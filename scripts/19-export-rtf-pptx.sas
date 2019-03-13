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

*	Exporting Results to PPTX file 

*******************************
*	Syntax:
*		ODS POWERPOINT FILE="filename.pptx" STYLE=style;
*		<sas code>
*		ODS POWERPOINT CLOSE;
*******************************;
ods powerpoint file="/home/S1613351/output/test.pptx";
title "First title";

proc print data=test;
run;

title "Second title";

proc means data=test;
run;

ods powerpoint close;
title;
*	Exporting Results to RTF file (word)

*******************************
*	Syntax:
*		ODS RTF FILE="filename.rtf" STARTPAGE=NO;
*		<sas code>
*		ODS RTF CLOSE;
*******************************;
ods rtf file="/home/S1613351/output/test.rtf";
proc print data=test;
run;

proc means data=test;
run;
ods rtf close;

/* Next Example */
ods powerpoint file="/home/krakowiakpawel90/EPG194/output/pressure.pptx" style=powerpointlight;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods powerpoint close;


ods rtf file="/home/krakowiakpawel90/EPG194/output/pressure.rtf" style=powerpointlight startpage=NO;

title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;

title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

ods rtf close;
