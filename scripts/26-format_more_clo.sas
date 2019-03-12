/*
Functions:
Date and Time,
Descriptive Stats,
Financial,
Distance,
Truncation,
Mathematical,
Special,
External,
Character,
Arithmetic,
Trigonometric,
Random Number,
Probability,
State and Zip Code
*/
/* var_1--var_4 allows to format multiple columns */
data test;
	input var_1 var_2 var_3 var_4;
	format var_1--var_4 7.1;
	datalines;
23.32323 1232.232 232.32 342.3
23.323 232.232 32.32 342.3
;
run;

/* format _numberic_ 7.1 */
/* _character_ */
/* _all_ */
data test_n;
	set test;
	format _numeric_ 8.2;
run;
