<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file="conn3.jsp" %>

<%
   String query=null,query1=null;
   String district=request.getParameter("district");
   String mandal=request.getParameter("mandal");
   String panchayat=request.getParameter("panchayat");
   String village=request.getParameter("village");
   String status=request.getParameter("status");
   Statement st2=null;
   ResultSet rs2=null;
try
{
%>
<table width="100%">
<tr>
<td align="right"><a href="javascript:history.go(-1);">Back </a>|<a href="/pred/home.jsp">Home</a></td>
</tr>
</table>

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
<% 	query="create or replace view unidentified as select d.dcode ,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_name,raj.panch_code,nvl(coverage_status,'--') as Status from rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code(+)=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and d.dcode=m.dcode and m.mcode=substr(h.hab_code,6,2) and p.dcode=d.dcode and p.mcode=m.mcode and p.pcode=substr (h.hab_code,13,2) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and v.vcode=substr(h.hab_code,8,3) order by d.dcode,m.mcode,p.pcode,v.vcode,d.dname,m.mname,p.pname,v.vname,panch_code,panch_name";	
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(query);
		
	//query="select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_name,raj.panch_code,nvl(coverage_status,'--') as Status from rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code(+)=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and d.dcode=m.dcode and m.mcode=substr(h.hab_code,6,2) and p.dcode=d.dcode and p.mcode=m.mcode and p.pcode=substr (h.hab_code,13,2) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and v.vcode=substr(h.hab_code,8,3)";
	query1="select * from unidentified ";
	
		if(district.equals("ALL"))
		{
			if(status.equals("UI"))
			{
				query1+=" where status='UI' ";
			}
			if(status.equals("NULL")) 
			{
				query1+=" where status='--' ";
			}
		}
		else if(!district.equals("ALL"))
		{				
			query1+=" where ";
			if(!district.equals("ALL"))
			{
				query1+=" substr(PANCH_CODE,1,2)='"+district+"' ";
			}
			if(!mandal.equals("ALL"))
			{
				query1+=" and substr(PANCH_CODE,6,2)='"+mandal+"' ";
			}
			if(!panchayat.equals("ALL"))
			{
				query1+=" and substr(PANCH_CODE,13,2)='"+panchayat+"' ";
			}
			if(!village.equals("ALL"))
			{
				query1+=" and substr(PANCH_CODE,8,3)='"+village+"' ";
			}
			if(status.equals("UI"))
			{
				query1+=" and status='UI'  ";
			}
			if(status.equals("NULL"))
			{
				query1+=" and status='--' ";
			}
			}
			
			//query1+=" order by dcode,mcode,pcode,vcode,dname,mname,pname,vname,panch_code,panch_name ";
			stmt=conn.createStatement();
			//System.out.println("query"+query);
			//System.out.println("query1"+query1);
			rs=stmt.executeQuery(query1);
			int i=1;
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
	String q2=null;
	q2="drop view unidentified ";
	st2=conn.createStatement();
	rs2=st2.executeQuery(q2);
	}catch(Exception e)
	{
		System.out.println("Exception in JSP"+e);
	}
%>
</table>