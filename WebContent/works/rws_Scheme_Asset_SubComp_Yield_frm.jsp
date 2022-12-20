<%@ include file="/reports/conn.jsp"%>
<tr>
	<td class="mycborder">
		<fieldset>
		<legend>Asset Additional Information</legend>
		<label>
		
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border=0 style="border-collapse:collapse;" width=940 align=center rules="none" >
	<tr>
    <td align=center colspan=4>
	&nbsp;
	</td></tr>
	<tr>
    <td   valign="top">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width=488 align=center>
		  <tr>
			<td class="textborder" colspan="3"><div align="center">Sub Components </div></td>
		  </tr>
		  <tr>
			<td class="textborder" width="43" align="center">S. No </td>
			<td class="textborder" width="277" align="center">Sub Component Name </td>
			<td class="textborder" width="62" align="center">Count</td>
		  </tr>
		 <%
		 	String assetTypeCodde = (String)request.getAttribute("assetTypeCodde");
			int sno = 1;
			String aa = (String)request.getAttribute("info");
			String[] aaa = aa.split("/");
		%>
		<%if(assetTypeCodde.equals("01") || assetTypeCodde.equals("02") || assetTypeCodde.equals("03") || assetTypeCodde.equals("09")){ %>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SUBSURFACE SOURCE</font></td>
			<td align="center"><font size=2><%=aaa[0]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SURFACE SOURCE</font></td>
			<td align="center"><font size=2><%=aaa[1]%></font></td>
		</tr>

		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>RAW WATER COLLECTION WELL</font></td>
			<td align="center"><font size=2><%=aaa[2]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SS TANK</font></td>
			<td align="center"><font size=2><%=aaa[3]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SS FILTER</font></td>
			<td align="center"><font size=2><%=aaa[4]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>RS FILTER</font></td>
			<td align="center"><font size=2><%=aaa[5]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SUMP</font></td>
			<td align="center"><font size=2><%=aaa[6]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>FOOT PATH BRIDGE</font></td>
			<td align="center"><font size=2><%=aaa[7]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>PUMP HOUSE</font></td>
			<td align="center"><font size=2><%=aaa[8]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>WATCHMAN QUARTER</font></td>
			<td align="center"><font size=2><%=aaa[9]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>CLEAR WATER COLLECTION WELL</font></td>
			<td align="center"><font size=2><%=aaa[10]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>MICRO FILTER</font></td>
			<td align="center"><font size=2><%=aaa[11]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>RO PLANTS</font></td>
			<td align="center"><font size=2><%=aaa[12]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>PUMPING MAIN</font></td>
			<td align="center"><font size=2><%=aaa[13]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>GRAVITY MAIN</font></td>
			<td align="center"><font size=2><%=aaa[14]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>DISTRIBUTION</font></td>
			<td align="center"><font size=2><%=aaa[15]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>OHSR</font></td>
			<td align="center"><font size=2><%=aaa[16]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>OHBR</font></td>
			<td align="center"><font size=2><%=aaa[17]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>GLSR</font></td>
			<td align="center"><font size=2><%=aaa[18]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>GLBR</font></td>
			<td align="center"><font size=2><%=aaa[19]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>BPT</font></td>
			<td align="center"><font size=2><%=aaa[20]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>CISTERNS</font></td>
			<td align="center"><font size=2><%=aaa[21]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>MISCELLANEOUS</font></td>
			<td align="center"><font size=2><%=aaa[22]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>CHLORINATION</font></td>
			<td align="center"><font size=2><%=aaa[23]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>O AND M</font></td>
			<td align="center"><font size=2><%=aaa[24]%></font></td>
		</tr>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>PUMPSETS</font></td>
			<td align="center"><font size=2><%=aaa[25]%></font></td>
		</tr>
		<tr>
			<td align="center" colspan=2><font size=2><b>Total Sub Components in this Asset</b></font></td>
			<td align="center"><font size=2><b><%=Integer.parseInt(aaa[0])+Integer.parseInt(aaa[1])+Integer.parseInt(aaa[2])+Integer.parseInt(aaa[3])+Integer.parseInt(aaa[4])+Integer.parseInt(aaa[5])+Integer.parseInt(aaa[6])+Integer.parseInt(aaa[7])+Integer.parseInt(aaa[8])+Integer.parseInt(aaa[9])+Integer.parseInt(aaa[10])+Integer.parseInt(aaa[11])+Integer.parseInt(aaa[12])+Integer.parseInt(aaa[13])+Integer.parseInt(aaa[14])+Integer.parseInt(aaa[15])+Integer.parseInt(aaa[16])+Integer.parseInt(aaa[17])+Integer.parseInt(aaa[18])+Integer.parseInt(aaa[19])+Integer.parseInt(aaa[20])+Integer.parseInt(aaa[21])+Integer.parseInt(aaa[22])+Integer.parseInt(aaa[23])+Integer.parseInt(aaa[24])+Integer.parseInt(aaa[25])%></b></font></td>
		</tr>
		<%}
		else if(assetTypeCodde.equals("04"))
		{
		%>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>BOREWELLS</font></td>
			<td align="center"><font size=2><%=aaa[0]%></font></td>
		</tr>
		<%
		}
		else if(assetTypeCodde.equals("05"))
		{
		%>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>SHALLOW HAND PUMPS</font></td>
			<td align="center"><font size=2><%=aaa[0]%></font></td>
		</tr>
		<%
		}
		else if(assetTypeCodde.equals("06"))
		{
		%>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>OPEN WELLS</font></td>
			<td align="center"><font size=2><%=aaa[0]%></font></td>
		</tr>
		<%
		}
		else if(assetTypeCodde.equals("07"))
		{
		%>
		<tr>
			<td align="center"><font size=2><%=sno++%></font></td>
			<td><font size=2>PONDS</font></td>
			<td align="center"><font size=2><%=aaa[0]%></font></td>
		</tr>
		<%
		}%>

		</table>
	</td>
    <td class="textborder">&nbsp;</td>
    <td class="textborder"  valign="top">
		<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width=428 align=center>
		  <tr>
			<td class="textborder" colspan="3"><div align="center">Habitations Linked with this Asset </div></td>
		  </tr>
		  <tr>
			<td class="textborder" align="center">S. No </td>
			<td class="textborder" align="center">Habitation Name </td>
			<td class="textborder" align="center">Yield</td>
		  </tr>
		  <%
			nic.watersoft.masters.PanchRaj panchRaj;
			sno = 1;
			ArrayList habs = (ArrayList)session.getAttribute("tempSelectedHabs");
			for(int i = 0;i<habs.size();i++)
			{
				panchRaj = (nic.watersoft.masters.PanchRaj)habs.get(i);
			%>
			<tr>
				<td align="center"><font size=2><%=sno++%></font></td>
				<td><font size=2><%=panchRaj.getHabName()%></font></td>
				<td align="center"><font size=2>&nbsp;</font></td>
			</tr>
			<%
			}
		  %>
		</table>
	</td>
  </tr>
</table>