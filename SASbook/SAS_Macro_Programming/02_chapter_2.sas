/*USING MACRO VARIABLE*/
%let month_gold = 4;

proc print data=ytdsales;
run;

proc print data=ytdsales(where=(month(datesold) = &month_gold)) noobs;
	title "Books sold for month &month_gold";
	var booktitle saleprice;
	sum saleprice;
run;

data book200701 book200702 book200703;
	set ytdsales;

	if month(datesold) = 1 then
		output book200701;
	else if month(datesold) = 2 then
		output book200702;
	else if month(datesold) = 3 then
		output book200703;
run;

/*USING MACRO*/
%macro sales;
	%do month = 1 %to 3;

		proc means data=book20070&month.;
			title "Summary for month &month.";
			ods noproctitle;
			var saleprice;
		run;

	%end;
%mend sales;

%sales;

/*Program 1.3*/
%let repmonth=5;
%let repyear=2007;
%let repmwrd=%sysfunc(mdy(&repmonth, 1, &repyear), monname9.);

data temp;
	set ytdsales;
	mosale = month(datesold);
	label mosale = "Month of Sale";
run;

proc tabulate data=temp;
	title "Sales during &repmwrd &repyear";
	where mosale=&repmonth and year(datesold)=&repyear;
	class section;
	var saleprice listprice cost;
	tables section all='**TOTAL**', (saleprice listprice cost)*(n*f=4. sum*f=dollar10.2);
run;

proc gchart data=temp(where=(mosale <= &repmonth and year(datesold) = &repyear));
	title "Sales Through &repmwrd &repyear";
	pie section / coutline=black percent=outside sumvar=saleprice noheading;
run;

/*Program 1.4*/
title "Sales Report";
title2 "As of &systime &sysday &sysdate";
title3 "Using SAS Version: &sysver";

proc means data=ytdsales n sum;
	var saleprice;
run;

title;

/*Program 1.5 - Conditional*/
%macro daily;

	proc means data=ytdsales(where=(datesold='17AUG2007'd)) maxdec=2 sum;
		title "Daily Sales Report for &sysdate";
		class section;
		var saleprice;
	run;

	%if &sysday = Friday %then
		%do;

			proc means data=ytdsales(where=('17AUG2007'd - 6 le datesold le '17AUG2007'd)) sum maxdec=2;
				title "Weekly Sales Report Week Ending &sysdate";
				class section;
				var saleprice;
			run;

		%end;
%mend daily;

%daily;

/*Program 1.6 - Iterative*/
%macro makesets;

	data 
		%do i = 1 %to 12;
			month&i
		%end;
	;
	set ytdsales;
	mosale = month(datesold);

	if mosale = 1 then
		output month1;

	%do i = 2 %to 12;
	else if mosale = &i then
		output month&i;
	%end;
	run;

%mend makesets;

%makesets;

/*The same progtam without macro*/
data month1 month2 month3 month4 month5 month6
	month7 month8 month9 month10 month11 month12;

	set ytdsales;
	mosale=month(datesold);

	if mosale=1 then
		output month1;
	else if mosale=2 then
		output month2;
	else if mosale=3 then
		output month3;
	else if mosale=4 then
		output month4;
	else if mosale=5 then
		output month5;
	else if mosale=6 then
		output month6;
	else if mosale=7 then
		output month7;
	else if mosale=8 then
		output month8;
	else if mosale=9 then
		output month9;
	else if mosale=10 then
		output month10;
	else if mosale=11 then
		output month11;
	else if mosale=12 then
		output month12;
run;

/*Program 1.7 - PASSING INFORMATION BETWEEN PROGRAMS - CALL SYMPUTX*/
data temp;
	set ytdsales end=lastobs;
	retain sumintwb 0;
	if section in ('Internet', 'Web Design') then 
		sumintwb = sumintwb + saleprice;
	if lastobs then
		call symputx('intwebsl', put(sumintwb, dollar10.2));
run;

proc gchart data=temp;
	title "Internet and Web Design Sales: &intwebsl";
	hbar section / sumvar=saleprice;
run;

/*Program 1.8*/
%macro dsreport(dsname);
	%*----open data set dsname;
	%let dsid=%sysfunc(open(&dsname));

	%*----how many obs are in the data set?;
	%let nobs=%sysfunc(attrn(&dsid, nobs))

	%*----when was the data set created?;
	%let when=%sysfunc(putn(%sysfunc(attrn(&dsid, crdte)), datetime9.));

	%*----close data set dsname identified by dsid;
	%let rc=%sysfunc(close(&dsid));

	title "Report on Data Set &dsname";
	title2 "Num obs: &nobs Date Created: &when";

	proc means data=&dsname sum maxdec=2;
		class section;
		var saleprice;
	run;
%mend dsreport;

%dsreport(ytdsales);

/*Program 1.9* - setting macro with customizable options*/
%macro standardopts;
	options nodate number byline;
	title "Bookstore Report";
	footnote1 "Prepared &sysday &sysdate9 at &systime using SAS &sysver";
%mend standardopts;

/*Finding the path with the macro location*/
%let x = %sysfunc(pathname(sasautos));
%put &x;
* /sas/home/SASFoundation/9.4/sasautos;

options mautosource sasautos=(sasuatos, "/sas/home/SASFoundation/9.4/sasautos");
%standardopts;

proc print data=ytdsales;
run;
