/* Creating simple tables */
data test;
	length Basin $15 Basin_Name $ 15;
	infile datalines dsd;
	input Basin $ Basin_Name $;
	datalines;
AS,Araban Sea
BB,Bay of Bengal
;
run;

data test_2;
	length A $ 10;
	infile datalines dlm='#';
	input X Y A $ Z;
	datalines;
1#2#Hello#3
10#22#Hello You#30
;
run;

*********************************
*	Table structure
*	FmtName | Start | Label
*	***		| ***	| ***
*
*	FmtName - name of format, start - values you want to format, label - label to apply to the value
*
*	FmtName | Start | End	| Label
*	***		| ***	| ***	| ***
*
* 	End - end value of a range
*
*	PROC FORMAT cntlin=work.sbdata;
*	RUN;
*
*********************************;

/* Define two custom formats from tables */
data sbdata;
	retain FmtName '$sbfmt';
	set pg2.storm_subbasincodes(rename=(Sub_Basin=Start SubBasin_Name=Label));
	keep Start Label FmtName;
run;

data catdata;
	retain FmtName 'catfmt';
	set pg2.storm_categories(rename=(Low=Start High=End Category=Label));
run;

proc format cntlin=sbdata;
run;

proc format cntlin=catdata;
run;

*********************************;

proc print data=pg2.storm_subbasincodes;
run;

proc print data=sbdata;
run;

proc print data=pg2.storm_detail(obs=10);
	format Sub_Basin $sbfmt.;
run;

proc freq data=pg2.storm_detail;
	tables Sub_Basin;
	format Sub_Basin $sbfmt.;
run;

title "Frequency of Eind Measurements for Storm Categories by SubBasin";

proc freq data=pg2.storm_detail;
	tables Sub_Basin*Wind / nocol norow nopercent;
	format Sub_Basin $sbfmt. Wind catfmt.;
run;

title;

/* Own Example */
/* Create source table */
data test;
	input id $ name $;
	infile datalines dlm=',';
	datalines;
PK,PawelK
MK,MateuszK
TK,TomaszK
;
run;

/* Create Format Table */
data fmttest;
	retain FmtName '$fmtname';
	set test(rename=(id=Start name=Label));
	keep Start Label FmtName;
run;

proc format cntlin=fmttest;
run;

/* Test Solution */
data test_sol;
	input id $ height;
	infile datalines dlm=',';
	format id $fmtname.;
	datalines;
PK,185
MK,182
TK,178
;
run;

/* Homework Example */
/* Define first format (character) */
proc print data=pg2.storm_subbasincodes;
run;

data sbdata;
	retain FmtName '$sbfmt';
	set pg2.storm_subbasincodes(rename=(Sub_Basin=Start SubBasin_Name=Label));
	keep Start Label FmtName;
run;

proc format cntlin=sbdata;
run;

proc print data=pg2.storm_detail(obs=10);
	format Sub_Basin $sbfmt.;
run;

proc print data=pg2.storm_categories;
run;

/* Define second format (numeric) */
data catdata;
	retain FmtName 'catfmt';
	set pg2.storm_categories(rename=(Low=Start High=End Category=Label));
	keep Start End Label FmtName;
run;

proc format cntlin=catdata;
run;

proc print data=catdata;
run;

proc print data=pg2.storm_summary(obs=10);
	format MaxWindMPH catfmt.;
run;

/* Testing */
data test_fmt;
	set pg2.storm_summary(obs=10);
	format MaxWindMPH catfmt.;
run;

data test_fmt;
	set pg2.storm_detail(obs=10);
	format Sub_Basin $sbfmt.;
run;

/* Very useful feature - displays summary of each format */
proc format library=work;
	select $sbfmt catfmt;
run;

**********************
*	Homework Solution
**********************;

proc print data=pg2.class_birthdate;
run;

proc format library=pg2;
	value $genfmt 'F'='Female' 'M'='Male';
	value wgtfmt low-<80='Below Average' 80-100='Average' 
		100<-high="Above Average";
run;

options fmtsearch=(pg2);

proc print data=pg2.class_birthdate noobs;
	where Age=12;
	var Name Gender Weight;
	format Gender $genfmt. Weight wgtfmt.;
run;

**********************
*	Homework Solution
**********************;

proc print data=pg2.np_monthlytraffic(obs=10);
run;

proc print data=pg2.np_codelookup;
run;

data lookup;
	retain FmtName '$park';
	set pg2.np_codelookup(rename=(ParkCode=Start Type=Label));
	keep Start Label FmtName;
run;

proc format cntlin=lookup;
run;

proc means data=pg2.np_monthlytraffic maxdec=1 mean min max stddev;
	var Count;
	class ParkCode Month;
	format ParkCode $park.;
run;

**********************
*	Homework Solution
**********************;

proc print data=pg2.np_species(obs=10);
run;

proc print data=pg2.np_codelookup;
run;

data custom_format;
	retain FmtName '$fmt';
	set pg2.np_codelookup(rename=(ParkCode=Start));

	if Region ne ' ' then
		Label=Region;
	else
		Label='Unknown';
	keep Start Label FmtName;
run;

proc print data=custom_format;
run;

proc format cntlin=custom_format;
run;

proc print data=pg2.np_species(obs=10);
	format ParkCode $fmt.;
run;

data new_data;
	set pg2.np_species;
	Region=put(ParkCode, $fmt.);
run;

proc means data=new_data;
	class Region;
run;

data np_endanger;
	set pg2.np_species;
	where Conservation_Status='Endangered';
	Region=put(ParkCode, $fmt.);
run;

proc freq data=np_endanger;
	tables Region;
run;