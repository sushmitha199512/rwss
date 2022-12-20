<% //if(circlecode!=null && circlecode.equals("00"))
if(circlecode!=null && circlecode.equals("00") && programcode!=null && programcode.equals("00"))
	{
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>&nbsp;
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>Circle Name</td>
		<td class=btext>Program</td>
	    <td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
		
<%}
	else if(circlecode!=null && circlecode.equals("00") && programcode!=null && !programcode.equals("00"))
			{ %>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=10>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Program:<%=programname%>&nbsp;
	  </td>  
   </tr>
	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>Circle Name</td>
		<td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
<%}
  else if( circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& programcode!=null &&  programcode.equals("00"))
			{%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>Division Name</td>
		<td class=btext>Program</td>
	    <td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") && programcode!=null &&  programcode.equals("00"))
			{

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>SubDivision Name</td>
		<td class=btext>Program</td>
	    <td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
	<%}
	else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") && programcode!=null &&  !programcode.equals("00"))
			{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=10>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>SubDivision Name</td>
		<td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
	<%}
	 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1") &&  programcode!=null &&  !programcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=10>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>Division Name</td>
		<td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
	<%}
	else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") &&  programcode!=null &&  !programcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=10>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>SubDivision Name</td>
		<td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
	<%}
	 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") &&  programcode!=null &&  programcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>EOAT-WORK Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Program:<%=programname%>
	  </td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext>SLNo</td>
		<td class=btext>SubDivision Name</td>
		<td class=btext>Program</td>
		<td class=btext>Work Id</td>
		<td class=btext>Work Name</td>
		<td class=btext>Value Of<BR>Work Done</td>
		<td class=btext>Cost Of Work</td>
		<td class=btext>Value Of Work<br>Beyond Agree</td>
		<td class=btext>Value Of Work<br>To Be Done</td>
		<!-- <td class=btext>Date Of<br>Completion</td> -->
		<td class=btext>Eoat Order No</td>
		</tr>
	<%}%>
	
	
	
				
				
	
	
	
