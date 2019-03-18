*****************************
*	Syntax:
*		DATA output-table;
*			SET input-tab-1 input-tab-2;
*		RUN;
*****************************;

libname pg2 "/home/krakowiakpawel90/EPG294/data";

proc print data=sashelp.class;
proc print data=pg2.class_new;
run;

/* Concatenate two tables */
data concat_tab;
	set sashelp.class pg2.class_new;
run;

/* Next Example */
proc print data=pg2.storm_summary(obs=10);
proc print data=pg2.storm_2017(obs=2);
run;

data concat;
	set pg2.storm_summary(rename=(Season=Year)) pg2.storm_2017(drop=Location);
run;

proc sort data=concat;
	by descending StartDate;
run;

/* Homework Solution */
data class_current;
	length Name $ 12;
	set sashelp.class 
	pg2.class_new2(rename=(Student=Name));
run;

proc contents data=sashelp.class;
run;

proc contents data=pg2.class_new2;
run;

/* Homework Solution */
data work.np_combine;
	set;
	drop Camping:;
run;

data tab;
	set pg2.np_2015 pg2.np_2016;
	where Month in (6, 7, 8) and Year=2016;
	CampTotal=sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
	format CampTotal comma20.;
	keep ParkCode Month CampTotal Year;
run;

proc sort data=tab out=sorted_tab;
	by ParkCode;
run;

/* Homework Solution */
proc print data=pg2.np_2014(obs=1);
run;

proc print data=pg2.np_2015(obs=1);
run;

proc print data=pg2.np_2016(obs=1);
run;

data work.np_combine;
	set;
	drop Camping:;
run;

data tab;
	set pg2.np_2014(rename=(Park=ParkName Type=ParkType)) pg2.np_2015 pg2.np_2016;
	where Month in (6, 7, 8) and ParkType="National Park";
	CampTotal=sum(of Camping:);
	format CampTotal comma20.;
	drop Camping:;
run;

proc sort data=tab out=sorted_tab;
	by ParkType ParkCode Year Month;
run;