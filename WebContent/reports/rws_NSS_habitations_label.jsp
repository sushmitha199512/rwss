<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Quality Affected Coverage Status Report</font></td>	
	</tr>

<%if(distname==null)
{  
if(rDistrict != null && rDistrict.equals("00"))
{
%>	
	<tr  align="center">
		<td  class="rptValue" colspan=8><b>District:</b> All</td>		
	</tr>	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext colspan = 4>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
<%}
}
if(distname!=null)
{
%> 
	<tr bgcolor="#edf2f8" align="center">
		<td class="rptValue" colspan=11>District: <%=distname%></td>		
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Constituency Name</td>
		<td class=btext rowspan = 2>Mandal Name</td>
		<td class=btext rowspan = 2>Panchayat Name</td>
		<td class=btext rowspan = 2>Village Name</td>
		<td class=btext rowspan = 2>Habitation Name</td>
	</tr>
<%
	}
	if(distname!=null && conname!=null && manname==null && panname==null && vilname==null)
	{
%>
<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>District: <%=distname%></td>
		<td align="left" class="rptValue" colspan=2>Constituency: <%=conname%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Mandal</td>
		<td class=btext colspan = 1>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
	<%} 
	if(distname!=null && conname!=null && manname!=null && panname==null && vilname==null)
	{
		//System.out.println("IN DISTRICT ALL LABEL...PAN");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>District: <%=distname%></td>
		<td align="left" class="rptValue" colspan=2>Constituency: <%=conname%></td>
	</tr>
	<tr  bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>Mandal: <%=manname%></td>
		<td  class="rptValue" colspan=2></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Panchayat</td>		
		<td class=btext colspan = 2>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
<%
	}	
	if(distname!=null && conname!=null && manname!=null && panname!=null && vilname==null)
	{
		//System.out.println("IN DISTRICT SELECTION LABEL...VILL");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>District: <%=distname%></td>
		<td align="left" class="rptValue" colspan=2>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8">
		<td align="left" class="rptValue" colspan=2>Mandal: <%=manname%></td>
		<td align="left" class="rptValue" colspan=2>Panchayat: <%=panname%></td>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Village</td>
		<td class=btext colspan = 2>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
<%
	}	
	if(distname!=null && conname!=null && manname!=null && panname!=null && vilname!=null)
	{
		nic.watersoft.commons.Debug.println("IN DISTRICT ALL LABEL...HABI");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>District: <%=distname%></td>
		<td align="left" class="rptValue" colspan=2>Constituency: <%=conname%></td>
		</tr>
		<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>Mandal: <%=manname%></td>
		<td align="left" class="rptValue" colspan=2>Panchayat: <%=panname%></td>
		</tr>
		<tr bgcolor="#edf2f8" align="center">
		<td align="left" class="rptValue" colspan=2>Village: <%=vilname%></td>
		<td align="left" class="rptValue" colspan=2></td>
		</tr>
	</tr>	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>Habitation</td>	
		<td class=btext colspan = 2>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
<%
	}
	
	%>