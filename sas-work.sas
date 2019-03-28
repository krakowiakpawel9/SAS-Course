*Program name: read_txt.sas

Purpose: The program reads the data and computes a body mass index (BMI) for each row.

Programmer: Paweł Krakowiak
Date: 28/03/2019;
data veggies;
	infile "SASBook/veggies.txt";
	input name $ code $ days number price;
	CostPerSeed = Price / Number;
run;

title "List of the raw data";

proc print data=veggies;
run;

title "Frequency Distribution of Vegetables Names";

proc freq data=veggies;
	tables Name;
run;

title "Average Cost of Seeds";

proc means data=veggies;
	var Price Days;
run;

*	read mydata.txt;
data demographic;
	infile "SASBook/mydata.txt";
	input Gender $ Age /*Age is in year */
	Height Weight;

	*compute a BMI;
	Weight_eur = Weight / 2.2;
	Height_eur = Height*0.0254;
	BMI = (Weight / 2.2) / (Height *0.0254)**2;
	BMI_eur = Weight_eur / Height_eur**2;
run;

title "Print all data";

proc print data=demographic;
run;

title "Gemder Frequencies";

proc freq data=demographic;
	tables Gender;
run;

title "Summary Statistics";

proc means data=demographic;
	var Age Height Weight;
run;

/******
NEXT
******/
proc print data=veggies /* comment inside statement */;
run;

*-------------------------------------*
| Program Name: comments.sas          |
|									  |
| Purpose: shows comment			  |
*-------------------------------------*;

/**************************************
Program name: comments.sas

Purpose: shows comment				
***************************************/

/******
NEXT
******/

/******************************************
Program Name: stocks.sas

Purpose: Reads stocks.txt file
*******************************************/
data stocks;
	infile "SASBook/stocks.txt";
	input name $ price amount;
run;

proc means data=stocks;
	var price amount;
run;

/******************************************
Program Name: stocks.sas

Purpose: solution
*******************************************/
data prob;
	input ID $
		Height /* in inches */
	Weight /* in pounds */
	SBP /* systolic BP */
	DBP /* diastolic BP */;
	WtKg = weight / 2.2;
	HtCm = height * 2.54;
	AveBP = DBP + 1/3 * (SBP - DBP);
	HtPolynomial = 2*height**2 + 1.5*height**3;
	datalines;
	001 68 150 110 70
	002 73 240 150 90
	003 62 101 120 80
	;
run;

title "Listing of prob";

proc print data=prob;
run;

/******************************************
Program Name: stocks.sas

Purpose: solution
*******************************************/
filename purpose "SASBook/mydata.csv";

data demo;
	infile purpose dsd;
	input Gender $ Age Height Weight;
run;

/******************************************
Program Name: stocks.sas

Purpose: solution - fixed column
*******************************************/
filename bank "SASBook/bank.txt";

data fin;
	infile bank;
	input Subject $ 1-3
	DOB $ 4-13
	Gender $ 14
	Balance 15-21;
run;

data fin_for;
	infile bank;
	input @1 Subject $3.
		@4 DOB mmddyy10.
		@14 Gender $1.
		@15 Balance 7.;
run;

proc print data=fin_for;
	format DOB mmddyy10. Balance dollar11.2;
run;

/******************************************
Program Name: stocks.sas

Purpose: solution, colon specify informat
*******************************************/
data list;
	infile "SASBook/list.csv" dsd;
	input Subject : $3.
		Name : $20.
		DOB : mmddyy10.
		Salary : dollar8.;
run;

data list_in;
	infile "SASBook/list.csv" dsd;
	informat Sub $3. Name $20. DOB mmddyy10. Salary dollar8.;
	input Sub Name DOB Salary;
	format DOB date9. salary dollar8.;
run;

proc contents data=work._all_ nods;
run;

proc contents data=work.demo varnum;
run;

data list_in;
	infile "SASBook/list.csv" dsd;
	informat Sub $3. Name $20. DOB mmddyy10. Salary dollar8.;
	input Sub Name DOB Salary;
	format DOB date9. salary dollar8.;
run;

/******************************************
Program Name: stocks.sas

Purpose: solution
*******************************************/
data score;
	input Obs : 3. ID : 3. Score1-Score3 : 4.;
	avg = mean(of Score1-Score3);
	datalines;
1 1 90 95 98
2 2 78 77 75
3 3 88 91 92
;
run;

data _null_;
	set score;

	if score1 ge 95 or score2 ge 95 or score3 ge 95 then
		put ID= Score1= Score2= Score3=;
run;

/******
NEXT
******/
data perm;
	input ID : $3. Gender : $1. DOB : mmddyy10. Height Weight;
	label DOB = "Date of Birth"
		Height = "Height in inches"
		Weight = "Weight in pounds";
	format DOB date9.;
	datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
;
run;

proc contents data=perm;
run;

proc print data=perm;

proc print data=perm label;
run;

libname myfmts "SASBook/format/";
libname myfmts clear;

proc format;
	value $gender 'M' = 'Male' 'F'='Female';
	value age_f low-40 = "Less than 40" 41-high = 'Greater than 40';
run;

proc print data=perm;
	format gender $gender. age age_f.;
run;

data test;
	input id : $3. gender : $1. age : 3.;
	datalines;
001 M 22
002 F 46
003 M 45
;
run;

proc print data=test;
	format gender $gender. age age_f.;
run;

/*****
NEXT
******/

/***************
if logic
	****************/
data cond;
	input Age Gender $ Midterm Quiz $ FinalExam;
	datalines;
21 M 80 B- 82
. F 90 B+ 85
35 M 87 B+ 85
48 F . . 76
59 F 95 A+ 97
15 M 88 . 93
67 F 97 A 91
. M 62 F 67
35 F 77 C- 77
49 M 59 C 81
;
run;

data cond_if;
	set cond;

	if age lt 20 and age ne . then
		AgeGroup=1;

	if age ge 20 and age lt 40 then
		AgeGroup=2;

	if age ge 40 and age lt 60 then
		AgeGroup=3;

	if age ge 60 then
		AgeGroup=4;
run;

proc print data=cond;

proc print data=cond_if;
run;

data cond_if_better;
	set cond;

	if age = . then
		AgGr = .;
	else if age lt 20 then
		AgGr = 1;
	else if age lt 40 then
		AgGr = 2;
	else if age lt 60 then
		AgGr = 3;
	else AgGr=4;
run;

data cond_if_better_two;
	set cond;

	if missing(age) then
		AgGr = .;
	else if age lt 20 then
		AgGr = 1;
	else if age lt 40 then
		AgGr = 2;
	else if age lt 60 then
		AgGr = 3;
	else AgGr=4;
run;

/*********************
if logic - subsetting
	**********************/
data cond_fem;
	set cond;

	if Gender='F';
run;

data quiz;
	set cond;

	if Quiz in ('A+', 'A', 'B+', 'B') then
		QuizRange=1;
	else if Quiz in ('B-', 'C+', 'C') then
		QuizRange=2;
	else if not missing(Quiz) then
		QuizRange=3;
	select (QuizRange);
		when (1) Limit=110;
		when (2) Limit=120;
		when (3) Limit=130;
		otherwise;
	end;
run;

data select;
	set cond;
	select;
		when (missing(Age)) AgeGroup=.;
		when (Age lt 20) AgeGroup=1;
		when (Age lt 40) AgeGroup=2;
		when (Age lt 60) AgeGroup=3;
		when (Age lt 80) AgeGroup=4;
		otherwise;
	end;
run;

data other;
	set cond;

	*where Quiz is missing;
	*where age is null;
	*where age between 20 and 40;
run;

/******
NEXT 
*******/
data grades;
	infile "SASBook/grades.txt" missover;
	input Age Gender$ Midterm Quiz$ FinalExam;
run;

data without_do;
	set grades;

	if missing(Age) then
		delete;

	if Age le 39 then
		AG = 'Younger group';

	if Age le 39 then
		Grade = 0.4*Midterm + 0.6*FinalExam;

	if Age gt 39 then
		AG = 'Older group';

	if Age gt 39 then
		Grade = 0.5*Midterm + 0.5*FinalExam;
run;

data with_do;
	set grades;

	if missing(Age) then
		delete;

	if Age le 39 then
		do;
			AG = 'Younger group';
			Grade = 0.4*Midterm + 0.6*FinalExam;
		end;

	if Age gt 39 then
		do;
			AG = 'Older group';
			Grade = 0.5*Midterm + 0.5*FinalExam;
		end;
run;

data revenue;
	input day : $3 Revenue : dollar6.;
	Total + Revenue;
	datalines;
Mon $1,000
Tue $1,500
Wed .
Fri $3,000
;
run;

data revenue_2;
	input day : $3 Revenue : dollar6.;
	retain Total 0;
	Total + Revenue;
	datalines;
Mon $1,000
Tue $1,500
Wed .
Fri $3,000
;
run;

data revenue_2;
	input day : $3 Revenue : dollar6.;
	retain Total 0;

	if not missing(Revenue) then
		Total = Total + Revenue;
	datalines;
Mon $1,000
Tue $1,500
Wed .
Fri $3,000
;
run;

/*******************
Using sum to create counter of missing values
********************/
data test;
	input x;

	if missing(x) then
		MissCounter + 1;
	datalines;
2
.
7
.
.
.
5
7
8
9
;
run;

data compound;
	Interest = 0.375;
	Total = 100;
	Year + 1;
	Total + Interest*Total;
	output;
	Year + 1;
	Total + Interest*Total;
	output;
	Year + 1;
	Total + Interest*Total;
	output;
	format total dollar12.2;
run;

data compound_2;
	Interest = 0.375;
	Total = 100;

	do Year=1 to 3;
		Total + Interest*Total;
		output;
	end;

	format total dollar12.2;
run;

data table;
	do n = 1 to 10;
		Square = n*n;
		SquareRoot = sqrt(n);
		output;
	end;
run;

data table_2;
	do n = 1 to 100 by 1;
		Square = n*n;
		SquareRoot = sqrt(n);
		output;
	end;
run;

data table;
	do n = 10 to 1 by -1;
		Square = n*n;
		SquareRoot = sqrt(n);
		output;
	end;
run;

proc gplot data=table_2;
	plot Square * n SquareRoot * n;
run;

data loop_list;
	do x = 1,2,5,10;
		y = x**2;
		output;
	end;
run;

data loop_month;
	do month='Jan', 'Feb', 'Mar';
		new = cat(month,'2019');
		output;
	end;
run;

data loop_other;
	do x =1,3,5 to 13 by 2;
		output;
	end;
run;

data loop_other_2;
	do x =1,3,5 to 13 by 2, 100 to 200 by 10;
		output;
	end;
run;

data easyway;
	do Group = 'Placebo','Active';
		do Subj = 1 to 5;
			input Score @;
			output;
		end;
	end;

	datalines;
 250 222 230 210 199
 166 183 123 129 234
 ;
run;

data easy;
	do Group = 'Europe', 'USA';
		do Nr = 1 to 4;
			input Score @;
			output;
		end;
	end;

	datalines;
12 14 15 16
01 50 51 40
;
run;

data double;
	Interest = .0375;
	Total = 100;

	do until (Total ge 200);
		Year + 1;
		Total = Total + Interest*Total;
		output;
	end;

	format Total dollar10.2;
run;

data double;
	Interest = .0375;
	Total = 100;

	do while (Total le 200);
		Year + 1;
		Total = Total + Interest*Total;
		output;
	end;

	format Total dollar10.2;
run;

data leave_it;
	Interest = .0375;
	Total = 100;

	do Year = 1 to 100;
		Total = Total + Interest*Total;
		output;

		if Total ge 200 then
			leave;
	end;

	format Total dollar10.2;
run;

data continue_on;
	Interest = .0375;
	Total = 100;

	do Year = 1 to 100 until (Total ge 200);
		Total = Total + Interest*Total;

		if Total le 150 then
			continue;
		output;
	end;

	format Total dollar10.2;
run;

data;
	do i = 1 to 10;
		if i gt 7 then
			leave;
		output;
	end;
run;

data;
	do i = 1 to 10;
		if i le 7 then
			continue;
		output;
	end;
run;

data logit;
	do i=0 to 1 by 0.01;
		Logit = log(i/(1-i));
		output;
	end;
run;

proc gplot data=logit;
	plot Logit * i;
run;

/******
NEXT
*******/
data date_val;
	infile "SASBook/dates.txt";
	input v1-v5 $;
run;

data test;
	input @1 id $3.
		@5 DoB mmddyy10.
		@16 VisitDate mmddyy8.
		@26 TwoDigit mmddyy8.
		@34 LastDate date9.;
	datalines;
001 10/21/1950 05122003 08/10/65 23Dec2005
002 01/01/1960 11122009 09/13/02 02Jan1960
;
run;

*	Compute number of years between two dates;
data ages;
	set test;
	Age = int(yrdif(DoB, VisitDate, 'Actual'));
	format DoB VisitDate TwoDigit LastDate ddmmyy10.;
run;

proc print data=ages;
	id id;
run;

data ages;
	set test;
	Age = yrdif(DOB,'01Jan2006'd,'Actual');
run;

title "Listing of AGES";

proc print data=ages;
	id id;
	format Age 5.1;
run;

data ag;
	set test;
	Age = yrdif(DOB, today(), 'Actual');
run;

/***********************
Extract parts of date
************************/
data extract;
	input id date;
	format date date9.;
	day = weekday(date);
	DayOfMonth = day(date);
	Month = month(date);
	Year = year(date);
	datalines;
001 19000
002 19500
003 20000
;
run;

/*************************
Create date
**************************/
data mdy_example;
	set extract;
	dating = mdy(month, dayofmonth, year);
	format dating date9.;
run;


data identity;
input date ddmmyy10.;
format date date9.;
datalines;
10/12/2010
;
run;

data read;
	set identity;
	date_2 = mdy(month(date), day(date), year(date));
	format date_2 date9.;
run;

data val;
a = intck('year', '01JAN2005'd, '31DEC2005'd);
b = intck('year', '01JAN2005'd, '01JAN2006'd);
c = intck('month', '01JAN2005'd, '31DEC2005'd);
d = intck('month', '01JAN2005'd, '31DEC2005'd);
e = intnx('month', '01JAN2019'd,1);
format e date9.;
run;

/*******
NEXT
********/
/******************
splitting data into two sets
*******************/
data males females;
	set mydata;

	if gender = 'M' then
		output males;
	else if gender = 'F' then
		output females;
run;

/******************
concatenating two tables
*******************/
data tab_1;
	input id$ name$;
	datalines;
001 pawel
002 jan
;
run;

data tab_2;
	input id$ name$;
	datalines;
003 adam
004 tomek
;
run;

data tab_3;
	input id$ names$;
	datalines;
003 adam
004 tomek
;
run;

data mer;
	set tab_1 tab_2;
run;

data mer_2;
	set tab_1 tab_3;
run;

/******************
merging two tables
*******************/
data t1;
	input id $ name $;
	datalines;
1 smith
2 gregory
3 adams
;
run;

data t2;
	input id $ class $ Hours;
	datalines;
1 A 39
2 B 44
5 A 35
;
run;

proc sort data=t1;
	by id;

proc sort data=t2;
	by id;

data merg;
	merge t1 t2;
	by id;
run;

data merg;
	merge t1(in=in_t1) t2(in=in_t2);
	by id;
	file print;
	put ID= in_t1= in_t2=;
run;

data merg_2;
	merge t1(in=in_t1) t2(in=in_t2);
	by id;

	if in_t1 and in_t2;
run;

data merg_3;
	merge t1(in=in_t1) t2(in=in_t2);
	by id;

	if in_t1;
run;

data merg_4 missing;
	merge t1(in=a) t2(in=b);
	by ID;

	if a and b then
		output merg_4;
	else if a and not b then
		output missing;
run;

/*merge with different var names*/
data s1;
	input id x;
	datalines;
123 90
222 95
333 100
;
run;

data s2;
	input EmpNo y;
	datalines;
123 200
222 205
333 317
;
run;

data all;
	merge s1
		s2(rename=(EmpNo=id));
	by id;
run;

/*****
NEXT
******/
data trun;
	input Age Weight;
	age = int(age);
	wtkg = round(weight*2.2, .1);
	weight = round(weight);
	datalines;
18.8 120.5
25.12 122.4
64.99 188
;
run;

data blood;
	infile "SASBook/blood.txt";
	input id gender$ cat$ age$ wbc rbc chol;
run;

data test_miss;
	set blood;

	if gender = ' ' then
		MissGender + 1;

	if wbc = . then
		MissWBC + 1;

	if rbc = . then
		MissRBC + 1;
run;


data test_miss_2;
	set blood;
	if missing(Gender) then MisG + 1;
	if missing(wbc) then MisWBC + 1;
run;
