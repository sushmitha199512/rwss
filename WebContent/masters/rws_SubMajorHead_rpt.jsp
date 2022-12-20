<%@ include file="/commons/rws_header1.jsp" %>


<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>
<table border="1" bordercolor=black align=center style="border-collapse:collapse" width="60%">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>")
//-->
</script>
</caption>
<tr><td colspan=6 class="head"> <b>Sub MajorHead Details</b></td></tr>
<tr  class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head</b></td>
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
<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
