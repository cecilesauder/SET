
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
  nbcards<-12
  #tableau de cartes
  tab<-jeu[1:nbcards,]

 
  output$deck_cards <- renderUI({
    
    display_card <-function(i){
      src <- sprintf("cards/%d.png", i)
      alert_msg <- sprintf('alert("carte n°%d")', i)
      tags$img(src = src,
               width = 100, 
               onclick = alert_msg)
    }
    list_cards <- lapply(tab$idcards, display_card)
    div <- div(
    list_cards[1:4],
    br(),
    br(),
    list_cards[5:8],
    br(),
    br(),
    list_cards[9:12]
    )
    div
 
  })

  # lapply( 1:nbcards, function(i){
  #   output[[paste("image",i, sep="")]] <- renderImage({
  #     # When input$n is 3, filename is ./images/image3.jpeg
  #     filename <- normalizePath(file.path( system.file( "app", "www", "cards", package = "SET" ), paste(tab[i,"idcards"], ".png", sep="")))
  # 
  #     # Return a list containing the filename and alt text
  #     list(src = filename,
  #          contentType = 'image/png',
  #          width = 150,
  #          height = 200)
  #     
  #   }, deleteFile = FALSE)
  # })
  

})
