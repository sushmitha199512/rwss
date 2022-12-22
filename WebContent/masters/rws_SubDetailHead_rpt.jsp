<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0"  >
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="100%">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=9 class="head"> <b>Sub DetailHead Details</b></td></tr>
<tr class="bwborder">
	<td  nowrap><b>SNo</b></td>
	<td align=center nowrap><b>Major Head </b></td>
	<td align=center nowrap><b>Sub Major Head </b></td>
	<td align=center nowrap><b>Minor Head </b></td>
	<td align=center nowrap><b>Group Sub Head</b></td>
	<td align=center nowrap><b>Sub Head </b></td>
	<td align=center nowrap><b>Detail Head </b></td>
	<td align=center nowrap><b>Sub Detail Head Code</b></td>
	<td align=center nowrap><b>Sub Detail Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="subdetailheadlist" name="subdetailheads">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="majorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="submajorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="minorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="grpSubHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="detailHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subDetailHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subDetailHeadName" />
</td>
</tr>
</logic:iterate>
</table>
</td></tr></table>
<br><br>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
