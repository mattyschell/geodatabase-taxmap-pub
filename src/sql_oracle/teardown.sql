delete from 
    user_sdo_geom_metadata
where
    table_name = 'TAX_LOT_FACE_POINT';
drop table tax_lot_face_point;
drop package geodatabase_taxmap_pub;
EXIT