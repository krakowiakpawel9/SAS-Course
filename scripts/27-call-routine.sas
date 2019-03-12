data test;
	input name $ q1 q2 q3 q4 q5;
	datalines;
Alfred 8 7 6 9 8
Alice 7 6 4 9 8 
Barbara 9 8 7 . 7
;
run;

/* Call allows to sort particular rows */
/* Case - sort by score, and compute average based on only top 3 results */
data quiz;
	set test;
	call sortn(of q1-q5);
	QuizAvg_form_q3_to_q5 = mean(of q3-q5);
run;
