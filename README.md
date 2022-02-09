# COVID-19 and Other Causes Relationship in Deaths Count

### Alan Zheng, Ivanna Maxwell, Kyle Sorstokke

*This project was created for the purpose of INFO478 final project. It explores trends of deaths count, grouped by various factors including state and causes, and its relationship with the deaths count for Coronavirus disease (COVID-19).*


## Project Description

#### **Why are we interested in this field/domain?**

  Learning more about the causes and pattern behind each death count is something that *all individuals can benefit from.* Additionally, with the breakout of Coronavirus disease in the past 2 years, we are also interested to integrate the characteristics and death count for COVID-19 disease in our project. This combined information can then be analyzed and used to help identify the relationship and characteristics of deaths due to COVID-19 disease, who is at a higher risk of deaths, to also determine where to focus on certain resources in order to minimize the risk of deaths or exposure to COVID-19 disease.


#### **What other examples of data driven projects related to this domain?**

1. [The Pandemic's True Death Toll Article](https://www.nature.com/articles/d41586-022-00104-8)

  **description about the project**

2. [Effect of COVID-19 in Life Expectancy Paper](https://www.bmj.com/content/373/bmj.n1343)

  **description about the project**

3. [Harvard's Air Pollution and COVID-19 Mortality in the United States paper](https://projects.iq.harvard.edu/covid-pm/home)
    
  **description about the project**


#### **What data-driven questions do we hope to answer about this domain and how?** 
1. Where does COVID-19 rank related to other long term causes grouped by specific factors such as location, age group, gender?
      
    + For this question, grouping the data set according to specific factors like gender, age groups, and location would be the first step. Then, we would wrangle the data and assign ranks to different causes depending on the total death counts.  Finally, plotting the result will give ideas on how these different causes relate to the overall trend of death counts

2. Is there any correlations present between COVID-19 deaths rate and deaths caused by respiratory illnesses? How is the trend across different groups?
      
    + For this question, we will start by aggregating deaths for each cause, with analyses grouped by region, time, and a combination of the two. This will present a picture of how the causes compare geographically and chronologically, which we can use in basic regression models to determine any potential correlations between different causes.

3. How is the trend of COVID-19 deaths relate to deaths caused by other groups over time? 
      
    + For the third question, we are aiming to see how different causes contribute to death count over time from the year 2020 - present. Similarly to the first question, grouping the data set based on causes and certain period (daily, monthly, or quarterly) will be the first step. Then, we can further explore the data and decide on certain features that we want to visualize over time. This can include but not limited to total death counts and average death counts. Finally, we can plot a time series chart to visualize the trend over time.

## Finding Data

#### **Data sources**

1. [Weekly Provisional Counts of Deaths by State and Causes 2020 - 2022](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6)
  
    **Data set description**
  
2. [Provisional COVID-19 Deaths by Sex and Age 2020 - 2022](https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku)
  
    **Data set description**
  
#### **Number of observations (rows) and features (columns) in our data**

1. The [Weekly Provisional Counts of Deaths by State and Causes 2020 - 2022](https://data.cdc.gov/NCHS/Weekly-Provisional-Counts-of-Deaths-by-State-and-S/muzy-jte6) data set contains **5832 observations and 35 features**

2. The [Provisional COVID-19 Deaths by Sex and Age 2020 - 2022](https://data.cdc.gov/NCHS/Provisional-COVID-19-Deaths-by-Sex-and-Age/9bhg-hcku) data set contains **79900 observations and 16 features**


## Technical Description

**Format of Final Product**

For this project, we are planning to have a Shiny app for the final product. We believe that Shiny app will be the most interactive format for the final output since it can combine interactive plots, rendered texts, widgets, and customized styles. With our large data sets, we can definitely make use of these features to give better visualization and analysis to the audience.

**Data Collection / Management Challenges**

With our large data sets, there will definitely be some challenges posted. One of them includes cleaning the data set and reshaping it to a suitable form for the purpose of analysis and visualizations. Another issue that might arise is the large number of features. While this might be beneficial in terms of data exploration, large number of features might result in higher complexity within data. Thus, one of our goals before performing data analysis / visualizations is to wrangle the raw data first.

**Necessary Technical Skills**

Since we are creating a Shiny app for the final product, we need a variety of skills. This ranges from basic data wrangling skills, including the ability to use some packages like `dplyr`, to skills on data visualization packages like `ggplot` and `plotly`. We also need to learn on how to create a Shiny app which involves understanding what goes to the server and ui side. Most of us may have been exposed to these skills from earlier courses, but there are definitely some rooms to continue exploring and learning from these packages.

**Major Challenges**

In regard to the overall structure of our team, our members have pretty hectic schedule since most of us are working part-time. However, we are arranging our schedule and will decide on a weekly 1-2 hours meeting over Discord in order to keep updated with our progress and individual task. Additionally, another challenge is that if our proposed questions for this project are too broad. As a result, we plan to get feedbacks from TA as well as Prof. Burkart in order to reflect and update our project proposal before we start performing the analysis.
