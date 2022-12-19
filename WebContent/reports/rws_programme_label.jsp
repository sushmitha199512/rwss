<%
if(circlecode!=null && circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode==null && mandcode==null)
	{
	
		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>DISTRICT</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}
	else if(circlecode!=null && !circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode==null && mandcode==null)
	{
		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Status Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>DISTRICT</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}
	else if(circlecode!=null && circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode!=null && mandcode==null)
	{
		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=distname%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>MANDAL</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}
	else if(circlecode!=null && !circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode!=null && mandcode==null)
	{

		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>
	  &nbsp;&nbsp;</td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>MANDAL</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}
		
		else if(circlecode!=null && circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode!=null && mandcode!=null)
	{
		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=distname%>&nbsp;&nbsp;Mandal:<%=manname%>&nbsp;&nbsp;Program:<%=programname%></td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>PANCHAYAT</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}
else if(circlecode!=null && !circlecode.equals("00") && programcode!=null && programcode.equals("00") && distcode!=null && mandcode!=null)
	{

		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=15>Programme Wise-Works Report</font></td>	
	</tr>
	<tr align="center">
  <td align="center" class="rptHeading" colspan=15>&nbsp;&nbsp;&nbsp;&nbsp;District:<%=circlename%>&nbsp;&nbsp;Mandal:<%=manname%>&nbsp;&nbsp;Program:<%=programname%></td>
  </tr>
	<tr align=center>
<td class=btext>SLNO</b></td> 
<td class=btext>PANCHAYAT</b></td>
<td class=btext>TOTAL</b></td>
<td class=btext>ARWS</b></td>       
<td class=btext>20%ARWS</b></td>
<td class=btext>PMGY</b></td>       
<td class=btext>NABARD</b></td>
<td class=btext>MNP</b></td>       
<td class=btext>ARWSP</b></td> 
<td class=btext>INDIRAKRANTI<BR>PADAM</b></td>       
<td class=btext>NEW CPWS</b></td>
<td class=btext>NEWPROGRAMME</b></td>
<td class=btext>OTHERS</b></td>
</TR>
<%}%>
		
		