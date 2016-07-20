#import all of the libraries
library(leaflet)
library(jsonlite)
library(shiny)


#shapefiles will work in R, but it is recommended that you convert
#shapefiles to GeoJSON files.  To do this, open QGIS, "Save As..." your
#shapefile and change the type to GeoJSON.

#Gets GeoJSON from local machine and names it "MyGeojson"
MyGeojson <- readLines("D:\\LearnR\\GeoJSON_Durham\\Durham.geojson", warn = FALSE) %>%
  paste(collapse = "\n") %>%
  fromJSON(simplifyVector = FALSE)


#Defines the style properties of MyGeoJSON
MyGeojson$style = list(
  weight = 1,
  #Pink color:
  color = "#F8BBD0",
  opacity = 1,
  fillOpacity = 0.7
)

#leaflet() %>% addGeoJSON(geojson)




shinyServer(function(input, output, session) {
  
  #Name your leaflet map - NorthCarolina...
  #this will be referenced in the ui.R
  map <- createLeafletMap(session, "NorthCarolina")
  
  session$onFlushed(once=TRUE, function() {
    map$addGeoJSON(MyGeojson)   
  })
  
  
  values <- reactiveValues(selectedFeature = NULL)
  
  observe({
    evt <- input$map_click
    if (is.null(evt))
      return()
    
    isolate({
      # An empty part of the map was clicked.
      # Null out the selected feature.
      values$selectedFeature <- NULL
    })
  })
  
  observe({
    evt <- input$map_MyGeojson_click
    if (is.null(evt))
      return()
    
    isolate({
      # A GeoJSON feature was clicked. Save its properties
      # to selectedFeature.
      values$selectedFeature <- evt$properties
    })
  })
  
  #Name the output (MyMap)...this will be referenced in ui.R
  #########I THINK THIS IS WHERE I NEED TO CHANGE TO renderLEAFLET
  #https://rstudio.github.io/leaflet/shiny.html
  # output$MyMap <- renderLeaflet( {
  #   leaflet() %>% addGeoJSON(geojson)
  #   
  # })
  output$MyMap <- renderText({
    # Render values$selectedFeature, if it isn't NULL.
    if (is.null(values$selectedFeature))
      return(NULL)

    as.character(tags$div(
      tags$h3(values$selectedFeature$name),
      tags$div(
        "Population:",
        values$selectedFeature$population
      )
    ))
  })
})
###########################


#Need next line of code to run shiny
#shinyApp(ui, server)