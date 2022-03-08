server <- function(input, output) {
  ## RAW DATA ##
  covid_df <- read.csv('data/covid19_2020_2022.csv')
  death_df <- read.csv('data/death_count_2020_2022.csv')
  
  ## RANK COMPARISON OUTPUT ##
  output$rank_comparison <- renderPlotly({
    # wrangle data
    rank_df <- covid_df %>%
      pivot_longer(cols = c('COVID.19.Deaths', 'Total.Deaths', 'Pneumonia.Deaths',
                            'Pneumonia.and.COVID.19.Deaths', 'Influenza.Deaths'),
                   names_to = 'death_cause') %>%
      mutate(death_cause = str_replace_all(death_cause, '\\.', ' ')) %>%
      filter(State != 'United States') %>%
      select(Year, State, death_cause, value)
    
    # filter data based on widget
    rank_filtered <- rank_df %>%
      filter(Year == input$year_val) %>%
      filter(death_cause == input$death_cause_val) %>%
      group_by(Year, State, death_cause) %>%
      summarize(sum_deaths = sum(value, na.rm = TRUE))

    # get state maps data
    state_df <- map_data('state') %>%
      mutate('State' =  str_to_title(region))
    
    # join df
    state_rank_df <- state_df %>%
      left_join(rank_filtered)
    
    # plot
    rank_plot <- ggplot(state_rank_df) +
      geom_polygon(mapping = aes(x = long, y = lat,
                                 group = group, fill = log(sum_deaths),
                                 text = paste0('State: ', State, '<br>',
                                               'Year: ', Year, '<br>',
                                               'Cause of Deaths: ', death_cause, '<br>',
                                               'Total Count: ', sum_deaths))) +
      scale_fill_gradient(name = "Log of Total Deaths Count by Specific Cause",
                          low = "yellow",
                          high = "red",
                          na.value = "grey50")
    
    # plot title
    if(length(input$year_val) == 2) {
      sep = ' and '
    } else if(length(input$year_val) == 3) {
      sep = ', '
    } else {
      sep = ''
    }
    
    rank_plot <- rank_plot +
      ggtitle(paste('Log of Specific Cause Total Death Count by State in',
                    paste(input$year_val, collapse = sep)))

    rank_plot <- ggplotly(rank_plot, tooltip = 'text')

    return(rank_plot)
  })
}