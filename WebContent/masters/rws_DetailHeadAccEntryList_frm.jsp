<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="100%">
<tr>
	<td align=right>
		<html:link page="/DetailHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
		<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
		<html:link page="/rws_DetailHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
		<html:link page="/rws_DetailHead_xls.jsp" target="_new">Excel</html:link>
	</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
	<tr bgcolor="#8A9FCD">
		<td colspan="12" class=textborder>
			<font color="#FFFFFF">Detailed Head Details</font>
		</td>
		<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td>
		</tr>
 	<tr >
		<td  class="clrborder" align=center>Major Head Code</td>
		<td  class="clrborder" align=center>Major Head Name</td>		
		<td  class="clrborder" align=center>Sub Major Head Code</td>
		<td  class="clrborder" align=center>Sub Major Head Name</td>		
		<td  class="clrborder" align=center>Minor Head Code</td>
		<td  class="clrborder" align=center>Minor Head Name</td>
		<td  class="clrborder" align=center>Group Head Code</td>
		<td  class="clrborder" align=center>Group Head Name</td>		
		<td  class="clrborder" align=center>Sub Head Code</td>
		<td  class="clrborder" align=center>Sub Head Name</td>		
		<td  class="clrborder" align=center>Detail Head Code</td>
		<td  class="clrborder" align=center>Detail Head Name</td>
		<td  class="clrborder" align=center>Action</td>
	</tr>
<logic:iterate id="detailheadlist" name="detailheads">
	<tr align="left" >
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="majorHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="majorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="submajorHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="submajorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="minorHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="minorHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="grpSubHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="grpSubHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="subHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="subHeadName" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="detailHeadCode" />
		</td>
		<td  class="bwborder" align=center>
			<bean:write name="detailheadlist" property="detailHeadName" />
		</td>
		<td class="bwborder" nowrap>
			<a href="./DetailHead.do?detailHeadCode=<bean:write name='detailheadlist' property='detailHeadCode' />&subHeadCode=<bean:write name='detailheadlist' property='subHeadCode' />&grpSubHeadCode=<bean:write name='detailheadlist' property='grpSubHeadCode' />&minorHeadCode=<bean:write name='detailheadlist' property='minorHeadCode' />&submajorHeadCode=<bean:write name='detailheadlist' property='submajorHeadCode' />&majorHeadCode=<bean:write name='detailheadlist' property='majorHeadCode' />&mode=get"><font color="#6600CC">Edit</font></a>
		</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
