***************************
*	sum(num1,num2,...)
*	mean(num1,num2,...)
*	year(SAS-date)
*	month(SAS-date)
*	today(SAS-date)
*	mdy(month, day, year)
*   rand('distribution', parameter1, ...) assign random number
*	largest(k, val1, val2, ...) identify best score on the k-th position
*	round(number, rounding-unit)
*
*   to truncate decimal values
*   ceil(number) - smallest integer that is greater then or equal to the args
*   floor(number) - largest integer that is less than or equal to the args
*	int(number) - returns the integer value
***************************;

data quiz_analysis;
	StudentID=rand('integer', 1000, 9999);
	set pg2.class_quiz;
	drop Quiz1-Quiz5 name;
	Quiz1st=largest(1, of Quiz1-Quiz5);
	Quiz2nd=largest(2, of Quiz1-Quiz5);
	Quiz3rd=largest(3, of Quiz1-Quiz5);
	Top3Avg=round(mean(Quiz1st, Quiz2nd, Quiz3rd), .2);
run;

data anal;
	set pg2.class_quiz;
	AVG=mean(of Quiz1-Quiz5);
	Avg_ceil = ceil(AVG);
	Avg_floor = floor(AVG);
	Avg_int = int(AVG);
run;

data wind_avg;
	set pg2.storm_top4_wide;
	WindAvg1=round(mean(of Wind1-Wind4), .1); 
	WindAvg2=mean(of Wind1-Wind4); 
	format WindAvg2 5.1;
run;

/* Homework case */
proc print data=pg2.np_lodging(obs=30);
run;

proc print data=case(obs=30);
run;

data case;
	set pg2.np_lodging;
	call sortn(of CL2010-CL2017);
run;

data case2;
	set pg2.np_lodging;
	Stay1=largest(1, of CL2010-CL2017);
	Stay2=largest(2, of CL2010-CL2017);
	Stay3=largest(3, of CL2010-CL2017);
	StayAvg=round(mean(of CL2010-CL2017));
	if StayAvg > 0;
run;

/* Homework case */
proc print data=pg2.np_hourlyrain;
run;

data running_total;
	set pg2.np_hourlyrain;
	retain TotalRain 0;
	TotalRain=sum(TotalRain, Rain);
run;

data running_total_by_month;
	set pg2.np_hourlyrain;
	by Month;

	if first.Month=1 then
		MonthlyRainTotal=0;
	MonthlyRainTotal + Rain;
	if last.Month=1;
	Date=datepart(DateTime);
	MonthEnd=intnx('month', Date, 0, 'end');
	format Date MonthEnd date9.;
	keep StationName MonthlyRainTotal Date MonthEnd;
run;

proc print data=running_total;
run;

proc print data=running_total_by_month;
run;
