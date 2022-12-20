<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="conn.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%
////System.out.println("rDistrict:"+request.getParameter("rDistrict"));
ResultSet rs1 =null,rs2=null;
PreparedStatement ps1=null;
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null,excelnav="";
////System.out.println("excelnav----------->"+session.getAttribute("excelnav"));
 excelnav=(String)session.getAttribute("excelnav");
rDistrict=(String)session.getAttribute("rDistrict");
////System.out.println("rDistrict----------->"+session.getAttribute("rDistrict"));
rDistrictName=(String)session.getAttribute("rDistrictName");
rMandal=(String)session.getAttribute("rMandal");
rMandalName=(String)session.getAttribute("rMandalName");
rPanchayat=(String)session.getAttribute("rPanchayat");
rPanchayatName=(String)session.getAttribute("rPanchayatName");
String covStatusQry = (String)session.getAttribute("covStatusQryy");
String covStatusPrint = (String)session.getAttribute("covStatusPrint");
String drill = "";

////System.out.println("Drill:"+drill);
if(excelnav!=null && excelnav.equals("0"))
{
////System.out.println("in if excelnav 0 loop");
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr align="center">
			<td align="center" class="rptHeading" colspan=15>Assets-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
////System.out.println("in try block");
////System.out.println("Here---------in try --->1 --->"+rDistrict);
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	////System.out.println("Here------------>1");
	
	%>
		<tr align="center" bgcolor="#ffffff">
			<td rowspan=2>Sno</td>
			<td  rowspan=2>District</td>			
			<td  colspan=5 align=center>Safe</td>
			<td  colspan=7 align=center>Un Safe</td>
			<td  rowspan=2>Total&nbsp;Assets<br>District-wise</td>	
		</tr>
		<tr align="center">
			<td >No. of HPs</td>
			<td >No. of CPWS</td>
			<td >No. of PWS</td>
			<td >No. of MPWS</td>
			<td >Others</td>
			<td >No. of HPs</td>
			<td >PWS(UnSafe)</td>
			<td >MPWS(UnSafe)</td>
			<td >Open Wells </td>
			<td >Ponds</td>
			<td >Shallow Hand Pumps</td>
			<td >Others</td>
		</tr>
				<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
		////System.out.println("query:"+getDnameQuery);
			////System.out.println("Here------------>2");
		 ps1=conn.prepareStatement(getDnameQuery);
		 rs2 = ps1.executeQuery(); 
			////System.out.println("Here------------>3");
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		while(rs2.next())
		{
//			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when MPWS_UNSAFE_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when HPS_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l  from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"')";
			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'"+covStatusQry+")";
			////System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			 rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue><%=rs2.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td  colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal11%></td>
			<td class=rptValue><%=columnTotal12%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
			<td class=rptValue><%=columnTotal9%></td>
			<td class=rptValue><%=columnTotal10%></td>
			<td class=rptValue><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
		</tr>
		<%
	}
	else
	{	////System.out.println("Here------------>3");
	     String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rDistrict+"')";
		////System.out.println("query:"+getDataQuery);
		ps=conn.prepareStatement(getDataQuery);
		 rs1 = ps.executeQuery();
		
		String getDnameQuery = "select dname from rws_district_tbl where dcode='"+rDistrict+"'";
		////System.out.println("query:"+getDataQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery();
		rs2.next();
		int sno = 1;
		if(rs1.next())
		{
		%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2>District</td>
			<td  colspan=5 align=center>Safe</td>
			<td  colspan=7 align=center>Un Safe</td>
			<td  rowspan=2>Total&nbsp;Assets<br>District-wise</td>	
		</tr>
		<tr align="center">
			<td >No. of HPs</td>
			<td >No. of CPWS</td>
			<td >No. of PWS</td>
			<td >No. of MPWS</td>
			<td >Others</td>
			<td >No. of HPs</td>
			<td >PWS(UnSafe)</td>
			<td >MPWS(UnSafe)</td>
			<td >Open Wells </td>
			<td >Ponds</td>
			<td >Shallow Hand Pumps</td>
			<td >Others</td>
		</tr>
				<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class="rptValue"><%=rs2.getString(1)%></td>
			<td class=rptValue><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>			
		</tr>
		<%
		}
	}
	%>
	 
				
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(ps1!=null){ps1.close();}
if(ps!=null){ps.close();}
if(conn!=null){conn.close();}
}
}
else if(excelnav!=null && excelnav.equals("2"))
{

%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr align="center">
			<td align="center" class="rptHeading" colspan=15>Assets-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->
<%
try
{

	%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2 nowrap>Mandal</td>			
			<td  colspan=5 align=center>Safe</td>
			<td  colspan=7 align=center>Un Safe</td>
			<td  rowspan=2>Total&nbsp;Assets<br>Mandal-wise</td>	
		</tr>
		<tr align="center">
			<td >No. of HPs</td>
			<td >No. of CPWS</td>
			<td >No. of PWS</td>
			<td >No. of MPWS</td>
			<td >Others</td>
			<td >No. of HPs</td>
			<td >PWS(UnSafe)</td>
			<td >MPWS(UnSafe)</td>
			<td >Open Wells </td>
			<td >Ponds</td>
			<td >Shallow Hand Pumps</td>
			<td >Others</td>
		</tr>
				<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
		<%
			String getDnameQuery1 = "select dname from rws_district_tbl where dcode = '"+rDistrict+"'";
			////System.out.println("query:"+getDnameQuery);
			PreparedStatement ps2=conn.prepareStatement(getDnameQuery1);
			ResultSet rs3 = ps2.executeQuery(); 
			rs3.next();
			
		 %>
		<tr>
			<td   colspan="15">District:<%=rs3.getString(1)%></td>
		</tr>
		<%
		String getMnameQuery = "select m.mcode,m.mname,d.dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and m.dcode = '"+rDistrict+"' order by m.dcode";
		////System.out.println("query:"+getMnameQuery);
		ps1=conn.prepareStatement(getMnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		
		while(rs2.next())
		{
			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rDistrict+"' and m.mcode='"+rs2.getString(1)+"'"+covStatusQry+")";
			
		////System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue><%=rs2.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td  colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal11%></td>
			<td class=rptValue><%=columnTotal12%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
			<td class=rptValue><%=columnTotal9%></td>
			<td class=rptValue><%=columnTotal10%></td>
			<td class=rptValue><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
		</tr>
		<%
	}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(ps1!=null){ps1.close();}
if(ps!=null){ps.close();}
if(conn!=null){conn.close();}
}	
} else if(excelnav!=null && excelnav.equals("3"))
{

%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<tr align="center">
			<td align="center" class="rptHeading" colspan=15>Assets-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->
<%
try
{

	%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2 nowrap>Panchayat</td>			
			<td  colspan=5 align=center>Safe</td>
			<td  colspan=7 align=center>Un Safe</td>
			<td  rowspan=2>Total&nbsp;Assets<br>Panchayat-wise</td>	
		</tr>
		<tr align="center">
			<td >No. of HPs</td>
			<td >No. of CPWS</td>
			<td >No. of PWS</td>
			<td >No. of MPWS</td>
			<td >Others</td>
			<td >No. of HPs</td>
			<td >PWS(UnSafe)</td>
			<td >MPWS(UnSafe)</td>
			<td >Open Wells </td>
			<td >Ponds</td>
			<td >Shallow Hand Pumps</td>
			<td >Others</td>
		</tr>
				<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
		<%
			String getDnameQuery1 = "select dname from rws_district_tbl where dcode = '"+rDistrict+"'";
			////System.out.println("query:"+getDnameQuery);
			PreparedStatement ps2=conn.prepareStatement(getDnameQuery1);
			ResultSet rs3 = ps2.executeQuery(); 
			rs3.next();
			
		 %>
		<tr>
			<td   colspan="15">District:<%=rs3.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%></td>
		</tr>
		<%
	
        String getpnameQuery="Select p.pcode,p.pname from rws_panchayat_tbl p where p.dcode='"+rDistrict+"' and p.mcode='"+rMandal+"' order by pcode";		
		////System.out.println("query:"+getpnameQuery);
		ps1=conn.prepareStatement(getpnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		
		while(rs2.next())
		{
			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rDistrict+"' and m.mcode='"+rMandal+"' and p.pcode='"+rs2.getString(1)+"'"+covStatusQry+")";
			
			////System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue ><%=rs2.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td  colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal11%></td>
			<td class=rptValue><%=columnTotal12%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
			<td class=rptValue><%=columnTotal9%></td>
			<td class=rptValue><%=columnTotal10%></td>
			<td class=rptValue><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
		</tr>
		<%
	}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(ps1!=null){ps1.close();}
if(ps!=null){ps.close();}
if(conn!=null){conn.close();}
}	
}  else if(excelnav!=null && excelnav.equals("4"))
{

%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr align="center">
			<td align="center" class="rptHeading" colspan=15>Assets-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->
<%
try
{

	%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2 nowrap>Village</td>			
			<td  colspan=5 align=center>Safe</td>
			<td  colspan=7 align=center>Un Safe</td>
			<td  rowspan=2>Total&nbsp;Assets<br>Village-wise</td>	
		</tr>
		<tr align="center">
			<td >No. of HPs</td>
			<td >No. of CPWS</td>
			<td >No. of PWS</td>
			<td >No. of MPWS</td>
			<td >Others</td>
			<td >No. of HPs</td>
			<td >PWS(UnSafe)</td>
			<td >MPWS(UnSafe)</td>
			<td >Open Wells </td>
			<td >Ponds</td>
			<td >Shallow Hand Pumps</td>
			<td >Others</td>
		</tr>
				<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
		<%
			String getDnameQuery1 = "select dname from rws_district_tbl where dcode = '"+rDistrict+"'";
			////System.out.println("query:"+getDnameQuery);
			PreparedStatement ps2=conn.prepareStatement(getDnameQuery1);
			ResultSet rs3 = ps2.executeQuery(); 
			rs3.next();
			
		 %>
		<tr>
			<td   colspan="15">District:<%=rs3.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%>&nbsp;&nbsp;&nbsp;&nbsp;Panchayat:<%=rPanchayatName%></td>
		</tr>
		<%
		//String getDnameQuery = "select m.mcode,m.mname,d.dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and m.dcode = '"+rDistrict+"' order by m.dcode";
        String getvnameQuery="Select v.vcode,v.vname from rws_village_tbl v where v.dcode='"+rDistrict+"' and v.mcode='"+rMandal+"' and v.pcode='"+rPanchayat+"' order by vcode";		
		////System.out.println("query:"+getvnameQuery);
		ps1=conn.prepareStatement(getvnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		
		while(rs2.next())
		{
			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rDistrict+"' and m.mcode='"+rMandal+"' and p.pcode='"+rPanchayat+"' and v.vcode='"+rs2.getString(1)+"'"+covStatusQry+")";
			
			////System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue ><%=rs2.getString(2)%></td>
			<td class=rptValue><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td  colspan="2">Total</td>
			<td class=rptValue><%=columnTotal1%></td>
			<td class=rptValue><%=columnTotal2%></td>
			<td class=rptValue><%=columnTotal3%></td>
			<td class=rptValue><%=columnTotal4%></td>
			<td class=rptValue><%=columnTotal5%></td>
			<td class=rptValue><%=columnTotal6%></td>
			<td class=rptValue><%=columnTotal11%></td>
			<td class=rptValue><%=columnTotal12%></td>
			<td class=rptValue><%=columnTotal7%></td>
			<td class=rptValue><%=columnTotal8%></td>
			<td class=rptValue><%=columnTotal9%></td>
			<td class=rptValue><%=columnTotal10%></td>
			<td class=rptValue><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
		</tr>
		<%
	}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{if(rs1!=null){rs1.close();}
if(rs2!=null){rs2.close();}
if(ps1!=null){ps1.close();}
if(ps!=null){ps.close();}
if(conn!=null){conn.close();}
}	

}

%>
</table>
</body>
</html>
