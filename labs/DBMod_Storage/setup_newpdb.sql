host mkdir -p /u01/app/oracle/oradata/ORCLCDB/newpdb
set echo on
ALTER PLUGGABLE DATABASE newpdb CLOSE ;
DROP PLUGGABLE DATABASE newpdb INCLUDING DATAFILES;
CREATE PLUGGABLE DATABASE newpdb ADMIN USER admin IDENTIFIED BY fenago ROLES=(CONNECT)
  CREATE_FILE_DEST='/u01/app/oracle/oradata/ORCLCDB/newpdb';
alter PLUGGABLE DATABASE newpdb open;
CONNECT system/fenago@//localhost:1521/newpdb
set echo on
SELECT property_name, property_value 
FROM database_properties
WHERE property_name LIKE 'DEFAULT_%TABLE%';
