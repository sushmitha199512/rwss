<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">

<br>
<table align=center>
<tr><td>
<table border="1" bordercolor=black style="border-collapse:collapse" width="500px">
<tr><td colspan=6 class="head"> <b>Minor Head Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head </b></td>
	<td align=center><b>Sub Major Head</b></td>
	<td align=center><b>Minor Head Code</b></td>
	<td align=center><b>Minor Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="minorheadlist" name="minorHeads">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

	<td  class="bwborder" >
			<bean:write name="minorheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="minorheadlist" property="minorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="minorHeadName" />
		</td>
</tr>
</logic:iterate>
</table>
</td></tr></table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
