<cfif eflag is "change_pw">
	<cfif curPassword is not player.passwd>
		<cfset eflag_message = "Invalid current password entered.">
	<cfelseif newPassword is not newPassword2>
		<cfset eflag_message = "Your verify password does not match your new password.">
	<cfelse>
		<cfquery datasource="#dsn#">
            update player set passwd = '#newPassword#' where id = #playerID#
        </cfquery>	
		<cfmail to="#player.email#" from="#adminEmail#" server="#mailserver#" subject="1000AD account changed">
			Password for empire #player.name# has been changed to #newpassword#
			
			#webpath#login.cfm			
		</cfmail>
		<cfset eflag_message = "Password change successful.">
	</cfif>

<cfelseif eflag is "change_login">
	<!--- see if other player has the same login name --->
	<cfset newlogin = trim(form.newlogin)>
	<cfquery datasource="#dsn#" name="op">
        select id from player where loginname = '#newlogin#' and id <> #playerID#
    </cfquery>
	<cfif op.recordcount gt 0>
		<cfset eflag_message = "Cannot change login name. <br>Another player is using '#newlogin#'">
	<cfelse>
		<cfquery datasource="#dsn#">
            update player set loginname = '#newlogin#' where id = #playerID#
        </cfquery>
		<cfmail to="#player.email#" from="#adminEmail#" server="#mailserver#" subject="1000AD account changed">
			Login name for empire #player.name# has been changed to #newLogin#		
			
			#webpath#login.cfm
		</cfmail>
		<cfset eflag_message = "Login name change successful.">
		
	</cfif>
<cfelseif eflag is "delete_empire">
	<cfquery name="p" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">
    	select id from player where loginname = '#lname#' and passwd = '#curPassword#' and id = #playerID#
    </cfquery>
	<cfif p.recordcount is 0>
		<cfset eflag_message = "Invalid login name or password. <br>Account not deleted.">
	<cfelseif deathmatchStarted>
		<cfset eflag_message = "Cannot delete empires once deathmatch started.">
	<cfelse>
		<cfmail to="#player.email#" from="#adminEmail#" server="#mailserver#" subject="1000AD account deleted">
			You have deleted your account for login name: #player.loginname#
			Empire Name: #player.name#
			Empire Number: #player.id#
		</cfmail>
		<cfquery datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">
            delete from player where id = #p.id#
        </cfquery>
		<cfset eflag_message = "Your empire has been deleted.<br><a href=""http://#webpath#"">Back to game home page</a>">
		<cfabort>
	</cfif>
</cfif>