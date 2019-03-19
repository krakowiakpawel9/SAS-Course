*libname pg2 "/home/krakowiakpawel90/EPG294/data";

data loops;
	Amount=200;

	do month=1 to 12;
		Running + Amount;
		output;
	end;
	format Running comma10.2;
run;

data loops_2;
	Amount=100;

	do month=1 to 12;
		Running + Amount;
		Running + Running*0.01;
		output;
	end;
	format Running comma10.2;
run;

data loop_3;
	Amount=2300;

	do year=1 to 3;

		do month=1 to 12;
			Running + Amount;
			Running + Running * 0.01;
			output;
		end;
	end;
	format Running comma12.2;
run;

/* Homework Solution */
/* Calculating simple Feature Value */
data retirement;
	Invest=10000;

	do year=1 to 6;
		Savings + Invest;
		output;
	end;
run;

title1 "Retirement Account Balance per Year";

proc print data=retirement noobs;
	format Savings dollar12.2;
run;

title1;

/* Calculating simple Feature Value with interest */

data retirement;
	Invest=10000;

	do year=1 to 6;

		do quarter=1 to 4;
			Savings + Invest/4;
			Savings + Savings * (0.075/4);
			output;
		end;
	end;
	format Savings 12.2;
run;

data retirement;
	Invest=10000;

	do year=1 to 6;

		do quarter=1 to 4;
			Savings + Invest/4;
			Savings + Savings * (0.075/4);
		end;
		output;
	end;
	format Savings 12.2;
	drop quarter;
run;

/* Homework Solution */
proc print data=pg2.np_summary(obs=2);
run;

data forecast;
	set pg2.np_summary;
	where Reg='PW' and Type in ('NM', 'NP');
	ForecastDV=DayVisits;
	NextYear=year(today()) + 1;

	do year=NextYear to NextYear + 4;

		if type='NM' then
			ForecastDV=ForecastDV * 1.05;

		if type='NP' then
			ForecastDV=ForecastDV * 1.08;
		output;
	end;
	format ForecastDV comma12.;
	keep ParkName DayVisits Year ForecastDV;
	label ForecastDV="Forecasted Day Visitors";
run;

/* Output after five iterations */
data forecast;
	set pg2.np_summary;
	where Reg='PW' and Type in ('NM', 'NP');
	ForecastDV=DayVisits;
	NextYear=year(today()) + 1;

	do year=NextYear to NextYear + 4;

		if type='NM' then
			ForecastDV=ForecastDV * 1.05;

		if type='NP' then
			ForecastDV=ForecastDV * 1.08;
	end;
	output;
	format ForecastDV comma12.;
	keep ParkName DayVisits Year ForecastDV;
	label ForecastDV="Forecasted Day Visitors";
run;

proc print data=forecast label;
run;

proc contents data=forecast;
run;

proc sort data=forecast;
	by ParkName;
run;

title "Forecast of Recreational Day Visitors for Pafific West";
proc print data=forecast label;
run;
