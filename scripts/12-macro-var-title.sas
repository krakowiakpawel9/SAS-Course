data dirty_id_country;
	input id $ name $;
	datalines;
POL_234 pawel
GER_423 tomek
ENG_099 Janusz
RUB_999 Rubbish
;
run;

data clean_data;
	set dirty_id_country;
	name=propcase(name);
	Country=substr(id, 1, 3);
run;

footnote "Created by Pawel Krakowiak";

proc print data=clean_data;
run;

title;

proc contents data=clean_data;
run;

%let Country_Name=POL;
title1 "Simple Report";
title2 "By Country &Country_Name";

proc print data=clean_data;
	where Country="&Country_Name";
run;

%let Country_Name=GER;
title1 "Simple Report";
title2 "By Country &Country_Name";

proc print data=clean_data;
	where Country="&Country_Name";
run;
title;
footnote;
