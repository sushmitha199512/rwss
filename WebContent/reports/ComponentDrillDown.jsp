
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html:html>
<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE></TITLE>
</HEAD>

<BODY>

<table width="100%" height="100%" border=0>
<tr>
<td  height="100%" align="center">
<%if(request.getAttribute("assetType").equals("pws"))
{ %>
		 <TABLE border="1" cellspacing="0" cellpadding="0" width="20%" 
					bordercolor="#8A9FCD" style="border-collapse:collapse" align="center">
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>ASSET TYPE PWS</td></TR>
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>COMPONENT NAME</td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=source&assetType=pws">SOURCE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pipeline&assetType=pws">PIPELINE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=reservoirs&assetType=pws">RESERVOIRS</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pumpsets&assetType=pws">PUMPSETS</a></td></TR>

					

		</TABLE>
		

<%} %>
<%if(request.getAttribute("assetType").equals("mpws"))
{ %>
		 <TABLE border="1" cellspacing="0" cellpadding="0" width="20%" 
					bordercolor="#8A9FCD" style="border-collapse:collapse" align="center">
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>ASSET TYPE MPWS</td></TR>
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>COMPONENT NAME</td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=source&assetType=mpws">SOURCE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pipeline&assetType=mpws">PIPELINE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=reservoirs&assetType=mpws">RESERVOIRS</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pumpsets&assetType=mpws">PUMPSETS</a></td></TR>

		</TABLE>
		

<%} %>
<%if(request.getAttribute("assetType").equals("cpws"))
{ %>
		 <TABLE border="1" cellspacing="0" cellpadding="0" width="20%" 
					bordercolor="#8A9FCD" style="border-collapse:collapse" align="center">
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>ASSET TYPE CPWS</td></TR>
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>COMPONENT NAME</td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pumpsets&assetType=cpws">PUMP SETS</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=source&assetType=cpws">SOURCE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=headworks&assetType=cpws">HEADWORKS</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=pipeline&assetType=cpws">PIPELINE</a></td></TR>
					<TR height="40" align="center"  class="textborder"><td><a href="./reports/ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=reservoirs&assetType=cpws">RESERVOIRS</a></td></TR>
					

		</TABLE>
		

<%} %>
<%if(request.getAttribute("assetType").equals("handpumps"))
{ %>
		 <TABLE border="1" cellspacing="0" cellpadding="0" width="20%" 
					bordercolor="#8A9FCD" style="border-collapse:collapse" align="center">
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>ASSET TYPE HANDPUMPS</td></TR>
					<TR height="40" align="center"  bgcolor="#8A9FCD" class="textborder"><td>COMPONENT NAME</td></TR>
					<TR height="40" align="center"  class="textborder"><td height="50"><a href="./ComponentDrillDown.do?schemeCode=<%=session.getAttribute("schemeCode")%>&subComp=subCompDetails&comp=source&assetType=handpumps">BOREWELL</a></td></TR>
					

		</TABLE>
		

<%} %>

</td>
</tr>
</table>
</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
