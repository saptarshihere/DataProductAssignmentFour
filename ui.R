#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Shiny UI
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Variation of OZONE level with TEMPERATURE"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderTemp","Slide to a Temperature Value", min = 56, max = 97, value = 10),
      submitButton("PREDICT") # Click to Predict
    ),
    
    # Plotting
    mainPanel(
      plotOutput("plot1"),
      h4("Predicted Ozone Level (Blue Circle):"),
      textOutput("pred1"),
      h6("Guide Notes: Insert Temperature value through slider, then press PREDICT button")
    )
  )
))