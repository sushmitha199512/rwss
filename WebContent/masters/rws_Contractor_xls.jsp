<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center width="75%" style="border-collapse:collapse" >
<tr><td colspan=10 class="head"> <b>Pay and Account Office Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Code</b></td>
	<td align=center><b>Name/<br>Company/Class<br>/Rating/Contacts</b></td>
	<td align=center><b>Address</b></td>
	<td align=center><b>Other Details</b></td>
	<td align=center><b>Registration Details</b></td>
	<td align=center><b>No.of EOAT's</b></td>
	<td align=center><b>No.of Supplementary Agreement</b></td>
	<td align=center><b>No.of times Penalised</b></td>
	<td align=center><b>Remarks</b></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="contractorlist" name="contractors">
<tr align="left" >
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorCode" /></FONT>
<FONT class=myfontclr1><bean:write name="contractorlist" property="firstName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="middleName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="lastName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorClass" /></FONT>
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorRating" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="contractorlist" property="street" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="city" /></FONT><br>
<FONT class=myfontclr1>Pin:<bean:write name="contractorlist" property="pin" /></FONT><br>
<FONT class=myfontclr1>Phone:<bean:write name="contractorlist" property="phone" /></FONT><br>
<FONT class=myfontclr1>Cell:<bean:write name="contractorlist" property="mobile" /></FONT><br>
<FONT class=myfontclr1>Fax:<bean:write name="contractorlist" property="fax" /></FONT><br>
<FONT class=myfontclr1>Email:<bean:write name="contractorlist" property="email" /></FONT><br>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1>Pan No:<bean:write name="contractorlist" property="panNo" /></FONT><br>
<FONT class=myfontclr1>Tin No::<bean:write name="contractorlist" property="tinNo" /></FONT><br>
<FONT class=myfontclr1>VoterId::<bean:write name="contractorlist" property="voterId" /></FONT><br>
<FONT class=myfontclr1>ValidForm:<bean:write name="contractorlist" property="validFrom" /></FONT><br>
<FONT class=myfontclr1>Valid To:<bean:write name="contractorlist" property="validTo" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1>RegNo:<bean:write name="contractorlist" property="contractorRegno" /></FONT><br>
<FONT class=myfontclr1>Reg At:<bean:write name="contractorlist" property="registerAt" /></FONT><br>
<FONT class=myfontclr1>Reg Dt:<bean:write name="contractorlist" property="registrationDate" /></FONT><br>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1>Proj. Executed:<bean:write name="contractorlist" property="projectsExecuted" /></FONT><br>
<FONT class=myfontclr1>Proj Compl intime:<bean:write name="contractorlist" property="projectsCompletedInTime" /></FONT><br>
<FONT class=myfontclr1>Proj Compl lastYr:<bean:write name="contractorlist" property="projectsCompletedLastYear" /></FONT><br>
<FONT class=myfontclr1>Proj Abond:<bean:write name="contractorlist" property="projectsAbandoned" /></FONT><br>
<FONT class=myfontclr1>Proj inHand:<bean:write name="contractorlist" property="projectsInhand" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contractorlist" property="noofEoat" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contractorlist" property="noofSupplentary" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contractorlist" property="noofPenalised" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contractorlist" property="remarks" /></FONT>
</td>

</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
