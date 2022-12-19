 <%@ page contentType="application/vnd.ms-excel"%>
<%@ include file="conn.jsp"%>

<%     
	    String  rDistrict = (String)request.getParameter("district");
		
	    String	rMandal = null;
		String	rPanchayat = null;
		String	rVillage = null;
		String	rHabitation = null;
%>
<html>
<head>
<title> WaterSoft </title>
<link rel="stylesheet" href="../resources/style/rwsstyle.css" type="text/css">
</head>
<body bgcolor="#edf2f8">
<%
   try{
	   String qry=null;

	
     qry="select substr(pr.panch_code,1,2),c.dname,suBstr(pr.panch_code,3,3)as acode,suBstr(pr.panch_code,6,2),d.mname,suBstr(pr.panch_code,8,3),E.vname,PR.PANCH_code,PR.PANCH_NAME,suBstr(pr.panch_code,13,2),F.pname,COVERAGE_STATUS,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, b.CENSUS_SC_POPU, b.CENSUS_ST_POPU,SUBSTR(PR.PANCH_CODE,15,2) from RWS_PANCHAYAT_RAJ_TBL PR,RWS_VILLAGE_TBL E,RWS_PANCHAYAT_TBL F, RWS_HABITATION_DIRECTORY_TBL B,rws_district_tbl c ,rws_mandal_tbl d where B.HAB_CODE = PR.PANCH_CODE and (substr(pr.panch_code,1,2)=c.dcode) and (substr(pr.panch_code,1,2)=d.dcode and suBstr(pr.panch_code,6,2)=d.mcode) and (substr(pr.panch_code,1,2)=F.dcode and suBstr(pr.panch_code,6,2)=f.mcode AND suBstr(pr.panch_code,13,2)=F.PCODE)AND(substr(pr.panch_code,1,2)=E.dcode and suBstr(pr.panch_code,6,2)=E.mcode AND suBstr(pr.panch_code,13,2)=E.PCODE AND suBstr(pr.panch_code,8,3)=E.VCODE)  AND substr(pr.panch_code,1,2)='"+rDistrict+"' and  update_date is null";
	
	
     stmt=conn.createStatement();
	Statement stmt1=conn.createStatement();
	Statement  stmt2=conn.createStatement();
	 rs=stmt.executeQuery(qry);
	 
%>

<form name="hab_not_ported">

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  style="border-collapse:collapse" bgcolor="#ffffff">
<thead>
<th>Dcode</th>
<th>Dname</th>
<th>Acode</th>
<th>Aname</th>
<th>MandalCode</th>
<th>MName</th>
<th>VCode</th>
<th>VName</th>
<th>HabCode</th>
<th>HabName</th>
<th>GpCode</th>
<th>GpName</th>
<th>Status</th>
<th>Pop_tot</th>
<th>Pop_sc</th>
<th>Pop_st</th>
<th>PanchayatRajCode</th>
<th>NssType</th>
<th>Floride</th>
<th>Brakish</th>
</thead>

<% 
   while(rs.next())
   {



String macode = rs.getString("acode");

String qry1="select  distinct constituency_name from rws_constituency_tbl b where constituency_code='"+macode+"' and constituency_type='A'";
 ResultSet rs1=stmt1.executeQuery(qry1);


%>
<tr>
<td>&nbsp;
<%
   
	out.println(rs.getString(1));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(2));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(3));

%>

</td>
<td>&nbsp;
<%
	
	if(rs1.next())
	   {
        out.println(rs1.getString(1));
	   }
%>
</td>
  

<td>&nbsp;
<%
	out.println(rs.getString(4));
%>
</td>  


<td>&nbsp;
<%
	out.println(rs.getString(5));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(6));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(7));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(8));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(9));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(10));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(11));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(12));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(13));
%>
</td>  
<td>&nbsp;
<%
	out.println(rs.getString(14));
%>
</td> 
<td>&nbsp;
<%
	out.println(rs.getString(15));
%>
</td> 
 <td>&nbsp;
<%
	out.println(rs.getString(16));
%>
</td> 
<td>&nbsp;
<%
	out.println("--");
%>
</td>  <td>
<%
	out.println("--");
%>
</td>  
<td>
<%
	out.println("--");
%>
</td>  


</tr>
<% } }
catch(Exception e)
{
	//System.out.println("Exception :"+e);
}%>

</table>