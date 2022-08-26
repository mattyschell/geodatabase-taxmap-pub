
## Data Management 

1. What is the best way to deal with invalid geometries?  Fix in source (not currently an option) or somehow fix on the fly?  This gets into possible ETL machinations again.

Theoretically none are invalid in the taxmap geodatabase.  Will need to think about other datasets though - streets, landmass, etc.

## Styles

1. Is it possible to use scale-based sizing on the labels of a feature layer?

Maybe using label classes?
https://pro.arcgis.com/en/pro-app/latest/help/mapping/text/label-classes.htm



## Automation 

1. Where should the index be stored for re-use?  In the database?  A local geodatbase with the ArcGIS Pro project

Local seems OK.

2. In geoserver styles were stored in xml and could be version controlled, shared, and deployed.  How to meet this requirement with an ArcGIS Pro project as the styler?

3. Does an ArcGIS Pro project contain sensitive info?  Can I drop it into version control and any VM I like?

I am pointing the connections at a relative connections folder path for now.  

4. How does one reshare a web layer when share package won't allow a reload to the same layer?  Delete and re-share?  Can the web layer be a view?

