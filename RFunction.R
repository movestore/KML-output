library('move')
library('spacetime')
library('plotKML')
library('plotrix')

rFunction <- function(data)
{
  Sys.setenv(tz="UTC")
  
  ###  create space time object
  sp_dat <- SpatialPoints(coordinates(data),proj4string=CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +towgs84=0,0,0"))
  sp_temp_all <- STIDF(sp_dat, timestamps(data), as.data.frame(data))
  
  # prepare html.table
  sp_temp_all@data$date_time_attr <- paste("DateTime:", sp_temp_all@data$timestamp, sep = " ")
  sp_temp_all@data$ID_attr <- paste("ID:", sp_temp_all@data$trackId, sep = " ")
  
  # kml
  shape <- "http://maps.google.com/mapfiles/kml/pal2/icon18.png" #like this or with file in MOveApps?
  
  ids <- as.character(unique(sp_temp_all@data$trackId))
  #col <- sapply(rainbow(n=length(ids)),color.id)

  
  for (i in seq(along=ids)) 
  {
    sp_temp_single_ID <- sp_temp_all[sp_temp_all@data$trackId == ids[i],]
    
    attributes_sub <- paste(sp_temp_single_ID@data$ID_attr, sp_temp_single_ID@data$date_time_attr, sep = "; ")

    # night roost points 
    kml_open(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"),sprintf("pts%s.kml", ids[i])))
    #kml_open(sprintf("pts%s.kml", ids[i]) )
    
    kml_layer(sp_temp_single_ID, 
              colour="red",#cannot make this colour variable with parameter col[i]
              shape = shape, 
              points_names = "",
              size = 0.7,
              match.ID = FALSE, 
              html.table = attributes_sub)
    
    #kml_close(sprintf("pts%s.kml", ids[i]) )
    kml_close(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"),sprintf("pts%s.kml", ids[i])))
    
    sp_temp_single_ID <- vector()
    
  }
  
  
  #################################################
  #### create trajectories - add lines
  
  all_lines <- name_info <- list()
  data.split <- move::split(data)
  ids_l <- names(data.split)
  
  for (j in seq(along=ids_l)) {
    datai <- data.split[[j]]
    line_class <- Line(coordinates(datai))
    
    all_lines[[j]] <- Lines(line_class, ID=ids_l[j])
    name_info[[j]] <- ids_l[j]
    
    line_class <- vector()
  }
  
  name_info_df <- as.data.frame(unlist(name_info))
  names(name_info_df) <- "ID"           
  
  row.names(name_info_df) <- name_info_df$ID
  
  spLin_dat <- SpatialLines(all_lines)
  spLindf_dat <- SpatialLinesDataFrame(spLin_dat, name_info_df)
  proj4string(spLindf_dat) <- CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +towgs84=0,0,0")
  
  #kml_open("trajectories.kml")
  kml_open(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"),"trajectories.kml"))
  kml_layer.SpatialLines(spLindf_dat, subfolder.name = paste(class(spLindf_dat)), colour=ID, width=3)
  #kml_close("trajectories.kml")
  kml_close(paste0(Sys.getenv(x = "APP_ARTIFACTS_DIR", "/tmp/"),"trajectories.kml"))
  
  result <- data
  return(result)
}

  
  
  
  
  
  
  
  
  
  
