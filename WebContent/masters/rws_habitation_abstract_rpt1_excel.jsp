<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@page import="java.util.*"%>
<%@ include file="conn.jsp"%>
<%
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "rws_habitation_abstract_rpt1_excel.xls");
//System.out.println("dsss");
Calendar cal=Calendar.getInstance();

StringBuffer year=new StringBuffer();
year.append(""+cal.get(Calendar.YEAR));
int prevYear=Integer.parseInt(year.toString())-1;     
/////
//String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null;

StringBuffer rDistrict= new StringBuffer();
rDistrict.append(session.getAttribute("rDistrict"));
StringBuffer dname= new StringBuffer();
dname.append(session.getAttribute("rDistrictName"));

StringBuffer rDistrictName= new StringBuffer();
rDistrictName.append(session.getAttribute("rDistrictName"));

StringBuffer rMandal= new StringBuffer();
rMandal.append(session.getAttribute("rMandal"));

StringBuffer rMandalName= new StringBuffer();
rMandalName.append(session.getAttribute("rMandalName"));

StringBuffer rPanchayat= new StringBuffer();
rPanchayat.append(session.getAttribute("rPanchayat"));

StringBuffer rPanchayatName= new StringBuffer();
rPanchayatName.append(session.getAttribute("rPanchayatName"));

StringBuffer drill= new StringBuffer();
drill.append(session.getAttribute("drill"));

StringBuffer s=new StringBuffer();
s.append(year.substring(0,4));

ResultSet rs1=null,rs2=null,prs = null,vrs =null,hrs = null;
Statement pst = null, vst = null , hst = null,getHabSt=null,stmt1=null;
PreparedStatement ps1=null;
//rDistrict = (String)session.getAttribute("rDistrict");
//String dname = (String)session.getAttribute("rDistrictName");
//String drill = (String)session.getAttribute("drill");
//rDistrictName = (String)session.getAttribute("rDistrictName");
//rMandal = (String)session.getAttribute("rMandal");
//rMandalName = (String)session.getAttribute("rMandalName");
//rPanchayat = (String)session.getAttribute("rPanchayat");
//rPanchayatName = (String)session.getAttribute("rPanchayatName");

/////
StringBuffer habTableName=(StringBuffer)session.getAttribute("habTableName");

StringBuffer finYear=(StringBuffer)session.getAttribute("finYear");
StringBuffer lpcdrange=(StringBuffer)session.getAttribute("lpcdrange");
StringBuffer poptype=(StringBuffer)session.getAttribute("poptype");
System.out.println("poptype"+poptype);
int styleCount=0;
StringBuffer style=new StringBuffer();

StringBuffer getDnameQuery=new StringBuffer();
StringBuffer pQuery=new StringBuffer();

StringBuffer vQuery=new StringBuffer();
StringBuffer hQuery=new StringBuffer();
StringBuffer hquery1=new StringBuffer();
StringBuffer dnamee=new StringBuffer();

StringBuffer year1 =new StringBuffer();

if(drill.toString().equals("null"))
{
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body >

<table border = 1 cellspacing = 0 cellpadding = 0 >	
		
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=20>Habitation-Status-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{
	
	if(rDistrict.toString()!=null && rDistrict.toString().equals("00"))
	{
	%>
		<tr align="center" >
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>District</td>			
			<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>	
			<td class=gridhdbg colspan=14 align=center nowrap>Status as <%=finYear%>  [(as per level of water supply (LPCD)]</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
	<%
	getDnameQuery.delete(0, getDnameQuery.length());
	getDnameQuery.append("select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode");
		//System.out.println("getDnameQuery:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery.toString());
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		//date = new Date();
        //System.out.println("1:"+dateFormat.format(date));
		while(rs2.next())
		{
			//System.out.println("11111111111111");
			pQuery.delete(0, pQuery.length());
			pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
			vQuery.delete(0, vQuery.length());
			vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
			//Query modified by pranavi
			hQuery.delete(0, hQuery.length());
			hQuery.append("select distinct h.panch_code,hd.exist_water_level,hd.coverage_status,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
			
			if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				if(poptype.toString().equals("SC"))
				{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
				}
				else if(poptype.toString().equals("ST"))
				{
					hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
				}
				else if(poptype.toString().equals("PLAIN"))
				{
					hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
					
				}
			}
			hquery1.delete(0, hquery1.length());
			hquery1.append("select distinct h.panch_code,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(total_water_supply,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rs2.getString(1)+"'");
			if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				if(poptype.toString().equals("SC"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
				}
				else if(poptype.toString().equals("ST"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
				}
				else if(poptype.toString().equals("PLAIN"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
					
				}
			}
			
			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
			FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;
	//	System.out.println("pQuery:"+hquery1);
		//	System.out.println("vQuery:"+vQuery);
		//	System.out.println("hQuery:"+hQuery);	
		//	System.out.println("hQuery:"+hquery1);
			
			pst = conn.createStatement();vst = conn.createStatement();hst = conn.createStatement();
			
			prs = pst.executeQuery(pQuery.toString());
			vrs = vst.executeQuery(vQuery.toString());
			
			if(lpcdrange.toString().equals("55")){
				//System.out.println("hQuery"+hQuery);
				hrs = hst.executeQuery(hQuery.toString());	
			}else{
				//System.out.println("hQuery1"+hquery1);
				hrs = hst.executeQuery(hquery1.toString());	
			}
			
			//date = new Date();
	       // System.out.println("2:"+dateFormat.format(date));
	        
			while(prs.next())pcount ++;while(vrs.next())vcount ++;
			//date = new Date();
	      //  System.out.println("3:"+dateFormat.format(date));
			//System.out.println("22222222222");
			stmt1 = conn.createStatement();	
			//System.out.println("pcount:"+pcount);
		//	System.out.println("vcount:"+vcount);	
		if(lpcdrange.toString().equals("55")){
			System.out.println("in 55 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(4);
int total_pop=hrs.getInt(4);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(2);
double safelpcd=hrs.getDouble(5);
double unsafelpcd=hrs.getDouble(6);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>55){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=13.75){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>13.75 && safelpcd<=27.5){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>27.5 && safelpcd<=41.25){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>41.25 && safelpcd<=55){count5++; PC4pop=PC4pop+total_pop;}
}
	}}
		else{
			System.out.println("in 40 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(2);
int total_pop=hrs.getInt(2);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(3);
double safelpcd=hrs.getDouble(4);
double unsafelpcd=hrs.getDouble(5);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>40){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=10){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>10 && safelpcd<=20){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>20 && safelpcd<=30){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>30 && safelpcd<=40){count5++; PC4pop=PC4pop+total_pop;}
}
	}
		}
		style.delete(0, style.length());
  		if(styleCount%2==0){
  			 style.append("gridbg1");
  		}else{
  			 style.append("gridbg2");
  		}
  		styleCount++;
			
		//date = new Date();
    			//System.out.println("5*******************5:"+dateFormat.format(date));
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<td class="<%=style%>" class="rptValue"  style="text-align: left;"><a href="rws_habitation_abstract_rpt1.jsp?drill=next&rDistrict=<%=rs2.getString(1)%>&rDistrictName=<%=rs2.getString(2)%>&finyear=<%= finYear%>&lpcdrange=<%=lpcdrange%>&poptype=<%=poptype%>"><%=rs2.getString(2)%></a></td>
				<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
				<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
				<td class="<%=style%>" style="text-align: right;"> <%=count7%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
			</tr>
			<%
			columnTotal1 += pcount;columnTotal2 += vcount;columnTotal3 += hcount;columnTotal4 += count1;
			columnTotal5 += count5;columnTotal6 += count4;columnTotal7 += count3;columnTotal8 += count2;
			columnTotal9 += count6;columnTotal10 += count7;FCpopTotal +=FCpop;PC4popTotal += PC4pop;
			Gtotalpop+=totalpop;
			PC3popTotal+=PC3pop;PC2popTotal+=PC2pop;PC1popTotal +=PC1pop;NCpopTotal+=NCpop;NSSpopTotal+=NSSpop;
		}
		%>
		<tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
				<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
				<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
				<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
			</tr>
	<%
	//style="";styleCount=0;
	}
	else
	{
	
//System.out.println("in next");
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
					<!--<td style="text-align: right;" class="bwborder">
					<!--<a href="excelrpt.jsp">Excel
					</td>-->
					<td style="text-align: right;" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>|
					 <a href="./rws_habitation_abstract_rpt1_excel.jsp" target=_new>Excel</a> 
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
		<td class=rptLabel colspan=20>LPCD Range:<font color="red">*</font><SELECT name="lpcdrange"  id="lpcdrange" style="width:140px" onchange="this.form.submit()" >

				 
				 <option value="55">55</option>
				 <option value="40">40</option>
				 </SELECT></td>
		</tr>
		 
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=20>Habitation-Status-Abstract-Report</td>	
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
			<td class=gridhdbg rowspan=2>Mandal</td>			
			<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on <%=finYear %> [(as per level of water supply (LPCD)]</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
	<%
	getDnameQuery.delete(0, getDnameQuery.length());
	getDnameQuery.append("select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict+"' order by m.mcode");
		System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery.toString());
		rs2 = ps1.executeQuery(); 
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0;
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		rs2.next();
		
		
		dnamee.delete(0, dnamee.length());
		 dnamee.append(rs2.getString(3));
		%>
		<tr>
			<td class="btext" colspan="19">District:<%=dnamee.toString()%></td>
		</tr>
		<%
		rs2.previous();
		while(rs2.next())
		{
			
			pQuery.delete(0, pQuery.length());
			pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");

			vQuery.delete(0, vQuery.length());
			vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
			
			
			hQuery.delete(0, hQuery.length());
			//Query modified by pranavi
			hQuery.append("select h.panch_code,hd.exist_water_level,hd.coverage_status,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
			hquery1.delete(0, hquery1.length());
			hquery1.append("select h.panch_code,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(total_water_supply,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
			System.out.println("hQuery"+hQuery);
			System.out.println("hQuery"+hQuery);
			
			System.out.println("hQuery"+hQuery);
			System.out.println("hQuery"+hQuery);
           

			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
			FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;
			pst = conn.createStatement();vst = conn.createStatement();hst = conn.createStatement();
			if(lpcdrange.toString().equals("55")){
				//System.out.println("hQuery"+hQuery);
				hrs = hst.executeQuery(hQuery.toString());	
			}else{
				//System.out.println("hQuery1"+hquery1);
				hrs = hst.executeQuery(hquery1.toString());	
			}
			prs = pst.executeQuery(pQuery.toString());
			vrs = vst.executeQuery(vQuery.toString());
			//hrs = hst.executeQuery(hQuery);
			
			while(prs.next())pcount ++;while(vrs.next())vcount ++;
			stmt1 = conn.createStatement();	
			if(lpcdrange.toString().equals("55")){
				System.out.println("in 55 lpcd");
				while(hrs.next())
				{
					
					hcount++;
					totalpop=totalpop+hrs.getInt(4);
	int total_pop=hrs.getInt(4);
	//System.out.println("totalpop="+total_pop);
	double water_supply=hrs.getDouble(2);
	double safelpcd=hrs.getDouble(5);
	double unsafelpcd=hrs.getDouble(6);
	//System.out.println("===watersupply"+water_supply);
	double lpcd=(safelpcd+unsafelpcd)/total_pop;

	//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
	if(safelpcd==0 && unsafelpcd!=0)
	{
		
		count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
	}else
	{
		if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
		else if(safelpcd>55){count1++;  FCpop=FCpop+total_pop;}
		else if(safelpcd>0 && safelpcd<=13.75){count2++; PC1pop=PC1pop+total_pop;}
		else if(safelpcd>13.75 && safelpcd<=27.5){count3++; PC2pop=PC2pop+total_pop;}
		else if(safelpcd>27.5 && safelpcd<=41.25){count4++; PC3pop=PC3pop+total_pop;}
		else if(safelpcd>41.25 && safelpcd<=55){count5++; PC4pop=PC4pop+total_pop;}
	}
		}}
			else{
				System.out.println("in 40 lpcd");
				while(hrs.next())
				{
					
					hcount++;
					totalpop=totalpop+hrs.getInt(2);
	int total_pop=hrs.getInt(2);
	//System.out.println("totalpop="+total_pop);
	double water_supply=hrs.getDouble(3);
	double safelpcd=hrs.getDouble(4);
	double unsafelpcd=hrs.getDouble(5);
	//System.out.println("===watersupply"+water_supply);
	double lpcd=(safelpcd+unsafelpcd)/total_pop;

	//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
	if(safelpcd==0 && unsafelpcd!=0)
	{
		
		count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
	}else
	{
		if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
		else if(safelpcd>40){count1++;  FCpop=FCpop+total_pop;}
		else if(safelpcd>0 && safelpcd<=10){count2++; PC1pop=PC1pop+total_pop;}
		else if(safelpcd>10 && safelpcd<=20){count3++; PC2pop=PC2pop+total_pop;}
		else if(safelpcd>20 && safelpcd<=30){count4++; PC3pop=PC3pop+total_pop;}
		else if(safelpcd>30 && safelpcd<=40){count5++; PC4pop=PC4pop+total_pop;}
	}
		}
			}
			style.delete(0, style.length());
	  		if(styleCount%2==0){
	  			 style.append("gridbg1");
	  		}else{
	  			 style.append("gridbg2");
	  		}
	  		styleCount++;
				
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<td class="rptValue"  style="text-align: left;"><a href="rws_habitation_abstract_rpt1.jsp?drill=next&rDistrict=<%=rs2.getString(1)%>&rDistrictName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
				<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
				<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
			</tr>
			<%
			columnTotal1 += pcount;columnTotal2 += vcount;columnTotal3 += hcount;columnTotal4 += count1;
			columnTotal5 += count5;columnTotal6 += count4;columnTotal7 += count3;columnTotal8 += count2;
			columnTotal9 += count6;columnTotal10 += count7;FCpopTotal +=FCpop;PC4popTotal += PC4pop;
			Gtotalpop+=totalpop;
			PC3popTotal+=PC3pop;PC2popTotal+=PC2pop;PC1popTotal +=PC1pop;NCpopTotal+=NCpop;NSSpopTotal+=NSSpop;
		}
          //style="";styleCount=0;
	%>
	 <tr>
				<td class=gridhdbg style="text-align: right;"colspan="2">Total</td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
				<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
				<td class=gridhdbg style="text-align: right;"> <%=PC2popTotal%></td>
				<td class=gridhdbg style="text-align: right;"> <%=columnTotal8%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
				<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NCpopTotal%></td>
			</tr>
				
<%
}
catch(Exception e)
{
	e.printStackTrace();
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
	
	
	dname=null;
	rDistrictName=null;
	rMandal=null;
	rMandalName=null;
	rPanchayat=null;
	rPanchayatName=null;
		year=null;
		rDistrict=null;
		style=null;
		pQuery=null;
		getDnameQuery=null;
		vQuery=null;
		hQuery=null;
		hquery1=null;
		dnamee=null;
		year1=null;
		
try{
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(vrs!=null){vrs.close();}
if(vst!=null){vst.close();}
if(prs!=null){prs.close();}
if(pst!=null){pst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(rs1!=null){rs1.close();}
if(stmt1!=null){stmt1.close();}
if(conn!=null){conn.close();}
}catch(Exception e){e.printStackTrace();}
}
}
else if(drill.toString()!=null && drill.toString().equals("next"))
{
//System.out.println("in next");
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body>
		
		<table border=2>
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
		<td class=gridhdbg rowspan=2>Mandal</td>			
		<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
		<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
		<td class=gridhdbg rowspan=2>No. of Habs</td>	
		<td class=gridhdbg rowspan=2>Pop</td>
		<td class=gridhdbg colspan=14 align=center nowrap>Status as on 01.04.<%=s.toString() %> [(as per level of water supply (LPCD)]</td>
		</tr>
	<tr align="center">
		<td class=gridhdbg>FC</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC4</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC3</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC2</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC1</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>NSS</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>NC</td>
		<td class=gridhdbg>Pop</td>
	</tr>
<%

	//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
getDnameQuery.delete(0, getDnameQuery.length());
getDnameQuery.append("select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict.toString()+"' order by m.mcode");
	//System.out.println("query:"+getDnameQuery);
	getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2 = getHabSt.executeQuery(getDnameQuery.toString()); 
	rs2.next();
	dnamee.delete(0, dnamee.length());
	dnamee.append(rs2.getString(3));
	//System.out.println("dnamee:"+dnamee);
	%>
	<tr>
		<td class="btext" colspan="20">District:<%=dnamee.toString()%></td>
	</tr>
	<%
	rs2.previous();
	int sno = 1;double Lpcd=0.0;
	int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
	int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
	int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";
	int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0;
	int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
	
	while(rs2.next())
	{
		pQuery.delete(0, pQuery.length());
		pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
		vQuery.delete(0, vQuery.length());
		vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
		hQuery.delete(0, hQuery.length());
		//Query modified by pranavi
		hQuery.append("select h.panch_code,hd.exist_water_level,hd.coverage_status,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			if(poptype.toString().equals("SC"))
			{
			hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
			}
			else if(poptype.toString().equals("ST"))
			{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
			}
			else if(poptype.toString().equals("PLAIN"))
			{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
				
			}
		}
		
		hquery1.delete(0, hquery1.length());
		hquery1.append("select h.panch_code,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(total_water_supply,0) as totalpop ,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rs2.getString(1)+"'");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			if(poptype.toString().equals("SC"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
			}
			else if(poptype.toString().equals("ST"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
			}
			else if(poptype.toString().equals("PLAIN"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
				
			}
		}

		//System.out.println("hQuery:"+hquery1);
		pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
        FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;
		pst = conn.createStatement();vst = conn.createStatement();hst = conn.createStatement();

		prs = pst.executeQuery(pQuery.toString());
		vrs = vst.executeQuery(vQuery.toString());
		//hrs = hst.executeQuery(hQuery);
		if(lpcdrange.toString().equals("55")){
			//System.out.println("hQuery"+hQuery);
			hrs = hst.executeQuery(hQuery.toString());	
		}else{
			//System.out.println("hQuery1"+hquery1);
			hrs = hst.executeQuery(hquery1.toString());	
		}
		while(prs.next())pcount ++;while(vrs.next())vcount ++;
		stmt1 = conn.createStatement();	
		if(lpcdrange.toString().equals("55")){
			System.out.println("in 55 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(4);
int total_pop=hrs.getInt(4);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(2);
double safelpcd=hrs.getDouble(5);
double unsafelpcd=hrs.getDouble(6);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>55){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=13.75){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>13.75 && safelpcd<=27.5){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>27.5 && safelpcd<=41.25){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>41.25 && safelpcd<=55){count5++; PC4pop=PC4pop+total_pop;}
}
	}}
		else{
			System.out.println("in 40 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(2);
int total_pop=hrs.getInt(2);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(3);
double safelpcd=hrs.getDouble(4);
double unsafelpcd=hrs.getDouble(5);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>40){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=10){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>10 && safelpcd<=20){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>20 && safelpcd<=30){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>30 && safelpcd<=40){count5++; PC4pop=PC4pop+total_pop;}
}
	}
		}
		style.delete(0, style.length());
  		if(styleCount%2==0){
  			 style.append("gridbg1");
  		}else{
  			 style.append("gridbg2");
  		}
  		styleCount++;
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="rptValue"  style="text-align: left;"><a href="rws_habitation_abstract_rpt1.jsp?drill=next1&rDistrict=<%=rDistrict%>&rDistrictName=<%=rDistrictName%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>&finyear=<%= finYear%>&lpcdrange=<%=lpcdrange%>&poptype=<%=poptype%>"><%=rs2.getString(2)%></a></td>
			<td class="<%=style%>" style="text-align: right;"><%=pcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
		columnTotal1 += pcount;columnTotal2 += vcount;columnTotal3 += hcount;columnTotal4 += count1;
		columnTotal5 += count5;columnTotal6 += count4;columnTotal7 += count3;columnTotal8 += count2;
		columnTotal9 += count6;columnTotal10 += count7;FCpopTotal +=FCpop;PC4popTotal += PC4pop;
		Gtotalpop+=totalpop;
		PC3popTotal+=PC3pop;PC2popTotal+=PC2pop;PC1popTotal +=PC1pop;NCpopTotal+=NCpop;NSSpopTotal+=NSSpop;
	
	} 
	//style="";styleCount=0;

%>
 <tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal1%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>
			
			
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	
	
	dname=null;
	rDistrictName=null;
	rMandal=null;
	rMandalName=null;
	rPanchayat=null;
	rPanchayatName=null;
		year=null;
		rDistrict=null;
		style=null;
		pQuery=null;
		getDnameQuery=null;
		vQuery=null;
		hQuery=null;
		hquery1=null;
		dnamee=null;
		year1=null;
		
		
try{
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(vrs!=null){vrs.close();}
if(vst!=null){vst.close();}
if(prs!=null){prs.close();}
if(pst!=null){pst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(rs1!=null){rs1.close();}
if(stmt1!=null){stmt1.close();}
if(conn!=null){conn.close();}
}catch(Exception e){e.printStackTrace();}

}

} else if(drill.toString()!=null && drill.toString().equals("next1")){

//System.out.println("in next");
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body>
		
		<table border=2>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->


<%
try
{

	Calendar cal1=Calendar.getInstance();
	year1.delete(0, year1.length());
    year1.append(""+cal1.get(Calendar.YEAR));
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=gridhdbg rowspan=2>Sno</td>
			<td class=gridhdbg rowspan=2>Panchayat</td>			
			<!-- <td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>-->
			<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>
			<td class=gridhdbg rowspan=2>No. of Habs</td>	
			<td class=gridhdbg rowspan=2>Pop</td>
			<td class=gridhdbg colspan=14 align=center nowrap>Status as on 01.04.<%= year1%>  [(as per level of water supply (LPCD)]</td>
 		</tr>
		<tr align="center">
			<td class=gridhdbg>FC</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC4</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC3</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC2</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>PC1</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NSS</td>
			<td class=gridhdbg>Pop</td>
			<td class=gridhdbg>NC</td>
			<td class=gridhdbg>Pop</td>
		</tr>
	<%
		//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
		//String getDnameQuery = "select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict+"' order by m.mcode";
		getDnameQuery.delete(0, getDnameQuery.length());
		getDnameQuery.append("select p.pcode,p.pname,dname from rws_panchayat_tbl p,rws_district_tbl d where d.dcode = p.dcode and p.dcode = '"+rDistrict+"' and p.mcode='"+rMandal+"' order by p.pcode");
		
	System.out.println("query:"+getDnameQuery);
		getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs2 = getHabSt.executeQuery(getDnameQuery.toString()); 
		rs2.next();
		
		dnamee.delete(0, dnamee.length());
		
	   dnamee.append(rs2.getString(3));
		%>
		<tr>
			<td class="btext" colspan="19">District:<%=dnamee%>&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%></td>
		</tr>
		<%
		rs2.previous();
		int sno = 1;double Lpcd=0.0;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
		int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
		int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";
		int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0;		
		int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
		
		while(rs2.next())
		{
			pQuery.delete(0, pQuery.length());
			pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rs2.getString(1)+"'");
			vQuery.delete(0, vQuery.length());
			vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rs2.getString(1)+"'");
			hQuery.delete(0, hQuery.length());
			//Query modified by pranavi
			hQuery.append("select h.panch_code,hd.exist_water_level,hd.coverage_status,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop, nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rs2.getString(1)+"'");
			if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				if(poptype.toString().equals("SC"))
				{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
				}
				else if(poptype.toString().equals("ST"))
				{
					hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
				}
				else if(poptype.toString().equals("PLAIN"))
				{
					hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
					
				}
			}
			
			hquery1.delete(0, hquery1.length());
			hquery1.append("select h.panch_code,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(total_water_supply,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rs2.getString(1)+"'");
			if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
				if(poptype.toString().equals("SC"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
				}
				else if(poptype.toString().equals("ST"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
				}
				else if(poptype.toString().equals("PLAIN"))
				{
					hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
					
				}
			}
			
			

			System.out.println("hQuery:"+hquery1);
			pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
            FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;
            pst = conn.createStatement();vst = conn.createStatement();hst = conn.createStatement();

			prs = pst.executeQuery(pQuery.toString());
			vrs = vst.executeQuery(vQuery.toString());
			//hrs = hst.executeQuery(hQuery);
			if(lpcdrange.toString().equals("55")){
				//System.out.println("hQuery"+hQuery);
				hrs = hst.executeQuery(hQuery.toString());	
			}else{
				//System.out.println("hQuery1"+hquery1);
				hrs = hst.executeQuery(hquery1.toString());	
			}
			while(prs.next())pcount ++;while(vrs.next())vcount ++;
			stmt1 = conn.createStatement();	
			if(lpcdrange.toString().equals("55")){
			//	System.out.println("in 55 lpcd");
				while(hrs.next())
				{
					
					hcount++;
					totalpop=totalpop+hrs.getInt(4);
	int total_pop=hrs.getInt(4);
	//System.out.println("totalpop="+total_pop);
	double water_supply=hrs.getDouble(2);
	double safelpcd=hrs.getDouble(5);
	double unsafelpcd=hrs.getDouble(6);
	//System.out.println("===watersupply"+water_supply);
	double lpcd=(safelpcd+unsafelpcd)/total_pop;

	//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
	if(safelpcd==0 && unsafelpcd!=0)
	{
		
		count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
	}else
	{
		if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
		else if(safelpcd>55){count1++;  FCpop=FCpop+total_pop;}
		else if(safelpcd>0 && safelpcd<=13.75){count2++; PC1pop=PC1pop+total_pop;}
		else if(safelpcd>13.75 && safelpcd<=27.5){count3++; PC2pop=PC2pop+total_pop;}
		else if(safelpcd>27.5 && safelpcd<=41.25){count4++; PC3pop=PC3pop+total_pop;}
		else if(safelpcd>41.25 && safelpcd<=55){count5++; PC4pop=PC4pop+total_pop;}
	}
		}}
			else{
			System.out.println("in 40 lpcd");
				while(hrs.next())
				{
					
					hcount++;
					totalpop=totalpop+hrs.getInt(2);
	int total_pop=hrs.getInt(2);
	//System.out.println("totalpop="+total_pop);
	double water_supply=hrs.getDouble(5);
	double safelpcd=hrs.getDouble(3);
	double unsafelpcd=hrs.getDouble(4);
	//System.out.println("===watersupply"+water_supply);
	double lpcd=(safelpcd+unsafelpcd)/total_pop;

	//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
	if(safelpcd==0 && unsafelpcd!=0)
	{
		
		count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
	}else
	{
		if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
		else if(safelpcd>40){count1++;  FCpop=FCpop+total_pop;}
		else if(safelpcd>0 && safelpcd<=10){count2++; PC1pop=PC1pop+total_pop;}
		else if(safelpcd>10 && safelpcd<=20){count3++; PC2pop=PC2pop+total_pop;}
		else if(safelpcd>20 && safelpcd<=30){count4++; PC3pop=PC3pop+total_pop;}
		else if(safelpcd>30 && safelpcd<=40){count5++; PC4pop=PC4pop+total_pop;}
	}
		}
			}
			style.delete(0, style.length());
	  		if(styleCount%2==0){
	  			 style.append("gridbg1");
	  		}else{
	  			 style.append("gridbg2");
	  		}
	  		styleCount++;
			%>
			<tr>
				<td class="<%=style%>"><%=sno++%></td>
				<td class="rptValue"  style="text-align: left;"><a href="rws_habitation_abstract_rpt1.jsp?drill=next2&rDistrict=<%=rDistrict%>&rDistrictName=<%=rDistrictName%>&rMandal=<%=rMandal%>&rMandalName=<%=rMandalName%>&rPanchayat=<%=rs2.getString(1)%>&rPanchayatName=<%=rs2.getString(2)%>&finyear=<%= finYear%>&lpcdrange=<%=lpcdrange%>&poptype=<%=poptype%>"><%=rs2.getString(2)%></a></td>
				<!-- <td class="<%=style%>"><%=pcount%></td>-->
				<td class="<%=style%>" style="text-align: right;"><%=vcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
				<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
				<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
				<td class="<%=style%>" style="text-align: right;"> <%=count3%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
				<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
				<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
				<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
			</tr>
			<%
			columnTotal1 += pcount;columnTotal2 += vcount;columnTotal3 += hcount;columnTotal4 += count1;
			columnTotal5 += count5;columnTotal6 += count4;columnTotal7 += count3;columnTotal8 += count2;
			columnTotal9 += count6;columnTotal10 += count7;FCpopTotal +=FCpop;PC4popTotal += PC4pop;
			Gtotalpop+=totalpop;
			PC3popTotal+=PC3pop;PC2popTotal+=PC2pop;PC1popTotal +=PC1pop;NCpopTotal+=NCpop;NSSpopTotal+=NSSpop;
		
		}
	//style="";styleCount=0;
	%>
	 <tr>
				<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
				<!-- <td class=gridhdbg><%=columnTotal1%></td>-->
				<td class=gridhdbg style="text-align: right;"><%=columnTotal2%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
				<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
				<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal8%></td>
				<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
				<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
				<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
				<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
			</tr>
				
				
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	
	
	dname=null;
	rDistrictName=null;
	rMandal=null;
	rMandalName=null;
	rPanchayat=null;
	rPanchayatName=null;
		year=null;
		rDistrict=null;
		style=null;
		pQuery=null;
		getDnameQuery=null;
		vQuery=null;
		hQuery=null;
		hquery1=null;
		dnamee=null;
		year1=null;
		
try{
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(vrs!=null){vrs.close();}
if(vst!=null){vst.close();}
if(prs!=null){prs.close();}
if(pst!=null){pst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(rs1!=null){rs1.close();}
if(stmt1!=null){stmt1.close();}
if(conn!=null){conn.close();}
}catch(Exception e){e.printStackTrace();}
}

} 
else if(drill.toString()!=null && drill.toString().equals("next2")){

//System.out.println("in next2");
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>
<body>
		
		<table border=2>
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
		<td class=gridhdbg rowspan=2>Village</td>			
		<!--<td class=gridhdbg rowspan=2 align=center>No. of Panchayats</td>
		<td class=gridhdbg rowspan=2 align=center>No. of Villages</td>-->
		<td class=gridhdbg rowspan=2>No. of Habs</td>	
		<td class=gridhdbg rowspan=2>Pop</td>
		<td class=gridhdbg colspan=14 align=center nowrap>Status as on 01.04.09  [(as per level of water supply (LPCD)]</td>
		</tr>
	<tr align="center">
		<td class=gridhdbg>FC</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC4</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC3</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC2</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>PC1</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>NSS</td>
		<td class=gridhdbg>Pop</td>
		<td class=gridhdbg>NC</td>
		<td class=gridhdbg>Pop</td>
	</tr>
<%
	//String getDnameQuery = "select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode";
	//String getDnameQuery = "select mcode,mname,dname from rws_mandal_tbl m,rws_district_tbl d where d.dcode = m.dcode and d.dcode = '"+rDistrict+"' order by m.mcode";
	
	
	//String getDnameQuery = "select p.pcode,p.pname,dname from rws_panchayat_tbl p,rws_district_tbl d where d.dcode = p.dcode and p.dcode = '"+rDistrict+"' and p.mcode='"+rMandal+"' order by p.pcode";
	
	getDnameQuery.delete(0, getDnameQuery.length());
	
//getDnameQuery.append("select v.vcode,v.vname,dname,panch_code from rws_village_tbl v,rws_district_tbl d where d.dcode = v.dcode and v.dcode = '"+rDistrict+"' and v.mcode='"+rMandal+"'  and v.pcode='"+rPanchayat+"' order by v.vcode");
getDnameQuery.append("select v.vcode,v.vname,d.dname,panch_code from rws_village_tbl v,rws_district_tbl d,rws_complete_hab_view c where d.dcode = v.dcode and c.dcode=d.dcode and c.dcode=v.dcode and c.mcode=v.mcode and c.pcode=v.pcode and v.dcode = '"+rDistrict+"' and v.mcode='"+rMandal+"'  and v.pcode='"+rPanchayat+"' order by v.vcode");
	
	//System.out.println("getDnameQuery:"+getDnameQuery);
	getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs2 = getHabSt.executeQuery(getDnameQuery.toString()); 
	rs2.next();
	dnamee.delete(0, dnamee.length());
	dnamee.append(rs2.getString(3));
	%>
	<tr>
		<td class="btext" colspan="18">District:<%=dnamee.toString()%>&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName.toString()%>&nbsp;&nbsp;&nbsp;Panchayat:<%=rPanchayatName.toString()%></td>
	</tr>
	<%
	rs2.previous();
	int sno = 1;double Lpcd=0.0;
	int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0;
	int count1 = 0,	count2 = 0,count3 = 0,count4 = 0,count5 = 0,count6 = 0,count7 = 0;
	int pcount = 0,vcount = 0,hcount = 0;String calCoverageStatus = "";
	int FCpop=0,PC4pop=0,PC3pop=0,PC2pop=0,PC1pop=0,NCpop=0,NSSpop=0,totalpop=0,Gtotalpop=0;
	int FCpopTotal=0,PC4popTotal=0,PC3popTotal=0,PC2popTotal=0,PC1popTotal=0,NCpopTotal=0,NSSpopTotal=0;
	String hab=null;
	while(rs2.next())
	{
		
		pQuery.delete(0, pQuery.length());
		pQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rPanchayat+"' and v.vcode='"+rs2.getString(1)+"'");
		vQuery.delete(0, vQuery.length());
		vQuery.append("select distinct substr(h.hab_code,1,2)||substr(h.hab_code,6,2)||substr(h.hab_code,13,2)||substr(h.hab_code,8,3) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rPanchayat+"' and v.vcode='"+rs2.getString(1)+"'");
		hQuery.delete(0, hQuery.length());
		//Query modified by pranavi
		hQuery.append("select h.panch_code,hd.exist_water_level,hd.coverage_status,(nvl(hd.CENSUS_PLAIN_POPU,'0')+nvl(hd.CENSUS_SC_POPU,'0')+nvl(hd.CENSUS_ST_POPU,'0')) as totalpop,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rPanchayat+"' and v.vcode='"+rs2.getString(1)+"' and h.panch_code='"+rs2.getString(4)+"'");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			if(poptype.toString().equals("SC"))
			{
			hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
			}
			else if(poptype.toString().equals("ST"))
			{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
			}
			else if(poptype.toString().equals("PLAIN"))
			{
				hQuery.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
				
			}
		}
		
		
		hquery1.delete(0, hquery1.length());
		hquery1.append("select h.panch_code,nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0),nvl(total_water_supply,0),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0)  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI'  and d.dcode='"+rDistrict+"'  and m.mcode='"+rMandal+"' and p.pcode='"+rPanchayat+"' and v.vcode='"+rs2.getString(1)+"' and h.panch_code='"+rs2.getString(4)+"'");
		if(poptype.toString()!=null && !poptype.toString().equals("") && !poptype.toString().equals("ALL") ){
			if(poptype.toString().equals("SC"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_SC_POPU >='40'");
			}
			else if(poptype.toString().equals("ST"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_ST_POPU >='40'");
			}
			else if(poptype.toString().equals("PLAIN"))
			{
				hquery1.append(" and hd.HABitation_SUB_TYPE='"+poptype+"' and hd.CENSUS_PLAIN_POPU >='40'");
				
			}
		}
		
		

		//System.out.println("hQuery:"+hQuery);
		pcount = 0;vcount = 0;hcount = 0;count1 = 0;count2 = 0;count3 = 0;count4 = 0;count5 = 0;count6 = 0;count7 = 0;
        FCpop=0;PC4pop=0;PC3pop=0;PC2pop=0;PC1pop=0;NCpop=0;NSSpop=0;totalpop=0;
		pst = conn.createStatement();vst = conn.createStatement();hst = conn.createStatement();

		prs = pst.executeQuery(pQuery.toString());
		vrs = vst.executeQuery(vQuery.toString());
		//hrs = hst.executeQuery(hQuery);
		if(lpcdrange.toString().equals("55")){
			//System.out.println("hQuery"+hQuery);
			hrs = hst.executeQuery(hQuery.toString());	
		}else{
			//System.out.println("hQuery1"+hquery1);
			hrs = hst.executeQuery(hquery1.toString());	
		}
		while(prs.next())pcount ++;while(vrs.next())vcount ++;
		stmt1 = conn.createStatement();	
		if(lpcdrange.toString().equals("55")){
			System.out.println("in 55 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(4);
int total_pop=hrs.getInt(4);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(2);
double safelpcd=hrs.getDouble(5);
double unsafelpcd=hrs.getDouble(6);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>55){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=13.75){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>13.75 && safelpcd<=27.5){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>27.5 && safelpcd<=41.25){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>41.25 && safelpcd<=55){count5++; PC4pop=PC4pop+total_pop;}
}
	}}
		else{
			System.out.println("in 40 lpcd");
			while(hrs.next())
			{
				
				hcount++;
				totalpop=totalpop+hrs.getInt(2);
int total_pop=hrs.getInt(2);
//System.out.println("totalpop="+total_pop);
double water_supply=hrs.getDouble(3);
double safelpcd=hrs.getDouble(4);
double unsafelpcd=hrs.getDouble(5);
//System.out.println("===watersupply"+water_supply);
double lpcd=(safelpcd+unsafelpcd)/total_pop;

//System.out.println("totalpop="+total_pop+"===watersupply"+water_supply+"===lpcd"+lpcd);
if(safelpcd==0 && unsafelpcd!=0)
{
	
	count6++; NSSpop=NSSpop+total_pop;//System.out.print(hrs.getString(1)+",");
}else
{
	if(safelpcd==0){count7++;  NCpop=NCpop+total_pop;}
	else if(safelpcd>40){count1++;  FCpop=FCpop+total_pop;}
	else if(safelpcd>0 && safelpcd<=10){count2++; PC1pop=PC1pop+total_pop;}
	else if(safelpcd>10 && safelpcd<=20){count3++; PC2pop=PC2pop+total_pop;}
	else if(safelpcd>20 && safelpcd<=30){count4++; PC3pop=PC3pop+total_pop;}
	else if(safelpcd>30 && safelpcd<=40){count5++; PC4pop=PC4pop+total_pop;}
}
	}
		}
		style.delete(0, style.length());
  		if(styleCount%2==0){
  			 style.append("gridbg1");
  		}else{
  			 style.append("gridbg2");
  		}
  		styleCount++;
			
		%>
		<tr>
			<td class="<%=style%>"><%=sno++%></td>
			<td class="<%=style%>"  style="text-align: left;"><%=rs2.getString(2)%></td>
			<!--<td class="<%=style%>"><%=pcount%></td>
			<td class="<%=style%>"><%=vcount%></td>-->
			<td class="<%=style%>" style="text-align: right;"><%=hcount%></td>
			<td class="<%=style%>" style="text-align: right;"><%=totalpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count1%></td>
			<td class="<%=style%>" style="text-align: right;"><%=FCpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count5%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC4pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count4%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC3pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count3%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC2pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count2%></td>
			<td class="<%=style%>" style="text-align: right;"><%=PC1pop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count6%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NSSpop%></td>
			<td class="<%=style%>" style="text-align: right;"><%=count7%></td>
			<td class="<%=style%>" style="text-align: right;"><%=NCpop%></td>
		</tr>
		<%
		columnTotal1 += pcount;columnTotal2 += vcount;columnTotal3 += hcount;columnTotal4 += count1;
		columnTotal5 += count5;columnTotal6 += count4;columnTotal7 += count3;columnTotal8 += count2;
		columnTotal9 += count6;columnTotal10 += count7;FCpopTotal +=FCpop;PC4popTotal += PC4pop;
		Gtotalpop+=totalpop;
		PC3popTotal+=PC3pop;PC2popTotal+=PC2pop;PC1popTotal +=PC1pop;NCpopTotal+=NCpop;NSSpopTotal+=NSSpop;
	
	}
//style="";styleCount=0;
%>
 <tr>
			<td class=gridhdbg style="text-align: right;" colspan="2">Total</td>
			<!--<td class=gridhdbg><%=columnTotal1%></td>
			<td class=gridhdbg><%=columnTotal2%></td>-->
			<td class=gridhdbg style="text-align: right;"><%=columnTotal3%></td>
			<td class=gridhdbg style="text-align: right;"><%=Gtotalpop%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal4%></td>
			<td class=gridhdbg style="text-align: right;"><%=FCpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal5%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC4popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal6%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC3popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal7%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC2popTotal%></td>
			<td class=gridhdbg style="text-align: right;"> <%=columnTotal8%></td>
			<td class=gridhdbg style="text-align: right;"><%=PC1popTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal9%></td>
			<td class=gridhdbg style="text-align: right;"><%=NSSpopTotal%></td>
			<td class=gridhdbg style="text-align: right;"><%=columnTotal10%></td>
			<td class=gridhdbg style="text-align: right;"><%=NCpopTotal%></td>
		</tr>
			
			
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	
dname=null;
rDistrictName=null;
rMandal=null;
rMandalName=null;
rPanchayat=null;
rPanchayatName=null;
	year=null;
	rDistrict=null;
	style=null;
	pQuery=null;
	getDnameQuery=null;
	vQuery=null;
	hQuery=null;
	hquery1=null;
	dnamee=null;
	year1=null;
	
try{
if(hrs!=null){hrs.close();}
if(hst!=null){hst.close();}
if(vrs!=null){vrs.close();}
if(vst!=null){vst.close();}
if(prs!=null){prs.close();}
if(pst!=null){pst.close();}
if(rs2!=null){rs2.close();}
if(getHabSt!=null){getHabSt.close();}
if(ps1!=null){ps1.close();}
if(rs1!=null){rs1.close();}
if(stmt1!=null){stmt1.close();}
if(conn!=null){conn.close();}
}
catch(Exception e){e.printStackTrace();}
}



}
%>
</table>