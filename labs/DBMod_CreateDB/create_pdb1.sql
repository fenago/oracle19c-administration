set echo on
ALTER PLUGGABLE DATABASE PDB1 CLOSE ;
DROP PLUGGABLE DATABASE PDB1 INCLUDING DATAFILES;
!mkdir /u01/app/oracle/oradata/ORCLCDB/pdb1
CREATE PLUGGABLE DATABASE PDB1 
ADMIN USER admin IDENTIFIED BY fenago  ROLES=(CONNECT)
  FILE_NAME_CONVERT=('/u01/app/oracle/oradata/ORCLCDB/pdbseed','/u01/app/oracle/oradata/ORCLCDB/pdb1');
alter PLUGGABLE DATABASE PDB1 open;

exit

