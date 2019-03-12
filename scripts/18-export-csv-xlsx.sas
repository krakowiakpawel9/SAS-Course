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
