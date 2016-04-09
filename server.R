shinyServer(
  function(input, output) { 
     #set.seed(101)
     #Generate the deviation corresponding to each data point in two dimension,
     #arround the mean, from the normal distribution 
     deviation<- reactive({
       n<-input$ndata
       x = matrix(rnorm(n * 2), n, 2)
       x
     })
     #Generate Cluster id which corrospond to each data point
     clusterid<-reactive({
       n<-input$ndata
       K1<-input$ncluster
       clusterid = sample(1:K1, n, replace = TRUE)
       clusterid
     })
     
     xmean<-reactive({
       K1<-input$ncluster
       #randomly Generate Cluster means
       xmean = matrix(rnorm(2*K1, sd = 4), K1, 2)
       xmean;
     })
    data<-reactive({
      Xmean<-xmean()
      id<-clusterid()
      #Generate ndata points from these clusters means
      data = deviation() + Xmean[id, ]
      data
    })
    #plot the data, datapoint with same color corresponds to same cluster
    output$DataPlot <- renderPlot({
      d<-data()
      id<-clusterid()
      Xmean<-xmean()
      plot(d, col = id, pch = 19, main = "Plot I: Input Data points and clusters",
           xlab= "X axis", ylab = "Y axis")
      text(Xmean, labels=1:nrow(Xmean), cex= 2)      
    })
    #plot the data After Applying the K means Clustersing,
    #datapoint with same color corresponds to same cluster
    output$KmeanPlot <- renderPlot({
      K2<-input$nkmean            
      km.out = kmeans(data(), K2, nstart = 15)
      plot(data(), col = km.out$cluster, pch = 19, main = "Plot II: Output Clusters",
           xlab= "X axis", ylab = "Y axis")
      text(km.out$centers, labels=1:nrow(km.out$centers), cex= 2)            
    })
  }
)