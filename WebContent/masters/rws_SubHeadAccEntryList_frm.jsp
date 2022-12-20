<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=700>
<tr><td align=right><html:link page="/switch.do?prefix=/masters&page=/SubHead.do&mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SubHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SubHead_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="700"   bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Sub Head Office Form</font></B></td>
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
		<td  class="clrborder" align=center>Group Sub Head Code</td>
		<td  class="clrborder" align=center>Group Sub Head Name</td>		
		<td  class="clrborder" align=center>Sub Head Code</td>
		<td  class="clrborder" align=center>Sub Head Name</td>
		<td  class="clrborder" align=center>Action</td>
	</tr>
<logic:iterate id="subheadlist" name="subheads">
	<tr align="left" >
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="majorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="submajorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="minorHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="minorHeadName" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="grpSubHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="grpSubHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="subheadlist" property="subHeadCode" />
		</td>
		<td  class="bwborder" >
			<bean:write name="subheadlist" property="subHeadName" />
		</td>
		
		<td nowrap class="bwborder">
		<a href="./SubHead.do?subHeadCode=<bean:write name='subheadlist' property='subHeadCode' />&grpSubHeadCode=<bean:write name='subheadlist' property='grpSubHeadCode' />&minorHeadCode=<bean:write name='subheadlist' property='minorHeadCode' />&submajorHeadCode=<bean:write name='subheadlist' property='submajorHeadCode' />&majorHeadCode=<bean:write name='subheadlist' property='majorHeadCode' />&mode=get" >
		<font color="#6600CC">Edit&nbsp;|&nbsp;</font></a>
		<a href="./SubHead.do?subHeadCode=<bean:write name='subheadlist' property='subHeadCode' />&grpSubHeadCode=<bean:write name='subheadlist' property='grpSubHeadCode' />&minorHeadCode=<bean:write name='subheadlist' property='minorHeadCode' />&submajorHeadCode=<bean:write name='subheadlist' property='submajorHeadCode' />&majorHeadCode=<bean:write name='subheadlist' property='majorHeadCode' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
		
		</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

