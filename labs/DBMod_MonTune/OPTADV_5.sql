col MESSAGE format a70
col BENEFIT_TYPE format a70
SELECT f.finding_id, f.message, r.benefit_type FROM user_advisor_findings f, user_advisor_recommendations r WHERE f.finding_id = r.finding_id AND f.task_name = 'MY_TASK' AND f.execution_name = 'EXEC_165';
