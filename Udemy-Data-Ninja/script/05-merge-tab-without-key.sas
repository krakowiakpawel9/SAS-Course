/* merge to differnet tables */
data tab_1;
	input age name $;
	datalines;
25 pawel
34 janek
18 wacek
;
run;

data tab_2;
	input birthday date9. gender $;
	format birthday ddmmyy10.;
	datalines;
05OCT1992 M
15MAR1991 M
29NOV1999 M
;
run;

proc print data=tab_1;
proc print data=tab_2;
	/* how to join these two tables? */
	/* You have to create a artificial key */
data tab_1_key;
	set tab_1;
	id + 1;
run;

data tab_2_key;
	set tab_2;
	id + 1;
run;

proc print data=tab_1_key;
proc print data=tab_2_key;
run;

data merging;
	merge tab_1_key tab_2_key;
	by id;
	drop id;
run;