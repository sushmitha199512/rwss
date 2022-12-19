<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0"><br/><br/>
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
		 document.write("Report on : "+mydate()+"<br><br>"); 
	</script>
	</tr>
</table>
</caption>
<tr><td colspan=3 class="textborder">Head Of Office Details</td></tr>
<tr>
	<td class="textborder"align=center><bean:message key="app.sno"/></td>
	<td class="textborder" align=center class="textborder"><bean:message key="app.office" /></td>
	<td class="textborder" align=center><bean:message key="app.designation" /></td>	
</tr>
<% int i=1;%>
<logic:iterate id="hofficelist" name="hoffices">
<tr align="left" >

	<td align="center" class="bwborder"><%= i++%></td>
	<td  class=bwborder align=center><bean:write name="hofficelist" property="office" /></td>
	<td  class=bwborder><bean:write name="hofficelist" property="designation" /></td>
</tr>
</logic:iterate>
</table>


</body>
</html>
