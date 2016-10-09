
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dplyr)
library(SET)

shinyServer(function(input, output, session) {
  jeu_start<- expand.grid( forme=1:3, nombre=1:3, remplissage=1:3, couleur=1:3 )
  #1 carte represente une ligne du tableau, on a le jeu de 81 cartes dans le tableau
  
  #melange du jeu de carte
  jeu <- jeu_start %>% 
    mutate(idcards = row_number() ) %>% 
    sample_n(81)
  jeu <- jeu
  
  #Choix des cartes
  ncards<-12
  #tableau de cartes
  tab<-jeu[1:ncards,]

 
  output$deck_cards <- renderUI({
    
    display_card <-function(i){
      src <- sprintf("cards/%d.png", i)
      style <- if( i %in% selected_cards$data){
        "border : 2px solid red"
      }
      tags$img(
        src = src,
        width = 150, 
        onclick = sprintf( 'Shiny.onInputChange( "img_clicked", %d )', i ),
        style = style
      )
    }
    allocate_cards <- function(cards){
      split( cards, rep(1:3, length.out = length(cards))  )
    }
    div <- div(
      lapply(allocate_cards(tab$idcards), function(cards){
        div(lapply(cards, display_card))
      })
    )
    div
 
  })
  
  selected_cards<-reactiveValues( data = NULL)
  reactive_selected_cards <- eventReactive(input$img_clicked,{
    numcard <- input$img_clicked
    if (length(selected_cards$data) < 3){
      selected_cards$data <- c(selected_cards$data,numcard)
    }
    if( length(selected_cards$data ) == 3){
      if(verif_set(selected_cards$data ,jeu)){
        title <- "Set!"
      }else{
        title <- "FAIL"
      }
      showModal(modalDialog(
        title = title,
        footer = actionButton("ok", "OK"),
        div(
          lapply(selected_cards$data , function(i){
            img(
              src = sprintf("cards/%d.png", i),
              width = 150
            )
          })
        )
      ))
  
    }
    selected_cards$data 
  })
  
  observeEvent(input$ok, {
    selected_cards$data <- NULL
    removeModal()
  })
  
  output$card_clicked <- renderText({
    if(is.null(reactive_selected_cards())){
      "Aucune carte cliquée"
    }else{
      reactive_selected_cards()
    }
  })
 

})
