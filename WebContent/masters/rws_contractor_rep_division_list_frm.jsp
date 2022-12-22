<%@ include file="/commons/rws_header1.jsp" %>


<%
nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();


if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
<%@ include file="/commons/rws_header2.jsp" %>

<% } %>
<script language="javascript">
function fnEdit(contractorCode)
{
	 var url ="switch.do?prefix=/masters&page=/Contractor.do?mode=getContractorreport&contractorCode="+contractorCode;
	 var width = 980;
	 var height = 350;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	url="switch.do?prefix=/masters&page=/Contractor.do?mode=getContractorreport&contractorCode="+contractorCode;
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
    }
</script>
<html:form action="Contractor.do">
<table width="50%">




			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
		<tr><td align=right><html:link page="/Contractor.do?mode=getContractorlist">Back</html:link>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<html:link page="/rws_Contractor_division_prep.jsp" target="_new">Print</html:link>&nbsp;|&nbsp;
<html:link page="/rws_Contractor_division_rep_xls.jsp" target="_new">Excel</html:link>
</tr>
<%  } else {%>

<tr><td align=right><html:link page="/Contractor.do?mode=getContractorlist">Back</html:link>&nbsp;|&nbsp;
<a href="#" onclick="window.close()">Close</a>&nbsp;|&nbsp;
<html:link page="/rws_Contractor_division_prep.jsp" target="_new">Print</html:link>&nbsp;|&nbsp;
<html:link page="/rws_Contractor_division_rep_xls.jsp" target="_new">Excel</html:link>
</tr>
	
<%} %>


</table>
<table width="50%">
<tr align="left">
<%String circlename=(String)session.getAttribute("cirname");
String c1="";
String c=request.getParameter("category");
if(c.equals("1"))
{
	c1="Projects";
}
else if(c.equals("2"))
{
	c1="Normal";
}
else if(c.equals("3"))
{
	c1="District Level";
}

%>

<%if(c != null && !c.equals(""))
{
	%>
<p class=btext>
Category:<%=c1%>
<%}%>
</p>

</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" >
<tr colspan=10>
<td class=btext colspan=10 >Contractor List</td>
</tr>
<tr >
	<td align=center><FONT size="1" color="maroon" face=verdana ><b>S.No</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana ><b>Contractor Code</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Name</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Voter Id</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Pan No</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Projects Executed</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Projects Completed in Time</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Projects Completed in Last Five Years</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b> Projects in Hand</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Operation</b></font></td>
	</tr>
<% int count=1;
%>
<logic:notEmpty name="divisionwise">
<logic:iterate id="contractorlist" name="divisionwise">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=count++%></FONT><br></td>
<td  class=mycborder1 ><FONT class=myfontclr1><bean:write name="contractorlist" property="contractorCode" /></FONT><br></td>
<td><FONT class=myfontclr1><bean:write name="contractorlist" property="firstName" /></FONT><br>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="voterId" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="panNo" /></FONT><br></td>
</td><td align="right"><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsExecuted" /></FONT><br></td>
</td><td align="right"><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsCompletedInTime" /></FONT><br></td>
</td><td align="right"><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsCompletedLastYear" /></FONT><br></td>
</td><td align="right"><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsInhand" /></FONT><br></td>
<td nowrap>
<a href="#1" onclick="fnEdit('<bean:write name='contractorlist' property='contractorCode' />')"><font color="#990066">View</font></a>
</td>
</tr>
</logic:iterate>
</logic:notEmpty>
<logic:empty name="divisionwise">
<script>
alert("No Contractors");
document.location.href="./switch.do?prefix=/masters&page=/Contractor.do&mode=getContractorlist&special=reset";
</script>
</logic:empty>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
