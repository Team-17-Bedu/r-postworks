# Postwork 8- Equipo 17
library(ggplot2)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Postwork 8 - Equipo 17"),

    # Sidebar Panel
    sidebarPanel(
        p("Goles por equipo"), 
        selectInput("x", "Seleccione equipo local o visitante",
                    choices = c("Goles Local"= "home.score","Goles Visitante" = "away.score")),
    ),
#**************************************************************************************************
    mainPanel(tabsetPanel(              
                             tabPanel("Plots",   #Inicio Plots 
                             plotOutput("output_plot"),
                                        ),# Fin Tabpanel plot
                                        
                             tabPanel("Probabilidad Marginal",  #Inicio Gráficas Postwork 3
                                      h3("Probabilidad Marginal equipo local"),
                                        img(src = "Sesion-03-plt-1.png", 
                                        height = 450, width = 550),
                                      h3("Probabilidad Marginal equipo visitante"),
                                        img( src = "Sesion-03-plt-2.png", 
                                        height = 450, width = 550),
                                      h3("Probabilidades conjuntas"),
                                        img( src = "Sesion-03-plt-3.png", 
                                        height = 450, width = 550)
                                        ), #Fin tabpanel Gráficas Postwork 3
                                     
                              tabPanel("Table Match", dataTableOutput("data_Table")),#Data Table
                              
                             tabPanel("Factor de Ganancia",  #Inicio Factores de ganancia
                                      h3("Factor de ganancia Maximo"),
                                      img(src = "momio_maximo.png", 
                                          height = 350, width = 550),
                                      h3("Factor de ganancia Promedio"),
                                      img( src = "momio_promedio.png", 
                                           height = 350, width = 550)
                                      
                             ), #Fin tabpanel Gráficas factores de ganancia
                             
                                       
                              tabPanel("Table", tableOutput("table")) ##EXTRA como prueba           
                        )## FIN1 tabsetPanel
            )#Fin tabsetPanel
) # FIn UI


#*************************************************************************************************
#*************************************************************************************************
#***************************************SERVIDOR *************************************************
#*************************************************************************************************
#*************************************************************************************************
# Inicio de Servidor
server <- function(input, output) {

    datasetImput <- reactive(
        switch(input$dataset, 
               "away.team" = away.team, 
               "home.team" = home.team)
    )
    
    #Gráfica primera pestaña                      
    output$output_plot <- renderPlot({
        data <-  read.csv("match.data.csv", header = T)
        x <- data[,input$x]
        data %>% ggplot(aes(x, fill = "RED")) + 
            geom_bar() + 
            facet_wrap("away.team", scales = "free") +
            labs(x =input$x, y = "Goles Anotados") + 
            ylim(0,76)
      
    })
   
    # Agregando el dataframe       <---------- Para Table como prueba
    output$table <- renderTable({ 
        data.frame(match.table)
    })
    
    #Agregando el data table       <---------- DataTable
    output$data_table <- renderDataTable({match.table}, 
                                         options = list(aLengthMenu = c(5,25,50),
                                                        iDisplayLength = 5))
    
    
} #//FIN Server

##Carga del archivo Match.table
setwd("C:/Users/abraham/Documents/DATASCIENCE/2daetapa/prueba/Postwork8")
match.table <- read.csv("match.data.csv")

# Run the application 
shinyApp(ui = ui, server = server)
