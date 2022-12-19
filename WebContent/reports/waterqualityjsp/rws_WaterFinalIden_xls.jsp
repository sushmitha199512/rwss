<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<body topmargin="0">
<br><br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="500px">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=15 class="head"> <b>Water Source Identification and Finalisation List</B></td>
</tr>
<tr class="bwborder">
     <td align=left rowspan="2"><b>SNo</b></td>
	<td  align="center" rowspan="2"><b>Habitation</b></td>
	<td  align="center" rowspan="2"><B>Source</B></td>
	<td  align="center" rowspan="2"><B>Programme & SubProgramme</B></td>
	<td  align="center" rowspan="2"><B>Work Id</B></td>
	<td  align="center" colspan="3"><B>Recommondations</B></td>
	<td  align="center" colspan="3"><B>References</B></td>
	<td  align="center" rowspan="2"><B>Lab Chemist</B></td>
	<td  align="center" rowspan="2"><B>Finalised</B></td>
	<td  align="center" rowspan="2"><B>Identifcation&nbsp;Date & Finalise&nbsp;Date</B></td>
	<td  align="center" rowspan="2"><B>Remarks</B></td>

</tr>
<tr class="bwborder">
	<td   align="center"><B>Casing</B></td>
	<td   align="center"><B>Depth</B></td>
	<td   align="center"><B>Yield</B></td>
	<td   align="center"><B>Source</B></td>
	<td   align="center"><B>Depth</B></td>
	<td   align="center"><B>Yield</B></td>
</tr>
<% int i=1;%>
<logic:iterate id="watersamplereslist" name="waterSrcFinIden">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class="bwborder" ><bean:write name="watersamplereslist" property="habCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="sourceCode" /></td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="prgmCode" /><br>
<bean:write name="watersamplereslist" property="subprgmCode" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="workCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="casing" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="depth" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="yield" /><br>
<td  class="bwborder" nowrap>
<bean:write name="watersamplereslist" property="source1" /><br>
<bean:write name="watersamplereslist" property="source2" /><br>
<bean:write name="watersamplereslist" property="source3" />
</td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="depth1" /><br>
<bean:write name="watersamplereslist" property="depth2" /><br>
<bean:write name="watersamplereslist" property="depth3" />
</td>
<td  class="bwborder" >
<bean:write name="watersamplereslist" property="yield1" /><br>
<bean:write name="watersamplereslist" property="yield2" /><br>
<bean:write name="watersamplereslist" property="yield3" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="empcode" /><br>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="finalised" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="siteIdenData" /><br>
<bean:write name="watersamplereslist" property="finalDate" />
</td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="remarks" /><br>

</td>
</tr>
</logic:iterate>
</table></td></tr></table>
<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
