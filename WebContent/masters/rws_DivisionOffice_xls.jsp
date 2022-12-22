<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<tr><td colspan=4 class=textborder>Division Office Details</td></tr>
<tr>
	<td class=textborder ><b>SNo.</b></td>
	 
	<td class=textborder align=center><bean:message key="app.circle" /></td>
	<td class=textborder align=center><bean:message key="app.code" /></td>
	<td class=textborder align=center><bean:message key="app.division" /></td>		
		
</tr>
<% int i=1;%>
<logic:iterate id="divisionlist" name="divisions">
<tr align="left">
	<td align="left" class=bwborder><%= i++%></td>
	<td class=bwborder align=left><bean:write name="divisionlist" property="con" /></td>
	<td class=bwborder align=left><bean:write name="divisionlist" property="doc" /></td>
	<td class=bwborder><bean:write name="divisionlist" property="don" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>