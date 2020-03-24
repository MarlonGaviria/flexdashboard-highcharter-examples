library(stringr)
library(dplyr)
library(htmltools)
library(purrr)

files <- dir(pattern = "index.html", recursive = TRUE, full.names = TRUE)
files <- setdiff(files, "./index.html")

folders <- files %>% 
  str_extract( "/.*/") %>% 
  str_replace_all("/", "") %>% 
  str_replace_all("-", " ") 


links <- data_frame(file = files, folder = folders) %>% 
  pmap_chr(function(file = "./booms/index.html", folder = "booms"){
    tags$a(folder, href = file, target = "_blank") %>% 
      tags$h5() %>% 
      as.character() 
  })
  
  
writeLines(links, "scripts/index.md")

rmarkdown::render("scripts/index.md",
                  output_file = "../index.html",
                  clean = TRUE,
                  params = list(
                    theme = "flatly",
                    title = "Some Ideas Highcharter + Flexdashboard")
                  )

  