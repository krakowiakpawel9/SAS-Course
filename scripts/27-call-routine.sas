************************
*call sortn routin allows to sort values in rows and at the same time keeping the name of columns
*call sortn(cols);
*
*call missing(cols);
*allows to assgin missing values for each specified columns
************************;

data test;
	input name $ q1 q2 q3 q4 q5;
	datalines;
Alfred 8 7 6 9 8 Alice 7 6 4 9 8 Barbara 9 8 7 . 7;
run;

/* Call allows to sort particular rows */
/* Case - sort by score, and compute average based on only top 3 results */
data quiz;
	set test;
	call sortn(of q1-q5);
	QuizAvg_form_q3_to_q5=mean(of q3-q5);
run;

/* Next Example */
proc print data=pg2.class_quiz;
run;

/* Suppose we want to compute average of the top 3 socres. Call sortn statement takes
the column provided as arguments and reorders the numeric values
for each student from low to high */
data quiz_report;
	set pg2.class_quiz;
	call sortn(of Quiz1-Quiz5);
	QuizAvg=mean(of Quiz3-Quiz5);
run;

proc print data=quiz_report;
run;

/* Own Example */
data test_call_sortn;
	set pg2.class_quiz;
	call sortn(of Quiz1-Quiz5);
	mean_top_2=mean(of Quiz4-Quiz5);
run;

/* Activity */
/* Step 1 */
data quiz_report;
	set pg2.class_quiz;

	if Name in ('Barbara', 'James') then
		do;
			Quiz1=.;
			Quiz2=.;
			Quiz3=.;
			Quiz4=.;
			Quiz5=.;
		end;
run;

/* Step 2 */
data quiz_report;
	set pg2.class_quiz;

	if Name in("Barbara", "James", "Alfred") then
		call missing(of Quiz1-Quiz5);
run;