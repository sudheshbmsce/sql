drop database airlines;
create database airlines;
use airlines;
create table flights(flno int,ffrom varchar(15) not null,tto varchar(15) not null,distance int,departs timestamp,arrives timestamp,price int,primary key(flno));
desc flights;
create table aircraft(aid int,aname varchar(10),cruisingrange int,primary key(aid));
drop table aircraft;
desc aircraft;
create table employees(eid int,ename varchar(15),salary int,primary key(eid));
desc employees;
create table certified(eid int not null, aid int not null,primary key(eid,aid),foreign key(eid) references employees(eid),foreign key(aid) references aircraft(aid));
desc certified;
insert into aircraft values(101,'747',3000);
insert into aircraft values(102,'boeing',900);
insert into aircraft values(103,'647',800);
insert into aircraft values(104,'dreamliner',10000);
insert into aircraft values(105,'boeing',3500);
insert into aircraft values(106,'707',1500);
insert into aircraft values(107,'dream',120000);
select * from  aircraft;
insert into  employees values(701,'A',50000);
insert into  employees values(702,'B',100000);
insert into  employees values(703,'C',150000);
insert into  employees values(704,'D',90000);
insert into  employees values(705,'E',40000);
insert into  employees values(706,'F',60000);
insert into  employees values(707,'G',90000);
commit;
SELECT *from employees;
insert into certified values(701,101);
insert into certified values(701,102);
insert into certified values(701,106);
insert into certified values(701,105);
insert into certified values(702,104);
insert into certified values(703,104);
insert into certified values(704,104);
insert into certified values(702,107);
insert into certified values(703,107);
insert into certified values(704,107);
insert into certified values(702,101);
insert into certified values(703,105);
insert into certified values(704,105);
insert into certified values(705,103);
commit;
select * from certified;


SELECT DISTINCT a.aname
FROM aircraft a,certified c,employees e
    WHERE a.aid=c.aid
    AND c.eid=e.eid
    AND NOT EXISTS
    (SELECT *
    FROM employees e1
     WHERE e1.eid=e.eid
    AND e1.salary<80000);
   
     SELECT c.eid,MAX(cruisingrange)
     FROM certified c,aircraft a
     WHERE c.aid=a.aid
    GROUP BY c.eid
    HAVING COUNT(*)>3;
   
    SELECT DISTINCT e.ename
     FROM employees e
    WHERE e.salary<
    (SELECT MIN(f.price)
     FROM flights f
    WHERE f.ffrom='Bangalore'
    AND f.tto='Frankfurt');
       
SELECT a.aid,a.aname,AVG(e.salary)
    FROM aircraft a,certified c,employees e
    WHERE a.aid=c.aid
AND c.eid=e.eid
AND a.cruisingrange>1000
GROUP BY a.aid,a.aname;
   
   
    SELECT distinct e.ename
     FROM employees e,aircraft a,certified c
     WHERE e.eid=c.eid
     AND c.aid=a.aid
    AND a.aname='Boeing';

 SELECT a.aid
     FROM aircraft a
     WHERE a.cruisingrange>
    (SELECT MIN(f.distance)
    FROM flights f
    WHERE f.ffrom='Bangalore'
    AND f.tto='Delhi');

        

