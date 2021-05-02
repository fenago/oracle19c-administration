set echo on
begin
for i in 1..5000 loop
insert into test.bigtab values ('NEW DATA during relocation');
dbms_lock.sleep(1);
commit;
end loop;
end;
/
exit
