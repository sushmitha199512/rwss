<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%

int styleCount=0;
String style="";
//System.out.println("rDistrict:"+request.getParameter("rDistrict"));
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;
ResultSet rs1=null,rs2=null,prs = null,vrs =null,hrs = null,mrs=null,crs=null,othrs =null;
Statement pst = null, vst = null ,cst = null , hst = null,getHabSt=null,stmt1=null,mst=null,othst=null;
PreparedStatement ps1=null;
rDistrict = request.getParameter("rDistrict");
if(rDistrict!=null){
session.setAttribute("rDistrict",rDistrict);
}
rDistrictName = request.getParameter("rDistrictName");
if(rDistrictName!=null){
session.setAttribute("rDistrictName",rDistrictName);
}
rMandal=request.getParameter("rMandal");
if(rMandal!=null){
session.setAttribute("rMandal",rMandal);
}
rMandalName=request.getParameter("rMandalName");
if(rMandalName!=null){
session.setAttribute("rMandalName",rMandalName);
}
rPanchayat=request.getParameter("rPanchayat");
if(rPanchayat!=null){
session.setAttribute("rPanchayat",rPanchayat);
}
rPanchayatName=request.getParameter("rPanchayatName");
if(rPanchayatName!=null){
session.setAttribute("rPanchayatName",rPanchayatName);
}
String dname = request.getParameter("rDistrictName");
if(rDistrictName!=null){
session.setAttribute("rDistrictName",dname);
}
String drill = request.getParameter("drill");
if(drill!=null){
session.setAttribute("drill",drill);
}
//System.out.println("Drill:"+drill);
if(drill.equals("null"))
{
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body >

<table border = 0 cellspacing = 0 cellpadding = 0 height=5% width="100%" style="border-collapse:collapse" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_habs_cov_schemes_rpt1_excel.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr class=gridhdbg >
			<td align="center"  colspan=16>Priority of Habitations Coverage by Schemes</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	
	
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	%>
		<tr align="center" >
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>District</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>	
			 <td class=gridhdbg colspan="10" >Habs covered by Schemes</td>
			<td class=gridhdbg colspan="2" >Habs covered by both CPWS and PWS/MPWS/DP</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>CPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>MPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>HP&SHP</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Others(DP)</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Habs</td>
			<td class=gridhdbg>Pop</td>
			
		</tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
		//System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0,hpcount=0,hppop=0;;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";int GTotal=0,count1pop=0;
		int cpcount=0,cpwspop=0,Gcpwstotal=0,mpwspop=0,GmpwsTotal=0,pwspop=0,GpwsTotal=0,othpop=0,GothTotal=0,othcount=0;
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0,mcount=0,mcountTotal=0,ghpcount=0,ghppop=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select sum(case when (cpws_supply >0) then 1 else 0 end) as b,sum(case when (cpws_supply >0)then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as bb,sum (case when (pws_supply>0 and cpws_supply =0 ) then 1 else 0 end) as c,sum (case when (pws_supply>0 and cpws_supply =0 ) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as cc,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0 ) then 1 else 0 end) as d,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as dd,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then 1 else 0 end) as e,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ee,sum(case when (cpws_supply >0 and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0)) then 1 else 0 end) as f,sum(case when (cpws_supply >0) and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ff,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then 1 else 0 end) as g,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as gg from rws_hab_supply_status_tbl hp, rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and substr (hp.hab_code,1,2)='"+rs2.getString(1)+"' and hd.hab_code=hp.hab_code ";
			mcount=0;cpcount=0;count1pop=0;
			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
			FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;cpwspop=0;mpwspop=0;pwspop=0;othpop=0;othcount=0;
			hpcount=0;hppop=0;
			hst = conn.createStatement();
			hrs = hst.executeQuery(hQuery);
			
			while(hrs.next())
			{
				hcount++;calCoverageStatus = "";
				totalpop=totalpop+hrs.getInt(2);
				
				
			}			
			%>
			<tr>
				<td class=<%=style %> style="text-align: left;"><%=sno++%></td>
				<td class=<%=style %> style="text-align: left;"><%=rs2.getString(2)%></td>
				<td class=<%=style %> style="text-align: right;"><%=hcount%></td>
				<td class=<%=style %> style="text-align: right;"><%=totalpop%></td>
				<% 
				cst = conn.createStatement();
//System.out.println("Query12:"+cpQuery);
			    crs = cst.executeQuery(cpQuery);
			    while(crs.next())
				{
					
					
					
				cpcount=crs.getInt(1);
				cpwspop=cpwspop+crs.getInt(2);
				pcount=crs.getInt(3);
				pwspop=pwspop+crs.getInt(4);
				mcount=crs.getInt(5);
				mpwspop=mpwspop+crs.getInt(6);
				othcount=crs.getInt(7);
				othpop=othpop+crs.getInt(8);
				count1 =crs.getInt(9);
				count1pop=count1pop+crs.getInt(10);
				hpcount=crs.getInt(11);
				hppop=hppop+crs.getInt(12);
				%>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=cpcount%></td>
				<td class=<%=style %>   align="right"><%=cpwspop%></td>				
				<td   class=<%=style %> style="text-align: right;"><%=pcount%></td>
				<td   class=<%=style %> style="text-align: right;"><%=pwspop%></td>							
				<td  class=<%=style %> style="text-align: right;"><%=mcount%></td>
				<td  class=<%=style %> style="text-align: right;"><%=mpwspop%></td>	
				<td  class=<%=style %> style="text-align: right;"><%=hpcount%></td>
				<td  class=<%=style %> style="text-align: right;"><%=hppop%></td>			
				<td class=<%=style %> style="text-align: right;"><%=othcount%></td>
				<td  class=<%=style %> style="text-align: right;"><%=othpop%></td>
				<td  class=<%=style %> style="text-align: right;"><%=count1%></td>
				<td  class=<%=style %> style="text-align: right;"><%=count1pop%></td>
				<%} %>
				
			</tr>
			<%
			
			Gtotalpop+=totalpop;
			columnTotal3 += hcount;
			Gcpwstotal+=cpwspop;
			columnTotal4 +=cpcount;
			GpwsTotal+=pwspop;
			columnTotal5+=pcount;
			GmpwsTotal+=mpwspop;
			columnTotal6+=mcount;
			GothTotal+=othpop;
			columnTotal7+=othcount;
			GTotal+=count1pop;
			columnTotal8+=count1;
			ghpcount+=hpcount;
			ghppop+=hppop;
			
		       
		}
		%>
		<tr>
				<td class=gridhdbg style="text-align: right;"  colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;" ><%=columnTotal3%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gcpwstotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
				<td class=gridhdbg style="text-align: right;"><%=GpwsTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
				<td class=gridhdbg style="text-align: right;"><%=GmpwsTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=ghpcount%></td>
				<td class=gridhdbg style="text-align: right;"><%=ghppop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
				<td class=gridhdbg style="text-align: right;"><%=GothTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
				<td class=gridhdbg style="text-align: right;"><%=GTotal%></td>
				
			</tr>
	<%}
	else
	{
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>District</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>	
			 <td class=gridhdbg colspan="8" >Habs covered by Schemes</td>
			<td class=gridhdbg colspan="2" >Habs covered by both CPWS and PWS/MPWS/DP</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>CPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>MPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Others(DP)</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Habs</td>
			<td class=gridhdbg>Pop</td>
			
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
		int cpcount=0,cpwspop=0,Gcpwstotal=0,mpwspop=0,GmpwsTotal=0,pwspop=0,GpwsTotal=0,othpop=0,GothTotal=0,othcount=0;
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0,mcount=0,mcountTotal=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select sum(case when (cpws_supply >0) then 1 else 0 end) as b,sum(case when (cpws_supply >0)then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as bb,sum (case when (pws_supply>0 and cpws_supply =0 ) then 1 else 0 end) as c,sum (case when (pws_supply>0 and cpws_supply =0 ) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as cc,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0 ) then 1 else 0 end) as d,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as dd,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then 1 else 0 end) as e,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ee,sum(case when (cpws_supply >0 and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0)) then 1 else 0 end) as f,sum(case when (cpws_supply >0) and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ff,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then 1 else 0 end) as g,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as gg from rws_hab_supply_status_tbl hp, rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and substr (hp.hab_code,1,2)='"+rs2.getString(1)+"' and hd.hab_code=hp.hab_code ";
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
				<td class="rptValue" ><%=rs2.getString(2)%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=hcount%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=totalpop%></td>
				<% 

				cst = conn.createStatement();
			    crs = cst.executeQuery(cpQuery);
				while(crs.next())
				{
System.out.println("Enter");
				cpcount=crs.getInt(1);
				cpwspop=cpwspop+crs.getInt(2);
				pcount=crs.getInt(3);
				pwspop=pwspop+crs.getInt(4);
				mcount=crs.getInt(5);
				mpwspop=mpwspop+crs.getInt(6);
				othcount=crs.getInt(7);
				othpop=othpop+crs.getInt(8);
				count1 =crs.getInt(9);
				count1pop=count1pop+crs.getInt(10);
				%>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=cpcount%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=cpwspop%></td>				
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=pcount%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=pwspop%></td>							
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=mcount%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=mpwspop%></td>				
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=othcount%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=othpop%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=count1%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=count1pop%></td>
				<%} %>
				
			</tr>
			<%
			
			Gtotalpop+=totalpop;
			columnTotal3 += hcount;
			Gcpwstotal+=cpwspop;
			columnTotal4 +=cpcount;
			GpwsTotal+=pwspop;
			columnTotal5+=pcount;
			GmpwsTotal+=mpwspop;
			columnTotal6+=mcount;
			GothTotal+=othpop;
			columnTotal7+=othcount;
			GTotal+=count1pop;
			columnTotal8+=count1;
		       
		}
		%>
		<tr>
				<td class=gridhdbg align="right" colspan="2">Total</td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal3%></td>
				<td class=rptValue  align="right"><%=Gtotalpop%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal4%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=Gcpwstotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal5%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GpwsTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal6%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GmpwsTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal7%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GothTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal8%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GTotal%></td>
				
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
//code to be added here for drill next
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body bgcolor="#edf2f8">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<!--<td align="right" class="bwborder">
					<a href="excelrpt.jsp">Excel
					</td>-->
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					<a href="./rws_habs_cov_schemes_rpt1_excel.jsp" target=_new>Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr  align="center">
			<td align="center" class="rptHeading" colspan=14>Coverage of Habitations by Schemes</td>	
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
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>District</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>	
			 <td class=gridhdbg colspan="8" >Habs covered by Schemes</td>
			<td class=gridhdbg colspan="2" >Habs covered by both CPWS and PWS/MPWS/DP</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>CPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>MPWS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Others(DP)</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>Habs</td>
			<td class=gridhdbg>Pop</td>
			
		</tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode = '"+rDistrict+"' order by dcode";
		//System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";int GTotal=0,count1pop=0;
		int cpcount=0,cpwspop=0,Gcpwstotal=0,mpwspop=0,GmpwsTotal=0,pwspop=0,GpwsTotal=0,othpop=0,GothTotal=0,othcount=0;
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0,mcount=0,mcountTotal=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
		    //Query modified by pranavi
			String hQuery = "select h.panch_code,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'";
			String cpQuery="select sum(case when (cpws_supply >0) then 1 else 0 end) as b,sum(case when (cpws_supply >0)then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as bb,sum (case when (pws_supply>0 and cpws_supply =0 ) then 1 else 0 end) as c,sum (case when (pws_supply>0 and cpws_supply =0 ) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as cc,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0 ) then 1 else 0 end) as d,sum(case when (mpws_supply>0 and pws_supply=0 and cpws_supply =0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as dd,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then 1 else 0 end) as e,sum (case when (OTHERS_SUPPLY_SAFE>0 and pws_supply=0 and cpws_supply =0  and mpws_supply=0 and SHP_DK_SUPPLY_SAFE =0 and HPS_OTH_SUPPLY=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ee,sum(case when (cpws_supply >0 and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0)) then 1 else 0 end) as f,sum(case when (cpws_supply >0) and (pws_supply>0 or mpws_supply >0 or OTHERS_SUPPLY_SAFE >0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as ff,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then 1 else 0 end) as g,sum(case when ((SHP_DK_SUPPLY_SAFE >0 or HPS_OTH_SUPPLY>0) and pws_supply=0 and cpws_supply =0  and mpws_supply=0) then nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0) else 0 end) as gg from rws_hab_supply_status_tbl hp, rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"' and substr (hp.hab_code,1,2)='"+rs2.getString(1)+"' and hd.hab_code=hp.hab_code ";
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
				
			
			
				//date = new Date();
    			//System.out.println("5*******************5:"+dateFormat.format(date));
			%>
				<% 
				cst = conn.createStatement();
			    crs = cst.executeQuery(cpQuery);
				while(crs.next())
				{
					if(styleCount%2==0){
						 style="gridbg1";
					 }else{
						 style="gridbg2";
					 }
					 styleCount++;
				cpcount=crs.getInt(1);
				cpwspop=cpwspop+crs.getInt(2);
				pcount=crs.getInt(3);
				pwspop=pwspop+crs.getInt(4);
				mcount=crs.getInt(5);
				mpwspop=mpwspop+crs.getInt(6);
				othcount=crs.getInt(7);
				othpop=othpop+crs.getInt(8);
				count1 =crs.getInt(9);
				count1pop=count1pop+crs.getInt(10);
				%>
				<tr>
			
				<td class=<%=style %>  style="text-align: right;"><%=sno++%></td>
				<td class=<%=style %>  style="text-align: right;" ><%=rs2.getString(2)%></td>
				<td class=<%=style %>  style="text-align: right;" ><%=hcount%></td>
				<td class=<%=style %>  style="text-align: right;" ><%=totalpop%></td>
			
				<td class=<%=style %>  style="text-align: right;"><%=cpcount%></td>
				<td class=<%=style %>  style="text-align: right;"><%=cpwspop%></td>				
				<td class=<%=style %>  style="text-align: right;"><%=pcount%></td>
				<td class=<%=style %> style="text-align: right;"><%=pwspop%></td>							
				<td class=<%=style %>  style="text-align: right;"><%=mcount%></td>
				<td class=<%=style %>  style="text-align: right;"><%=mpwspop%></td>				
				<td class=<%=style %>  style="text-align: right;"><%=othcount%></td>
				<td class=<%=style %>  style="text-align: right;"><%=othpop%></td>
				<td class=<%=style %>  style="text-align: right;"><%=count1%></td>
				<td class=<%=style %> style="text-align: right;"><%=count1pop%></td>
				</tr>
				<%} %>
				
		
			<%
			
			Gtotalpop+=totalpop;
			columnTotal3 += hcount;
			Gcpwstotal+=cpwspop;
			columnTotal4 +=cpcount;
			GpwsTotal+=pwspop;
			columnTotal5+=pcount;
			GmpwsTotal+=mpwspop;
			columnTotal6+=mcount;
			GothTotal+=othpop;
			columnTotal7+=othcount;
			GTotal+=count1pop;
			columnTotal8+=count1;
		       
		}
		%>
		<tr>
				<td class=gridhdbg align="right" colspan="2">Total</td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal3%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=Gtotalpop%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal4%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=Gcpwstotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal5%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GpwsTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal6%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GmpwsTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal7%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GothTotal%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=columnTotal8%></td>
				<td class=<%=style %> class=<%=style %> style="text-align: right;"><%=GTotal%></td>
				
			</tr>
	<%

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
<%@ include file = "footer.jsp" %>
