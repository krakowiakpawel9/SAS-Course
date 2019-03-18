proc print data=pg2.class_birthdate noobs;
run;

proc print data=pg2.class_birthdate noobs;
	format Height Weight 3.0 Birthdate date9.;
run;

/* Homework solution */
data work.stocks;
	set pg2.stocks;
	CloseOpenDiff=Close-Open;
	HighLowDiff=High-Low;
	format Date monyy7. Volume comma12. CloseOpenDiff HighLowDiff dollar8.2;
run;

proc print data=stocks (obs=5);
	var Stock Date Volume CloseOpenDiff HighLowDiff;
run;

proc means data=stocks maxdec=0 nonobs mean min max;
	class Stock Date;
	var Open;
	*add a FORMAT statement;
run;

proc means data=stocks maxdec=0 nonobs mean min max;
	class Stock Date;
	var Open;
	format Date year.;
run;

******************
*	Custom Format
*	PROC FORMAT;
*		VALUE format-name value-or-range-1='formatted-value'
*		VALUE format-name value-or-range-2='formatted-value'
*		...;
*	RUN;
******************;

proc print data=pg2.class_birthdate;
run;

/* Creating custom format */
/* This format can be applied to any columns and tables  */
proc format;
	value $genfmt 'F'='Female' 'M'='Male';
run;

proc print data=pg2.class_birthdate;
	format gender $genfmt.;
run;

/* Homework Solution */
/* hrange - it works only for integer values */
proc format;
	value $genfmt 'F'='Female' 'M'='Male';
	value hrange 50-57='Below average' 58-60='Average' 61-70='Above Average';
	value hrange_ 50-<58='Below Average' 58-60='Average' 60<-70='Above Average';
	value _hrange low-<58='Below Average' 58-60='Average' 60<-high='Above Average';
	value $genfmtmore 'F'='Female' 'M'='Male' other='Miscoded';
run;

proc print data=pg2.class_birthdate noobs;
	format Gender $genfmt. Height _hrange.;
	where Age=12;
	var Name Gender Height;
run;

/* Next Solution */
proc format;
	value stdate low-'31DEC1999'd='1999 and before' 
		'01JAN2000'd - '31DEC2009'd='2000 to 2009' 
		'01JAN2010'd - high='2010 and later'
		.='Not Supplied';
	value $region 'NA'='Atlantic' 'WP', 'EP', 'SP'='Pacific' 'NI', 'SI'='Indian' 
		' '='Missing' other='Unknown';
run;

proc freq data=pg2.storm_summary;
	tables StartDate*Basin / norow nocol;
	format StartDate stdate. Basin $region.;
run;

/* Homework Solution */
proc format;
	value $region 'NA'='Atlantic' 'WP', 'EP', 'SP'='Pacific' 'NI', 'SI'='Indian' 
		' '='Missing' other='Unknown';
run;

data storm_summary;
	set pg2.storm_summary;
	Basin=upcase(Basin);
	*Delete the IF-THEN/ELSE statements and replace them with an assignment statement;

	if Basin='NA' then
		BasinGroup='Atlantic';
	else if Basin in ('WP', 'EP', 'SP') then
		BasinGroup='Pacific';
	else if Basin in ('NI', 'SI') then
		BasinGroup='Indian';
	else if Basin=' ' then
		BasinGroup='Missing';
	else
		BasinGroup='Unknown';
run;

data storm_summary_smart;
	set pg2.storm_summary;
	Basin=upcase(Basin);
	BasinGroup=put(Basin, $region.);
run;

proc means data=storm_summary_smart maxdec=1;
	class BasinGroup;
	var MaxWindMPH MinPressure;
run;

/* Homework Solution */
proc format;
	value $highreg 'IM'='Intermountain' 'PW'='Pacific West' 'SE'='Southeast' 
		other='Other Regions';
run;

title 'High Frequency Regions';

proc freq data=pg2.np_summary order=freq;
	tables Reg;
	label Reg='Region';
	format Reg $highreg.;
run;

title;

/* Homework Solution */
proc print data=pg2.np_acres(obs=10);
run;

proc format;
	value psize low-<10000='small' 10000-500000='medium' 500000<-high='large';
run;

data ParkSizeTab;
	set pg2.np_acres;
	ParkSize=put(GrossAcres, psize.);
run;