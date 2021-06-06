
dashboardPage(
    dashboardHeader(title = "Vehicle Recalls"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Home", tabName = "home"),
            menuItem("Dataset", tabName = "dashboard"),
            menuItem("Recalls and Manufacturers", tabName = "data"),
            menuItem("Recall Component History", tabName = "times"),
            menuItem("Findings", tabName = "find")
            
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
                        column(12, plotOutput('bar')),
                        
                        selectizeInput(inputId = "manu",
                                       label = "Recall Component",
                                       choices = vehicle_edit$Recall.Component)
                        
            )),
            
            tabItem(tabName = "times",
                    fluidRow(
                        column(12, plotOutput('time')),
                        
                        selectizeInput(inputId = "t",
                                       label = "Recall Component",
                                       choices = vehicle_edit$Recall.Component)
                    )),
            
            # tabItem(tabName = "find",
            #         fluidRow(
            #             box(plotOutput("found")),
            
                        
                        
            tabItem(tabName = "home",
                    h2("Analysis on Vehicle Recalls"),
                    br(),
                    strong(p('Sidebar Tabs')),
                    p("- Dataset- This is the complete dataset that I used for my project."),
                    p("- Recalls and Manufacturers- This a bar chart where you can see the top
                      10 manufactuers with the most recalls for a selected recall component."),
                    p("- Recall Component History- This a line chart that shows the recaall amount 
                    of the selected recall component over the years."),
                    p("- Findings- This where I share my main findings."),
                    br(),
                    br(),
                    strong(p('Background')),
                    p('The dataset used contains 10000s of vehicle-related recalls from 1966-2016.
                    This Shiny app provides analysis on this dataset, and look into recalls'),
                    p('If interested in downloading the dataset, you can click here:', a('https://www.kaggle.com/nhtsa/safety-recalls'))
                    
                           
            
            )
        )
    )

)