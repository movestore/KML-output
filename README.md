# Write KML

MoveApps

Github repository: *github.com/movestore/KML-output*

## Description
A small App to explore your tracks with kml files. It is possible to obtain a file with points, lines segments and track lines.

## Documentation
Using the R-package `sf` (st_write) this App creates for each track a kml file of the locations as points, line segments or track lines.

Download the files and open them locally in Google Earth. They can be opened together in Google Earth for overlaying and better exploration. A timeslider for the point files allows to show only points of a specified time interval.

### Input data
move2 location object		

### Output data
move2 location object

### Artefacts
`file.name_points.gpkg`: kml file containing all tracking data as lines per track of the input data set.

`file.name_segments.gpkg`: kml file containing all tracking data as lines per track of the input data set.

`file.name_lines.gpkg`: kml file containing all tracking data as lines per track of the input data set.

### Settings 
**File name (`file.name`):** Provide a file name for the kml file (optional). If none is provided, "moveapps_data" is used.

**Points shapefile (`pts`):** Select if you want to obtain the kml file with points of the locations. Default TRUE

**Line segments shapefile (`seg`):** Select if you want to obtain the kml file with line segments between your locations. Default FALSE

**Track lines shapefile (`lins`):** Select if you want to obtain the kml file with full track lines. Default FALSE

### Most common errors
Please make an issue in this Github repository.

### Null or error handling:
**Data:** The data are not manipulated, but empty input with no locations (NULL) leads to an error. For calculations in further Apps the input data set is returned.
