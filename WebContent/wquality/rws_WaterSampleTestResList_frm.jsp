<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function openEditWindow(url)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function openDeleteWindow(url)
{

	 var width = 10;
	 var height = 10;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
</script>
<table width="100%">
<tr><td align=right>
<!-- <html:link page="/WaterSampleRes.do?mode=data">Back&nbsp;|&nbsp;</html:link> -->
<a href="javascript:history.back(-1)">Back</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WaterSampleTestRes_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WaterSampleTestRes_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="8"><B><font color="#FFFFFF">Water Sample Test Result List</B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Test</td>
	<td class="clrborder" align="center">Hab Name</td>
	<td class="clrborder" align="center">Collected Date</td>
	<td class="clrborder" align="center">Tested Date</td>
	<td class="clrborder" align="center">Source</td>
	
	<td class="clrborder" align="center">Lab</td>
	<td class="clrborder" align="center">Remarks <BR>Recommendations</td>
	<!-- <td class="clrborder" align="center">Potable Source</td>
	<td class="clrborder" align="center">Update Source</td> --> 
	<td class="clrborder" align="center"><bean:message key="app.op"/></td>
	</tr>
<%int index = 0; %>
<logic:iterate id="watersamplereslist" name="watersampleres">
<tr align="left" >
<td  class="bwborder" ><%=++index%></td>
<td  class="bwborder" nowrap><bean:write name="watersamplereslist" property="testName"/></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="habName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="forwadedOn" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="preparedOn" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="sourceName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="labName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="recommendations" /></td>
<!-- <td  class="bwborder" ><bean:write name="watersamplereslist" property="condemnSource" /><br>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="updateSource" /></td> -->
<td  class="bwborder"  nowrap>
 <a href="#1" onclick=openEditWindow('switch.do?prefix=/wquality&page=/WaterSampleRes.do?testId=<bean:write name='watersamplereslist' property='testId' />&mode=get')><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="#1" onclick=openDeleteWindow('switch.do?prefix=/wquality&page=/WaterSampleRes.do?testId=<bean:write name='watersamplereslist' property='testId' />&mode=delete')><font color="#990066">Delete</font></a>
</td>

</tr>
</logic:iterate>
<%if (index==0) {%>
<tr><td  class="bwborder" colspan=9 align=center>No Records Match with this Selection Criteria</td></tr>

<%}%>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>