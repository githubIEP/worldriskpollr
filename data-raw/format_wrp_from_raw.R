library(tidyverse)
library(here)
library(labelled)
library(sjlabelled)

# get raw data -----------------------------------------------------------------
url = "https://wrp.lrfoundation.org.uk/lrf_wrp_2021_full_data.zip"
download.file(url, "./data-raw/wrp.zip", mode = "wb")
