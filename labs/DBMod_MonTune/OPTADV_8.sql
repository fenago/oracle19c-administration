VARIABLE b_ret CLOB
DECLARE
v_tname VARCHAR2(32767);
BEGIN
v_tname := 'my_task';
:b_ret := DBMS_STATS.IMPLEMENT_ADVISOR_TASK(v_tname);
END;
/
