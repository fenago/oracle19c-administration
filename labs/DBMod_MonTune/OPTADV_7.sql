DECLARE
v_len NUMBER(10);
v_offset NUMBER(10) :=1;
v_amount NUMBER(10) :=10000;
BEGIN
v_len := DBMS_LOB.getlength(:b_report);
WHILE (v_offset < v_len)
LOOP
DBMS_OUTPUT.PUT_LINE(DBMS_LOB.SUBSTR(:b_script, v_amount, v_offset));
v_offset := v_offset + v_amount;
END LOOP;
END;
/
