#GOAL:  Clip points shapefile to a polygon

#Import a polygon shapefile of MS and AL and a tornado point shapefile
#that includes the entire US
MS_AL = readOGR(dsn = "data/MS_AL.shp", layer = "MS_AL")
TornPt = readOGR(dsn = "data/Tornado.shp", layer = "Tornado")
TornLns = readOGR(dsn = "data/TornLns.shp", layer = "TornLns")

#View the original points and polygons
plot(MS_AL)
plot(TornPt, pch = 21, add = TRUE, bg = "red", col = "black")

#Use get_arg_man to get arguments for a specific tool.  Set the alg to the folder (QGIS)
#and the specific tool.  Then set the environment containing the paths to 
#run QIGS API to "my_env"
params <- get_args_man(alg = "qgis:intersection", qgis_env = my_env)

#You can view what you need to write from the tool in the Environment tab
params$INPUT <- TornPt
params$INPUT2 <- MS_AL
params$OUTPUT <- file.path("D:/LearnR", "output.shp")

#Run the tool.  
result <- run_qgis(alg = "qgis:intersection",
                   params = params,
                   load_output = params$OUTPUT,
                   qgis_env = my_env)

#plot the tool
plot(MS_AL)
plot(result, pch = 21, add = TRUE, bg = "red", col = "black")
