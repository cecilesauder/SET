library(shiny)
library(dplyr)
library(SET)

shinyServer(function(input, output, session) {
  
  ncards <- 12
  list_df_cards <- draw_cards(ncards,create_gameplay())
  tab <- list_df_cards$drawn_cards
  #table de jeu prete a afficher :
  table <- allocate_cards(tab$idcards)
  names(table) <- NULL
  
  # prints the currently selected cards
  output$sel_cards = renderText({
    cards <- input$selected_cards
    if( is.null(cards) ) "" else paste( cards, collapse = ", " )
  })
  
  # observes changes in selected cards (input$selected_cards)
  # and triggers the is_set message if they are a SET
  observe({
    cards <- input$selected_cards
    if(length(cards) == 3 ){
      is_set <-tab %>% filter( idcards %in% cards) %>% is_set
      if(is_set){
        session$sendCustomMessage(type = "is_set", "SET!")
      }
    }
  })
  
  # sends the message to initialize the table of cards
  session$sendCustomMessage( 
    type = "init_set", 
    list( table = table)
  )
  
})
