<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>

<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
function callClose()
{
window.close();
}

</script>
<html:html>
<HEAD>
<TITLE></TITLE>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</HEAD>
<BODY>
<table  width="100%" >
<tr>
<td align="right">
<A href="#1" onclick="callClose()">Close</A>&nbsp;&nbsp;&nbsp;
 
</td></tr></table>
<table >
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
District Name:<%=session.getAttribute("DistrictName")%>&nbsp;
Mandal Name:<%=session.getAttribute("MandalName")%>
</td>
</tr>
<tr align=left bgcolor="#8A9FCD" class="textborder">
<td>
Database Related Isuues:
Problem in connecting to Database(OR)Values Changed in DataBase(OR)Try again
</td>
</tr>
<tr>
<td> 
                <TABLE border="1" cellspacing="0" cellpadding="0" width="100%"
					bordercolor="#000000" style="border-collapse:collapse">
					
					<logic:iterate id="Exception" name="ExceptionPage"
						scope="request">
						
							<TR>
								<logic:iterate id="EXCEP" name="Exception" 
									offset="offset">
									<TD class="mystyle1"><bean:write name="EXCEP" ignore="true"/></TD>
								</logic:iterate>
							</TR>
						
					</logic:iterate>
				</TABLE>
				</td>
</tr>
</table>




 


</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
