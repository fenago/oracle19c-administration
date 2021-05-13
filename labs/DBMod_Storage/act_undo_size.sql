SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MB]"
   FROM (SELECT SUM(a.bytes) undo_size
	FROM v$datafile a,
		v$tablespace b,
		dba_tablespaces c
	WHERE c.contents = 'UNDO'
	AND c.status = 'ONLINE'
	AND b.name = c.tablespace_name
	AND a.ts# = b.ts#) d ;
