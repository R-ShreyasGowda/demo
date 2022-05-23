create or replace procedure for_loop as
begin
for i in reverse 1..5 loop
dbms_output.put_line(i);
end loop;
end;

exec for_loop;

create or replace procedure for_loop as
begin
for i in 1..5 loop
dbms_output.put_line(i);
end loop;
end;

exec for_loop;

create or replace procedure for_loop as
begin
for i in 1..50 loop
if mod(i,2)=0 then
dbms_output.put_line(i);
end if;
end loop;
end;

exec for_loop;

create or replace procedure for_loop as
begin
for i in 1..50 loop
if mod(i,2)=1 then
dbms_output.put_line(i);
end if;
end loop;
end;

exec for_loop;

create or replace procedure while_loop as
start_dt date;
end_dt date;
begin
start_dt:=trunc(sysdate,'yy');
end_dt:=add_months(start_dt,12)-1;
while start_dt<=end_dt loop
dbms_output.put_line(start_dt);
start_dt:=start_dt+1;
end loop;
end;


exec while_loop;

create or replace procedure rank as
begin
for i in (select ename
from(select ename,sal,dense_rank()over(order by sal desc)rnk
from emp)a
where a.rnk<=50) loop
dbms_output.put_line(i.ename);
end loop;
end;

exec rank

begin
rank;
end;

create or replace procedure a_h_n(p_id accounts_t.a_no%type)as
p_nm c_a_t.cust_name%type;
begin
select cust_name into p_nm 
from c_a_t c,accounts_t t
where c.cust_bkey=t.cust_bkey
and a_no=p_id;
dbms_output.put_line('p_nm');
exception
when no_data_found then
dbms_output.put_line('invalid account number');
end;

exec a_h_n(1111);

set serveroutput on

create or replace procedure value_err as
salary emp.sal%type;
begin
select ename into salary
from emp
where empno=7788;
exception
when value_error then
dbms_output.put_line('storing in wrong variable');
end;

exec value_err;

create or replace procedure value_err as
salary emp.sal%type;
begin
select ename into salary
from emp
where empno=7788;
exception
when value_error then
dbms_output.put_line('storing in wrong variable');
end;

exec value_err;

create or replace procedure value_err as
salary emp.sal%type;
begin
select ename into salary
from emp
where empno='abc';
exception
when invalid_number then
dbms_output.put_line('invalid data');
end;

exec value_err;

--if denominator is 0 then zero_divide not on quotient--

create or replace procedure zero_div(p_no number) as
v_res number(5);
begin
v_res :=p_no/0;
exception
when zero_divide then
dbms_output.put_line('zero divide error');
when others then
dbms_output.put_line(sqlcode ||' '||sqlerrm);
end;

exec zero_div(10); 

select * from emp;

create or replace procedure dup_val as
begin
insert into emp(empno,ename) values(7369,'shreyas');
exception
when dup_val_on_index then
dbms_output.put_line('duplicate value cannont insert');
end;

create or replace procedure dup_val as
begin
insert into emp(empno,ename) values(7369,'shreyas');
exception
when dup_val_on_index then
dbms_output.put_line('sqlcode||''||sqlerrm');
end;

exec dup_val;
