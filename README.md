# KML Map Output

MoveApps

Github repository: *github.com/movestore/KML-output*

## Description
A small App to explore your tracks with kml files. Each track is presented as a line and individual locations can be laid on top.

## Documentation
Using the R-package `plotKML` this App creates for each track a kml file of the locations as points and one overview kml of all tracks as lines (in colours by individual).

Download the files and open them locally in Google Earth. They can be opened together in Google Earth for overlaying and better exploration. A timeslider for the point files allows to show only points of a specified time interval.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
`ptsID.kml`: google earth kml file for each individual track. The locations are presented as points with underlying information about ID and timestamp. A timeslider allows to show only part of the points. The file(s) can be opened together with `trajectories.kml` in Google Earth for overlay and data exploration.

`trajectories.kml`: google earth kml file of all individual tracks as lines. Each track has a different colour and can be disabled from view in google earth.

### Parameters 
none.

### Null or error handling:
**Data:** The data are not manipulated, but empty input with no locations (NULL) leads to an error. For calculations in further Apps the input data set is returned.