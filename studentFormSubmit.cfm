<!--- create new order  --->
<cf_generateorderidentifier>
<cf_uniqueid datasource="#dsn#" tablename="orders">
<cfquery datasource="#dsn#">
	insert into orders (id, orderid, createdOn)
	values (#uniqueid#, '#orderid#', #Now()#)
</cfquery>

<!--- go thru all items and add to cart --->
<cfset totalQty = 0>
<cfloop list="#itemlist#" index="i">
	<cfset qty = val(evaluate("qty#i#"))>
	<cfif qty gt 0>
		<cfset totalQty = totalQty + qty>
		<cfquery datasource="#dsn#" name="item">
        	select name, identifier from item where id = #i#
        </cfquery>
		<cfset price = 0>
		<cf_getItemPrice datasource="#dsn#" qty="#qty#" itemid="#i#" customerMemberLevel=0>
		<cf_uniqueid datasource="#dsn#" tablename="orderitem">
		<cfquery datasource="#dsn#">
            insert into orderitem (id, itemidentifier, itemname, itemprice, total, qty, createdOn, itemid, orderid)
			values (#uniqueid#, '#item.identifier#', '#item.name#', #price#, #val(price*qty)#, #qty#,
				#now()#, #i#, '#orderid#')
        </cfquery>
	</cfif>
</cfloop>

<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript">
<!--
window.open("../processOrder.cfm?ssnumber=<cfoutput>#ssnumber#</cfoutput>");
//-->
</SCRIPT>