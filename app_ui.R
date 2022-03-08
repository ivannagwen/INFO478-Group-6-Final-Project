# UI
source('./scripts/ui/introduction.R')

# tabs + widgets



# UI PAGES
ui <- fluidPage(theme = 'style.css',
  h1(
    strong("The Relationship Between COVID-19 and Other Causes of Deaths"),
    style = "color: Green"),
  h2("Alan Zheng, Ivanna Maxwell, Kyle Sorstokke"),
  tabsetPanel(
    intro_tab
  )
)
