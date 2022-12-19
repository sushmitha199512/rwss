 <%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script>
function openFile(hoc){
	
	    
		var url="switch.do?prefix=/masters&page=/Asset.do?mode=showOffImage&hoc="+hoc;
		//alert(url);
		var width = 990;
		var height = 450;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
						   + "resizable=yes,status=yes,left=20,top=20";

		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
		
		
	}
  

</script>
<table width=400>
<tr><td align=right><html:link page="/UrHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_HeadOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_HeadOffice_xls.jsp" target="_new">Excel</html:link>
</td>
</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Head Office Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=mycborder align=center>
		<FONT  class=myfontclr ><font color="#993366"><bean:message key="app.hoc" />&nbsp;</font></FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.hon" /></FONT>
		</td>
        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.honame" /></FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Image</FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366"><bean:message key="app.op" /></FONT>
		</td>
		
	</tr>

<logic:iterate id="headlist" name="headdetails">

<tr align="left" >

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="headlist" property="hoc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="headlist" property="hon" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="headlist" property="hoName" /></FONT>
</td>
<!-- bhagya -->
<td  class=mycborder1 >
			<logic:equal name="headlist"  property="hoImgStatus"  value="Yes" >
				<a href="#" onclick="openFile('<bean:write name="headlist" property="hoc"/>')">View</a>&nbsp;
			</logic:equal> 
			<logic:notEqual name="headlist"  property="hoImgStatus"  value="Yes" >
				<p style="width:100px">Image not Exist</p>
			</logic:notEqual> 
		</td>
<td  class=mycborder1 align=center>
<a href="./UrHead.do?hoc=<bean:write name='headlist' property='hoc' />&mode=get" >
<font color="#6600CC">Edit&nbsp;&nbsp;</font></a>
</td>
</tr>
</logic:iterate>

</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>