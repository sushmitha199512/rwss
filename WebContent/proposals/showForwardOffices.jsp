<%@ include file="/commons/rws_header1.jsp"%>

<script language="JavaScript">
<!--
function fnSelect(field)
{	
	var listLen = field.length;
	var selectedOffices = new Array(); 
	var j=0;
	for(var i=0; i<listLen; i++)
	{
		if(field[i].checked)
		{
			selectedOffices[j] = i;
			j++;
		}
	}
	var forwardOffice = opener.document.getElementById("forwardOffice");
	var forwardTo = opener.document.getElementById("forwardTo");
	forwardOffice.value = "";
	forwardTo.value = "";
	var tempForwardOffice = "";
	var tempForwardTo = "";

	for(var k=0; k< selectedOffices.length; k++)
	{
		var officeCode = field[selectedOffices[k]].value;
		var officeName = document.getElementById(officeCode).innerHTML;
		tempForwardTo += officeCode + ",";
		tempForwardOffice += officeName + ",";
	}
	forwardTo.value = tempForwardTo.substring(0,tempForwardTo.length-1);
	forwardOffice.value = tempForwardOffice.substring(0,tempForwardOffice.length-1);
	window.close();
}
//-->
</script>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<form name="f1">
<logic:present name="forwardOffices">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="black"
	   style="border-collapse:collapse">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th align="center"><bean:message key="app.select" /></th>
	<th align="center"><bean:message key="app.officeCode" /></th>
	<th align="left"><bean:message key="app.officeName" /></th>
</tr>
</thead>
<tbody class="gridLabel">
<c:forEach items="${requestScope.forwardOffices}" var="item" varStatus="status">
<tr class="<c:out value='row${status.index%2}' />">
	<td style="width:50px" align="center">
		<input type="checkbox" name="list" value="<c:out value='${item.value}'/>">
	</td>
	<td style="width:80px" align="center">
		<c:out value='${item.value}'/>
	</td>
	<td style="width:100px" align="left" id="<c:out value='${item.value}'/>">	
		<c:out value='${item.label}'/>
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnSelect(this.form.list)">
		<bean:message key="button.select" />
	</html:button>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</logic:present>
</form>
</body>
</html>