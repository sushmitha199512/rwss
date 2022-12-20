
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ page import="nic.watersoft.reports.TotalCountBean"%>
<%@ include file="/commons/rws_header1.jsp" %>
 <%@ include file="/commons/rws_header2.jsp"%>

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
<%
//System.out.println("in subCompDetails.jsp"); %>
<table width="100%" height="100%" border=0>
<tr>
<td  height="100%" align="center">

<%if(request.getAttribute("assetType").equals("pws"))
{
%>
	
	<TABLE border="1"  
					bordercolor="#8A9FCD"  align="center">
					<TR  align="center"  bgcolor="#8A9FCD"  class="textborder"><td colspan=4>ASSET TYPE PWS</td></TR>
					<tr bgcolor="#8A9FCD"><td>SOURCE</td><TD>PIPE LINE</TD><TD>RESERVOIRS</TD><TD>PUMPSETS</TD></tr>
					<tr valign="top">
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="0" length="4">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="4" length="3">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="7" length="3">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request"  offset="10" length="2">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td></tr>
					


		</TABLE>

<%}%>


<!-- MPWS STARTS HERE -->
<%if(request.getAttribute("assetType").equals("mpws"))
{
%>
	<TABLE border="1"  
					bordercolor="#8A9FCD"  align="center">
					<TR  align="center"  bgcolor="#8A9FCD"  class="textborder"><td colspan=4>ASSET TYPE MPWS</td></TR>
					<tr bgcolor="#8A9FCD"><td>SOURCE</td><TD>PIPE LINE</TD><TD>RESERVOIRS</TD><TD>PUMPSETS</TD></tr>
					<tr valign="top">
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="0" length="4">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="4" length="3">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request" offset="7" length="3">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1" bordercolor="#8A9FCD">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request"  offset="10" length="2">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td></tr>
					


		</TABLE>
<%}%>


<!-- CPWS STARTS HERE -->
<%if(request.getAttribute("assetType").equals("cpws"))
{
%>
		<TABLE border="1"  width="680" 
					bordercolor="#8A9FCD"  >
					<TR   bgcolor="#8A9FCD" class="textborder" align="center"><td colspan="5">ASSET TYPE CPWS</td></TR>
					<tr bgcolor="#8A9FCD"><td>PUMP SETS</td><TD>SOURCE</TD><TD>HEADWORKS</TD><TD>PIPELINE</TD><TD>RESERVOIRS</TD></tr>
					<tr valign="top">
					<td> 
					
					<table border="1">
				
					<logic:iterate id="pwsReport" name="subCompDetailsReport" 
						scope="request" offset="0" length="1">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
							
					
					</logic:iterate>
					</table>
					</td>
					<td> 
					
					<table border="1">
					
					<logic:iterate id="pwsReport" name="subCompDetailsReport" 
						scope="request" offset="1" length="4">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
							
					
					</logic:iterate>
					</table>
					</td>
					<td> 
					<table border="1">
				
					<logic:iterate id="pwsReport" name="subCompDetailsReport" 
						scope="request" offset="5" length="9">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
							
					
					</logic:iterate>
					</table>
					</td>
					<td>
					<table border="1">
					
					<logic:iterate id="pwsReport" name="subCompDetailsReport" 
						scope="request" offset="14" length="4">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
							
					
					</logic:iterate>
					</table>
					</td>
					<td>
					<table border="1">
					
					<logic:iterate id="pwsReport" name="subCompDetailsReport" 
						scope="request" offset="18" length="6">
						
							<TR>
								
									<TD class="mystyle1"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="40"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
					
					</logic:iterate>
					</table>
					</td></tr>
					
					
					
		</TABLE>


<%}%>


<%if(request.getAttribute("assetType").equals("handpumps"))
{
%>

		<TABLE border="1" cellspacing="0" cellpadding="0" 
					bordercolor="#8A9FCD" style="border-collapse:collapse" align="center">
					<TR height="40" align="center"  bgcolor="#8A9FCD"  class="textborder"><td colspan="2">ASSET TYPE HANDPUMPS</td></TR>
					<tr valign="top">
					<td> 
					
					<table border="1">
					<logic:iterate id="pwsReport" name="subCompDetailsReport"
						scope="request">
						
							<TR>
								
									<TD class="mystyle1" width="100"><a href="ComponentDrillDown.do?assetType=<%=request.getAttribute("assetType")%>&schemeCode=<%=session.getAttribute("schemeCode")%>&subComponent=<%=((TotalCountBean)pwsReport).getName()%>&subComp=subComponentReport"><bean:write name="pwsReport" property="name" ignore="true"/></a></TD>
									<TD class="mystyle1" width="60"><bean:write name="pwsReport" property="count" ignore="true"/></TD>
							</TR>
						
					</logic:iterate>
					</table>
					</td></tr>
					
		</TABLE>

<%} %>
<%
//System.out.println("exiting subCompdetails.jsp"); %>
</td>
</tr>
</table>
</BODY>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
