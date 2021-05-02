set echo on
ALTER PLUGGABLE DATABASE pdb_source_for_hotclone close;
DROP PLUGGABLE DATABASE pdb_source_for_hotclone INCLUDING DATAFILES;
exit
