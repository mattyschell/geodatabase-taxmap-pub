import os
import arcpy
import cx_sde

class Pointmill(object):

    def __init__(self
                ,sdeconn
                ,rawinputtable = 'TAX_LOT_FACE'
                ,hoppertable   = 'TAX_LOT_FACE_SDO'
                ,pointtable    = 'TAX_LOT_FACE_POINT'):

        self.sdeconn       = sdeconn
        self.rawinputtable = self.sdeconn + "/" + rawinputtable
        self.hoppername    = hoppertable
        self.hoppertable   = self.sdeconn + "/" + hoppertable
        self.pointname     = pointtable
        self.pointtable    = self.sdeconn + "/" + pointtable            

    def deletehopper(self):

        if arcpy.Exists(self.hoppertable):

            # locks?
            arcpy.Delete_management(self.hoppertable)

    def getboroblocks(self
                     ,days):

        sql = """select distinct boro_block from 
                    (SELECT DISTINCT
                            SUBSTR (a.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_air_rights a, dab_wizard_transaction w
                        WHERE a.trans_num = w.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (t.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_boundary_line b,
                            dab_wizard_transaction w,
                            dab_tax_lots t
                        WHERE b.trans_num = w.trans_num AND b.trans_num = t.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (c.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_condo_conversion c, dab_wizard_transaction w
                        WHERE c.trans_num = w.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (c.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_condo_units c, dab_wizard_transaction w
                        WHERE c.trans_num = w.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (r.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_reuc r, dab_wizard_transaction w
                        WHERE r.trans_num = w.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (s.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_subterranean_rights s, dab_wizard_transaction w
                        WHERE s.trans_num = w.trans_num
                    UNION
                    SELECT DISTINCT
                            SUBSTR (t.bbl, 1, 6) AS boro_block,
                            w.change_date AS change_date
                        FROM dab_tax_lots t, dab_wizard_transaction w
                        WHERE t.trans_num = w.trans_num)
                where change_date > (current_date - {0}) """.format(days)

        boroblocks = cx_sde.selectacolumn(self.sdeconn,
                                          sql)

        return boroblocks
    
    def getwhereclause(self,
                       days):

        boroblocks = self.getboroblocks(days)

        whereclause = ""

        for i, boroblock in enumerate(boroblocks):

            #ex 100009
            whereclause += " (boro = '{0}' and block = {1}) ".format(boroblock[0:1]
                                                                    ,str(int(boroblock[1:6])))
            if i < len(boroblocks)-1:
                whereclause += " or "

        return whereclause

    def refillhopper(self
                    ,days):

        whereclause = self.getwhereclause(days)

        # print(whereclause)

        # default geom storage is sdo
        arcpy.conversion.FeatureClassToFeatureClass(self.rawinputtable
                                                   ,self.sdeconn
                                                   ,self.hoppername
                                                   ,whereclause)

    def remillpoints(self
                     ,days):

        boroblocks = self.getboroblocks(days)

        for boroblock in boroblocks:

            sql = "delete from {0} where bbl like '{1}%'".format(self.pointname
                                                                ,boroblock)
            # print(sql)

            cx_sde.execute_immediate(self.sdeconn
                                    ,sql)

            sql  = """insert into {0} (""".format(self.pointname)    
            sql +=  """    objectid """
            sql +=  """   ,bbl """
            sql +=  """   ,lot_face_length """
            sql +=  """   ,azimuth """
            sql +=  """   ,shape) """
            sql +=  """ select """
            sql +=  """    tax_lot_face_point_seq.nextval """
            sql +=  """   ,a.bbl """
            sql +=  """   ,a.lot_face_length """
            sql +=  """   ,geodatabase_taxmap_pub.sdo_azimuth(a.shape) """
            sql +=  """   ,SDO_LRS.CONVERT_TO_STD_GEOM( """
            sql +=  """                SDO_LRS.LOCATE_PT( """
            sql +=  """                        SDO_LRS.CONVERT_TO_LRS_GEOM(a.shape, 0, 100) """
            sql +=  """                                ,50) """
            sql +=  """                ) """
            sql +=  """from """
            sql +=  """    {0} a """.format(self.hoppername)
            sql +=  """where """
            sql +=  """    GEODATABASE_TAXMAP_PUB.quarantine_face(a.shape) = 'FALSE' """
            sql += """ and a.bbl like '{0}%' """.format(boroblock)

            # print(sql)
            cx_sde.execute_immediate(self.sdeconn
                                    ,sql)
            
    def millfreshpoints(self
                       ,days):

        self.deletehopper()   
        self.refillhopper(days)  
        self.remillpoints(days)                 


                              
                                    



                    