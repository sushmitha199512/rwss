<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--

function fnSave(frm)
{
	var totalHabitations = frm.elements("selectedHabCode");
	var noOfSelectedHabs = 0;
	if(totalHabitations)
	{
		if(typeof totalHabitations.length != "number")
		{
			totalHabitations = [totalHabitations];
		}
		var len = totalHabitations.length;
		var noOfSelectedHabs = 0;
		for(var i=0; i<len; i++)
		{
			if(totalHabitations[i].checked)
				noOfSelectedHabs++;  
		}
	}
	if(noOfSelectedHabs > 0)
	{
		if(confirm("Do you want to save the selected habitations?"))
			return true;			
		else
			return false;
	}
	else
	{
		alert("Please select atleast one habitation to save.");
		return false;
	}
}

//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">
<html:form action="SaveAssetHab" onsubmit="return fnSave(this)">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">
<c:forEach items="${assetHabs}" var="item" varStatus="status">
<tr>
	<td align="center">
		<html:multibox property="selectedHabCode">
			<c:out value="${item.habCode}" />
		</html:multibox>
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
<br>
<input type="hidden" name="assetCode" value="<c:out value='${requestScope.assetCode}'/>">
<center>
<html:submit property="mode" styleClass="btext">
	<bean:message key="button.save"/>
</html:submit>
<html:button property="mode" styleClass="btext" onclick="javascript: fnClose()">
	<bean:message key="button.close"/>
</html:button>
</center>
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
			alert("Habitations added successfully.\nPress OK to continue...");
			var openerDoc = opener.document;
			var frm = openerDoc.forms[0];
			frm.action = "switch.do?prefix=/proposals&page=/OMProposalData.do";
			frm.submit();
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
		alert("Cannot add habitations.\n Please try again.");
	//-->
	</script>
<%
	}
%>
