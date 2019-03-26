*
--------------------------------------
--- IMPORT TXT FILES -----------------
--------------------------------------
*;

data salary;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/salary.txt";
	input year salary;
run;

*
--------------------------------------
--- IMPORT CSV FILES -----------------
--------------------------------------
*;

data krakers.weightgain;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/weightgain.csv" 
		dsd missover firstobs=2;
	input id source $ type $ weightg;
run;

*
--------------------------------------
--- IMPORT XLSX FILES ----------------
--------------------------------------
*;

proc import out=krakers.salesdata datafile="/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/Sample-Sales-Data.xlsx" 
		dbms=xlsx replace;
	*sheet="name_of sheet";
	*you can specify particular sheet;
	*getnames=yes;
	*get names from first row as column - default option yes;
run;

*
--------------------------------------
--- IMPORT SPSS FILES ----------------
--------------------------------------
*;

proc import 
		datafile="/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/p054.sav" 
		out=krakers.spss_table replace;
proc contents data=spss_table;
run;

*
--------------------------------------
--- CREATING LIBRARY -----------------
--------------------------------------
*;
libname krakers "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/lib";

data krakers.salaries;
	infile "/folders/myfolders/SAS-Course/Udemy-Data-Ninja/data/salary.txt";
	input year salary;
run;