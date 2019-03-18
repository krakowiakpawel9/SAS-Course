*************
*one-to-one
*one-to-many
*no-matching rows
*
*	DATA output;
*	MERGE input_1 input_2;
*	BY col;
*	RUN;
*
*************;

proc print data=sashelp.class;
proc print data=pg2.class_teachers;
run;

data merged_tab;
	merge sashelp.class pg2.class_teachers;
	by name;
run;

/* Homework Solution */
proc sort data=pg2.class_teachers out=teachers_sort;
	by Name;
run;

proc sort data=pg2.class_test2 out=test2_sort;
	by Name;
run;

data class2;
	merge teachers_sort test2_sort;
	by Name;
run;

/* Homework Solution */
proc print data=pg2.storm_summary(obs=3);
proc print data=pg2.storm_basincodes;
run;

proc sort data=pg2.storm_summary;
	by Basin;

proc sort data=pg2.storm_basincodes;
	by BasinCode;
run;

data merged_basin;
	merge pg2.storm_basincodes(rename=(BasinCode=Basin)) pg2.storm_summary;
	by Basin;
run;

/* Homework Solution */
/* Identifying matches and nonmatches */
*
*	DATA output;
*	MERGE input_1(in=variable) 
*		  input_2(in=variable);
*	BY col;
*	RUN;
*
*************;

proc print data=pg2.class_update;
proc print data=pg2.class_teachers;
run;

data class2;
	merge pg2.class_update pg2.class_teachers;
	by name;
run;

data class3;
	merge pg2.class_update(in=inUpdate) pg2.class_teachers(in=inTeachers);
	by name;

	if inUpdate=1 and inTeachers=1;
run;

/* Next Example */
proc print data=pg2.storm_final(obs=3);
proc print data=pg2.storm_damage(obs=3);
run;

data storm_damage;
	set pg2.storm_damage;
	Season=Year(Date);
	Name=scan(Event, -1);
	drop Event;
	format Date date9. Cost dollar16. deaths comma5.;
run;


TBA...