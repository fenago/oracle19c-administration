Select (TO_NUMBER(e.value) * TO_NUMBER(f.value) *
g.undo_block_per_sec) / (1024*1024)
"NEEDED UNDO SIZE [MB]"
FROM V$PARAMETER e, V$PARAMETER f,
(SELECT MAX(undoblks/((end_time-begin_time)*3600*24)) undo_block_per_sec
	FROM v$undostat) g
WHERE e.name = 'undo_retention'
AND f.name = 'db_block_size';
