<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
 
<%
////System.out.println("rDistrict:"+request.getParameter("rDistrict"));
ResultSet rs1 =null,rs2=null;
PreparedStatement ps1=null;
String rDistrict=null,rDistrictName=null,rMandal=null,rMandalName=null,rPanchayat=null,rPanchayatName=null,excelnav="";
 rDistrict = request.getParameter("rDistrict");
if(rDistrict!=null){
session.setAttribute("rDistrict",rDistrict);
}
rDistrictName=request.getParameter("&rDistrictName");
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
String drill = request.getParameter("drill");
String covStatus[] = request.getParameterValues("covStatus");
String covStatusPrint = "";
if(covStatus!=null && covStatus.length>0)
{
	covStatusPrint += " Coverage Status:";
	for(int j=0;j<covStatus.length;j++)
	{
		if(j==covStatus.length-1)
			covStatusPrint += covStatus[j];
		else
			covStatusPrint += covStatus[j]+"/";
	}
}
//System.out.println("print:"+covStatusPrint);

if(request.getParameter("covStatus")!=null)
{
	session.setAttribute("covStatusPrint",covStatusPrint);
}
else 
{
		covStatusPrint = (String)session.getAttribute("covStatusPrint");
}

String covStatusQry = "";
//System.out.println("request.getparam():"+request.getParameter("covStatusQry"));
//System.out.println("request.getAtttr():"+request.getAttribute("covStatusQry"));
if(request.getParameter("covStatusQry")!=null)
{
	covStatusQry = request.getParameter("covStatusQry");
	session.setAttribute("covStatusQryy",covStatusQry);
}
else 
{
		covStatusQry = (String)session.getAttribute("covStatusQryy");
}
//System.out.println("cov status qry:"+covStatusQry);
if(drill.equals("null"))
{
%>
<html>
 <head>
<title></title>
<!--<link rel="stylesheet" type="text/css" href="./resources/style/rwsstyle.css">-->
 </head>

<script>
function fnPopUp(URL,h,w)
	{ 
		var strTitle ='Details';
		var strUrl = URL;
		var strOptions= 'menubar=no,toolbar=no,scrollbars=Yes,status=no,resizable=yes,height='+h+',width='+w+',left=300,top=0';
		window.open(strUrl,strTitle,strOptions).focus();
	}

</script>
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
					<a href="rws_asset_abstract_excel.jsp"  target=_new>Excel
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=15>Assets-Abstract-Report</td>	
		</tr>
		<!-- 
		<tr>
		<td colspan="11">Drilled Down Abstract Report - Assets upto Mandal Level (District-Mandal)</td>
		</tr>
		 -->

<%
try
{  String zero="0";
	if(rDistrict!=null && rDistrict.equals("00"))
	{
	excelnav="0";
	%>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>			
			<td class=btext colspan=5 align=center>Safe</td>
			<td class=btext colspan=7 align=center>Un Safe</td>
			<td class=btext rowspan=2>Total&nbsp;Assets<br> District-wise</td>	
		</tr>
		<tr align="center">
			<td class=btext>No. of HPs</td>
			<td class=btext>No. of CPWS</td>
			<td class=btext>No. of PWS</td>
			<td class=btext>No. of MPWS</td>
			<td class=btext>Others</td>
			<td class=btext>No. of HPs</td>
			<td class=btext>PWS(UnSafe)</td>
			<td class=btext>MPWS(UnSafe)</td>
			<td class=btext>Open Wells </td>
			<td class=btext>Ponds</td>
			<td class=btext>Shallow Hand Pumps</td>
			<td class=btext>Others</td>
		</tr>
		<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
	<%
		String getDnameQuery = "select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode";
		////System.out.println("query:"+getDnameQuery);
		ps1=conn.prepareStatement(getDnameQuery);
		rs2 = ps1.executeQuery(); 
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0;
		while(rs2.next())
		{
//			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when MPWS_UNSAFE_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when HPS_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l  from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"')";
			String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rs2.getString(1)+"'"+covStatusQry+")";
			//System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue><a href="rws_asset_abstract_rpt1.jsp?drill=next&rDistrict=<%=rs2.getString(1)%>&rDistrictName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue align="right"><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue align="right"><%if(rs1.getString(2)!=null){%><a href=javascript:fnPopUp('rws_cpws_scheme_habs_list.jsp?dcode=<%=rs2.getString(1)%>&dname=<%=rs2.getString(2)%>',350,650)><%=rs1.getString(2)%></a><%} else{%>0<%} %></td>
			<td class=rptValue align="right"><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td class=btext align="right" colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
		</tr>
		<%
	}
	else
	{
	     excelnav="1";
		String getDataQuery = "select sum(case when HPS_NO <>'0' then HPS_NO else 0 end) as a,sum(case when cpws_no <>'0' then cpws_no else 0 end) as b,sum (case when pws_no <>'0' then pws_no else 0 end) as c,sum(case when MPWS_NO <>'0' then MPWS_NO else 0 end) as d,sum (case when OTHERS_NO_SAFE <>'0' then OTHERS_NO_SAFE else 0 end) as e,sum(case when HPS_NO_UNSAFE <>'0' then HPS_NO_UNSAFE else 0 end) as f,sum(case when OWS_NO <>'0' then OWS_NO else 0 end) as g,sum(case when PONDS_NO <>'0' then PONDS_NO else 0 end) as h,sum(case when SHP_NO <>'0' then SHP_NO else 0 end) as i,sum(case when OTHERS_NO <>'0' then OTHERS_NO else 0 end) as j,sum(case when PWS_UNSAFE_NO <>'0' then PWS_UNSAFE_NO else 0 end) as k,sum(case when MPWS_UNSAFE_NO <>'0' then MPWS_UNSAFE_NO else 0 end) as l from rws_hab_supply_status_tbl where hab_code in (select distinct h.panch_code from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,rws_panchayat_raj_tbl h,rws_habitation_directory_tbl hd where d.dcode=m.dcode and m.dcode=p.dcode and m.mcode =p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr (h.panch_code,1,2) = v.dcode and substr (h.panch_code,6,2) = v.mcode and substr(h.panch_code,13,2) = v.pcode and substr (h.panch_code,8,3) = v.vcode and h.panch_code=hd.hab_code and hd.coverage_status is not null and hd.coverage_status <> 'UI' and d.dcode='"+rDistrict+"'"+covStatusQry+")";
		//System.out.println("query:"+getDataQuery);
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
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2>District</td>
			<td class=btext colspan=5 align=center>Safe</td>
			<td class=btext colspan=7 align=center>Un Safe</td>
			<td class=btext rowspan=2>Total&nbsp;Assets <br>District-wise</td>	
		</tr>
		<tr align="center">
			<td class=btext>No. of HPs</td>
			<td class=btext>No. of CPWS</td>
			<td class=btext>No. of PWS</td>
			<td class=btext>No. of MPWS</td>
			<td class=btext>Others</td>
			<td class=btext>No. of HPs</td>
			<td class=btext>PWS(UnSafe)</td>
			<td class=btext>MPWS(UnSafe)</td>
			<td class=btext>Open Wells </td>
			<td class=btext>Ponds</td>
			<td class=btext>Shallow Hand Pumps</td>
			<td class=btext>Others</td>
		</tr>
		<tr><td class="btext" colspan="15"><%=covStatusPrint%></td></tr>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class="rptValue"><a href="rws_asset_abstract_rpt1.jsp?drill=next&rDistrict=<%=rDistrict%>&rDistrictName=<%=rs2.getString(2)%>"><%=rs2.getString(1)%></a></td>
			<td class=rptValue align="right"><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue align="right"><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>			
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
else if(drill!=null && drill.equals("next"))
{
 excelnav="2";
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
					<a href="rws_asset_abstract_excel.jsp"  target=_new>Excel
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
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
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2 nowrap>Mandal</td>			
			<td class=btext colspan=5 align=center>Safe</td>
			<td class=btext colspan=7 align=center>Un Safe</td>
			<td class=btext rowspan=2>Total&nbsp;Assets<br> Mandal-wise</td>	
		</tr>
		<tr align="center">
			<td class=btext>No. of HPs</td>
			<td class=btext>No. of CPWS</td>
			<td class=btext>No. of PWS</td>
			<td class=btext>No. of MPWS</td>
			<td class=btext>Others</td>
			<td class=btext>No. of HPs</td>
			<td class=btext>PWS(UnSafe)</td>
			<td class=btext>MPWS(UnSafe)</td>
			<td class=btext>Open Wells </td>
			<td class=btext>Ponds</td>
			<td class=btext>Shallow Hand Pumps</td>
			<td class=btext>Others</td>
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
			<td class="btext" colspan="15">District:<%=rs3.getString(1)%></td>
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
			
		//System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery);
			rs1 = ps.executeQuery();
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue><a href="rws_asset_abstract_rpt1.jsp?drill=next1&rDistrict=<%=rDistrict%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue align="right"><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue align="right"><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td class=btext align="right" colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
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
} else if(drill!=null && drill.equals("next1"))
{
 excelnav="3";
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
					<a href="rws_asset_abstract_excel.jsp"  target=_new>Excel
					</td>
					</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
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
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2 nowrap>Panchayat</td>			
			<td class=btext colspan=5 align=center>Safe</td>
			<td class=btext colspan=7 align=center>Un Safe</td>
			<td class=btext rowspan=2>Total&nbsp;Assets<br> Panchayat-wise</td>	
		</tr>
		<tr align="center">
			<td class=btext>No. of HPs</td>
			<td class=btext>No. of CPWS</td>
			<td class=btext>No. of PWS</td>
			<td class=btext>No. of MPWS</td>
			<td class=btext>Others</td>
			<td class=btext>No. of HPs</td>
			<td class=btext>PWS(UnSafe)</td>
			<td class=btext>MPWS(UnSafe)</td>
			<td class=btext>Open Wells </td>
			<td class=btext>Ponds</td>
			<td class=btext>Shallow Hand Pumps</td>
			<td class=btext>Others</td>
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
			<td class="btext" colspan="15">District:<%=rs3.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%></td>
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
			<td class=rptValue ><a href="rws_asset_abstract_rpt1.jsp?drill=next2&rDistrict=<%=rDistrict%>&rMandal=<%=rMandal%>&rMandalName=<%=rMandalName%>&rPanchayat=<%=rs2.getString(1)%>&rPanchayatName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></td>
			<td class=rptValuealign="right"><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue align="right"><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue align="right" ><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td class=btext align="right" colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
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
}  else if(drill!=null && drill.equals("next2"))
{
 excelnav="4";
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
					<a href="rws_asset_abstract_excel.jsp"  target=_new>Excel
					
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
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
			<td class=btext rowspan=2>Sno</td>
			<td class=btext rowspan=2 nowrap>Village</td>			
			<td class=btext colspan=5 align=center>Safe</td>
			<td class=btext colspan=7 align=center>Un Safe</td>
			<td class=btext rowspan=2>Total&nbsp;Assets<br> Village-wise</td>	
		</tr>
		<tr align="center">
			<td class=btext>No. of HPs</td>
			<td class=btext>No. of CPWS</td>
			<td class=btext>No. of PWS</td>
			<td class=btext>No. of MPWS</td>
			<td class=btext>Others</td>
			<td class=btext>No. of HPs</td>
			<td class=btext>PWS(UnSafe)</td>
			<td class=btext>MPWS(UnSafe)</td>
			<td class=btext>Open Wells </td>
			<td class=btext>Ponds</td>
			<td class=btext>Shallow Hand Pumps</td>
			<td class=btext>Others</td>
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
			<td class="btext" colspan="15">District:<%=rs3.getString(1)%>&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=rMandalName%>&nbsp;&nbsp;&nbsp;&nbsp;Panchayat:<%=rPanchayatName%></td>
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
			<td class=rptValue align="right"><%=rs1.getString(1)!=null ? rs1.getString(1) : "0" %></td>
			<td class=rptValue align="right"><%=rs1.getString(2)!=null ? rs1.getString(2) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(3)!=null ? rs1.getString(3) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)!=null ? rs1.getString(4) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)!=null ? rs1.getString(5) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)!=null ? rs1.getString(6) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(11)!=null ? rs1.getString(11) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)!=null ? rs1.getString(12) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)!=null ? rs1.getString(7) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)!=null ? rs1.getString(8) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)!=null ? rs1.getString(9) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)!=null ? rs1.getString(10) : "0"%></td>
			<td class=rptValue align="right"><%=rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4)+rs1.getInt(5)+rs1.getInt(6)+rs1.getInt(7)+rs1.getInt(8)+rs1.getInt(9)+rs1.getInt(10)+rs1.getInt(11)+rs1.getInt(12)%></td>
		</tr>		
		<%
		columnTotal1 += rs1.getInt(1);columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		
		}
		%>
		<tr>
			<td class=btext  align="right"colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal1+columnTotal2+columnTotal3+columnTotal4+columnTotal5+columnTotal6+columnTotal7+columnTotal8+columnTotal9+columnTotal10+columnTotal11+columnTotal12%></td>
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

}
session.setAttribute("excelnav",excelnav);
%>
<table><tr><td> Note : 1. Report is based on the values entered in the habitaton directory form and not on actual assets basis </td></tr></table>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
