# Song Lyric Graph

A Shiny app that creates a directed graph to visualize song lyric co-occurrences. Song cover art and lyrics are obtained from [Genius](https://genius.com).

## Running the app

Genius-related apps don't appear to work anymore when hosted on shinyapps.io...
It is probably best to just run it locally.

```
https://adamoshen.shinyapps.io/song-lyric-graph/
```

## Running the app locally

### Minimum requirements

```
package     * version date       lib source        
dplyr       * 1.0.5   2021-03-05 [1] CRAN (R 4.0.4)
DT            0.17    2021-01-06 [1] CRAN (R 4.0.4)
genius      * 2.2.2   2020-05-28 [1] CRAN (R 4.0.3)
geniusr     * 1.2.0   2020-04-13 [1] CRAN (R 4.0.5)
ggplot2     * 3.3.3   2020-12-30 [1] CRAN (R 4.0.4)
ggraph      * 2.0.5   2021-02-23 [1] CRAN (R 4.0.4)
igraph      * 1.2.6   2020-10-06 [1] CRAN (R 4.0.4)
magick      * 2.7.2   2021-05-02 [1] CRAN (R 4.0.5)
rvest       * 1.0.0   2021-03-09 [1] CRAN (R 4.0.4)
shiny       * 1.6.0   2021-01-25 [1] CRAN (R 4.0.5)
shinythemes   1.2.0   2021-01-25 [1] CRAN (R 4.0.5)
tidyr         1.1.3   2021-03-03 [1] CRAN (R 4.0.4)
```

```r
shiny::runGitHub(repo="song-lyric-graph", username="adamoshen")
```

## Demo

![Data tab](./images/preview1.png)

![Plot tab](./images/preview2.png)
