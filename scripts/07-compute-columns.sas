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