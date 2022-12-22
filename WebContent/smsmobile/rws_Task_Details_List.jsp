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
/* function fnDelete(complntno,typeofAsset,dcode)
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
} */
</script>
<table width="50%">
<tr>
<td class="bwborder" align=right>
<a href="/pred/home.jsp?loginMode=watersoft">Home </a>|&nbsp;<a href="javascript:onclick=history.go(-1)">Back</a>
</tr>

</table>
<html:form action="SmsRegistration.do">
<table    width="50%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Task Autherization Details</font></B></td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="50%" border=1 style="border-collapse:collapse" >
     <tr >

	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Task&nbsp;Authorization&nbsp;Code</FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Task&nbsp;Authorization&nbsp;Name</FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT></td>
	</tr>
<%

 int count=0; 
 %>
<logic:iterate id="taskList" name="taskList">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" align="right"><%=count %></td>
<td  class=mycborder1 align=right>
<FONT class=myfontclr1><bean:write name="taskList" property="taskAuthorizationCode" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="taskList" property="taskAuthorizationName" /></FONT>
</td>

<td   class="bwborder" align=left>
<a href="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=editTask&taskCode=<bean:write name="taskList" property="taskAuthorizationCode" />"  style="color:blue">Edit&nbsp;</a>
</td>

</tr>
</logic:iterate>
	
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



