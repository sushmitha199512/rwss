<%@ include file="/commons/rws_header1.jsp" %>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="500px">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=6 class="head"> <b>Minor Head Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head </b></td>
	<td align=center><b>Sub Major Head </b></td>
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

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
