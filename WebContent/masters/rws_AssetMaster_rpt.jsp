<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<html>
<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=left>
<table align=right>
<tr>
   <td colpsan="8" class="bwborder" ><FONT class=myfontclr>Report Date :</FONT> <%=fmt.format(new java.util.Date()) %></td>
	</tr> 
</table>

</caption>
<tr><td colspan=8> <FONT class=myfontclr><b>Asset Details</b></FONT></td></tr>
<tr>
	<td align=center><b><FONT class=myfontclr> SNo</FONT></b></td>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr> Asset Code </TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr> Scheme Code </TD>
    <td> <FONT class=myfontclr> Asset Name</font> </td>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr>Panchayat</FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr><bean:message key="app.village" /></FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><bean:message key="app.habitation" /></FONT></TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr> <bean:message key="app.location" /> </TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr> <bean:message key="app.assetStatus" /> </TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr> <bean:message key="app.assetCost" /> </TD>
    <TD class="mycborder" align=center>
	<FONT class=myfontclr> Start - End Year </TD>
	
	 
</tr>
<% int i=1;%>
 <bean:define id="assetType1" value=""/>
    <logic:iterate id="assetlist" name="assets"  >
       <bean:define id="tempAssetType" name="assetlist" property="assetTypeName"/>
 	
         <c:if test="${tempAssetType != assetType1}">
          <c:forEach items="${assetTypes}" var="item" varStatus="status">
          <bean:define id="assetType" name="item" property="label"/>
              <c:if test="${tempAssetType == assetType}">
              <td colspan="7"><table  width="100%"  >
               <tr><td class="label"><FONT class=myfontclr1 size="2"> 
               <b><bean:write name="item" property="label"/></b></font></td></tr>
		       </table>
		       </td>
               <c:set var="assetType1" value="${tempAssetType}"/>
 		     </c:if>
		 </c:forEach>
		</c:if> 
<tr align="left" >

<td align="left"><FONT class=myfontclr1>
<%= i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetlist" property="panchName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetlist" property="villName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetlist" property="habitation" /></FONT>
</td>
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
    <FONT class=myfontclr1>
    <bean:write name="assetlist" property="startYear" />-</FONT>
    <FONT class=myfontclr1><bean:write name="assetlist" property="endYear" /></FONT>   
</logic:present>
<logic:notPresent name="assetlist" property="endYear" >
<FONT class=myfontclr1>
<bean:write name="assetlist" property="startYear" /></FONT>
</logic:notPresent>
</td> 
</tr>
</logic:iterate>
</table>

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
