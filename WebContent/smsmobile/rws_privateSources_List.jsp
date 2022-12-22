<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<script language="javascript">


function fnDelete(psourceCode)
	{
	if(confirm("Do You Want To Delete The Selected Record"))
	{
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?mode=delete&psourceCode="+psourceCode;
	document.forms[0].submit();
	}
	}

</script>

<html:form action="SmsRegistration.do">
<table width="100%">
<tr>
<td class="bwborder" align=right>
<a href="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do&mode=get2">Back&nbsp;|&nbsp;</a>
<a href="/pred/home.jsp">Home&nbsp;|&nbsp;</a>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Private Source Details</font></B></td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
     <tr >

	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sl.No</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">District</FONT></FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Mandal</FONT></FONT></td>
	
    
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Panchayat</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Village</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Habitation</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Private&nbsp;Source&nbsp;Code</FONT></FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source&nbsp;Location</FONT></FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source&nbsp;Owner&nbsp;Name</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source&nbsp;Owner&nbsp;Mobile</FONT></FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source&nbsp;Latitude</FONT></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Source&nbsp;Longitude</FONT></FONT></td>
	
	<td  class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Action</FONT></FONT></td>
	
	
	</tr>
<%
try
{
java.util.Collection b = (java.util.ArrayList)session.getAttribute("SourceDetails"); 
if(b.size() > 0)
{
 int count=0; 
%>
<logic:iterate id="SourceDetails" name="SourceDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="dname" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="mname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="pname" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="vill" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="panchName" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceCode" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceLoc" /></FONT>
</td>
<td  class=mycborder1 align=left>
  <FONT class=myfontclr1><label for="psourceLocT" id="psourceLocT">${SourceDetails.psourceLocT}</label></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceMob" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceLat" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="SourceDetails" property="psourceLong" /></FONT>
</td>

<td  class="mycborder1"  nowrap>
 <a href="./switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?psourceCode=<bean:write name='SourceDetails' property='psourceCode'/>&mode=get"  ><font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
<!--  <a href="./switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?psourceCode=<bean:write name='SourceDetails' property='psourceCode'/>&mode=delete" ><font color="#6600CC">Delete&nbsp;|&nbsp;</font></a>-->
<a href="#1"  onclick="fnDelete('<bean:write name='SourceDetails' property='psourceCode' />')"><font color="#990066">Delete</font></a>
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
	System.out.println("Exception in rws_privateSources_List.jsp  "+e);
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



