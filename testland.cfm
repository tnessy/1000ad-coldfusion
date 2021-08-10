<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>
<font face="verdana" size="2">
<cfparam name="eflag" default="">
<cfparam name="people" default="">
<cfparam name="seekLand" default="">
<cfset message = "">

<cfif eflag is "test">
<cfscript>
		m = people * 0.15;
		f = people * 0.30;
		p = people * 0.65;
		m_half = round(m/3);
		f_half = round(f/3);
		p_half = round(p/3);

		if (seekLand is 1) {
			m = m * 3; m_half = m_half * 3;
			f = 0; f_half = 0; 
			p = 0; p_half = 0;
		}
		else if (seekLand is 2) {
			m = 0; m_half = 0;
			f = round(f * 2.5); f_half = round(f_half * 2.5);
			p = 0; p_half = 0;
		}
		else if (seekLand is 3) {
			m = 0; m_half = 0;
			f = 0; f_half = 0;
			p = p * 2;	p_half = p_half * 2;
		}
		writeoutput("M: #m_half# - #m#<br>");
		writeoutput("F: #f_half# - #f#<br>");
		writeoutput("P: #p_half# - #p#<br>");
		
		m = randRange(m_half, m);  // chance to find mountains
		f = randRange(f_half, f);  // chance to find forest
		p = randRange(p_half, p);  // chance to find plains

		message = message & "M: #m# - F: #f# - P: #p#<br>";
	</cfscript>
	<cfoutput>#message#</cfoutput><br>	
</cfif>

<form action="testland.cfm" method="post">
<input type="hidden" name="eflag" value="test">
People: <input type="Text" name="people" value="<cfoutput>#people#</cfoutput>"><br>
Type: <input type="Text" name="seekLand" value="<cfoutput>#seekLand#</cfoutput>"><br>
<input type="Submit">
</form>		


</body>
</html>
