************************************************
*	PROC MEANS DATA=input-table <stats-list>;
*   	VAR col-names(s);
* 		CLASS col-name(s);
*		WAYS n;
* 	RUN;
************************************************;

data test;
	input model $ type $ price volume flag $;
	datalines;
MDX SUV 36945 20 y
RSX Sedan 23820 10 n
TSX Sedan 26690 15 n
NSX Sports 89000 25 n
LSX Sports 90000 25 n
Jaguar Sports 120000 45 y
CRV SUV 80000 30 y
CRV SUV 89000 45 y
;
run;

proc means data=test;
run;

proc means data=test mean median min max stddev;
run;

/* Display particular variable */
proc means data=test mean median min max stddev;
	var price;
run;

/* Display statistics based on one variable */
proc means data=test;
	var price;
	class type;
run;

/* Display statistics based on one variable */
proc means data=test;
	var price;
	class type flag;
run;

proc means data=test;
	class type;
run;

/* ways allows to control how the values of classification var segments the data
0 - zero classification
1 - one classification
2 - two classification
in this case*/
proc means data=test;
	class type flag;
	ways 1;
run;

proc means data=test;
	class type flag;
	ways 2;
run;

proc means data=test;
	class type flag;
	ways 0 1 2;
run;

/* Creating output summary table */
*************
*	Syntax:
*		OUTPUT OUT=output-table <statistics(col-name)-col-name> </option(s)>;
*************;
proc means data=test;
	class flag type;
	ways 2;
	output out=test_stats;
run;

proc means data=test noprint;
	class flag type;
	ways 2;
	output out=test_stats mean(price)=price min(price)=min_price;
	
run;
