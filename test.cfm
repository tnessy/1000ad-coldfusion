<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<cfparam name="eflag" default="">
<cfparam name="ename" default="">

<cfif eflag is "doit">
	<cfoutput>
	<cfset ename = trim(ename)>
	<cfset isValid = true>
	<cfloop from="1" to="#len(ename)#" index="i">
		<cfset ch = asc(mid(ename, i, 1))>
		<cfif (ch gte 65 and ch lte 90) or (ch gte 97 and ch lte 122) or ch is 32 or ch is 95>
		
		<cfelse>
			<cfset isValid = false>
		</cfif>
	</cfloop>
	valid: #isvalid#<br>
	
	</cfoutput>
</cfif>

<cfoutput>
A:#asc("A")# - Z:#asc("Z")# - a:#asc("a")# - z:#asc("z")# - space:#asc(" ")# - _:#asc("_")# -
0:#asc("0")# - 9:#asc("9")#
</cfoutput>

<form action="test.cfm" method="post">
<input type="hidden" name="eflag" value="doit">
<input type="Text" name="ename" value="<cfoutput>#ename#</cfoutput>">
</form>


</body>
</html>
