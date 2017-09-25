#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
data("airquality")
#Internal airquality data has been used

# Server definition
shinyServer(function(input, output) {
  # Fit a linear model
  airq<-na.omit(airquality)
  ozl<-airq$Ozone
  Temp<-airq$Temp
  model1<-lm(ozl~Temp)
  # Predict
  model1pred<-reactive({
    TempInput<-input$sliderTemp
    predict(model1, newdata=data.frame(Temp=TempInput))
  })
  
  # Plot it
  output$plot1<-renderPlot({
    TempInput<-input$sliderTemp
    plot(airquality$Temp, airquality$Ozone, xlab = "Temperature", ylab = "Ozone", bty="n", pch=16)
    points(TempInput, model1pred(), col="blue", pch=16, cex=2)
  })
  
  # Output
  output$pred1<-renderText({
    model1pred()
  })
  
})