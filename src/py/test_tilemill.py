import unittest
import os
import pathlib

import tilemill


class ImporterTestCase(unittest.TestCase):

    @classmethod
    def setUpClass(self):
        

        self.srcproj = os.path.join(pathlib.Path(__file__).parent.resolve()
                                  ,'resources'
                                  ,'dummy'
                                  ,'dummy.aprx')

        self.tempdir = os.environ['TMP']

        #C:...\geodatabase-taxmap-pub\src\py\resources\dummy\dummy.gdb\dummyindex
        self.tileindex = os.path.join(pathlib.Path(__file__).parent.resolve()
                                     ,'resources'
                                     ,'dummy'
                                     ,'dummy.gdb'
                                     ,'dummyindex')

        self.miller = tilemill.Tilemill(self.srcproj)

    @classmethod
    def tearDownClass(self):
        
        self.miller.deletetiles()

    def tearDown(self):
        pass

    def test_aproducetiles(self):

        # https://pro.arcgis.com/en/pro-app/latest/tool-reference/data-management/create-vector-tile-package.htm

        #print('dropping dummypackage.tpk at ' + self.tempdir)
        self.miller.createtiles(os.path.join(self.tempdir
                                            ,'dummypackage.vtpk')
                                ,self.tileindex)



if __name__ == '__main__':
    unittest.main()