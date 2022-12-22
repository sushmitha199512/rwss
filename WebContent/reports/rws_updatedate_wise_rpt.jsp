<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%

	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict=null;
	String prevcode=null;
	rDistrict = String.valueOf(session.getAttribute("districtCode"));
	//System.out.println("rDistrict = " +rDistrict);
	String districtName = String.valueOf(session.getAttribute("districtName"));
	int pass = Integer.parseInt(request.getParameter("pass"));
	String query=null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null, query9 = null, query10 = null, query11 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, rs8 = null, rs9 = null, rs10 = null, rs11 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, stmt7 = null, stmt8 = null, stmt9 = null, stmt10 = null, stmt11 = null ;
	int slno = 0,NOP=0;
	int Count = 0, i = 0,Count1=0;
	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0,nodatatotal=0,subfctotal=0,subpc1total=0,subpc2total=0,subpc3total=0,subpc4total=0,subnctotal=0,subnsstotal=0,subuitotal=0,NOP1=0;
try
{%>
<html>
<head>

</head>
<body bgcolor="#edf2f8">

<form name=f1 action="./rws_hab_update_rpt1.jsp">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_hab_update_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<!--<td class="bwborder"><a href="./rws_planning_rpt_format2_prnt_rpt.jsp?rDistrict=<%=rDistrict%>" target="_new">Print |</a></td>
			    <td class="bwborder"><a href="./rws_planning_rpt_format1_xls_rpt.jsp?rDistrict=<%=rDistrict
	            %>" target="_new">Excel</a></td>-->
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=12>District-Habitation-Report</font></td>	
	</tr>
<% 
	if(rDistrict != null && rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: All</td>
		</tr>	
<%
		}
		if(!rDistrict.equals("00") && !rDistrict.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=14>District: <%=districtName%></font></td>	
	</tr>	

	<%
		}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan=2>Slno</td>
		<td class=btext rowspan=2>District</td>	
		<td class=btext rowspan=2>Update-Month</td>
		<td class=btext rowspan=2>No Of Habitations<br>Updated</td>
		<td class=btext colspan=9>Coverage Status</td>
	<tr>
		<td class="btext">FC </td>
		<td class="btext">PC1 </td>
		<td class="btext">PC2 </td>
		<td class="btext">PC3</td>
		<td class="btext">PC4</td>
		<td class="btext">NC</td>
		<td class="btext">NSS</td>
		<td class="btext">UI</td>
		
	</tr>
	 </tr>
<%	
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT distinct d.dcode,D.DNAME,count(PR.PANCH_NAME), substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11) as update_date1,substr(to_char(hd.update_date,'dd-mm-yyyy'),4,10) AS update_date from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE group by d.dcode,d.dname,substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11),substr(to_char(hd.update_date,'dd-mm-yyyy'),4,10)";

		String qq="SELECT distinct d.dcode from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE group by d.dcode";



       stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//query1 = "SELECT  COUNT(PR.PANCH_NAME)From RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND D.DCODE='14' AND PR.PANCH_CODE = HD.HAB_CODE and update_date='04-oct-06';
	}
	if(!rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        query="SELECT distinct d.dcode,D.DNAME,count(PR.PANCH_NAME), substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11) as update_date1,substr(to_char(hd.update_date,'dd-mm-yyyy'),4,10) AS update_date from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and d.dcode='"+rDistrict+"'group by d.dcode,d.dname,substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11),substr(to_char(hd.update_date,'dd-mm-yyyy'),4,10)";


		/*query = " SELECT DISTINCT D.DCODE, D.DNAME,PR.PANCH_NAME,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY')FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND  SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' and  PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE ";

		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//query1 = " SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND PR.PANCH_CODE = HD.HAB_CODE ";*/
		
	}
	//System.out.println("Query is"+query);
    rs = stmt.executeQuery(query);
    rs.last();
    Count = rs.getRow();
	//System.out.println("Count is"+Count);
	rs.beforeFirst();
	String distcode[]=new String[Count];
	String datecode[]=new String[Count];
	/*//System.out.println("Query is"+qq);
    rs11 = stmt.executeQuery(qq);
    rs11.last();
    Count1 = rs11.getRow();
	//System.out.println("Count is"+Count1);
	rs11.beforeFirst();
	String dcode[]=new String[Count1];*/

	 /*while(rs9.next())
	{
		 int m=0;
		 String s="SELECT distinct sum(count(pr.panch_name)) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='12' group by pr.panch_name";
		 dcode[m]=rs9.getString(1);*/

	 
	if(request.getParameter("pass") !=  null) {
	pass = Integer.parseInt(request.getParameter("pass"));
	 ////System.out.println("start values  is "+start);
		}
		
		if(Count!=0)
	    {
		for(int j = pass; j < Count ; j++)
		
		{	
				rs.absolute(j+1);
			
					
		distcode[j]=rs.getString(1);
		datecode[j]=rs.getString(4);

		String s="SELECT distinct sum(count(pr.panch_name)) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' group by pr.panch_name";
		
		String qq="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='FC' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'";
		//System.out.println("qq.........."+qq);

		String q1="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='PC1' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'";

        //System.out.println("q1.........."+q1);

		String q2="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='PC2' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'" ;
          //System.out.println("q2.........."+q2);

		String q3="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='PC3' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'" ;
         //System.out.println("q3.........."+q3);
		String q4="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='PC4' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'";
        
		 //System.out.println("q4.........."+q4);
		String q5="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='NC' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'";
 	
	 //System.out.println("q5.........."+q5);
		String q6="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='NSS' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'";
 //System.out.println("q6.........."+q6);
		String q77="SELECT distinct COUNT(HD.COVERAGE_STATUS) from  RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and  PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2) ='"+distcode[j]+"' and HD.COVERAGE_STATUS='UI' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+datecode[j]+"'" ;

		stmt2 = conn.createStatement();
		rs6 = stmt2.executeQuery(qq);
	
		stmt3 = conn.createStatement();
		rs1 = stmt3.executeQuery(q1);
		
		stmt4 = conn.createStatement();
		rs2 = stmt4.executeQuery(q2);
		
		stmt5 = conn.createStatement();
		rs3= stmt5.executeQuery(q3);
	
		stmt6 = conn.createStatement();
		rs4 = stmt6.executeQuery(q4);
	
		stmt7 = conn.createStatement();
		rs5= stmt7.executeQuery(q5);
	
		stmt8 = conn.createStatement();
		rs7= stmt8.executeQuery(q6);
		
		stmt9 = conn.createStatement();
		rs8= stmt9.executeQuery(q77);

        stmt11 = conn.createStatement();
		rs10= stmt11.executeQuery(s);
        
		
       
		rs6.next();
		rs1.next();
		rs2.next();
		rs3.next();
		rs4.next();
		rs5.next();
		rs7.next();
		rs8.next();
		rs10.next();
		
	%>	
	     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
        <td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs6.getString(1)%></td>
        <td class=rptValue><%=rs1.getString(1)%></td>
		<td class=rptValue><%=rs2.getString(1)%></td>
		<td class=rptValue><%=rs3.getString(1)%></td>
		<td class=rptValue><%=rs4.getString(1)%></td>
		<td class=rptValue><%=rs5.getString(1)%></td>
		<td class=rptValue><%=rs7.getString(1)%></td>
		<td class=rptValue><%=rs8.getString(1)%></td>
		</tr>
		<% 
		    NOP=NOP+rs.getInt(3);
		    fcgtotal =  fcgtotal + rs6.getInt(1);
			pc1gtotal = pc1gtotal + rs1.getInt(1);	
			pc2gtotal = pc2gtotal + rs2.getInt(1);	
			pc3gtotal = pc3gtotal + rs3.getInt(1);	
			pc4gtotal = pc4gtotal + rs4.getInt(1);	
			ncgtotal = ncgtotal + rs5.getInt(1);	
			nssgtotal = nssgtotal + rs7.getInt(1);	
			uitotal = uitotal + rs8.getInt(1);
	
			}
		
		%>
	    <tr>
		<td class="btext" colspan=3>GRANDTOTAL</td>
		<td class="rptValue"><a href="./rws_hab_update_rpt.jsp?districtCode=<%=rDistrict%>&dName=<%=districtName%>"><%=NOP%></a>
        </td>
		<td class="btext"><%=fcgtotal%></td>
		<td class="btext"><%=pc1gtotal%></td>
		<td class="btext"><%=pc2gtotal%></td>
		<td class="btext"><%=pc3gtotal%></td>
		<td class="btext"><%=pc4gtotal%></td>
		<td class="btext"><%=ncgtotal%></td>
		<td class="btext"><%=nssgtotal%></td>
		<td class="btext"><%=uitotal%></td>
       
	   </tr>
	   <%
		
			
		}
		//}
	else
	{%>
	  <td align="center" class="rptHeading" colspan=12>There are no Records</td>
	  <%
	}

	rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();
	}
catch(Exception e)
{
	//System.out.println("THE ERROR IN REPORT = " + e);
}
	
%>
</table>
<input type="hidden" name="pass"> 

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
<%
	conn.close();
%>