REM chnage this one
set SDEFILE=C:\xxx\xxxxxxxx\xxxxx\xxx\xxxx\xxxx.sde
REM review the rest
set DAYS=365
set PROPY=c:\Progra~1\ArcGIS\Pro\bin\Python\envs\arcgispro-py3\python.exe
set BASEPATH=C:\gis
set TAXPUBREPO=%BASEPATH%\geodatabase-taxmap-pub
set PYTHONPATH=%TAXPUBREPO%\src\py;PYTHONPATH%
CALL %PROPY% %TAXPUBREPO%\samplepointmill.py %DAYS%
