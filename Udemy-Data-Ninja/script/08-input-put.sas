/***************
input - charcter to numeric

put - numeric to character
 ****************/
data inp;
	input sale $9.;
	numsale=input(sale, comma9.);
	datalines;
6,515,353
;
run;

data inp_2;
	input sale $7.;
	sale_num = input(sale, comma7.);
	datalines;
515,353
;
run;

data put;
	input sale;
	sale_char=put(sale, 7.);
	datalines;
6515353
;
run;

data put_2;
	input sale;
	sale_char=put(sale, 3.);
	datalines;
353
;
run;

