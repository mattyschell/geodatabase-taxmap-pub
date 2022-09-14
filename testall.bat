REM executes from ArcGIS Pro conda environment
SET DBUSER=DEVSCHEMA
SET DBPASS=ILuvEsri247
SET DB=DEVDB
CALL c:\Progra~1\ArcGIS\Pro\bin\Python\scripts\propy.bat .\src\py\test_tilemill.py 
CALL sqlplus %DBUSER%/"%DBPASS%"@%DB% @src/sql_oracle/testall.sql
