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