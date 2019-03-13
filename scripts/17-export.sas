***************************
*	Exporting data:
*		PROC EXPORT DATA=input-table OUTFILE="output-file" <DBMS=identifier> <REPLACE>;
*		RUN;
*
* 		DBMS = CSV, TAB, DLM, XLSX
***************************;
libname out "/home/S1613351/output";
%let outpath=/home/S1613351/output;

data test out.test_out;
	input model $ type $ price volume flag $;
	datalines;
MDX SUV 36945 20 y
RSX Sedan 23820 10 n
TSX Sedan 26690 15 n
NSX Sports 89000 25 n
LSX Sports 90000 25 n
Jaguar Sports 120000 45 y
CRV SUV 80000 30 y
CRV SUV 89000 45 y
;
run;

/* Exporting file as a TAB .txt file */
proc export data=test outfile="/home/S1613351/output/test_tab.txt" dbms=tab 
		replace;
run;

/* Exporting file as a CSV .csv file */
proc export data=test outfile="/home/S1613351/output/test_csv.csv" dbms=csv 
		replace;
run;

/* Exporting Data to Excel Workbook */
/* Key Note: add xlsx extension to the file in path */
*****************************
*	Syntax:
*		LIBNAME libref XLSX "path/file.xlsx";
*		<use libref for output table(s)>
*		LIBNAME libref CLEAR;
*****************************;
libname myxl xlsx "/home/S1613351/output/cars.xlsx";

data myxl.test_xlsx;
	set test;
run;

libname myxl clear;

/* Second example */
/* Easy way to create one excel file with multiple worksheets */
libname xlout xlsx "/home/S1613351/output/export.xlsx";
data xlout.test_read;
	set test;
run;

proc print data=test_read;
run;

proc means data=test_read;
	class type;
	output out=xlout.test_stats n=Count mean=Avg;
run;
libname xlout clear;

***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    PROC EXPORT DATA=input-table                         *;
*                OUTFILE="output-file"                    *;
*                <DBMS=identifier> <REPLACE>;
*;
*    RUN;
*;
***********************************************************;

proc export data=pg1.storm_final 
		outfile="/home/krakowiakpawel90/EPG194/output/storm_final.csv" dbms=csv 
		replace;
run;

***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    OPTIONS VALIDVARNAME=V7;
*;
*    LIBNAME libref xlsx "path/file.xlsx";
*;
*     <use libref for output table(s)>                    *;
*    LIBNAME libref CLEAR;
*;
***********************************************************;
libname xl_lib xlsx "/home/krakowiakpawel90/EPG194/output/storm2.xlsx";

data xl_lib.storm_final;
	set pg1.storm_final;
	drop Lat Lon Basin OceanCode;
run;

libname xl_lib clear;

/* Another Example */

ods excel file="/home/krakowiakpawel90/EPG194/output/pressure.xlsx";
title "Minimum Pressure Statistics by Basin";
ods noproctitle;

proc means data=pg1.storm_final mean median min maxdec=0;
	class BasinName;
	var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";

proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;

title;
ods excel close;
ods proctitle;
