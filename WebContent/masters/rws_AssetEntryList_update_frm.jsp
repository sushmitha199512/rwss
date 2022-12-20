<%
String msg = (String)request.getAttribute("message");
System.out.println("Msg:"+msg);
String status = "N";
System.out.println("coded:"+request.getParameter("circleOfficeCode"));
if(msg!=null)
{
	if(msg.endsWith("Successfully"))
		status = "Y";
System.out.println(msg.endsWith("Successfully"));
}%>
<%@page import="nic.watersoft.masters.RwsMaster"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
java.util.ArrayList progs = (java.util.ArrayList)session.getAttribute("programs");%>
<script language="javascript">
function checkCheckedOrNot(index,that)
{
	if(!document.getElementById('check['+index+']').checked)
	{
		alert("Before Updating the program You must select the Check Box with Sl. No:"+index);
		that.value = '';
	}
}
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
function fnViewUpdateProgram()
{
	var len=document.forms[0].elements.length;
	var yes=0;
	for( var i=0;i<len;i++)
	{ 
		if(document.forms[0].elements[i].name.substring(0,7)=="program")
		{
			if(document.forms[0].elements[i].value == "")
			{ 
				yes=1; 
			}
			else if(document.forms[0].elements[i].value!="")
			{ 
				yes=0;
				break; 
			}
		}
	}
	
	if(yes==1)
	{
		alert("Please Select Program for atleast one asset");
		return false;
	}
	else if(yes==0)
	{
		var val=confirm("Are You Sure to Update the Asset(S)");
		if(val)
		{
			alert("ok");
			return true;
		}
	}
}

</script>
<body>
<html:form action="Asset.do?mode=viewUpdateProgram">
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
	<FONT class=myfontclr><font color="#993366">Sel<BR>ect</FONT></TD>
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
	<FONT class=myfontclr><font color="#993366">Program</FONT></TD> 
	</tr>
	<% int count=1; %>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist1" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px" onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="pwss" name="assetlist1" property="program"/>
			<%
			//System.out.println("pwss:"+pwss);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(pwss)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist2" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px" onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="mpwss" name="assetlist2" property="program"/>
			<%
			//System.out.println("mpws:"+mpwss);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(mpwss)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
			</td>

			</tr>
	</logic:iterate>
	<%
if(((java.util.ArrayList)session.getAttribute("assets3")).size()>0){%>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="cpwss" name="assetlist" property="program"/>
			<%
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(cpwss)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="chps" name="assetlist" property="program"/>
			<%
			//System.out.println("hps:"+chps);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(chps)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="shps" name="assetlist" property="program"/>
			<%
			//System.out.println("shps:"+shps);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(shps)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="ows" name="assetlist" property="program"/>
			<%
			//System.out.println("ows:"+ows);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(ows)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="ponds" name="assetlist" property="program"/>
			<%
			//System.out.println("ponds:"+ponds);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(ponds)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px"  onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<bean:define id="others" name="assetlist" property="program"/>
			<%
			//System.out.println("others"+others);
			for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
				if(rwsMaster.getPrgmCode().equals(others)) {
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>" selected><%=rwsMaster.getPrgmName()%></option>
				<%
				}
				else{
				%>
				<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
				<%
				}
			}
			%>
			</select>
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
			<td><input type=checkbox name="check[<%=count%>]" value='<bean:write name="assetlist" property="assetCode" />'></td>
			<td  class=mycborder1 align=center>
			<FONT class=myfontclr1><%= count++ %></FONT>
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
			<td class="bwborder" >
			<select name="program<%=(count-1)%>" styleClass="mycombo" style="width:140px" onchange="checkCheckedOrNot('<%=count-1%>',this)">
			<option value="">SELECT...</option>
			<%for(int i=0;i<progs.size();i++)
			{
				RwsMaster rwsMaster = (RwsMaster)progs.get(i);
			%>
			<option value="<%=rwsMaster.getPrgmCode()%>"><%=rwsMaster.getPrgmName()%></option>
			<%
			}
			%>
			</select>
			</td>
			</tr>
	</logic:iterate>
	</table><BR><BR>
<input type=submit value="Update Assets with Selected Program" onSubmit="fnViewUpdateProgram();">
<input type="hidden" name="resultCount" value="<%=--count%>">
<input type="hidden" name="circleOfficeCode" value="<%=request.getParameter("circleOfficeCode")%>">
<input type="hidden" name="divisionOfficeCode" value="<%=request.getParameter("divisionOfficeCode")%>">
<input type="hidden" name="subdivisionOfficeCode" value="<%=request.getParameter("subdivisionOfficeCode")%>">
<input type="hidden" name="mandal" value="<%=request.getParameter("mandal")%>">
<input type="hidden" name="subdivisionOfficeCode" value="<%=request.getParameter("subdivisionOfficeCode")%>">
<input type="hidden" name="mandal" value="<%=request.getParameter("mandal")%>">
<input type="hidden" name="habCode" value="<%=request.getParameter("habCode")%>">
<input type="hidden" name="assetTypeCode" value="<%=request.getParameter("assetTypeCode")%>">
</td>
</tr>
</html:form>
</body>
 <%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>