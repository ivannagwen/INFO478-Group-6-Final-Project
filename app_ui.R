### UI ###

################
### RAW DATA ###
################
covid_df <- read.csv('data/covid19_2020_2022.csv')
death_df <- read.csv('data/death_count_2020_2022.csv')


########################
### INTRODUCTION TAB ###
########################
intro_tab <- tabPanel(
  tags$span(class = "header", "Overview"),
  tags$img(class = "image",
           src = "https://health.clevelandclinic.org/wp-content/uploads/sites/3/2020/03/caronavirusLungs-125957837-770x533-1.jpg",
           alt = "covid and other death causes",
           width = 500,
           height = 325,
           style = 'align::middle'),
  br(),
  p(paste("In this project, our team aims to explore the relationship between COVID-19 and other causes of deaths within the past 2 years.",
          "By combining different data sets and analyzing them, we can analyze different characteristics of deaths due to COVID-19 disease,",
          "identify who is at higher risk of deaths, and focus on certain resources that minimize the risk of deaths or exposure to COVID-19 disease.",
          "To be specific, here are the 3 questions we hope to answer throughout the project:")),
  br(),
  tags$ol(
    tags$li("How does the total death count due to COVID-19 differ from other long term causes across State in different time period?"),
    tags$li("Is there any correlations present between COVID-19 deaths rate and deaths caused by respiratory illnesses? How is the trend across different groups?"),
    tags$li("How is the trend of COVID-19 deaths related to deaths caused by other groups over time?")
  ),
  br(),
  p("The data sources we are using throughout this project are:"),
  tags$ol(
    tags$li(
      tags$html(
        a(href = 'https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6',
          "Weekly Provisional Counts of Deaths by State and Causes 2020 - 2022")
      ),
      br(),
      tags$body(paste("The dataset introduced data about weekly provisional counts of deaths",
                      "by the state of occurrence and selected underlying causes of death for 2020 to 2022.",
                      "The dataset is provided by National Center for Health Statistics and accessed from"),
                tags$html(a(href="data.cdc.gov", 'data.cdc.gov')),
                paste("website. It needs to note that this report do not represent all deaths that occurred between",
                      "2020 and 2022.")
      )),
    br(),
    tags$li(
      tags$html(
        a(href = 'https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku',
          "Provisional COVID-19 Deaths by Sex and Age 2020 - 2022")
      ),
      br(),
      tags$body(paste("The dataset provided information related to deaths that are involving coronavirus disease (2019),",
                      "pneumonia, and influenza by sex, age group, and jurisdiction of occurrence. It is provided by National",
                      "Center for health Statistics and is accessiable on the"),
                tags$html(a(href="data.cdc.gov", 'data.cdc.gov')),
                paste("website. It needs to note that the age group variable within this dataset range from 0 to 64.")
      )
    )
  ),
  br(),
  p(paste('In order for us to answer the 3 questions with the data sets linked above, we explore different kind of relationships',
          'across the columns in the datasets. The table below shows the related columns.')),
  tags$div(
    tags$h4(class = "tableheader", "Table indicating related columns:"),
    tags$table(class = "columns",
               tags$tr(
                 tags$th("Total Death Count due to COVID-19 and Long Term Causes by State in Different Years"),
                 tags$th("Relationship between Deaths Caused by COVID-19 and Other Respiratory Illnesses"),
                 tags$th("Trends of Deaths Caused by COVID-19 and Other Causes")
               ),
               tags$tr(
                 tags$td("State"),
                 tags$td("COVID-19 Deaths"),
                 tags$td("Start Date / End Date")
               ),
               tags$tr(
                 tags$td("Year"),
                 tags$td("Pneumonia Deaths"),
                 tags$td("COVID-19 and Pneumonia Deaths (Sum of deaths)")
               ),
               tags$tr(
                 tags$td("Deaths Count by Different Causes"),
                 tags$td("Influenza Deaths"),
                 tags$td("Influenza Deaths")
               )
    )
  ),
  tags$footer("___")
)


###########################
### RANK COMPARISON TAB ###
###########################
# wrangle data
rank_df <- covid_df %>%
  pivot_longer(cols = c('COVID.19.Deaths', 'Total.Deaths', 'Pneumonia.Deaths',
                        'Pneumonia.and.COVID.19.Deaths', 'Influenza.Deaths'),
               names_to = 'death_cause') %>%
  mutate(death_cause = str_replace_all(death_cause, '\\.', ' ')) %>%
  filter(State != 'United States') %>%
  select(Year, State, Sex, Age.Group, death_cause, value)

# widget 1 - filter by year
year_choices <- na.omit(unique(covid_df$Year))
year_widget <- checkboxGroupInput(
  inputId =  'year_val',
  label = 'Select Year',
  choices = year_choices,
  selected = year_choices
)

# widget 2 - select death cause
death_cause_choices <- unique(rank_df$death_cause)
death_cause_widget <- radioButtons(
  inputId = 'death_cause_val',
  label = 'Select Death Cause to Visualize',
  choices = death_cause_choices,
  selected = 'Total Deaths'
)


# Rank tab
rank_tab <- tabPanel(
  "COVID-19 vs. Other Long Term Death Causes Rank by State",
  titlePanel("How do relationships affect the alcohol consumption
             of students?"),
  sidebarLayout(
    sidebarPanel(year_widget,
                 death_cause_widget,
                 width = 4),
    mainPanel(plotlyOutput('rank_comparison'))
  )
)

# Evolution Tab
age_group_choice <- na.omit(unique(covid_df$Age.Group))
state_choice <- na.omit(unique(covid_df$State))

evolution_tab <- tabPanel(
  "Trend of COVID-19 deaths vs Other Diseases' deaths",
  fluidRow(
    selectInput("ageSelect", label = h3("Age Group"), 
                choices = age_group_choice, 
                selected = 1),
    selectInput("stateSelect", label = h3("State"),
                choices = state_choice,
                selected = 1),
    selectInput("timeSelect", label = h3("Time"),
                choices = c("By Month", "By Year"),
                selected = 1)
  ),
  dygraphOutput("evolutionPlot")
)





# UI PAGES
ui <- fluidPage(theme = 'style.css',
  h1(
    strong("The Relationship Between COVID-19 and Other Causes of Deaths"),
    style = "color: Green"),
  h2("Alan Zheng, Ivanna Maxwell, Kyle Sorstokke"),
  tabsetPanel(
    intro_tab,
    rank_tab,
    evolution_tab
  )
)
