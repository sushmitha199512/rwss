<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>

<%     
	   Statement stmt1=null,stmt2=null;
       ResultSet rs1=null,rs3=null;
	   int sno=0;
		String rDistrict=null, rMandal=null, rPanchayat=null, rVillage=null, rHabitation=null,q1=null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rHabitation = request.getParameter("habitation");	
	String districtName = String.valueOf(session.getAttribute("districtName"));
	String mandalName = String.valueOf(session.getAttribute("mandalName"));
	String panchayatName = String.valueOf(session.getAttribute("panchayatName"));
	String villageName = String.valueOf(session.getAttribute("villageName"));
	String habitationName = String.valueOf(session.getAttribute("habitationName"));
	   
%>
<html>
<head>
<script>
window.history.forward(1);
</script>
<title> WaterSoft </title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body bgcolor="#edf2f8">
<%
   try{
	   String qry=null;

	
	if(rDistrict!=null && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
		

		 qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
	}
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		
		  qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
	}
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		
		 qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' and substr(b.hab_code,6,2)='"+rMandal+"' order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
		  	}
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
	{
        

		 qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' and substr(b.hab_code,6,2)='"+rMandal+"' order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
         
		  
      }
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		

		qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' and substr(b.hab_code,6,2)='"+rMandal+"' and substr(b.hab_code,13,2)='"+rPanchayat+"'  order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
		
	}
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		

       qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' and substr(b.hab_code,6,2)='"+rMandal+"' and substr(b.hab_code,13,2)='"+rPanchayat+"'  order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
		
	}
	if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		
		qry="select distinct c.dcode,c.dname,a.acode,d.mcode,d.mname,v.vcode,v.vname,b.hab_code,a.hname,pa.pcode,pa.pname,a.parlc,a.prhab,b.coverage_status,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU,b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(b.hab_code,15,2) from RWS_HABMAST_TBL a,RWS_HABITATION_DIRECTORY_TBL b,rws_district_tbl c,rws_mandal_tbl d,rws_panchayat_tbl pa,rws_village_tbl v where a.prhab=b.hab_code and substr(b.hab_code,1,2)=c.dcode and (substr(b.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode)and(substr(b.hab_code,1,2)=pa.dcode and substr(b.hab_code,6,2)=pa.mcode and substr(b.hab_code,13,2)=pa.pcode) and (substr(b.hab_code,1,2)=v.dcode and substr(b.hab_code,6,2)=v.mcode and substr(b.hab_code,13,2)=v.pcode and substr(b.hab_code,8,3)=v.vcode)  and substr(b.hab_code,1,2)='"+rDistrict+"' and substr(b.hab_code,6,2)='"+rMandal+"' and substr(b.hab_code,13,2)='"+rPanchayat+"' and substr(b.hab_code,8,3)= '"+rVillage+"' order by c.dcode,d.mcode,v.vcode,pa.pcode,a.acode";
	}
	
	 stmt=conn.createStatement();
	 stmt1=conn.createStatement();
	 stmt2=conn.createStatement();
	 rs=stmt.executeQuery(qry);
     rs.setFetchSize(100);
	 
%>

<form method="post">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">		
				<a href="./rws_planning_format1_frm.jsp">Back|</a>
				<a href="../home.jsp">Home |</a>
				<!--<a href="rws_planning_format1_rpt_print.jsp" target="_new">Print |</a>-->
				<a href="rws_planning_format1_rpt_xls.jsp?district=<%=rDistrict%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&habitation=<%=rHabitation%>&districtName=
				<%=districtName%>&mandalName=<%=mandalName%>&panchayatName=<%=panchayatName%>&villageName=<%=villageName%>&habitationName=<%=habitationName%>"target="_new">Excel</a>
			</td>
		</tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td align="center" class="rptHeading" colspan=24>RWS Planning Format - I Report</td>	
	</tr>	
	<tr>
		<td valign=top>
			<table border =0 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#edf2f8" align=center width=100%>	
				<tr align=center>
					<td align="center" class="rptValue">District: <%=session.getAttribute("districtName")%></td>
<% 
	if(session.getAttribute("mandalName")!=null)
	{
%>
					<td align="center" class="rptValue">Mandal: <%=session.getAttribute("mandalName")%></td>
					<!--</tr>-->
<%
	}
		if(session.getAttribute("panchayatName")!=null)
		{
%>
					<td align="center" nowrap class="rptValue">Panchayat: <%=session.getAttribute("panchayatName")%></td>
				<!--</tr>-->
<%
		}
			if(session.getAttribute("villageName")!=null)
			{
%>
					<td align="center" nowrap class="rptValue">Village: <%=session.getAttribute("villageName")%></td>
				<!--</tr>-->
<%
			}
				//if(session.getAttribute("habitationName")!=null)
				//{
%>
					<!--<td align="center" nowrap class="rptValue">Habitation: <%=session.getAttribute("habitationName")%></td>
				</tr>-->
<%
				//}
%>
		<!--</td>-->
	</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
        <tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>District Code</td>
		<td class=btext>District Name</td>
	<!--<td class=btext>Assembly Constituency Code</td>
		<td class=btext>Assembly Constituency Name</td>
		<td class=btext>Parliamentary Constituency Code</td>
        <td class=btext>Parliamentary Constituency Name</td> -->
		<td class=btext>Mandal Code</td>
		<td class=btext>MandalName</td>
		<td class=btext>Village Code</td>
		<td class=btext>Village Name</td>
		<td class=btext>Habitation Code</td>
		<td class=btext>Habitation Name</td>
		<td class=btext>Panchayat Code</td>
		<td class=btext>Panchayat Name</td>
		<td class=btext>PR Hab Code</td>
		<td class=btext>HabitationCode</td>
		<td class=btext>Status </td>
		<td class=btext>Total Population</td>
		<td class=btext>SC Population</td>
		<td class=btext>ST Population</td>
	   <!--   <td class=btext>NSS - Ty</td>
		<td class=btext>NSS - FI</td>
		<td class=btext>NSS - Br</td>
		<td class=btext>NSS - Ir</td> -->
	</tr>
<% 

	
   while (rs.next())
   {
	
String mparlc = rs.getString(12);

String macode = rs.getString("acode");

String qry1="select  distinct constituency_name from rws_constituency_tbl b where constituency_code='"+macode+"' and constituency_type='A'";
rs1=stmt1.executeQuery(qry1);
%>
<tr>
<td class=rptValue nowrap><%=++sno%></td>
<td class=rptValue nowrap align="center"><%=rs.getString(1)%></td>
<td class=rptValue nowrap><%=rs.getString(2)%></td>
<!-- <td class=rptValue nowrap><%=rs.getString(3)%></td> -->
<%
	
	if(rs1.next())
	{ %>
<!--<td class=rptValue nowrap><%=rs1.getString(1)%></td>
  <td class=rptValue nowrap><%=rs.getString(12)%></td> 
-->
<%

		String qry3="select  distinct constituency_name from rws_constituency_tbl b where substr(constituency_code,2,2)='"+mparlc+"' and constituency_type='P'";
		rs3=stmt2.executeQuery(qry3);
		if(rs3.next())
		   { %>
		<!--  	<td class=rptValue nowrap><%=rs3.getString(1)%></td> -->
		   <% 
		   }else
		   {%>
         <!--     <td class=rptValue nowrap>--</td> -->
		  <% }
	}

	else
	   {%>
	<!-- 	<td class=rptValue nowrap>--</td> -->
	  <% } %>
	
<td class=rptValue nowrap align="center"><%=rs.getString(4)%></td>
<td class=rptValue nowrap><%=rs.getString(5)%></td>
<td class=rptValue nowrap align="center"><%=rs.getString(6)%></td> 
<td class=rptValue nowrap><%=rs.getString(7)%></td>
<td class=rptValue nowrap><%=rs.getString(8)%></td>
<td class=rptValue nowrap><%=rs.getString(9)%></td>
<td class=rptValue nowrap align="center"><%=rs.getString(10)%></td>
<td class=rptValue nowrap><%=rs.getString(11)%></td>
<td class=rptValue nowrap align="center"><%=rs.getString(18)%></td>
<td class=rptValue nowrap><%=rs.getString(13)%></td>
<td class=rptValue nowrap><%=rs.getString(14)%></td>
<td class=rptValue nowrap align="right"><%=rs.getString(15)%></td>
<td class=rptValue nowrap align="right"><%=rs.getString(16)%></td>
<td class=rptValue nowrap align="right"><%=rs.getString(17)%></td> 

</tr>
<% }
}
catch(Exception e)
	   {
	    e.printStackTrace();
	   }
	  finally
	  {
		  conn.close();
	  }
	   %>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>