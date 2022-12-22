<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "ZeroPopulationReport.xls");

%>
<%
   String query=null,query1=null;
   Statement st2=null;
   ResultSet rs2=null;
try
{
%>
<table border = 1 cellspacing = 0 cellpadding = 0 bgcolor="#DEE3E0" width=100% height=20% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr class="bwborder" bgcolor="white">	
	<td class="btext" align=center>S.No.</td>	
	<td class="btext" align=center>District Name</td>	
	<td class="btext" align=center>MCode</td>	
	<td class="btext" align=center>Mandal Name</td>	
	<td class="btext" align=center>PCode</td>	
	<td class="btext" align=center>Panchayat Name</td>	
	<td class="btext" align=center>VCode</td>	
	<td class="btext" align=center>Village Name</td>
	<td class="btext" align=center>HabCode</td>
	<td class="btext" align=center>Habitation Name</td>
	<td class="btext" align=center>Coverage Status</td>
	</tr>
<% 	
query="select d.dcode ,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_name,raj.panch_code,nvl(coverage_status,'--') as Status from rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code(+)=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and d.dcode=m.dcode and m.mcode=substr(h.hab_code,6,2) and p.dcode=d.dcode and p.mcode=m.mcode and p.pcode=substr (h.hab_code,13,2) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and v.vcode=substr(h.hab_code,8,3)  and (CENSUS_PLAIN_POPU=0 AND CENSUS_SC_POPU=0 AND CENSUS_ST_POPU=0)  order by d.dcode,m.mcode,p.pcode,v.vcode,d.dname,m.mname,p.pname,v.vname,panch_code,panch_name";	
	stmt=conn.createStatement();
	rs=stmt.executeQuery(query);

	//System.out.println("query"+query);
	
	
int i= 1;
			if(rs.isBeforeFirst())
			{
				while(rs.next())
				{
%>

		<tr>
		<td class=rptValue><%=i++ %></td>
		<td class=rptValue nowrap>&nbsp;<%=rs.getString(2) %>&nbsp; </td>
		<td class=rptValue>&nbsp;<%=rs.getString(3) %>&nbsp;</td>
		<td class=rptValue nowrap>&nbsp;<%=rs.getString(4) %>&nbsp;</td>
		<td class=rptValue>&nbsp;<%=rs.getString(5) %>&nbsp;</td>
		<td class=rptValue nowrap>&nbsp;<%=rs.getString(6) %>&nbsp;</td>
		<td class=rptValue>&nbsp;<%=rs.getString(7) %>&nbsp;</td>
		<td class=rptValue nowrap>&nbsp;<%=rs.getString(8) %>&nbsp;</td>
		<td class=rptValue>&nbsp;<%=rs.getString(10) %>&nbsp;</td>
		<td class=rptValue nowrap>&nbsp;<%=rs.getString(9) %>&nbsp;</td>
		<td class=rptValue>&nbsp;<%=rs.getString(11) %>&nbsp;</td>
		</tr>
<%}
}
else
{%>
	<tr><td colspan="11" align="center">NO-RECORDS</td></tr>
<%} 
	
	}catch(Exception e)
	{
		System.out.println("Exception in JSP"+e);
	}
%>
</table>
<%@ include file = "connClose.jsp" %>
<%}%>