/***************
PROC SQL
****************/
data perteen;
	set sashelp.class;
	where age < 13;
	label name = "First Name";
	rename name = Fname;
	format height weight 5.1;
run;

proc print data=perteen label;
run;

proc sql;
	select * from perteen;
quit;

proc sql;
	select fname, age from perteen;
quit;

proc sql;
	create table new as
		select * from perteen;
quit;

proc sql;
	create table subset(drop=height weight) as
		select * from perteen;
quit;

/*ATTRIB - to create a new variable, the ATTRIB statement here is not essential. It just provides a variable label and an
appropriate format.*/
data ratios;
	set perteen;
	attrib ratio format=5.2 label='Weight:Height Ratio';
	ratio = weight / height;
run;

proc sql;
	create table ratios_2 as
		select *, weight / height as ratio format=5.2 label='Weight:Height Ratio'
			from perteen;
quit;

/*PROC SUMMARY*/
proc summary data=perteen;
	var age weight height;
	output out = overall_averages(drop= _type_ _freq_)
		min(age) = Youngest
		max(age) = Oldest
		mean(height) = Avg_Height
		mean(weight) = Avg_Weight;
run;

proc sql;
	create table overall_stats as
		select min(age) as youngest, 
			max(age) as oldest, 
			mean(age) as Avg_Age format=5.2,
			mean(weight) as Avg_weight format=5.2
		from perteen;
quit;

proc summary data=perteen nway;
	class Sex;
	var age weight height;
	output out = overall_averages(drop= _type_ _freq_)
		min(age) = Youngest
		max(age) = Oldest
		mean(height) = Avg_Height
		mean(weight) = Avg_Weight;
run;

proc sql;
	create table stats as
		select sex, 
			min(age) as youngest,
			max(age) as oldest,
			mean(weight) as Avg_Weight format=5.2,
			mean(height) as Avg_Height format=5.2
		from perteen group by sex;
quit;

data threex3;
	input a b c;
	cards;
1.1 2.0 3.0
6.0 5.0 4.4
7.7 8.0 9.0
;
run;

/*Important note: calculation is made row by row*/
proc sql;
	select mean(a, b, c) label='Mean of 3',
		median(a, b, c) label='Median of 3'
	from threex3;
quit;

/*Calculation is made by column*/
proc sql;
	select mean(a) label='Mean of a',
		mean(b) label='Mean of b',
		mean(c) label='Mean of c'
	from threex3;
quit;

proc sql;
	select median(a) label='Median of 1',
		median(b) label='Median of 1'
	from threex3;
quit;

/*CONDITIONALITY*/
data trip_list;
	length Trip $10;
	set perteen;

	if age=11 then
		Trip='Zoo';
	else if sex='F' then
		Trip='Museum';
	else  trip = '[None]';
	keep fname age sex trip;
run;

proc sql;
	create table trip_list as
		select fname, age, sex,
			case 
				when age=11 then 'Zoo'
				when sex='F' then 'Museum'
				else '[None]'
			end
		as Trip
			from perteen;
quit;

proc print data=sashelp.shoes;
run;

proc sql;
	create table three_country as
		select * from sashelp.shoes 
			where Region in ('Africa', 'Asia', 'Canada');
quit;

proc sql;
	select Product, 
		case 
			when Region='Africa' then 'Lower'
			when Region='Asia' then 'Mid'
			else 'High'
		end
	as Price
		from three_country;
quit;

/*FILTERING*/
proc sql;
	create table girls as
		select * from perteen
			where sex='F';
quit;

/*FILTERING AGGREGATED DATA*/
proc sql;
	create table hilo as
		select sex,
			max(height) as Tallest,
			min(height) as Shortest 
		from perteen
			group by sex;
quit;

proc sql;
	create table hilo as
		select sex,
			age,
			max(height) as Tallest,
			min(height) as Shortest 
		from perteen
			group by sex, age;
quit;

proc sql;
	create table hilo as
		select sex,
			age,
			max(height) as Tallest,
			min(height) as Shortest 
		from perteen
			group by sex, age
				having Tallest - Shortest > 4;
quit;

/*REORDERING ROWS*/
proc sql;
	create table age_sort as
		select * from perteen
			order by age desc, fname;
quit;

/*ELIMINATION OF DUPLICATES*/
proc sql;
	select distinct sex
		from perteen;
quit;

proc sql;
	select distinct sex, age
		from perteen;
quit;

/*CHAPTER 3*/
proc sql;
	create table teens as
		select name as Fname, 
			age
		from sashelp.class
			where age > 12;
quit;

proc sql;
	create table detal as
		select fname, 
			age,
			count(*) as Many
		from teens
			group by age
				order by fname;
quit;

proc sql;
	select mean(age) label='Weighted', mean(distinct age) label='Unweighted'
		from teens;
quit;

proc sql;
	select age from teens;
	select distinct age from teens;
	select mean(age) as Avg_age from teens;
	select mean(distinct age) as Avg_age_dist from teens;
quit;

proc sql;
	create table temp as
		select age, count(*) as many
			from teens
				group by age;
quit;

proc sql;
	create table largest as
		select *
			from temp
				having many = max(many);
quit;

/*Nested Versions*/
proc sql;
	create table largest as
		select *
			from (select age, count(*) as many
			from teens
				group by age)
					having many = max(many);
quit;
