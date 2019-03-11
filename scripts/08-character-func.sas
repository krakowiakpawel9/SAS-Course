data test;
	input Basin $ Name $ MaxWind Unit $;
	datalines;
na AGHATA 120 km
SP ALEX 100 km 
NA CELIA 80 km
;
run;

data test_clear;
	set test;
	Name=propcase(Name);
	Basin=upcase(Basin);
	Wind=cats(MaxWind, Unit);
	Ocean=substr(Basin, 2, 1);
run;
