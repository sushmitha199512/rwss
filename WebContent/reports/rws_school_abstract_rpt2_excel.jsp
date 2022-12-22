<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%
String dcode=(String)session.getAttribute("dcode");
String mcode=(String)session.getAttribute("mcode");
String schoolcode=(String)session.getAttribute("schoolcode");

String dname=(String)session.getAttribute("dname");
String mname=(String)session.getAttribute("mname");
String scname=(String)session.getAttribute("scname");

%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr>
			<td class="btext" colspan="12">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;School Category:<%=scname%></td>
		</tr>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=12> Categorywise School Details Report</td>	
		</tr>
	<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext>Panchayat Name</td>
			
			<td class=btext >Total Strength</td>			
			
				<%if(schoolcode!=null && schoolcode.equals("01")){%>
			<td class=btext>Balwadi/Anganwadi </td>
			<%} else if(schoolcode!=null && schoolcode.equals("02")){%>
				<td class=btext>Primary </td>
			<%} else if(schoolcode!=null && schoolcode.equals("03")){%>
				<td class=btext>Upper Primary </td>
			<%} else if(schoolcode!=null && schoolcode.equals("04")){%>
				<td class=btext>Secondary</td>
			<%} else if(schoolcode!=null && schoolcode.equals("05")){%>
				<td class=btext>Sr. Secondary </td>
				<%}%>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>
			</tr>
			
		<%
		String getDnameQuery = "select pcode,pname from rws_panchayat_tbl where dcode = '"+dcode+"' and mcode = '"+mcode+"' order by pcode";
	    System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		while(rs2.next())
		{
			String getHabCountQuery = "select hab_code,count(*) from rws_school_master_tbl where substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"' group by hab_code having count (*) >=1 ";
			getHabRs = getHabSt.executeQuery(getHabCountQuery);
			int habCount = 0 ;
			getHabRs.afterLast();
			getHabRs.previous();
			habCount = getHabRs.getRow();
			//System.out.println("sizee:"+habCount);
	 String  getDataQuery="select count(hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,count( SCHOOL_CATEGORY_CODE ) as a,sum(case when   FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as a1,sum(case when    FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as a2,sum(case when   ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)')then 1 else 0 end) as a3,sum(case when   FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as a4,sum(case when    FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as a5,sum(case when  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as a6,sum(case when    FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as a7,sum(case when   ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as a8 from rws_school_master_tbl where   substr(hab_code,1,2)='"+dcode+"' and substr(hab_code,6,2)='"+mcode+"'  and substr(hab_code,13,2)='"+rs2.getString(1)+"' and School_category_code='"+schoolcode+"'";
	 // System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue ><%=sno++%></td>
			<td class=rptValue nowrap><%=rs2.getString(2)%></td>
			<!-- 	<td class=rptValue nowrap><%=rs1.getString(1)%></td>
			<td class=rptValue align="right"><%=rs1.getString(2)==null? "-" : rs1.getString(2)%></td> -->
			<td class=rptValue align="right"><%=rs1.getInt(3)%></td>
			<%if(rs1.getInt(4)>0)
	       {%>
		   <td class=rptValue align="right"><a href="#" onclick="wopen('rws_schoolDetails_rpt.jsp?dcode=<%=dcode%>&mcode=<%=mcode%>&pcode=<%=rs2.getString(1)%>&schoolcode=<%=schoolcode%>','popup', 900, 300)"><%=rs1.getInt(4)%></a></td>
     	<%}
	else{%>
	<td class=rptvalue align="right">0</td>
	<%}%>
			
			<td class=rptValue align="right"><%=rs1.getInt(5)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(6)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(7)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(8)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(9)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(10)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(11) %></td>
			<td class=rptValue align="right"><%=rs1.getInt(12) %></td>
			</tr>						

			<%		columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		}%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td  class=btext align="right"><%=columnTotal3%></td>
			<td  class=btext align="right"><%=columnTotal4%></td>
			<td  class=btext align="right"><%=columnTotal5%></td>
			<td  class=btext align="right"><%=columnTotal6%></td>
			<td  class=btext align="right"><%=columnTotal7%></td>
			<td  class=btext align="right"><%=columnTotal8%></td>
			<td  class=btext align="right"><%=columnTotal9%></td>
			<td  class=btext align="right"><%=columnTotal10%></td>
			<td  class=btext align="right"><%=columnTotal11%></td>
			<td  class=btext align="right"><%=columnTotal12%></td>
			<tr>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
