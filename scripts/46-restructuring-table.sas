proc print data=pg2.class_test_wide;
proc print data=pg2.class_test_narrow;
proc print data=new;
proc print data=pg2.class_new;
run;

/* Convert wide table to narrow */
data new;
	set pg2.class_test_wide;
	keep Name Subject Score;
	length Subject $ 7;
	Subject='Math';
	Score=Math;
	output;
	Subject='Reading';
	Score=Reading;
	output;
run;

data new_2;
	length Sex $8;
	set pg2.class_new;
	Dimension='Height';
	Value=height;
	output;
	Dimension='Weight';
	Value=weight;
	output;
run;

data new;
	set pg2.class_test_narrow;
	by Name;
	retain Math Reading Name;

	if TestSubject='Math' then
		Math=TestScore;
	else if TestSubject='Reading' then
		Reading=TestScore;
	drop TestSubject;

	if last.Name;
run;

/* Homework Solution */
proc print data=pg2.np_2017camping(obs=10);
run;

data work.camping_narrow(drop=Tent RV Backcountry);
	length CampType $ 10;
	set pg2.np_2017Camping;
	format CampCount comma12.;
	CampType='Tent';
	CampCount=Tent;
	output;
	CampType='RV';
	CampCount=RV;
	output;
	CampType='Backcountry';
	CampCount=Backcountry;
	output;
run;

/* Homework Solution */
proc print data=pg2.np_2016camping;
run;

data camping_wide;
	set pg2.np_2016camping;
	by ParkName;
	keep ParkName Tent RV Backcountry;
	format Tent RV Backcountry comma12.;
	retain ParkName Tent RV Backcountry;

	if CampType='Tent' then
		Tent=CampCount;
	else if CampType='RV' then
		RV=CampCount;
	else if CampType='Backcountry' then
		BackCountry=CampCount;
	if last.ParkName;
run;

data work.camping_wide;
    set pg2.np_2016Camping;
    by ParkName;
    keep ParkName Tent RV Backcountry;
    format Tent RV Backcountry comma12.;
    retain ParkName Tent RV Backcountry;
    if CampType='Tent' then Tent=CampCount;
    else if CampType='RV' then RV=CampCount;
    else if CampType='Backcountry' then Backcountry=CampCount;
    if last.ParkName;
run;