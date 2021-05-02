col attr1 format a5
col attr2 format a15
col message  format a55
set echo on
select attr1, attr2, message from dba_advisor_findings f, dba_advisor_objects o where f.task_name = o.task_name and f.object_id = o.object_id and f.task_name = 'my_seg_task';
