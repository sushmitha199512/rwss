<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="qualForm" />
<%@ include file="/commons/rws_header2.jsp" %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">
function fnDelete(code,dcode,mcode,type)
{

	
		document.forms[0].action="switch.do?prefix=/masters&page=/EE.do?mode=delete&paoCode="+code+"&circleOffice="+dcode+"&divisionOffice="+mcode;
		document.forms[0].submit();

	
}


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
</script>

<table width=100%>
<tr><td align=right><html:link page="/EE.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="../admin/rws_general_admn_loginsuccess.jsp">Home</a></td>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="9">Executive Engineers List  </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
        <td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
		
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Circle</FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Division</FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">PAO Code/<br>Employee Code</FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Executive Engineer Name</FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Date Of Joining<br>(In Present Post)</FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Date Of Relieving</FONT></td>
         		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Select</FONT></td>
		<td  class=mycborder1 align=center>

		
		
		
		
		
		
		</tr>
<%int count=1;%>
<logic:iterate id="conslist" name="engineers">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=count++%></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="conslist" property="circleName" /></FONT>
<html:hidden name="conslist" property="circleOffice" />
</td>
<td  class=mycborder1 align=left >
<FONT class=myfontclr1><bean:write name="conslist" property="divisionName" /></FONT>
<html:hidden name="conslist" property="divisionOffice" />
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="conslist" property="paoCode" /></FONT>
</td>
<td  class=mycborder1 align=left >
<FONT class=myfontclr1><bean:write name="conslist" property="eeName" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="dateofPresent" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="dateofReleaving" /></FONT>
</td>

<td align=center>
<a href="switch.do?prefix=/masters&page=/EE.do?paoCode=<bean:write name='conslist' property='paoCode' />&circleOffice=<bean:write name='conslist' property='circleOffice' />&divisionOffice=<bean:write name='conslist' property='divisionOffice' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>&nbsp;&nbsp;


</td>



</td>

</tr>
</logic:iterate>

</table>
</html:html>
<%@ include file="/commons/rws_footer.jsp"%>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>




