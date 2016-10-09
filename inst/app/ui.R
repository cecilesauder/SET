
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/


library(shiny)

shinyUI(fluidPage(
  
  # Application title
  headerPanel("SET"),
  
  sidebarPanel(
    #actionButton("new_game", label = "New game"),
    actionButton("action", label = "SET !")
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    SETwidgetOutput('cards')

  )
))
