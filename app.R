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