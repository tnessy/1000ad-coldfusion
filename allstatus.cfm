<cfparam name="pw" default="">
<!--- 
	Project: 1000 AD
	Author: Andrew Deren - Ader Software 2000 http://www.adersoftware.com
	File: alliance.cfm
	Date: 12/07/2000
 --->
<cfif pw is not "testgame"><cfabort></cfif> 
 
 <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
<style type="text/css">
	TD {
		font-family:verdana;
		font-size:x-small;
	}  
	TD.HEADER {
		font-family:verdana;
		font-size:x-small;
		background-color: darkslategray;
		color: white;	
	}
	A {
		text-decoration: none;
	}
	A:hover {
		color: red;
		text-decoration: overline underline;
	}
</style>

	<title>Untitled</title>
</head>

<body background="images/bg.gif" bgcolor="Black" alink="Aqua" link="Aqua" text="White" vlink="Aqua">

<cfparam name="ocol" default="player.id">
<cfquery name="member" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
	select player.id, turn, player.name, lastLoad, alliance.tag, (pland+mland+fland) as totalland, score, (swordsman+horseman+archers+trainedPeasants+thieves+catapults+macemen) as totalarmy 
	from player left outer join alliance on player.allianceID = alliance.id
	order by #ocol#
</cfquery>
<table border=1 cellspacing=1 cellpadding=1 bordercolor="darkslategray">
<tr>
	<td class="HEADER">#</td>
	<td class="HEADER">PID</td>
	<td class="HEADER">Name</td>
	<td class="HEADER">Alliance</td>
	<td class="HEADER">Army</td>
	<td class="HEADER">Land</td>
	<td class="HEADER">Score</td>	
	<td class="HEADER">Last Load</td>
	<td class="HEADER">Turns</td>
</tr>
<cfoutput query="member">
<tr><td>#member.currentrow#</td>
	<td>#member.id#</td>
	<td>#member.name#</td>
	<td>#member.tag#&nbsp;</td>
	<td>#member.totalarmy#</td>
	<td>#member.totalland#</td>
	<td>#member.score#</td>
	<td><cfif not isDate(member.lastLoad)><font coor=red>Never Played</font>
		<cfelse>
			<cfset h = dateDiff("h", member.lastLoad, now())>
			<cfset m = dateDiff("n", member.lastLoad, Now())>
			<cfset m = m - (h*60)>
			#h# hours and  #m# minutes ago.
		</cfif>
	</td>
	<td>#member.turn#</td>
</tr>
</cfoutput>
</body>
</html>
