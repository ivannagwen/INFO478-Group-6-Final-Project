# Chart 1 
# Where does COVID-19 rank related to other long-term causes grouped by specific factors such as location, age group, gender?

covid_df <- read.csv('../../data/covid19_2020_2022.csv')
death_df <- read.csv('../../data/death_count_2020_2022.csv')

# wrangle data
rank_df <- covid_df %>%
  pivot_longer(cols = c('COVID.19.Deaths', 'Total.Deaths', 'Pneumonia.Deaths',
                        'Pneumonia.and.COVID.19.Deaths', 'Influenza.Deaths'),
               names_to = 'death_cause') %>%
  mutate(death_cause = str_replace_all(death_cause, '\\.', ' ')) %>%
  select(Year, State, Sex, Age.Group, death_cause, value)

# widget 1 - filter by year
year_choices <- na.omit(unique(covid_df$Year))
year_widget <- selectInput(
  inputId =  'year_val',
  label = 'Select Year',
  choices = year_choices,
  multiple = TRUE,
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

rank_tab <- tabPanel(
  "COVID-19 vs. Other Long Term Death Causes Rank",
  sidebarLayout()
)