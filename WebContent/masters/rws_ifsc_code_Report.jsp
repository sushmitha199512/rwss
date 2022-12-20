<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>




<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
</caption>
<tr bgcolor="#8A9FCD"><td class=myfontclr colspan="10"><B><font color="#FFFFFF">IFSC Code Entry Details</font></B></td>
</tr>

<tr >
<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">S.No</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Bank Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Branch Name</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">IFSC Code</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">MICR C0de</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Contact Number</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">Address</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">District</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><font color="#993366">City</FONT>
	</td>
	
	
	
	</tr>
<logic:present name="ifscdetails">
<%int i=1;%>
<logic:iterate id="ifsclist" name="ifscdetails">
<tr align="left" >
<td  class=mycborder1>
<FONT class=myfontclr1><%=i++%></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="bankName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="branchName" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="ifscCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="micrCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="contactNumber" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="address" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="district" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="ifsclist" property="city" /></FONT>
</td>


 
</tr>
</logic:iterate>
</logic:present>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
