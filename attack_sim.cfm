<!---
	1000 AD
	Andrew Deren
	(C) AderSoftware 2000
--->

<cfparam name="attack_swordsman" default="10">
<cfparam name="attack_archers" default="10">
<cfparam name="attack_horseman" default="10">

<cfparam name="defense_swordsman" default="10">
<cfparam name="defense_archers" default="10">
<cfparam name="defense_horseman" default="10">
<cfparam name="defense_towers" default="2">
<cfif eflag is "attack">
	<cfscript>
		game = CreateObject("JAVA", "AderGame");
		game.attackSwordsman = #val(attack_swordsman)#;
		game.attackArchers = #val(attack_archers)#;
		game.attackHorseman = #val(attack_horseman)#;
		game.defenseSwordsman = #val(defense_swordsman)#;
		game.defenseArchers = #val(defense_archers)#;
		game.defenseHorseman = #val(defense_horseman)#;
		game.defenseTowers = #val(defense_towers)#;
		
		writeOutput("<font face=verdana size=2>");
		// phase 1, defense towers shoot
		gameOver = game.defenseShoot(game.defenseTowers, 50);
		writeOutput("Enemy Towers shoot killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman<br>.");
		if (gameOver is "YES") writeOutput("Your army has been killed.<br>");		
		
		// phase 2, defense towers shoot
		if (gameOver is "NO") {
			gameOver = game.defenseShoot(game.defenseTowers, 50);
			writeOutput("Enemy Towers shoot killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
		
		// attack archers shoot
		if (gameOver is "NO") {
			gameOver = game.attackShoot(game.attackArchers, 15);
			writeOutput("Archers shoot killing " & game.defenseDieSwordsman & " swordsman, " & game.defenseDieArchers & " archers and " & game.defenseDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Enemy defeated.<br>");		
		}
	
		
		// defense archers shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseArchers, 20);
			writeOutput("Enemy Archers shoot killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	
		
		// phase 3, defense towers shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseTowers, 50);
			writeOutput("Enemy Towers shoot killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	

		// attack archers shoot
		if (gameOver is "NO") {		
			gameOver = game.attackShoot(game.attackArchers, 15);
			writeOutput("Archers shoot killing " & game.defenseDieSwordsman & " swordsman, " & game.defenseDieArchers & " archers and " & game.defenseDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Enemy defeated.<br>");					
		}
	
		
		// defense archers shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseArchers, 20);
			writeOutput("Enemy Archers defend killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	

		// attack horseman attack
		if (gameOver is "NO") {		
			gameOver = game.attackShoot(game.attackHorseman, 35);
			writeOutput("Hoseman attack killing " & game.defenseDieSwordsman & " swordsman, " & game.defenseDieArchers & " archers and " & game.defenseDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Enemy defeated.<br>");					
		}
	

		// defense horseman shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseHorseman, 40);
			writeOutput("Enemy Horseman defend killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	
				
		// phase 4, attack swordsman
		if (gameOver is "NO") {		
			gameOver = game.attackShoot(game.attackSwordsman, 25);
			writeOutput("Swordsman attack killing " & game.defenseDieSwordsman & " swordsman, " & game.defenseDieArchers & " archers and " & game.defenseDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Enemy defeated.<br>");					
		}
	

		// defense swordsman shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseSwordsman, 30);
			writeOutput("Enemy swordsman defend killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	
		// attack horseman attack
		if (gameOver is "NO") {
			gameOver = game.attackShoot(game.attackHorseman, 35);
			writeOutput("Hoseman attack killing " & game.defenseDieSwordsman & " swordsman, " & game.defenseDieArchers & " archers and " & game.defenseDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Enemy defeated.<br>");					
		}
	
		// defense horseman shoot
		if (gameOver is "NO") {		
			gameOver = game.defenseShoot(game.defenseHorseman, 40);
			writeOutput("Enemy Horseman defend killing " & game.attackDieSwordsman & " swordsman, " & game.attackDieArchers & " archers and " & game.attackDieHorseman & " horseman.<br>");
			if (gameOver is "YES") writeOutput("Your army has been killed.<br>");					
		}
	
		writeOutput("-------------------- Final Results ----------------------------<br>");
		writeOutput("Attacker killed " & game.defenseTotalDieSwordsman & " swordsman, " & game.defenseTotalDieArchers & " archers and " & game.defenseTotalDieHorseman & " horseman.<br>");		
		writeOutput("Enemy killed " & game.attackTotalDieSwordsman & " swordsman, " & game.attackTotalDieArchers & " archers and " & game.attackTotalDieHorseman & " horseman.<br>");		
		
		youKilled = game.defenseTotalDieSwordsman + game.defenseTotalDieArchers + game.defenseTotalDieHorseman;
		youLost = game.attackTotalDieSwordsman + game.attackTotalDieArchers + game.attackTotalDieHorseman;
		
		enemyRemaining = game.defenseSwordsman + game.defenseArchers + game.defenseHorseman;
		
		if (youKilled gt youLost or enemyRemaining is 0) {
			writeOutput("<br>You won the war!<br>");
		}
		else {
			writeOutput("<br>You lost the war!<br>");
		}
	</cfscript>
</cfif>

<font face=verdana size=2>
<form action="index.cfm" method="post">
<input type="hidden" name="page" value="attack_sim">
<input type="hidden" name="eflag" value="attack">
Your army:<br>
<input type="text" name="attack_swordsman" value="<cfoutput>#attack_swordsman#</cfoutput>">Swordsman<br>
<input type="text" name="attack_archers" value="<cfoutput>#attack_archers#</cfoutput>">Archers<br>
<input type="text" name="attack_horseman" value="<cfoutput>#attack_horseman#</cfoutput>">Horseman<br>
<br>
<br>
Defense army:<br>
<input type="text" name="defense_swordsman" value="<cfoutput>#defense_swordsman#</cfoutput>">Swordsman<br>
<input type="text" name="defense_archers" value="<cfoutput>#defense_archers#</cfoutput>">Archers<br>
<input type="text" name="defense_horseman" value="<cfoutput>#defense_horseman#</cfoutput>">Horseman<br>
<input type="text" name="defense_towers" value="<cfoutput>#defense_towers#</cfoutput>">Towers<br>
<br>
<input type="Submit" value="Attack">
</font>