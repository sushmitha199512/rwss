<%	
String q11=null,q22=null,q33=null,q44=null;
dCode=String.valueOf(session.getAttribute("dCode"));
                //System.out.println("dCode********"+dCode); //mCode=String.valueOf(session.getAttribute("mCode")); 
               // pCode=String.valueOf(session.getAttribute("pCode"));
 /*mCode=String.valueOf(session.getAttribute("mCode")); 
 pCode=String.valueOf(session.getAttribute("pCode")); */
                 if(dCode.equals("51"))
				 {
                query= "SELECT distinct proposed_fc_year,count(hab_code) from RWS_HABITATION_DIRECTORY_TBL where  (coverage_status!='FC' AND proposed_fc_year is not null and  upper(proposed_fc_year)<>'NULL'  and  substr(proposed_fc_year,3,4)>=substr(sysdate,8,9))  group by proposed_fc_year";
                 }
				else if(!dCode.equals("51"))
				 {
                   query="SELECT distinct proposed_fc_year,count(hd.hab_code) from  RWS_HABITATION_DIRECTORY_TBL HD where  coverage_status!='FC' AND proposed_fc_year is not null and upper(proposed_fc_year) <>'NULL'  and substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and SUBSTR(HD.HAB_CODE,1,2)='"+dCode+"' group by proposed_fc_year";
				 }
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = stmt.executeQuery(query);
				rs.last();
				Count = rs.getRow();
				//System.out.println("Count is"+Count);
				rs.beforeFirst();
				if(Count!=0)
				{
                j=0;
			//System.out.println("in total"+tot);
			%>
			<tr>
				<td class="btext">S.No </td>
				<td class="btext">Proposed FC Year</td> 
				<td class="btext">No of Habitations</td> 
			</tr>
			<% while(rs.next())
			{
				tot=tot+rs.getInt(2);
				
	        %>			
				
		<tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1"><%=rs.getString(1)%></td>
			  <% if(dCode.equals("51"))
				{ %>
			  <td class="mystyle1"><a href="rwss1.jsp?year=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td>
			  <% }
		     else {%>
             <td class="mystyle1"><a href="rwss1.jsp?dcode=<%=dCode%>&year=<%=rs.getString(1)%>"><%=rs.getString(2)%></a></td>
            <% } %>
		     
			
        </tr>
		<%}%>
		 <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=tot%></td>
			</tr>
				<% }
		else {
	%>
	<tr class="btext"><td>There are no Records</td></tr>
	
	<%}%>
		


