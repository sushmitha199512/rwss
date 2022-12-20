<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ page contentType="application/vnd.ms-excel" %>
<html>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr >
	
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Sl. No.</FONT></TD> 
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Asset Code</FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Scheme Code</FONT></TD>
    <td> <FONT class=myfontclr><font color="#993366">Asset Name</font></FONT></td>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Panchayat</FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.village" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.habitation" /></FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.location" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetStatus" /></FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCost" /></FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Start Year</FONT></TD>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>
	</tr>
	<% int count=0; %>
	<%if(((java.util.ArrayList)session.getAttribute("assets1")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	PWS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist1" name="assets1">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist1" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist1" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist1" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist1" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist1" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist1" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist1" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist1" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist1" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
<%if(((java.util.ArrayList)session.getAttribute("assets2")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	MPWS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist2" name="assets2">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist2" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist2" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist2" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist2" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist2" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist2" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist2" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist2" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist2" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets3")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	CPWS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets3">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets4")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	HAND PUMPS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets4">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
		

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets5")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	SHALLOW HAND PUMPS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets5">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets6")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	OPEN WELLS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets6">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
<%if(((java.util.ArrayList)session.getAttribute("assets7")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	PONDS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets7">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets8")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	OTHERS
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets8">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
	<%if(((java.util.ArrayList)session.getAttribute("assets9")).size()>0){%>
	<tr>
	<td colspan="12"  class=myfontclr><B><font color="red">
	DIRECT PUMPING
	</b>
	</font>
	</td>
	</tr>
	<%}%>
	<logic:iterate id="assetlist" name="assets9">
			<tr align="left"  onclick="toggleRowColor(this)">
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= ++count %></FONT>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1>&nbsp;<bean:write name="assetlist" property="habitation"/></FONT></TD>

			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="location" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetStatusName" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCost" /></FONT>
			</td>
			<td  class=mycborder1 align=center>

			<logic:present name="assetlist" property="endYear" >
			  <c:if test="${startYear==endYear}">
				 <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" /></FONT>
				</c:if>
				  <c:if test="${startYear!=endYear}">
				  <FONT class=myfontclr1>
				 <bean:write name="assetlist" property="startYear" />-</FONT>
				 <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
				 </c:if>
			</logic:present>
			<logic:notPresent name="assetlist" property="endYear" >
			<FONT class=myfontclr1>
			<bean:write name="assetlist" property="startYear" /></FONT>
			</logic:notPresent>
				
			</td>
			

			</tr>
	</logic:iterate>
</table>
