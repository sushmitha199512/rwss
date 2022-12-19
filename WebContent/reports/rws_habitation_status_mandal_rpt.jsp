<%	if(request.getAttribute("currentYear")!=null)
{
 %>

<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=81% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr class="bwborder" bgcolor="white"><td class="btext"  colspan=11><b>YEAR:</b> 01-APR-<%=request.getAttribute("currentYear")%></td></tr>

	<tr class="bwborder" bgcolor="white">	
	<td class="btext">S.No.</td>	
	<td class="btext">District Name</td>	
	<td class="btext">MCode</td>	
	<td class="btext">Mandal Name</td>	
	<td class="btext">FC</td>	
	<td class="btext">PC1</td>	
	<td class="btext">PC2</td>	
	<td class="btext">PC3</td>
	<td class="btext">PC4</td>
	<td class="btext">NC</td>
	<td class="btext">NSS</td>
	<td class="btext">TOTAL</td>
	</tr>
<%}%>
<% int i=1; %>
<logic:iterate  id="dists" name="records1">

<tr>
<td class=mycborder1><FONT class=myfontclr1><%=i++%></FONT></td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="distname"/></FONT><BR></td>

<td class=mycborder1 ><FONT class=myfontclr1><bean:write name="dists" property="mandcode"/></FONT></td>

<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="mandname"/></FONT><BR></td>


<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="FC"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC1"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC2"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC3"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC4"/></FONT><BR></td>

<td  class=mycborder1 align="right"  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="NC"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="NSS"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="total"/></FONT><BR></td>

</tr>

</logic:iterate>

<tr class="bwborder" bgcolor="white">
<td class=btext colspan=4 align="right">TOTAL</td>
<%java.util.ArrayList total=(java.util.ArrayList)session.getAttribute("totalsM"); 
int i1=0;
for(i1=0;i1<total.size();i1++)
{
%>

<td class="btext" align="right"><%=total.get(i1)%></font><br></td>


<%}%></tr>


<%--
<tr class="bwborder" bgcolor="white"><td class="btext" colspan=11><b>YEAR:</b> <%=request.getAttribute("prevYear")%></td></tr>
<%int i1=1; %>
<logic:iterate  id="dists" name="records1">

<tr>
<td class=mycborder1>
<FONT class=myfontclr1><%=i1++ %></FONT></td>

<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="distname1"/></FONT></td>

<td class=mycborder1 >
<FONT class=myfontclr1><bean:write name="dists" property="mandcode"/></FONT></td>

<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="mandname"/></FONT></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="FC1"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC11"/></FONT><BR></td>

<td  class=mycborder1align="right"  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC21"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC31"/></FONT><BR></td>

<td  class=mycborder1 align="right"  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="PC41"/></FONT><BR></td>

<td  class=mycborder1 align="right"  nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="NC1"/></FONT><BR></td>

<td  class=mycborder1 align="right" nowrap>
<FONT class=myfontclr1><bean:write name="dists" property="NSS1"/></FONT><BR></td>
</tr>

</logic:iterate>
--%>
</table>


