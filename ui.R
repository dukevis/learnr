#To make a shiny app you'll need 2 R scripts:
#1. ui.R - user interface codes; control layout/appearance here
#2. server.R - computation/statistcal analysis code; you'll make your map here


 # #import all of the libraries
# library(leaflet)
# library(shiny)


 #create a Shiny user interface and reference the name of the map you used in
 #the server.R script (in this case, "NorthCarolina")
 shinyUI(fluidPage(
  #numbers are length by width of map
   leafletMap("NorthCarolina", 600, 400, options = list(
    #set the center of your mapping using lat/long coordinates
     center = c(36.002958, -78.903466),
     #set the zoom level - on a 1-17 scale
     #1 = full zoom out, 17 = full zoom in
    zoom = 9
  )),
   #References the output MyMap in server.R
   htmlOutput("MyMap")
 ))

