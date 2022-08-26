create table tax_lot_face_point (
    objectid            number primary key
   ,bbl                 varchar2(10)
   ,lot_face_length     number
   ,azimuth             number
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