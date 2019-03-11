**********************************
*  Syntax:
*
*	IF expression THEN DO;
*		<exec statements>
*	END;
*	ELSE IF expression THEN DO;
*		<exec statements>
*	END;
*	ELSE DO;
*		<exec statements>
*	END;
*
**********************************;

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

data stocks;
	input name $ price market $;
	datalines;
CDR 190 main
PLW 160 main
11BIT 320 main
VVD 2 alter
CLD 8 alter
;
run;

data stocks_full_name_main stocks_full_name_alter;
	set stocks;
	length full_name $ 19;
	format export_date date9.;

	if name="CDR" then
		full_name="CD Projekt";

	if name="PLW" then
		full_name="Playway";

	if name="11BIT" then
		full_name="11 BIT Studios";

	if name="VVD" then
		full_name="Vivid Games";

	if name="CLD" then
		full_name="Cloud Technologies";

	if market="main" then
		do;
			export_date=today();
			output stocks_full_name_main;
		end;
	else
		do;
			export_date=today();
			output stocks_full_name_alter;
		end;
run;

/* Other example */
data dirty_id;
	input id $ name $;
	datalines;
PID_234 pawel
PID_423 tomek
PID_099 Janusz
;
run;

data clean_id;
	set dirty_id;
	id=substr(id, 5, 3);
run;

data dirty_id_country;
	input id $ name $;
	datalines;
POL_234 pawel
GER_423 tomek
ENG_099 Janusz
RUB_999 Rubbish
;
run;

data id_poland id_germany id_england id_empty;
	set dirty_id_country;
	name=propcase(name);
	length Country $ 20;
	Country_Code=substr(id, 1, 3);
	if Country_Code = "POL" then do;
		Country = "Poland";
		output id_poland;
	end;
	else if Country_Code = "GER" then do;
		Country = "Germany";
		output id_germany;
	end;
	else if Country_Code = "ENG" then do;
		Country = "England";
		output id_england;
	end;
	else do;
		Country=" ";
		output id_empty;
	end;
run;
