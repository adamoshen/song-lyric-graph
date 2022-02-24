# https://github.com/ewenme/geniusr/issues/17#issuecomment-989302741
get_lyrics <- function(session) {
  lyrics <- session %>%
    rvest::html_nodes(xpath = '//div[contains(@class, "Lyrics__Container")]')

  song <- session %>%
    rvest::html_nodes(xpath = '//span[contains(@class, "SongHeaderVariantdesktop__")]') %>%
    rvest::html_text(trim = TRUE)

  artist <- session %>%
    rvest::html_nodes(xpath = '//a[contains(@class, "SongHeaderVariantdesktop__Artist")]') %>%
    rvest::html_text(trim = TRUE)

  xml2::xml_find_all(lyrics, ".//br") %>%
    xml2::xml_add_sibling("p", "\n")

  xml2::xml_find_all(lyrics, ".//br") %>%
    xml2::xml_remove()

  lyrics <- rvest::html_text(lyrics, trim = TRUE)
  lyrics <- unlist(strsplit(lyrics, split = "\n"))
  lyrics <- grep(pattern = "[[:alnum:]]", lyrics, value = TRUE)

  if (is_empty(lyrics)) {
    return(
      tibble::tibble(
        line = NA,
        section_name = NA,
        section_artist = NA,
        song_name = song,
        artist_name = artist
      )
    )
  }

  section_tags <- nchar(gsub(pattern = "\\[.*\\]", "", lyrics)) == 0
  sections <- geniusr:::repeat_before(lyrics, section_tags)
  sections <- gsub("\\[|\\]", "", sections)
  sections <- strsplit(sections, split = ": ", fixed = TRUE)
  section_name <- sapply(sections, "[", 1)
  section_artist <- sapply(sections, "[", 2)
  section_artist[is.na(section_artist)] <- artist

  tibble(
    line = lyrics[!section_tags],
    section_name = section_name[!section_tags],
    section_artist = section_artist[!section_tags],
    song_name = song,
    artist_name = artist
  )
}

assignInNamespace("get_lyrics", get_lyrics, "geniusr")
