libname krakers "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/lib";

data mydata;
	length age 3 sex$6 bmi 8 children 3 smoker$3 region$15 charges 8;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/insurance.csv" dsd 
		missover firstobs=2;
	input age sex$ bmi children smoker$ region$ charges;
run;

*	creating a counting variable;

data studentscores;
	input gender score;
	cards;
1 48
1 45
2 50
2 42
1 41
2 51
1 52
1 43
2 52
;
run;

proc sort data=studentscores;
	by gender;
run;

data scores_1;
	set studentscores;
	count + 1;
	by gender;

	if first.gender then
		count=1;
run;

data sales;
	input Name$ Sales_1-Sales_4;
	cards;
Greg 10 2 40 0
John 15 5 15 50
;
run;

data sales_2;
	input Name$1-4 Sales_1-Sales_4 @5;
	cards;
Greg10 2 40 0
John15 5 15 50
;
run;

data krakers.police;
	infile 
		"/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/londonoutcomes.csv" dsd 
		missover firstobs=2;
	length CrimeID $25 ReportedF $25 FallsW $25 Longitude 4 Latitude 4 
		Location $25 LSOAC $25 LSOAN $25 OutcomeT $100;
	input CrimeID$ ReportedF$ FallsW$ Longitude Latitude 
		Location$ LSOAC$ LSOAN$ OutcomeT$;
run;

proc print data=krakers.police;
run;

*	user defined format;

data disease;
	input diagcode$;
	datalines;
001
290
800
;
run;

proc print data=disease;
run;

proc format;
	value $codetwo '001'='Malaria' '290'='Social Anxiety Disorder' 
		'800'='Leg Injury';
run;

proc print data=disease;
	format diagcode $codetwo.;
run;

data dis_real;
	set disease;
	diagdesc=put(diagcode, $codetwo.);
	numdate = 122591;
	chardate = put(numdate, z8.);
run;

proc print data=dis_real;
run;