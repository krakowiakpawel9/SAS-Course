/**********************
verify
 ***********************/
data errors valid;
	input id$ stage : $5.;

	if verify(stage, 'abcd') then
		output errors;
	else
		output valid;
	cards;
001 aabcd
002 aabqc
003 aaabbbcc
;
run;

/**********************
sunstr
 ***********************/
data new;
	dat='06MAY98';
	month=substr(dat, 3, 3);
run;