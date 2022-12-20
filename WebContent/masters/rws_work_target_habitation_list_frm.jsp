<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>



<script language="JavaScript" type="text/javascript">
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
function funcDelete(dist,finYear)
{	
	if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="switch.do?prefix=/masters&page=/HabWork.do&mode=delete&dist="+dist+"&finYear="+finYear;
	    document.forms[0].submit();
	}
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
<body>

<html:form action="/HabWork.do" method="post">
<table border = 0 cellspacing = 0 cellpadding = 0 width="50%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "RIGHT">			
			<tr align="right">
					<td class="bwborder"><a href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Home&nbsp;&nbsp;|</a><a href="javascript:onclick=history.go(-1)">Back</td>		
			</tr>  
		</table>
	</caption>
</table>


<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF" colspan="12">Targets For Financial Year  </font></B></td>
<td align=right></td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
        <td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
		
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.dist" /></FONT></td>
		<td class=mycborder align=center>
		
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.finYear" /></FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.svsHabs" /></FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.svsExp" /></FONT><br>( <b style="font-family: Rupee Foradian;">`</b>. In Lakhs )</td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.mvsHabs" /></FONT></td>
		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.mvsExp" /></FONT><br>( <b style="font-family: Rupee Foradian;">`</b>. In Lakhs )</td>
         		<td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.schHabs" /></FONT></td>
		
         <td class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.angHabs" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.noofVwsctrained" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.trtoFtkkits" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.wqftkTests" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.pcHabs" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.qaHabs" /></FONT></td>
		<td  class=mycborder1 align=center>
		
	
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.pwsHabitations" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.houseConnections" /></FONT></td>
		<td  class=mycborder1 align=center>
		
		
		
		
		

		<FONT class=myfontclr><font color="#993366">Select</FONT></td>
	
		
		
		
		
		
		
		</tr>
<%int count=1;
%>
<logic:iterate id="conslist" name="targets">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><%=count++%></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="conslist" property="districtName" /></FONT>
<html:hidden name="conslist" property="dist" />


</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="finYear" /></FONT>

</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="conslist" property="svsHabs" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="svsExp" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="mvsHabs" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="mvsExp" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="schHabs" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="angHabs" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="noofVwsctrained" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="trtoFtkkits" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="wqftkTests" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="pcHabs" /></FONT>
</td>

<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="qaHabs" /></FONT>
</td>


<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="pwsHabitations" /></FONT>
</td>
<td  class=mycborder1 align=center >
<FONT class=myfontclr1><bean:write name="conslist" property="houseConnections" /></FONT>
</td>




<td  class=mycborder1 align=center><font color="#990066">

<a href="switch.do?prefix=/masters&page=/HabWork.do?dist=<bean:write name='conslist' property='dist' />&finYear=<bean:write name='conslist' property='finYear' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp; 
<a href="#" onclick="funcDelete('<bean:write name='conslist' property='dist'/>','<bean:write name='conslist' property='finYear'/>')">Delete</a>

</td> 







</tr>
</logic:iterate>
<%if(count==1){
	%>
	<tr>
	<td colspan=16 align=center class=myfontclr><b>No Records</b></td>
	</tr>
<%} %>

</table>
</html:form>
</body>

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




