proc print data=sashelp.shoes(obs=2);
run;

data sales_high sales_low;
	set sashelp.shoes;

	if sales < 100000 then
		output sales_low;
	else
		output sales_high;
run;

proc print data=pg2.storm_summary;
run;

data atlantic indian pacific;
	set pg2.storm_summary;
	Basin=upcase(Basin);

	if substr(Basin, 2, 1)="A" then
		do;
			Ocean="Atlantic";
			output atlantic;
		end;
	else if substr(Basin, 2, 1)="P" then
		do;
			Ocean="Pacific";
			output pacific;
		end;
	else
		do;
			Ocean="Indian";
			output indian;
		end;
run;

/* Controlling Column Output */
data sales_h(drop=Region Inventory) sales_l(keep=Product Sales);
	set sashelp.shoes;

	if sales < 100000 then
		output sales_l;
	else
		output sales_h;
run;

/* Next Example */
proc print data=pg2.np_yearlytraffic(obs=5);
run;

data monument(drop=ParkType) park(drop=ParkType) others;
	set pg2.np_yearlytraffic;
	drop Region;

	if find(lowcase(ParkType), "monument") then
		output monument;

	if find(lowcase(ParkType), "park") then
		output park;
	else
		output others;
run;

proc print data=monument(obs=1);
proc print data=park(obs=1);
proc print data=others(obs=1);
run;

/* Next Example */
proc print data=pg2.np_2017(obs=2);
run;

data camping(keep=ParkName Month DayVisits CampTotal) lodging(keep=ParkName 
		Month DayVisits LodgingOther);
	set pg2.np_2017;
	CampTotal=sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
	format CampTotal comma20.;

	if CampTotal > 0 then
		output camping;

	if LodgingOther > 0 then
		output lodging;
run;

/* Next Example */
data test;
	set pg2.class_birthdate;
	Zone=1;
	output;
	Zone=2;
	Age=Age + 10;
	output;
	Zone=3;
	Age=Age + 10;
	output;
run;

/* Next Example */
data Female Others;
	set sashelp.class;

	if Sex="F" then
		output Female;
	else
		output Others;
run;

/* Next Example */
data boots(drop=Product);
	set sashelp.shoes(keep=Sales Product Subsidiary Inventory);
	where Product="Boot";
	drop Sales Inventory;
	Total=sum(Sales, Inventory);
run;

/* Next Example */
data boots_2;
	set sashelp.shoes(keep=Sales Product Subsidiary);
	where Product='Boot';
	NewSales=Sales*1.35;
run;