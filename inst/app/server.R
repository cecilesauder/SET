
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dplyr)

shinyServer(function(input, output) {
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

  output$table <- renderTable({
    tab
  })
  
  output$value1 <- renderPrint({ input$c1 })
  output$value2 <- renderPrint({ input$c2 })
  output$value3 <- renderPrint({ input$c3 })
  
  
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
