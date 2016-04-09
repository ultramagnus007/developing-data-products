# ui.R
shinyUI(fluidPage(
  titlePanel("K-Means Clustering"),
  sidebarLayout(
    sidebarPanel(
      helpText("Move the slider to change the Number of Data points"),
      fluidRow(
        sliderInput("ndata", "Number of data points",min = 20, max = 200, value = 100)
      ),
      helpText("Move the slider to change the Number of Cluster for Data generation"),
      fluidRow(
        sliderInput("ncluster", "Number of Clusters for data generation",min = 3, max = 20, value = 4)
      ),
      helpText("Move the slider to change Number of Cluster for K-Means Clustering "),
      fluidRow(
        sliderInput("nkmean", "Number of Clusters for Kmean Custering Algo",min = 3, max = 20, value = 4)
      )  
      ),
    mainPanel(
      helpText("Plot showing the generated data and clusters around which data Points are generated, Cluster number are shown in Black numeric letters at their location, data points belonging different clusters have different color"),      
      plotOutput("DataPlot"),
      helpText("Plot showing the generated data and clusters calcultaed from K-Mean clustering algorithm, Cluster number are shown in Black numeric letters at their location, data points belonging different clusters have different color"),
      plotOutput("KmeanPlot")            
      )
  )
))