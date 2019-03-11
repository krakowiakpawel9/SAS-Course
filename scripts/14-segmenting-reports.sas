/* Segmenting reports
First step: sort by values which you want to divide dataset
Second step: use proc freq procedure to display corresponding tables */
data cars;
	length type $ 10;
	input name $ type $ origin $ price;
	datalines;
Fiat hatchback Europe 30000
Renault sedan Europe 40000
Audi sedan Europe 100000
Dodge SUV USA 100000
Volvo SUV Europe 200000
Tata sedan Asia 30000
Honda SUV Asia 50000
Dodge sedan USA 100000
;
run;

proc sort data=cars;
	by origin;
run;

proc sort data=cars out=cars_sort;
	by origin;
run;

proc sort data=cars out=cars_sort;
	by origin descending price;
run;

proc freq data=cars_sort order=freq;
	by origin;
	tables type;
run;

proc print data=cars_sort label;
	by origin;
	label type="Car Type" name="Car Name" price="Price in USD";
run;
