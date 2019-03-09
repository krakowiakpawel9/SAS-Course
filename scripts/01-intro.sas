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