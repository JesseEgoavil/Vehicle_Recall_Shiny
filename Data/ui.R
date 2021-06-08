
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
            
             tabItem(tabName = "find",
                     fluidRow(
                         box(title= 'Chart 1', plotOutput("found", height = 200, width= 550)), 
                         box(title= 'Chart 2', plotOutput("found1", height = 200, width= 550)),
                         box(title= 'Chart 3', plotOutput("found2", height = 200, width= 550)),
                         box(title= 'Chart 4', plotOutput("found3", height = 200, width= 550)),
                         box("Chart 1 and 2 - Here I calculated the time difference by year between the Model Year
                             and Recall Year and counted how many times a recall occured in that time. It looks like
                             most recalls occur 4 years after the Model Year. I would recommend someone that is interested
                             in a car to wait least 4 years after the Model Year, to reduce the chance of having a car with a recall"),
                         box("Chart 3- This looks at the amount of recalls that have happened with each new Model Year. Recalls have increased 
                             greatly during the 2000s, but start to go down in the 2010s. It looks like the NHTSA created stricter
                             guidelines for safety as years go by, but in the 2010s, companies start to take safety more
                             seriously. It is safe to say that cars are getting more increasingly safe as time goes by."),
                         box("Chart 4 - This shows the top companies that have the most frequent recalls, so these are companies
                             to be aware of when looking into a new car.")
                         
                     )),
                        
                        
            tabItem(tabName = "home",
                    h2("Analysis on Vehicle Recalls"),
                    br(),
                    strong(p('Sidebar Tabs')),
                    p("- Dataset- This is the complete dataset that I used for my project."),
                    p("- Recalls and Manufacturers- This a bar chart where you can see the top
                      10 manufactuers with the most recalls for a selected recall component."),
                    p("- Recall Component History- This a line chart that shows the most recalls for a selected 
                    recall component was over the years."),
                    p("- Findings- I share some of my analysis"),
                    br(),
                    br(),
                    strong(p('Background')),
                    p('The dataset used contains 10000s of vehicle-related recalls from 1966-2016.
                    This Shiny app provides analysis on this dataset, and visit:', a('https://www.kaggle.com/nhtsa/safety-recalls'))
                    
                           
            
            )
        )
    )

)