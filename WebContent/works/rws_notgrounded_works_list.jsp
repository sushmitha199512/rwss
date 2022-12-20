<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<table>
<tr><td><html:link page="/NotGrounded.do?mode=data">Back</html:link></td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  border=1 style="border-collapse:collapse" >
<tr><td align=right colspan=12><font color="red">*</font><font color="blue"><b>Amount In Lakhs</b></font></td>
</tr>
<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366"><font color="#993366">WorkId</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Work Name</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Programme</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sub Programme Name</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Sancation Amount</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Part-A Amount</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Part-A Clearance</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Part-A Clearance Date</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">DPR Status</FONT>
	</td>
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Dpr Completion Date</FONT>
	</td>
-


<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Remarks</FONT>
	</td>
	
	</tr>
<logic:present name="reqWorks">
<%int i=1;%>
<logic:iterate id="reqWorks" name="reqWorks">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="reqWorks" property="workId" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="reqWorks" property="workName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="programmeName" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="subProgrammeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="sanctionAmount" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="partAAmount" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="partAClearnce" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="partAClearnceDate" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="dprStatus" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="dprCompDate" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="reqWorks" property="remarks" /></FONT>
</td>



<td  class=mycborder1 align=center>

</td> 


</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
