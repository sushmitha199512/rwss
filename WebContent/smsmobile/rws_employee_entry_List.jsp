<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<script language="javascript">
var newWindow;
function openEditWindow(url)
{
	var width = 1000
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
	+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
	+ "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	//newWindow = window.open(url, "_blank", properties);
	newWindow.focus();
	}
function openDeleteWindow(url)
{
	 var width = 100;
	 var height = 100;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 	 
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
function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"
}
function fnDelete(complntno,typeofAsset,dcode)
	{
	if(confirm("Do You Want To Delete The Selected Record"))
	{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=cdelete&complntno="+complntno+"&typeofAsset="+typeofAsset+"&dcode="+dcode;
	document.forms[0].submit();
	}
	}
function fnEdit(complntno,typeofAsset,dcode)
{
 document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsoutgeneric.do?mode=get&complntno="+complntno+"&typeofAsset="+typeofAsset+"&dcode="+dcode;
 document.forms[0].submit();
}
function funDelete(){
	if(confirm("Are You Sure You Want Delete Selected Record")) {
		return true;
				  }
	else{
		return false;
	}
}
</script>
<table width="100%">
<tr>
<td class="bwborder" align=right>
<A HREF="javascript:history.go(-3)">Back&nbsp;|&nbsp;</A>
</tr>
</table>
<html:form action="SmsRegistration.do">
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Employee Mobile Entry  Details</font></B></td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
     <!-- <tr >

	
	
	
	</tr> -->
<%
try
{
java.util.Collection b = (java.util.ArrayList)session.getAttribute("mobreg"); 
System.out.println("B size"+b.size());
if(b.size()>0)
{
	
 int count=0; 
//System.out.println("Complaints"); %>
<logic:iterate id="REGLIST" name="mobreg" >
<% if(count==0)
	{
	
%>
<tr >

	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Head Office Code</FONT></td>
	<logic:notEqual name="REGLIST"  property="circleOfficeCode" value="">
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Circle Office Code</FONT></td>
	</logic:notEqual>
	<logic:notEqual name="REGLIST"  property="divisionOfficeCode" value="">
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Division Office Code</FONT></td>
	</logic:notEqual>
	<logic:notEqual name="REGLIST"  property="subDivisionOfficeCode" value="">
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sub Division Office Code</FONT></td>
	</logic:notEqual>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Employee Number</FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Employee Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Designation</FONT></td>
    <td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Mobile Number</FONT></td>
	<tr>
<%} %>
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="headOfficeCode" /></FONT>
</td>
 <logic:notEqual name="REGLIST"  property="circleOfficeCode" value="">
 <td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="circleOfficeCode" /></FONT>
</td>
</logic:notEqual>
<logic:notEqual name="REGLIST"  property="divisionOfficeCode" value="">
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="divisionOfficeCode"  /></FONT>
</td>
</logic:notEqual>
<logic:notEqual name="REGLIST"  property="subDivisionOfficeCode" value="">
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="subDivisionOfficeCode" /></FONT>
</td>
</logic:notEqual>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="employeeId" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="employeeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="designation" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="employeeMobile" /></FONT>
</td>

<td  class="bwborder"  nowrap>
 <a href="./switch.do?prefix=/smsmobile&page=/employeeEntry.do?headOfficeCode=<bean:write name='REGLIST' property='headOfficeCode'/>&circleOfficeCode=<bean:write name='REGLIST' property='circleOfficeCode'/>&divisionOfficeCode=<bean:write name="REGLIST" property="divisionOfficeCode" />&subDivisionOfficeCode=<bean:write name="REGLIST" property="subDivisionOfficeCode" />&employeeId=<bean:write name="REGLIST" property="employeeId" />&employeeName=<bean:write name="REGLIST" property="employeeName" />&employeeMobile=<bean:write name="REGLIST" property="employeeMobile" />&mode=updateMobileData"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<%--  <a href="./switch.do?prefix=/smsmobile&page=/SmsRegistration.do?phone=<bean:write name='REGLIST' property='employeeId'/>&hab=<bean:write name='REGLIST' property='employeeName'/>&mode=delete" onclick="return funDelete()"><font color="#6600CC">Delete&nbsp;</font></a>
 --%>
</tr>
</logic:iterate>
	<%} 
	else 
	{
	%>
	<tr>
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%
	}}
	catch(Exception e)
	{
	e.printStackTrace();
	}
	%>
</table>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
<script language="javascript">
<%
if(request.getAttribute("gmessage")!=null)
{
%>
alert('<%=request.getAttribute("gmessage")%>');
<%}%>
</script>



