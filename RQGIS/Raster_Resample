#GOAL:  Create a finer raster.  You have a raster that has a cell size of 29.033, and 
#this script will create a cell size of 10.

#Another note: Wilmington and Raleigh rasters were projected and have a 
#cell size of 29.033.

#Raster data
Wilm <- raster("data/Wilington.tif")

#View cell size of original raster(Wilm).  Resultion gives you the cell size.
Wilm

#View original DEM
plot(Wilm)

#Find out the different types of resample tools you can use
find_algorithms(search_term = "resampl", qgis_env = my_env)

#Set the parameters to grass7:r.resample
paramRESAMPLE <- get_args_man(alg = "grass7:r.resample", qgis_env = my_env)

#View the parameters you need to set
paramRESAMPLE

#Set the first parameter to the DEM raster
paramRESAMPLE$input <- Wilm
#Leave "GRASS_REGION_PARAMETER" blank because you want to use the min covering extent
#Specify the cell size parameter
paramRESAMPLE$GRASS_REGION_CELLSIZE_PARAMETER <- 10
#The output tif will be located here:
paramRESAMPLE$output <- file.path("D:/LearnR", "Wilm_Res.tif")

#Name an object and run the tool.  First name the algarithym to the tool, specify
#the parameters to the parameters you set, name the output file in the parameters,
#and set the qgis environment to your environment.
ResultRESAMPLE <- run_qgis(alg = "grass7:r.resample",
                           params = paramRESAMPLE,
                           load_output = paramRESAMPLE$output,
                           qgis_env = my_env)

#View the map, but nothing looks that different....
plot(ResultRESAMPLE)

#So view the ResultRESAMPLE properties and see that the cell size is now 10.
ResultRESAMPLE
