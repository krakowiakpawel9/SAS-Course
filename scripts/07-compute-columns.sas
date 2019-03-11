data cars_new;
	set sashelp.cars;
	where Origin ne 'USA';
	Profit=MSRP - Invoice;
	Source="Non-US Cars";
	format Profit dollar10.;
	keep Make Model MSRP Invoice Profit Source;
run;

libname pg1 "/folders/myfolders/SAS-Course/data";

data tropical_storm;
	set pg1.storm_summary;
	drop Hem_EW HEM_NS Lat Lon;
	where Type="TS";
	MaxWindKM=MaxWindMPH*1.60934;
	format MaxWindKM 5.1;
	StormType="Tropical Storm";
run;

data trop_clean;
	set tropical_storm;
	where MaxWindKM is not missing;
run;

proc sort data=trop_clean noduprecs out=trop_sort dupout=trop_dups;
	by descending MaxWindKM;
run;

data storm_length;
	set pg1.storm_summary;
	StormLength=EndDate - StartDate;
	keep Season Name StormLength;
run;

proc sort data=storm_length;
	by descending StormLength;
run;

/* Common Summary Functions */
/* n(num_1, num_2) returns the number of nonmissing values */
/* nmiss(num_1, num_2) returns the number of missing values */
data test;
	input val_1 val_2 val_3;
	datalines;
100 90 230
60 49 100
45 10 42
;
run;

data test_calc;
	set test;
	Sum=sum(val_1, val_2, val_3);
	Mean=mean(val_1, val_2, val_3);
	Median=median(val_1, val_2, val_3);
	range=range(val_1, val_2, val_3);
	min=min(val_1, val_2, val_3);
	max=max(val_1, val_2, val_3);
	n=n(val_1, val_2, val_3);
	nmiss=nmiss(val_1, val_2, val_3);
run;

proc print data=pg1.storm_range;
run;

data wind;
	set pg1.storm_range;
	WindAvg=mean(Wind1, Wind2, Wind3, Wind4);
	WindRange=range(Wind1, Wind2, Wind3, Wind4);
run;

/* Common Character Functions */
data test2;
	input name $ profession $14.;
	datalines;
Pawel data_scientist
Tomek student
Teresa salesman
;
run;

data test_fun;
	set test2;
	upcase_name=upcase(name);
	lowcase_name=lowcase(name);
	propcase_name=propcase(name);
	cats_name_profession=cats(' ', name, profession);
	substr_name=substr(name, 2, 2);
run;

/* Practice example */
data np_summary_update;
	set pg1.np_summary;
	SqMiles=Acres*0.0015625;
	Camping=sum(TentCampers, RVCampers, BackcountryCampers, OtherCamping);
	format SqMiles Camping comma10.;
	keep ParkName SqMiles Camping;
run;

/* Practice example 2 */
data eu_occ_total;
	set pg1.eu_occ;
	year=substr(YearMon, 1, 4);
	month = substr(YearMon, 6, 2);
	ReportDate = mdy(month, 1, year);
	Total=sum(Hotel, ShortStay, Camp);
	format Hotel ShortStay Camp Total comma12. ReportDate monyy7.;
	keep Country Hotel ShortStay Camp ReportDate Total;
run;