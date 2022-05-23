--1.display month name wise no of transactions in the last three years-- 
 
select count(txn_id), to_char(sysdate,'mm')
from tran
where to_char(txn_date,'yy')>to_char(trunc(sysdate,'yy'))-3
group by  to_char(sysdate,'mm');

--2.display the customer names who have their email in gamil--

select cust_name
from customer
where email like '%gmail%';


alter table customer add dob date;

update customer set dob='3-jun-2022' where cust_bkey =102;

update customer set dob='16-sep-2019' where cust_bkey =103;

update customer set dob='30-jan-2020' where cust_bkey =104;

update customer set dob='23-aug-2021' where cust_bkey =105;

select * from customer;

--3.display the youngest customer name in each city--

select cust_name 
from customer
where (dob,city) in (select max(dob),city
                     from customer
                     group by city);

--4.display the city names that have more number of customers than the city HYD--

select city,count(cust_bkey)
from customer
group by city
having count(cust_bkey)>(select count(cust_bkey)
                         from customer
                         where city = 'HYD'
                         group by city);
                         
--5.display the city name wise no of accounts opened in the current YTD and the previous YTD--

select city,count(case when to_char(act_open_date,'yy')=to_char(sysdate,'yy') then a_no
                  end)CYTD,
            count(case when to_char(act_open_date,'yy')=to_char(sysdate,'yy')-1 then a_no
                  end)PYTD
from customer c,accounts_t a
where c.cust_bkey=a.cust_bkey
group by city;

select * from accounts_t;
                         
--6.display the state wise no of accounts and no of transactions in the current year--

select c.state,count(a.a_no),count(t.txn_id)
from customer c,accounts a,tran t
where c.cust_bkey=a.cust_bkey
and a.a_no=t.a_no
and to_char(t.txn_date,'yy')=to_char(sysdate,'yy')
group by c.state;

-- 7.display the customer names who have more no of accounts than the customer MIKE--

select cust_name,count(a_no)
from customer c,accounts_t a
where c.cust_bkey=a.cust_bkey
group by cust_name
having count(a_no)>(select count(a_no)
                    from customer c,accounts_t a
                    where c.cust_bkey=a.cust_bkey
                    and cust_name='MIKE'
                    group by cust_name);

--8.display the account type wise no of customers and no of accounts opened in the current year--

select a.act_type,count(a.a_no),count(c.cust_bkey)
from customer c,accounts_t a
where c.cust_bkey=a.cust_bkey
and to_char(a.act_open_date,'yy')=to_char(sysdate,'yy')
group by a.act_type;


select * from customer;

select * from accounts_t;

--9.display customers who have only savings account--

select cust_name,count(a_no)
from customer c,accounts_t a
where c.cust_bkey=a.cust_bkey
and act_type='savings'
group by cust_name
having count(a_no)=1;

select * from tran;

--10.display the customer name wise total withdraw and deposit amounts in the current month.the t_type column differentiates the amounts--

select cust_name,sum(case when txn_type='withdraw' then fcy_amt
                  end)withdraw,
            sum(case when txn_type='deposit' then lcy_amt
                  end)deposit
from customer c,accounts_t a,tran t
where c.cust_bkey=a.cust_bkey
and a.a_no=t.a_no
group by cust_name;