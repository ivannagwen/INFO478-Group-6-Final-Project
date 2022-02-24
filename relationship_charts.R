# necessary packages
library(tidyverse)
library(lubridate)
library(dygraphs)
library(xts)

# load data
death_count_data <- read.csv("data/death_count_2020_2022.csv")
covid_data <- read.csv("data/covid19_2020_2022.csv")

# VISUALIZATION 1
evo_data <- covid_data
evo_data$Start.Date <- mdy(evo_data$Start.Date)
evo_data <- evo_data %>%
  filter(Group == "By Month",
         State == "United States",
         Sex == "All Sexes",
         Age.Group == "All Ages")

prep_data <- xts(x = evo_data$COVID.19.Deaths, order.by = evo_data$Start.Date)

evolution_plot <- dygraph(prep_data, main = "Covid 19 Evolution", ylab = "Total Death") %>%
  dySeries("V1", label = "Death(All Sexes)") %>%
  dyOptions(labelsUTC = TRUE, fillGraph=TRUE, fillAlpha=0.1, drawGrid = FALSE, colors="#D8AE5A") %>%
  dyRangeSelector() %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.5, hideOnMouseOut = FALSE)  %>%
  dyUnzoom() %>%
  dyRoller(rollPeriod = 1)


# VISUALIZATION 2 - comparison plot
compare_data <- covid_data
compare_data$Start.Date <- mdy(compare_data$Start.Date)
compare_data <- compare_data %>%
  filter(Group == "By Month",
         State == "United States",
         Sex == "All Sexes",
         Age.Group == "All Ages") %>%
  select(Start.Date, COVID.19.Deaths, Pneumonia.Deaths, Influenza.Deaths)
rDeath <- xts(compare_data, order.by = compare_data$Start.Date)

comparison_plot <- dygraph(rDeath, main = "Respiratory Diseases Evolution",
                           ylab = "Total Death") %>%
  dyAxis("y", valueRange = c(0, 110000), independentTicks = TRUE, label = 'Total Death (COID-19 and Pneumonia)') %>%
  dyAxis("y2", valueRange = c(0, 5000), independentTicks = TRUE, label = 'Total Death (Influenza)') %>%
  dyOptions(stepPlot = TRUE, fillGraph = TRUE) %>%
  dyCrosshair(direction = "vertical") %>%
  dyHighlight(highlightCircleSize = 5, highlightSeriesBackgroundAlpha = 0.5, hideOnMouseOut = FALSE)  %>%
  dyUnzoom() %>%
  dyLegend(width = 600) %>%
  dySeries("Start.Date", label = 'Start Date') %>%
  dySeries('COVID.19.Deaths', label = 'COVID-19 Deaths') %>%
  dySeries('Pneumonia.Deaths', label = 'Pneumonia Deaths') %>%
  dySeries("Influenza.Deaths", axis=('y2'), label = 'Influenza Deaths') %>%
  dyRoller(rollPeriod = 1)

