<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<a href="http://www.adersoftware.com/cgi-bin/forumdisplay.cgi?action=topics&forum=1000AD+Alliance+Talk&number=1" target="_blank">Alliances</a>
<hr noshade size="1" color="darkslategray">
<a href="http://www.adersoftware.com/cgi-bin/forumdisplay.cgi?action=topics&forum=1000AD+Bugs&number=3" target="_blank">Bugs</a>
<hr noshade size="1" color="darkslategray">
<a href="http://www.adersoftware.com/cgi-bin/forumdisplay.cgi?action=topics&forum=1000AD+General&number=2" target="_blank">General</a>
<hr noshade size="1" color="darkslategray">
<a href="http://www.adersoftware.com/cgi-bin/forumdisplay.cgi?action=topics&forum=Beta+Version+Suggestions&number=4" target="_blank">Beta Version</a>
<hr noshade size="1" color="darkslategray">
<!---
<cfquery name="m" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    select * from forumMessage where parentID = 0
	<cfif val(player.isAdmin) is 0>and adminOnly = 0</cfif>
	order by lastUpdate desc
</cfquery>
<font face=verdana size=1>
<cfoutput query="m">
<a href="index.cfm?page=forum&forumID=#m.id#">
<b>#DateFormat(m.lastUpdate, "mm/dd/yy")# #timeFormat(m.lastUpdate, "hh:mm tt")# - #m.lastUpdateBy#</b><br>
#m.title#</a>
<hr noshade size="1" color="darkslategray">
</cfoutput>
---->