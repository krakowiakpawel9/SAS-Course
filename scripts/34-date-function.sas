/* SAS date - number of days */
/* SAS time - number of seconds */
/* SAS datetime - number of seconds */
* datepart(datetime-value) allows to separate date 

	* timepart(datetime-value) allows to separate time;

proc print data=pg2.storm_detail(obs=10);
run;

data storm;
	set pg2.storm_detail;
	WindDate=datepart(ISO_time);
	WindTime=timepart(ISO_time);
	format WindDate date9. WindTime time.;
run;