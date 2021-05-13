VAR b_report CLOB
DECLARE
v_tname VARCHAR2(32767);
BEGIN
v_tname := 'my_task';
:b_report := dbms_stats.report_advisor_task(v_tname, type => 'TEXT', section => 'ALL', level => 'ALL');
END;
/
