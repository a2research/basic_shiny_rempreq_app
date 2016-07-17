# Module Tabs UI function

# Employment impact for a given year:
empImpactUI <- function(id) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
      # Employment for a sector, for a given year, source, direct/indirect:
 # tabPanel(
 #  "Employment",
    
    pageWithSidebar(
      headerPanel("Jobs Generated"),
      
      sidebarPanel(
        selectInput(
          inputId = ns("select_year"),
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
          inputId = ns("select_sector"),
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
        
        numericInput(
          inputId = ns("numeric_prod_amount"),
          label = "Production Amount ($ Million 2009 USD)",
          value = 10
        ),
        
        wellPanel(
          radioButtons(
            inputId = ns("radio_domestic_total"),
            label = "Domestic, Total, or Imports",
            choices = list(
              "Domestic" = "Domestic",
              "Total" = "Total",
              "Imports" = "Imports"
            )
          ),
          
          radioButtons(
            inputId = ns("radio_total_direct_indirect"),
            label = "Direct, Indirect, or Total",
            choices = list(
              "Total" = "Total",
              "Direct" = "Direct",
              "Indirect" = "Indirect"
            )
          )
        ),
        
        actionButton(inputId = ns("update_emp"),
                     label = "Update")
        
      ),
      
      mainPanel(h3("Employment Impact Results"),
                tableOutput(ns("emp_table_results")),
                imageOutput("sector_trend_plot")
      )
    ) #pageWithSidebar

  ) # tagList
}

############ Trend ####################

# Employment impact for a given sector, for all years:
allYearsEmpImpactUI <- function(id) {
  # Create a namespace function using the provided id
  ns <- NS(id)
  
  tagList(
    
    # Employment for a sector, all years source, direct/indirect:
    tabPanel(
      "Trend",
      
      pageWithSidebar(
        headerPanel("Sector Employment Trend"),
        
        sidebarPanel(
          selectInput(
            inputId = ns("select_sector"),
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
          
          numericInput(
            inputId = ns("numeric_prod_amount"),
            label = "Production Amount ($ Million 2009 USD)",
            value = 10
          ),
          
          wellPanel(
            radioButtons(
              inputId = ns("radio_domestic_total"),
              label = "Domestic, Total, or Imports",
              choices = list(
                "Domestic" = "Domestic",
                "Total" = "Total",
                "Imports" = "Imports"
              )
            ),
            
            radioButtons(
              inputId = ns("radio_total_direct_indirect"),
              label = "Direct, Indirect, or Total",
              choices = list(
                "Total" = "Total",
                "Direct" = "Direct",
                "Indirect" = "Indirect"
              ),
              selected = "Direct"
            )
          ),
          
          
          actionButton(inputId = ns("update_emp_sector"),
                       label = "Update")
          
        ),
        
        mainPanel(h3("Employment Trend Results"),
                  fluidRow(
                    column(2,
                  
                  tableOutput(ns("all_years_table_results"))
                  ),
                    column(10,
        plotOutput(ns("sector_trend_plot"), width = "100%")
                  )
                  )
        )
        
        
        
      )  # pageWithSidebar
      
      
    )   # tabPanel Sector Trend
    
  )
}


