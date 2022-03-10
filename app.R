# load packages
library(shiny)
library(maps)
library(plotly)
library(tidyr)
library(dplyr)
library(stringr)
library(lubridate)
library(dygraphs)
library(tidyverse)
library(xts)

# source UI and server
source('app_ui.R')
source('app_server.R')

shinyApp(ui = ui, server = server)
  