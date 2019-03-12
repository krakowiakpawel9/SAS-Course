*******************************
*	Exporting Results to PDF
*	PROCLABEL labels the bookmark
*	PDFTOC controls level of bookmarks
*
*	Syntax: 
*		ODS PDF FILE="filename.pdf" STYLE=style STARTPAGE=NO PDFTOC=n;
*		ODS PROCLABEL 'label';
*			<sas code>
*		ODS PDF CLOSE;
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

/* Own Sample */
ods pdf file="/home/S1613351/output/test.pdf" pdftoc=1;
ods noproctitle;
title "First part";

proc print data=test;
run;

title "Second part";

proc means data=test;
run;

ods pdf close;

/* Second Sample */
/* Startpage=no eliminates page breaks into report */
ods pdf file="/home/S1613351/output/test.pdf" pdftoc=1 startpage=no style=journal;
ods noproctitle;
title "First part";

proc print data=test;
run;

title "Second part";

proc means data=test;
run;

title "Graphs";

proc sgplot data=test;
	histogram price / nbins=10;
	density price;
run;

ods pdf close;

/* Third Example */
ods pdf file="/home/S1613351/output/test.pdf" pdftoc=1 startpage=no style=journal;
ods noproctitle;

ods proclabel "First";
title "First part";
proc print data=test;
run;

ods proclabel "Second";
title "Second part";

proc means data=test;
run;

ods proclabel "Third";
title "Graphs";

proc sgplot data=test;
	histogram price / nbins=10;
	density price;
run;

ods pdf close;
