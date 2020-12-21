# Song Lyric Graph

A Shiny app that creates a directed graph to visualize song lyric co-occurrences. Song cover art and lyrics are obtained from [Genius](https://genius.com).

## Running the app

```
https://adamoshen.shinyapps.io/song-lyric-graph/
```

## Running the app locally

### Minimum requirements

```
package     * version date       lib source        
dplyr       * 1.0.2   2020-08-18 [1] CRAN (R 3.6.3)
DT            0.16    2020-10-13 [1] CRAN (R 3.6.3)
genius      * 2.2.0   2019-05-05 [1] CRAN (R 3.6.2)
ggplot2     * 3.3.2   2020-06-19 [1] CRAN (R 3.6.3)
ggraph      * 2.0.2   2020-03-17 [1] CRAN (R 3.6.3)
igraph      * 1.2.5   2020-03-19 [1] CRAN (R 3.6.3)
magick      * 2.3     2020-01-24 [1] CRAN (R 3.6.2)
rvest       * 0.3.5   2019-11-08 [1] CRAN (R 3.6.3)
shiny       * 1.4.0.2 2020-03-13 [1] CRAN (R 3.6.3)
shinythemes   1.1.2   2018-11-06 [1] CRAN (R 3.6.2)
stringr       1.4.0   2019-02-10 [1] CRAN (R 3.6.1)
tibble        3.0.0   2020-03-30 [1] CRAN (R 3.6.3)
tidyr         1.0.2   2020-01-24 [1] CRAN (R 3.6.3)
```

```r
shiny::runGitHub(repo="song-lyric-graph", username="adamoshen")
```

## Demo

![Data tab](./images/preview1.png)

![Plot tab](./images/preview2.png)
