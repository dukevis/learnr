library(shiny)
library(ggplot2)
library(dplyr)

# Loading the movies dataset

# may need to set working directory to the place where these files are located 
# before RStudio will know where to find the data file
# In RStudio, go to Session --> Set Working Directory --> Choose Directory...

movies <- read.csv("movies.csv", stringsAsFactors = FALSE)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
    
    # Application title
    titlePanel("Exploring movies"),
    
    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            
            # Select y-variable
            selectInput("y",
                        "Y-axis:",
                        choices = c("imdb_rating",
                                    "imdb_num_votes",
                                    "critics_score",
                                    "audience_score",
                                    "runtime"),
                        selected = "audience_score"),
            
            # Select x-variable
            selectInput("x",
                        "X-axis:",
                        choices = c("imdb_rating",
                                    "imdb_num_votes",
                                    "critics_score",
                                    "audience_score",
                                    "runtime"),
                        selected = "critics_score"),

            # Select a categorical variable to color by
            selectInput("color",
                        "Color by:",
                        choices = c("title_type",
                                    "genre",
                                    "mpaa_rating",
                                    "critics_rating",
                                    "audience_rating")),
            # Select alpha level
            sliderInput("alpha",
                        "Change the transparency:",
                        min = 0,
                        max = 1,
                        value = 0.7),
            
            hr(),
            
            # Select sample size
            sliderInput("sample",
                        "Sample size:",
                        min = 1,
                        max = nrow(movies),
                        value = nrow(movies))
            
            
        ),
        mainPanel(
            plotOutput("distPlot")
        )
    )    
    
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output){
    
    # create a new data frame which is a sample of size n from movies
    movies_subset <- reactive({
        
        movies %>%
            sample_n(input$sample)
        
    })

    output$distPlot <- renderPlot({
        
        #ggplot(data = movies_subset(), aes_string(x = input$x, y = input$y, color = input$color)) + 
        #    geom_point(alpha = input$alpha) + 
        #    theme_bw()

        ggplot(data = sample_n(movies,input$sample), aes_string(x = input$x, y = input$y, color = input$color)) + 
            geom_point(alpha = input$alpha) + 
            theme_bw()
        
                
    })
})

# Run the application
shinyApp(ui = ui, server = server)