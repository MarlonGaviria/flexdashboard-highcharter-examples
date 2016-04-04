library("stringr")
library("dplyr")
library("htmltools")
library("purrr")

files <- dir(pattern = "index.html", recursive = TRUE, full.names = TRUE)

folders <- files %>% 
  str_extract( "/.*/") %>% 
  str_replace_all("/", "") %>% 
  str_replace_all("-", " ") 


links <- data_frame(files, folders) %>% 
  by_row(function(x){
    as.character(tags$a(x$folders, href = x$files, target = "_blank"))
  }, .to = "link") %>% 
  .$link %>% 
  unlist()

writeLines(links, "scripts/index.md")
rmarkdown::render("scripts/index.md", output_file = "../index.html",
                  output_options = list(
                    theme = "flatly",
                    title = "Some Ideas Highcharter + Flexdashboard"))

  