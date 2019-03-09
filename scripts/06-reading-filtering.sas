data myclass;
	set sashelp.class;
run;

/*
Data Step is divided into two steps:
Compilation - check syntax for errors, identify columns
establish new table metadata and
Execution - read and write data, perform data manipulations,
calculations, and so on


Execution:
1) read a row from the input table
2) sequentially process statements
3) at run, write the row to the output table
4) loop back to the top and read the next row from the input table
*/
/* Filtering using where statement */
data myclass;
	set sashelp.class;
	where Age >=15;
run;

/* Keep allows you to specify particular columns in particular order */
data myclass;
	set sashelp.class;
	where Age >=15;
	keep Name Age Height;
run;

/* Drop allows you to drop particular column(s) */
data myclass;
	set sashelp.class;
	where Age >=15;
	drop Sex;
run;

/* Adding permanent format to the SAS table */
data myclass;
	set sashelp.class;
	where Age >=15;
	format height 4.1 weight 3.;
run;

libname out "/folders/myfolders/SAS-Course/output";

data Storm_cat5 out.Storm_cat5;
	set pg1.storm_summary;
	where MaxWindMPH ge 156 and StartDate > '01JAN2000'd;
	keep Season Basin Name Type MaxWindMPH;
run;

libname out clear;

/* Homework solution */
proc print data=pg1.eu_occ(obs=10);
run;

proc contents data=pg1.eu_occ;
run;

data eu_occ2016;
	set pg1.eu_occ;
	where YearMon like "2016%";
	format Hotel ShortStay Camp comma17.;
	drop Geo;
run;