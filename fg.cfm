<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<!--- uncomment abort when done. Do not want to run this script --->
<cfset dsn = "ad1000">
<cfabort>
<cfquery name="player" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
	select id, name, email, (mland+fland+pland) as land, score from player order by score desc
</cfquery>

<cfloop query="player">
	<cfmail to="#player.email#" from="#adminEmail#" server="#mailserver#" subject="Current game of 1000 AD has ended.">
		The current game of 1000 AD has ended. 
		Your final results for empire #player.name# (#player.id#) are:
		score: #player.score#
		ranking: #player.currentrow# out of #player.recordcount#
		land: #player.land#
		
		If you have not played 1000 AD recently, there are a lot of new exiciting changes 
		in the new game. You can choose to play any or all of the 2 available games:
		Standard Game  with turns every 10 minutes and maximum stored 300
		and NEW Deathmatch game with new exciting rules.
		Now every civilization has its own weaknesses and strengths.

		We hope you will be back to create your empire, 
		and allied with others to conquer your opponents. 
		Just point your browser to:
		http://www.1000ad.net/thegame/
		and create your new empire.
		
		Have a nice play, and Happy Holidays.
		Wishes you AderSoftware
		Thank You
	</cfmail>
</cfloop>


</body>
</html>
