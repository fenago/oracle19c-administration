SELECT SUBSTR(e.value,1,25) "UNDO RETENTION [Sec]"
FROM v$parameter e
WHERE e.name = 'undo_retention'
