shinyUI(fluidPage(
    theme=shinythemes::shinytheme("sandstone"),

    titlePanel("Song Lyric Graph"),

    sidebarLayout(
        sidebarPanel(textInput("artistname", label="Artist Name:", value="Vance Joy"),
                     textInput("songname", label="Song Name:", value="Riptide"),
                     actionButton("submit", "Submit"),
                     helpText("Fields are not case-sensitive."),
                     imageOutput("cover_art")
        ),

        mainPanel(
            tabsetPanel(
                tabPanel("Data", DT::dataTableOutput("lyric_table")),
                tabPanel("Plot", plotOutput("graph")),
                tabPanel("Help",
                         br(),
                         p("Song cover art and lyrics are obtained from", a(href="https://genius.com/", "Genius.")),
                         p("In the", strong("Data"), "tab you will find lyric co-occurrence data and the number of times
                         each pair occurred in the song. Lyric pairs that do not occur more than once are dropped. Therefore
                         if your song of choice has no repetition of lyric pairs then no data will be shown."),
                         p("In the", strong("Plot"), "tab you will find a directed graph of the lyric co-occurrence
                         data. Each lyric line (from the filtered data) becomes a vertex and directed edges are coloured
                         according to the number of times that a particular lyric pair sequence occurred. If your song of
                         choice has no repetition, a warning will be shown."),
                         p("If the requested song is not found (typo, information supplied is incorrect), the cover art will
                         be updated with a message to inform you that the song was not found. The", strong("Data"), "and",
                         strong("Plot"), "tabs will not be updated until a song has been successfully found."))
            )
        )
    )
))
