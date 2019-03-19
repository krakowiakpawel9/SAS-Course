/* Accessing Data */
/* Excel */
%let path=/folders/myfolders/SAS-Course/practicalSAS/data;
options validvarname=v7;
libname ctryxl xlsx "&path/country_lookup.xlsx";

/* CSV File */
/* Tempory */
proc import 
		datafile="/folders/myfolders/SAS-Course/practicalSAS/data/orders.csv" 
		out=orders dbms=csv replace;
run;

/* Permanent */
libname cr "/folders/myfolders/SAS-Course/practicalSAS/output";

proc import 
		datafile="/folders/myfolders/SAS-Course/practicalSAS/data/orders.csv" 
		out=cr.orders dbms=csv replace;
run;

libname cert clear;

proc contents data=cert.orders;
run;

proc contents data=ctryxl.countries;
run;

/* Display all worksheets  */
proc contents data=ctryxl._all_;
run;

/* Display only initial list */
proc contents data=ctryxl._all_ nods;
run;

libname cr "/folders/myfolders/SAS-Course/practicalSAS/data/sas7bdat";

proc contents data=cr._all_ nods;
run;

/* Homework  */
proc import 
		datafile="/folders/myfolders/SAS-Course/practicalSAS/data/payroll.csv" 
		out=payroll dbms=csv replace;
	guessingrows=max;
run;

proc contents data=payroll;
run;

libname go xlsx "/folders/myfolders/SAS-Course/practicalSAS/data/employee.xlsx";

proc contents data=go._all_;
run;