shinyServer(function(input, output) {

  ### Sidebar content
  observeEvent(input$submit, {
    checkpoint1$out <- tryCatch(expr=gen_song_url(input$artistname, input$songname) %>% read_html(),
                                error=function(w){"fail"})
    if (!is.character(checkpoint1$out)){
      user$artistname <- input$artistname
      user$songname <- input$songname
    }
  })
  
  output$cover_art <- renderImage({
    if (!is.character(checkpoint1$out)){
      img <- gen_song_url(artist=user$artistname, song=user$songname) %>%
        read_html() %>%
        html_nodes(css="img") %>%
        purrr::pluck(1) %>%
        html_attr("src") %>%
        image_read(density=500, depth=16, strip=TRUE) %>%
        image_resize("x235") %>%
        image_write(tempfile(fileext="png"), format="png")

      return(list(src=img,
                  contentType="image/png",
                  alt="Album Cover Art"))
    } else {
      return(list(src="./images/fail.png",
                  contentType="image/png",
                  alt="Song not found"))
    }
  }, deleteFile=FALSE)
  ###
  
  
  ### Tab 1 content
  output$lyric_table <- DT::renderDataTable({
    lyrics <- get_lyric_data()
    DT::datatable(lyrics, style="bootstrap", options=list(dom="t"))
  })
  ###
  
  
  ### Tab 2 content
  output$graph <- renderPlot({
    create_graph()
  }, width=700, height=750, type="cairo")
  ###
})
