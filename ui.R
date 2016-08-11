# Allan Miller
# allan amilleranalytics.com
# License: GPL-2
##############################
### data Types - ui.R ########
##############################

library(shiny)
library(rempreq)
library(ggplot2)

source('empImpactUIModule.R')

shinyUI(tabsetPanel(
  tabPanel(
    "Employment",
    empImpactUI("emp_impact")
  ),  # TabPanel Employment Panel
  tabPanel(
    "Trend",
    allYearsEmpImpactUI("sector_trend")
  )
  
) # tabsetPanel 

) # shinyUI
