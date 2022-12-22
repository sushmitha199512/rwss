<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">

<br>
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="70%">
<tr><td colspan=6 class="head"> <b>Group Sub Head Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head</b></td>
	<td align=center><b>Sub Major Head</b></td>
	<td align=center><b>Minor Head</b></td>
	<td align=center><b>Group Sub Head Code</b></td>
	<td align=center><b>Group Sub Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="grpsubheadlist" name="grpSubHeads">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="majorHeadName" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="submajorHeadName" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="minorHeadName" />
	</td>
	<td  class="bwborder" align=center>
		<bean:write name="grpsubheadlist" property="grpSubHeadCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="grpSubHeadName" />
	</td>

</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
