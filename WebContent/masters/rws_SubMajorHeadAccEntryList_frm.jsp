<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=500>
<tr><td align=right><html:link page="/SubMajorHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SubMajorHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SubMajorHead_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="500"   bgcolor="#8A9FCD">
	<tr>
		<td class="textborder">
			<font color="#FFFFFF">Sub Major Head Office Form</font>
		</td>
		<td align=right>
			<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
		<td  class=clrborder align=center >
			<bean:message key="app.majorHeadCode" />
		</td>
		<td  class=clrborder align=center >
			Major Head Name
		</td>
		<td  class=clrborder align=center >
			<bean:message key="app.submajorHeadCode" />
		</td>
		<td  class=clrborder  align=center>
			<bean:message key="app.submajorHeadName" />
		</td>
		<td  class=clrborder  align=center>
			<bean:message key="app.op" />
		</td>
		</tr>

<logic:iterate id="submajorheadlist" name="submajorHeads">
	<tr align="left" >
		<td  class="bwborder" >
			<bean:write name="submajorheadlist" property="majorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="submajorheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="submajorheadlist" property="submajorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="submajorheadlist" property="submajorHeadName" />
		</td>
		
		<td class="bwborder" nowrap>
		<a href="./SubMajorHead.do?submajorHeadCode=<bean:write name='submajorheadlist' property='submajorHeadCode' />&majorHeadCode=<bean:write name='submajorheadlist' property='majorHeadCode' />&mode=get"><font color="#6600CC">Edit&nbsp;</font></a>

		</td>
	</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>