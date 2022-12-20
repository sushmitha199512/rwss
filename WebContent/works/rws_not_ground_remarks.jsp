<%@	page import="java.util.ArrayList" %>
<%@	page import="nic.watersoft.masters.PanchRaj" %>
<%@ include file="/commons/rws_SpecialHeader.jsp" %>
 <%!int i=0,ix=0; %>
<html>
<head>
 <html:javascript formName="WorkForm"/>
<script language="JavaScript">
function fnAdd()
{
	if(document.forms[0].physicalStatusDetails.value=="")
	{
		alert("Please Enter Reasons");
	}
	else
	{
		opener.document.forms[0].physicalStatusDetails.value=document.forms[0].physicalStatusDetails.value;
		document.forms[0].action="switch.do?prefix=/works&page=/WorkStatus.do&mode=saveRemarks"
		document.forms[0].submit();	
	}
	
}
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">
<%java.util.Date date=new java.util.Date();
 	             long now=date.getTime();
  	             response.setHeader("Expires",(now-(1000*60*60))+""); %>
<html:form action="WorkStatus.do"  method="POST"  >
<html:hidden property="workId" value="<%=request.getParameter(\"workId\")%>"/>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr>
<td>Work Name:
&nbsp;&nbsp;<html:text property="workName" style="width:450px" styleClass="noborder-text-box" readonly="true"/>
</td></tr>
</thead>
<tbody class="gridText">
<td align="center">Enter Reasons<html:textarea property="physicalStatusDetails" rows="5"/></td>
</tbody>
</table>
<br>
<center>
	<html:button property="mode" value="Add" styleClass="btext" onclick="fnAdd()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</html:form>
</body>
</html>
