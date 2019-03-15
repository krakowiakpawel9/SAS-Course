proc print data=pg2.weather_houston;
run;

data houston;
	set pg2.weather_houston;
	putlog "NOTE: After SET statement";
	putlog _all_;
	keep Date DailyRain YTDRain;
	retain YTDRain 0;
	YTDRain=YTDRain + DailyRain;
	putlog "NOTE: Before RUN statement";
	putlog _all_;
run;

/* Next Example */
/* Using sum() function allows to omit the problems with missing values */
data zurich2017;
	set pg2.weather_zurich;
	retain TotalRain 0;
	TotalRain=sum(TotalRain, Rain_mm);
run;

/* This code is not correct */
data zurich2017;
	set pg2.weather_zurich;
	retain TotalRain 0;
	TotalRain=TotalRain + Rain_mm;
run;

data zur;
	set pg2.weather_zurich;
	YTDRain_mm + Rain_mm;
	DayNum + 1;
run;

/* next example */
proc print data=pg2.np_yearlytraffic(obs=5);
run;

data totalTraffic;
	set pg2.np_yearlytraffic;
	keep ParkName Location Count totTrafic;
	retain totTrafic;
	totTrafic=sum(totTrafic, Count);
	format totTrafic comma20.;
run;

/* next example */
data parkTypeTraffic;
	set pg2.np_yearlytraffic;
	where ParkType in ('National Monument', 'National Park');
	drop Location;
	retain MonumentTraffic 0 ParkTraffic 0;
	format MonumentTraffic ParkTraffic comma20.;

	if ParkType="National Monument" then
		do;
			MonumentTraffic=sum(MonumentTraffic, Count);
		end;
	else
		do;
			ParkTraffic=sum(ParkTraffic, Count);
		end;
run;

title "Accumulating Traffic Totals for Park Types";

proc print data=parkTypeTraffic;
	var ParkType ParkName Count MonumentTraffic ParkTraffic;
run;