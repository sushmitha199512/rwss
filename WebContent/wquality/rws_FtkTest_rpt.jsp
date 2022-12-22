<%@ include file="/commons/rws_header1.jsp" %>

</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>

Rural Water Supply & Sanitation<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=8 class="textborder">FTK Testing</td></tr>
<tr>
<tr>
	<td class="textborder" align="center">S.No.</td>
	<td class="textborder" align="center">Office</td>	  
	<td class="textborder" align="center">Habitation</td>
	<td class="textborder" align="center">Source Type</td>
	<td class="textborder" align="center">Source Code</td>
	<td class="textborder" align="center">Ftk Test Id </td>
	<td class="textborder" align="center">Test Date</td>
	<td class="textborder" align="center">Forward Date</td>
	
	</tr>
<%int count = 1;%>
<nested:iterate id="watersamplelist" name="watersamples" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>
<td class="bwborder"><bean:write name="watersamplelist" property="coc" /></td>
<td  class="bwborder" >&nbsp;<bean:write name="watersamplelist" property="habCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sourceType" /></td>
<td  class="bwborder" >&nbsp;<bean:write name="watersamplelist" property="sourceCode" /></td>

<td  class="bwborder" ><bean:write name="watersamplelist" property="ftktestid" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="ftkTestDate" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="forwardDate" /></td>


</tr>
</nested:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>