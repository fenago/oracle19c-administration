DECLARE
tname VARCHAR2(128) := 'my_seg_task';
tname_desc VARCHAR2(128) := 'Get shrink advice for segments in TBSALERT';
task_id NUMBER;
object_id NUMBER;
objectname VARCHAR2(100);
objecttype VARCHAR2(100);
BEGIN
dbms_advisor.create_task('Segment Advisor', task_id, tname, tname_desc, NULL);
dbms_advisor.create_object(tname, 'TABLESPACE','TBSALERT', ' ', ' ', NULL, ' ', object_id);
dbms_advisor.set_task_parameter(tname, 'RECOMMEND_ALL', 'TRUE');
END;
/

