<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Iterator"%>
<head>
<script>
function deleteRec()
{
//alert("hai"+ftkid);

if(confirm("Are You Sure To Delete the Record"))
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=Deleteftk" ;
	document.forms[0].submit();
	
}
}

function openEditWindow(url)
{
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}
</script>
</head>
<html:form action="WaterSample.do">
<table width="100%">
<tr><td align=right><a href="javascript:onclick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_FtkTest_rpt.jsp" target="_new" >Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_FtkTest_xls.jsp" target="_new">Excel</html:link>
</td></tr>
</table>

<%session.getAttribute("watersamples");	%>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD"><td class="bwborder" colspan="9"><B><font color="#FFFFFF">FTK Testing</font> </B></td>
<td align="center">
<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
</tr>
<tr >
	<td class="clrborder" align="center">S.No.</td>
	<td class="clrborder" align="center">Office</td>	  
	<td class="clrborder" align="center">Habitation</td>
	<td class="clrborder" align="center">Source Type</td>
	<td class="clrborder" align="center">Source Code</td>
	<td class="clrborder" align="center">Ftk Test Id </td>
	<td class="clrborder" align="center">Test Date</td>
	<td class="clrborder" align="center">FIELD_TEST_CHEMICAL</td>
    <td class="clrborder" align="center">H2S_VIAL </td>    
  	<td class="clrborder" align="center">Forward Date</td>
	<%-- <td class="clrborder" align="center"><bean:message key="app.op" /></td> --%>
	</tr>
	
 
	 
<%int count = 1;%> 
<nested:iterate id="watersamplelist" name="watersamples" indexId="ndx">
<tr align="left" >
<td class="bwborder"><%=count++%></td>
<td class="bwborder"><bean:write name="watersamplelist" property="circleOfficeName"/></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="habName" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sourceType" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sourceCode" /></td>

<td  class="bwborder" ><bean:write name="watersamplelist" property="ftktestid" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="ftkTestDate" /></td>
<td  class="bwborder" align="center" ><bean:write name="watersamplelist" property="ftkCtype" /></td> 
<td  class="bwborder" align="center"><bean:write name="watersamplelist" property="ftkHtype" /></td>

<td  class="bwborder" ><bean:write name="watersamplelist" property="forwardDate" /></td>

<!-- <td  class="bwborder"  nowrap align="center"> -->
 
 <% session.getAttribute("contaminvalue");
   String contamin= (String)session.getAttribute("contaminvalue");%>


<%-- <a href="#" onclick="openEditWindow('switch.do?prefix=/wquality&page=/WaterSample.do&ftktestid=<bean:write name='watersamplelist' property='ftktestid'/>&sourceCode=<bean:write name='watersamplelist' property='sourceCode'/>&mode=get&ftklab=ftk')">&nbsp;&nbsp;Edit&nbsp;&nbsp;</a> --%>
<!-- <a href="#" onclick="openEditWindow('switch.do?prefix=/wquality&page=/WaterSample.do&ftktestid=<bean:write name='watersamplelist' property='ftktestid' />&sourceCode=<bean:write name='watersamplelist' property='sourceCode' />&coc=<bean:write name='watersamplelist' property='coc'/>&mandalCode=<bean:write name='watersamplelist' property='mandalCode'/>&mode=Deleteftk&ftklab=ftk')" onClick="return confirm('Are You Sure To Delete the Record');")>Delete</font></a>-->
<!-- <a href="./switch.do?prefix=/wquality&page=/WaterSample.do&ftktestid=<bean:write name='watersamplelist' property='ftktestid'/>&sourceCode=<bean:write name='watersamplelist' property='sourceCode' />&coc=<bean:write name='watersamplelist' property='coc'/>&mandalCode=<bean:write name='watersamplelist' property='mandalCode'/>&mode=Deleteftk&ftklab=ftk" onClick="return confirm('Are You Sure To Delete the Record');"><font color="#990066">Delete</font></a> -->

<!-- </td> -->
</tr>
</nested:iterate>
  
<%if(count==0)
	  {%>
	  <tr>
	  <td colspan=8 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
       
     <%}%>
</table>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>