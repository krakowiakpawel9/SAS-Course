*********************************************
*	IF expression THEN statement;
*	<ELSE IF expression THEN statement;
> * <ELSE IF expression THEN statement;
> * ELSE statement;
*********************************************



data test;
input model $ type $ MSRP;
datalines;
MDX SUV 36945 RSX Sedan 23820 TSX Sedan 26690 NSX Sports 89000 CRV SUV 80000;
run;

data test_cond;
	set test;

	if MSRP < 30000 then
		Cost_Group=1;

	if MSRP >=30000 then
		Cost_Group=2;

	if type="SUV" then
		Buy="Yes";
	else
		Buy="No";
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

data risk_cond;
	set risk;

	if value < 50000 then
		Class='Economy';

	if value >=50000 then
		Class='Luxury';
run;

data risk_missing;
	input id $ name $ value;
	datalines;
10 pawel 36945 
11 adam . 
12 jan 26690 
13 kuba 89000 
14 olek 80000 
15 tadek . 
;
run;

/* Important note! Missing value is treating as the smallest possible value */
/* Two groups of Category */
data risk_missing_cond;
	set risk_missing;

	if value < 50000 then
		Class_Group=1;
	else
		Class_Group=2;
run;

/* Three groups of Category */
data risk_missing_cond_three;
	set risk_missing;

	if value < 30000 then
		Category=1;
	else if value < 40000 then
		Category=2;
	else
		Category=3;
run;

/* Quick Fix */
data risk_missing_cond_2;
	set risk_missing;

	if value=. then
		Flag=0;
	else
		Flag=1;
run;

data risk_3;
	set risk_missing_cond_2;

	if value > 30000 and Flag=1 then
		Result="Yes";
	else
		Result="No";
run;

/* First occurence of the column define a type, length */
/* To avoid this problem - explicitly define length of a column */
data cars;
	set test;
	length CarType $ 6;

	if msrp < 60000 then
		CarType="Basic";
	else
		CarType="Luxury";
run;

/* Practice Solution */
data storm_cat;
	set pg1.storm_summary;
	keep Name Basin MinPressure StartDate PressureGroup;

	if MinPressure=. then
		PressureGroup=.;
	else if MinPressure <=920 then
		PressureGroup=1;
	else
		PressureGroup=2;
run;

proc freq data=storm_cat;
	tables PressureGroup;
run;

/* Practice Solution 2 */
data storm_summary2;
	set pg1.storm_summary;
	length Ocean $ 20;
	keep Basin Season Name MaxWindMPH Ocean;
	Basin=upcase(Basin);
	OceanCode=substr(Basin, 2, 1);

	if OceanCode="I" then
		Ocean="Indian";
	else if OceanCode="A" then
		Ocean="Atlantic";
	else
		Ocean="Pacific";
run;

/* Practice Solution 3 */
data girls boys;
	set sashelp.class;

	if sex="F" then
		do;
			Gender="Female";
			output girls;
		end;
	else
		do;
			Gender="Male";
			output boys;
		end;
run;

/* Practice Solution 4 */
data np_summary_cond;
	set pg1.np_summary;

	if type='NM' then
		ParkType='Monument';

	if type='NP' then
		ParkType='Park';

	if type in ('NPRE', 'PRE', 'PRESERVE') then
		ParkType='Preserve';

	if type='NS' then
		ParkType='Seashore';

	if type in ('RVR', 'RIVERWAYS') then
		ParkType='River';
run;

proc freq data=np_summary_cond;
	tables ParkType;
run;