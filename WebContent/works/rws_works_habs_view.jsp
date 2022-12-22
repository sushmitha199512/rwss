<%@ include file="/commons/rws_SpecialHeader.jsp" %>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<%
int cyear = Calendar.getInstance().get(Calendar.YEAR);%>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th rowspan="2"><bean:message key="app.habitationCode" /></th>
	<th rowspan="2"><bean:message key="app.habitationName" /></th>
	<th rowspan="2"><bean:message key="app.population" /></th>
	<th rowspan="2"><bean:message key="app.status" /></th>
	<th rowspan="1" >Total House Holds as on 01-04-<%=cyear %></th>
	<th rowspan="1">House Connections Provided as on 01-04-<%=cyear %></th>
	<th rowspan="1">Balance House Connections to be as on 01-04-<%=cyear %></th>
</tr>
</thead>
<tbody class="gridText">
	<c:forEach items="${requestScope.selectedHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center"><c:out value='${item.habCode}'/></td>
		<td><c:out value='${item.habName}'/></td>
		<td align="right"><c:out value='${item.population}'/></td>
		<td><c:out value='${item.status}'/></td>
		<td><c:out value='${item.houseHolds}'/></td>
		<td><c:out value='${item.houseCons}'/></td>
		<td><c:out value='${item.balHouseConn}'/></td>
	</tr>
	</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of Selected Habitations:&nbsp;<c:out value="${index+1}" />
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
