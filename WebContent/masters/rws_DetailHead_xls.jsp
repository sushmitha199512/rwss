<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0" >

<br>
<table border="1" bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=8 class="head"><b>Detail Head Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head </b></td>
	<td align=center><b>Sub Major Head </b></td>
	<td align=center><b>Minor Head </b></td>
	<td align=center><b>Group Sub Head </b></td>
	<td align=center><b>Sub Head </b></td>
	<td align=center><b>Detail Head Code</b></td>
	<td align=center><b>Detail Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="detailheadlist" name="detailHeads">
<tr align="left" >
<td  class=mycborder1 align="center">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="minorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="grpSubHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="subHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="detailHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="detailHeadName" />
		</td>
 
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
