library(shiny)
library(SET)
library(purrple)

page <- purrplePage(fluidPage)
shinyUI(page( 
  theme = "SET.css", 
  
  tags$head( 
   tags$script(src="SET.js")
  ), 
  
  headerPanel("SET"),
  
  sidebarPanel(
    actionButton("action", label = "SET !"),
    textOutput("sel_cards")
  ),
  
  mainPanel(
    htmlOutput('cards')
  )
  
))
