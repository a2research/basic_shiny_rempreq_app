empImpactServer <- function(input, output, session) {
  
  
  run_emp_params <- eventReactive(input$update_emp, {
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
  
  output$emp_table_results <- renderTable({
    result <- run_emp_params()
    })
  
 

 ################################################# 

  run_sector_emp_params <- eventReactive(input$update_emp_sector, {
    validate(
      need(is.numeric(input$numeric_prod_amount), "Please input a valid numeric production amount (million$)")
    )
    if (input$radio_total_direct_indirect == 'Total') {
      use_fun <- sector_all_impact_all_years
    } else if (input$radio_total_direct_indirect == 'Direct') {
      use_fun <- sector_direct_impact_all_years
    } else
      use_fun <- sector_indirect_impact_all_years
    
    if (input$radio_domestic_total == 'Domestic') {
      use_table <- dom_table_list
    } else if (input$radio_domestic_total == 'Total') {
      use_table <- all_table_list
    } else
      use_table <- imports_table_list
    
    #employment <- formatC(use_fun(as.numeric(input$select_sector), 
    #                                     input$numeric_prod_amount, 
    #                                     use_table), digits =  2, format = "f", big.mark = ",")
    employment <- use_fun(as.numeric(input$select_sector), 
                                         input$numeric_prod_amount, 
                                         use_table)
  
    sector_emp_res <- data.frame(Year = TABLE_YEARS, Employment = employment, row.names = NULL)
    #row.names(sector_emp_res) <- c('Million$ Output', 'Source', 'Sector', 'Jobs Generated' )
    row.names(sector_emp_res) <- NULL
    
    return(sector_emp_res)
  })
  
  output$all_years_table_results <- renderTable({
    result <- run_sector_emp_params()
  }, include.rownames = FALSE)
  df <- data.frame(x = runif(100), y = runif(100))
  # output$sector_trend_plot <- renderPlot(ggplot(df) + geom_point(aes(x, y)))
  output$sector_trend_plot <- renderPlot(ggplot(run_sector_emp_params(), aes(x = Year, y = Employment)) + 
                                                geom_point(aes(x = Year, y = Employment), color = 'red') +
                                                geom_smooth(aes(x = as.numeric(Year), y = Employment))
                                         )
  } 
