drop database faculty;
create database faculty;
use faculty;
create table student(snum integer primary key, sname varchar(30), major varchar(30), lvl varchar(30), age integer);
desc student;
create table faculty(fid integer primary key, fname varchar(30), deptid integer);
create table class(cname varchar(30) primary key, meets_at timestamp, room varchar(30), fid integer, foreign key(fid) references faculty(fid));
desc class;
create table enrolled(snum integer, cname varchar(30), primary key(snum,cname), foreign key(snum) references student(snum), foreign key (cname) references class(cname));
desc enrolled;
desc faculty;

insert into student values(1,'John','CS','Sr',19);
insert into student values(2,'Smith','CS','Jr',20);
insert into student values(3,'Jacob','CV','Sr',20);
insert into student values(4,'Tom','CS','Jr',20);
insert into student values(5,'Rahul','CS','Jr',20);
insert into student values(6,'Rita','CS','Sr',21);

insert into faculty values(11,'Harish',1000);
insert into faculty values(12,'MV',1000);
insert into faculty values(13,'Mira',1001);
insert into faculty values(14,'Shiva',1002);
insert into faculty values(15,'Nupur',1000);

insert into class values('class1','15/11/12 10:15:16','R1',14);
insert into class values('class10','15/11/12 10:15:16','R128',14);
insert into class values('class2','15/11/12 10:15:20','R2',12);
insert into class values('class3','15/11/12 10:15:25','R3',11);
insert into class values('class4','15/11/12 20:15:20','R4',14);
insert into class values('class5','15/11/12 20:15:20','R3',15);
insert into class values('class6','15/11/12 13:20:20','R3',15);
insert into class values('class7','15/11/12 10:10:10','R3',14);

insert into enrolled values(1,'class1');
insert into enrolled values(2,'class1');
insert into enrolled values(3,'class3');
insert into enrolled values(4,'class3');
insert into enrolled values(5,'class4');
insert into enrolled values(1,'class5');
insert into enrolled values(2,'class5');
insert into enrolled values(3,'class5');
insert into enrolled values(4,'class5');
insert into enrolled values(5,'class5');

commit;
select * from student;
select * from enrolled;
select * from faculty;
select * from class;
/*query 1: all sudents who have title jr who is taught by harish*/
select distinct  s.sname from student s, faculty f, class c, enrolled e where s.snum=e.snum and E.cname=C.cname and c.fid=f.fid and f.fname='Harish'and s.lvl='Jr' ;

/*query 2: names of all classes in room 128 or have five or more students enrolled*/
select distinct c.cname from student s, faculty f, class c, enrolled e where c.room='R128' or c.cname in(select e.cname from enrolled e group by e.cname having count(*)>=5);

/*query 3:*/
select distinct s.sname from student s where s.snum in(select e1.snum from enrolled e1,enrolled e2, class c1, class c2 where  e1.snum=e2.snum and e1.cname<>e2.cname and e1.cname=c1.cname and e2.cname=c2.cname and c1.meets_at=c2.meets_at);

/*query 4
select distinct f.fname from student s, faculty f, class c where not exists(( select c.room from class c) minus (select c1.room from class c1 where c1.fid=f.fid));*/

/*query 5*/
select f.fname from faculty f where 5>(select count(e.snum) from class c, enrolled e where c.cname=e.cname and c.fid=f.fid);

/*query 6*/
select distinct s.sname from student s where s.snum not in (select e.snum from enrolled e);

/*query 7*/
select s.age, s.lvl from student s group by s.age , s.lvl having s.lvl in(select s1.lvl from student s1 where s1.age=s.age group by s1.lvl,s1.age having count(*)>=ALL(select count(*) from student s2 where s1.age=s2.age group by s2.lvl,s2.age));

