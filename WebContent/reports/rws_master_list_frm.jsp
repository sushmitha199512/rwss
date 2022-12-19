<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="nic.watersoft.commons.*, java.util.*,javax.sql.*,javax.naming.*"%>
<table width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
	<td colspan=2 align=right><a href="../home.jsp">Back</a></td>
	</tr>
</table>
<table bgcolor="#8A9FCD" bordercolor= "#000000" width="40%" border=1 rules="none" style="border-collapse:collapse" align=center>	
	<tr bgcolor="#8A9FCD">		
		<td class=myfontclr colspan=2><B><font color="#FFFFFF">Masters Reports</font></B></td>	
		<td align=right><IMG SRC="../images/cloapp.gif" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close"></td>
	</tr>	
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_masters_frm.jsp?optype=district">District Wise Details</a></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_offices_frm.jsp?optype=offices">Office Wise Details</a></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_designation_rpt.jsp?optype=designation">Designation Details</a></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_qualification_rpt.jsp?optype=qualification">Qualification Details</a></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_representative_rpt.jsp?optype=rpresentation">Public Representative Details</a></font></td>
	</tr>
	<!-- <tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_userspassword_rpt.jsp?optype=users">Users & Password Details</a></font></td>
	</tr> -->
	<tr bgcolor="#ffffff">
		<td class=myfontclr colspan=3><font color="#000000"><a href="rws_offices_details_rpt.jsp?optype=officedetails">RWS Office Details</a></font></td>
	</tr>
</table>
<%@ include file="/commons/rws_footer.jsp"%>