/* essential reviews */
data shoes;
	set sashelp.shoes;
	Profit=Sales - Returns;
	format Profit dollar12.;
	label Profit="Profit (USD)";
run;

proc print data=shoes;
run;

proc means data=shoes;
	var Profit;
	class Region Subsidiary;
run;

proc means data=shoes noprint;
	var Profit;
	class Region Subsidiary;
	output out=shoes_summary sum=Profit;
	ways 2;
run;

proc print data=shoes_summary(obs=5);
run;

title "Shoes Profit by Region, Subsidiary";

proc print data=shoes_summary noobs;
	by Region;
	var Subsidiary Profit;
run;

title;
libname cr "/folders/myfolders/SAS-Course/practicalSAS/data";

data CanadaSales;
	set sashelp.prdsale;
	where Country="CANADA" and Quarter=1;
	Diff=Actual-Predict;
run;

*
This program analyzes blood pressure
in the SASHELP.HEART table.
*;

proc freq data=sashelp.heart;
    table BP_Status;
run;

proc means data=sashelp.heart min max mean maxdec=0;
    var systolic diastolic;
    class BP_Status;
run;