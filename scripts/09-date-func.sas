data test;
	input start_date end_date;
	datalines;
21000 21100
21001 21201
21300 21310
;
run;

data test_format;
	set test;
	format start_date end_date date9.;
run;

proc print data=test_format;
run;

/* Basic SAS Data function
month() returns a number from 1 to 12
year() returns the four-digit year
day() returns a number from 1 through 31
weekday() returns a number from 1 through 7 (Sunday=1)
qtr() returns a number from 1 through 4 */
data test_month;
	set test;
	format_start_date=start_date;
	month_start=month(start_date);
	format format_start_date date9.;
run;

data test_year;
	set test_month;
	year_start=year(start_date);
run;

data test_day;
	set test_year;
	day_start=day(start_date);
run;

data test_weekday;
	set test;
	weekday=weekday(start_date);
run;

data test_quarter;
	set test;
	quarter=qtr(start_date);
run;

/* Other date functions
today() returns today date
mdy(month, day, year) returns a SAS date value from numeric month, day, and year values
yrdif(startdate, enddate, 'AGE') calculates a precise age between two dates */
data test_today;
	set test;
	today=today();
	today_format=today();
	diff_today=today - start_date;
	mdy=mdy(10, 5, 1992);
	mdy_format=mdy(10, 5, 1992);
	yrdif=yrdif(start_date, end_date);
	format today_format mdy_format date9.;
run;

/* Other example */
data test_2;
	input event $ date;
	datalines;
Hurricane 16673
Storm 21056
Ivan 16396
;
run;

data data_func;
	set test_2;
	YearsPassed=yrdif(date, today(), "age");
	Anniversary=mdy(month(date), day(date), year(today()));
	format Anniversary date date9. YearsPassed 4.1;
run;
