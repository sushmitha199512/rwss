<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
 
 

function fnAdd(frm)
{
	var selectedHabs = 	frm.elements("selectedHabCode");
	var len;
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations?"))
			{
				var index = document.getElementById("index").value;
				var totalHabitations = document.forms[0].elements("selectedHabCode");
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
							noOfSelectedHabs++;  
					}
				}
				var openerDoc = opener.document;
				openerDoc.getElementById("WORK["+index+"].noOfHabs").value = noOfSelectedHabs;
				return true;
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
}

function fnOpenerSubmit()
{
	
}
 
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="RevSaveHabitation" >

<logic:notEmpty name="habitations">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th>Constituency</th>
	<th>Mandal</th>
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">
<%int count=0; %>
<c:forEach items="${habitations}" var="item" varStatus="status">
<%count++; %>
<tr>
	<td align="center">
		<input type="checkbox" name="selectedHabCode" 
			  value=<c:out value="${item.habCode}" /> <c:out value='${item.habMatch}' />/>
	</td>
	<td align="left">
		<b><c:out value="${item.constituencyName}" /></b>
	</td>
	<td align="left">
		<b><c:out value="${item.mandalName}" /></b>
	</td>
	<td align="center">
	
		<b><c:out value="${item.habCode}" /></b>
	</td>
	<td align="left">
		<b><c:out value="${item.habName}" /></b>
	</td>
	<td align="right">
		<c:out value="${item.population}" />
	</td>
	<td align="center">
		<c:out value="${item.status}" />
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:submit  value="Add"  styleClass="btext" />
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="habitations">
<center><b class="gridLabel">
There are no habitations in the selected office.
<br>Please select different office</b><br> 
<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:empty>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">

<script>
<!-- 

var frm = document.forms[0];
var habs = frm.elements("selectedHabCode");
if(habs)
{
	if(typeof habs.length != 'number')
		habs = [habs];
	System.out.println("habssssssssssssssssssssss"+habs.length);
	for(var i=0; i<habs.length; i++)
	{
		<c:forEach items="${tempSelectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.habCode}" />')
				habs[i].checked = true;
		</c:forEach>	
	}
}
//-->
</script>
</html:form>
</body>
</html>

<%
	String message = (String)request.getAttribute("insert-success");
	if(message != null && message.equals("inserted"))
	{
%>
	<script>
	<!--
		var index = document.getElementById("index").value;
		var openerDoc = opener.document;
		alert("Habitations added successfully.\nPress OK to continue...");
		var url = "switch.do?prefix=/worksMonitoring&page=/workStatus.do&mode=showHabs";
		openerDoc.forms[0].action = url;
		openerDoc.forms[0].submit();
		window.close();
	//-->
	</script>
<%
	}
	
	if(message != null && message.equals("not-inserted"))
	{
%>
	<script>
	<!--
		//alert("Cannot add habitations.\n Please try again.");
		openerDoc.getElementById("WORK["+index+"].noOfHabs").value = "";
	//-->
	</script>
<% 
	}
%> 