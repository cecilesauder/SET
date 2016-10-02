
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("SET"),
  
  sidebarPanel(
    actionButton("new_game", label = "New game"),
    textInput("c1", "card 1 : ",value = "1"),
    textInput("c2", "card 2 : ",value = "2"),
    textInput("c3", "card 3 : ",value = "3"),
    
    actionButton("action", label = "SET !")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    tableOutput("table")
  )
))
