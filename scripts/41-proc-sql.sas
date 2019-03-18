proc print data=pg2.np_2016traffic(obs=10);
proc print data=pg2.np_codelookup(obs=10);
proc print data=traffic;
run;

proc sql;
	create table traffic as select Code, Year, Month, MonthCount, ParkName from 
		pg2.np_2016traffic t inner join pg2.np_codelookup c on t.code=c.parkcode;
quit;