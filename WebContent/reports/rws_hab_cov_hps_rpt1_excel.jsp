<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="conn.jsp"%>
<%
//System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;
ResultSet rs1=null,rs2=null,prs = null,vrs =null,hrs = null,mrs=null,crs=null,othrs =null;
Statement pst = null, vst = null ,cst = null , hst = null,getHabSt=null,stmt1=null,mst=null,othst=null;
PreparedStatement ps1=null;
rDistrict = (String)session.getAttribute("rDistrict");
String dname = (String)session.getAttribute("rDistrictName");
String drill = (String)session.getAttribute("drill");
rDistrictName = (String)session.getAttribute("rDistrictName");
rMandal = (String)session.getAttribute("rMandal");
rMandalName = (String)session.getAttribute("rMandalName");
rPanchayat = (String)session.getAttribute("rPanchayat");
rPanchayatName = (String)session.getAttribute("rPanchayatName");
System.out.println("Drill:"+drill);
if(drill.equals("null"))
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
			<td align="center" class="rptHeading" colspan=6>Coverage of Habitations  by Hand Pumps only (without schemes)</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	//System.out.println("rDistrict :"+rDistrict);
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2>District</td>
			<td  rowspan=2>No. of Habs</td>	
			<td  rowspan=2>Pop</td>	
			 <td  colspan="2" >Habs covered by HPs only</td>
 		</tr>
		<tr align="center">
			<td >No</td>
			<td >Pop</td>
			
		</tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
		//System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";int GTotal=0,count1pop=0;
		int cpcount=0,cpwspop=0,Gcpwstotal=0,mpwspop=0,GmpwsTotal=0,pwspop=0,GpwsTotal=0,othpop=0,GothTotal=0,othcount=0,cpcount1=0;
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0,mcount=0,mcountTotal=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select sum(case when ((HPS_NO <>'0' or HPS_NO_UNSAFE<>'0') and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then 1 else 0 end) as ab,sum(case when ((HPS_NO <>'0' or HPS_NO_UNSAFE<>'0')  and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then HPS_NO + HPS_NO_UNSAFE  else 0 end) as a,sum(case when ((HPS_NO <>'0' or HPS_OTH_SUPPLY <> '0' or HPS_NO_UNSAFE<>'0' or HPS_OTH_SUPPLY_UNSAFE <> '0' ) and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end) as aa from rws_hab_supply_status_tbl hp, rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and substr (hp.hab_code,1,2)='"+rs2.getString(1)+"' and hd.hab_code=hp.hab_code ";
			mcount=0;cpcount=0;count1pop=0;
			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
			FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;cpwspop=0;mpwspop=0;pwspop=0;othpop=0;othcount=0;
			
			hst = conn.createStatement();
			hrs = hst.executeQuery(hQuery);
			
			while(hrs.next())
			{
				hcount++;calCoverageStatus = "";
				totalpop=totalpop+hrs.getInt(2);
				
				
			}			
			%>
			<tr>
				<td class=rptValue><%=sno++%></td>
				<td class="rptValue"><%=rs2.getString(2)%></td>
				<td class=rptValue><%=hcount%></td>
				<td class=rptValue><%=totalpop%></td>
				<% 
				cst = conn.createStatement();
			    crs = cst.executeQuery(cpQuery);
				while(crs.next())
				{
				cpcount1=crs.getInt(1);
				cpcount=crs.getInt(2);
				cpwspop=cpwspop+crs.getInt(3);
				%>
				<td class=rptValue><%=cpcount1%></td>
				<td class=rptValue><%=cpcount%></td>
				<td class=rptValue><%=cpwspop%></td>				
					<%} %>
				
			</tr>
			<%
			
			Gtotalpop+=totalpop;
			columnTotal3 += hcount;
			Gcpwstotal+=cpwspop;
			columnTotal4 +=cpcount1;
			columnTotal5 +=cpcount;
					       
		}
		%>
		<tr>
				<td class=btext colspan="2">Total</td>
				<td class=btext><%=columnTotal3%></td>
				<td class=btext><%=Gtotalpop%></td>
				<td class=btext><%=columnTotal4%></td>
				<td class=btext><%=columnTotal5%></td>
				<td class=btext><%=Gcpwstotal%></td>
								
			</tr>
	<%}
	
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(crs!=null){crs.close();}
if(cst!=null){cst.close();}
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(conn!=null){conn.close();}
}
} else if(drill!=null && drill.equals("next")){
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		
		<tr align="center">
			<td align="center" class="rptHeading" colspan=6>Coverage of Habitations  by Hand Pumps only (without schemes)</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	if(rDistrict!=null && !rDistrict.equals(""))
	{
	%>
		<tr align="center" bgcolor="#ffffff">
			<td  rowspan=2>Sno</td>
			<td  rowspan=2>District</td>
			<td  rowspan=2>No. of Habs</td>	
			<td  rowspan=2>Pop</td>	
			 <td  colspan="2" >Habs covered by HPs only</td>
 		</tr>
		<tr align="center">
			<td >No</td>
			<td >Pop</td>
			
		</tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode ='"+rDistrict+"' order by dcode";
		System.out.println("querysss:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";int GTotal=0,count1pop=0;
		int cpcount=0,cpwspop=0,Gcpwstotal=0,mpwspop=0,GmpwsTotal=0,pwspop=0,GpwsTotal=0,othpop=0,GothTotal=0,othcount=0,cpcount1=0;
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0,mcount=0,mcountTotal=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select sum(case when ((HPS_NO <>'0' or HPS_NO_UNSAFE<>'0') and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then 1 else 0 end) as ab,sum(case when ((HPS_NO <>'0' or HPS_NO_UNSAFE<>'0')  and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then HPS_NO + HPS_NO_UNSAFE  else 0 end) as a,sum(case when ((HPS_NO <>'0' or HPS_OTH_SUPPLY <> '0' or HPS_NO_UNSAFE<>'0' or HPS_OTH_SUPPLY_UNSAFE <> '0' ) and cpws_no = '0' and CPWS_SUPPLY = '0' and pws_no='0' and PWS_SUPPLY ='0' and mpws_no='0' and MPWS_SUPPLY ='0' and OTHERS_NO_SAFE='0' and OTHERS_SUPPLY_SAFE ='0' and PWS_UNSAFE_NO='0' and PWS_UNSAFE_SUPPLY='0' and MPWS_UNSAFE_NO='0' and MPWS_UNSAFE_SUPPLY='0') then CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU else 0 end) as aa from rws_hab_supply_status_tbl hp, rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and substr (hp.hab_code,1,2)='"+rs2.getString(1)+"' and hd.hab_code=hp.hab_code ";
			mcount=0;cpcount=0;count1pop=0;
			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
			FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;cpwspop=0;mpwspop=0;pwspop=0;othpop=0;othcount=0;
			
			hst = conn.createStatement();
			hrs = hst.executeQuery(hQuery);
			
			while(hrs.next())
			{
				hcount++;calCoverageStatus = "";
				totalpop=totalpop+hrs.getInt(2);
				
				
			}			
			%>
			<tr>
				<td class=rptValue><%=sno++%></td>
				<td class="rptValue"><%=rs2.getString(2)%></td>
				<td class=rptValue><%=hcount%></td>
				<td class=rptValue><%=totalpop%></td>
				<% 
				cst = conn.createStatement();
			    crs = cst.executeQuery(cpQuery);
				while(crs.next())
				{
				cpcount1=crs.getInt(1);
				cpcount=crs.getInt(2);
				cpwspop=cpwspop+crs.getInt(3);
				%>
				<td class=rptValue><%=cpcount1%></td>
				<td class=rptValue><%=cpcount%></td>
				<td class=rptValue><%=cpwspop%></td>				
					<%} %>
				
			</tr>
			<%
			
			Gtotalpop+=totalpop;
			columnTotal3 += hcount;
			Gcpwstotal+=cpwspop;
			columnTotal4 +=cpcount1;
			columnTotal5 +=cpcount;
					       
		}
		%>
		<tr>
				<td class=btext colspan="2">Total</td>
				<td class=btext><%=columnTotal3%></td>
				<td class=btext><%=Gtotalpop%></td>
				<td class=btext><%=columnTotal4%></td>
				<td class=btext><%=columnTotal5%></td>
				<td class=btext><%=Gcpwstotal%></td>
								
			</tr>
	<%}
	
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
if(crs!=null){crs.close();}
if(cst!=null){cst.close();}
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(conn!=null){conn.close();}
}
}
 %>
</table>
</body>
</html>

