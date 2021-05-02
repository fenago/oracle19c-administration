exec testpga(500000);

column COMP format a20

select substr(COMPONENT, 0, 20) COMP, CURRENT_SIZE CS, USER_SPECIFIED_SIZE US from v$memory_dynamic_components where CURRENT_SIZE!=0;

select substr(COMPONENT, 0, 20) COMP, FINAL_SIZE, OPER_TYPE, OPER_MODE, status from v$memory_resize_ops order by START_TIME;

