<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
 

<body topmargin="0">

<br>
<table width="400px" align=center>
<tr><td>
<table border="1" bordercolor=black style="border-collapse:collapse" width="400px">
<tr><td colspan=4  class="head"> <b>Sub MajorHead Details</b></td></tr>
<tr  class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head </b></td>
	<td align=center><b>Sub Major Head Code</b></td>
	<td align=center><b>Sub Major Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="submajorheadlist" name="submajorHeads">
<tr align="left" >

<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

        <td  class="bwborder" >
			<bean:write name="submajorheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="submajorheadlist" property="submajorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="submajorheadlist" property="submajorHeadName" />
		</td>
		
</tr>
</logic:iterate>
</table>
</td></tr></table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
