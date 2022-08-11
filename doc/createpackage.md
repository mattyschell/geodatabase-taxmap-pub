* Map must contain only simple feature classes (point, multipoint, line, and polygon).
* Map metadata must be set.
* Map must use the WGS 1984 Web Mercator Auxiliary Sphere coordinate system.
* Map must use the ArcGIS Online / Bing Maps / Google Maps tiling scheme.
* Only the following simple symbologies are supported:
Single Symbol
Unique Value
Graduated Colors
Graduated Symbols


    === Tax Block Polygon ===

Block Polygon Symbol (level 7 - 10)
stroke">#B0B0B0
stroke-width">3
Block Polygon Symbol (level 5 - 6)
stroke">#B0B0B0
stroke-width">1     


Check geometry - one invalid
Repair geometry - Fixed 1 and updated extent

Map Properties - name FinanceBasemap
    Metadata Tab
NYC Department of Finance Digital Taxmap Basemap
NYC Basemap Finance Tax
Basemap of the NYC Department of Finance Digital Taxmap
This map contains the NYC Department of Finance Digital Taxmap basemap
New York City Office of Technology and Innovation - Application Development - Geographic Information Systems
None friend
    Coordinate Systems Tab
WGS 1984 Web Mercator (auxiliary sphere)

Set Scale Levels
At the bottom of the map, click the scale list down arrow and choose Customize.
In the Scale Properties dialog box, click Load.
Select ArcGIS Onine/Bing/etc

    Style tax_block_polygon
Select Tax_Block_Polygon
Click "feature layer" tab (formerly Appearance)
Out beyond: 1577791 (equivalent of 6?)
Feature layer - click big orange symbology button
Outline color - grey 30%
click enable scale based labeling
Made some stops, 1pt/3pt this thing is confusing
No labels for now (from points)


    Style tax_block_polygon labels
Select tax_block_polygon
Click labeling tab
Check the big label button on the left
(skipped the rest)

    Create vector tile index
Find create vector tile index tool
Output to a geodatabase
    (I assume usually you would want a local gdb for performance?)
Remove it from the map

    Create vector tiles
Create Vector Tile Package tool

    Share package
Find share package tool




