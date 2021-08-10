<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<font face=verdana size=3>
		<a href="index.cfm?page=build">Build</a> |
		<a href="index.cfm?page=explore">Explore</a> |
		<a href="index.cfm?page=army">Army</a> |
		<a href="index.cfm?page=attack">Attack</a> |
		<a href="index.cfm?page=manage">Management</a> |
		<a href="index.cfm?page=scores">Scores</a> |
		<a href="login.cfm?eflag=logout">Logout</a> |
		<a href="index.cfm?page=docs">Help / Docs</a> |
		<a href="index.cfm?page=attack_sim">Attack Simulator</a> |
</font>
<br>

<table border=1 cellspacing=0 cellpadding=2>
<tr>
	<td>Player</td>
	<td>&nbsp;</td>
	<td>Date</td>
	<td>Score</td>
	<td>People</td>
	<td>Wood</td>
	<td>Iron</td>
	<td>Gold</td>
	<td>Food</td>
	<td>Tools</td>
	<td>Mount.</td>
	<td>Forest</td>
	<td>Plains</td>
	<td>&nbsp;</td>
</tr>
<tr>
	<td><cfoutput>#player.name#</cfoutput></td>
	<td><a href="index.cfm?page=menu">Main Menu</a></td>
	<cfoutput>
	<cfset month = (player.turn mod 12)+1>
	<cfset year = int(player.turn / 12) + 1000>
	<td>#MonthAsString(month)# #year#</td>
	<td>#NumberFormat(player.score, "_,___,___")#</td>
	<td>#player.people#</td>
	<td>#player.wood#</td>
	<td>#player.iron#</td>
	<td>#player.gold#</td>
	<td>#player.food#</td>
	<td>#player.tools#</td>
	<td>#player.mLand#</td>
	<td>#player.fLand#</td>
	<td>#player.pLand# P</td>
	<td><a href="index.cfm?page=#page#&eflag=end_turn">End Turn</a></td>
	</cfoutput>
</tr>
</table>