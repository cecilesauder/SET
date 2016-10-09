
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
  
  #table de jeu prete a afficher :
  table <- allocate_cards(tab$idcards)
  names(table) <- NULL
  
  output$truc <- renderSETwidget({
    SETwidget(table)
  })

})
