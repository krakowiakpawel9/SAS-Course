/* Putlog allows to make simple debugging process if you don't have access to EG */
data myclass;
	set sashelp.class(obs=3);
	putlog "PDV after set statement";
	putlog _all_;
	putlog name;
run;

data test;
	input id name $;
	putlog "After input statement";
	putlog _all_;
	datalines;
1 pawel
2 tomek
3 rysiu
;
run;

***********************************************************;
*  Syntax                                                 *;
*     PUTLOG _ALL_;
*;
*     PUTLOG column=;
*;
*     PUTLOG "message";
*;
***********************************************************;
libname pg2 "/home/krakowiakpawel90/EPG294/data";

data storm_complete;
	set pg2.storm_summary_small(obs=2);
	putlog "NOTE:PDV after SET statement";
	putlog _all_;
	length Ocean $ 8;
	drop EndDate;
	where Name is not missing;
	Basin=upcase(Basin);
	StormLength=EndDate-StartDate;
	putlog StormLength=;

	if substr(Basin, 2, 1)="I" then
		Ocean="Indian";
	else if substr(Basin, 2, 1)="A" then
		Ocean="Atlantic";
	else
		Ocean="Pacific";
	putlog "PDV Before RUN Statement";
	putlog stormlength=;
run;

/* Next Example */
data np_parks(obs=5);
	set pg2.np_final;
	putlog "NOTE:Start Data Step Iteration";
	keep Region ParkName AvgMonthlyVisitors Acres Size Type;
	length Size $ 10;
	type=propcase(type);
	putlog type=;
	where type="PARK";
	AvgMonthlyVisitors=sum(DayVisits, Campers, OtherLodging) / 12;
	format AvgMonthlyVisitors comma10.;

	if Acres < 1000 then
		Size="Small";
	else if Acres < 100000 then
		Size="Medium";
	else
		Size="Large";
	putlog _all_;
run;

proc print data=np_parks;
run;

/* Next Example */
/* This example is incorrect, without output statement in particular step
you can't add the calcualted row to the output table */
data forecast;
	set sashelp.shoes;
	keep Region Product Subsidiary Year ProjectedSales;
	format ProjectedSales dollar10.;
	Year=1;
	ProjectedSales=Sales*1.05;
	putlog Year= ProjectedSales= _N_=;
	Year=2;
	ProjectedSales=ProjectedSales*1.05;
	putlog Year= ProjectedSales= _N_=;
	Year=3;
	ProjectedSales=ProjectedSales*1.05;
	putlog Year= ProjectedSales= _N_=;
run;

/* Adding output statement to write row to output column */
data forecast;
	set sashelp.shoes;
	keep Region Product Subsidiary Year ProjectedSales;
	format ProjectedSales dollar10.;
    Year=1;
	ProjectedSales=Sales*1.05;
	output;
	ProjectedSales=ProjectedSales*1.05;
	Year=2;
	output;
	Year=3;
	ProjectedSales=ProjectedSales*1.05;
	output;
run;

/* When explicit output is enabled the inplicit output is enabled */
data fore;
	set sashelp.shoes;
	format ProSales comma10.;
	test = 3;
	test_power = test**2;
	year=1;
	ProSales=Sales*1.05;
	output;
	year=2;
	ProSales=ProSales*1.05;
	output;
	year=3;
	ProSales=ProSales*1.05;
	*output;
run;
