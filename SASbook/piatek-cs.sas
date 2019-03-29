/***********************
PROC MEANS
************************/
proc print data=blood;
run;

proc sort data=blood;
	by gender;
run;

proc means data=blood n nmiss mean sum min max median std var clm q1 q3 qrange maxdec=2;
	by gender;
	var rbc wbc;
run;

proc means data=blood n nmiss;
	class gender;
run;

proc format;
	value chol_gr low-<200 = 'Low' 200-high = "High";
run;

proc means data=blood n nmiss mean median maxdec=1;
	class Chol;
	format Chol chol_gr.;
	var rbc wbc;
run;

*veggies dataset;
proc print data=veggies;
run;

data double;
	set veggies veggies;
run;

proc format;
	value price_fmt low-<200 = 'Low price' 200-high = "High price";
run;

proc means data=veggies;
	class price;
	format price price_fmt.;
run;

proc means data=blood noprint maxdec=2;
	var rbc wbc;
	output out=summary(drop=_type_ _freq_) mean=MeanRBC MeanWBC;
run;

proc means data=blood noprint maxdec=2;
	var rbc wbc;
	output out=summary
		mean	=
		n		=
		nmiss	=
		median	= / autoname;
run;

data survey;
	infile 'SASBook/survey.txt' pad;
	input ID : $3.
		Gender : $1.
		Age
		Salary
		(Ques1-Ques5)(1.);
run;

proc freq data=survey;
	tables gender;
run;

proc format;
	value $gend 'F' = 'Female' 'M'='Male';
run;

proc freq data=survey;
	tables gender;
	format gender $gend.;
run;

/******************
grouping
*******************/
data grouping;
	input X @@;
	datalines;
2 4 5 2 4 5 3 4 5 3 . 6
;

proc format;
	value two low-3 = 'Group 1' 4-5 = "Group 2" . = 'Missing' other = 'Other values';
run;

proc freq data=grouping;
	tables x;
	format x two.;
run;

/******************
PROC TABULATE
*******************/
proc tabulate data=blood;
	class  gender;

	table gender;
run;

/******************
PROC GCHART
*******************/
proc gchart data=blood;
	vbar Gender;
run;

proc gchart data=blood;
	hbar Gender;
run;

proc gchart data=blood;
	vbar3d Gender;
run;

proc gchart data=blood;
	pie gender;
	donut gender;
	star gender;
run;

proc gchart data=blood;
	vbar wbc;
run;

proc gchart data=blood;
	vbar wbc / midpoints=4000 to 11000 by 1000;
run;

proc gchart data=blood;
	vbar gender / sumvar=chol type=mean;
run;

/************
SCATTER
*************/
data clinic;
	input ID : $5.
		VisitDate : mmddyy10.
		Dx : $3.
		HR SBP DBP;
	format VisitDate mmddyy10.
		Dx $dx.;
	datalines;
101 10/21/2005 4 68 120 80
255 9/1/2005 1 76 188 100
255 12/18/2005 1 74 180 95
255 2/1/2006 3 79 210 110
255 4/1/2006 3 72 180 88
101 2/25/2006 2 68 122 84
303 10/10/2006 1 72 138 84
409 9/1/2005 6 88 142 92
409 10/2/2005 1 72 136 90
409 12/15/2006 1 68 130 84
712 4/6/2006 7 58 118 70
712 4/15/2006 7 56 118 72
;

ods graphics on;

proc gplot data=clinic;
	plot sbp*dbp;
run;

symbol value=dot interpol=sms width=2;

proc gplot data=clinic;
	plot sbp*dbp;
run;

/****************
MACRO VAR
*****************/
title "The date is &sysdate9 - the time is &systime";

proc print data=blood;
run;

%let var_list = rbc wbc chol;
title "Macro var: &var_list";

proc means data=blood;
	var &var_list;
run;

%let n=3;

data gen;
	do sub = 1 to &n;
		x = int(100*ranuni(0) + 1);
		output;
	end;
run;

title "Data Set with &n random numbers";

proc print data=gen;
run;

title;

/****************
SIMPLE MACRO
*****************/
%macro gen(n, start, end);

	data generate;
		do sub = 1 to &n;
			x = int((&end - &start + 1)*ranuni(0) + &start);
			output;
		end;
	run;

%mend gen;

%gen(4, 1, 100);
%gen(10,1,1000);

/***********************
SIMPLE MACRO WITH DOCS
************************/
%macro gen_2(n,		/* number of random numbers */
			start, /* starting value */
			end,	/* ending value */);
	/**************************************************
	Example to use: to generate 4 random numbers from
	1 to 100 use:
	%gen(4, 1, 100)
	***************************************************/
	data gen;
		do sub=1 to &n;
			xxx = int((&end-&start)*ranuni(0) + &start);
			output;
		end;
	run;

%mend gen_2;

%gen_2(4, 1, 100);
%let prefix=abc;

data &prefix.123;
	do i = 1 to 10;
		x + 2;
		output;
	end;
run;

proc print data=abc123;
run;

/********************
PROC SQL
*********************/
data health;
	input Subj : $3.
		Height
		Weight;
	datalines;
001 68 155
003 74 250
004 63 110
005 60 95
;

data demographic;
	input Subj : $3.
		DOB : mmddyy10.
		Gender : $1.
		Name : $20.;
	format DOB mmddyy10.;
	datalines;
001 10/15/1960 M Friedman
002 8/1/1955 M Stern
003 12/25/1988 F McGoldrick
005 5/28/1949 F Chien
;

proc sql;
	select * from health;
	select * from demographic;
quit;

proc sql;
	select * from health h
		inner join demographic d 
			on h.subj = d.subj;
quit;

proc sql;
	select h.subj, d.subj, height, weight, name, gender from health h, demographic d where h.subj = d.subj;
quit;

/********************
LEFT JOIN
*********************/
proc sql;
	title "Left join";
	select h.subj as sub_hel,
		d.subj as sub_dem, 
		height, 
		weight, 
		gender
	from health h
		left join demographic d 
			on h.subj = d.subj;
	title;
quit;

/********************
FULL JOIN
*********************/

proc sql;
	title "Left join";
	select h.subj as sub_hel,
		d.subj as sub_dem, 
		height, 
		weight, 
		gender
	from health h
		full join demographic d 
			on h.subj = d.subj;
	title;
quit;

/********************
CONCATENATING:
UNION - matches by column position, drop dups
UNION ALL - matches by column position, do not drop dups
UNION CORRESPONDING - matches by column name, drop dups
UNION ALL CORRESPONDING - matches by column name, do not drop dups
EXCEPT - matches by column name and drops rows found in both tables
INTERSECTION - matches by column name and keeps unique rows in both tables
*********************/

data new_members;
   input Subj : $3.
         Gender : $1.
         Name : $20.
         DOB : mmddyy10.;
   format DOB mmddyy10.;
datalines;
010 F Ostermeier 3/5/1977 
013 M Brown 6/7/1999 
;

proc sql;
	create table demo as
	select * from demographic union all corresponding
	select * from new_members;
quit;

proc sql;
select subj,
		height,
		weight,
		mean(height) as avg_height
from health;
quit;

/***********
FUZZY MATCH
IMPORTANT NOTE!
spedis() function - spelling distance
************/

data insurance;
   input Name : $20.
         Type : $2.;
datalines;
Fridman F
Goldman P
Chein F
Stern P
;

proc sql;
select subj,
	d.name as health_name,
	i.name as insurance_name
from demographic as d, insurance as i
where spedis(health_name, insurance_name) le 25;
quit;
