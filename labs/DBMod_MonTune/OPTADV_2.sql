DECLARE
v_tname VARCHAR2(128) := 'my_task';
v_ename VARCHAR2(128) := NULL;
v_report CLOB := null;
v_script CLOB := null;
v_implementation_result CLOB;
BEGIN
v_tname :=DBMS_STATS.CREATE_ADVISOR_TASK(v_tname);
sh_obj_filter(v_tname);
v_ename := DBMS_STATS.EXECUTE_ADVISOR_TASK(v_tname);
END;
/
