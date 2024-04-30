library('move2')
library('sf')
library('dplyr')

## The parameter "data" is reserved for the data object passed on from the previous app

# to display messages to the user in the log file of the App in MoveApps
# one can use the function from the logger.R file:
# logger.fatal(), logger.error(), logger.warn(), logger.info(), logger.debug(), logger.trace()

# Showcase injecting app setting (parameter `year`)
rFunction = function(data, pts=TRUE, seg=TRUE, lins=TRUE, file.name="moveapps_data", ...) {
  
  ## move all track associated attributes to the event table
  data_allattrb <- mt_as_event_attribute(data, names(mt_track_data(data)))
  ## drop all attributes that are all NA
  data_allattrb <- data_allattrb %>% select(where(~ !(all(is.na(.)))))
  
  data_allattrb_seg <- data_allattrb
  data_allattrb_seg$segments <- mt_segments(data_allattrb_seg)
  data_allattrb_seg <-data_allattrb_seg %>%  dplyr::filter(st_geometry_type(data_allattrb_seg$segments) == "LINESTRING") # as the last one is a point, this has to be removed or it cannot be saved with st_write()
  st_geometry(data_allattrb_seg) <- data_allattrb_seg$segments ## making the segments the geometry of the object
  
  ## one line per track
  data_lines <- mt_track_lines(data) # returns one line per track, track attrb are kept
  
  ### Save as KML, points and lines, standard layout (should be improved)
  if (pts==TRUE) sf::st_write(data_allattrb, dsn = appArtifactPath(paste0(file.name,"_points.kml")), driver="kml", delete_layer = TRUE)
  if (seg==TRUE) sf::st_write(data_allattrb_seg, dsn=appArtifactPath(paste0(file.name,"_segments.kml")), driver="kml", delete_layer = TRUE)
  if (lins==TRUE) sf::st_write(data_lines, dsn=appArtifactPath(paste0(file.name,"_lines.kml")), driver="kml", delete_layer = TRUE)
  
  # provide my result to the next app in the MoveApps workflow
  return(data)
}
