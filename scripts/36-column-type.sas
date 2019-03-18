/* Converting Column Type */
/* Important Note: Some values are automatically converted to numeric values  */
/* during the calculation process, but for example if we have column specified in  */
/* commas format it won't work */
/* INPUT(source, informat)  - converts a character values to a numeric values
(How to read the character string) */
/* PUT(source, format) - converts numeric values to character values by using a
fromat to indicate how the values should be written
(how to write the character sting) */
proc contents data=pg2.stocks2;
run;

proc print data=pg2.stocks2(obs=10);
run;

data work.stocks2;
	set pg2.stocks2;
	Range=High-Low;
	DailyVol=Volume/30;
run;

proc print data=stocks2(obs=10);
run;

/* converting CHARACTER values to NUMERIC */
**************************************************
*	Char		   INPUT format		    Numeric
*	15OCT2018      date9.				21472
*	10/15/5018     mmddyy10.			21472
*   15/10/2018     ddmmyy10.			21472
*   123,456.78     comma12.			    123456.78
*	$123,456.78    dollar12.			123456.78
*	123456	       6.					123456;
**************************************************;

/* Important Note! Pay attention on comma. NewCol2 is inproper */
data work.stock;
	set pg2.stocks2;
	NewCol1=input(Volume, comma12.);
	NewCol2=input(Volume, comma12.2);
	keep volume New:;
run;

/* Using Generic functions to read date format: */
/*                                              */
/* Char		           PUT function		Numeric */
/* 15OCT2018		   anydtdtew.		21472 */
/* 10/15/5018 */
/* 10152018 */
/* Oct 15, 2018 */
/* October 15, 2018 */
*	DATASTYLE = LOCALE = ENGLISH = MDY
*	OPTIONS DATESTYLE = MDY;
*	OPTIONS DATESTYLE = DMY;

/* In this case the type of the column doesn't change */
data stocks_old_column;
	set pg2.stocks2;
	Date=input(Date, date9.);
	Volume=input(Volume, comma12.);
run;

/* In this case if you create new column, desirable format is assigned */
data stocks_new_column;
	set pg2.stocks2;
	Date2=input(Date, date9.);
	Volume2=input(Volume, comma12.);
run;

/* Converting the Type of an Existing Column */
/* Step 1: rename the column */
/* table(RENAME=(current-col-name=new-col-name)) */
/* Step 2: use input function */
/* Step 3: use drop to eliminate column */
data stocks;
	set pg2.stocks2(rename=(Volume=CharVolume));
	Date2=input(Date, date9.);
	Volume=input(CharVolume, comma12.);
	drop CharVolume;
run;

data shoes;
	set sashelp.shoes(rename=(Product=Type));
run;

/* converting NUMERIC values to CHARACTER */
****************************************************
* 	example:
*	Day = put(Date, downame3.);
* 	returns frist three letter of the day name;
*
*	Numeric			PUT format			Character
*	21472			date9.				15OCT2018
*	21472			downame3.			Mon
*	21472			year4.				2018
*	123456.78		comma10.2			123,456.78
*	123456.78		dollar11.2			$123,456.78
*	123.456			6.2					123.46;
****************************************************;

/* Case Study */
proc print data=pg2.weather_atlanta(obs=5);
run;

proc contents data=pg2.weather_atlanta;
run;

proc freq data=pg2.weather_atlanta;
	tables AirportCode;
run;

/* Using input() function */
data atl_precip;
	set pg2.weather_atlanta;
	where AirportCode='ATL';
	drop AirportCode City Temp: ZipCode Station;

	if Precip ne 'T' then
		PrecipNum=input(Precip, 6.);
	else
		PrecipNum=0;
	TotalPrecip+PrecipNum;
run;

/* More changes */
data atl_precip_2;
	set pg2.weather_atlanta(rename=(Date=CharDate));
	where AirportCode='ATL';
	drop AirportCode City Temp: ZipCode Station CharDate;

	if Precip ne 'T' then
		PrecipNum=input(Precip, 6.);
	else
		PrecipNum=0;
	TotalPrecip+PrecipNum;
	Date=input(CharDate, mmddyy10.);
run;

/* Using put() function */
data atl_precip_2;
	set pg2.weather_atlanta;
	CityStateZip=catx(' ', City, 'GA', ZipCode);
run;

data atl_precip_2;
	set pg2.weather_atlanta(rename=(ZipCode=NumZipCode));
	drop Station NumZipCode;
	ZipCode=put(NumZipCode, 5.);
	CityStateZip=catx(' ', City, 'GA', ZipCode);
	ZipCodeLast2 = substr(ZipCode, 4, 2);
run;

/* Take note! Zw. format is used */
data atl_precip_2;
	set pg2.weather_atlanta;
	CityStateZip=catx(' ', City, 'GA', ZipCode);
	ZipCodeLast2 = substr(put(ZipCode, z5.), 4, 2);
run;

/* Homework assignment */
data stocks2;
   set pg2.stocks2(rename=(Volume=CharVolume Date=CharDate));
   Volume=input(CharVolume,comma12.);
   Date = input(CharDate, date9.);
   drop Char:;
run;

proc contents data=stocks2;
run;