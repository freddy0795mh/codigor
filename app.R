

library(shiny)
library(DT)
library(dplyr)
library(readxl)

library(MASS)


p1 <- read_excel("./0001.xls", col_names = T)
p2 <- read_excel("./0002.xls", col_names = T)
p3 <- read_excel("./0016.xls", col_names = T)
p4 <- read_excel("./0017.xls", col_names = T)
p5 <- read_excel("./0018.xls", col_names = T)
p6 <- read_excel("./0024.xls", col_names = T)
p7 <- read_excel("./0068.xls", col_names = T)
p8 <- read_excel("./0104.xls", col_names = T)
p9 <- read_excel("./0129.xls", col_names = T)
p10 <- read_excel("./0131.xls", col_names = T)
p11 <- read_excel("./1001.xls", col_names = T)
p12 <- read_excel("./1002.xls", col_names = T)

combine1 <- full_join(p1,p2)


combine2 <- full_join(p3,p4)


combine3 <- full_join(p5,p6)


combine4 <- full_join(p7,p8)


combine5 <- full_join(p9,p10)


combine6 <- full_join(p11,p12)


combine7 <- full_join(combine1, combine2)

combine8 <- full_join(combine3, combine4)

combine9 <- full_join(combine5, combine6)


combine10 <- full_join(combine7, combine8)


consolidado <- full_join(combine9, combine10) 


ui <- fluidPage(


  
    titlePanel("KIT_EJECUCION_2023"),
    
    #sidebarLayout( 
      
      
      #sidebarPanel( width = 2,
         
             #selectInput("FilterColumn","Filtrar Columna", choices = names(consolidado[,4:20])),
             
            # textInput("FilterValue","Ingresar Valor  Columna"
                  
                   #  )
                        
       #    ),
        
     
          mainPanel( 
          
          
          datos <- DT::dataTableOutput("datos") 
          
          
                 
            )
        
        
   # )
    )
         
server <- function(input, output) {
  
 
    #output$datos<- DT::renderDataTable(consolidado[,4:20] # %>%
    #filter((!! rlang::sym(input$FilterColumn )) == input$FilterValue)
  #)
    
  output$datos<- DT::renderDataTable(
    DT::datatable({
      
      consolidado[,4:20] %>% arrange(Progr.) 
      
     },
 
 extensions = 'Buttons', options = list(dom = 'Bfrtip',buttons = list(c('copy', 'csv', 'excel', 'pdf', 'print'))),
 filter = "top",
 selection = 'multiple',
 style = 'bootstrap',
    
    )
  )
  #****************
    #options =  list(lengthMenu = list(c(7,15,-1), c('5','15','ALL')), pageLength = 15),
    #filter = "top",
    #selection = 'multiple',
    #style = 'bootstrap',
   
  }

shinyApp(ui = ui, server = server)
