<%@ include file="/commons/rws_header1.jsp" %>


<table width="50%">
<tr align="left">
<td class=btext>Contractor List</td>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" >
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
	
</tr>
<% int count=1;
%>
<logic:iterate id="contractorlist" name="divisionwise">
<tr align="left" >
<td  class=mycborder1 ><FONT class=myfontclr1><%=count++%></FONT><br></td>
<td  class=mycborder1 ><FONT class=myfontclr1><bean:write name="contractorlist" property="contractorCode" /></FONT><br></td>
<td><FONT class=myfontclr1><bean:write name="contractorlist" property="firstName" /></FONT><br>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="voterId" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="panNo" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsExecuted" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsCompletedInTime" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsCompletedLastYear" /></FONT><br></td>
</td><td><FONT class=myfontclr1><bean:write name="contractorlist" property="projectsInhand" /></FONT><br></td>

</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
