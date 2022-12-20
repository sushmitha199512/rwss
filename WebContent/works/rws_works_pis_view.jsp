<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th>Hab Code</th>
	<th>Hab Name</th>
	<th>PI Code</th>
	<th>PI Name</th>
	<th>Classification</th>
	<th>No of Taps</th>
	
</tr>
</thead>
<tbody class="gridText">
	<c:forEach items="${requestScope.selectedHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="right"><c:out value='${item.habCode}'/></td>
		<td align="left"><c:out value='${item.habName}'/></td>
		<td align="center"><c:out value='${item.piCode}'/></td>
		<td><c:out value='${item.piLocation}'/></td>
		<td><c:out value='${item.piCategory}'/></td>
		<td><c:out value='${item.pis_no_tap_conn}'/></td>
		<%-- <td><c:out value='${item.facilities}'/></td> --%>
	</tr>
	</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="7" align="left">
		Total No. of Selected Public Institutes:&nbsp;<c:out value="${index+1}" />
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
