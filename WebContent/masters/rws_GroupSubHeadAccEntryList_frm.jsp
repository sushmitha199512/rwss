<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=700>
	<tr>
		<td align=right>
			<html:link page="/GrpSubHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
			<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
			<html:link page="/rws_GrpSubHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
			<html:link page="/rws_GrpSubHead_xls.jsp" target="_new">Excel</html:link>
		</td>
	</tr>
</table>
<table    width="700"   bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Group Head Office Form</B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="700" border=1 style="border-collapse:collapse" >
	<tr >
		<td  class="clrborder" align=center>Major Head Code</td>
		<td  class="clrborder" align=center>Major Head Name</td>
		<td  class="clrborder" align=center>Sub Major Head Code</td>
		<td  class="clrborder" align=center>Sub Major Head Name</td>
		<td  class="clrborder" align=center>Minor Head Code</td>
		<td  class="clrborder" align=center>Minor Head Name</td>
		<td  class="clrborder" align=center>Group SubHead Code</td>
		<td  class="clrborder" align=center>Group SubHead Name</td>
		<td  class="clrborder" align=center>Action</td>
	</tr>

<logic:iterate id="grpsubheadlist" name="grpSubHeads">
<tr align="left" >
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="majorHeadCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="majorHeadName" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="submajorHeadCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="submajorHeadName" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="minorHeadCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="minorHeadName" />
	</td>
	<td  class="bwborder" align=center>
		<bean:write name="grpsubheadlist" property="grpSubHeadCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="grpsubheadlist" property="grpSubHeadName" />
	</td>

	<td nowrap class="bwborder" align=center>
		<a href="./GrpSubHead.do?grpSubHeadCode=<bean:write name='grpsubheadlist' property='grpSubHeadCode' />&&majorHeadCode=<bean:write name='grpsubheadlist' property='majorHeadCode' />&submajorHeadCode=<bean:write name='grpsubheadlist' property='submajorHeadCode' />&minorHeadCode=<bean:write name='grpsubheadlist' property='minorHeadCode' />&mode=get"><font color="#6600CC">Edit&nbsp;&nbsp;|</a>
		<a href="./GrpSubHead.do?grpSubHeadCode=<bean:write name='grpsubheadlist' property='grpSubHeadCode' />&majorHeadCode=<bean:write name='grpsubheadlist' property='majorHeadCode' />&submajorHeadCode=<bean:write name='grpsubheadlist' property='submajorHeadCode' />&minorHeadCode=<bean:write name='grpsubheadlist' property='minorHeadCode' />&mode=delete"onclick="return deleteRec()"><font color="#990066">Delete</a>
	</td>
</tr>

</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
