<%
	/*stmt2=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt4=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt5=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt6=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt7=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt8=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt9=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt10=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	stmt11=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

	/*if(rDistrict != null && rDistrict.equals("00"))
		{
			// //System.out.println("IN DISTRICT ALL SELECTION RESULTS...");						
		}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
		{
			// //System.out.println("IN DISTRICT SELECTION RESULTS...");
		}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
		{
			// //System.out.println("IN MANDAL ALL SELECTION RESULTS...");
		}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00"))
		{
			//System.out.println("IN MANDAL SELECTION...");
		}

	query2="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='NC' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"'";
	rs2=stmt2.executeQuery(query2);			
	rs2.next();
	
	query3="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='PC1' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"' ";
	rs3=stmt3.executeQuery(query3);			
	rs3.next();
	
	query4="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='PC2' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"'";
	rs4=stmt4.executeQuery(query4);
	rs4.next();
	
	query5="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='PC3' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"'";
	rs5=stmt5.executeQuery(query5);			
	rs5.next();
	
	query6="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='PC4' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"'";
	rs6=stmt6.executeQuery(query6);			
	rs6.next();
	
	query7="SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS='FC' AND SUBSTR(HD.HAB_CODE,1,2)='"+rs.getString(1)+"'";
	rs7=stmt7.executeQuery(query7);
	rs7.next();*/
	
	
%>

	<tr bgcolor="#ffffff">
		<td class=rptValue><%=++pas%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		</tr>