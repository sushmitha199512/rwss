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
	 	 //var url = "/pred/complaints/Complaintsout.do?mode=cdelete&complntno="+complntno;
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
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=cdelete&complntno="+complntno+"&typeofAsset="+typeofAsset+"&dcode="+dcode;
	document.forms[0].submit();
	}
	}
function fnEdit(complntno,typeofAsset,dcode)
{
 document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=get&complntno="+complntno+"&typeofAsset="+typeofAsset+"&dcode="+dcode;
 document.forms[0].submit();
}
</script>
<table width="100%">
<tr>
<td class="bwborder" align=right>
<A HREF="javascript:history.go(-3)">Back&nbsp;|&nbsp;</A>
</tr>
</table>
<html:form action="Complaintsout.do">
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Complaints List</font></B></td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
     <tr >
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Location</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Inward No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint Date</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Nature of Problem</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Problem Description</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Complaint Given By</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Address</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Phone No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT>	</td>
	</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)session.getAttribute("complaints"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{
 int count=0; 
System.out.println("Complaints"); %>
<logic:iterate id="COMPLAINTSLIST" name="complaints">
<%System.out.println("Complaints2"); %>
<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="assetName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="assetLocation" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="complntno" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="inwardNo" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="complntdt" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="categoryName" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="complntdesc" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="repName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="name" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="address" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSLIST" property="phoneNo" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<a href="#1" onclick="openEditWindow('switch.do?prefix=/complaints&page=/Complaintsout.do?mode=get&complntno=<bean:write name='COMPLAINTSLIST' property='complntno' />')">Edit&nbsp;|</a>&nbsp;
<!-- <a href="#1" onclick="openEditWindow('<bean:write name='COMPLAINTSLIST' property='complntno' />') " style="color:blue">Edit&nbsp;|</a>&nbsp; -->
<!-- <a href="#1"  onclick="fnEdit('<bean:write name='COMPLAINTSLIST' property='complntno' />','<bean:write name='COMPLAINTSLIST' property='typeofAsset' />','<bean:write name='COMPLAINTSLIST' property='dcode' />')"><font color="#990066">&nbsp;&nbsp;Edit | </font></a> -->
<!-- <a href="#1" onclick="toggleColor(this);openDeleteWindow('<bean:write name='COMPLAINTSLIST' property='complntno' />') " style="color:blue">Delete&nbsp;</a>&nbsp; -->
<!--  <a href="#1"  onclick="fnDelete('<bean:write name='COMPLAINTSLIST' property='complntno' />','<bean:write name='COMPLAINTSLIST' property='typeofAsset' />','<bean:write name='COMPLAINTSLIST' property='dcode' />')"><font color="#990066">Delete</font></a>-->
 <a href="#1" onclick="openDeleteWindow('switch.do?prefix=/complaints&page=/Complaintsout.do?mode=cdelete&complntno=<bean:write name='COMPLAINTSLIST' property='complntno' />')">
<font color="#990066">Delete</font></a>
</td>
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
	System.out.println("Exception"+e);
	}
	%>
</table>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
<script language="javascript">
<%
if(request.getAttribute("dmessage")!=null)
{
%>
alert('<%=request.getAttribute("dmessage")%>');
<%}%>
</script>



