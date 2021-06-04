#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

dashboardPage(
    dashboardHeader(title = "Vehicle Recalls"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Home", tabName = "home"),
            menuItem("Dataset", tabName = "dashboard"),
            menuItem("Data", tabName = "data")
            
        )
    ),
    dashboardBody(
        tabItems(
            tabItem(tabName = "dashboard",
                    fluidRow(
                        column(12, dataTableOutput('table'))
                        
            )
            ),
            
            tabItem(tabName = "data",
                    fluidRow(
                        column(12, plotOutput('bar'))
            )),
            
            tabItem(tabName = "home",
                    h2("Widgets tab content")
            
            )
        )
    )
)
