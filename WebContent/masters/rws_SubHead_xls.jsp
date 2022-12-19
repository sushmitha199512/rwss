<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0" >

<br>
<table border="1" bordercolor=black align=center style="border-collapse:collapse" width="80%">
<tr class="bwborder">
	<td    align=left>SNo</td>
	<td    align=center>Major Head</font></FONT></td>
	<td   align=center>SubMajor Head</FONT></FONT></td>
	<td   align=center>Minor Head</FONT></FONT></td>
	<td   align=center>Group Sub Head</FONT></FONT></td>
	<td    align=center>Sub Head Code</FONT></FONT></td>
	<td   align=center>Sub Head Name</FONT></FONT></td>
 
</tr>
<% int i=1;%>
<logic:iterate id="subheadlist" name="subheads">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  class="bwborder" >
			<bean:write name="subheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="minorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="grpSubHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="subheadlist" property="subHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="subHeadName" />
		</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
