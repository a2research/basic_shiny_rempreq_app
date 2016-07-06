##############################
### data Types - ui.R ########
##############################

library(shiny)
library(rempreq)

shinyUI(tabsetPanel(
  # Employment for a sector, for a given year, source, direct/indirect:
  tabPanel(
    "Employment",
    
    pageWithSidebar(
      headerPanel("Jobs Generated"),
      
      sidebarPanel(
        numericInput(
          inputId = "numeric_prod_amount",
          label = "Production Amount ($ Million 2009 USD)",
          min = 1,
          max = 10,
          value = 10
        ),
        
        wellPanel(
          radioButtons(
            inputId = "radio_domestic_total",
            label = "Domestic, Total, or Imports",
            choices = list(
              "Domestic" = "Domestic",
              "Total" = "Total",
              "Imports" = "Imports"
            )
          ),
          
          radioButtons(
            inputId = "radio_total_direct_indirect",
            label = "Direct, Indirect, or Total",
            choices = list(
              "Total" = "Total",
              "Direct" = "Direct",
              "Indirect" = "Indirect"
            )
          )
        ),
        selectInput(
          inputId = "select_year",
          label = "Year",
          choices = mapply(
            function(x, y) {
              y
            },
            as.character(TABLE_YEARS),
            TABLE_YEARS,
            SIMPLIFY = FALSE,
            USE.NAMES = TRUE
          ),
          selected = as.character(LATEST_YEAR)
        ),
        
        selectInput(
          inputId = "select_sector",
          label = "Sector",
          choices = mapply(
            function(x, y) {
              y
            },
            sectors$Industry.Commodity.Description,
            sectors$Sector.Number,
            SIMPLIFY = FALSE,
            USE.NAMES = TRUE
          )
        ),
        
        actionButton(inputId = "go",
                     label = "Update")
        
      ),
      
      mainPanel(h3("Employment Impact Results"),
                tableOutput("table_results"))
    )
  ),  # TabPanel Employment Panel
  
  
  # Employment for a sector, all years source, direct/indirect:
  tabPanel(
    "Trend",
    
    pageWithSidebar(
      headerPanel("Sector Employment Trend"),
      
      sidebarPanel(
        numericInput(
          inputId = "numeric_prod_amount",
          label = "Production Amount ($ Million 2009 USD)",
          min = 1,
          max = 10,
          value = 10
        ),
        
        wellPanel(
          radioButtons(
            inputId = "radio_domestic_total",
            label = "Domestic, Total, or Imports",
            choices = list(
              "Domestic" = "Domestic",
              "Total" = "Total",
              "Imports" = "Imports"
            )
          ),
          
          radioButtons(
            inputId = "radio_total_direct_indirect",
            label = "Direct, Indirect, or Total",
            choices = list(
              "Total" = "Total",
              "Direct" = "Direct",
              "Indirect" = "Indirect"
            )
          )
        ),
        #selectInput(
        #  inputId = "select_year",
        #  label = "Year",
        #  choices = mapply(
        #    function(x, y) {
        #      y
        #    },
        #    as.character(TABLE_YEARS),
        #    TABLE_YEARS,
        #    SIMPLIFY = FALSE,
        #    USE.NAMES = TRUE
        #  ),
        #  selected = as.character(LATEST_YEAR)
        #),
        
        selectInput(
          inputId = "select_sector",
          label = "Sector",
          choices = mapply(
            function(x, y) {
              y
            },
            sectors$Industry.Commodity.Description,
            sectors$Sector.Number,
            SIMPLIFY = FALSE,
            USE.NAMES = TRUE
          )
        ),
        
        actionButton(inputId = "go",
                     label = "Update")
        
      ),
      
      mainPanel(h3("Employment Trend Results"),
                tableOutput("table_results"))
      
      
      
    )  # pageWithSidebar
    
    
  )   # tabPanel Sector Trend
) # tabsetPanel 

) # shinyUI
