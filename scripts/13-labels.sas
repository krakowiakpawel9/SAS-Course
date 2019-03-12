*********************************************************
*	Adding labels:
*       label col-name="label-text";
* 	If you want to add label in you proc print statement
*       you must add 'label' statement
*********************************************************;

data dirty_id_country;
	input id $ name $;
	datalines;
POL_234 pawel
GER_423 tomek
ENG_099 Janusz
RUB_999 Rubbish
;
run;

data with_labels;
	set dirty_id_country;
	label id="Identification Number" name="Name of Client";
run;

proc print data=with_labels label;
run;

proc contents data=with_labels;
run;

data test;
	input model $ type $ price volume;
	label model="Car Model" type="Car Type" price="Recommended Price" 
		volume="Volume of transctions";
	datalines;
MDX SUV 36945 100
RSX Sedan 23820 500
TSX Sedan 26690 300
NSX Sports 89000 200
CRV SUV 80000 50
;
run;

/* Next Example */
proc print data=test label;
run;

proc means data=test;
run;

data cars_update;
	set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price" 
		AvgMPG="Average Miles per Gallon" Invoice="Invoice Price";
run;

proc means data=cars_update min mean max;
	var MSRP Invoice;
run;

proc print data=cars_update label;
	var Make Model MSRP Invoice AvgMPG;
run;