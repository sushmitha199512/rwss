<% //if(circlecode!=null && circlecode.equals("00"))
if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && sourcecode.equals("00"))
	{
		%>
	
	<tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;
	  SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>

	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}
  else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && sourcecode.equals("00"))
  {%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>

	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00"))
  {%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>
    <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivisionName</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00"))
  {%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>
    <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivisionName</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}

else if( circlecode!=null && circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00"))
{
%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;
	  SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>
<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}else if( circlecode!=null && !circlecode.equals("00") && divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && !sourcecode.equals("00"))
{
%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>

	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && subdivisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00"))
  {%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>
    <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivisionName</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00"))
  {%><tr>
	  <td align="center" class="rptHeading" colspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>
	  &nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;</td>  
   </tr>
    <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivisionName</td>
		<td class=btext >Source Type</td>
		<td class=btext >Count</td>
	</tr>
		
<%}
%>
	
	
	
