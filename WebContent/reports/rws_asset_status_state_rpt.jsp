<%  java.util.ArrayList state = (java.util.ArrayList)session.getAttribute("stateAssets");
	java.util.ArrayList state1 = (java.util.ArrayList)session.getAttribute("stateAssets1");
	String total=(String)session.getAttribute("totalAssets");
%>

 <table>
 <tr rowspan=20>
 <td></td>
 </tr>
 </table>

<table border="1" bgcolor="#DEE3E0" align=center bordercolor=black style="border-collapse:collapse" width="70%">
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="9">
			<font color="ffffff">Assets Status Report </font></td>
	</tr>
	<tr class="bwborder" bgcolor="white">
		<td class="btext">AssetType</td>	
	 	<td class="btext">No.of Assets</td>	
	</tr>

<%for(int i=0;i<state.size();i++){ %>
	<tr>
		<td class="textborder"><FONT class=myfontclr1><b><%=state.get(i)%></FONT></td>
		<td class=mycborder1><FONT class=myfontclr1><%=state1.get(i) %></FONT></td>
	</tr>
	
<%}%>
<tr><td class="btext">TOTAL</td><td class="btext"><FONT color="blue"><%=total %></FONT></td></tr>
</table>
