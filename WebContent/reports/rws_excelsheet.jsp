<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file = "conn.jsp" %>
<%

	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict=null,rMandal=null;
	String prevcode=null;
	rDistrict = String.valueOf(session.getAttribute("districtCode"));
	System.out.println("DDD"+rDistrict);
	rMandal = String.valueOf(session.getAttribute("mandalCode"));
	System.out.println("mmmm"+rMandal);
	//System.out.println("rDistrict = " +rDistrict);
	String districtName = String.valueOf(session.getAttribute("districtName"));
	System.out.println("dn"+districtName);
	String mandalName = String.valueOf(session.getAttribute("mandalName"));
System.out.println("dn"+mandalName);
	
	String query=null;
	int slno = 0;
	int Count = 0;
	
try
{%>
<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16>District-Mandal Wise Coverage Planning Report</font></td>	
	</tr>
<% 
	System.out.println("before headings");
		if(rDistrict!=null && !rDistrict.equals("-1") && rMandal.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=16>District: <%=districtName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>District Code</td>
		<td class=btext>District Name</td>
		<td class=btext>Mandal Code</td>
		<td class=btext>Mandal Name</td>
		<td class=btext>Village Code</td>
		<td class=btext>Village Name</td>
		<td class=btext>HCode</td>
		<td class=btext>HName</td>
		<td class=btext>Panchayat Code</td>
        <td class=btext>Panchayat Name</td>
		<td class=btext>Assembly Code</td>
        <td class=btext>Assembly Name</td>
		<td class=btext>Habitation Code</td>
        <td class=btext>Habitation Name</td>
		<td class=btext>Coverage Status</td>
	</tr>
	
<%	
		}
if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1"))
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=16>District: <%=districtName%>&nbsp;&nbsp;&nbsp;Mandal: <%=mandalName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Mandal Code</td>
		<td class=btext>Mandal Name</td>
		<td class=btext>Village Code</td>
		<td class=btext>Village Name</td>
		<td class=btext>HCode</td>
		<td class=btext>HName</td>
		<td class=btext>Panchayat Code</td>
        <td class=btext>Panchayat Name</td>
		<td class=btext>Assembly Code</td>
        <td class=btext>Assembly Name</td>
		<td class=btext>Habitation Code</td>
        <td class=btext>Habitation Name</td>
		<td class=btext>Coverage Status</td>
	</tr>
	
<%	
	System.out.println("after headings");
		}
	
	if(rDistrict!=null && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
		
query="select distinct d.dcode,d.dname,m.mcode,m.mname,v.vcode,v.vname,substr (raj.panch_code,11,2),raj.panch_name, p.pcode,p.pname,con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,raj.panch_code, raj.panch_name,h.coverage_status from RWS_CONSTITUENCY_TBL con,rws_PANCHAYAT_RAJ_TBL raj,RWS_HABITATION_DIRECTORY_TBL h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and d.dcode=m.dcode and m.mcode=substr(h.hab_code,6,2) and p.dcode=d.dcode and p.mcode=m.mcode and p.pcode=substr (h.hab_code,13,2) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and v.vcode=substr(h.hab_code,8,3) and d.dcode=con.dcode and m.mcode=con.mcode  and h.coverage_status is not null and h.coverage_status<>'UI' and substr(h.hab_code,1,2)='"+rDistrict+"' order by d.dcode,m.mcode,v.vcode,p.pcode, con.CONSTITUENCY_CODE,raj.panch_code ";
		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        }
	else if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1"))
	  {
		
	query="select distinct d.dcode,d.dname,m.mcode,m.mname,v.vcode,v.vname,substr (raj.panch_code,11,2),raj.panch_name, p.pcode,p.pname,con.CONSTITUENCY_CODE,con.CONSTITUENCY_NAME,raj.panch_code, raj.panch_name,h.coverage_status from RWS_CONSTITUENCY_TBL con,rws_PANCHAYAT_RAJ_TBL raj,RWS_HABITATION_DIRECTORY_TBL h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where h.hab_code=raj.panch_code and d.dcode=substr(h.hab_code,1,2) and d.dcode=m.dcode and m.mcode=substr(h.hab_code,6,2) and p.dcode=d.dcode and p.mcode=m.mcode and p.pcode=substr (h.hab_code,13,2) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and v.vcode=substr(h.hab_code,8,3) and d.dcode=con.dcode and m.mcode=con.mcode and h.coverage_status is not null and h.coverage_status<>'UI' and substr(h.hab_code,1,2)='"+rDistrict+"' and substr(h.hab_code,6,2)='"+rMandal+"' order by d.dcode,m.mcode,v.vcode,p.pcode, con.CONSTITUENCY_CODE,raj.panch_code ";
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
        }
	rs=stmt.executeQuery(query);
	System.out.println("after queries");
	System.out.println(" Habitaitons List query"+query);
	if(rs.next()){
	rs.setFetchSize(1000);
	rs.last();
    Count = rs.getRow();
	//System.out.println("Count is"+Count);
	rs.beforeFirst();
	}
	if(Count!=0)
	{
	if(rDistrict!=null && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
	while(rs.next())
	{
	%>	
	     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(1)%></td>
        <td class=rptValue><%=rs.getString(2)%></td>
		<td class="rptValue"><%=rs.getString(3)%></td>			
		<td class="rptValue"><%=rs.getString(4)%></td>
        <td class="rptValue"><%=rs.getString(5)%></td>
		<td class="rptValue"><%=rs.getString(6)%></td>			
		<td class="rptValue"><%=rs.getString(7)%></td>
        <td class=rptValue><%=rs.getString(8)%></td>
		<td class=rptValue><%=rs.getString(9)%></td>			
		<td class=rptValue><%=rs.getString(10)%></td>
		<td class=rptValue><%=rs.getString(11)%></td>
		<td class=rptValue><%=rs.getString(12)%></td>
		<td class=rptValue><%=rs.getString(13)%></td>
		<td class=rptValue><%=rs.getString(14)%></td>
		<td class=rptValue><%=rs.getString(15)%></td>
		</tr>
        
	    
	   <%
		}
	}
	else if(rDistrict!=null && !rDistrict.equals("-1") && !rMandal.equals("-1"))
		{
         while(rs.next())
	{
	%>	
	     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(3)%></td>
        <td class=rptValue><%=rs.getString(4)%></td>
		<td class="rptValue"><%=rs.getString(5)%></td>			
		<td class="rptValue"><%=rs.getString(6)%></td>
       	<td class=rptValue><%=rs.getString(7)%></td>
        <td class=rptValue><%=rs.getString(8)%></td>
		<td class=rptValue><%=rs.getString(9)%></td>			
		<td class=rptValue><%=rs.getString(10)%></td>
		<td class=rptValue><%=rs.getString(11)%></td>
		<td class=rptValue><%=rs.getString(12)%></td>
		<td class=rptValue><%=rs.getString(13)%></td>
		<td class=rptValue><%=rs.getString(14)%></td>
		<td class=rptValue><%=rs.getString(15)%></td>
		</tr>
        <%
		}
	}
		}
	else
	{%>
	  <td align="center" class="rptHeading" colspan=12><a align=center href="./rws_planning_format_frm.jsp">There are no Records</td></a>
	 <%
	}
	
	
   stmt.close();
   rs.close();
	
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
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>


</form>
</body>
</html>
