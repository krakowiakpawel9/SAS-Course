data chars;
	input Height $ Weight $ Date : $10.;
	datalines;
58 155 10/21/1950
63 200 5/6/2005
45 79 11/12/2004
;

/****************************
INPUT - character to numeric
*****************************/
data nums;
	set chars(rename=(Height=Char_Height Weight=Char_Weight Date = Char_Date));
	height = input(Char_Height, 8.);
	weight = input(Char_Weight, 8.);
	Date = input(Char_Date, mmddyy10.);
	drop char_Height char_Weight char_Date;
	format date mmddyy10.;
run;

data nums_2;
	set chars(rename=(Height=Char_Height Weight=Char_Weight Date = Char_Date));
	height = input(Char_Height, 8.);
	weight = input(Char_Weight, 8.);
	Date = input(Char_Date, mmddyy10.);
	drop char_:;
	format date mmddyy10.;
run;

/****************************
PUT - numeric to character
*****************************/
data numeric;
	input Date : mmddyy10.
		Age
		Cost;
	datalines;
10/15/2000 23 12345
11/12/1923 55 39393
;

proc format;
	value agefmt low-<20 = 'Group One' 20-<40 = 'Group Two' 40-high = 'Group Three';
run;

data char;
	set numeric;
	char_date = put(date, date9.);
	char_cost = put(cost, dollar10.2);
	char_age = put(age, agefmt.);
	drop date cost;
run;

/*********************************************
LAG - returns previous values 
LAGn - returns n position of previous values
**********************************************/
data look_back;
	input Time Temp;
	prev_temp = lag(Temp);
	two_back = lag2(Temp);
	datalines;
1 60
2 62
3 65
4 70
;
run;

data laggard;
	input x @@;

	if x ge 5 then
		last_x = lag(x);
	datalines;
9 8 7 1 2 12
;
run;

data diff;
	input Time Temp;
	diff_temp = temp - lag(temp);
	datalines;
1 60
2 62
3 65
4 70
;
run;

/*********************************************
DIF(x) = x - lag(x)
DIF2
DIF3
**********************************************/
data diff_2;
	input Time Temp;
	diff_temp_dif = dif(Temp);
	diff_temp_lag = Temp - lag(Temp);
	datalines;
1 60
2 62
3 65
4 70
;
run;

/*********************************************
CHARACTER FUNCTIONS
**********************************************/
data sales;
	input    EmpID     :       $4. 
		Name      &      $15.
		Region    :       $5.
		Customer  &      $18.
		Date      : mmddyy10.
		Item      :       $8.
		Quantity  :        5.
		UnitCost  :  dollar9.;
	TotalSales = Quantity * UnitCost;

	/*   format date mmddyy10. UnitCost TotalSales dollar9.;*/
	drop Date;
	datalines;
1843 George Smith  North Barco Corporation  10/10/2006 144L 50 $8.99
1843 George Smith  South Cost Cutter's  10/11/2006 122 100 $5.99
1843 George Smith  North Minimart Inc.  10/11/2006 188S 3 $5,199
1843 George Smith  North Barco Corporation  10/15/2006 908X 1 $5,129
1843 George Smith  South Ely Corp.  10/15/2006 122L 10 $29.95
0177 Glenda Johnson  East Food Unlimited  9/1/2006 188X 100 $6.99
0177 Glenda Johnson  East Shop and Drop  9/2/2006 144L 100 $8.99
1843 George Smith  South Cost Cutter's  10/18/2006 855W 1 $9,109
9888 Sharon Lu  West Cost Cutter's  11/14/2006 122 50 $5.99
9888 Sharon Lu  West Pet's are Us  11/15/2006 100W 1000 $1.99
0017 Jason Nguyen  East Roger's Spirits  11/15/2006 122L 500 $39.99
0017 Jason Nguyen  South Spirited Spirits  12/22/2006 407XX 100 $19.95
0177 Glenda Johnson  North Minimart Inc.  12/21/2006 777 5 $10.500
0177 Glenda Johnson  East Barco Corporation  12/20/2006 733 2 $10,000
1843 George Smith  North Minimart Inc.  11/19/2006 188S 3 $5,199
;

data mixed;
	input Name & $20. ID;
	datalines;
Daniel Fields  123
Patrice Helms  233
Thomas chien  998
;

data upper;
	input Name & $20. DOB : mmddyy10.;
	format DOB mmddyy10.;
	datalines;
DANIEL FIELDS  01/03/1966
PATRICE HELMS  05/23/1988
THOMAS CHIEN  11/12/2000
;

data long_name;
	set sales;

	if lengthn(Name) gt 12;
run;

/*********************************************
UPCASE - all large letters
**********************************************/
data mix;
	set mixed;
	Name = upcase(Name);
run;

data both;
	merge mix upper;
	by name;
run;

/*********************************************
COMPBL - compress blank
**********************************************/
data address;
	infile datalines truncover;
	input #1 Name $40.
		#2 Street $40.
		#3 @1  City $20. 
		@21 State $2. 
		@24 Zip $5.;
	datalines;
ron   coDY
1178  HIGHWAY 480
camp   verde        tx 78010
jason Tran
123 lake  view drive
East  Rockaway      ny 11518
;

data standard;
	set address;
	Name = compbl(propcase(Name));
	Street = compbl(propcase(Street));
	City = compbl(propcase(City));
	State = upcase(State);
run;

/*********************************************
CAT - concatenates two strings
CATS - strips off leading and trailing blanks
CATX - supply separator to concatenate
**********************************************/
data _null_;
	length Join Name1-Name4 $ 15;
	first = 'Ron   ';
	last = 'Cody   ';
	join = ':'||first||':';
	name1 = first||last;
	name2 = cat(first, last);
	name3 = cats(first, last);
	name4 = catx(' ', first, last);
	file print;
	put join= /
		name1= / name2= / name3= / name4=;
run;

/*********************************************
LEFT - remove leading blanks
TRIM - remove trailing blanks
STRIP - remove blanks
**********************************************/
data blanks;
	string = '   ABC  ';
	join = ':'||string||':';
	joinleft = ':'||left(string)||':';
	jointrim = ':'||trim(string)||':';
	joinstrip = ':'||strip(string)||':';
run;

/*********************************************
COMPRESS - remove particular character
**********************************************/
data phone;
	input Phone $20.;
	datalines;
(908)232-4856
210.343.4757
(516)  343 - 9293
9342342345
;

data phone_comp;
	length phonenumber $ 10;
	set phone;
	PhoneNumber = compress(Phone, ' ()-.');
run;

data ph;
	set phone;

	* kd -keep only digits;
	* a - removes all letters;
	* pd - removes punctuation and digits;
	phnumber = compress(phone, ,'kd');
run;

/*********************************************
FIND
FINDW
**********************************************/
data mixed_nuts;
	input Weight : $10. Height : $10.;
	datalines;
100Kgs. 59in
180lbs 60inches
88kg 150cm.
50KGS 160CM
;

data eng;
	set mixed_nuts(rename=(Weight = Char_Weight Height = Char_Height));
	
	* i - ignore case;
	if find(Char_Weight, 'lb', 'i') then
		weight = input(compress(Char_weight, ,'kd'), 8.);
	else if find(Char_Weight, 'kg', 'i') then
		weight = 2.2*input(compress(Char_Weight,,'kd'), 8.);

	if find(Char_Height, 'in', 'i') then
		height = input(compress(Char_Height,,'kd'), 8.);
	else if find(Char_Height, 'cm', 'i') then
		height = input(compress(Char_Height,,'kd'), 8.) / 2.54;
	drop char_:;
run;

data look_over;
	input String $40.;
	if findw(String, 'Roger') then Match='Yes';
	else Match='No';
datalines;
Will Rogers
Roger Cody
Was roger here?
Was Roger here?
;
run;

/*********************************************
ANYDIGIT
**********************************************/

data only_alpha mixed;
	infile "SASBook/id.txt" truncover;
	input ID $10.;
	if anydigit(ID) then output mixed;
	else output only_alpha;
run;

/*********************************************
NOTALPHA - only letter
NOTDIGIT - only digit
NOTALNUM - only letters and digit
**********************************************/

data cleaning;
   Subject + 1;
   input Letters $ Numerals $ Both $;
datalines;
Apple 12345 XYZ123
Ice9 123X Abc.123
Help! 999 X1Y2Z3
;

title "Data Cleaning Application";
data _null_;
	file print;
	set cleaning;
	if notalpha(trim(Letters)) then put Subject= Letters=;
	if notdigit(trim(Numerals)) then put Subject= Numerals=;
	if notalnum(trim(Both)) then put Subject= Both=;
run;

/*********************************************
VERIFY(string, list of valid characters)
**********************************************/

data errors valid;
	input ID $ Answer : $5.;
	if verify(Answer, 'ABCDE') then output errors;
	else output valid;
datalines;
001 AABDE
002 A5BBD
003 12345
;
run;

/*********************************************
SUBSTR	
**********************************************/

data extract;
	input ID : $10. @@;
	length State $ 2 Gender $ 1 Last $ 5;
	State = substr(ID, 1, 2);
	Gender = substr(ID, 5, 1);
	Last = substr(ID, 6);
datalines;
NJ12M99 NY76F4512 TX91M5
;
run;

/*********************************************
SCAN	
**********************************************/
data origin;
	input Name $ 30.;
datalines;
Jeffrey Smith
Ron Cody
Alan Wilson
Alfred E. Newman
;
run;

data first_last;
	set origin;
	length first last $15;
	first = scan(Name, 1, ' ');
	last = scan(Name, -1, ' ');
run;
/*********************************************
COMPARING STRINGS	
**********************************************/
data diagnosis;
	input Code $10.;
	if compare(Code, 'V450', 'i:') eq 0 then Match = "Yes";
	else Match = "No";
datalines;
V450
V450
V450.100
V900
;
run;

/*********************************************
ARRAYS	
**********************************************/

data SPSS;
   input Height Weight Age HR Chol Name : $20.;
datalines;
68 178 55 68 210 Smith
999 200 999 999 290 Orlando
72 999 29 79 999 Ramos
;

data new;
	set spss;
	if Height=999 then Height=.;
	if Weight=999 then Weight=.;
	if Age=999 then Age=.;
run;

data new_arr;
	set spss;
	array arr(3) Height Weight Age;
	do i = 1 to 3;
		if arr(i) = 999 then arr(i) = .;
	end;
	drop i;
run;

data new_arr_2;
	set spss;
	array arr(5) Height Weight Age HR Chol;
	do i = 1 to 5;
		if arr(i) = 999 then arr(i) = .;
	end;
	drop i;
run;

data new_arr_3;
	set spss;
	array arr(5) Height Weight Age HR Chol;
	*with call missing routines;
	do i = 1 to 5;
		if arr(i) = 999 then call missing(arr(i));
	end;
	drop i;
run;

data chars;
   input Height $ Weight $ Date : $10.;
datalines;
58 155 10/21/1950
? 200 5/6/2005
45 NA 11/12/2004
;

data miss;
	set chars;
	array char_arr(*) $ _character_;
	do loop = 1 to dim(char_arr);
		if char_arr(loop) in ('NA','?') then	
			call missing(char_arr(loop));
	end;
	drop loop;
run;

data careless;
   input Score LastName : $10. (Ans1-Ans3)($1.);
datalines;
100 COdY Abc
65 sMITH CCd
95 scerbo DeD
;

data lower;
	set careless;
	array all(*) _character_;
	do i = 1 to dim(all);
		all(i) = lowcase(all(i));
	end;
	drop i;
run;

data temp;
	input Far1-Far5 @@;
	array Far(5);
	array Cel(5) Cel1-Cel5;
	do Hour=1 to 5;
		Cel(Hour) = (Far(Hour) - 32)/1.8;
	end;
	drop Hour;
datalines;
35 37 40 42 44
;
run;

data account;
	input ID Income1999-Income2004;
	array income(1999:2004) Income1999-Income2004;
	array taxes(1999:2004) Taxes1999-Taxes2004;
	do year = 1999 to 2004;
		Taxes(year) = 0.25*Income(Year);
	end;
	drop year;
datalines;
001 45000 47000 48000 52000 53000 55000
002 45000 50000 48000 50000 53000 55000
;
run;

proc print data=account n="Total numbers of observations:" double;
id ID;
run;

proc report data=account;
run;
