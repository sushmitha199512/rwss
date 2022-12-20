<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<table width=770>
<tr><td align=right>
<html:link page="/SubDetailHead.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_SubDetailHead_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_SubDetailHead_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>
<table    width="100%"   bgcolor="#8A9FCD">
<tr>
<td class=myfontclr ><B><font color="#FFFFFF">SubDetailed Head Details</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="770" border=1 style="border-collapse:collapse" >
<tr >

		<td  class="clrborder" align=center >Major Head Code</td>
		<td  class="clrborder" align=center >Major Head Name</td>
		<td  class="clrborder" align=center >Sub Major Head Code</td>
		<td  class="clrborder" align=center >Sub Major Head Name</td>		
		<td  class="clrborder" align=center >Minor Head Code</td>
		<td  class="clrborder" align=center >Minor Head Name</td>
		<td  class="clrborder" align=center >Group Head Code</td>
		<td  class="clrborder" align=center >Group Head Name</td>		
		<td  class="clrborder" align=center >Sub Head Code</td>
		<td  class="clrborder" align=center >Sub Head Name</td>		
		<td  class="clrborder" align=center >Detail Head Code</td>
		<td  class="clrborder" align=center >Detail Head Name</td>		
		<td  class="clrborder" align=center >Sub Detail Head Code</td>
		<td  class="clrborder" align=center >Sub Detail Head Name</td>
		<td  class="clrborder" align=center>Action</td>

</tr>

<logic:iterate id="subdetailheadlist" name="subdetailheads">
<tr align="left" >
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="majorHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="majorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="submajorHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="submajorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="minorHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="minorHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="grpSubHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="grpSubHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="detailHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="detailHeadName" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subDetailHeadCode" />
</td>
<td  class="bwborder" align=center>
<bean:write name="subdetailheadlist" property="subDetailHeadName" />
</td>

<td nowrap>
<a href="./SubDetailHead.do?subDetailHeadCode=<bean:write name='subdetailheadlist' property='subDetailHeadCode' />&detailHeadCode=<bean:write name='subdetailheadlist' property='detailHeadCode' />&subHeadCode=<bean:write name='subdetailheadlist' property='subHeadCode' />&grpSubHeadCode=<bean:write name='subdetailheadlist' property='grpSubHeadCode' />&minorHeadCode=<bean:write name='subdetailheadlist' property='minorHeadCode' />&submajorHeadCode=<bean:write name='subdetailheadlist' property='submajorHeadCode' />&majorHeadCode=<bean:write name='subdetailheadlist' property='majorHeadCode' />&mode=get">
<font color="#6600CC">Edit</a>
</td>
</tr>
</logic:iterate>
</table>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
