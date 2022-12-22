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
<tr><td class=myfontclr><B><font color="#FFFFFF">Registration Details</font></B></td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
     <tr >

	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">IMEI Number</FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Habitation Code</FONT></td>
	
    
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Data Collector Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Mobile Number</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Designation</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Gender</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Email Id</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Address</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Date Of Request</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Service Request</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT></td>
	
	
	</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)session.getAttribute("smsreg"); 
//System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
//System.out.println("Complaints"); %>
<logic:iterate id="REGLIST" name="smsreg">
<%//System.out.println("Complaints2"); %>
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="imeino" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="REGLIST" property="habCode" /></FONT>
</td>



<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="datecollname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="phoneNo" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="desgnation" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="gender" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="emailId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="address" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="dateCreation" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="REGLIST" property="servicereq" /></FONT>
</td>
<td  class="bwborder"  nowrap>
 <a href="./switch.do?prefix=/smsmobile&page=/SmsRegistration.do?phone=<bean:write name='REGLIST' property='phoneNo'/>&hab=<bean:write name='REGLIST' property='habCode'/>&serviceReq=<bean:write name="REGLIST" property="servicereq" />&mode=get"><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
 <a href="./switch.do?prefix=/smsmobile&page=/SmsRegistration.do?phone=<bean:write name='REGLIST' property='phoneNo'/>&hab=<bean:write name='REGLIST' property='habCode'/>&mode=delete" onclick="return funDelete()"><font color="#6600CC">Delete&nbsp;</font></a>

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



