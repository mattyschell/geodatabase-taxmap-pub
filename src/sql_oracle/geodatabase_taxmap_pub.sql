CREATE OR REPLACE PACKAGE GEODATABASE_TAXMAP_PUB
AUTHID CURRENT_USER
AS

   FUNCTION quarantine_face (
      p_shape      IN MDSYS.SDO_GEOMETRY
   ) RETURN VARCHAR2;

END GEODATABASE_TAXMAP_PUB;
/
CREATE OR REPLACE PACKAGE BODY GEODATABASE_TAXMAP_PUB
AS

   FUNCTION quarantine_face (
      p_shape      IN MDSYS.SDO_GEOMETRY
   ) RETURN VARCHAR2
   AS

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

END GEODATABASE_TAXMAP_PUB;
/
