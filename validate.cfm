<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>1000AD Validation</title>
</head>

<body bgcolor="Black" text="White" link="Aqua" vlink="Aqua" alink="Aqua">

<cfparam name="vcode" default="">
<cfparam name="eflag" default="">

<cfif eflag is "validate">
	<cfset vcode = trim(vcode)>
	<cfif vcode is not "">
		<cfquery datasource="#dsn#" name="p">
        	select id, name from player where validationcode = '#vcode#'
        </cfquery>
		<cfif p.recordcount is 0>
			<cfset eflag = "">
			<font face="verdana" color="red" size="2">Invalid validation code.</font><br>
		<cfelse>
			<cfquery datasource="#dsn#">
                update player set validationcode = '' where id = #p.id#
            </cfquery>
			<font face="verdana" size="2">
			Empire <cfoutput>#p.name# (#p.id#)</cfoutput> validated.<br>
			<a href="login.cfm">Login To Game</a>
			</font>
		</cfif>
	</cfif>
<cfelseif eflag is "email">
	<cfset eflag = "">
	<cfset loginname = trim(loginname)>
	<cfquery datasource="#dsn#" name="p">
    	select email, validationCode from player where loginname = '#loginname#'
    </cfquery>
	<cfif p.recordcount is 0>
		<font face="verdana" color="red" size="2">Empire with login name '<cfoutput>#loginname#</cfoutput>' does not exist.</font>
		<br>
	<cfelse>
		<cfmail to="#p.email#" from="#adminEmail#" server="#mailserver#" subject="1000 A.D. Validation Code" type="HTML">
				You have to validate your account to be able to play after 3 days.<br>				
				Your validation code is: #p.validationCode#<br>				
				or just use this link to validate your account:<br>				
				<a href="#webpath#validate.cfm?vcode=#p.validationCode#">#webpath#validate.cfm?vcode=#p.validationCode#</a><br>				
				<br>				
				Thank You for playing 1000AD.<br>				
				If you have any question you can contact me at: andrew@c3chicago.com<br>		
		</cfmail>
		<font face="verdana" size="2">E-mail has been sent with validation code.</font><br>
		<br>
		
	</cfif>
</cfif>

<cfif eflag is "">
<cfparam name="eflag_message" default="">
<font face="verdana" size="2"><b>1000 AD Validation</b><br>
<cfif eflag_message is not "">
	<cfoutput>#eflag_message#</cfoutput><br>
</cfif>
<form action="validate.cfm" method="post">
<input type="hidden" name="eflag" value="validate">

Validation Code: <input type="Text" name="vcode" value="<cfoutput>#vcode#</cfoutput>" size=50 maxlength=50>
<input type="Submit" value="Validate">
</form><br>
<br>
E-mail validation code to me:<br>
<form action="validate.cfm" method="post">
<input type="hidden" name="eflag" value="email">
<cfparam name="loginName" default="">
Login Name: <input type="Text" name="loginName" value="<cfoutput>#loginname#</cfoutput>" size=20 maxlength=50>
<input type="Submit" value="E-mail Validation Code">
</form><br>
<br>
<a href="login.cfm">Back To 1000AD</a>
</cfif>
</body>
</html>
