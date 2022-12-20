<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function openDeleteWindow(url,deletes,assetTypeCode) {
//	alert(url);
	var width = 1;
		 var height = 1;
		 var left = parseInt((screen.availWidth/2)-(width/2));
		 var top = parseInt((screen.availHeight/2)-(height/2));
		 
		 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
		 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
		
	if(assetTypeCode=="01" || assetTypeCode=="02" || assetTypeCode=="03" || assetTypeCode=="09")
	{
		if(deletes!="")
		{
			if(confirm("Subcomponents Exists! Are you sure you wish to continue?"))
			{
				newWindow = window.open(url, "_New", properties);
				newWindow.focus();
			}
		}
		else
		{
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
		}
	}
	else
	{
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
	}
}
function openEditWindow(url)
{

	 var width = 838;
	 var height = 600;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	//alert(url);
	 //var url = "/pred/masters/habStatusEditFrm.do?habCode="+habCode;
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
	
}
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
</script>
<body>
<form>
<table width="100%" >
<tr><td align=right><A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</a>
 <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_AssetMaster_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_AssetMaster_xls.jsp" target="_new">Excel</html:link>

</tr>
</table>

<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Asset Entry Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
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
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Covered Habs</FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Sub Surface Source</FONT></TD>
	<TD class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366">Surface Source</FONT></TD>
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
			<FONT class=myfontclr1><bean:write name="assetlist1" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="habitation"/></FONT></TD>

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
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist1" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist1' property='assetCode' />&schemeCode=<bean:write name='assetlist1' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist1' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist1' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist1' property='compExists' />','<bean:write name='assetlist1' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist2" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist2" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist2' property='assetCode' />&schemeCode=<bean:write name='assetlist2' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist2' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist2' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist2' property='compExists' />','<bean:write name='assetlist2' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
						<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>
			&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
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
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="schemeCode" /></FONT><br>
			</td>
			<td  class=mycborder1 align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="assetName"/></FONT> 
			</td>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="panchName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="villName"/></FONT></TD>
			<TD class="mycborder1" align=left>
			<FONT class=myfontclr1><bean:write name="assetlist" property="habitation"/></FONT></TD>

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
				
			</td>			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="totalCovered" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="surfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><bean:write name="assetlist" property="subsurfaceSourceCount" /></FONT>
			</td>
			<td  class=mycborder1 align=center nowrap>
			<a href="#1" onclick=openEditWindow('./Asset.do?assetCode=<bean:write name='assetlist' property='assetCode' />&schemeCode=<bean:write name='assetlist' property='schemeCode' />&assetTypeCode=<bean:write name='assetlist' property='assetTypeCode' />&mode=getNew&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&opType=Modify')>
			<font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
			<a href="#1" onclick=openDeleteWindow('./Asset.do?mode=delete&assetCode=<bean:write name='assetlist' property='assetCode' />&circleOfficeCode=<%=request.getAttribute("circleOfficeCode")%>&divisionOfficeCode=<%=request.getAttribute("divisionOfficeCode")%>&subdivisionOfficeCode=<%=request.getAttribute("subdivisionOfficeCode")%>&habCode=<%=request.getAttribute("habCode")%>','<bean:write name='assetlist' property='compExists' />','<bean:write name='assetlist' property='assetTypeCode' />')>
			<font color="#990066">Delete</font></a>
			</td>

			</tr>
	</logic:iterate>
</table>
 
</td>
</tr>
</form>
</body>
 <%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>