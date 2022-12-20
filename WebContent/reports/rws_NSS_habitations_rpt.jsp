<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//Debug.println("***********************REPORT BEGINING***********************");
	String rDistrict="00", rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, conname, convalue, manvalue, manname, panvalue, panname, vilvalue, vilname = null;
	distname=null;
	conname=null;
	manname=null;
	panname=null;
	vilname=null;
	
	String query2=null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
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

<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="65%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right"><td class="bwborder"><a href="../rws_login_frm.jsp">Home</a>|</td>
							  <td class="bwborder"><a href="./rws_NSS_habitations_rpt_xls1.jsp" target="_new">Excel</a></td>
			</tr>
		</table>
	</caption>
<%
   	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE); 
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//query2="SELECT DISTINCT d.Dcode,d.DNAME,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS from rws_district_tbl d,rws_habitation_directory_tbl HD,RWS_PANCHAYAT_RAJ_TBL RAJ where HD.HAB_CODE=RAJ.PANCH_CODE AND d.dcode=substr (HD.hab_code,1,2) and hd.coverage_status is not null and hd.coverage_status! ='UI' and hd.coverage_status='NSS' group by d.dcode,d.dname ";
		query2="select distinct d.dcode,d.dname,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where hd.hab_code=raj.panch_code and m.dcode=d.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and  substr (raj.panch_code,1,2) =v.dcode and substr(raj.panch_code,6,2)=v.mcode and substr (raj.panch_code,13,2) =v.pcode and substr(raj.panch_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and hd.coverage_status='NSS' group by d.dcode,d.dname";		
       //query2="select distinct d.dcode,d.dname,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS from rws_district_tbl d,RWS_CONSTITUENCY_TBL C,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where hd.hab_code=raj.panch_code and m.dcode=d.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and c.dcode=d.dcode and (SUBSTR (raj.panch_code,1,2) = C.DCODE AND SUBSTR (raj.panch_code,3,3) = C.CONSTITUENCY_CODE and constituency_type='A') and substr (raj.panch_code,1,2) =v.dcode and substr(raj.panch_code,6,2)=v.mcode and substr (raj.panch_code,13,2) =v.pcode and substr(raj.panch_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and hd.coverage_status='NSS' group by d.dcode,d.dname";
		//query2="select distinct d.dcode,d.dname,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS from rws_district_tbl d,RWS_CONSTITUENCY_TBL C,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where hd.hab_code=raj.panch_code and m.dcode=d.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode and c.dcode=d.dcode and (SUBSTR (raj.panch_code,1,2) = C.DCODE AND SUBSTR (raj.panch_code,3,3) = C.CONSTITUENCY_CODE and constituency_type='A') and substr (raj.panch_code,1,2) =v.dcode and substr(raj.panch_code,6,2)=v.mcode and substr (raj.panch_code,13,2) =v.pcode and substr(raj.panch_code,8,3)=v.vcode and hd.coverage_status is not null and hd.coverage_status<>'UI' and hd.coverage_status='NSS' group by d.dcode,d.dname";
    }
	rs2 = stmt1.executeQuery(query2);
%>
<%--@ include file="./rws_NSS_habitations_label.jsp"--%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Quality Affected Coverage Status Report</td>	
	</tr>
	<tr  align="center">
		<td  class="rptValue" colspan=8><b>District:</b> All</td>		
	</tr>	
	<tr align=center>
		<td class=btext rowspan = 2>Sl.No</td>
		<td class=btext rowspan = 2>District</td>
		<td class=btext colspan = 4>No.of Habs</td>
	</tr>
	<tr align = center>
		<td class=btext>Quality Affected</td>
	</tr>
<%
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	while(rs2.next())
	{		
		++ slno;
%>	
	<tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rs2.getString(2)%></td>
		<td class=rptValue><a href="./rws_NSS_consti_habitations_rpt.jsp?distvalue=<%=rs2.getString(1)%>&distname=<%=rs2.getString(2)%>"><%=rs2.getInt(3)%></a></td>
		<% nssTotal+=rs2.getInt(3); %>
	</tr>
<%
	}
	rs2.close();
%>
	<tr>
		<td class=btext colspan=2>TOTAL</td>
		<td class=btext><%=nssTotal%></td>
	</tr>
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
	rs2.close();
	stmt1.close();
	conn.close();
}catch(Exception e){}
}
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
