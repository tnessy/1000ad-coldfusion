<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Create Player</title>
</head>

<body bgcolor="Black" text="White" link="Aqua" vlink="Aqua" alink="Aqua">

<cfparam name="eflag" default="">
<cfset message = "">
	
<cfif eflag is "createPlayer" and not deathMatchStarted>
	<cfset playerName = trim(form.empireName)>
	<cfset loginName = trim(form.loginName)>
	<cfset passwd1 = trim(form.passwd1)>
	<cfset passwd2 = trim(form.passwd2)>
	<cfset email = trim(form.email)>
	<cfset civ = val(form.civ)>
	<cfif civ lt 1 or civ gt 6><cfset civ = 1></cfif>
	
	<cfset isValid = true>
	<cfloop from="1" to="#len(playerName)#" index="i">
		<cfset ch = asc(mid(playerName, i, 1))>
		<cfif (ch gte 65 and ch lte 90) or (ch gte 97 and ch lte 122) or ch is 32 or ch is 95 or (ch gte 48 and ch lte 57)>
		
		<cfelse>
			<cfset isValid = false>
		</cfif>
	</cfloop>

	<cfset eflag = "">
	<cfif playerName is "">
		<cfset message = message & "Empire name cannot be empty<br>">
	<cfelseif passwd1 is "">
		<cfset message = message & "Password cannot be empty<br>">
	<cfelseif passwd1 is not passwd2>
		<cfset message = message & "Your verify password does not the password you entered<br>">
	<cfelseif email is "">
		<cfset message = message & "Please enter your e-mail<br>">
	<cfelseif loginname is "">
		<cfset message = message & "Login name cannot be empty<br>">
	<cfelseif not isValid>
		<cfset message = message & "Empire name can only contain spaces and alpha-numeric characters<br>">
	<cfelse>
		<!--- check if player with that name does not exist --->
		<cfquery name="e" datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
            select id from player where name = '#playerName#'
        </cfquery>
		<cfquery datasource="#dsn#" name="e2">
            select id from player where loginname = '#loginname#'
        </cfquery>
		<cfif e.recordcount gt 0>
			<cfset message = message & "Empire  with that name already exists<br>">		
		<cfelseif e2.recordcount gt 0>
			<cfset message = message & "Login name already exists<br>">
		<cfelse>
			<cfset cDate = now()>
			<cfset lastTurn = createDateTime(year(cDate), month(cDate), day(cDate), hour(cDate), minute(cDate), 0)>
			
			<cfset numTurns = startTurns>
			<!--- calculate number of turns extra --->
			<cfset extra = dateDiff("n", startGameDate, now())>
			<cfset extra = round(extra / minutesPerTurn)>
			<cfset numTurns = numTurns + extra>
			<cfif numTurns gt maxTurnsStored><cfset numTurns = maxTurnsStored></cfif>
			
			<cfset vCode = createUUID()>
			<cfquery datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#">	
                insert into player (
					name, email, passwd, toolMaker, woodCutter, loginname, foodRatio,
					goldMine, hunter, tower, towncenter, market, 
					ironMine, house, farmer,
					fland, mland, pland, swordsman, archers, 
					horseman, people, wood, food, iron, 
					gold, tools, turn, civ, 
					hunterStatus, farmerStatus, ironMineStatus, goldMineStatus, toolMakerStatus, weaponSmithStatus, 
					stableStatus, woodCutterStatus, mageTowerStatus, wineryStatus,
					message, 
					lastTurn, turnsFree, createdOn, validationCode)
				values (
					'#playerName#', '#email#', '#passwd1#', 10, 20, '#loginname#', 1, 
					10, 50, 10, 10, 10, 
					20, 50, 20,
					1000, 500, 2500, 3, 3, 
					3, 3000, 1000, 2500, 1000, 
					100000, 250, 0, #civ#,
					100, 100, 100, 100, 100, 100,
					100, 100, 100, 100,
				'Thank you for playing 1000 A.D.<br> View Help / Docs section for information on how to play this game.', 
					#lastTurn#, #numTurns#, #now()#, '#vCode#')
   	        </cfquery>

			<cfquery datasource="#dsn#" name="pl">
                select id from player where loginname = '#loginname#'
            </cfquery>
			<cf_calc_score datasource="#dsn#" username="#dsn_login#" password="#dsn_pw#" playerID="#pl.id#">	
			<cfset message = message & "Your empire '#playerName#' (#pl.id#) has been created. <br><a href='login.cfm'>Go back</a> to login page<br><br>">
			<cfmail to="#email#" from="#adminEmail#" server="#mailserver#" subject="1000 A.D. Account Created" type="HTML">
				<b>Thank you for trying 1000 A.D.</b><br>
				<br>
				Your account has been created with the following information:<br>
				Login Name: #loginname#<br>
				Password: #passwd1#<br>
				E-mail: #email#<br>
				Empire Name: #playerName#<br>
				<br>				
				To play the game go #webpath#login.cfm<br>
				<br>
				Thank You for playing 1000AD.<br>				
				If you have any question you can contact me at: andrew@c3chicago.com<br>
				<br>				
			</cfmail>
			<cfset eflag = "created">
		</cfif>
	</cfif>
</cfif>

<cfparam name="empireName" default="">
<cfparam name="email" default="">
<cfparam name="loginName" default="">

<table border=0 cellspacing=0 cellpadding=0>
<tr><td colspan="3" align="center">
		<font face=verdana size=10 color="White"><b>1000   A. D.</b></font><br>
		</font>
	</td>
</tr>   
<tr>
	<td width="200" valign="top"><br>
	<br>
	
		<table border=1 cellspacing=0 cellpadding=0 width="200" bordercolor="darkslategray">
        <tr>
			<td bgcolor="darkslategray" align="center"><font face=verdana size=2 color="White">
				<b>Instructions</b>
			</font>
			</td>
		</tr>
		<tr>
			<td><font face=verdana size=2 color="White">
				All fields are required. You are allowed only 1 account per game. If you are found using
				multiple accounts, all of them could be deleted.
				Your e-mail address will stay confidential.<br>
				<br>
				<a href="login.cfm">Back to Home</a>
			</td>
		</tr>
        </table>
	</td>
	<td width="10">&nbsp;</td>
	<td width="400" align="right" valign="top"><br>
	<br>
		<table border=1 cellspacing=0 cellpadding=0 width="400" bordercolor="darkslategray">
        <tr>
			<td bgcolor="darkslategray" align="center"><font face=verdana size=2>
				<b>Create Your Account:</b>
			</td>
		</tr>
		<form action="createPlayer.cfm" method="post">
		<input type="hidden" name="eflag" value="createPlayer">
		<tr>
			<td align="center"><br>
				<font face=verdana size=2 color="Yellow"><cfoutput>#message#</cfoutput></font>
				<cfif eflag is not "created">
				<table border=0 cellspacing=0 cellpadding=0>
                <tr>
					<td><font face=verdana size=2>Login Name:</font></td>
					<td><input type="Text" name="loginName" size="30" maxlength="50" value="<cfoutput>#loginName#</cfoutput>"></td>
				</tr>				
				<tr>
					<td><font face=verdana size=2>Password:</font></td>
					<td><input type="Password" name="passwd1" size="30" maxlength="50"></td>
				</tr>
				<tr>
					<td nowrap><font face=verdana size=2>Verify Password:</font></td>
					<td><input type="Password" name="passwd2" size="30" maxlength="50"></td>
				</tr>
                <tr>
					<td><font face=verdana size=2>E-mail address:</font></td>
					<td><input type="Text" name="email" size="30" maxlength="50" value="<cfoutput>#email#</cfoutput>"></td>
				</tr>			
                <tr>
					<td><font face=verdana size=2>Empire Name:</font></td>
					<td><input type="Text" name="empireName" size="30" maxlength="20" value="<cfoutput>#empireName#</cfoutput>"></td>
				</tr>
								
				<tr>
					<cfparam name="civ" default="1">
					<td valign="top"><font face=verdana size=2>Civilization:</font></td>
					<td><font face="verdana" size="2">
					<input type="Radio" name="civ" value="1" <cfif civ is 1>checked</cfif>><b>Vikings</b> 
					<br><font face="verdana" size="1">
Unique Unit: Berserker<br>
<b>Pluses</b><br>
Woodcutter: -2 land used and +2 wood produced<br>
Hunter: +2 food produced<br>
Iron Mine: +1 iron produced<br>
<b>Minuses</b><br>
Stable: +2 more land used and uses 50 more food to grow a horse<br>
Warehouse: stores half of the goods<br>
House: -25 less people<br>
Farm: -2 food produced<br>
					</font>
					<br>
					<input type="Radio" name="civ" value="2" <cfif civ is 2>checked</cfif>><b>Franks</b> <br>
					<font face="verdana" size="1">
Unique Unit: Paladin<br>
<b>Pluses</b><br>
Farm: -2 land used<br>
Tool maker: +4 builders<br>
Tower: -1 land used, -10 iron and wood building cost, +15 defense points<br>
Town center: +1 explorer<br>
Mage Tower: -5 workers needed<br>
<b>Minuses</b><br>
Town center: +10 land used<br>
Fort: -3 less army<br>
Mage Tower: +2 land used and <br>
					</font>
					<br>					
					<input type="Radio" name="civ" value="3" <cfif civ is 3>checked</cfif>><b>Japanese</b> <br>
					<font face="verdana" size="1">
Unique Unit: Samurai<br>
<b>Pluses</b><br>
Farm: +2 food production<br>
House: +20 more people<br>
Town Center: -5 land used<br>
Mage Tower: +0.5 research points produced<br>
<b>Minuses</b><br>
Hunter: -1 food produced<br>
Woodcutter: +1 land used<br>
Market: -10 less trades per month<br>
Stable: +4 land used and +25 more food used to grow a horse<br>
					</font>
					<br>
					<input type="Radio" name="civ" value="4" <cfif civ is 4>checked</cfif>><b>Byzantines</b> <br>
					<font face="verdana" size="1">
Unique Unit: Cataphract<br>
<b>Pluses</b><br>
Gold Mine: -4 land used and +150 gold produced<br>
Town Center: -3 land used<br>
Market: +50 more trades per month<br>
Warehouse: stores twice as many goods<br>
Mage Tower: -2 land used<br>
Archer: +3 defense points<br>
Horseman: +2 attack points<br>
Catapult: +5 attack and defence points<br>
<b>Minuses</b><br>
Iron Mine: +1 land used<br>
Tool Maker: -1 less builders<br>
People eat 20% more food<br>
					</font>
					<br>
					
					<input type="Radio" name="civ" value="5" <cfif civ is 5>checked</cfif>><b>Mongols</b> <br>
					<font face="verdana" size="1">
Unique Unit: Horse Archer<br>
<b>Pluses</b>
Fort: -4 land used, +5 more army<br>
Weaponsmith: +1 weapons produced for the same cost in iron and wood<br>
Tool Maker: +1 tool produced for the same cost in iron and wood<br>
Tool Maker: +2 more builders<br>
Stable: +1 horse produced for the same cost in food<br>
Hunters: +1 more food produced<br>
<b>Minuses</b><br>
Town Center: -1 explorer<br>
Farms: -2 food produced<br>
Mage Tower: +100 gold to produce 1 research point<br>
People eat 20% more food<br>
					</font>
					<br>

					<input type="Radio" name="civ" value="6" <cfif civ is 6>checked</cfif>><b>Incas</b> 
					<font face="verdana" size="1">
					<br>
Unique Unit: Shaman<br>
<b>Pluses</b><br>
Mage Tower: -60 gold used for research<br>
Town Center: stores 2500 more goods<br>
Market: +50 more goods traded each month<br>
Thieves: +25 defense points<br>
Swordsman: +1 attack point<br />
Maceman: +2 attack points<br />
<b>Minuses</b><br>
Town Center: +5 more land used<br>
Iron Mine: +1 more land used<br>
Catapults: -9 attack points and -5 defense points<br>
Horseman are useless<br>
					</font>
					<br>
					</font>
					</td>
				</tr>
				<tr>
					<td bgcolor="darkslategray" colspan="2" align="center"><font face="verdana" size="2" color="White">Note!!!</td>
				</tr>
				<tr>
					<td colspan="2"><font face="verdana" size="2">
						You are allowed only account for this game (except test game, where you're allowed 
						multiple accounts). 
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center"><br>
					<input type="Submit" value="    Create My Empire    "><br>
					<br>
					</td>
				</tr>	
                </table>
				</cfif>
			</td>
		</tr>
		</form>
		</table>
	</td>
</tr>
<tr><td colspan="3" align="center"><font face=verdana size=2 color="White">
	<hr noshade size="1" color="darkslategray">
	&copy; Copyright Ader Software 2000, 2001<br>
	<a href="mailto:andrew@c3chicago.com">Contact Us</a>
</td></tr>
</table>


</body>
</html>
