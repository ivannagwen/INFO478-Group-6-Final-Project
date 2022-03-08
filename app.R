# load packages
library(shiny)
library(maps)
library(plotly)
library(tidyr)
library(stringr)

# source UI and server
source('app_ui.R')
source('app_server.R')

shinyApp(ui = ui, server = server)