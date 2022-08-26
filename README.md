# geodatabase-taxmap-pub

From New York City Digital Taxmap versioned feature classes in an ESRI Enterprise Geodatabase on Oracle 19c, publish vector tiles to ArcGIS Online.  Friends, these are our versioned feature classes published to vector tiles, our rules, the trick is never to be afraid.

## High level

* Create an ArcGIS Pro project with default taxmap layers
* Style the layers in ArcGIS Pro to match NYC legacy Geoserver tiles
* Deploy the project to a server
* Automate tile package generation and publishing

## Output

Temporarily: https://arcg.is/LKLGf

## Data Prep

1. Convert tax_lot_face to tax_lot_face_sdo

2. Populate tax_lot_face_point

(first time only) Set up tax_lot_face_point table.

```
sqlplus dof_taxmap/iluvesri247@db @src/sql_oracle/setup.sql
```




## Tests

```
>testall.bat
```





