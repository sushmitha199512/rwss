<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=400>
<tr><td align=right><html:link page="/Head.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_HeadOffice_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_HeadOffice_xls.jsp" target="_new">Excel</html:link>
</td>
</tr>
</table>

<style>
.thumbnail{
position: relative;
z-index: 0;
}

.thumbnail:hover{
background-color: transparent;
z-index: 60;
}

.thumbnail span{ /*CSS for enlarged image*/
position: absolute;
background-color: lightyellow;
padding: 4px;
left: -1000px;
border: 1px dashed gray;
visibility: hidden;
color: black;
text-decoration: none;
}

.thumbnail span img{ /*CSS for enlarged image*/
border-width: 0;
padding: 2px;
}

.thumbnail:hover span{ /*CSS for enlarged image on hover*/
visibility: visible;
top: -120px;
left: -350px; /*position where enlarged image should offset horizontally */

}
</style>
<html:form  action="/Head.do" method="post" enctype="multipart/form-data">
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

<td class=mycborder1 >
	<logic:equal name="headlist"  property="imageStatus"  value="Yes" >
		<a class="thumbnail" href="#thumb"><img src="./../dashboards/image.jsp?imgID=<bean:write name='headlist' property='hoc' />"  width="30px" height="30px" border="0" /><span><img src="./../dashboards/image.jsp?imgID=<bean:write name='headlist' property='hoc' />"  width="350px" height="230px"/></span></a>
	</logic:equal> 
	<logic:notEqual name="headlist"  property="imageStatus"  value="Yes" >
			--
	</logic:notEqual> 
</td>
 
<td  class=mycborder1 align=center>
<a href="./Head.do?hoc=<bean:write name='headlist' property='hoc' />&mode=get" >
<font color="#6600CC">Edit&nbsp;&nbsp;</font></a>
</td>
</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>