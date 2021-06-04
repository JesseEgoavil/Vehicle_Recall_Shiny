#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyverse)

vehicle= read.csv('vehicle.csv')

vehicle = transform(vehicle, Recall.Notification.Date = as.Date(as.character(Recall.Notification.Date),"%Y%m%d"))
vehicle = transform(vehicle, Manufacture.Start.Date  = as.Date(as.character(Manufacture.Start.Date), "%Y%m%d"))
vehicle = transform(vehicle, Manufacture.End.Date = as.Date(as.character(Manufacture.End.Date), "%Y%m%d"))

function(input, output){
    output$table <- renderDataTable(vehicle,
                                    options = list(scrollX = TRUE)
                                    )
    output$bar <- renderPlot(
        vehicle %>%
            filter(., str_detect
                   (Recall.Component,'AIR BAGS')) %>%
            select(., Recall.Component, Recall.Manufacturer, Estimated.Units)%>%
            group_by(., Recall.Manufacturer) %>%
            summarize(., Total_Recalls=sum(Estimated.Units))%>%
            arrange(desc(Total_Recalls))%>%
            top_n(10)%>%
            ggplot(aes(x = reorder(Recall.Manufacturer, -Total_Recalls), y = Total_Recalls)) + geom_bar(stat='identity')
    )
    }

