<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>
<table width=500>
<tr><td align=right><html:link page="/branch.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a>
</tr>
</table>

<table    width="600"   >
<tr><td class=myfontclr><B><font color="blue">&nbsp;&nbsp;&nbsp;&nbsp;All Branches</font></B></td>
</tr>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
 <td class=mycborder align=left>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Circle Name</FONT>
	</td>
	<td class=mycborder align=left>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Division Name</FONT>
	</td>
	<td class=mycborder align=left>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Bank Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Branch Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Branch Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">MICR Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Operation</FONT>
	</td>
	</tr>
<logic:present name="branches">
<%int i=1;%>
<logic:iterate id="branchlist" name="branches">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
 <td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="branchlist" property="circleName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="branchlist" property="divisionName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="branchlist" property="bankName" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="branchlist" property="branchCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="branchlist" property="branchName" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="branchlist" property="micrCode" /></FONT>
</td>

<html:hidden name="branchlist" property="bankCode" /></FONT>
<td  class=mycborder1 align=center>
<a href="./branch.do?branchCode=<bean:write name='branchlist' property='branchCode'/>&bankCode=<bean:write name='branchlist' property='bankCode'/>&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="./branch.do?branchCode=<bean:write name='branchlist' property='branchCode'/>&branchName=<bean:write name='branchlist' property='branchName'/>&bankCode=<bean:write name='branchlist' property='bankCode' />&bankName=<bean:write name='branchlist' property='bankName' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
