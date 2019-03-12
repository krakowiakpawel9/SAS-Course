data fore;
	set sashelp.shoes;
	year=1;
	ProSales=Sales*1.05;
	year=2;
	ProSales=ProSales*1.05;
run;

/* Sending output to multiple tables */
data sales_high sales_low;
	set sashelp.shoes;

	if Sales > 100000 then
		output sales_high;
	else
		output sales_low;
run;

proc print data=sashelp.shoes(obs=4);
run;

proc freq data=fore;
	tables Region;
run;

/* Drop and Keep statements, more options */
/* First drop allows to drop column from sales_high table */
data sales_high(drop=Stores) sales_low(drop=Region);
	set sashelp.shoes;
	drop Returns;

	if Sales > 100000 then
		output sales_high;
	else
		output sales_low;
run;
