#RQGIS package allows users to use tools from QGIS.

#Find available tools here:
#C:\Program Files\QGIS 2.14\apps\qgis\python\plugins\processing\algs\qgis
#C:\Program Files\QGIS 2.14\apps\qgis\python\plugins\GdalTools\tools
#C:\Program Files\QGIS 2.14\apps\qgis\python\plugins\processing\algs\grass\description

#install RQGIS package
install.packages("rgeos")
library(RQGIS)
library(raster)
library(rgdal)
library(maptools)
library(rgeos)

#Set your environment to the file location of QGIS on your computer
my_env <- set_env("C:/Program Files/QGIS 2.14")

#Ensure my_env is set to the correct location
my_env

#Since you want to set qt4, python27, grass, and msys folder add the following code
####ALSO NOTE: You may have to create a new empty folder named msys in the apps folder
my_env$qt4 <- "C:\\Program Files\\QGIS 2.14\\apps\\Qt4"
my_env$python27 <- "C:\\Program Files\\QGIS 2.14\\apps\\Python27"
my_env$grass <- "C:\\Program Files\\QGIS 2.14\\apps\\grass"
my_env$msys <- "C:\\Program Files\\QGIS 2.14\\apps\\msys"

#Search for function names.  Change the search term as needed.  It will 
#provide the folder name and name of the tool that you will use below.
find_algorithms(search_term = "add", qgis_env = my_env)
