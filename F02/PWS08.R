#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(shinydashboard)
library(shinythemes)
library(dplyr)
library(ggplot2)


# Define UI for application that draws a histogram  
ui <- fluidPage(
    # Application title
    titlePanel("Resultados del PostWork #8"),
    theme = shinytheme("simplex"),
    dashboardPage(
        dashboardHeader(title = "Opciones"),
        
        dashboardSidebar(
            sidebarMenu(
                menuItem("Graficas de barras, goles de local-visitante", tabName = "p1", icon = icon("chart-bar")),
                menuItem("Postwork 3", tabName = "p2", icon =icon("save")),
                menuItem("Data Table", tabName = "p3", icon = icon("table")),
                menuItem("Grafica de Factores de ganancia", tabName = "p4", icon =icon("chart-line") )
            )
        ),
        dashboardBody(
            tabItems(
                #P1
                tabItem(tabName = "p1",
                        fluidRow(
                            titlePanel("Grafico de barras de goles local-visitante"), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = c("home.score", "away.score")),
                            plotOutput("plot", height = 450, width = 650)
                        )
                ),
                #SP2
                tabItem(tabName = "p2", 
                            titlePanel("Graficas de probabilidades de goles"),
                            p("Grafica para las probabilidades marginales estimadas del numero de goles que anota el equipo de casa"),
                            img( src = "3.png", 
                                 height = 450, width = 450),
                            p("Grafica para probabilidades marginales estimadas del numero de goles que anota el equipo visitante"),
                            img( src = "4.png", 
                                 height = 450, width = 450),
                            p("HeatMap para las probabilidades conjuntas estimadas de los numeros de goles que anotan el equipo de casa y el equipo 
                            visitante en un partido"),
                            img( src = "5.png", 
                                 height = 450, width = 450)
                            
                            
                )
                ,
                #P3
                tabItem(tabName = "p3",
                        fluidRow(        
                            titlePanel(h3("Data Table de match.data.csv")),
                            dataTableOutput ("Match_Data")
                        )
                ), 
                #P4
                tabItem(tabName = "p4",
                            titlePanel("Factores de ganacia del archivo momios.R"),
                            p("Grafica con momios Maximos"),
                            img( src = "1.png", 
                                 height = 450, width = 450),
                            p("Grafica con momios Normales"),
                            img( src = "2.png", 
                             height = 450, width = 450)
                            
                            
                )
            )
        )
    )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
    output$plot = renderPlot({
        data = read.csv("../match.data.csv", header = T)
        
        data = mutate(data, FTR = ifelse(home.score > away.score, "H", ifelse(home.score < away.score, "A", "D")))
        x = data[,input$x]
        
        data %>% ggplot(aes(x, fill = FTR)) + 
            geom_bar() + 
            facet_wrap("away.team") +
            labs(x = input$x, y = "Goles") + 
            ylim(0,50)
    })

    
    output$Match_Data = renderDataTable( {read.csv("../match.data.csv")}, 
    )
    
}

# Run the application 
shinyApp(ui, server)
