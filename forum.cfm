<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<cfset forumID = forumID>

<cfquery name="forum" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    select * from forumMessage where id = #forumID#
</cfquery>
<cfif forum.recordcount is 0>
	Invalid Forum.<br>
	<cfabort>
</cfif>
<br>
<br>

<table border=0 cellspacing=0 cellpadding=0 width="100%">
<tr>
	<td bgcolor="darkslategray"><font color="White" size="2" face="Verdana">
		<cfoutput>#forum.title# - #dateFormat(forum.lastUpdate, "mm/dd/yyyy")# #timeFormat(forum.lastUpdate, "hh:mm tt")# by #forum.lastUpdateBy#</cfoutput>
	</td>
</tr>   
<cfquery name="m" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
    select * from forumMessage where parentID = #forumID# order by lastUpdate desc
</cfquery>
<cfif m.recordcount is 0>
	<tr><td>There are no messages in this forum</td></tr>
<cfelse>
<tr>
	<td><font face=verdana size=2>
	<cfoutput query="m">
			<b>#m.title# - #dateFormat(m.lastUpdate, "mm/dd/yyyy")# #timeFormat(m.lastUpdate, "hh:mm tt")# by #m.lastUpdateBy#</b><br>
			#m.message#
			<cfif player.isAdmin is 1>
				<br><a href="index.cfm?page=forum&eflag=delete_entry&entryID=#m.id#&forumID=#forumID#">Delete Entry</a>
			</cfif>
		</font>
		<hr noshade size="1">
	</cfoutput>
</cfif>
<tr><td>
	<br>
	<br>
	<table border=0 cellspacing=0 cellpadding=0>
	<form action="index.cfm" method="post">
	<input type="hidden" name="page" value="forum">
	<input type="hidden" name="eflag" value="add_entry">
	<input type="hidden" name="forumID" value="<cfoutput>#forumID#</cfoutput>">
	<tr><td colspan="2" bgcolor="darkslategray"><font color=white><b>Add New Message:</b></td></tr>
	<tr><td>Your Name:</td><td><input type="Text" name="userName" maxlength="50" size="40"></td></tr>
	<tr><Td>Title: </td><td><input type="Text" name="title" maxlength="100" size="40"></td></tr>
	<tr><td colspan=2><textarea name="message" rows="10" cols="40"></textarea></td></tr>
	<tr><td colspan=2 align=center><input type="Submit" value="Submit"></td></tr>	
	</form>
	</table>
	</td>
</tr>
</table>