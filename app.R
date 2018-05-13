library(shiny)
library(promises)
library(future)

plan(multisession)

long_running <- function(delay, value) {
  Sys.sleep(delay)
  value
}

moduleUI <- function(id, delay, sync) {
  ns <- NS(id)
  
  tagList(
    column(3, 
           actionButton(ns("btn"), paste(delay, sync)),
           verbatimTextOutput(ns("txt"))
    )
  )
}

module <- function(input, output, session, delay, sync) {
  observeEvent(input$btn, {
    output$txt <- renderPrint( {
      if (sync) {
        long_running(delay, runif(1))
      } else {
        future(long_running(delay = delay, runif(1))) %...>% 
          print() 
      }
    })
  })
}

ui <- fluidPage(
  moduleUI("m1", 0, "synch"),
  moduleUI("m2", 10, "synch"),
  moduleUI("m3", 2, "asynch"),
  moduleUI("m4", 10, "asynch")
)

server <- function(input, output, session) {
  callModule(module, id = "m1", session = session, delay = 0, sync = T)
  callModule(module, id = "m2", session = session, delay = 10, sync = T)
  callModule(module, id = "m3", session = session, delay = 2, sync = F)
  callModule(module, id = "m4", session = session, delay = 10, sync = F)
}

shinyApp(ui, server)