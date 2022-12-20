<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header4.jsp"%>
<html:html>
<BODY>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
<HEAD><TITLE>PanchayatList</TITLE></HEAD>
<P>
<p align="center">

<form action="DistrictHabitationSearch.do" >
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<tr align="right">
				<td class="bwborder"><a href="switch.do?prefix=/reports&page=/DistrictHabitationSearch.do">Back |</a></td>
				
				
				
</tr>
		</table>
	</caption>
	</table>

<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Habitation Search List</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">

</tr>

</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<td class=clrborder>Sl.No</td>
	<td align="center" class=clrborder>District Code</td>
	<td align="center" class=clrborder>District Name</td>
	<td align="center" class=clrborder>Mandal Code</td>
	<td align="center" class=clrborder>Mandal Name</td>
	<td align="center" class=clrborder>Panchayat Code</td>
	<td align="center" class=clrborder>Panchayat Name</td>
	<td align="center" class=clrborder>Village Code</td>
	<td align="center" class=clrborder>Village Name</td>
	<td align="center" class=clrborder>Habitation Code</td>
	<td align="center" class=clrborder>Habitation Name</td>
	
	
	
	
	<% int count=0;
	java.util.Collection a = (java.util.ArrayList)session.getAttribute("habitationdisplay"); 
	 
	if(a.size()>0)
	{
	%>
	<logic:iterate id="employee" name="habitationdisplay">
			<TR align="center">
				
				</tr>
				<tr bgcolor="#ffffff">
				<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onMouseOver="this.style.background='#E3E4FA'" onMouseOut="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
				
				<td align="center" class=bwborder><bean:write name="employee" property="districtCode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="districtName" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="mandalCode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="mandalName" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="panchayatCode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="panchayatName" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="villageCode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="villageName" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="panchCode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="panchName" /></td>
				
				
					
			</logic:iterate>
			<%  }
			else
			{
			%>
			<tr>
			<td colspan=10 align=center>No Records </td>
			</tr>
			<%} %>
			
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

