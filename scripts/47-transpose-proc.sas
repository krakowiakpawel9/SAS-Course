******************************************************;
*	PROC TRANSPOSE DATA=input-table <OUT=output-table>;
*		<ID col-name>                                 ;
*		<VAR col-name(s)>							  ;
*		<BY col-name(s)>							  ;
*	RUN												  ;
******************************************************;

proc print data=sashelp.class;
run;

/* Example 1 */
proc transpose data=sashelp.class;
run;

/* Example 2 */
proc transpose data=sashelp.class out=class_t;
	id Name;
run;

/* Example 3 */
proc transpose data=sashelp.class out=class_tr;
	id Name;
	var Height Weight;
run;

proc print data=sashelp.class;
proc print data=class_t;
proc print data=class_tr;
run;

/* Creating a Wide Table with proc transpose */
proc print data=pg2.storm_top4_narrow(obs=10);
run;

proc transpose data=pg2.storm_top4_narrow out=wind_rotate;
	var WindMPH;
	id WindRank;
	by Season Basin Name;
run;

/* Improve proc transpose */
proc transpose data=pg2.storm_top4_narrow out=wind_rotate prefix=Wind 
		name=WindSource;
	var WindMPH;
	id WindRank;
	by Season Basin Name;
run;

proc transpose data=pg2.storm_top4_narrow out=wind_rotate(drop=_name_) 
		prefix=Wind;
	var WindMPH;
	id WindRank;
	by Season Basin Name;
run;

proc print data=pg2.storm_top4_narrow(obs=10);
proc print data=wind_rotate(obs=10);
run;

/* Creating a narow table with proc transpose */
proc print data=pg2.storm_top4_wide(obs=10);
run;

/* Practice Example */
title "Storm Wide";

proc print data=pg2.storm_top4_wide(obs=5);
run;

proc transpose data=pg2.storm_top4_wide out=storm_top4_narrow;
	by Season Basin Name;
run;

/* Only Wind1 and Wind2 */
proc transpose data=pg2.storm_top4_wide out=storm_top4_narrow;
	by Season Basin Name;
	var Wind1 Wind2;
run;

title "Storm Narrow";

proc print data=storm_top4_narrow(obs=10);
run;

title;

/* Own Example */
proc print data=pg2.storm_top4_wide(obs=10);
proc print data=trans_tab(obs=10);
run;

proc transpose data=pg2.storm_top4_wide out=trans_tab(drop=_name_) prefix=Wind;
	by Season Basin Name;
run;

proc transpose data=pg2.storm_top4_wide out=tab name=WindRank prefix=WindMPH;
	by Season Basin Name;
	var Wind1-Wind4;
run;

proc transpose data=pg2.storm_top4_wide out=tab_2(rename=(col1=WindMPH)) 
		name=WindRank;
	by Season Basin Name;
	var Wind1-Wind4;
run;

proc print data=pg2.storm_top4_wide(obs=10);
proc print data=tab(obs=10);
proc print data=tab_2(obs=10);
	/* Homework Example */
proc print data=pg2.np_2017camping(obs=10);
run;

proc transpose data=pg2.np_2017camping out=camp_trans;
run;

proc print data=pg2.np_2017camping(obs=10);
proc print data=camp_trans(obs=10);
run;

proc transpose data=pg2.np_2017camping out=camp_trans_2_by_id name=Type;
	id ParkName;
run;

proc transpose data=pg2.np_2017camping out=camp_trans_2_by(rename=(col1=Count)) 
		name=Location;
	by ParkName;
run;

proc transpose data=pg2.np_2017camping out=camp_trans_2_by(rename=(col1=Count)) 
		name=Location;
	by ParkName;
	var Tent RV;
run;

proc print data=pg2.np_2017camping(obs=10);
proc print data=camp_trans;
proc print data=camp_trans_2_by_id;
proc print data=camp_trans_2_by(obs=10);
run;

/* Important Note: Remember the BY statement indicates the groups, the ID  */
/* indicates the names and the VAR statement lists the variable to transpose */
proc print data=pg2.np_2016camping(obs=10);
run;

proc transpose data=pg2.np_2016camping out=camp_tr(drop=_name_);
	by ParkName;
	id CampType;
	var CampCount;
run;

proc print data=pg2.np_2016camping(obs=10);
proc print data=camp_tr(obs=10);
run;