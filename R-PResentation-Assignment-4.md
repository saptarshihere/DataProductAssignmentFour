Data Product (Assignment Four)
========================================================
author: Saptarshi Lahiri
date: 24-Sep-2017
autosize: true

Overview
========================================================


This Shiny application will help you predicting OZONE level for a given value of Temperature ( in Degree Farenhite )

- Open the application using the below link  
https://saptarshi.shinyapps.io/data_product_assignment_4/

- Select a temperature value through the slider
- Click on the PREDICT button
- See the predicted value as a 'BLUE' dot on the graph
- Hover your mouse over the graph to see the value

Relevant code for this assignment is stored in GitHub Repository
https://github.com/saptarshihere/DataProductAssignmentFour/


Client Code
========================================================


```r
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
```

<!--html_preserve--><div class="container-fluid">
<h2>Predict Variation of OZONE level with TEMPERATURE</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<div class="form-group shiny-input-container">
<label class="control-label" for="sliderTemp">Slide to a Temperature Value</label>
<input class="js-range-slider" id="sliderTemp" data-min="56" data-max="97" data-from="10" data-step="1" data-grid="true" data-grid-num="8.2" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-keyboard-step="2.4390243902439" data-data-type="number"/>
</div>
<div>
<button type="submit" class="btn btn-primary">PREDICT</button>
</div>
</form>
</div>
<div class="col-sm-8">
<div id="plot1" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
<h4>Predicted Ozone Level (Blue Circle):</h4>
<div id="pred1" class="shiny-text-output"></div>
<h6>Guide Notes: Insert Temperature value through slider, then press PREDICT button</h6>
</div>
</div>
</div><!--/html_preserve-->

Server Code
========================================================

```r
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
```
Data Set Summary
========================================================

```r
summary(airquality[,c('Ozone','Temp')])
```

```
     Ozone             Temp      
 Min.   :  1.00   Min.   :56.00  
 1st Qu.: 18.00   1st Qu.:72.00  
 Median : 31.50   Median :79.00  
 Mean   : 42.13   Mean   :77.88  
 3rd Qu.: 63.25   3rd Qu.:85.00  
 Max.   :168.00   Max.   :97.00  
 NA's   :37                      
```

