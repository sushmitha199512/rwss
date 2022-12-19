<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<html:html>
<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}



</script>






<%

String rDistrict=request.getParameter("rDistrict");
//System.out.println("rDistrict"+rDistrict);
String rDistrictName=request.getParameter("rDistrictName");
String finyear=request.getParameter("finyear");
String lpcdrange1=request.getParameter("lpcdrange");
String coverageStatus=request.getParameter("coverageStatus");
String poptype=request.getParameter("poptype");
//System.out.println("poptype"+poptype);

StringBuffer query =new StringBuffer();
Calendar cal=Calendar.getInstance();
StringBuffer year =new StringBuffer();
year.append(String.valueOf(cal.get(Calendar.YEAR)));
 //System.out.println("year"+year);
String FC="FC";
  int prevYear=Integer.parseInt(year.toString())-1;  
  StringBuffer finYear=new StringBuffer();
  //String finYear="";
  

  if(request.getParameter("finyear")!=null){
  	finYear.append(request.getParameter("finyear"));
  }else{
  	finYear.append(session.getAttribute("finYear"));
  }
////System.out.println("finYear="+year.toString());
  session.setAttribute("finYear",finYear);
  
StringBuffer lpcdrange=new StringBuffer();
  //String lpcdrange="";
  if(request.getParameter("lpcdrange")!=null){
  	lpcdrange.append(request.getParameter("lpcdrange"));
  }else{
  	lpcdrange.append("55");
  }
  session.setAttribute("lpcdrange",lpcdrange);
  
  
  
  
  
//  //System.out.println("s***lpcdrange**"+lpcdrange);
  StringBuffer habTableName=new StringBuffer();
  
//String habTableName="";
java.util.Date d=new java.util.Date();

////System.out.println("year"+year);
////System.out.println("finYear"+finYear);
////System.out.println("prevYear"+prevYear);
//session.setAttribute("prevYear",prevYear);
//String s=finYear.substring(0,4);
////System.out.println("s*****"+s);

StringBuffer s=new StringBuffer();
s.append(finYear.substring(0,4));

if(finYear.toString().substring(0,4).equals(year.toString()))
  {
 habTableName.append("rws_habitation_directory_tbl");

}
else if(finYear.toString().substring(0,4).equals(String.valueOf(prevYear)))
{
 habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
}
else
{
habTableName.append("RWS_HABITATION_DIR_HIS"+s+"_TBL");
}
session.setAttribute("habTableName",habTableName);
////System.out.println("Hab Table"+habTableName);


int count=1;
int total=0;
int totalPopulation=0;
String startYear="01-APR-"+finYear.substring(0,4);
String endYear="31-MAR-"+finYear.substring(5,9);
////System.out.println(startYear+"@@"+endYear);
 %>

<html:hidden property="init" value="false"/>
<table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			
			<a href="#" onClick="window.close();">Close</a>

<!--   <td class="bwborder">&nbsp;&nbsp; | &nbsp;<a href="./rws_perfomance_dril_spill_excel.jsp" target="_new">Excel</a></td>

-->
  
		</table>
	</caption>
<tr  align="center">
		<td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >District:&nbsp;<%=rDistrictName %>(<%=finyear %>)&nbsp;&nbsp;Coverage Status:<%=coverageStatus %>  </td>
</tr>

</table>
<table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
<tr align=center>


<td class=gridhdbg rowspan="2"><b>SL&nbsp;NO   </b></td>
<td class=gridhdbg  rowspan="2"><b>Mandal </b></td>
<td class=gridhdbg  rowspan="2"><b>Panchayat </b></td>
<td class=gridhdbg rowspan="2"><b>Village </b></td>
<td class=gridhdbg rowspan="2"><b>Hab Name </b></td>
<td class=gridhdbg rowspan="2"><b>Hab Code </b></td>
<td class=gridhdbg colspan=4 align=center nowrap>Population</td>
<%
if(coverageStatus.equals("NSS")){
	%>
	<td class=gridhdbg rowspan="2"><b>Contamination Type </b></td>
	<td class=gridhdbg rowspan="2"><b>Value </b></td>
	<%
}
%>
 </tr>		
		<tr align="center">
			<td class=gridhdbg>Plain</td>
			<td class=gridhdbg>SC</td>
			<td class=gridhdbg>ST</td>
			<td class=gridhdbg>Total</td>
		</tr>

<%
PreparedStatement preparedStatement=null;
ResultSet resultSet=null;
String query1="";
int sno=0;
try{
	if(coverageStatus.equals("FC") || coverageStatus.equals("PC4") || coverageStatus.equals("PC3") || coverageStatus.equals("PC2") || coverageStatus.equals("PC1")){
	
		if(coverageStatus.equals("FC")){
		
		if(lpcdrange1.equals("55")){
			
			////////query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=55  ";
			
			query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd >= 55";
			
			System.out.println("***********   "+query1);
			
			if(poptype.equals("SC"))	
			{
				//System.out.println("SC");
			query1+="  and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU ";
			
			//System.out.println("%%%%%%%   "+query1);
			}
			else if(poptype.equals("ST"))
			{
				query1+="  and (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			
	// System.out.println("55FC-anupama---------"+query1);
		}
		else{
			//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(ACT_PLAIN_POPU,0),nvl(ACT_SC_POPU,0),nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>40  ";
			
			query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd > 40";

			if(poptype.equals("SC"))
			{
				query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			else if(poptype.equals("ST"))
			{
				query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			
	}
		}
	else if(coverageStatus.equals("PC4")){
		if(lpcdrange1.equals("55")){
			//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=41.25 and hd.safe_lpcd<55";
			query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"'  and hd.safe_lpcd>=41.25 and hd.safe_lpcd<55";

			if(poptype.toString().equals("SC"))
			{
				query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			else if(poptype.toString().equals("ST"))
			{
				query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			
			 //System.out.println("55PC4----------"+query1);
				}
				else{
					//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(ACT_PLAIN_POPU,0),nvl(ACT_SC_POPU,0),nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>30 and hd.safe_lpcd<=40";
								query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>30 and hd.safe_lpcd<=40";

					if(poptype.toString().equals("SC"))
					{
						query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					else if(poptype.toString().equals("ST"))
					{
						query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
					}
					else if(poptype.equals("PLAIN"))
					{
						query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
	}
	}
	else if(coverageStatus.equals("PC3")){
		if(lpcdrange1.equals("55")){
			//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=27.5 and hd.safe_lpcd<41.25";
			
			query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=27.5 and hd.safe_lpcd<41.25";

			if(poptype.toString().equals("SC"))
			{
				query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			else if(poptype.toString().equals("ST"))
			{
				query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			// System.out.println("55PC3----------"+query1);
				}
				else{
					//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(ACT_PLAIN_POPU,0),nvl(ACT_SC_POPU,0),nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>20 and hd.safe_lpcd<=30";
					
					query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>20 and hd.safe_lpcd<=30";

					if(poptype.toString().equals("SC"))
					{
						query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					else if(poptype.toString().equals("ST"))
					{
						query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
					}
					else if(poptype.equals("PLAIN"))
					{
						query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					//System.out.println("40PC3-----"+query1);
				}
	}
	else if(coverageStatus.equals("PC2")){
		if(lpcdrange1.equals("55")){
			//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=13.75 and hd.safe_lpcd<27.5";
			query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>=13.75 and hd.safe_lpcd<27.5";

			
			if(poptype.toString().equals("SC"))
			{
				query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			else if(poptype.toString().equals("ST"))
			{
				query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			//System.out.println("55PC3----------"+query1);
				}
				else{
					//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(ACT_PLAIN_POPU,0),nvl(ACT_SC_POPU,0),nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>10 and hd.safe_lpcd<=20 ";
								query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>10 and hd.safe_lpcd<=20";

					if(poptype.toString().equals("SC"))
					{
						query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					else if(poptype.toString().equals("ST"))
					{
						query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
					}
					else if(poptype.equals("PLAIN"))
					{
						query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					//System.out.println("40PC3-----"+query1);
				}
	}
	else if(coverageStatus.equals("PC1")){
		if(lpcdrange1.equals("55")){
			//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>0 and hd.safe_lpcd<13.75";
						query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>0 and hd.safe_lpcd<13.75";

			if(poptype.toString().equals("SC"))
			{
				query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			else if(poptype.toString().equals("ST"))
			{
				query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
			}
			else if(poptype.equals("PLAIN"))
			{
				query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
			}
			// System.out.println("55PC3----------"+query1);
				}
				else{
					//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,nvl(safe_lpcd,0),nvl(unsafe_lpcd,0),nvl(ACT_PLAIN_POPU,0),nvl(ACT_SC_POPU,0),nvl(ACT_ST_POPU,0),nvl(total_water_supply,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>0 and hd.safe_lpcd<=10";
								query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode='"+rDistrict+"' and hd.safe_lpcd>0 and hd.safe_lpcd<=10";

					if(poptype.toString().equals("SC"))
					{
						query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					else if(poptype.toString().equals("ST"))
					{
						query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
					}
					else if(poptype.equals("PLAIN"))
					{
						query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
					}
					//System.out.println("40PC3-----"+query1);
				}
	}
	
	
	preparedStatement=conn.prepareStatement(query1);
	//preparedStatement.setString(1, rDistrict);
	resultSet=preparedStatement.executeQuery(); 
	while(resultSet.next()){
		//sno++;
	
		totalPopulation=resultSet.getInt(8)+resultSet.getInt(9)+resultSet.getInt(10);
		total=total+totalPopulation;
%>

	<%

	int styleCount=0;
	String style="";
	
		 if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
	
	
%>


<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
 <td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(3) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(4) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(5) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(8) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(9) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(10) %></td>
<td class="<%=style %>" style="text-align: left;" align="right"><%=totalPopulation %></td>
</tr>

	<%
		}
	////System.out.println("size of the record is"+sno);
	preparedStatement.close();
	resultSet.close();
	%>
	<tr>
				<td class=gridhdbg style="text-align: right;" colspan="9">Total Population:  </td>
				<td class=gridhdbg style="text-align: left;" colspan="11"><%=total %></td>
			</tr> 
	<%}else if(coverageStatus.equals("NSS") || coverageStatus.equals("NC")){
		
			
				
				//query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(safe_lpcd,0),nvl(unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode=?";
			   query1="select distinct m.mname,p.pname,v.vname,h.panch_name,h.panch_code,hd.exist_water_level,hd.ACT_COVERAGE_STATUS,nvl(hd.ACT_PLAIN_POPU,'0'),nvl(hd.ACT_SC_POPU,'0'),nvl(hd.ACT_ST_POPU,'0'),nvl(hd.safe_lpcd,0),nvl(hd.unsafe_lpcd,0) from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_complete_hab_view h,"+habTableName+" hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr(h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.ACT_COVERAGE_STATUS is not null and hd.ACT_COVERAGE_STATUS not in('UI','NW')  and d.dcode=? ";

				
				if(poptype.toString().equals("SC"))
				{
					query1+=" and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_SC_POPU and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
				}
				else if(poptype.toString().equals("ST"))
				{
					query1+="   and   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))<= hd.ACT_ST_POPU ";
				}
				else if(poptype.equals("PLAIN"))
				{
					query1+="  AND   (nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_SC_POPU AND  (40/100)*(nvl(hd.ACT_PLAIN_POPU,'0')+nvl(hd.ACT_SC_POPU,'0')+nvl(hd.ACT_ST_POPU,'0'))> hd.ACT_ST_POPU  ";
				}
				//System.out.println("55-nss---------"+query1);
				 preparedStatement=conn.prepareStatement(query1);
					preparedStatement.setString(1, rDistrict);
					resultSet=preparedStatement.executeQuery(); 
					
					while(resultSet.next()){
						double safelpcd=resultSet.getDouble(11);
						double unsafelpcd=resultSet.getDouble(12);
						if(safelpcd==0 && unsafelpcd!=0)
						{
							String contaminationType="";
							String contaminationValue="";
							if(coverageStatus.equals("NSS")){
								String pcode=resultSet.getString(5);
								String contaminationQuery="select b.contamination_name,a.cont_perc from rws_hab_contamination_tbl a,rws_contamination_tbl b where a.cont_type=b.contamination_code and hab_code=? and status_date between ? and ?";
								PreparedStatement preparedStatement2=conn.prepareStatement(contaminationQuery);
								preparedStatement2.setString(1, pcode); 
								preparedStatement2.setString(2, startYear);
								preparedStatement2.setString(3, endYear); 
								ResultSet resultSet2=preparedStatement2.executeQuery();
								if(resultSet2.next()){
									contaminationType=resultSet2.getString(1);
									contaminationValue=resultSet2.getString(2);
								}
								preparedStatement2.close();
								resultSet2.close();
							totalPopulation=resultSet.getInt(8)+resultSet.getInt(9)+resultSet.getInt(10);
							total=total+totalPopulation;
					%>

						<%

						int styleCount=0;
						String style="";
						
							 if(styleCount%2==0){
								 style="gridbg1";
							 }else{
								 style="gridbg2";
							 }
							 styleCount++;
						
						
					%>


					<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
					 <td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(3) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(4) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(5) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(8) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(9) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(10) %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=totalPopulation %></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=contaminationType%></td>
					<td class="<%=style %>" style="text-align: left;" align="right"><%=contaminationValue %></td>
					</tr>

						
						
							
						<%}}else
						{
							if(safelpcd==0){
								if(coverageStatus.equals("NC")){
									totalPopulation=resultSet.getInt(8)+resultSet.getInt(9)+resultSet.getInt(10);
									total=total+totalPopulation;
							%>

								<%

								int styleCount=0;
								String style="";
								
									 if(styleCount%2==0){
										 style="gridbg1";
									 }else{
										 style="gridbg2";
									 }
									 styleCount++;
								
								
							%>


							<tr><td class="<%=style %>" style="text-align: left;" align="right"><%=count++ %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(1) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(2) %></td>
							 <td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(3) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(4) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(5) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(8) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(9) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=resultSet.getString(10) %></td>
							<td class="<%=style %>" style="text-align: left;" align="right"><%=totalPopulation %></td>
							</tr>

								
								
									
								<%
								}
								}
							
						}
					}
					preparedStatement.close();
					resultSet.close();
					%>
					 <tr>
				<td class=gridhdbg style="text-align: right;" colspan="9">Total Population:  </td>
				<td class=gridhdbg style="text-align: left;" colspan="11"><%=total %></td>
			</tr> 
					<%
					
					
		}
}
catch(Exception e){
	e.printStackTrace();
}
finally{
	try{
		if(conn!=null){
			conn.close();
		}
	}
	catch(Exception e){
		
	}
	
}
	%>
</table>

</html:html>



