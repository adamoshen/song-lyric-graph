library(geniusr)
library(rvest)
library(xml2)
library(tidyverse)
library(igraph)
library(ggraph)
source("./get_lyrics.R")

get_lyric_data <- function(artistname, songname) {
  lyric_data <- tibble(NULL)

  while (nrow(lyric_data) == 0) {
    lyric_data <- get_lyrics_search(artistname, songname)
    Sys.sleep(4)
  }

  lyric_data %>%
    select(line) %>%
    drop_na() %>%
    rename(LyricA = line) %>%
    mutate(LyricB = lead(LyricA)) %>%
    drop_na() %>%
    count(LyricA, LyricB, sort=TRUE) %>%
    filter(n > 1) %>%
    graph_from_data_frame()
}

create_graph <- function(lyric_data, artistname, songname) {
  a <- grid::arrow(type="closed", length=unit(3, "mm"))

  set.seed(101)

  ggraph(lyric_data, layout="nicely") +
    geom_edge_fan(
      aes(colour=factor(n)),
      arrow=a,
      start_cap=circle(5, "mm"),
      end_cap=circle(3, "mm")
    ) +
    geom_edge_loop(
      aes(colour=factor(n), span=-30),
      arrow=a,
      position=position_nudge(x=0.1),
      start_cap=circle(5, "mm"),
      end_cap=circle(2, "mm")
    ) +
    geom_node_text(aes(label=str_wrap(name, width=40)), hjust="inward", repel=TRUE) +
    theme_void() +
    scale_edge_colour_discrete(name="Co-occurrences", breaks=unique(edge_attr(lyric_data)$n)) +
    theme(legend.position="bottom", plot.title=element_text(face="bold")) +
    labs(title=paste(songname, "by", artistname))
}

song <- get_lyric_data("Dua Lipa", "Levitating")
create_graph(song, "Dua Lipa", "Levitating")
