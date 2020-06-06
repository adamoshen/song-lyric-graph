# Song Lyric Co-occurrence

A Shiny app for visualizing song lyric co-occurrences. Song cover art and lyrics are obtained from [Genius](https://genius.com).

## Required packages

From the `global.R` file:

```
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
```

Other required packages that were used but not loaded: `purrr`, `DT`.

## Running the app

```
shiny::runGitHub(repo="Song-Lyric-Co-occurrence", username="adamshen1")
```

## Demo

![Data tab](./images/preview1.png)

![Plot tab](./images/preview2.png)
