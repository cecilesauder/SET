library(shiny)
library(SET)
library(purrpleWidgets)

shinyUI(fluidPage( 
  theme = "SET.css", 
  
  tags$head( 
   tags$script(src="SET.js")
  ), 
  purrple_logo(), 

  headerPanel("SET"),
  
  sidebarPanel(
    actionButton("action", label = "SET !"),
    textOutput("sel_cards")
  ),
  
  mainPanel(
    htmlOutput('cards')
  )
  
))
