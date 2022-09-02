CREATE OR REPLACE PACKAGE GEODATABASE_TAXMAP_PUB
AUTHID CURRENT_USER
AS

   FUNCTION quarantine_face (
      p_shape      IN MDSYS.SDO_GEOMETRY
   ) RETURN VARCHAR2;

   FUNCTION sdo_azimuth (
       p_shape     IN MDSYS.SDO_GEOMETRY
   ) RETURN NUMBER;

   FUNCTION bearing (
      lat1          IN NUMBER
     ,long1         IN NUMBER
     ,lat2          IN NUMBER
     ,long2         IN NUMBER
   ) RETURN NUMBER;


END GEODATABASE_TAXMAP_PUB;
/
CREATE OR REPLACE PACKAGE BODY GEODATABASE_TAXMAP_PUB
AS

   FUNCTION quarantine_face (
      p_shape      IN MDSYS.SDO_GEOMETRY
   ) RETURN VARCHAR2
   AS

        --mschell! 20220828

        testgeom        mdsys.sdo_geometry;

   BEGIN

        testgeom := SDO_LRS.CONVERT_TO_STD_GEOM( 
                            SDO_LRS.LOCATE_PT( 
                                    SDO_LRS.CONVERT_TO_LRS_GEOM(p_shape
                                                               ,0
                                                               ,100) 
                                      ,50)
                            );

        RETURN 'FALSE';

    EXCEPTION 
    WHEN OTHERS THEN

        RETURN 'TRUE';

   END quarantine_face;


   FUNCTION sdo_azimuth (
       p_shape     IN MDSYS.SDO_GEOMETRY
   ) RETURN NUMBER
   AS

        -- mschell! 20220901
        -- attempt to mimic st_azimuth
        -- wrapper to bearing

        -- in our universe we have tax_lot_face segments
        -- where any angle change results in a new record.
        -- So we are OK to take the first and last vertex
        -- without consideration for other configurations
        
        startp      mdsys.sdo_geometry;
        endp        mdsys.sdo_geometry;

    BEGIN

        --convert start,end to lat/lon

        startp := sdo_cs.transform(
                    sdo_geometry(2001 
                                ,p_shape.sdo_srid 
                                ,SDO_POINT_TYPE(sdo_util.GetFirstVertex(p_shape).X
                                               ,sdo_util.GetFirstVertex(p_shape).Y
                                               ,NULL)
                                ,NULL
                                ,NULL)
                    ,4326);

        endp := sdo_cs.transform(
                    sdo_geometry(2001 
                                ,p_shape.sdo_srid 
                                ,SDO_POINT_TYPE(sdo_util.GetLastVertex(p_shape).X
                                               ,sdo_util.GetLastVertex(p_shape).Y
                                               ,NULL)
                                ,NULL
                                ,NULL)
                    ,4326);
       
        --be sure to reverse inputs to bearing (y,x)

        return GEODATABASE_TAXMAP_PUB.bearing(startp.sdo_point.Y
                                             ,startp.sdo_point.X
                                             ,endp.sdo_point.Y
                                             ,endp.sdo_point.X);

    END sdo_azimuth;

   FUNCTION bearing (
      lat1          IN NUMBER
     ,long1         IN NUMBER
     ,lat2          IN NUMBER
     ,long2         IN NUMBER
   ) RETURN NUMBER
   AS

        -- mschell! 20220901
        -- but the real author is Mr. Haversine
        -- https://stackoverflow.com/questions/3932502/calculate-angle-between-two-latitude-longitude-points
        -- You've got to be kidding me haversine is half a versed sine?
        -- The haversine function computes half a versine of the angle θ.
        -- (versine = versed sine)
        -- To solve for the distance d, apply the archaversine 
        -- (inverse haversine) to h = hav(θ) or use the arcsine (inverse sine) function:

        dlon        NUMBER;
        y           NUMBER;
        x           NUMBER;
        bearing     NUMBER;

   BEGIN

        --dbms_output.put_line('long1: ' || long1); 
        --dbms_output.put_line('long2: ' || long2); 

        dlon := long2 - long1; 

        -- return 0 for points, polygons, 0-length lines
        if dlon = 0
        then
           return 0;
        end if;

        --dbms_output.put_line('dlon ' || dlon);
        
        y := sin(dlon) * cos(lat2);
        x := cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dlon);

        dbms_output.put_line('y: ' || y); 
        dbms_output.put_line('x: ' || y);

        bearing := atan2(y,x);

        bearing := SDO_UTIL.CONVERT_UNIT(bearing
                                        ,'Radian'
                                        ,'Degree');
        
        bearing := mod((bearing + 360), 360);
        --> is 270 now for example

        --flips clockwise
        bearing := 360 - bearing; 

        return bearing;

   END bearing;


END GEODATABASE_TAXMAP_PUB;
/
