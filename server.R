##########################################
##### data types and values - server.R ###
##########################################

library(shiny)
library(rempreq)

shinyServer(function(input, output) {
  
  run_params <- eventReactive(input$go, {
    validate(
      need(is.numeric(input$numeric_prod_amount), "Please input a valid numeric production amount (million$)")
    )
    if (input$radio_total_direct_indirect == 'Total') {
      use_fun <- emp_impact_all_sectors
    } else if (input$radio_total_direct_indirect == 'Direct') {
      use_fun <- direct_emp_impact
    } else
      use_fun <- indirect_emp_impact
    
    if (input$radio_domestic_total == 'Domestic') {
      use_table <- dom_table_list
    } else if (input$radio_domestic_total == 'Total') {
      use_table <- all_table_list
    } else
      use_table <- imports_table_list
    
    employment <- formatC(use_fun(as.numeric(input$select_sector), 
                                         input$numeric_prod_amount, 
                                         input$select_year,
                                         use_table), digits =  2, format = "f", big.mark = ",")
    
    
    
    emp_res <- data.frame(Results = c(input$numeric_prod_amount,
      input$radio_domestic_total,
      input$select_year,
      sector_description(as.numeric(input$select_sector), sectors),
      employment))
    row.names(emp_res) <- c('Million$ Output', 'Source', 'Year', 'Sector', 'Jobs Generated' )
    return(emp_res)
  })
  
  #output$show_text <- renderText({
  #  result <- run_params()
  #  })

  output$table_results <- renderTable({
    result <- run_params()
    })
  
#  output$textDisplay <- renderTable({
#    getMat = matrix(c(paste(input$numeric_prod_amount, class(input$boxInput),
#                      input$radio_domestic_total, class(input$pickRadio),
#                      input$select_year, class(input$comboBox)),
#                      ncol=2, byrow = TRUE))

#    colnames(getMat) = c("Value", "Class")
#    getMat

#  })

})


