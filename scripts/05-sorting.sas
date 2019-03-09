/*
Sorting helps:
- improve visual arrangement of the data
- identify and remove duplicate rows
- prepare datafor certain data processing steps
*/
proc print data=sashelp.class(obs=2);
run;

/* Default sorting method is ascending */
proc sort data=sashelp.class out=class_sorted;
	by Age;
run;

proc sort data=sashelp.class out=class_sorted_2;
	by descending Age descending Height;
run;

proc sort data=sashelp.class out=sorted_class;
	by Name;
run;

proc print data=pg1.storm_summary(obs=4);
run;

proc sort data=pg1.storm_summary out=storm_sort;
	where Basin in('NA', 'na');
	by descending MaxWindMPH;
run;

/* Sort and remove duplicate rows */
proc sort data=pg1.storm_summary out=strom_sort_2 noduprecs dupout=storm_dup;
	by _all_;
run;

proc sort data=pg1.class_test3 out=class_clean noduprecs dupout=class_dups;
	by _all_;
run;

/* Sort and remove duplicated values for particular column */
proc sort data=pg1.class_test3 out=class_clean_2 nodupkey dupout=class_dups_2;
	by Name;
run;

/* Exmple - sorting anr removing  */
/* This is uesful when you want to extract min/max values for specific key */
proc sort data=pg1.storm_detail out=storm_clean noduprecs dupout=storm_dups;
	by _all_;
run;

proc sort data=pg1.storm_detail out=min_pressure;
	where Pressure is not missing and Name is not missing;
	by descending Season Basin Name Pressure;
run;

proc sort data=min_pressure nodupkey;
	by descending Season Basin Name;
run;

/* National Park dataset */
proc sort data=pg1.np_summary out=np_sort;
	where Type='NP';
	by Reg descending DayVisits;
run;

proc sort data=pg1.np_largeparks out=park_clean noduprecs dupout=park_dups;
	by _all_;
run;

/* Sample basic dataset */
data payment;
	input ID $ Amount;
	format Amount dollar7.2;
	datalines;
A 997.54
A 833.88
B 879.05
C 894.77
C 894.77
C 998.26
;
run;

proc sort data=payment out=payment_clean nodupkey dupout=payment_dups;
	by ID;
run;

proc sort data=payment out=payment_clean_2 noduprecs dupout=payment_dups_2;
by _all_;
run;