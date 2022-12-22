<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%		
		
	String query = null,query1=null,currentYear=null,fdate=null,query2=null,query22=null,query3=null,query4=null,query5=null,query6=null,query7=null,
	query8=null,query9=null,query10=null;
	Statement st1=null,st22=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null,st9=null,st10=null;
	ResultSet rs2=null,rs1=null,rs22=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0;
	
    String[] popRange = {"100","500","501","1001","1501","2001","3001","4001","5001"};
int total1=0,total2=0,total22=0,total222=0,total3=0,total4=0,total5=0,total6=0,total7=0,total8=0,total9=0,total10=0,total11=0,total12=0,total13=0,total14=0,total15=0,total16=0,total17=0,total18=0;
	String per = request.getParameter("per");
	if(per==null)per="";
	String type = request.getParameter("type");
	if(type==null)type="";
	//System.out.println("per:"+per);
%>
<html>
<title> WaterSoft </title>
<head>
<script>
window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">
<table width="880" align="center">
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr>
		<td class="textborder" align="center" colspan="4">Select Coverage  Status&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="per" class="mycombo">
			<%if(per==null && per.equals("")){%>
				<option value="" selected>ALL</option>
			<%}
			else
			{
				%>
					<option value="">ALL</option>
				<%if(per!=null && per.equals("FC")){%>
					<option value="FC" selected>FC</option>
				<%}
				else
				{
				%>
					<option value="FC">FC</option>
				<%
				}if(per!=null && per.equals("PC4")){%>
					<option value="PC4" selected>PC4</option>
				<%}
				else
				{
				%>
					<option value="PC4">PC4</option>
				<%
				}if(per!=null && per.equals("PC3")){%>
					<option value="PC3" selected>PC3</option>
				<%}
				else
				{
				%>
					<option value="PC3">PC3</option>
				<%
				}if(per!=null && per.equals("PC2")){%>
					<option value="PC2" selected>PC2</option>
				<%}
				else
				{
				%>
					<option value="PC2">PC2</option>
				<%
				}if(per!=null && per.equals("PC1")){%>
					<option value="PC1" selected>PC1</option>
				<%}
				else
				{
				%>
					<option value="PC1">PC1</option>
				<%
				}if(per!=null && per.equals("NSS")){%>
					<option value="NSS" selected>NSS</option>
				<%}
				else
				{
				%>
					<option value="NSS">NSS</option>
				<%
				}if(per!=null && per.equals("NC")){%>
					<option value="NC" selected>NC</option>
				<%}
				else
				{
				%>
					<option value="NC">NC</option>
				<%
				}
			}%>
		</select>
		</font></td>
		<td class="textborder" align="center" colspan="4">Select Hab Type&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<select name="type" class="mycombo">
		<%if(type==null && type.equals("")){%>
	<option value="" selected>ALL</option>
<%}
else
{
	%>
		<option value="">ALL</option>
	<%if(type!=null && type.equals("PLAIN")){%>
		<option value="PLAIN" selected>PLAIN</option>
	<%}
	else
	{
	%>
		<option value="PLAIN">PLAIN</option>
	<%
	}if(type!=null && type.equals("SC")){%>
		<option value="SC" selected>SC</option>
	<%}
	else
	{
	%>
		<option value="SC">SC</option>
	<%
	}if(type!=null && type.equals("ST")){%>
		<option value="ST" selected>ST</option>
	<%}
	else
	{
	%>
		<option value="ST">ST</option>
	<%
	}
	}
	%>
</select>
</td>
	</tr>
	<tr><td colspan="8" align="center">
		<input type="button" value="Get Report" onClick="this.form.submit()" class="btext">
	</td></tr>
</table><BR>
<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">DistrictWise-Population Report </font></td>
	</tr>
<tr><td valign=top>


<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr  align="center">
		<td align="center" class="rptValue" colspan=22>District: All</td>		
	</tr>	
	<tr align=center  align=center>
		<td class=btext rowspan = 3>Sl.No</td>
		<td class=btext rowspan = 3>District</td>
		<td class=btext colspan = 20 align="Center">Population Range&nbsp;&nbsp;</td>
	</tr>
	<tr>
	    <td class=btext colspan = 2 align="center">Total</td>
		<td class=btext colspan = 2 align="center">Upto 100</td>
		<td class=btext colspan = 2 align="center">101-500</td>
		<td class=btext colspan = 2 align="center">501-1000</td>
		<td class=btext colspan = 2 align="center">1001-1500</td>
		<td class=btext colspan = 2 align="center">1501-2000</td>
		<td class=btext colspan = 2 align="center">2001-3000</td>
		<td class=btext colspan = 2 align="center">3001-4000</td>
		<td class=btext colspan = 2 align="center">4001-5000</td>
        <td class=btext colspan = 2 align="center">Beyond 5001</td>
	</tr>
	<tr align = center>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td> 
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
		<td class=btext>No(Habs)</td>
		<td class=btext>Pop</td>
	</tr>
	<%


	try
		{
	st2=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

rs2=st2.executeQuery("select distinct d.dcode,d.dname from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  order by d.dcode,d.dname");
while(rs2.next())
		{
	
int j=0;
System.out.println("popRange[j]:"+popRange[j]);
	            if(popRange[j].equals("100"))
				{
					query22 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and ((hd.census_plain_popu is null or hd.census_sc_popu is null or hd.census_st_popu is null) or(hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='100'))";
					if(per!=null && !per.equals(""))query22+=" and hd.coverage_status='"+per+"'";
					if(type!=null && !type.equals(""))query22+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				if(popRange[j+1].equals("500"))
				{
					query3 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and ((hd.census_plain_popu is null or hd.census_sc_popu is null or hd.census_st_popu is null) or(hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='500' and hd.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >= '101'))";
					if(per!=null && !per.equals(""))query3+=" and hd.coverage_status='"+per+"'";
					if(type!=null && !type.equals(""))query3+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
			    if(popRange[j+2].equals("501"))
				{
				query4 ="SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query4 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1000'";
				if(per!=null && !per.equals(""))query4+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query4+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				 if(popRange[j+3].equals("1001"))
				{
				query5 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1500' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query5 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='1500'";
				if(per!=null && !per.equals(""))query5+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query5+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				  if(popRange[j+4].equals("1501"))
				{
				query6 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='2000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query6 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='1501' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='2000'";
				if(per!=null && !per.equals(""))query6+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query6+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				  if(popRange[j+5].equals("2001"))
				{
				query7 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='2001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='3000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query7 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='2001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='3000'";
				if(per!=null && !per.equals(""))query7+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query7+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				  if(popRange[j+6].equals("3001"))
				{
				query8 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2)  and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='3001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='4000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query8 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='3001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='4000'";
				if(per!=null && !per.equals(""))query8+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query8+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				  if(popRange[j+7].equals("4001"))
				{
				query9 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='4001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='5000' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query9 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='4001' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu <='5000'";
				if(per!=null && !per.equals(""))query9+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query9+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
				  if(popRange[j+8].equals("5001"))
				{
				query10 ="SELECT DISTINCT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_habitation_directory_tbl HD  where d.dcode=substr(HD.hab_code,1,2) and coverage_status <> 'UI' and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='5001' and substr(HD.hab_code,1,2)='"+rs2.getString(1)+"'";
				query10 = "SELECT count(hd.hab_code),sum(HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu) as tot from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'  and HD.census_plain_popu+hd.census_sc_popu+hd.census_st_popu >='5001'";
				if(per!=null && !per.equals(""))query10+=" and hd.coverage_status='"+per+"'";
				if(type!=null && !type.equals(""))query10+=" and hd.HABITATION_SUB_TYPE='"+type+"'";
				}
			
//				System.out.println("query is"+query22);
				try
			{
st22=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st3=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st4=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st5=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st6=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st7=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st8=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st9=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
st10=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

				rs22 = st22.executeQuery(query22);
				rs22.next();
				rs3 = st3.executeQuery(query3);
				rs3.next();
				rs4 = st4.executeQuery(query4);
				rs4.next();
				rs5 = st5.executeQuery(query5);
				rs5.next();
				rs6 = st6.executeQuery(query6);
				rs6.next();
				rs7= st7.executeQuery(query7);
				rs7.next();
				rs8= st8.executeQuery(query8);
				rs8.next();
				rs9 = st9.executeQuery(query9);
				rs9.next();
				rs10 = st10.executeQuery(query10);
				rs10.next();
				total1 += rs22.getInt(1)+rs3.getInt(1)+rs4.getInt(1)+rs5.getInt(1)+rs6.getInt(1)+rs7.getInt(1)+rs8.getInt(1)+rs9.getInt(1)+rs10.getInt(1);
				total2 += rs22.getInt(2)+rs3.getInt(2)+rs4.getInt(2)+rs5.getInt(2)+rs6.getInt(2)+rs7.getInt(2)+rs8.getInt(2)+rs9.getInt(2)+rs10.getInt(2);
				total22 += rs22.getInt(1);total222 += rs22.getInt(2);
				total3 += rs3.getInt(1);total4 += rs3.getInt(2);
				total5 += rs4.getInt(1);total6 += rs4.getInt(2);
				total7 += rs5.getInt(1);total8 += rs5.getInt(2);
				total9 += rs6.getInt(1);total10 += rs6.getInt(2);
				total11 += rs7.getInt(1);total12 += rs7.getInt(2);				
				total13 += rs8.getInt(1);total14 += rs8.getInt(2);
				total15 += rs9.getInt(1);total16 += rs8.getInt(2);
				total17 += rs10.getInt(1);total18 += rs10.getInt(2);

				%>
				<tr>	
		     <td class=rptValue><%=++sno%></td>
		     <td class=rptValue nowrap><%=rs2.getString(2)%></td>
			 <td class=btext><%=rs22.getInt(1)+rs3.getInt(1)+rs4.getInt(1)+rs5.getInt(1)+rs6.getInt(1)+rs7.getInt(1)+rs8.getInt(1)+rs9.getInt(1)+rs10.getInt(1)
					%></td>
			 <td class=btext><%=rs22.getInt(2)+rs3.getInt(2)+rs4.getInt(2)+rs5.getInt(2)+rs6.getInt(2)+rs7.getInt(2)+rs8.getInt(2)+rs9.getInt(2)+rs10.getInt(2)
					%></td>
		    <td class=rptValue><%=rs22.getInt(1)%></td>
		    <td class=rptValue><%=rs22.getInt(2)%></td>
		    <td class=rptValue><%=rs3.getInt(1)%></td>
			 <td class=rptValue><%=rs3.getInt(2)%></td>
			<td class=rptValue><%=rs4.getInt(1)%></td>
			 <td class=rptValue><%=rs4.getInt(2)%></td>
			<td class=rptValue><%=rs5.getInt(1)%></td>
			 <td class=rptValue><%=rs5.getInt(2)%></td>
			<td class=rptValue><%=rs6.getInt(1)%></td>
			<td class=rptValue><%=rs6.getInt(2)%></td>
			<td class=rptValue><%=rs7.getInt(1)%></td>
			<td class=rptValue><%=rs7.getInt(2)%></td>
			<td class=rptValue><%=rs8.getInt(1)%></td>
			<td class=rptValue><%=rs8.getInt(2)%></td>
			<td class=rptValue><%=rs9.getInt(1)%></td>
			<td class=rptValue><%=rs9.getInt(2)%></td>
			<td class=rptValue><%=rs10.getInt(1)%></td>
			<td class=rptValue><%=rs10.getInt(2)%></td>
            </tr>
<%
			}
			
				catch(Exception e)
			{}
				finally
			{
					rs22.close();rs3.close();rs4.close();rs5.close();rs6.close();rs7.close();rs8.close();rs9.close();rs10.close();
					st22.close();st3.close();st4.close();st5.close();st6.close();st7.close();st8.close();st9.close();st10.close();
			}
				}
				%>
				<tr>
								<td class="btext" colspan="2">Total</td> 
								<td class="btext"><%=total1%></td> 
								<td class="btext"><%=total2%></td> 
								<td class="btext"><%=total22%></td> 
								<td class="btext"><%=total222%></td> 
								<td class="btext"><%=total3%></td> 
								<td class="btext"><%=total4%></td> 
								<td class="btext"><%=total5%></td> 
								<td class="btext"><%=total6%></td> 
								<td class="btext"><%=total7%></td> 
								<td class="btext"><%=total8%></td> 
								<td class="btext"><%=total9%></td> 
								<td class="btext"><%=total10%></td> 
								<td class="btext"><%=total11%></td> 
								<td class="btext"><%=total12%></td> 
								<td class="btext"><%=total13%></td> 
								<td class="btext"><%=total14%></td> 
								<td class="btext"><%=total15%></td> 
								<td class="btext"><%=total16%></td> 
								<td class="btext"><%=total17%></td> 
								<td class="btext"><%=total18%></td> 
							</tr>
				<%
		}
		catch(Exception e)
		{}
		finally
		{
			rs2.close();
			st2.close();
			conn.close();
		}
	%>
</table></table>
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>

