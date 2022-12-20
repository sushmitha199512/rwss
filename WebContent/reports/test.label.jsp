<% //if(circlecode!=null && circlecode.equals("00"))
if(circlecode!=null && circlecode.equals("00") && labcode!=null &&  labcode.equals("00")&& sourcecode!=null && sourcecode.equals("00")&& yearcode!=null && yearcode.equals("00"))
	{
		%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=14>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>

	
	<tr align=center  align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
else if(circlecode!=null && circlecode.equals("00") && labcode!=null && !labcode.equals("00")&&   sourcecode!=null && sourcecode.equals("00") && yearcode!=null && yearcode.equals("00"))
{%>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=14>&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	<tr align=center  align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if( circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null &&  labcode.equals("00") &&  yearcode!=null &&  yearcode.equals("00"))
 { %>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=14>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && sourcecode.equals("00") && labcode!=null &&  labcode.equals("00") &&  yearcode!=null &&  yearcode.equals("00"))
		    {
%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=14>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null &&  labcode.equals("00") && yearcode!=null &&  yearcode.equals("00"))
		    {
%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=14>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=14>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
		    {  
%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
	    <td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		
		</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") &&  subdivisioncode!=null && subdivisioncode.equals("-1") &&  sourcecode!=null && sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{       

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
   <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") &&  subdivisioncode!=null && !subdivisioncode.equals("-1") &&  sourcecode!=null && sourcecode.equals("00") && labcode!=null &&  labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{    

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
   <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		
		</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1")&& sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{    
%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
   <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{    

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
   <tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{  

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
        <td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && subdivisioncode.equals("-1")&& sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{  

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	 <tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>
	  &nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr> 
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
        <td class=btext >Assigned On</td>
		
		</tr>
		
<%}
 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && divisioncode.equals("-1")&& sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{ 

%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >TestName</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	 else if(circlecode!=null && !circlecode.equals("00")&& divisioncode!=null && !divisioncode.equals("-1")&& subdivisioncode!=null && subdivisioncode.equals("-1")&& sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	 {
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >TestName</td>
        <td class=btext >Test<br>Periodicity</td>
        
		</tr>
		<%}
	
	else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	 {
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	 {
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=11>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
      
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && divisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >TestName</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
        
		</tr>
		<%}
	else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	{%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >TestName</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && subdivisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
	{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
        <td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && !divisioncode.equals("-1") && subdivisioncode!=null && !subdivisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
        
		</tr>
		<%}
	else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=12>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
        <td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
       
		</tr>
		<%}
	else if(circlecode!=null && circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Circle Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
       
		</tr>
	<%}
	else if(circlecode!=null && !circlecode.equals("00") && circlecode!=null && !circlecode.equals("00") && circlecode!=null && !circlecode.equals("00") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
	{%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;SubDivision:<%=subdivisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >SubDivision Name</td>
		<td class=btext >Source Id</td>
	    <td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>Collection Date</td>
		<td class=btext >Location</td>
		<td class=btext >TestName</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
       
		</tr>
	<%}
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && divisioncode.equals("-1") && sourcecode!=null && sourcecode.equals("00") && labcode!=null && !labcode.equals("00") && yearcode!=null && yearcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Source Type</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>CollectionDate</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		<td class=btext >Assigned On</td>
       
		</tr>
	<% }
	else if(circlecode!=null && !circlecode.equals("00") && divisioncode!=null && divisioncode.equals("-1") && sourcecode!=null && !sourcecode.equals("00") && labcode!=null && labcode.equals("00") && yearcode!=null && !yearcode.equals("00"))
			{
	
	%><tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=13>Lab Status Report</font></td>	
	</tr>
	<tr>
	  <td align="center" class="rptHeading" colspan=13>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle:<%=circlename%>&nbsp;&nbsp;Division:<%=divisionname%>&nbsp;&nbsp;Lab:<%=labname%>&nbsp;&nbsp;SourceType:<%=sourcename%>&nbsp;&nbsp;AssignedDate:<%=year%></td>  
   </tr>
	
	<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Division Name</td>
		<td class=btext >Source Id</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample<br>CollectionDate</td>
        <td class=btext >Lab Name</td>
		<td class=btext >Location</td>
		<td class=btext >Test Name</td>
        <td class=btext >Test<br>Periodicity</td>
		
		</tr>
	<% }%>
	
	
	
