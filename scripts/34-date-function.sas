/* SAS date - number of days */
/* SAS time - number of seconds */
/* SAS datetime - number of seconds */
******************************************************
*
* 	datepart(datetime-value) allows to separate date 
* 	timepart(datetime-value) allows to separate time
* 	intck('interval', start-date, end-dte, 'method')
*
* 	WEEK = Sunday to Saturday
* 	method='discrete' default method
* 	method='C' continuous;
*
*	INTNX(interval, start, increment, 'alignment');
* 	allows shifts the dates to the first day of following month for example
********************************************************;
libname pg2 "/folders/myfolders/EPG294/data";

proc print data=pg2.storm_detail(obs=10);
run;

data storm;
	set pg2.storm_detail;
	WindDate=datepart(ISO_time);
	WindTime=timepart(ISO_time);
	format WindDate date9. WindTime time.;
run;

/* Create own example intck() function*/
data test;
	input ServiceDate PayDate;
	informat ServiceDate PayDate date9.;
	format ServiceDate Paydate date9.;
	datalines;
10JUL2018 05SEP2018
;
run;

proc print data=test;
run;

data test_month;
	set test;
	Months2Pay=intck('month', ServiceDate, PayDate);
	Months2Pay_2=intck('month', ServiceDate, PayDate, 'c');
run;

/* Create own example intnx() function*/
/* This code below allows to shift the date to the beginning of given interval */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, 0);
	format date AssesmentDate date9.;
run;

/* If I change third parameter of intnx() function to 1 it gives me next month */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, 1);
	format date AssesmentDate date9.;
run;

/* If I change third parameter of intnx() function to 2 it gives me second month */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, 2);
	format date AssesmentDate date9.;
run;

/* If I change third parameter of intnx() function to -1 it gives me previous month */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, -1);
	format date AssesmentDate date9.;
run;

/* If I change third parameter of intnx() function to -1  and add fourth 
parameter 'end' it gives me end of the previous month */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, -1, 'end');
	format date AssesmentDate date9.;
run;

/* If I change third parameter of intnx() function to -1  and add fourth 
parameter 'middle' it gives me the middle of the previous month */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date;
	AssesmentDate=intnx('month', Date, -1, 'middle');
	format date AssesmentDate date9.;
run;

/* Calculating Anniversary (10 years) */
/* Important Note! You have to specify 'same' options */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date Anniversary;
	AssesmentDate=intnx('month', Date, -1, 'end');
	Anniversary = intnx('year', Date, 10, 'same');
	format date AssesmentDate Anniversary date9.;
run;

/* Calculating Beginning of the Year */
data storm;
	set pg2.storm_damage;
	keep AssesmentDate Event Date Beginning_of_Year;
	AssesmentDate=intnx('month', Date, -1, 'end');
	Beginning_of_Year = intnx('year', Date, 1);
	format date AssesmentDate Beginning_of_Year date9.;
run;

