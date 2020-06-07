library(shiny)
library(shinythemes)
library(rvest)
library(genius)
library(dplyr)
library(tidyr)
library(magick)
library(ggplot2)
library(igraph)
library(ggraph)
library(stringr)


### Initialize reactive values
user <- reactiveValues(artistname="Vance Joy", songname="Riptide")
checkpoint1 <- reactiveValues(out=NA)
###


### Tab 1 content
get_lyric_data <- reactive({
  lyric_data <- tibble(NULL)
  
  while (nrow(lyric_data) == 0){
    lyric_data <- genius_lyrics(artist=user$artistname, song=user$songname, info="simple")
  }
  
  lyric_data %>%
    drop_na(everything()) %>%
    select(LyricA=lyric, everything()) %>%
    mutate(LyricB=lead(LyricA)) %>%
    drop_na(everything()) %>%
    count(LyricA, LyricB, sort=TRUE) %>%
    filter(n > 1)
})
###


### Tab 2 content
create_graph <- reactive({
  lyric_data <- get_lyric_data() %>%
    graph_from_data_frame()
  
  if (ecount(lyric_data) == 0){
    ggplot(NULL)+
      geom_text(aes(x=0, y=1, label="Graph is empty - no repeated lyric pairs!",
                    hjust="left", vjust="top"), colour="red", size=5)+
      geom_text(aes(x=1, y=0, label="null"), alpha=0)+
      theme_void()
  } else {
    a <- grid::arrow(type="closed", length=unit(3, "mm"))
    
    set.seed(20)
    
    ggraph(lyric_data, layout="fr")+
      geom_edge_fan(aes(colour=factor(n)), arrow=a,
                    start_cap=circle(5, "mm"), end_cap=circle(3, "mm"))+
      geom_edge_loop(aes(colour=factor(n), span=-30), arrow=a, position=position_nudge(x=0.1),
                     start_cap=circle(5, "mm"), end_cap=circle(2, "mm"))+
      geom_node_text(aes(label=str_wrap(name, width=40)), hjust="inward", repel=TRUE)+
      theme_void()+
      scale_edge_colour_discrete(name="Co-occurrences", breaks=unique(edge_attr(lyric_data)$n))+
      theme(legend.position="bottom", plot.title=element_text(face="bold"))+
      labs(title=paste(user$songname, "by", user$artistname))
  }
})
###