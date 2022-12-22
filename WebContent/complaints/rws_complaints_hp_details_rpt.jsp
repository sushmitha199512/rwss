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

<form action="TotalComplaints.do" >
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td class="bwborder"><a href="javascript:history.go(-1)">Back </a></td>
	</tr>
	</table>
	</caption>
	</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Grievance Report</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext>District :<%=request.getAttribute("distName")%>&nbsp;&nbsp;&nbsp;Mandal :<%=request.getAttribute("mandName")%>&nbsp;&nbsp;&nbsp;Panchayat :<%=request.getAttribute("panchName")%>&nbsp;&nbsp;&nbsp;Asset Type :<%=request.getAttribute("typeName")%></td>
</tr>
</table>
<%
if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("04"))
	{%>
	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<tr>
		    <td class=clrborder align=center>Select</td>
		    <td class=clrborder align=center>Source Name</td>
		    <td class=clrborder align=center>Source Code</td>
		    <td class=clrborder align=center>AssetCode</td>
			<td class=clrborder align=center>Location</td>
			<td class=clrborder align=center>Diameter(mts)</td>
			
			<td class=clrborder align=center>Condition</td>
			<td class=clrborder align=center>Static Water Level(mts)</td>
			<td class=clrborder align=center>Summer Water Level(mts)</td>
			<td class=clrborder align=center>DrillYear</td>
		</tr>
		<% int count=0; %>
	<logic:iterate id="complist" name="complaints">
	<TR align="center">
			</tr>
	<tr bgcolor="#ffffff">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
	<td  class="bwborder" ><%=count %></td>
	<td  class=bwborder align=left>
	<nested:write name="complist" property="assetName"  />
	</td>
	<td  class=bwborder align=center>
	<nested:hidden name="complist" property="sourceCode"indexed="true"/>
	<nested:write name="complist" property="sourceCode"  />
	</td>
	<td class=bwborder align=center>
	<nested:hidden name="complist" property="assetCode" indexed="true"/>
	<nested:write name="complist" property="assetCode"  />
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="complist" property="location" /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write name="complist" property="diameterOfBorewell" /> 
	</td>
	
	<td  class=bwborder align=left>
	<nested:write name="complist" property="cond"  />
	</td>
	<td  class=bwborder align=center>
	<nested:write name="complist" property="staticWaterLevel"  /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write name="complist" property="summerWaterLevel"  /> 
	</td>
	<td  class=bwborder align=center>
	<nested:write name="complist" property="drillYear"/> 
	</td>
	</tr>	
    </logic:iterate>
	</table>
	<%}
	else if(request.getAttribute("asst")!=null  &&  ( request.getAttribute("asst").equals("01") || request.getAttribute("asst").equals("02") || request.getAttribute("asst").equals("03") || request.getAttribute("asst").equals("09")))
	{%>
	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<tr>
	<td class=clrborder align=center>Slno</td>
	<td class=clrborder align=center>Source Name</td>
	<td class=clrborder align=center>Source Code</td>
	<td class=clrborder align=center>AssetCode</td>
			<td class=clrborder align=center>Location</td>
	</tr>
	<% int count=0; %>
	<logic:iterate id="complist" name="complaints">
	<TR align="center">
	</tr>
	<tr bgcolor="#ffffff">
	<% count=count+1;%>
	<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
	<td  class="bwborder" ><%=count %></td>
	 <td  class=bwborder align=left>
	<nested:write name="complist" property="assetName"  />
	</td>
	<td  class=bwborder align=center>
	<nested:hidden name="complist" property="sourceCode"indexed="true"/>
	<nested:write name="complist" property="sourceCode"  />
	</td>
	<td class=bwborder align=center>
	<nested:hidden name="complist" property="assetCode" indexed="true"/>
	<nested:write name="complist" property="assetCode"  />
	</td>
	<td  class=bwborder align=left>
	<nested:write  name="complist" property="assetLocation" /> 
	</td>
	</logic:iterate>
	<%}  %>
	</table>
	</TABLE>
	<%@ include file="/commons/rws_footer.jsp"%></center>
	</form>
	</html:html>

