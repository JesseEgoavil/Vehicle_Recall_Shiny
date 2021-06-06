library(data.table)
library(shiny)
library(shinydashboard)
library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(scales)
library(gcookbook)

vehicle_raw <- read.csv(file = "vehicle.csv")

vehicle_raw = transform(vehicle_raw, Recall.Notification.Date = as.Date(as.character(Recall.Notification.Date),"%Y%m%d"))
vehicle_raw = transform(vehicle_raw, Manufacture.Start.Date  = as.Date(as.character(Manufacture.Start.Date), "%Y%m%d"))
vehicle_raw = transform(vehicle_raw, Manufacture.End.Date = as.Date(as.character(Manufacture.End.Date), "%Y%m%d"))

vehicle_edit = vehicle_raw
vehicle_edit$Recall.Component = gsub(",", ":", vehicle_edit$Recall.Component)
vehicle_edit= separate(vehicle_edit, col = Recall.Component, into = c("Recall.Component","Detail"), sep = ":")
vehicle_edit$Detail = NULL

vehicle_edit= vehicle_edit[vehicle_edit$Recall.Component != 'TBD',]
vehicle2 = vehicle_edit[vehicle_edit$Recall.Component == 'ENGINE',]
vehicle_edit= vehicle_edit[vehicle_edit$Recall.Component != 'ENGINE',]
vehicle2$Recall.Component = sub("ENGINE", "ENGINE AND ENGINE COOLING", vehicle2$Recall.Component)  
vehicle_edit= rbind(vehicle_edit, vehicle2)

vehicle_unique = vehicle_edit[c('NHTSA.Campaign', 'Estimated.Units', 'Recall.Notification.Date', 'Vehicle.Manufacturer','Recall.Component')]
vehicle_unique = distinct(vehicle_unique)
vehicle_unique$Recall.Notification.Date =as.integer(format(vehicle_unique$Recall.Notification.Date, '%Y'))
