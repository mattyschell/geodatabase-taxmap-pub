create table tax_lot_face_point (
    objectid            integer primary key
   ,bbl                 varchar2(10)
   ,lot_face_length     number 
   ,azimuth             number(3,0) check(azimuth >= 0 
                                    and   azimuth <= 360
                                    and   azimuth is not null) 
   ,shape               mdsys.sdo_geometry
);
insert into user_sdo_geom_metadata  
    (table_name
    ,column_name
    ,srid
    ,diminfo) 
values
    ('TAX_LOT_FACE_POINT'
    ,'SHAPE'
    ,2263
    ,sdo_dim_array (mdsys.sdo_dim_element ('X', 900000, 1090000, .0005)
                   ,mdsys.sdo_dim_element ('Y', 110000, 295000, .0005)
                   )
            );
create index 
    tax_lot_face_pointsidx
on
    tax_lot_face_point (shape)
indextype is 
    mdsys.spatial_index;
grant select on 
    tax_lot_face_point 
to 
    MAP_VIEWER;
@src/sql_oracle/geodatabase_taxmap_pub.sql
insert /*+ APPEND */ into tax_lot_face_point (
    objectid
   ,bbl
   ,lot_face_length
   ,azimuth
   ,shape)
select
    a.objectid
   ,a.bbl
   ,a.lot_face_length
   ,geodatabase_taxmap_pub.sdo_azimuth(a.shape)
   ,SDO_LRS.CONVERT_TO_STD_GEOM(
                SDO_LRS.LOCATE_PT(
                        SDO_LRS.CONVERT_TO_LRS_GEOM(a.shape, 0, 100)
                                ,50)
                )
from 
    tax_lot_face_sdo a
where 
    GEODATABASE_TAXMAP_PUB.quarantine_face(a.shape) = 'FALSE';
commit;
begin
    dbms_stats.gather_schema_stats(user);
end;
/
EXIT

