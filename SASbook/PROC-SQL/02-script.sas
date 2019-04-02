/*SUBQUERIES*/
proc sql;
	select name from sashelp.class where age > 12;
quit;

proc sql;
	create table class_girls as
		select * from sashelp.class(rename=(name=Fname))
			where sex = 'F';
quit;

data more_girls;
	input Fname$ Age;
	cards;
Susan 16
Jane 12
Abigail 13
Zelda 16
;
run;

proc sql;
	create table already as
		select * from more_girls
			where exists (select * from class_girls where more_girls.fname = class_girls.fname);
quit;

proc sql;
	create table already as
		select * from more_girls
			where exists (select 'Hello world' from class_girls where more_girls.fname = class_girls.fname);
quit;

proc sql;
	create table alred as
		select * 
			from more_girls
				where fname in 
					(select fname from class_girls);
quit;

proc sql;
	create table alred_2 as
		select * from more_girls
			where fname in
				('Alice', 'Barbara', 'Carol', 'Jane');
quit;

proc sql;
	select fname from class_girls;
quit;

proc sql;
	create table alred_3 as
		select * from more_girls
			where fname = any
				(select fname from class_girls);
quit;

proc sql;
	create table already as
		select * from more_girls
			where not (fname ne all (select fname from class_girls));
quit;

proc sql;
	select * from more_girls
		order by fname in 
			(select fname from class_girls), fname;
quit;

proc sql;
	select fname in (select fname from class_girls), * from more_girls;
quit;

/*SET OPERATIONS*/
data a;
	A = 1;
	Aa = 1.5;
run;

data b;
	B = 2;
run;

proc sql;
	select * from a
		cross join b;
quit;

proc sql;
	select * from a
		union
	select * from b;
quit;

/*GET SOME DATA*/
proc sql;
	create table one as
		select name as fname, weight, age
			from sashelp.class	
				where age < 13 and length(name) ge 5
					order by age, ranuni(1);
	create table two as
		select name as fname, age, height
			from sashelp.class
				where age < 13 and length(name) le 5
					order by age, ranuni(2);
quit;

/*UNION - duplicate rows are eliminated*/
proc sql;
	select fname, age
		from one
			union
		select fname, age
			from two;
quit;

/*INTERSECT - only matching rows*/
proc sql;
	select fname, age
		from one
			intersect
		select fname, age
			from two;
quit;

/*EXCEPT - keep rows from only one table*/
proc sql;
	select fname, age
		from one
			except
		select fname, age
			from two;
quit;

/*OUTER UNION*/
proc sql;
	select fname, age
		from one
			outer union
		select fname, age
			from two;
quit;

proc sql;
create table outer as
	select fname, age
		from one
			outer union
		select fname, age
			from two;
quit;

data concat;
	set one
		two;
run;

proc sql;
	create table concat as
		select * from one
			outer union corresponding
				select * from two;
quit;

proc sql;
	create table concat as
		select * from one(drop=weight)
			outer union corresponding
				select * from two(drop=height);
quit;

data concat_order;
	set one
		two;
	by age;
run;

proc sql;
	create table concat_order as
		select * from one
			outer union corresponding
				select * from two
					order by age;
quit;

proc sql;
	select *, 1 as Suborder
		from one;
	select *, 2 as Suborder
		from two;
quit;

/*How to use additional column to sort results*/
proc sql;
	create table interleave(drop = suborder) as
		select *, 1 as suborder
			from one
				outer union corresponding
					select *, 2 as suborder
						from two
							order by age, suborder;
quit;

data num;
	var = 123;
run;
data char;
	var = 'abc';
run;
/*GIVES ERROR*/
data both;
	set num 
	char;
run;

proc sql;
	create table constraint as
		select * from num
			outer union corresponding
				select * from char;
quit;

/*UNION ALL*/
proc sql;
	create table uniall as
		select * from one
			union all corresponding
				select * from two;
quit;

proc sql;
select * from one;
select * from two;
select * from uniall;
quit;

proc sql;
	create table uniall as
		select fname, age from one
			union all
				select fname, age, height from two;
quit;

/*UNION ALL and UNION*/
data abc;
	retain id 1;
	do code = 'aa', 'aa', 'bb', 'bb', 'bb', 'bb', 'cc', 'cc';
		output;
		end;
run;

data ab;
	retain id 1;
	do code = 'aa', 'aa', 'aa', 'bb', 'bb';
		output;
		end;
run;

proc sql;
	create table union_tab as
		select * from abc
			union all 
				select * from ab;
quit; 

proc sql;
	create table union_tab as
		select * from abc
			union 
				select * from ab;
quit; 

data uni;
	set abc ab;
run;

proc sort data=uni out=union_sort noduprecs;
by _all_;
run;

data un;
	merge abc(in=in_abc) ab(in=in_ab);
	by id code;
	if first.code and (in_abc or in_ab);
run;

/*INTERSECT, INTERSECT ALL*/
proc sql;
	create table inter as
		select * from abc
			intersect 
				select * from ab;
quit;

proc sql;
	create table inter as
		select * from abc
			intersect all
				select * from ab;
quit;


