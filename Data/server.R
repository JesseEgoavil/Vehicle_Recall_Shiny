

function(input, output){
    output$table <- renderDataTable(vehicle_raw,
                                    options = list(scrollX = TRUE)
                                    )
    output$bar <- renderPlot(
            vehicle_unique %>%
              filter(Recall.Component == input$manu)%>%
              select(., Recall.Component, Estimated.Units, Vehicle.Make)%>%
              group_by(., Vehicle.Make)%>%
              summarise(., t= sum(Estimated.Units, na.rm=TRUE))%>%
              arrange(desc(t))%>%
              top_n(10)%>%
              ggplot(aes(x = reorder(Vehicle.Make, t), y = t)) + 
              geom_bar(stat='identity')+ scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
              coord_flip() + ggtitle("Top 10 Companies") +
              xlab("Companies") + ylab("Number of Recalls"))
            
    output$time <- renderPlot(
              vehicle_unique %>%
                group_by(Recall.Notification.Date, Recall.Component) %>%
                filter(Recall.Notification.Date>1965 & Recall.Notification.Date<=2016) %>%
                filter(Recall.Component == input$t) %>%
                summarise(., t= sum(Estimated.Units, na.rm=TRUE))%>%
                ggplot(aes(x=reorder(Recall.Notification.Date), y=t, colour= Recall.Component)) +
                geom_line() + scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) + geom_point() +
                  ggtitle("Recall Component over the Years") +
                  xlab("Years") + ylab("Number of Recalls")
    )
    
    output$found <- renderPlot(
    vehicle_unique2 %>%
        filter(Recall.Notification.Date-Model.Year>-2)%>%
        summarise(t= Recall.Notification.Date-Model.Year)%>%
        count(t)%>%
        filter(t<18)%>%
        ggplot(aes(x= t, y= n))+ geom_bar(stat = 'identity')+
        xlab("Difference between Recall Year and Model Year") + ylab("Freq of Recalls")
            
    )
    output$found1 <- renderPlot(
        vehicle_unique2 %>%
            filter(Recall.Notification.Date-Model.Year>-2)%>%
            summarise(t= Recall.Notification.Date-Model.Year)%>%
            count(t)%>%
            filter(t<18)%>%
            ggplot(aes(x=n))+ geom_boxplot()+
        xlab("Freq of Recalls")) 
    
    output$found2 <- renderPlot(
        vehicle_unique2 %>%
            filter(Model.Year < 2019)%>%
            group_by(Model.Year)%>%
            ggplot(., aes(Model.Year)) + geom_histogram(bins= 24)+
        xlab("Model Year") + ylab("Freq of Recalls"))
    
    output$found3 <- renderPlot(
        vehicle_unique %>%
        group_by(Vehicle.Make)%>%
        summarise(t= sum(n()))%>%
        arrange(desc(t))%>%
        top_n(10)%>%
        ggplot(.,aes(x= Vehicle.Make, y= t)) + geom_bar(stat = 'identity')+
        xlab("Companies") + ylab("Freq of Recalls"))
    
    }
