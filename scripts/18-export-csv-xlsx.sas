*******************************
*	Output Delivery System
*	Common Types: XLSX, RTF(wrod), PPTX(power point), PDF
*
*	Syntax: 
*		ODS <destination> <destination-specifications>;
*			<sas code>
*		ODS <destination> CLOSE;
*******************************;

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

*	Exporting Results to CSV file

*******************************
*	Syntax:
*		ODS CSVALL FILE="filename.csv";
*		<sas code>
*		ODS CSVALL CLOSE;
*******************************;
ods csvall file="/home/S1613351/output/test_csv.csv";

proc print data=test;
run;

proc print data=test;
	where type="Sedan";
run;

ods csvall close;
*	Exporting results to Excel
******************************
*	Syntax:

	*		ODS EXCEL FILE='filename.xlsx' STYLE=style OPTIONS(SHEET_NAME='label');
*		<sas code>
*		ODS EXCEL CLOSE;
******************************;
ods excel file="/home/S1613351/output/test_xlsx.xlsx";
title "First title";
ods noproctitle;

proc print data=test;
run;

title "Basic Staistics";

proc means data=test;
run;

title "Histogram and Density";

proc sgplot data=test;
	histogram price / nbins=10;
	density price;
run;

title;
ods proctitle;
ods excel close;
*	View different styles that are available:
* 		PROC TEMPLATE;
*			list styles;
*		RUN;

proc template;
	list styles;
run;

/* Next Example */
ods excel file="/home/S1613351/output/test_xlsx.xlsx" options(sheet_name="First table") style=sasdocprinter;
title "First title";
ods noproctitle;

proc print data=test;
run;

ods excel options(sheet_name="Basic Stats");
title "Basic Staistics";

proc means data=test;
run;

ods excel options(sheet_name="Histogram");
title "Histogram and Density";

proc sgplot data=test;
	histogram price / nbins=10;
	density price;
run;

title;
ods proctitle;
ods excel close;
