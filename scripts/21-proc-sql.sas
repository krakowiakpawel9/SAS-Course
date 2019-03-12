*****************************
*	Syntax:
*		PROC SQL;
*		<statements>
*		QUIT;
*
*	Example:
*		PROC SQL;
*		SELECT col FROM table WHERE clause ORDER BY col;
*		QUIT;
*****************************;

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

proc sql;
	select * from test;
quit;

proc sql;
	select * from test where type="SUV" order by model;
quit;

/* You can add format directly in your SQL statement */
proc sql;
	select model, type, price format dollar10., price*3.7 as price_pln 
		format=comma10., flag from test order by price desc;
quit;

proc sql;
	select * from test order by model, type;
quit;

/* Creating new columns */
title "Text Functions";

proc sql;
	select *, upcase(type) as type_upcase, lowcase(type) as type_lowcase, 
		propcase(model) as model_propcase from test;
quit;

/* Creating table */
************************
*	Syntax:
*		PROC SQL;
*		CREATE TABLE table-name AS
*		SELECT * FROM table;
*		QUIT;
************************;
proc sql;
	create table work.sample_table as 
	select * from test;
quit;

/* Droping table */
************************
*	Syntax:
*		PROC SQL;
*		DROP TABLE work.table;
*		QUIT;
************************;
proc sql;
drop table work.sample_table;
quit;

