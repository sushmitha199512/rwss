<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center width="90%" style="border-collapse:collapse" >
<tr><td colspan=4 class="textborder">Sub Programme Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.programme" /></td>
		<td class="textborder"  align=center><bean:message key="app.subprgmCode" /></td>
		<td class="textborder"  align=center><bean:message key="app.subprgmName" /></td>
</tr>


<% int i=1;%>
<logic:iterate id="subprgmlist" name="subprogrammes">
<tr align="left" >
	<td  class=bwborder align="left"><%= i++%></td>

	<td  class=bwborder align=left><bean:write name="subprgmlist" property="prgmName" /></td>
	<td  class=bwborder align=center><bean:write name="subprgmlist" property="subprgmCode" /></td>
	<td  class=bwborder><bean:write name="subprgmlist" property="subprgmName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>


</body>
</html>
