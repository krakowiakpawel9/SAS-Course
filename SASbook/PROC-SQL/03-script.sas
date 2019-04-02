/*GLOBAL STATEMENT, SESSION MANAGEMENT*/
/*SETUP TABLE*/
proc sql;
	create table twelves as
		select 
			name as fname, 
			sex, 
			height, 
			weight 
		from sashelp.class
			where age=12;
quit;

proc sql;
	title "Weight Minima by Sex";
	select 
		sex, 
		min(weight) 
	from twelves 
		group by sex;
	title;
quit;

/*FEEDBACK STIMER - gives time processing in logs*/
proc sql feedback stimer;
	select 
		sex, 
		min(weight) 
	from twelves 
		group by sex;
quit;

/*OUTOBS - limit the number of observations*/
proc sql outobs=2;
	select
		fname, 
		sex, 
		weight 
	from twelves;
quit;

/*MACRO FACILITY*/
data wide;
	input id $ m1-m4;
	cards;
A 11 12 13 14
B 21 22 23 24
;
run;

proc summary data=wide;
	var m1-m4;
	output out=sums(drop= _freq_ _type_) sum = sum1-sum4;
run;

data sums;
	set wide end=last;
	array _measure(*) m1-m4;
	array _sum(*) sum1-sum4;
	keep sum1-sum4;

	do i = 1 to 4;
		_sum(i) + _measure(i);
	end;

	if last then
		output;
run;

proc sql;
	create table sum as
		select 
			sum(m1) as sum1,
			sum(m2) as sum2,
			sum(m3) as sum3,
			sum(m4) as sum4
		from wide;
quit;

proc sql;
	create table sums as
		select %select(maxindex=4)
			from wide;
quit;

%MACRO select(maxindex=);
	%DO n = 1 %TO &maxindex;
		SUM(m&n) as Sum&n
			%IF &n NE &maxindex %THEN ,
		;
	%END;
%MEND select;

%macro selected(max=);
	%do i = 1 %to &max;
		sum(m&i) as sum&i 
			%if &i ne &max %then ,
		;
	%end;
%mend selected;

proc sql;
	select %selected(max=4) from wide;
quit;

proc sql;
	select %selected(max=2) from wide;
quit;

proc sql;
	create table thirteen as
		select 
			name as fname,
			height format=6.1,
			weight format=6.1
		from sashelp.class
			where age = 13;
quit;

data _null_;
	set thirteen end=lastobs;
	heightsum + height;

	if lastobs then
		call symput('avgheight', put(heightsum / _n_, 4.1));
run;

proc sql;
	select * from wide;
quit;

proc sql;
	insert into wide
		set id = 'C',
			m1 = 10,
			m2 = 20,
			m3 = 30,
			m4 = 40;
	select * from wide;
quit;

proc print data=thirteen;
run;

/*Insert row with data step*/
data thirteen;
	fname = 'pawel';
	weight = 90;
	height = 185;
	output;
	stop;
	modify thirteen;
run;

proc sql;
	select * from thirteen;
quit;

proc sql;
	insert into thirteen
		values ('Tomek', 85 180);
	select * from thirteen;
quit;

/*INSERTING ALL TABLES*/
proc sql;
	create table short as 
		select * from sashelp.class where age = 13;
quit;

proc sql;
	insert into newly
		select * from short;
quit;

proc sql;
	select * from newly;
quit;

proc sql;
	create table newly like short;
quit;

/*CREATE TABLE*/
proc sql;
	create table paylist 
		(
		ID char(4), 
		Gender char(1), 
		JobCode char(3), 
		Salary num, 
		Birth num informat=date7. format=date7., 
		Hired num informat=date7. format=date7.
		);
	insert into paylist 
		values
			('1639', 'F', 'TA1', 42300, '26JAN2010'd, '01JAN2019'd);
quit;

proc sql;
	insert into paylist 
		values ('1639', 'F', 'TA1', ., '26JAN2010'd, '01JAN2019'd)
		values ('1640', 'M', 'TA1', 40300, '26JAN2018'd, '01JAN2019'd)
		values ('1640', 'M', null, 40300, '26JAN2018'd, '01JAN2019'd)
	;
quit;

proc sql;
	select * from paylist;
quit;

/*deleting rows*/
data paylist;
	modify paylist;
	where ID = '1639';
	remove;
run;

proc sql;
	delete from paylist where JobCode=' ';
quit;

proc sql;
	create table deletions
		(
		Fname char(10)
		);
	insert into deletions 
		values ('pawel')
		values ('Tomek')
	;
	select * from deletions;
quit;

proc sql;
	delete from thirteen 
		where fname in (select fname from deletions);
quit;

proc sql;
	select * from thirteen;
quit;

/*Modification*/
proc sql;
	create table five as
		select * from sashelp.class
			where age > 13;
quit;

data five;
	modify five;

	if fname='Janet' then
		do;
			height = 64;
			replace;
		end;

	if fname='William' then
		do;
			weight = 118;
			replace;
		end;
run;

proc sql;
	select * from five;
quit;

proc sql;
	update five
		set weight=190 
			where name = 'Janet';
	update five
		set height=100
			where name='William';
quit;

proc sql;
	select * from five;
quit;

proc sql;
	alter table five
		modify name char(12)
	drop age, height, weight
		add DoB date label='Date of Birth';
quit;

proc sql;
create index age on five;
quit;

proc print data=five;
by age;
run;

proc sql;
describe table five;
quit;

proc sql;
describe table constraints five;
quit;

proc sql;
	create view v_eleven_sql as
	select name, sex, age from sashelp.class
	where age > 13;
quit;

proc print data=v_eleven_sql;
run;
