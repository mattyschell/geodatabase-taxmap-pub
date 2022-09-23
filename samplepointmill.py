import sys
import os
import logging
import datetime

import pointmill

# SET PYTHONPATH=C:\gis\geodatabase-taxmap-pub\src\py

if __name__ == "__main__":

    days          = sys.argv[1]
    targetsdeconn = os.environ['SDEFILE']
    
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger(__name__)

    logger.info('started remilling {0} days of points at {1}'.format(days
                                                                     ,datetime.datetime.now()))

    miller = pointmill.Pointmill(targetsdeconn)

    miller.millfreshpoints(days)

    logger.info('completed remilling {0} days of points at {1}'.format(days
                                                                      ,datetime.datetime.now()))

