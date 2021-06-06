

function(input, output){
    output$table <- renderDataTable(vehicle_raw,
                                    options = list(scrollX = TRUE)
                                    )
    output$bar <- renderPlot(
            vehicle_unique %>%
              filter(Recall.Component == input$manu)%>%
              select(., Recall.Component, Estimated.Units, Vehicle.Manufacturer)%>%
              group_by(., Vehicle.Manufacturer)%>%
              summarise(., t= sum(Estimated.Units, na.rm=TRUE))%>%
              arrange(desc(t))%>%
              top_n(10)%>%
              ggplot(aes(x = reorder(Vehicle.Manufacturer, t), y = t)) + 
              geom_bar(stat='identity')+ scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) +
              coord_flip() + ggtitle("Top 10 Manufacturers") +
              xlab("Manufacturer") + ylab("Number of Recalls"))
            
    output$time <- renderPlot(
              vehicle_unique %>%
                group_by(Recall.Notification.Date, Recall.Component) %>%
                filter(Recall.Notification.Date>1965 & Recall.Notification.Date<=2016) %>%
                filter(Recall.Component == input$t) %>%
                summarise(., t= sum(Estimated.Units, na.rm=TRUE))%>%
                ggplot(aes(x=Recall.Notification.Date, y=t, colour= Recall.Component)) +
                geom_line() + scale_y_continuous(labels = label_number(suffix = " M", scale = 1e-6)) + geom_point() +
                  ggtitle("Recall Component over the Years") +
                  xlab("Years") + ylab("Number of Recalls")
    )
    
    # output$find <- renderPlot(
    #     vehicle_unique %>%
            
    #)
    
    
    
    
    
    }
