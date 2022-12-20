<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			// //System.out.println("IN DISTRICT ALL SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
		{
			// //System.out.println("IN DISTRICT SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
		{
			// //System.out.println("IN MANDAL ALL SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
		{
			// //System.out.println("IN MANDAL SELECTION...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
		{
			// //System.out.println("IN PANCHAYAT ALL SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
		{
			// //System.out.println("IN PANCHAYAT SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
		{
			// //System.out.println("IN VILLAGE ALL SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && rHabitation.equals("-1"))
		{
			//System.out.println("IN VILLAGE SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && rHabitation.equals("00"))
		{
			//System.out.println("IN HABITATION ALL SELECTION RESULTS...");
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && !rHabitation.equals("00"))
		{
			//System.out.println("IN HABITATION SELECTION RESULTS...");
		}
%>
	<tr bgcolor="#ffffff">
		<td class=rptValue nowrap><%=++pas%></td>			
		<td class=rptValue nowrap><%=rs.getString(1)%></td>
		<td class=rptValue nowrap><%=rs.getString(2)%></td>
		<td class=rptValue nowrap><%=rs.getString(3)%></td>
		<td class=rptValue nowrap><%=rs.getString(4)%></td>
		<td class=rptValue nowrap><%=rs.getString(5)%></td>
		<td class=rptValue nowrap><%=rs.getString(6)%></td>		
		<td class=rptValue nowrap>--</td>
		<td class=rptValue nowrap><%=rs.getString(9)%></td>
		<td class=rptValue nowrap><%=rs.getString(8)%></td>
		<td class=rptValue nowrap><%=rs.getString(9)%></td>
		<td class=rptValue nowrap><%=rs.getString(10)%></td>
		<td class=rptValue nowrap><%=rs.getString(11)%></td>
		<td class=rptValue nowrap><%=rs.getString(12)%></td>
		<td class=rptValue nowrap><%=rs.getString(13)%></td>
		<td class=rptValue nowrap><%=rs.getString(14)%></td>
		<td class=rptValue align=right><%=rs.getInt(15)+rs.getInt(16)%></td>
		<td class=rptValue align=right><%=rs.getInt(15)%></td>		
		<td class=rptValue align=right><%=rs.getInt(16)%></td>
		<td class=rptValue nowrap><%=rs.getString(17)%></td>
		<td class=rptValue align=right><%=rs.getInt(18)%></td>
		<td class=rptValue align=right>--</td>
		<td class=rptValue align=right>--</td>
		<td class=rptValue align=right>--</td>
	</tr>