/* Sorted data */
data storm2017;
	set pg2.storm_2017;
run;

proc sort data=storm2017 out=storm2017_sorted;
	by Basin;
run;

data storm2017_sorted;
	set storm2017_sorted;
run;

data storm2017_sorted_by;
	set storm2017_sorted;
	by Basin;
run;

proc contents data=storm2017_sorted;
proc contents data=storm2017_sorted_by;
run;

/* Identifying the First and Last Row in Each Group */
proc sort data=pg2.storm_2017 out=storm2017_sort(keep=Basin Name);
	by Basin;
run;

data storm2017_max;
	set storm2017_sort;
	by Basin;
	First_Basin=first.Basin;
	Last_Basin=last.Basin;
	Storm_Length=EndDate-StartDate;
run;

/* Next Example */
proc sort data=pg2.storm_2017 out=storm2017_sort;
	by Basin MaxWindMPH;
run;

data storm2017_max;
	set storm2017_sort;
	by Basin MaxWindMPH;
	StormLength=EndDate-StartDate;
	MaxWindKM=MaxWindMPH*1.60934;

	if last.Basin=1;
run;

/* Alternate solution */
proc sort data=pg2.storm_2017(drop=Location) out=storm_sort;
	by Basin descending MaxWindMPH;
run;

proc print data=storm_sort;
run;

data storm_2017_max_2;
	set storm_sort;
	by Basin;
	StormLength=EndDate-StartDate;

	if first.Basin=1;
run;

/* Check if there are the same results */
proc print data=storm2017_max;
proc print data=storm_2017_max_2;
run;

/* Next Example */
/* Rule: Use the If statement as early as possible */
proc sort data=pg2.storm_2017 out=storm2017_sort;
	by Basin MaxWindMPH;
run;

data storm2017_max;
	set storm2017_sort;
	by Basin;

	if last.Basin=1;
	StormLength=EndDate-StartDate;
	MaxWindKM=MaxWindMPH*1.60934;
run;

/* Own example */
data test;
	set pg2.weather_houston;
	keep Date Month DailyRain YTDRain;
	retain YTDRain 0;
	YTDRain=sum(YTDRain, DailyRain);
	month=month(Date);
run;

proc sort data=test out=test_sort;
	by Month;
run;

data mtd_month;
	set test_sort;
	by Month;
	retain MTDRain 0;

	if first.Month=1 then
		MTDRain=0;
	MTDRain=sum(MTDRain, DailyRain);
run;

/* Next example */
/* Note worthing: you don't have to use retain statement in this case */
data houston;
	set pg2.weather_houston;
	keep Date Month DailyRain MTDRain;
	by Month;

	if first.Month=1 then
		MTDRain=0;
	MTDRain+DailyRain;
run;

/* Next example */
/* Note mentioning: This code displays the last day in each month, which is very */
/* convenient way to show total values accumulated by month */
data houston_monthly;
	set pg2.weather_houston;
	keep Date Month DailyRain MTDRain;
	by Month;

	if first.Month=1 then
		MTDRain=0;
	MTDRain+DailyRain;

	if last.Month=1;
run;

/* In alternate scenario you can use only 'if last.Month;' at the end of this code */
data houston_monthly;
	set pg2.weather_houston;
	keep Date Month DailyRain MTDRain;
	by Month;

	if first.Month=1 then
		MTDRain=0;
	MTDRain+DailyRain;

	if last.Month;
run;

/* Sorting by multiple columns */
data sydney;
	set pg2.weather_sydney;
	by Year Qtr;
	FirstYear=first.Year;
	LastYear=last.Year;
	FirstQuarter=first.Qtr;
	LastQuarter=last.Qtr;
run;

/* Next Example */
data TypeTraffic;
	set;
run;

proc sort data=pg2.np_yearlytraffic(keep=ParkType ParkName Location Count) 
		out=sortedTraffic;
	by ParkType ParkName;
run;

data TypeTraffic;
	set sortedTraffic;
	keep ParkType TypeCount;
	by ParkType;
	format TypeCount comma20.;

	if first.ParkType=1 then
		TypeCount=0;
	TypeCount+Count;
run;

/* Display only last row in each ParkType */
data TypeTraffic;
	set sortedTraffic;
	keep ParkType TypeCount;
	by ParkType;
	format TypeCount comma20.;

	if first.ParkType=1 then
		TypeCount=0;
	TypeCount+Count;

	if last.ParkType;
run;

/* Next Example */
proc print data=sashelp.shoes(obs=3);
run;

proc sort data=sashelp.shoes out=shoes_sorted;
	by Region Product;
run;

data profit_summary(keep=Region Product Subsidiary Profit TotalProfit);
	set shoes_sorted;
	by Region Product;
	Profit=Sales - Returns;

	if first.Product=1 then
		TotalProfit=0;
	TotalProfit + Profit;

	if last.Product=1;
	format TotalProfit dollar20.;
run;

data profitsummary;
	set sort_shoes;
	by Region Product;
	Profit=Sales-Returns;

	if first.Product then
		TotalProfit=0;
	TotalProfit+Profit;

	if last.Product=1;
	keep Region Product TotalProfit;
	format TotalProfit dollar12.;
run;