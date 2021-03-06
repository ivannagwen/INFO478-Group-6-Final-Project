# The Relationship Between COVID-19 and Other Causes of Deaths

### Alan Zheng, Ivanna Maxwell, Kyle Sorstokke

_This project was created for the purpose of INFO478 final project. It explores trends of deaths count, grouped by various factors including state and causes, and its relationship with the deaths count for Coronavirus disease (COVID-19)._

## Project Description

#### **Why are we interested in this field/domain?**

Learning more about the causes and pattern behind each death count is something that _all individuals can benefit from._ Additionally, with the breakout of Coronavirus disease in the past 2 years, we are also interested to integrate the characteristics and death count for COVID-19 disease in our project. This combined information can then be analyzed and used to help identify the relationship and characteristics of deaths due to COVID-19 disease, who is at a higher risk of deaths, to also determine where to focus on certain resources in order to minimize the risk of deaths or exposure to COVID-19 disease.

#### **What other examples of data driven projects related to this domain?**

1. [The Pandemic's True Death Toll Article](https://www.nature.com/articles/d41586-022-00104-8)

    This article summarizes research, along with data visualizations, about the often overlooked excess mortality connected to COVID-19. This concept measures the death toll by comparing actual to expected deaths, rather than simply counting the deaths with COVID-19 as a listed cause. While this method can be complicated and imperfect, it better encapsulates the overall impact of the pandemic on mortality.

2. [Effect of COVID-19 in Life Expectancy Paper](https://www.bmj.com/content/373/bmj.n1343)

    This study looks at high-income countries and their life expectancies over the past decade. It analyzes trends in life expectancy over the pre-covid period since 2010, as well as during the pandemic. Including an analysis of US patterns by race and ethnicity, the study compares the United States to peer nations in an effort to better understand success of pandemic response. Similar to the first project we listed, this research focuses more on the entire impact of the pandemic, rather than just the exact number of deaths.

3. [Harvard's Air Pollution and COVID-19 Mortality in the United States paper](https://projects.iq.harvard.edu/covid-pm/home)
  
    This project looks at the potential relationship between air quality and severity of COVID-19. The overall goal is to better understand and respond to the pandemic and similar scenarios by creating a clearer picture of comorbidity factors. The study found a positive correlation between air pollutant exposure and severity of covid, which is important information in the fight against pandemic mortality overall.

#### **What data-driven questions do we hope to answer about this domain and how?**

1. Where does COVID-19 rank related to other long-term causes grouped by specific factors such as location, age group, gender?

   - For this question, grouping the data set according to specific factors like gender, age groups, and location would be the first step. Then, we would wrangle the data and assign ranks to different causes depending on the total death counts. Finally, plotting the result will give ideas on how these different causes relate to the overall trend of death counts

2. Is there any correlations present between COVID-19 deaths rate and deaths caused by respiratory illnesses? How is the trend across different groups?

   - For this question, we will start by aggregating deaths for each cause, with analyses grouped by region, time, and a combination of the two. This will present a picture of how the causes compare geographically and chronologically, which we can use in basic regression models to determine any potential correlations between different causes.

3. How is the trend of COVID-19 deaths related to deaths caused by other groups over time?
   - For the third question, we are aiming to see how different causes contribute to death count over time from the year 2020 to the present. Similarly to the first question, grouping the data set based on causes and certain periods (daily, monthly, or quarterly) will be the first step. Then, we can further explore the data and decide on certain features that we want to visualize over time. This can include but is not limited to total death counts and average death counts. Finally, we can plot a time series chart to visualize the trend over time.

## Finding Data

#### **Data sources**

1. [Weekly Provisional Counts of Deaths by State and Causes 2020 - 2022](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6)

   The dataset introduced data about weekly provisional counts of deaths by the state of occurrence and selected underlying causes of death for 2020 to 2022. The dataset is provided by National Center for Health Statistics and accessed from [data.cdc.gov](data.cdc.gov) website. It needs to note that this report do not represent all deaths that occurred between 2020 and 2022.

2. [Provisional COVID-19 Deaths by Sex and Age 2020 - 2022](https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku)

   The dataset provided information related to deaths that are involving coronavirus disease (2019), pneumonia, and influenza by sex, age group, and jurisdiction of occurrence. It is provided by National Center for health Statistics and is accessiable on the [data.cdc.gov](data.cdc.gov) website. It needs to note that the age group variable within this dataset range from 0 to 64.

#### **Number of observations (rows) and features (columns) in our data**

1. The [Weekly Provisional Counts of Deaths by State and Causes 2020 - 2022](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6) data set contains **5832 observations and 35 features**

2. The [Provisional COVID-19 Deaths by Sex and Age 2020 - 2022](https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku) data set contains **79900 observations and 16 features**

## Technical Description

**Format of Final Product**

For this project, we are planning to have a Shiny app for the final product. We believe that the Shiny app will be the most interactive format for the final output since it can combine interactive plots, rendered texts, widgets, and customized styles. With our large data sets, we can definitely make use of these features to give better visualization and analysis to the audience.

**Data Collection / Management Challenges**

With our large data sets, there will definitely be some challenges posted. One of them includes cleaning the data set and reshaping it to a suitable form for the purpose of analysis and visualizations. Another issue that might arise is a large number of features. While this might be beneficial in terms of data exploration, a large number of features might result in higher complexity within data. Thus, before performing data analysis/visualizations, one of our goals is to wrangle the raw Data first.

**Necessary Technical Skills**

Since we are creating a Shiny app for the final product, we need a variety of skills. This ranges from basic data wrangling skills, including the ability to use some packages like `dplyr`, to skills on data visualization packages like `ggplot` and `plotly`. We also need to learn how to create a Shiny app which involves understanding what goes to the server and UI side. Most of us may have been exposed to these skills from earlier courses, but there are definitely some rooms to continue exploring and learning from these packages.

**Major Challenges**

In regard to the overall structure of our team, our members have pretty hectic schedule since most of us are working part-time. However, we are arranging our schedule and will decide on a weekly 1-2 hours meeting over Discord in order to keep updated with our progress and individual task. Additionally, another challenge is if our proposed questions for this project are too broad. As a result, we plan to get feedback from TA as well as Prof. Burkart in order to reflect and update our project proposal before we start performing the analysis.
