
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp" %>
<html>
<HEAD>
<script>
function update()
{
// alert(document.forms[0].tpv0.value);
}
</script>
</HEAD>

<BODY>
<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff" width="100%">
	<tr bgcolor="#8A9FCD" >
		<td colspan=7 class="textborder">
			<font color="#ffffff">Water Quality Parameters Test(s) Last Updated</font>
		</td>
	</tr>
	<tr>
		<td align=center class="clrborder">SNo</td>
		<td align=center class="clrborder">Updated Date</td>
		<td align=center class="clrborder">Test Id</td>
		<td align=center class="clrborder">Test Name</td>
		<!-- <td align=center class="clrborder">Potable</td> --> 
		<td align=center class="clrborder">Recommendations</td>
	</tr>
	<%int count=-1; 
	%>
	<logic:iterate id="waterPtestUpdateList" name="updateParameters">
    <%count++;
    int index = count+1;
    java.util.ArrayList testIds = new java.util.ArrayList();
    testIds = (java.util.ArrayList)session.getAttribute("testids");
     %>
    
    <tr align="left" bgcolor="#ffffff">
    <td  class="bwborder"><%=index%></td>
		<td  class="bwborder">
			<bean:write name="waterPtestUpdateList" property="preparedOn" />
		</td>
		<td  class="bwborder" >
			<a href="switch.do?prefix=/wquality&page=/WaterSampleRes.do?mode=updateTests&testid=<%=testIds.get(count)%>" target="_blank" title="Click to get Water Quality Parameters List "><bean:write name="waterPtestUpdateList" property="testId"/></a>
		 </td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="testName" />
		</td>
		<td  class="bwborder" align="center" >
			<bean:write name="waterPtestUpdateList" property="condemnSource" />
		</td>
		<td  class="bwborder" >
			<bean:write name="waterPtestUpdateList" property="recommendations" />
		</td>
				
	</tr>
	</logic:iterate>
	<%if(count==-1){ %>
	<tr><td colspan="10" align="center">No Records</td></tr>
	<%} %>

				<td align="center" colspan="6">
					<html:button property="close" value="Close" onclick="javascript:self.close()" />
				</td>
			</tr></table>
</BODY>
</html>
