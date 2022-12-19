<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

////// System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict = request.getParameter("rDistrict");
session.setAttribute("rDistrict",rDistrict);
String dname = request.getParameter("rDistrictName");
session.setAttribute("rDistrictName",dname);

String rMandal = request.getParameter("rMandal");
session.setAttribute("rMandal",rMandal);
String mname = request.getParameter("rMandalName");
session.setAttribute("rMandalName",mname);

String rPanchayat = request.getParameter("rPanchayat");
session.setAttribute("rPanchayat",rPanchayat);
String pname = request.getParameter("rPanchayatName");
session.setAttribute("rPanchayatName",pname);

String drill = request.getParameter("drill");
session.setAttribute("drill",drill);
////// System.out.println("Drill:"+drill);
if(drill.equals("null"))
{
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a><a href="javascript:history.back(-1)">|Back</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>


			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>District</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>Primary</td>
			<td class=btext>Upper Primary</td>
			<td class=btext>Secondary</td>
			<td class=btext>Sr.Secondary</td>
		</tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dname";
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0;

		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		while(rs2.next())
		{
           String  getDataQuery="select count(distinct hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e from rws_school_master_tbl where  substr(hab_code,1,2)='"+rs2.getString(1)+"'";
			ps=conn.prepareStatement(getDataQuery);
			System.out.println("qry:"+getDataQuery);
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><a href="rws_school_abstract_rpt1_secy.jsp?drill=next&rDistrict=<%=rs2.getString(1)%>&rDistrictName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue><%=rs1.getString(1)%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(3)%></td>
			<td class=rptValue><%=rs1.getString(4)%></td>
			<td class=rptValue><%=rs1.getString(5)%></td>								
			<td class=rptValue><%=rs1.getString(6)%></td>
			<td class=rptValue><%=rs1.getString(7)%></td>
			<td class=rptValue><%=rs1.getString(8)%></td>	
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);
		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>		
		</tr>
		<%
	}
}
catch(Exception e)
{
	e.printStackTrace();
}
}
else if(drill!=null && drill.equals("next"))
{
	%>
	<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a><a href="javascript:history.back(-1)">|Back</a><a href="rws_school_abstract_rpt1_secy_excel.jsp">|Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|<a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Mandal</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>Primary</td>
			<td class=btext>Upper Primary</td>
			<td class=btext>Secondary</td>
			<td class=btext>Sr.Secondary</td>
		</tr>
		<tr>
			<td class="btext" colspan="92">District:<%=dname%></td>
		</tr>
	<%
		String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mname";
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		while(rs2.next())
		{
			String  getDataQuery="select count(distinct hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e from rws_school_master_tbl where  substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rs2.getString(1)+"'";


			//// System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><a href="rws_school_abstract_rpt1_secy.jsp?drill=next1&rDistrict=<%=rDistrict%>&rDistrictName=<%=dname%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue><%=rs1.getString(1)%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue><%=rs1.getInt(3)%></td>
			<td class=rptValue><%=rs1.getInt(4)%></td>
			<td class=rptValue><%=rs1.getInt(5)%></td>
			<td class=rptValue><%=rs1.getInt(6)%></td>
			<td class=rptValue><%=rs1.getInt(7)%></td>
			<td class=rptValue><%=rs1.getInt(8)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);
		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
		</tr>
		<%
	}
	else if(drill!=null && drill.equals("next1"))
{
	%>
	<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a><a href="javascript:history.go(-1)">Back</a>|<a href="rws_school_abstract_rpt1_secy_excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|<a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Panchayat</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>Primary</td>
			<td class=btext>Upper Primary</td>
			<td class=btext>Secondary</td>
			<td class=btext>Sr.Secondary</td>
		</tr>
		<tr>
			<td class="btext" colspan="17">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%></td>
		</tr>
	<%
		String getDnameQuery = "select pcode,pname from rws_panchayat_tbl where dcode = '"+rDistrict+"' and mcode = '"+rMandal+"' order by pname";
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		while(rs2.next())
		{
			 String  getDataQuery="select count(distinct hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e from rws_school_master_tbl where  substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rs2.getString(1)+"'";
			////// System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><a href="rws_school_abstract_rpt1_secy.jsp?drill=next2&rDistrict=<%=rDistrict%>&rDistrictName=<%=dname%>&rMandal=<%=rMandal%>&rMandalName=<%=mname%>&rPanchayat=<%=rs2.getString(1)%>&rPanchayatName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue><%=rs1.getString(1)	%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue><%=rs1.getInt(3)%></td>
			<td class=rptValue><%=rs1.getInt(4)%></td>
			<td class=rptValue><%=rs1.getInt(5)%></td>
			<td class=rptValue><%=rs1.getInt(6)%></td>
			<td class=rptValue><%=rs1.getInt(7)%></td>
			<td class=rptValue><%=rs1.getInt(8)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);
	}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
		</tr>
		<%
	}
	else if(drill!=null && drill.equals("next2"))
{
	%>
	<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a>|<a href="javascript:history.go(-1)">Back</a>|<a href="rws_school_abstract_rpt1_secy_excel.jsp">Excel</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|<a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Village</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>Primary</td>
			<td class=btext>Upper Primary</td>
			<td class=btext>Secondary</td>
			<td class=btext>Sr.Secondary</td>
		</tr>
		<tr>
			<td class="btext" colspan="17">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Panchayat:<%=pname%></td>
		</tr>
	<%
		String getDnameQuery = "select vcode,vname from rws_village_tbl where dcode = '"+rDistrict+"' and mcode = '"+rMandal+"' and pcode = '"+rPanchayat+"' order by vname";
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery);
		ResultSet rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		while(rs2.next())
		{
			 String  getDataQuery="select count(distinct hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e from rws_school_master_tbl where  substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rPanchayat+"' and substr(hab_code,8,3)='"+rs2.getString(1)+"'";
			////// System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			ResultSet rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><%=rs2.getString(2)%></td>
				<td class=rptValue><%=rs1.getString(1)	%></td>
			<td class=rptValue><%=rs1.getString(2)%></td>
			<td class=rptValue><%=rs1.getInt(3)%></td>
			<td class=rptValue><%=rs1.getInt(4)%></td>
			<td class=rptValue><%=rs1.getInt(5)%></td>
			<td class=rptValue><%=rs1.getInt(6)%></td>
			<td class=rptValue><%=rs1.getInt(7)%></td>
			<td class=rptValue><%=rs1.getInt(8)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);
		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
		</tr>
		<%
	}
%>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
