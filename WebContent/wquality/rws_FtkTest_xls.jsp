<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
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

<td  class="bwborder" >&nbsp;<bean:write name="watersamplelist" property="ftktestid" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="ftkTestDate" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="forwardDate" /></td>


</tr>
</nested:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>