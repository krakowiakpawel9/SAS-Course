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
	input name $ company $;
	datalines;
Huawei China
Samsung Japan
Tata China
Motorolla Japan
Apple USA
HP USA
Asus USA
Lenovo China
Windows USA
;
run;

proc freq data=devices order=freq;
tables company;
run;
