<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp"%>
<html:html>
<BODY>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
<HEAD><TITLE>ComplaintsLists</TITLE></HEAD>
<P>
<p align="center">

<form action="TotalComplaintR.do" >
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				
				
</tr>
		</table>
	</caption>
	</table>

<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Complaint Report</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext>District :<%=session.getAttribute("distname")%>&nbsp;&nbsp;&nbsp;Mandal :<%=session.getAttribute("mandname")%></td>
</tr>
</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<td class=clrborder>Sl.No</td>
	<td align="center" class=clrborder>District Code</td>
	<td align="center" class=clrborder>District Name</td>
	<td align="center" class=clrborder>Source Code</td>
	<td align="center" class=clrborder>Source Name</td>
	<td align="center" class=clrborder>Location</td>
	<td align="center" class=clrborder>Complaint No</td>
	<td align="center" class=clrborder>Complaint Date</td>
	<td align="center" class=clrborder>Attended Date</td>
	<td align="center" class=clrborder>Attended By</td>
	<td align="center" class=clrborder>Complaint Status</td>
	<td align="center" class=clrborder>Remarks</td>
	
	
	<% int count=0; %>
	
	<logic:iterate id="complist" name="districtcomplaint">
			<TR align="center">
				
				</tr>
				<tr bgcolor="#ffffff">
				<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
				<td align="center" class=bwborder><bean:write name="complist" property="districtCode" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="districtName" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="sourceCode" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="assetName" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="assetLocation" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="complntno" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="complntdt" /></td>
				<td align="center" class=bwborder><bean:write name="complist" property="attendt" /></td>
				<td align="left" class=bwborder><bean:write name="complist" property="attenby" /></td>
				<td align="left" class=bwborder><bean:write name="complist" property="complntstatus" /></td>
	            <td align="left" class=bwborder><bean:write name="complist" property="remarksby" /></td>
				
				
				
				
					
			</logic:iterate>
			
				</TABLE>
<table>
<tr>
<td>				
</tr>
</table>
<center>
<%@ include file="/commons/rws_footer.jsp"%></center>
</form>

</html:html>

