
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/


library(shiny)

shinyUI(fluidPage(
  
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
    htmlOutput( "deck_cards" )
    # fluidRow(
    #   column(2,imageOutput("image1", click = NULL)),
    #   column(2,imageOutput("image2", click = NULL)),
    #   column(2,imageOutput("image3", click = NULL)),
    #   column(2,imageOutput("image4", click = NULL))
    # ),
    # fluidRow(
    #   column(2,imageOutput("image5", click = NULL)),
    #   column(2,imageOutput("image6", click = NULL)),
    #   column(2,imageOutput("image7", click = NULL)),
    #   column(2,imageOutput("image8", click = NULL))
    # ),
    # fluidRow(
    #   column(2,imageOutput("image9", click = NULL)),
    #   column(2,imageOutput("image10", click = NULL)),
    #   column(2,imageOutput("image11", click = NULL)),
    #   column(2,imageOutput("image12", click = NULL))
    # )
  )
))
