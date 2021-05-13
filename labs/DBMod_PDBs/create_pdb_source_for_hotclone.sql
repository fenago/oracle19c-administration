set echo on
ALTER PLUGGABLE DATABASE pdb_source_for_hotclone close;
DROP PLUGGABLE DATABASE pdb_source_for_hotclone INCLUDING DATAFILES;

ALTER SESSION SET db_create_file_dest='/u01/app/oracle/oradata/ORCLCDB/pdb_source_for_hotclone';
CREATE PLUGGABLE DATABASE pdb_source_for_hotclone 
    ADMIN USER admin IDENTIFIED BY fenago  ROLES=(CONNECT)
    FILE_NAME_CONVERT =('/u01/app/oracle/oradata/ORCLCDB/pdbseed','/u01/app/oracle/oradata/ORCLCDB/pdb_source_for_hotclone');
ALTER PLUGGABLE DATABASE pdb_source_for_hotclone open;
exit
