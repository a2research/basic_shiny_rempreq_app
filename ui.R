##############################
### data Types - ui.R ########
##############################

library(shiny)
library(rempreq)

shinyUI(pageWithSidebar(

  headerPanel("Employment Impact Calculator"),

  sidebarPanel(

    numericInput(inputId = "numeric_prod_amount",
                 label = "Production Amount ($ Million 2009 USD)",
                 min = 1, max = 10, value = 10),

    radioButtons(inputId = "radio_domestic_total",
                 label = "Domestic or Total",
                 choices = list("Domestic" = "Domestic", "Total" = "Total", "Imports" = "Imports")),
    
    radioButtons(inputId = "total_direct_indirect",
                 label = "Direct, Indirect or Total",
                 choices = list("Total" = "Total", "Direct" = "Direct", "Indirect" = "Indirect")),

    selectInput(inputId = "select_year",
                label = "Year",
                choices = mapply(function(x,y) { y }, as.character(TABLE_YEARS), TABLE_YEARS,
                    SIMPLIFY = FALSE,USE.NAMES = TRUE), selected = as.character(LATEST_YEAR)),

    selectInput(inputId = "select_sector",
                label = "Sector",
                choices = mapply(function(x,y) { y }, sectors$Industry.Commodity.Description, 
                                 sectors$Sector.Number,   SIMPLIFY = FALSE,USE.NAMES = TRUE)),
    
    actionButton(inputId = "go",
                 label = "Update")

  ),
 
  mainPanel(
    h3("Employment Impact Results"),
    #textOutput('show_text')
    tableOutput("table_results")
  )
))
