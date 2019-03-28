/*********************
coalesce - return first nonmissing value
 **********************/
data coal;
	input home cell;
	num_avail=coalesce(home, cell);
	datalines;
65465
46546
;
run;

data coal_2;
	input home cell key;
	num_avail=coalesce(home, cell, key);
	datalines;
.
.
6561
;
run;