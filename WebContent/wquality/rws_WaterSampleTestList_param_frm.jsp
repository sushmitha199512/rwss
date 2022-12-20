<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<head>
<script>
function openDeleteWindow(url) {
	var width = 1;
	var height = 1;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function openEditWindow(url) {
	var width = 850;
	var height = 550;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
		 
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function deleteRec(ndx)
{
//alert(ndx);
if(confirm("Are You Sure To Delete the Record"))
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterLabTestingParameter.do&mode=delete&testId="+ndx;
	document.forms[0].submit();
}
}
</script>
</head>
<html:form action="WaterLabTesting.do">
<table width="100%">
<tr><td align=right><a href="javascript:onclick=history.go(-1)">Back&nbsp;|&nbsp;</a>
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

	</tr>
<%int count = 1;%>
<nested:iterate id="watersamplelist" name="watersamples" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>
<td class="bwborder"><bean:write name="watersamplelist" property="circleOfficeName" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="habName" /></td>
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

<!-- <td  class="bwborder"  nowrap>
<a href="./switch.do?prefix=/wquality&page=/WaterSample.do?testId=<bean:write name='watersamplelist' property='testId' />&mode=get&ftklab=lab"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<a href="./switch.do?prefix=/wquality&page=/WaterSample.do?testId=<bean:write name='watersamplelist' property='testId' />&coc=<bean:write name='watersamplelist' property='coc' />&doc=<bean:write name='watersamplelist' property='doc' />&sdoc=<bean:write name='watersamplelist' property='sdoc' />&mandalCode=<bean:write name='watersamplelist' property='mandalCode' />&mode=delete"><font color="#6600CC">Delete&nbsp;&nbsp;</font></a>
</td> -->
</tr>
</nested:iterate>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>