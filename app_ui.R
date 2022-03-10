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
    tags$li("How does the total death count due to COVID-19 differ from other long term causes across state in different time period?"),
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
  titlePanel("How does the total death count due to COVID-19 differ from other long term causes across state in different time period?"),
  p(paste("The purpose of this chart is to compare the total death count caused by COVID-19 and other long term causes across different states.",
          "Here, we use the following variables from the given data sets in order to aggregate and plot the map below:")),
  br(),
  tags$ol(
    tags$li(paste('Year:', 'Range of year to plot, from 2020 - 2022')),
    tags$li(paste('Cause of Deaths:', 'COVID-19, Influenza, Pneumonia, Both COVID-19 and Pneumonia, and all causes')),
    tags$li(paste('State:', 'States name in United States'))
  ),
  br(),
  p(paste('On a side note, some states may have missing data for certain year period, which is depicted by the grey colored map area.',
          'We also use the log of death counts for scaling the colors of our map in order to clearly visualize the discrepancy across each state.')),
  br(),
  sidebarLayout(
    sidebarPanel(year_widget,
                 death_cause_widget,
                 width = 4),
    mainPanel(plotlyOutput('rank_comparison'))
  )
)


#############################
###### Correlation Tab ######
#############################

age_group_choice <- na.omit(unique(corr_df$Age.Group))
age_group_val <- checkboxGroupInput(
  inputId =  'age_group_val',
  label = 'Select Age Group',
  choices = age_group_choice,
  selected = "50-64 years"
)

sex_choice <- na.omit(unique(corr_df$Sex))
sex_choice_val <- checkboxGroupInput(
  inputId =  'sex_choice_val',
  label = 'Select Sex',
  choices = sex_choice,
  selected = "Male"
)

illness_choice <- c('Pneumonia', 'Influenza')
illness_val <- checkboxGroupInput(
  inputId =  'illness_val',
  label = 'Select Respiratory Illness',
  choices = illness_choice,
  selected = c("Pneumonia", "Influenza")
)


corr_tab <- tabPanel(
  "Correlation of deaths from COVID-19 and other respiratory illnesses",
  titlePanel("Is there any correlation present between COVID-19 deaths rate and deaths caused by respiratory illnesses? How is the trend across different groups?"),
  p(paste("This interactive visualization compares monthly state total death counts for COVID",
          "against those of other respiratory illnesses for select age groups and sexes.")),
  br(),
  tags$ol(
    tags$li(paste('Age Group:', 'Age group for which to view death counts')),
    tags$li(paste('Sex:', 'Set the sex for which to view data')),
    tags$li(paste('Illness:', 'Pick the illness to compare against COVID'))
  ),
  br(),
  sidebarLayout(
    sidebarPanel(age_group_val,
                 sex_choice_val,
                 illness_val,
                 width = 4),
    mainPanel(plotlyOutput('correlationPlot'))
  )
)

#####################
### EVOLUTION TAB ###
#####################
age_group_choice <- na.omit(unique(covid_df$Age.Group))
state_choice <- na.omit(unique(covid_df$State))

evolution_tab <- tabPanel(
  "Trend of COVID-19 deaths vs Other Respiratory Diseases' deaths",
  titlePanel("How is the trend of COVID-19 deaths related to deaths caused by other groups over time?"),
  p(paste("The purpose of these charts is to compare the trend of death counts caused by COVID-19 and other causes, categorized by age groups, over time.",
          "Here, we use the following variables from the given data sets in order to aggregate and plot the visualizations below:")),
  br(),
  tags$ol(
    tags$li(paste('Year:', 'Range of year to plot, from 2020 - 2022')),
    tags$li(paste('Cause of Deaths:', 'COVID-19, Influenza, and Pneumonia')),
    tags$li(paste('State:', 'States name in United States')),
    tags$li(paste('Age Group:', 'Range of age in different groups (5 to 10 increments)'))
  ),
  fluidRow(
    column(selectInput("ageSelect", label = h4("Age Group"), 
                          choices = age_group_choice, 
                          selected = 1), width = 4),
    column(selectInput("stateSelect", label = h4("State"),
                          choices = state_choice,
                          selected = 1), width = 4),
    column(selectInput("timeSelect", label = h4("Time"),
                          choices = c("By Month", "By Year"),
                          selected = 1), width = 4)
  ),
  dygraphOutput("evolutionPlot"),
  hr(),
  p(paste('In addition, we also look into the evolution of death counts from COVID-19 patients with Pneumonia:')),
  dygraphOutput("covid_pneu_plot"),
  tags$footer("___")
)

######################
### CONCLUSION TAB ###
######################
conclusion <- tabPanel('Conclusion',
  titlePanel('Takeaways'),
  br(),
  tags$h4(class = 'tableheader',
          strong("Deaths Count by Different Causes Data Distribution")),
  fluidRow(column = 12, align = 'center', tableOutput("summary_table")),
  p(paste('Before we explore and discuss the takeaways from each question shown in the introduction page,',
          'it is worth for us to take a look into the statistical distribution of death counts across different ccauses.',
          'The table shown above summarizes the distribution, sorted by the average death count in descending order.',
          'As we can see, across the different death causes we investigated, COVID-19 holds the highest average death count across',
          'the year range 2020 - 2022. However, note that the maximum death count corresponds to Pneumonia. Additionally, we can also',
          'see that the maximum death count from COVID-19 patients with Pneumonia is more than half of the death counts caused solely by',
          'Pneumonia or COVID-19. This is an interesting observation since we can note that most of the deaths are associated with',
          'severe lungs illness.')),
  br(),
  # answers to each question
  # question 1
  tags$h4(class = 'tableheader',
          strong('How does the total death count due to COVID-19 differ from other long term causes across state in different time period?')),
  p(paste('Based on our observation, it is worth to note that the differences between the log of the death count due to different causes',
          'across different year range are similar to one another.',
          'This means that the differences of the death count distribution across different causes are consistent throughout the period,',
          'meaning our insights are applicable for a good range of years throughout this pandemic period across different states.',
          'It is clearly visible that the top 3 states with the highest death count are California, Texas, and Florida.',
          'As a result, with this observation, we can direct our focus onto these 3 states in order to help prevent the spread of COVID-19 diseases',
          'as well as the exposures of certain age groups to certain severe diseases like Influenza and pneumonia.',
          'Additionally, it is important to note that this insight relies heavily onto the data quality.',
          'Some causes and states data may be more complete compared to one another. In response to this,',
          'our group has performed data checks and clean data as needed to remove outliers and NA values in order to visualize the information as appropriate.')),
  tags$h4(class = 'tableheader', strong('Is there any correlation present between COVID-19 deaths rate and deaths caused by respiratory illnesses? How is the trend across different groups?')),
  p(paste('There does not appear to be much correlation between deaths due to COVID-19 and',
          'deaths due to influenza. Influenza deaths are fairly constant, with the expected',
          'variation due to state population differences, even as COVID cases rise.',
          'There appears to be some correlation between deaths due to COVID-19 and pneumonia,',
          'although some of this trend can likely be explained by population as well.',
          'Even after removing overlapping cases of death caused by both COVID and pneumonia,',
          'the plot shows somewhat similar values for each in most observations.',
          'These observed trends hold fairly constant across groups. There is some',
          'variation, although it can likely be explained in part by the natural fluctuations',
          'in illness transmission cycles rather than a true difference in illness',
          'trends by age or sex.'))
)


# UI PAGES
ui <- fluidPage(theme = 'style.css',
  h2(
    strong("The Relationship Between COVID-19 and Other Causes of Deaths"),
    style = "color: Green"),
  h3("Alan Zheng, Ivanna Maxwell, Kyle Sorstokke"),
  tabsetPanel(
    intro_tab,
    rank_tab,
    corr_tab,
    evolution_tab,
    conclusion
  )
)
