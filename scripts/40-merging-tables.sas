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


/* Homework Solution */
proc print data=pg2.storm_final(obs=10);
proc print data=pg2.storm_damage(obs=10);
run;

proc sort data=pg2.storm_final out=storm_final_sort;
	by Season Name;
run;

data storm_damage;
	set pg2.storm_damage;
	Season=Year(date);
	Name=upcase(scan(Event, -1));
	format Date date9. Cost dollar16. deaths comma5.;
	drop event;
run;

proc sort data=storm_damage;
	by Season Name;
run;

data damage_detail storm_other(drop=Cost Deaths);
	merge storm_final_sort(in=inFinal) storm_damage(in=inDamage);
	keep Season Name BasinName MaxWindMPH MinPressure Cost Deaths;
	by Season Name;

	if inDamage=1 and inFinal=1 then
		output damage_detail;
	else
		output storm_other;
run;

/* Homework Solution */
/* Merging Tables with Matching Column Names */
/* Below table from 2017 overwrites all values in the table 2016 */
proc print data=pg2.weather_sanfran2016;
proc print data=pg2.weather_sanfran2017;
proc print data=weather_sanfran;
run;

data weather_sanfran;
	merge pg2.weather_sanfran2016 pg2.weather_sanfran2017;
	by month;
run;

/* Better Solution */
/* Keeping all value columns */
data weather_sf;
merge pg2.weather_sanfran2016(rename=(AvgTemp=AvgTemp2016))
	  pg2.weather_sanfran2017(rename=(AvgTemp=AvgTemp2017));
by Month;
run;

/* Homework Solution */
proc print data=pg2.class_update;
proc print data=pg2.class_teachers;
proc print data=pg2.class_rooms;
run;

proc sql;
	select * from pg2.class_update cu inner join pg2.class_teachers ct on 
		cu.name=ct.name inner join pg2.class_rooms cr on ct.teacher=cr.teacher;
quit;

proc sort data=pg2.class_update out=update_sort;
	by name;

proc sort data=pg2.class_teachers out=teachers_sort;
	by name;

data two;
	merge update_sort teachers_sort;
	by name;
run;

/* Homework Solution */
proc print data=pg2.np_2016(obs=10);
proc print data=pg2.np_codelookup(obs=10);
run;

proc sql;
	create table parkStats as select * from pg2.np_2016 y inner join 
		pg2.np_codelookup c on y.parkcode=c.parkcode;
quit;

/* Using SAS Merge */
proc sort data=pg2.np_CodeLookup
          out=work.sortedCodes;
    by ParkCode;
run;

proc sort data=pg2.np_2016
          out=work.sorted_code_2016;
    by ParkCode;
run;

data work.parkStats(keep=ParkCode ParkName Year Month DayVisits)
     work.parkOther(keep=ParkCode ParkName);
    merge work.sorted_code_2016(in=inStats) work.sortedCodes;
    by ParkCode;
    if inStats=1 then output work.parkStats;
    else output work.parkOther;
run;