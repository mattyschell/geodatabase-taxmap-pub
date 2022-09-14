select 
    'north 360' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,940000
                                                       ,180000))
        )) 
    when 
        360 --because of distortion it is 359.x
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual
union all
select 
    'north 0' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,940020
                                                       ,180000))
        )) 
    when 
        0 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual
union all
select 
    'east 90' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,940000.1
                                                       ,170000))
        )) 
    when 
        90 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual
union all
select 
    'south 180' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,940000
                                                       ,169999))
        )) 
    when 
        180 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual
union all
select 
    'west 270' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,939999
                                                       ,170000))
        )) 
    when 
        270 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual
union all
select 
    'extra points' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2002
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1,2,1)
                              ,mdsys.sdo_ordinate_array(940000
                                                       ,170000
                                                       ,939999
                                                       ,170000
                                                       ,939997
                                                       ,170000
                                                       ,939990
                                                       ,170000
                                                       ))
        )) 
    when 
        270 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual  
union all
select 
    'a point 0' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2001
                              ,2263
                              ,SDO_POINT_TYPE(940000
                                             ,170000
                                             ,NULL)
                              ,NULL
                              ,NULL)
        )) 
    when 
        0 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual     
union all
select 
    'a polygon 0' as test
    ,case 
        round(
        geodatabase_taxmap_pub.sdo_azimuth(
            mdsys.sdo_geometry(2003
                              ,2263
                              ,NULL
                              ,mdsys.sdo_elem_info_array(1, 1003, 1)
                              ,mdsys.sdo_ordinate_array(940005
                                                       ,170001
                                                       ,940008
                                                       ,170001
                                                       ,940008
                                                       ,170006
                                                       ,940005
                                                       ,170007
                                                       ,940005
                                                       ,170001))
        )) 
    when 
        0 
    then 
        'pass'
    else 
        'fail'
    end as result 
from dual;     
