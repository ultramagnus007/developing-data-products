# ui.R
shinyUI(fluidPage(
  titlePanel("K-Means Clustering"),
  sidebarLayout(
    sidebarPanel(
      fluidRow(
        sliderInput("ndata", "Number of data points",min = 20, max = 200, value = 100)
      ),
      fluidRow(
        sliderInput("ncluster", "Number of Clusters for data generation",min = 3, max = 20, value = 4)
      ),
      fluidRow(
        sliderInput("nkmean", "numner of Clusters for Kmean Custering",min = 3, max = 20, value = 4)
      )  
      ),
    mainPanel(      
      plotOutput("DataPlot"),
      plotOutput("KmeanPlot")            
      )
  )
))