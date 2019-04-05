/*Program 3.1*/
%let reptitle = Book Section;
%let repvar = section;

/*Without macro variable*/
title "Frequencies by Book Section as of Friday";

proc freq data=books.ytdsales;
	tables section;
run;

/*With macro */
title "Frequencies by &reptitle as of &sysday";

proc freq data=ytdsales;
	tables &repvar;
run;

/*Program 3.2*/
%let reptitle = Book Section;
%let repvar = section;
title "Frequencies by &reptitle as of &sysday";

proc freq data=ytdsales;
	tables &repvar;
run;

title "Means by &reptitle as of &sysday";

proc means data=ytdsales;
	class &repvar;
	var saleprice;
run;

/*Display values of macro variables
%PUT var*/
%put &repvar;
%put &sysdate;
%put &sysdate9;
%put &sysday;
%put &systime;
%put &sysver;
%put _all_;
%put _automatic_;

* depends on your version of SAS;
%put _global_;

* user-defined global macro variable;
%put _local_;
%put _user_;

* user-defined global and local macro variables;
/*Making own ERROR, WARNING, NOTE*/
%put ERROR: Pierwszy własny błąd;
%put WARNING: Pierwsze ostrzeżenie;
%put NOTE: Pierwsza notatka;

/*Adding some text to statement*/
%put My macro variable repvar has values:&reptitle;

/*SYMBOLGEN OPTIONS*/
options symbolgen;
%let reptitle=Book Section;
%let repvar=section;
title "Frequencies by &reptitle as of &sysday";

proc freq data=ytdsales;
	tables &repvar;
run;

/*AUTOMATIC MACRO VARIABLES*/
data web;
	set ytdsales;

	if section="Web Design" and datesold > "28FEB2007"d - 6;
run;

proc print data=web;
	title "Web Design Titles Sold in the Past Week";
	title2 "Report Date: &sysday &sysdate &systime";
	footnote1 "Data Set Used: &syslast SAS Version: &sysver";
	var booktitle datesold saleprice;
run;

/*Program 3.8*/
/*UESR DEFINED MACRO VARIABLES*/
%let nocalc=53*21 + 100.1;
%let val1=982;
%let val2=819;
%let sum=&val1 + &val2;
%put &sum;
%put &nocalc;
%let text=Sales Report;
%let more="Sales Report";
%let two=&text + &more;
%put &two;
%let rep=&text &val1;
%put &rep;

/*Program 3.9*/
/*Placing macro variable into text*/
%let mosold=4;
%let level=25;

/*without macro*/
data book425;
 set books.ytdsales(where=(month(datesold)=4));
 attrib over25 length=$3 label="Cost > $25";
 if cost > 25 then over25='YES';
 else over25='NO';
run;

proc freq data=book425;
title "Frequency Count of Books Sold During Month 4";
title2 "Grouped by Cost Over $25";
 tables over25;
run;

/*with macro*/
data book&mosold&level;
	set ytdsales(where=(month(datesold)=&mosold));
	attrib over&level length=$3 label="Cost > $&level";

	if cost > &level then
		over&level='YES';
	else over&level='NO';
run;

proc freq data=book&mosold&level;
	title "Frequnecy Count of Books Sold During Month &mosold";
	title2 "Grouped by Cost Over $&level";
	tables over&level;
run;

/*Program 3.10*/
%let prefix=QUE;

data var;
	input &prefix.1 &prefix.2 &prefix.3;
	cards;
1 2 3
7 8 9
;
run;

/*Program 3.11*/
%let libname=work;
%let tabname=ytdsales;

title "First 100 obs from &libname..&tabname tables";
proc print data=&libname..&tabname.(obs=100);
run;

/*Program 3.12*/
/*Indirect macro variables*/
%let section1=Certification and Training;
%let section2=Internet;
%let section3=Networking and Communication;
%let n=2;

proc means data=ytdsales;
	title "Sales for Section: &&section&n";
run;

/*Program 3.13*/
options symbolgen;
%let section4=Operating System;
%let n=4;

%put Tutaj: &&section&n;
