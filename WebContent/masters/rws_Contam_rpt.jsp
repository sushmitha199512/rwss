<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
<table align=right>
	<tr>
	<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
	</tr>
</table>
</caption>
<tr><td colspan=3 class="textborder">Contamination Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" align=center class="textborder"><bean:message key="app.contamCode" /></td>
	<td class="textborder" align=center><bean:message key="app.contamName" /></td>	
</tr>
<% int i=1;%>
<logic:iterate id="contamlist" name="contams">
<tr align="left" >

	<td align="center" class="bwborder"><%= i++%></td>
	<td  class=bwborder align=center><bean:write name="contamlist" property="contamCode" /></td>
	<td  class=bwborder><bean:write name="contamlist" property="contamName" /></td>
</tr>
</logic:iterate>
</table>


</body>
</html>
