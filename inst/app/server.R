
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dplyr)
library(SET)
library(htmlwidgets)

shinyServer(function(input, output, session) {
  ncards <- 12
  list_df_cards <- draw_cards(ncards,create_gameplay())
  tab <- list_df_cards$drawn_cards
  #table de jeu prete a afficher :
  table <- allocate_cards(tab$idcards)
  names(table) <- NULL
  
  output$cards <- renderSETwidget({
    SETwidget(table)
  })
  
  output$sel_cards = renderPrint({
    input$selected_cards
  })

})
