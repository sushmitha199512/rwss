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

<form name=f1 action="./rws_hab_update_report.jsp">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_hab_update_frm1.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<td class="bwborder"><a href="./rws_excel3_prnt.jsp?rDistrict=<%=rDistrict%>" target="_new">Print |</a></td>
			    <td class="bwborder"><a href="./rws_excel1.jsp?rDistrict=<%=rDistrict
	            %>" target="_new">Excel</a></td>
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
		<td class=btext rowspan=2>No Of Habitations<br>NotUpdated</td>
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
		
		query = "SELECT distinct d.dcode,D.DNAME,NVL(to_char(hd.update_date,'dd-mon-yyyy'),'-') as update_date,count(PR.PANCH_NAME),SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE group by d.dcode,d.dname,to_char(hd.update_date,'dd-mon-yyyy')";

		/*String qq="SELECT distinct d.dcode from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE group by d.dcode";*/



       stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//query1 = "SELECT  COUNT(PR.PANCH_NAME)From RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND D.DCODE='14' AND PR.PANCH_CODE = HD.HAB_CODE and update_date='04-oct-06';
	}
	if(!rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT SELECTION...");
		//stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        query="SELECT distinct d.dcode,D.DNAME,NVL(to_char(hd.update_date,'dd-mon-yyyy'),'-') as  update_date, count(PR.PANCH_NAME),SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and d.dcode='"+rDistrict+"' group by d.dcode,d.dname,to_char(hd.update_date,'dd-mon-yyyy')";
		
		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

		/*query = " SELECT DISTINCT D.DCODE, D.DNAME,PR.PANCH_NAME,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY')FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND  SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' and  PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE ";stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		//query1 = " SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND PR.PANCH_CODE = HD.HAB_CODE ";*/
		
	}
	rs=stmt1.executeQuery(query);
	rs.last();
    Count = rs.getRow();
	//System.out.println("Count is"+Count);
	rs.beforeFirst();
	if(Count!=0)
	{
	while(rs.next())
	{
	%>	
	     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
        <td class=rptValue><%=rs.getString(3)%></td>
		
		<% if(rDistrict.equals("00"))
		{%>
		<td class="rptValue"><a href="./rws_hab_update_report.jsp?dcode=<%=rs.getString(1)%>&dName=<%=rs.getString(2)%>
		&updateDate=null"><%=rs.getString(4)%></a></td>
		<%
		}
		else
			{%>
             <td class="rptValue"><%=rs.getString(4)%></td>
			 <%
			}
		%>
         <td class="rptValue"><%=rs.getString(5)%></td>			
		 <td class="rptValue"><%=rs.getString(6)%></td>
         <td class="rptValue"><%=rs.getString(7)%></td>
		<td class="rptValue"><%=rs.getString(8)%></td>			
		<td class="rptValue"><%=rs.getString(9)%></td>
        <td class="rptValue"><%=rs.getString(10)%></td>
		<td class="rptValue"><%=rs.getString(11)%></td>			
		<td class="rptValue"><%=rs.getString(12)%></td>
		</tr>
         <% 
		    NOP=NOP+rs.getInt(4);
		    fcgtotal =  fcgtotal + rs.getInt(5);
			pc1gtotal = pc1gtotal + rs.getInt(6);	
			pc2gtotal = pc2gtotal + rs.getInt(7);	
			pc3gtotal = pc3gtotal + rs.getInt(8);	
			pc4gtotal = pc4gtotal + rs.getInt(9);
			ncgtotal = ncgtotal + rs.getInt(10);	
			nssgtotal = nssgtotal + rs.getInt(11);	
			uitotal = uitotal + rs.getInt(12);
	
			}
		
		%>
	    <tr>
		<td class="btext" colspan=3>GRANDTOTAL</td>
		<td class="rptValue"><a href="./rws_hab_update_report.jsp?districtCode=<%=rDistrict%>&districtName=<%=districtName%>"><%=NOP%></a>
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

	/*rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();*/
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