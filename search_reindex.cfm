<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<!--- pages to index --->
<cfset pageFiles = listToArray("home,basics,resources,buildings,army,attack,explore,people,research,trade,aid,civs")>
<cfset pageNames = listToArray("Home,Game Basics,Resources,Buildings,Unit,Attacking,Exploring,Population,Research,Trade,Aid,Civilizations")>

<cfset count = arrayLen(pageFiles)>
<cfloop from="1" to="#count#" index="i">
	<cfindex collection="#veritySearch#" type="FILE" title="#pageNames[i]#" action="UPDATE" key="#pageFiles[i]#">
</cfloop>


</body>
</html>
