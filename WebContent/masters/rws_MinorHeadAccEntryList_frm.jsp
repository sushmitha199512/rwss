<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=600>
<tr><td align=right><html:link page="/MinorHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_MinorHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_MinorHead_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="600"   bgcolor="#8A9FCD">
	<tr>
		<td class="textborder">
			<font color="#FFFFFF">Minor Head Office Form</font>
		</td>
		<td align=right>
			<IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;
		</td>
	</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="600" border=1 style="border-collapse:collapse" >
	<tr >
		<td  class="clrborder" align="center">
			Major Head Code
		</td>
		<td  class="clrborder" align="center" nowrap>
			Major Head Name
		</td>
		<td  class="clrborder" align=center>
			Sub Major Head Code
		</td>
		<td  class="clrborder" align=center nowrap>
			Sub Major Head Name
		</td>
		<td  class="clrborder" align=center>
			Minor Head Code
		</td>
		<td  class="clrborder" align="center" nowrap>
			Minor Head Name
		</td>
		<td  class="clrborder" align="center">
			Action
		</td>
	</tr>
<logic:iterate id="minorheadlist" name="minorHeads">
	<tr align="left" >
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="majorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="submajorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="minorheadlist" property="minorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="minorheadlist" property="minorHeadName" />
		</td>
		<td nowrap class="bwborder">
			<a href="./MinorHead.do?minorHeadCode=<bean:write name='minorheadlist' property='minorHeadCode' />&majorHeadCode=<bean:write name='minorheadlist' property='majorHeadCode' />&submajorHeadCode=<bean:write name='minorheadlist' property='submajorHeadCode' />&mode=get"><font color="#6600CC">Edit&nbsp;</a>

		</td>
	</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

