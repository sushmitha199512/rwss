<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

 
<table width="95%">
<tr><td align=right><a href="<rws:context page='/switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data' />">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_MandalSubDivision_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_MandalSubDivision_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table   width="95%"   bgcolor="#8A9FCD">
	<tr>
		<td class=textborder>
			<font color="#FFFFFF">Mandal Sub Division Link Form</font></td>
		<td align=right>
			<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table  width="95%" bgcolor="#FFFFFF" bordercolor= "#8A9FCD"    border=1 style="border-collapse:collapse" >
	<tr >
     <td  class="clrborder" align=center >SNo.
     </td>
		<td  class="clrborder" align=center >
			<bean:message key="app.district" />     
			
		<td  class="clrborder" align=center >
			<bean:message key="app.circle" />
		</td>
		<td  class="clrborder" align=center >
			<bean:message key="app.division" />
		</td>
		<td  class="clrborder" align=center >
			<bean:message key="app.subdivision" />
		</td>

		</td>
		<td  class="clrborder" align=center >
			<bean:message key="app.mandal" />
		</td>
		
		<td class="clrborder" align=center >
			<bean:message key="app.op" />
		</td>
	</tr>
<% int sno=1; %>
<logic:iterate id="mandalSubdivision" name="mandalSubdivisions">
	<tr align="left" >
        <td  class="bwborder"><%=sno%>
        <% sno=sno+1; %>
        </td>
		<td  class="bwborder">
			<bean:write name="mandalSubdivision" property="dname" />
		</td>
	
		<td  class="bwborder">
			<bean:write name="mandalSubdivision" property="con" />
		</td>
		<td  class="bwborder">
			<bean:write name="mandalSubdivision" property="don" />
		</td>
		<td  class="bwborder">
			<bean:write name="mandalSubdivision" property="sdon" />
		</td>

		<td  class="bwborder">
			<bean:write name="mandalSubdivision" property="mandalName" />
		</td>
		
						
		<td class="bwborder">
			<a href="./switch.do?prefix=/masters&page=/MandalSubdivision.do?coc=<bean:write name='mandalSubdivision' property='coc' />&doc=<bean:write name='mandalSubdivision' property='doc' />&sdoc=<bean:write name='mandalSubdivision' property='sdoc' />&dcode=<bean:write name='mandalSubdivision' property='dcode' />&mandalCode=<bean:write name='mandalSubdivision' property='mandalCode' />&mode=get"><font color="#6600CC">Edit</font></a>&nbsp;&nbsp;|&nbsp;
            <a href="./switch.do?prefix=/masters&page=/MandalSubdivision.do?coc=<bean:write name='mandalSubdivision' property='coc' />&doc=<bean:write name='mandalSubdivision' property='doc' />&sdoc=<bean:write name='mandalSubdivision' property='sdoc' />&dcode=<bean:write name='mandalSubdivision' property='dcode' />&mandalCode=<bean:write name='mandalSubdivision' property='mandalCode' />&mode=delete"onclick="return deleteRec()"><font color="#990066">Delete</font></a>			
		</td>
	</tr>
</logic:iterate>
		
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
 

