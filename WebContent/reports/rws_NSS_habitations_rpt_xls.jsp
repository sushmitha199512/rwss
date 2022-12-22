
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, convalue, conname = null,manname=null,panname=null,vilname=null;
	distvalue = request.getParameter("distvalue");
	distname = request.getParameter("distname");
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs2=null;
	Statement stmt1 = null;
	Statement stmt2 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
try
{
%>
<html>
<head>
<script>
	window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">

<form name="f1" method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<%  try
	{ 
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	if(distvalue != null)
	{
		query2="select d.dcode,d.dname,m.mcode,m.mname,p.pcode, p.pname,v.vcode,v.vname,raj.panch_code,raj.panch_name from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where hd.hab_code=raj.panch_code and m.dcode=d.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and  substr (raj.panch_code,1,2) =v.dcode and substr(raj.panch_code,6,2)=v.mcode and substr (raj.panch_code,13,2)=v.pcode and substr(raj.panch_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and hd.coverage_status='NSS' and substr(raj.panch_code,1,2)='"+distvalue+"' order by d.dcode,m.mcode,p.pcode,v.vcode";	
	}
	rs2 = stmt1.executeQuery(query2);
	System.out.println(query2); 
%>
	
<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=6>Quality Affected Coverage Status Excel Report</font></td>	
</tr>
	<tr align="center">
		<td  class="rptValue" colspan=6><b>District:</b> <%=distname %></td>		
	</tr>	
	<tr bgcolor="#ffffff">
		<td class=btext>Sl.No</td>
		<td class=btext>Mandal Name</td>
		<td class=btext>Panchayat Name</td>
		<td class=btext>Village Name</td>
		<td class=btext>Habitation Name</td>
	</tr>

<%	while(rs2.next())
	{
		++ slno;
%>
<tr >
		<td class=rptValue align="center"><%=slno%></td>
		<td class=rptValue nowrap><%=rs2.getString(4)%>&nbsp;</td>
		<td class=rptValue nowrap><%=rs2.getString(6)%>&nbsp;</td>
		<td class=rptValue nowrap><%=rs2.getString(8)%>&nbsp;</td>
		<td class=rptValue nowrap><%=rs2.getString(10)%>&nbsp;</td>
</tr>
<%} 
}catch(Exception e)
{
System.out.println("Exception"+e);
}
finally
{
try{
rs2.close();
stmt1.close();
}catch(Exception e){}
}
%>
</table>
<%
	
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
try{
	conn.close();
}catch(Exception e)
{}
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
