<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=6 class=textborder>Sub Division Office Details</td></tr>
<tr>
	<td align=center class=textborder>SNo</td>
	<td class=textborder align=center><bean:message key="app.circle" /></td>
	<td class=textborder align=center><bean:message key="app.division" /></td>
	<td class=textborder align=center>Code</td>
	<td class=textborder align=center><bean:message key="app.subdivision" /></td>
	<td class=textborder align=center>No Of Mandals</td>
	
</tr>
<% int i=1;%>
<logic:iterate id="subdivisionlist" name="subdivisions">
<tr align="left" >
    <td class=bwborder><%= i++%></td>
	<td class=bwborder><bean:write name="subdivisionlist" property="con" /></td>
	<td class=bwborder><bean:write name="subdivisionlist" property="don" /></td>
	<td class=bwborder><bean:write name="subdivisionlist" property="sdoc" /></td>
	<td class=bwborder><bean:write name="subdivisionlist" property="sdon" /></td>
	<td class=bwborder>
	<font color=black><bean:write name="subdivisionlist" property="noOfMandals" /></font></a>&nbsp;&nbsp;
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
