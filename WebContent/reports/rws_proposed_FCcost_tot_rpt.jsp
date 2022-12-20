<%	
String q11=null,q22=null,q33=null,q44=null;
int j=0;
Statement stmt1=null,stmt2=null;
int Count1=0,Count2=0;
dCode=String.valueOf(session.getAttribute("dCode"));
                //System.out.println("dCode********"+dCode); 
                 if(dCode.equals("51"))
				 {
                q11="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt >=0 and proposed_fc_est_amt <=1 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";

				 q22="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 1 and proposed_fc_est_amt <=10 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";
                  
				 q33="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 10 and proposed_fc_est_amt <=20 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";

                 }
				else if(!dCode.equals("51"))
				 {
				q11="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt >=0 and proposed_fc_est_amt <=1 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9)and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dCode+"'";

				 q22="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 1 and proposed_fc_est_amt <=10 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dCode+"'";
                  
				 q33="SELECT distinct count(HD.HAB_CODE) from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND coverage_status!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 10 and proposed_fc_est_amt <=20 AND substr(proposed_fc_year,3,4) >=substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dCode+"'";
                  }
				stmt =conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs = stmt.executeQuery(q11);
				rs.next();
				stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs1 = stmt1.executeQuery(q22);
				rs1.next();
				stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				rs2= stmt2.executeQuery(q33);
				rs2.next();	
				if(rs.getInt(1)!=0 || rs1.getInt(1)!=0 || rs2.getInt(1)!=0 )
				{%>
			    <tr>
				<td class="btext">S.No </td>
                <td class="btext">Estimate Cost<br>(Rs. In Lakhs)</td>
				<td class="btext">No of Habitations</td> 
			   </tr>
			  <%if(rs.getInt(1)!=0)
	           {
				
		 %>
			  <tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1">0 - 1 </td>
			   <td class="mystyle1"><a href="rss1.jsp?range=<%="0 - 1"%>"><%=rs.getString(1)%></a></td>
        </tr>
		<%
			   }
				
				if(rs1.getInt(1)!=0)
	           {
				
		 %>
			 <tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1">1 - 10 </td>
			   <td class="mystyle1"><a href="rss1.jsp?range=<%="1 - 10"%>"><%=rs1.getString(1)%></a></td>
        </tr>
		<%
			   }
				
				if(rs2.getInt(1)!=0)
	           {
					 %>
			 <tr>
			  <td class="mystyle1"><%=++j%> </td>
			  <td class="mystyle1">10 - 20 </td>
			   <td class="mystyle1"><a href="rss1.jsp?range=<%="10 - 20"%>"><%=rs2.getString(1)%></a></td>
        </tr>
		<%
				  }%>
		 <tr>
			<td colspan=2 class="btext">Total:</td>
			<td class="btext"><%=rs.getInt(1)+rs1.getInt(1)+rs2.getInt(1)%></td>
			</tr>
          
		 <%
				}
				else
				{%>
				<tr><td class="btext">There are no Records<td></tr>
				
			   <%
				}%>
