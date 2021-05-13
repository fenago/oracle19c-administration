set echo on
create user source_user identified by fenago;
grant dba to source_user;
create table source_user.bigtab (label varchar2(30));
begin
for i in 1..10000 loop
insert into source_user.bigtab values ('DATA FROM source_user.bigtab');
commit;
end loop;
end;
/
exit
