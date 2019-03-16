/* This is the initial file about SAS capabilities */
data myclass;
	set sashelp.class;
run;

proc print data=myclass;
run;

data myclass_2;
	set sashelp.class;
	height_cm=height*2.54;
	format height_cm 3.;
run;

proc print data=myclass_2;
run;

proc means data=myclass_2;
	var age height_cm;
run;

/* Basic operations with cars dataset */
data mycars;
	set sashelp.cars;
	AvgMPG=mean(MPG_City, MPG_Highway);
run;

title "Cars with column AvgMPG (Average Miles Per Galon)";

proc print data=mycars(obs=10);
run;

title "Cars with AvgMPG over 35";

proc print data=mycars;
	where AvgMPG > 35;
run;

title "Average miles per galon by type";

proc means data=mycars order=freq;
	var AvgMPG;
	class Type;
run;

title "Average miles per galon by type (only providing stats)";

proc means data=mycars min max mean stddev order=freq;
	var AvgMPG;
	class Type;
run;

title;

/* Basic operations with shoes dataset */
data canadashoes;
	set sashelp.shoes;
	where region="Canada";
	Profit=Sales-Returns;
run;

proc print data=canadashoes;
run;