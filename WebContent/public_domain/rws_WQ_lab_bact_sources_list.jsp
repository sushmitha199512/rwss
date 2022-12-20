<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp" %>

<%@ include file="/commons/rws_header2.jsp"%>

<%
//System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict=null;
ResultSet rs1=null,rs2=null;
Statement pst = null;
PreparedStatement ps1=null;
ArrayList bactSourcesList=new ArrayList((HashSet)session.getAttribute("bactSourcesList"));

%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=14> Souces with Bacteriological
		Contaminants (Faecal Coliform)  and Habitations  </td>	
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
			<td class=btext >Source Code</td>
			<td class=btext >Source Name</td>
			<td class=btext >Source Location</td>
 		</tr>
	<%
String getDnameQuery="";

String sCode="";int sno = 1;
String sourcetgable ="";
for(int i=0;i<bactSourcesList.size();i++){
		
 sCode=(String)bactSourcesList.get(i);
if(sCode.substring(19,21).equals("HP")){
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.hp_code,nvl(st.location,'-') from rws_hp_subcomp_param_tbl st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.hp_code='"+sCode+"' and substr(st.hp_code,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
sourcetgable="rws_hp_subcomp_param_tbl";
}else if(sCode.substring(19,21).equals("SO"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.source_code,nvl(st.source_name,'-'),nvl(st.location,'-') from RWS_SOURCE_TBL st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.source_code='"+sCode+"' and substr(st.source_code,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}else if(sCode.substring(19,21).equals("PD"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.pond_code,nvl(st.pond_name,'-'),nvl(st.pond_location,'-') from RWS_OPENWELL_POND_TBL st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.pond_code='"+sCode+"' and substr(st.pond_code,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}
else if(sCode.substring(19,21).equals("OW"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.openwell_code,nvl(st.location,'-') from rws_open_well_mast_tbl st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.openwell_cod='"+sCode+"' and substr(st.openwell_code,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}
else if(sCode.substring(19,21).equals("SH"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.SHALLOWHP_CODE,nvl(st.location,'-') from rws_shallowhandpumps_tbl st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.SHALLOWHP_CODE='"+sCode+"' and substr(st.SHALLOWHP_CODE,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}
else if(sCode.substring(19,21).equals("GL"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.GLSR_CODE,nvl(st.GLSR_LOC,'-') from RWS_ast_glsr_sc_param_tbl st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.GLSR_CODE='"+sCode+"' and substr(st.GLSR_CODE,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}
else if(sCode.substring(19,21).equals("GB"))
{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name,st.GLBR_CODE,nvl(st.GLBR_LOC,'-') from RWS_ast_glbr_sc_param_tbl st,rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and st.GLBR_CODE='"+sCode+"' and substr(st.GLBR_CODE,1,16)=hd.hab_code and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}

else{
getDnameQuery="select d.dname,m.mname,p.pname,v.vname,hd.hab_code,h.panch_name from rws_hab_supply_status_tbl hp,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where hd.hab_code='"+sCode.substring(0,16)+"' and  d.dcode=substr (hd.hab_code,1,2) and  d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and  substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and  substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code  and hp.hab_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' ";
}
	
//0506140012111200600SO001




		System.out.println("query:"+getDnameQuery);
		pst=conn.createStatement();
		rs2 = pst.executeQuery(getDnameQuery); 
		double Lpcd=0.0;
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
<% 
		if(sCode.substring(19,21).equals("HP") || sCode.substring(19,21).equals("OW")|| sCode.substring(19,21).equals("SH")){
%>
<td><%=rs2.getString(7) %></td>
<td>-</td>
<td><%=rs2.getString(8) %></td>

<% } else if(sCode.substring(19,21).equals("SO") || sCode.substring(19,21).equals("PD")){%>
<td><%=rs2.getString(7) %></td>
<td><%=rs2.getString(8) %></td>
<td><%=rs2.getString(9) %></td>
 

<%} else if(sCode.substring(19,21).equals("GL") ||sCode.substring(19,21).equals("GB")) {
%>
<td><%=rs2.getString(7) %></td>
<td><%=rs2.getString(8) %></td>
<td>-</td>
<% 
}else{%>
<td></td><td></td><td></td>
<%} %>
				</tr>
				<%
		} 

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

