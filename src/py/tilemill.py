import os
import arcpy

class Tilemill(object):

    def __init__(self
                ,project):

        self.projectfile = project
        self.project = arcpy.mp.ArcGISProject(self.projectfile)

        # add more than one map at your own risk 
        self.map = self.project.listMaps()[0]
        self.mapname = self.map.name            

    def createtiles(self
                   ,outputfile
                   ,index):

        try:
            arcpy.CreateVectorTilePackage_management(self.map
                                                    ,outputfile
                                                    ,"ONLINE"
                                                    ,"" # tiling_scheme NA
                                                    ,"INDEXED"
                                                    ,"" # min_cached_scale
                                                    ,"" # max_cached_scale
                                                    ,index
                                                    ,"" #summary
                                                    ,"" #tags
                                                    )
        except:
            # plan for more here
            raise ValueError('failed creating {0}'.format(outputfile))
        finally:
            self.package = outputfile

    def deletetiles(self):

        if self.package:
            os.remove(self.package)


                    