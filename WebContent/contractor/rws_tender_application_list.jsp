<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table width="90%">
<tr><td align=right><html:link page="/TenderSchedule.do?mode=data">Back&nbsp;|&nbsp;</html:link>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
<html:link page="/rws_TenderScheduleA_rpt.jsp" target="_new">Print&nbsp;|&nbsp;</html:link>
<html:link page="/rws_TenderScheduleA_xls.jsp" target="_new">Excel</html:link>
</tr>
</table>

<table   width="90%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Tender Application Form</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>

</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >
<tr >
	
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Tender Id No.</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Application No.</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contractor Reg Number</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Cheque Number</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Cheque Date</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Bank Name</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Branch</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contractor Name</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Tender Amount</FONT>
	</td>
	
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contractor Address1</FONT>
	</td>
	 
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contractor Address2</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Contractor Address3</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">Action</FONT>
	</td>
	</tr>

 <logic:iterate id="tenderApplist" name="tenderAppList">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderApplist" property="tenderIdNo" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderApplist" property="tenderApplNo" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderApplist" property="contractorRegNo" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="tenderApplist" property="chequeNo" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="chequeDate" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="bank" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="branch" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="contractorName" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="tenderAmount" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="contractorAdd1" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="contractorAdd2" /></FONT>
</td>

<td  class=mycborder1 align="right">
<FONT class=myfontclr1><bean:write name="tenderApplist" property="contractorAdd3" /></FONT>
</td>

<td  class=mycborder1 align=center>
<a href="switch.do?prefix=/contractor&page=/TenderApplication.do?workId=<bean:write name='tenderApplist' property='tenderIdNo' />&mode=get"><font color="#6600CC">Edit&nbsp;|</font></a>&nbsp;&nbsp;
<a href="switch.do?prefix=/contractor&page=/TenderApplication.do?workId=<bean:write name='tenderApplist' property='tenderAppNo' />&mode=delete" onclick="return deleteRec()"><font color="#990066">Delete</font></a>
</td>
</tr>
</logic:iterate>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
