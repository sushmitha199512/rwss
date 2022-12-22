<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
	function getMandals(sdoc,doc,coc,sdon,noofmandals)
	{
	  if(noofmandals==0)
	    alert("There Are No Mandals Mapped To This Sub Divison");
	  else
	  {
		url = "switch.do?prefix=/masters&page=/UrSubDivision.do&mode=getmandals&sdoc="+sdoc+"&doc="+doc+"&coc="+coc+"&sdon="+sdon;
		window.open(url,"", "width=300,height=260,left=200,top=180,scrollbars=1");
		}
    }
	//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="95%">
<tr><td align=right>
<html:link page="/UrSubDivision.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SubDivisionOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SubDivisionOffice_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="95%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Sub Division Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="95%" border=1 style="border-collapse:collapse" >
<tr >

		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">SNo.</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Circle</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Division</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.code" /></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.subdivision" /></FONT></td>
		<!-- <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">No Of Mandals</FONT></td> -->
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT></td>


</tr>

<%int sno=1; %>
<logic:iterate id="subdivisionlist" name="subdivisions">
<tr align="left" >
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><%=sno%></FONT>
<%sno=sno+1;%>
<html:hidden name="subdivisionlist" property="hoc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="subdivisionlist" property="con" /></FONT>
<html:hidden name="subdivisionlist" property="coc" />
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="subdivisionlist" property="don" /></FONT>
<html:hidden name="subdivisionlist" property="doc" />
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="subdivisionlist" property="sdoc" /></FONT>
<html:hidden name="subdivisionlist" property="sdoc" />
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="subdivisionlist" property="sdon" /></FONT>
<html:hidden name="subdivisionlist" property="sdon" />
</td>

<%-- <td  class=mycborder1 align=center>
<FONT class=myfontclr1>

<a href="#<bean:write name="subdivisionlist" property="noOfMandals" />" onclick="getMandals('<bean:write name='subdivisionlist' property='sdoc' />','<bean:write name='subdivisionlist' property='doc' />','<bean:write name='subdivisionlist' property='coc' />','<bean:write name="subdivisionlist" property="sdon" />','<bean:write name="subdivisionlist" property="noOfMandals" />')">
<font color="#6600CC"><bean:write name="subdivisionlist" property="noOfMandals" /></FONT></font></a>&nbsp;&nbsp;
</td> --%>

<td  class=mycborder1 >
<a href="./UrSubDivision.do?sdoc=<bean:write name='subdivisionlist' property='sdoc' />&doc=<bean:write name='subdivisionlist' property='doc' />&coc=<bean:write name='subdivisionlist' property='coc' />&mode=get"><font color="#6600CC">Edit&nbsp;&nbsp;|</font></a>&nbsp;&nbsp;
<!--<a href="./SubDivision.do?sdoc=<bean:write name='subdivisionlist' property='sdoc'/>&doc=<bean:write name='subdivisionlist' property='doc' />&coc=<bean:write name='subdivisionlist' property='coc' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>-->
</td>
</tr>
</logic:iterate>
</table>
<br>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

