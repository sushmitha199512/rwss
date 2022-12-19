<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

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
</script>
<table width="100%">
<tr><td align=right><html:link page="/Contractor.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_Contractor_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_Contractor_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table width="100%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Contractor List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	<td align=center><FONT size="1" color="maroon" face=verdana ><b>Code/Name/<br>Company/Class<br>/Rating</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Address</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Other Details</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Registration Details</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>No.of EOAT's</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>No.of Supplementary <Agreement:</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>No.of times Penalised</b></font></td>
    <td align=center><FONT size="1" color="maroon" face=verdana><b>Bank Details</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Remarks</b></font></td>
	<td align=center><FONT size="1" color="maroon" face=verdana><b>Operation</b></font></td>
</tr>

<logic:iterate id="contractorlist" name="contractors">
<tr align="left" >
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorCode" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="firstName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="middleName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="lastName" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorClass" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="contractorRating" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="contractorlist" property="street" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="contractorlist" property="city" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Pin:</font><bean:write name="contractorlist" property="pin" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Phone:</font><bean:write name="contractorlist" property="phone" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Cell:</font><bean:write name="contractorlist" property="mobile" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Fax:</font><bean:write name="contractorlist" property="fax" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Email:</font><bean:write name="contractorlist" property="email" /></FONT><br>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><font color=navy>Pan No:</font><bean:write name="contractorlist" property="panNo" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Voter Id:</font><bean:write name="contractorlist" property="voterId" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Tin No:</font><bean:write name="contractorlist" property="tinNo" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Vat No:</font><bean:write name="contractorlist" property="vatNo" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Adhaar No:</font><bean:write name="contractorlist" property="adharNo" /></FONT>

</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><font color=navy>RegNo:</font><bean:write name="contractorlist" property="contractorRegno" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Reg At:</font><bean:write name="contractorlist" property="registerAt" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Reg Dt:</font><bean:write name="contractorlist" property="registrationDate" /></FONT><br>
<FONT class=myfontclr1><font color=navy>ValidForm:</font><bean:write name="contractorlist" property="validFrom" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Valid To:</font><bean:write name="contractorlist" property="validTo" /></FONT>

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
<FONT class=myfontclr1><font color=navy>Bank Name:</font><bean:write name="contractorlist" property="bankName" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Branch Name:</font><bean:write name="contractorlist" property="branchName" /></FONT><br>
<FONT class=myfontclr1><font color=navy>IFSC/MICR Code:</font><bean:write name="contractorlist" property="ifscCode" /></FONT><br>
<FONT class=myfontclr1><font color=navy>Account No:</font><bean:write name="contractorlist" property="accountNo" /></FONT><br>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="contractorlist" property="remarks" /></FONT>
</td>

<td nowrap>
<a href="#1" onclick=openEditWindow('./Contractor.do?contractorCode=<bean:write name='contractorlist' property='contractorCode' />&mode=get')>
<font color="#6600CC"><b>Edit</b></font></a>&nbsp;|&nbsp;
<a href="#1" onclick=openDeleteWindow('./Contractor.do?contractorCode=<bean:write name='contractorlist' property='contractorCode' />&mode=delete')><font color="#990066" ><b>Delete</b></font></a>

</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
