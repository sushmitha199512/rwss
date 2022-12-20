<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Prajapatham Works Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL LABEL...COVERAGE");
%>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=17>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=17>District: <%=districtName%></td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Constituency</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY ALL SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=8>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=9>Constituency: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Constituency</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=8>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=9>Constituency: <%=constituencyName%></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Mandal</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
	{
		//System.out.println("IN DISTRICT CONSTITUENCY MANDAL ALL SELECTION LABEL...COVERAGE");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=6>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=5>Mandal: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Mandal</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") & rPanchayat.equals("-1"))
	{
		//System.out.println("DISTRICT CONSTITUENCY MANDAL SELETION LABEL...COVERAGE");
%>
	<tr align="center">
		<td align="center" class="rptValue" colspan=6>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=6>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Panchayat</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rPanchayat.equals("-1"))
	{
		//System.out.println("DISTRICT MANDAL CONSTITUENCY PANCHAYAT ALL SELECTION LABEL...COVERAGE");
%>
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=4>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=4>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=5>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: All</td>
	</tr>	
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Village</td>
		
	
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE ALL SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: All</td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Village</td>
		
	
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION LABEL...COVERAGE");
%>
	<tr  align="center">
		<td align="center" class="rptValue" colspan=3>District: <%=districtName%></td>
		<td align="center" class="rptValue" colspan=3>Constituency: <%=constituencyName%></td>
		<td align="center" class="rptValue" colspan=4>Mandal: <%=mandalName%></td>
		<td align="center" class="rptValue" colspan=4>Panchayat: <%=panchayatName%></td>
		<td align="center" class="rptValue" colspan=3>Village: <%=villageName%></td>
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>Habitation</td>
		
		
	</tr>
	<tr>
	<td class=btext colspan=5 align="center">Sanctioned At District (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Sanctioned At State (Amount In Rs. Lakhs)</td>
	<td class=btext colspan=5 align="center">Total (Amount In Rs. Lakhs)</td>
	
	</tr>
	
	<tr align = center>
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
		<td class=btext>No. Of Works </td>
		<td class=btext>Estimate Cost</td>
		<td class=btext>Expenditure</td>
		<td class=btext>No. Of Works Grounded</td>
		<td class=btext>No. Of Works Completed</td>
		
	</tr>
<%
	}
%>