<%


String q11=null,q22=null,q33=null,q44=null;
int Count=0;
int columntot=0;



                query= "select count(*),type_of_asset_name,b.type_of_asset_code from rws_asset_mast_tbl a,rws_asset_type_tbl b,rws_asset_scheme_tbl s where b.type_of_asset_code not in('10','11','12') and a.type_of_asset_code=b.type_of_asset_code and a.asset_code=s.asset_code group by b.type_of_asset_code,type_of_asset_name  order by b.type_of_asset_code";
             
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = stmt.executeQuery(query);
				rs.last();
				Count = rs.getRow();
				rs.beforeFirst();
				if(Count!=0)
				{
                j=0;
			
			%>
			<tr>
				<td class=btext>Sl.No </td>
				<td class=btext>Asset Name</td> 
				<td class=btext>Total</td> 
			</tr>
			<%
				while(rs.next())
			{
				tot=rs.getInt(1);
				columntot=columntot+tot;
				


				
	        %>			
				
     		<tr>
			  <td class="mystyle1"><%=++j%> </td>
			  
			  <td class="mystyle1"><a href="rws_district_rpt.jsp?asset_name=<%=rs.getString(3)%>&typeassetname=<%=rs.getString(2)%>"><%=rs.getString(2)%></td>
			  	<td class="mystyle1"><%=tot%></td>
	
		
				<% }
				%>
				<tr>
			  
			  <td></td>
			  <td class="btext">Total Assets </td>
			  <td class="btext"><%=columntot%></td>
			  </tr>
			<%
				
				}
		else {
	%>
	<tr class="btext"><td>There are no Records</td></tr>
	
	<%
		}



	%>
		


