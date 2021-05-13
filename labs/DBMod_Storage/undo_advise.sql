col "ACTUAL UNDO SIZE [MByte]" for 999999999
col "UNDO RETENTION [Sec]" for a20
col "NEEDED UNDO SIZE [MB]" for 99.99

SELECT d.undo_size/(1024*1024) "ACTUAL UNDO SIZE [MB]",
SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]",
(TO_NUMBER(e.value) * TO_NUMBER(f.value) *
g.undo_block_per_sec) / (1024*1024)
"NEEDED UNDO SIZE [MB]"
FROM (SELECT SUM(a.bytes) undo_size
	FROM v$datafile a,
		v$tablespace b,
		dba_tablespaces c
	WHERE c.contents = 'UNDO'
	AND c.status = 'ONLINE'
	AND b.name = c.tablespace_name
	AND a.ts# = b.ts#) d,
v$parameter e,
v$parameter f,
(SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
	FROM v$undostat) g
WHERE e.name = 'undo_retention'
AND f.name = 'db_block_size';
