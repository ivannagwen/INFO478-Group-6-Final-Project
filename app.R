# load packages
library(shiny)

# source UI and server
source('app_ui.R')
source('app_server.R')

shinyApp(ui = ui, server = server)