shinyServer(
  function(input, output) { 
     set.seed(101)
     #Generate the deviation corresponding to each data point in two dimension,
     #arround the mean, from the normal distribution 
     deviation<- reactive({
       ndata<-input$ndata
       x = matrix(rnorm(ndata * 2), ndata, 2)
       x
     })
     #Generate Cluster id which corrospond to each data point
     clusterid<-reactive({
       ndata<-input$ndata
       ncluster<-input$ncluster
       clusterid = sample(1:ncluster, ndata, replace = TRUE)
       clusterid
     })
     
     xmean<-reactive({
       ncluster<-input$ncluster
       #randomly Generate Cluster means
       xmean = matrix(rnorm(2*ncluster, sd = 4), ncluster, 2)
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
      plot(d, col = id, pch = 19)
      text(Xmean, labels=1:nrow(Xmean), cex= 2)      
    })
    #plot the data After Applying the K means Clustersing,
    #datapoint with same color corresponds to same cluster
    output$KmeanPlot <- renderPlot({
      nkmean<-input$nkmean            
      km.out = kmeans(data(), nkmean, nstart = 15)
      plot(data(), col = km.out$cluster, pch = 19)
      text(km.out$centers, labels=1:nrow(km.out$centers), cex= 2)            
    })
  }
)