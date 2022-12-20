<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="application/vnd.ms-excel" %>

<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%
//System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict=null;
ResultSet rs1=null,rs2=null;
Statement pst = null;
PreparedStatement ps1=null;
rDistrict = (String)session.getAttribute("rDistrict");
System.out.println("rDistrict"+rDistrict);
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=14>Coverage of Habitations  by Hand Pumps only (without schemes)</td>	
		</tr>
		
<%
try
{
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext >Sno</td>
			<td class=btext >District</td>
			<td class=btext >Mandal</td>	
			<td class=btext >Panchayat</td>	
			 <td class=btext >Village</td>
			 <td class=btext >Hab Code</td>
			<td class=btext >Hab Name</td>
 		</tr>
	<%
String getDnameQuery="";
 if(rDistrict!=null && rDistrict.equals("null") || rDistrict.equals("00"))
	{
	
		 getDnameQuery = "select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name from rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and (hp.HPS_NO >0 or hp.HPS_NO_UNSAFE>0) and hp.cpws_no = 0 and hp.CPWS_SUPPLY = 0 and hp.pws_no=0 and hp.PWS_SUPPLY =0 and hp.mpws_no=0 and hp.MPWS_SUPPLY =0 and hp.OTHERS_NO_SAFE=0 and hp.OTHERS_SUPPLY_SAFE =0 and hp.PWS_UNSAFE_NO=0 and hp.PWS_UNSAFE_SUPPLY=0 and hp.MPWS_UNSAFE_NO=0 and hp.MPWS_UNSAFE_SUPPLY=0 order by d.dcode,m.mcode,p.pcode,v.vcode"; 
}else{
		getDnameQuery = "select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name from rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode='"+rDistrict+"' and substr (hd.hab_code,1,2)='"+rDistrict+"' and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and (hp.HPS_NO >0 or hp.HPS_NO_UNSAFE>0) and hp.cpws_no = 0 and hp.CPWS_SUPPLY = 0 and hp.pws_no=0 and hp.PWS_SUPPLY =0 and hp.mpws_no=0 and hp.MPWS_SUPPLY =0 and hp.OTHERS_NO_SAFE=0 and hp.OTHERS_SUPPLY_SAFE =0 and hp.PWS_UNSAFE_NO=0 and hp.PWS_UNSAFE_SUPPLY=0 and hp.MPWS_UNSAFE_NO=0 and hp.MPWS_UNSAFE_SUPPLY=0 order by d.dcode,m.mcode,p.pcode,v.vcode"; 
}
		System.out.println("query:"+getDnameQuery);
		pst=conn.createStatement();
		rs2 = pst.executeQuery(getDnameQuery); 
		int sno = 1;double Lpcd=0.0;
		while(rs2.next())
		{
		    			
			%>
			<tr>
				<td class=rptValue><%=sno++ %></td>
				<td class="rptValue"><%=rs2.getString(1) %></td>
<td class="rptValue"><%=rs2.getString(2) %></td>
<td class="rptValue"><%=rs2.getString(3) %></td>
<td class="rptValue"><%=rs2.getString(4) %></td>
<td class="rptValue"><%=rs2.getString(5) %></td>
<td class="rptValue"><%=rs2.getString(6) %></td>
				</tr>
				<%
		} 
					
}
catch(Exception e)
{
	e.printStackTrace();
}


 %>
</table>
</body>
</html>

