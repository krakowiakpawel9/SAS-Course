******************************
*	Compilation
*	1) check for syntax error
*	2) create the program data vector PDV
*	3) establish rules for procesing data in the PDV
*	4) create descriptor portion of output table
*	Execution
* 	1) initialize PDV
*	2) read a row from the input table
*	3) sequentailly process statements
*
*	Syntax:
*		DATA output-table;
*			set input-table;
*			<sas code>
*		RUN;
******************************;

data my_car;
	set sashelp.cars;
run;

proc contents data=my_car;
run;

proc print data=my_car(obs=10) label;
run;

proc print data=my_car(obs=10);
run;

data my_car_proc;
	set my_car;
	keep Make Model Type Origin MSRP EngineSize Abbrev;

	if Origin="Asia" then
		Abbrev="A";
	else if Origin="Europe" then
		Abbrev="E";
	else
		Abbrev="P";
run;

proc contents data=my_car_proc;
run;

proc univariate data=my_car_proc;
run;

proc print data=my_car_proc(obs=10);
run;

proc freq data=my_car_proc;
	tables origin;
run;

/* Next Example */
proc print data=sashelp.airline;
run;

data first second third;
	set sashelp.airline;
	No_of_days=today() - date;

	if air < 200 then
		do;
			AirGroup=1;
			output first;
		end;
	else if air < 400 then
		do;
			AirGroup=2;
			output second;
		end;
	else
		do;
			AirGroup=3;
			output third;
		end;
run;

/* Shoes dataset */
proc print data=sashelp.shoes(obs=10);
run;

proc contents data=sashelp.shoes;
run;

data shoes_proc;
	set sashelp.shoes;
run;

ods graphics on;

proc freq data=shoes_proc order=data;
	tables Region / plots=freqplot();
run;

proc freq data=shoes_proc order=data;
	tables Product / plots=freqplot();
run;

