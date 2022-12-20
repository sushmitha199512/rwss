<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.sql.*,java.util.*" %>
<%@ include file="conn.jsp" %>
<%!ResultSet resultforhab; 
Connection conn1;
String query1=null;
ResultSet rs1=null;
Statement stmt1=null;
String officeCode="";
%>
<%

	



	
	String ofName="";
	String query3=null;
	String officeName="";
		String officeType="";
	String habId, habName, query = null;
	habId = request.getParameter("habId");
	habName = request.getParameter("habName");
	String dis="";
	String man="";
	String pan="";
	String vill="";
	int slno=0;
%>

<html>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<!-- <td class="bwborder"><a href="javascript:window.history.back()">Back |</a></td> -->
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!-- <td class="bwborder"><a href="../home.jsp">Print |</a></td>
				<td class="bwborder"><a href="../home.jsp">Excel</a></td>	 -->		
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16><%=habName%> - <%=habId%> Details</font></td>	
	</tr>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext rowspan=2>Sl.No</td>		
		<td class=btext rowspan=2>District</td>
		<td class=btext rowspan=2>Mandal</td>
		<td class=btext rowspan=2>Panchayat</td>
		<td class=btext rowspan=2>Village</td>
		<td class=btext colspan=4>Census Population Details</td>		
		<td class=btext colspan=2>Floating Population Details</td>
		<td class=btext colspan=3>Population Covered Details</td>
		<td class=btext rowspan=2>Coverage Status</td>
	</tr>
	<tr>
		<td class=btext>Year</td>
		<td class=btext>Plain</td>
		<td class=btext>SC</td>
		<td class=btext>ST</td>	
		<td class=btext>Population</td>
		<td class=btext>Reasons</td>		
		<td class=btext>Plain</td>
		<td class=btext>SC</td>
		<td class=btext>ST</td>
	</tr>

<%	
	
	int tempi=0;
	try
	{
	String district=habId.substring(0,2);
	String mandal=habId.substring(5,7);
	String panchayat=habId.substring(12,14);
	String village=habId.substring(7,10);
	
	query1="select d.dname,m.mname,p.pname,v.vname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and substr(hd.hab_code,1,2)='"+district+"' and substr(hd.hab_code,6,2)='"+mandal+"' and substr(hd.hab_code,13,2)='"+panchayat+"' and substr(hd.hab_code,8,3)='"+village+"' and hd.hab_code='"+habId+"'";
	
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(query1);
	while(rs1.next())
	{
	dis=rs1.getString(1);
	man=rs1.getString(2);
	pan=rs1.getString(3);
	vill=rs1.getString(4);
	
	
		
				
	}
		
		query3="SELECT (1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE), HD.HAB_CODE, PR.PANCH_NAME, HD.CENSUS_YEAR, HD.CENSUS_PLAIN_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, HD.FLOAT_POP,nvl(HD.FLOAT_POP_REASONS,'-'), HD.PLAIN_POPU_COVERED, HD.SC_POP_COVERED, HD.ST_POP_COVERED, HD.COVERAGE_STATUS FROM RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR WHERE HD.HAB_CODE = '"+habId+"' AND HD.HAB_CODE = PR.PANCH_CODE";


	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	
	rs = stmt.executeQuery(query3);
	

		
	while(rs.next())
	{
	
		slno++;	

%>
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>		
		<td class=rptValue><%=dis%></td>
		<td class=rptValue><%=man%></td>
		<td class=rptValue><%=pan%></td>
		<td class=rptValue><%=vill%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getInt(5)%></td>			
		<td class=rptValue><%=rs.getInt(6)%></td>
		<td class=rptValue><%=rs.getInt(7)%></td>
		<td class=rptValue><%=rs.getInt(8)%></td>
		<td class=rptValue><%=rs.getString(9)%></td>
		<td class=rptValue><%=rs.getInt(10)%></td>			
		<td class=rptValue><%=rs.getInt(11)%></a></td>
		<td class=rptValue><%=rs.getInt(12)%></td>
		<td class=rptValue><%=rs.getString(13)%></td>
	</tr>

<%
	}
	
		}catch(Exception o)
		{
		
		}
		finally
		{
		try
		{
		if(rs1!=null)
		{
		rs1.close();
		}
		if(stmt1!=null)
		{
		stmt1.close();
		}
		if(rs!=null)
		{
		rs.close();
		}
		if(stmt!=null)
		{
		stmt.close();
		}
		conn.close();
		}
		catch(Exception e)
		{
		e.printStackTrace();
		}
		}
		if(slno==0)
		{
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptSubValue" colspan="14">NO RECORDS FOR YOUR QUERY...</td>	
	</tr>
	<%} %>
		
		
	
	
	
	
	
	
		  
		 
	