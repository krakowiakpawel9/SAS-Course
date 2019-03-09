/* Importing a comma-delimited (CSV) file */
proc import datafile="/folders/myfolders/SAS-Course/data/storm_damage.csv" 
		dbms=csv out=storm_import replace;
run;

/* Check if types of columns are correctly assigned */
proc contents data=storm_import;
run;

proc print data=storm_import(obs=10);
run;

/* Importing a tab-delimited (TAB) file */
proc import datafile="/folders/myfolders/SAS-Course/data/storm_damage.tab" 
		dbms=tab out=storm_tab replace;
run;

/* Importing Excel files */
proc import datafile="/folders/myfolders/SAS-Course/data/class.xlsx" dbms=xlsx 
		out=class_xlsx replace;
run;

/* Specifying name of the worksheet */
proc import datafile="/folders/myfolders/SAS-Course/data/class.xlsx" dbms=xlsx 
		out=class_test_xlsx replace;
	sheet=class_test;
run;

/* Specifying name of the worksheet */
proc import datafile="/folders/myfolders/SAS-Course/data/class.xlsx" dbms=xlsx 
		out=class_birthdate_xlsx replace;
	sheet=class_birthdate;
run;

/*
Difference between XLSX ENGINE and PROC IMPORT
- XLSX ENGINE reads data directly form the xlsx file, data is always current
- PROC IMPORT creates a copy of Excel file, data must be reimported if if changes
*/
proc import datafile="/folders/myfolders/SAS-Course/data/eu_sport_trade.xlsx" 
		dbms=xlsx out=eu_sport_trade replace;
run;

proc contents data=eu_sport_trade;
run;

/* Wrangling np_traffic dataset */
proc import datafile="/folders/myfolders/SAS-Course/data/np_traffic.csv" 
		dbms=csv out=traffic replace;
proc contents data=traffic;
run;

/* Wrangling storm_damage dataset */
proc print data=pg1.storm_damage;
	format Date ddmmyy10. Cost dollar16. Deaths comma5.;
run;

/*
Look at the difference between two piece of code: guessingrows=max; allows to read
format of columns based on all tables. In the opposite the above piece of code truncates some values in rows.
*/
proc import datafile="/folders/myfolders/SAS-Course/data/np_traffic.csv" 
		dbms=csv out=traffic replace;
	guessingrows=max;

proc contents data=traffic;
run;

proc print data=pg1.storm_summary(obs=10);
	format Lat Lon 4. StartDate date11. EndDate date9.;
run;

proc freq data=pg1.storm_summary order=freq;
	tables StartDate;
	format StartDate Monname.;
run;