******************************************************************************;
*	DO index-column=start TO stop <BY increment> UNTIL | WHILE (expression)  *;
******************************************************************************;

data iter_until;
	Amount=100;

	do Month=1 to 12 until (Savings > 5000);
		Savings + Amount;
		Savings + (Savings*0.02/12);
		output;
	end;
	format Savings 12.2;
run;

data iter_while;
	Amount=100;

	do Month=1 to 12 while (Savings <=5000);
		Savings + Amount;
		Savings + (Savings*0.02/12);
		output;
	end;
	format Savings 12.2;
run;

data iter_until;
	set pg2.savings2;

	do Month=1 to 12 until (Savings > 5000);
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings 12.2;
run;

data iter_while;
	set pg2.savings2;

	do Month=1 to 12 while (Savings <= 5000);
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings 12.2;
run;

proc print data=iter_while;
proc print data=iter_until;
run;

/* Struggling with index */

data iter_until;
	set pg2.savings2;
	Month = 0;
	do i=1 to 12 until (Savings > 5000);
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings 12.2;
	drop i;
run;

data iter_while;
	set pg2.savings2;
	Month= 0;
	do i=1 to 12 while (Savings <= 5000);
		Month + 1;
		Savings + Amount;
		Savings + (Savings*0.02/12);
	end;
	format Savings 12.2;
	drop i;
run;

proc print data=iter_while;
proc print data=iter_until;
run;

/* Homework Solution */
data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;

	do until (IncrDayVisits > 100000);
		IncrDayVisits=IncrDayVisits*1.06;
		Year + 1;
		output;
	end;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

proc sort data=IncreaseDayVisits;
	by ParkName;
run;

title1 'Years Until Northeast National Monuments Exceed 100,000 Visitors';
title2 'Based on Annual Increase of 6%';

proc print data=IncreaseDayVisits label;
	label DayVisits='Current Day Visitors' IncrDayVisits='Increased Day Visitors';
run;

title;

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;
	Year=0;

	do until (IncrDayVisits > 100000);
		IncrDayVisits=IncrDayVisits*1.06;
		Year + 1;
	end;
	output;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

data IncreaseDayVisits;
	set pg2.np_summary;
	where Reg='NE' and DayVisits<100000;
	IncrDayVisits=DayVisits;

	while (IncrDayVisits <= 100000);
		IncrDayVisits=IncrDayVisits*1.06;
	end;
	output;
	format IncrDayVisits comma12.;
	keep ParkName DayVisits IncrDayVisits Year;
run;

/* Homework Solution */
data IncrExports;
	set pg2.eu_sports;
	where Year=2015 and Country='Belgium' and Sport_Product in ('GOLF', 'RACKET');
	year=0;

	do until (Amt_Export > Amt_Import);
		year + 1;
		Amt_Export=Amt_Export*1.07;
		output;
	end;
	format Amt_Import Amt_Export comma12.;
run;

title 'Belgium Golf and Racket Products - 7% Increase in Exports';

proc print data=IncrExports;
	var Sport_Product Year Amt_Import Amt_Export;
run;

title;

data IncrExports;
	set pg2.eu_sports;
	where Year=2015 and Country='Belgium' and Sport_Product in ('GOLF', 'RACKET');
	year = 2016;
	do i=1 to 10 until (Amt_Export > Amt_Import);
		year + 1;
		Amt_Export=Amt_Export*1.07;
		output;
	end;
	format Amt_Import Amt_Export comma12.;
run;

/* Homework Solution */
data Earnings(keep=QTR Earned);
	Amount=1000;
	Rate=0.075/4;

	do QTR=1 to 4;
		Earned + (Amount + Earned)*Rate;
	end;
run;

proc print data=pg2.savings;
run;

data work.savings;
	set pg2.savings;
	Savings=0;

	do Year=1 to 5;

		do qtr=1 to 4;
			Savings+Amount;
			Savings+(Savings*0.02/12);
		end;
	end;
run;

data invest;
	do Year=2010 to 2019;
		Capital+5000;
		Capital+(Capital*.03);
	end;
run;

data test;
	x=15;

	do until (x>12);
		x+1;
	end;
run;

data test;
	bike=10;

	do day=1 to 7 while(bike lt 13);
		bike=bike+2;
	end;
run;