******************************************************
*	Syntax
*
*	ODS GRAPHICS ON;
*	PROC FREQ DATA=input-table <proc-options>;
* 		TABLES col-name(s) / options;
*	RUN;
*
*	proc freq options:
*		- order=freq|formatted|data
*		- nlevels
*	tables options:
*		- nocum
*		- nopercent
* 		- plots=freqplot (must turn on ODS GRAPHICS, default vertical)
* 		- out=output-table
*
*	Additional:
*		"ods noproctitle" statements allows to hide default title
******************************************************;

data test;
	input model $ type $ price;
	datalines;
MDX SUV 36945 
RSX Sedan 23820 
TSX Sedan 26690 
NSX Sports 89000 
CRV SUV 80000 
CRV SUV 89000
;
run;

proc freq data=test order=freq nlevels;
	tables type;
run;

proc freq data=test order=freq nlevels;
	tables type / nocum;
run;

/* Orient changes orientation, scale changes scale to percent value */
ods graphics on;
ods noproctitle;
title "Frequnecy report";

proc freq data=test order=freq nlevels;
	tables type / plots=freqplot(orient=horizontal scale=percent);
run;

title;
ods proctitle;

data devices;
	input name $ company $ flag $;
	datalines;
Huawei China yes
Samsung Japan no
Tata China yes
Motorolla Japan no
Apple USA no
HP USA no
Asus USA no 
Lenovo China yes
Windows USA no
;
run;

proc freq data=devices order=freq;
	tables company;
run;

proc freq data=devices order=freq;
	table flag;
run;

/* Creating two distinct frequency tables */
proc freq data=devices order=freq;
	tables flag company;
run;

proc freq data=devices;
	tables flag*company / nocum nopercent norow;
run;

data devices_list;
	input name $ company $ flag $ date;
	datalines;
Huawei China yes 21620
Samsung Japan no 21619
Tata China yes 21628
Motorolla Japan no 21610
Apple USA no 21616
HP USA no 21500
Asus USA no 21510 
Lenovo China yes 21515
Windows USA no 21600
;
run;

proc print data=devices_list;
	format date date9.;
run;

proc freq data=devices_list;
	tables date;
	format date monname.;
run;

proc freq data=devices_list;
	tables date*flag / nocum;
	format date monname.;
	label flag="In Trade Union";
run;

/* Using crosslist options to create more flexible tables */
proc freq data=devices_list;
	tables flag*date / nocum crosslist;
	format date monname.;
run;

/* Using list options to create more flexible table */
proc freq data=devices_list;
	tables date*flag / list;
	format date monname.;
run;

/* Quick histogram */
proc freq data=devices_list;
	tables flag / plots=freqplot();
run;

proc freq data=devices_list;
	tables flag / plots=freqplot(orient=horizontal);
run;

/* Produce output table */
proc freq data=devices_list;
	tables flag*date / out=dev_count;
	format date monname.;
run;

/* With noprint options */
proc freq data=devices_list noprint;
	tables flag*date / out=dev_count;
	format date monname.;
run;
