<!--- 
	Project: 1000 AD
	Author: Andrew Deren - Ader Software 2000 http://www.adersoftware.com
	File: alliance.cfm
	Date: 12/07/2000
 --->
<table border=0 cellpadding=0 cellspacing=0 width="100%">
<tr>
	<td class="HEADER" align="center" width="92%"><font face="verdana" size="3"><b>Alliance</td>
	<td class="HEADER" align="center" width="8%"><b><a href="javascript:openHelp('alliance')">Help</a></td>
</tr>
</table>
 
 
<cfif deathMatchMode or allianceMaxMembers is 0>
	<font face="verdana" color=red size=2>Cannot view this page in deathmatch game.</font>
	<cfabort>
</cfif>
 
<cfquery datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    update player set hasAllianceNews = 0 where id = #playerID#
</cfquery>

<cfif player.allianceID is 0><!--- doesn't belongs to any alliance --->
	<cfquery name="alliance" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    	select id, tag from alliance order by tag
    </cfquery>

	<br>
	<table border="1" cellpadding="1" cellspacing="1" bordercolor="darkslategray" width="250">
	<form action="index.cfm" method="post">
	<input type="hidden" name="page" value="alliance">
	<input type="hidden" name="eflag" value="join_alliance">
	<tr>
		<td class="HEADER">Join Alliance</td>
	</tr>
	<tr>
		<td nowrap>Alliance Tag:
		<select name="joinAllianceID">
		<option value="0">--- Select One ---
		<cfoutput query="alliance">
		<option value="#alliance.id#">#alliance.tag#
		</cfoutput>
		</select>
		<br>
		Password: &nbsp;&nbsp; <input type="Text" name="aPassword" size="20" maxlength="20">
		<center>
		<input type="Submit" value="Join" style="width:100">
		</td>
	</tr>
	</form>
	</table>
<br>
<br>
	<table border="1" cellpadding="1" cellspacing="1" bordercolor="darkslategray" width="250">
	<form action="index.cfm" method="post">
	<input type="hidden" name="page" value="alliance">
	<input type="hidden" name="eflag" value="create_alliance">
	<tr>
		<td class="HEADER">Create New Alliance</td>
	</tr>
	<tr>
		<td nowrap>Alliance Tag:
		<input type="Text" name="newTag" size="20" maxlength="15">
		<br>
		Password: &nbsp;&nbsp; <input type="Text" name="aPassword" size="20" maxlength="20">
		<center>
		<input type="Submit" value="Create Alliance" style="width:100">
		</td>
	</tr>
	</form>
	</table>	
	<br>
	
<cfelse>
	<cfquery name="all" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    	select id, tag from alliance where id <> #player.allianceID# order by tag
    </cfquery>
	
	<cfquery name="alliance" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    	select * from alliance where id = #player.allianceID#
    </cfquery>
	<cfquery datasource="#dsn#" name="allaly">
        select tag from alliance where ally1 = #player.allianceID# or ally2 = #player.allianceID# or ally3 = #player.allianceID# or ally4 = #player.allianceID# or ally5 = #player.allianceiD# order by tag
    </cfquery>
	<cfquery datasource="#dsn#" name="allwar">
        select tag from alliance where war1 = #player.allianceID# or war2 = #player.allianceID# or war3 = #player.allianceID# or war4 = #player.allianceID# or war5 = #player.allianceid# order by tag
    </cfquery>
	
	<center><font face="verdana" size=4><b>Alliance: <cfoutput>#alliance.tag#</cfoutput></font></center>
	<br>
		<cfquery name="member" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
        	select id, name, lastLoad, (pland+mland+fland) as totalland, score, (swordsman+horseman+archers+trainedPeasants+thieves+catapults+macemen) as totalarmy,
			alliancememberType as isTrusted
			from player where allianceID = #alliance.id#
			order by score desc
        </cfquery>
		
	
	<cfif alliance.leaderID is playerID>
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
        <tr>
			<td colspan="2" class="HEADER" align="center">Alliance Relations</td>
		</tr>
		<form action="index.cfm" method="post">
		<input type="hidden" name="page" value="alliance">
		<input type="hidden" name="eflag" value="change_relations">
		<tr>
			<td valign="top" width="50%" align="center"><b>Allies:</b><br>
				<cfloop from="1" to="5" index="i">
					<cfset aID = evaluate("alliance.ally#i#")>
					<select name="<cfoutput>n_ally#i#</cfoutput>">
					<option value="0">--- None ---					
					<cfoutput query="all">
						<option value="#all.id#" <cfif all.id is aID>selected</cfif>>#all.tag#
					</cfoutput>
					</select>		
					<br>
								
				</cfloop>
			</td>
			<td valign="top" width="50%" align="center"><b>War:</b><br>
				<cfloop from="1" to="5" index="i">
					<cfset aID = evaluate("alliance.war#i#")>
					<select name="<cfoutput>n_war#i#</cfoutput>">
					<option value="0">--- None ---					
					<cfoutput query="all">
						<option value="#all.id#" <cfif all.id is aID>selected</cfif>>#all.tag#
					</cfoutput>
					</select>					
					<br>
					
				</cfloop>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<font face="verdana" size=2>
				<b>Alliances that have your alliance on the ally list:</b><br>
					<cfloop query="allaly">
						<cfoutput>#allaly.tag#<br></cfoutput>
					</cfloop>
					<cfif allaly.recordcount is 0>None</cfif>
			</td>
			<td valign="top">
				<font face="verdana" size=2>
				<b>Alliances that have your alliance on the war list:</b><br>
				<cfloop query="allwar">
					<cfoutput>#allwar.tag#<br></cfoutput>
				</cfloop>
				<cfif allwar.recordcount is 0>None</cfif>
				
			</td>
			
		</tr>
		<tr><td colspan="2" align="center"><input type="Submit" value="Change Relations"></td></tr>
		</form>
        </table>
		<br>
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
		<form action="index.cfm" method="post">
		<input type="hidden" name="page" value="alliance">
		<input type="hidden" name="eflag" value="change_news">
        <tr>
			<td class="HEADER" align="center">Alliance News:</td>
		</tr>
		<tr>
			<td><textarea name="news" rows=5 cols=45><cfoutput>#alliance.news#</cfoutput></textarea></td>
		</tr>
		<tr><td align="center"><input type="Submit" value="Update News"></td></tr>		
		</form>
		</table>
		
		<br>
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
		<form action="index.cfm" method="post">
		<input type="hidden" name="page" value="alliance">
		<input type="hidden" name="eflag" value="change_password">
        <tr>
			<td class="HEADER" align="center">Leader Options:</td>
		</tr>
		<tr>
			<td>
			Change alliance password to <input type="Text" value="<cfoutput>#alliance.passwd#</cfoutput>" name="aPassword" size="10" maxlength="20">
			<input type="Submit" value="Change">
			</td>
		</tr>
		</form>
		</table>
		<br>
		<form action="index.cfm" method="post" onsubmit="return confirm('Are you sure you want to disband this alliance?')">
		<input type="hidden" name="page" value="alliance">
		<input type="hidden" name="eflag" value="finish_alliance">
		<input type="hidden" name="allianceTag" value="<cfoutput>#alliance.tag#</cfoutput>">
		<input type="Submit" value="Disband Alliance">
		</form>
				
	<cfelse><!--- not a leader --->
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
        <tr>
			<td colspan="2" class="HEADER" align="center">Alliance Relations</td>
		</tr>
		<tr>
			<td valign="top" width="50%"><b>Allies:</b><br>
				<cfset hasAllies = false>
				<cfloop from="1" to="5" index="i">
					<cfset aID = evaluate("alliance.ally#i#")>
					<cfquery name="ally" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
                    	select tag from alliance where id = #aID#
                    </cfquery>
					<cfif ally.recordcount gt 0>
						<cfoutput>#ally.tag#<br></cfoutput>
						<cfset hasAllies = true>
					</cfif>					
				</cfloop>
				<cfif not hasAllies>No Allies</cfif>
			</td>
			<td valign="top" width="50%"><b>War:</b><br>
				<cfset hasWar = false>
				<cfloop from="1" to="5" index="i">
					<cfset aID = evaluate("alliance.war#i#")>
					<cfquery name="ally" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
                    	select tag from alliance where id = #aID#
                    </cfquery>
					<cfif ally.recordcount gt 0>
						<cfoutput>#ally.tag#<br></cfoutput>
						<cfset hasWar = true>
					</cfif>
				</cfloop>
				<cfif not hasWar>No War</cfif>
			</td>
		</tr>
		<tr>
			<td valign="top">
				<font face="verdana" size=2>
				<b>Alliances that have your alliance on the ally list:</b><br>
					<cfloop query="allaly">
						<cfoutput>#allaly.tag#<br></cfoutput>
					</cfloop>
					<cfif allaly.recordcount is 0>None</cfif>
			</td>
			<td valign="top">
				<font face="verdana" size=2>
				<b>Alliances that have your alliance on the war list:</b><br>
				<cfloop query="allwar">
					<cfoutput>#allwar.tag#<br></cfoutput>
				</cfloop>
				<cfif allwar.recordcount is 0>None</cfif>
				
			</td>
			
		</tr>
		
        </table>
		<br>
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
        <tr>
			<td colspan="2" class="HEADER" align="center">Alliance News:</td>
		</tr>
		<tr>
			<td><cfif trim(alliance.news) is "">No Alliance News<cfelse><cfoutput>#replace(alliance.news, "#chr(10)#", "<BR>", "ALL")#</cfoutput></cfif></td>
		</tr>
		</table>
		<br>
		<br>
		<form action="index.cfm" method="post" onsubmit="return confirm('Are you sure you want to leave this alliance?')">
		<input type="hidden" name="page" value="alliance">
		<input type="hidden" name="eflag" value="leave_alliance">
		<input type="hidden" name="allianceTag" value="<cfoutput>#alliance.tag#</cfoutput>">
		<input type="Submit" value="Leave This Alliance">
		</form>
	</cfif>
	
		<table border="1" cellpadding="1" cellspacing="1" width="400" bordercolor="darkslategray">
        <tr>
			<td colspan="2" class="HEADER" align="center">Alliance Members:</td>
		</tr>
		<tr><td align="center">
		<cfoutput query="member">
			<cfif member.isTrusted is 1><b><u></cfif>#member.name# (###member.id#) <cfif member.isTrusted is 1></u></b></cfif><cfif member.id is alliance.leaderID><font color="Red"><b>&nbsp;&nbsp;&nbsp;Alliance Leader</b></font></cfif><br>
			<cfquery name="memberRank" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">
            	select count(*)+1 as cnt from player where score > #member.score#
            </cfquery>
			Rank: #memberRank.cnt#<br>			
			Score: #NumberFormat(member.score)#<br>
			Land: #NumberFormat(member.totalland)#<br>
			
			<cfif player.allianceMemberType is 1 or playerID is alliance.leaderID>
				Army: #NumberFormat(member.totalarmy)#<br>
				<font color=yellow size="1">
				<cfif not isDate(member.lastLoad)><font coor=red>Never Played</font>
				<cfelse>
					<cfset h = dateDiff("h", member.lastLoad, now())>
					<cfset m = dateDiff("n", member.lastLoad, Now())>
					<cfset m = m - (h*60)>
					<cfif h is 0 and m lte 10>
						<font color=red>* Online Now</font>
					<cfelse>
						Last played: <cfif h gt 0>#h# hours and </cfif> #m# minutes ago.
					</cfif>
					<br>
				</cfif>
				</font>
				<cfif member.id is not playerID and playerID is alliance.leaderID>
				<font face="verdana" size=1>
				<a href="index.cfm?page=alliance&eflag=viewArmy&memberID=#member.id#">View Army</a>
				<br>
				<a href="index.cfm?page=alliance&eflag=changeStatus&memberID=#member.id#">
				<cfif member.isTrusted is 1>Change to Starting Member<cfelse>Change to Trusted Member</cfif></a>
				<br>
				<a href="index.cfm?page=alliance&eflag=remove_from_alliance&removeID=#member.id#">Remove From Alliance</a>
				<br>
				<a href="index.cfm?page=alliance&eflag=give_leadership&newLeader=#member.id#">Give Leadership</a><br>

				</font>
				</cfif>
			</cfif>
			<cfif member.currentrow is not member.recordcount><hr noshade size="2" color="darkslategray"></cfif>
		</cfoutput>
			</td>
		</tr>
		</table>
		<br>
	
</cfif>