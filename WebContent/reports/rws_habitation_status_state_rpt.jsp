<%	java.util.ArrayList state = (java.util.ArrayList)session.getAttribute("state");
	//java.util.ArrayList state1 = (java.util.ArrayList)session.getAttribute("state1");
	java.util.ArrayList statenames=(java.util.ArrayList)session.getAttribute("statenames");
//	if(state.size()!=0)// && state1.size()!=0);
	//{
	%>
	<table border="1" bgcolor="#DEE3E0" align=center bordercolor=black style="border-collapse:collapse" width="70%">
	
	<tr class="bwborder" bgcolor="white">
	<td class="btext">Coverage_Status</td>	
 	<td class="btext">No.of Habitations <%=request.getAttribute("prevYear") %></td>	
<!--<td class="btext">No.of Habitations 01-APR-2007</td>--> 
	</tr>

<%
for(int i=0;i<state.size();i++)
{
if(statenames.get(i).equals("TOTAL"))
{
%>
<tr>
<td class="btext"><b><%=statenames.get(i)%></b></FONT></td>
<td class="btext"><FONT color="blue"><b><%=state.get(i) %></b></FONT></td>
<%--<td class="btext"><FONT color="blue"><b><%=state1.get(i) %></b></FONT></td>--%> 
</tr>
<%}else
{ 
%>
		<tr>
		<td class="textborder"><FONT class=myfontclr1><b><%=statenames.get(i)%></FONT></td>
		<td class=mycborder1><FONT class=myfontclr1><%=state.get(i) %></FONT></td>
<%--<td class=mycborder1><FONT class=myfontclr1><%=state1.get(i) %></FONT></td>--%>
		</tr>
	
<%} 
}%>

</table>
<%//}%>