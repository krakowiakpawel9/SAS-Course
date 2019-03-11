/* Multiple statements */
data test;
	input model $ type $ price;
	datalines;
MDX SUV 36945 
RSX Sedan 23820 
TSX Sedan 26690 
NSX Sports 89000 
CRV SUV 80000 
;
run;

data first_cat over_40000;
	set test;

	if price < 30000 then
		do;
			Cost_Group=1;
			output first_cat;
		end;
	else if price < 40000 then
		do;
			Cost_Group=2;
			output first_cat;
		end;
	else
		do;
			Cost_Group=3;
			output over_40000;
		end;
run;

data risk;
	input id $ name $ value;
	datalines;
10 pawel 36945 
11 adam 23820 
12 jan 26690 
13 kuba 89000 
14 olek 80000 
;
run;

data default worthy;
	set risk;
	length Credibility $ 9;

	if value < 25000 then
		do;
			Credibility="Bad";
			output default;
		end;
	else if value < 50000 then
		do;
			Credibility="Good";
			output worthy;
		end;
	else
		do;
			Credibility="Very Good";
			output worthy;
		end;
run;
