<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<head>
<script>
function deleteRec(ndx)
{

if(confirm("Are You Sure To Delete the Record"))
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=delete&testId="+ndx;
	document.forms[0].submit();
}
}
</script>
</head>
<html:form action="WaterSample.do">
<table width="100%">
<tr><td align=right><html:link page="/WaterSample.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_WaterSampleTest_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_WaterSampleTest_xls.jsp" target="_new">Excel</html:link>
</td></tr>
</table>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="11"><B><font color="#FFFFFF">Water Quality Sample Collection Form</B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Office</td>
	<td class="clrborder" align="center">Habitation</td>
	<td class="clrborder" align="center">Source Type</td>
	<td class="clrborder" align="center">Source Code</td>
	<td class="clrborder" align="center">Type of Test</td>
	<td class="clrborder" align="center">Nature of Test</td>
	<td class="clrborder" align="center">Lab Assigned</td>
	<td class="clrborder" align="center">Sample Collected&nbsp;By</td>
	<td class="clrborder" align="center">Collection Date & Time</td>
	<td class="clrborder" align="center">Assigned On</td>
	<td class="clrborder" align="center"><bean:message key="app.op" /></td>
	</tr>
<%int count = 1;%>
<nested:iterate id="watersamplelist" name="watersamples" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>
<td class="bwborder"><bean:write name="watersamplelist" property="coc" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="habCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sourceType" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sourceCode" /></td>
<!-- <td  class="bwborder" ><bean:write name="watersamplelist" property="testCode" /></td>-->
<td  class="bwborder" ><bean:write name="watersamplelist" property="testName" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="natureOfTest" /></td>
<!-- <td  class="bwborder" ><bean:write name="watersamplelist" property="labCode" /></td>-->
<td  class="bwborder" ><bean:write name="watersamplelist" property="labName" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sampCollectCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sampCollectDate" />&nbsp;<bean:write name="watersamplelist" property="sampCollectTime" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="assignedOn" /></td>
<html:hidden name="watersamplelist" property="preparedBy" />
<html:hidden name="watersamplelist" property="coc" />
<td  class="bwborder"  nowrap>
<a href="./WaterSample.do?testId=<bean:write name='watersamplelist' property='testId' />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="#1" onclick="<%="javascript: deleteRec("%><bean:write name='watersamplelist' property='testId' /><%=")"%>"><font color="#990066">Delete</font></a>

</td>
</tr>
</nested:iterate>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>