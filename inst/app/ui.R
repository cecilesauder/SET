
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/


library(shiny)
library(SET)


shinyUI(fluidPage( 
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
