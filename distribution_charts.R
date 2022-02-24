# packages
library(ggplot2)
library(plotly)
library(dplyr)

# load data
death_count_data <- read.csv("data/death_count_2020_2022.csv")
covid_data <- read.csv("data/covid19_2020_2022.csv")

# VISUALIZATION 1
death_dist_data <- death_count_data %>%
  filter(Jurisdiction.of.Occurrence=="United States")

death_dist_plot <- ggplot(death_dist_data) +
  geom_boxplot(aes(Natural.Cause, color = Jurisdiction.of.Occurrence),
               na.rm=T, show.legend = FALSE) +
  xlab("Weekly Natural Death Counts (National)") +
  ggtitle('Weekly Natural Death Count Distribution') +
  scale_color_manual(values = c("#0099f8")) +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank())

# VISUALIZATION 2
gender_dist_data <- covid_data %>%
  filter(Age.Group == "All Ages", Sex != "All Sexes")

gender_dist_stat <- gender_dist_data %>%
  mutate(log_death = ifelse(is.infinite(log(COVID.19.Deaths)), NA, log(COVID.19.Deaths))) %>%
  group_by(Sex) %>%
  summarize(avg_log_death = mean(log_death, na.rm = TRUE),
            median_log_death = median(log_death, na.rm = TRUE),
            min_log_death = min(log_death, na.rm = TRUE),
            max_log_death = max(log_death, na.rm = TRUE))

gender_dist_plot <- ggplot(gender_dist_data) +
  stat_density(aes(x=log(COVID.19.Deaths), colour=Sex),
               geom="line",position="identity", na.rm = T) +
  xlim(0,log(50000))+
  xlab("Log of COVID Death Counts") +
  ylab('Density') +
  ggtitle('Density of Log Covid Death Counts Across Gender') +
  theme(plot.title = element_text(hjust = 0.5))

gender_dist_plot <- ggplotly(gender_dist_plot)