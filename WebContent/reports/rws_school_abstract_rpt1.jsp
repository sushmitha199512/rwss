<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<%
////// System.out.println("rDistrict:"+request.getParameter("rDistrict"));
StringBuffer getDnameQuery=new StringBuffer();
StringBuffer getHabCountQuery=new StringBuffer();
StringBuffer  getDataQuery=new StringBuffer();


StringBuffer rDistrict =new StringBuffer();
rDistrict.append(request.getParameter("rDistrict"));
session.setAttribute("rDistrict",rDistrict);
//System.out.println("rDistrict:"+rDistrict);

StringBuffer dname =new StringBuffer();
dname.append(request.getParameter("rDistrictName"));
session.setAttribute("rDistrictName",dname);

StringBuffer rMandal=new StringBuffer();
rMandal.append(request.getParameter("rMandal"));

session.setAttribute("rMandal", rMandal);


StringBuffer mname = new StringBuffer();
mname.append(request.getParameter("rMandalName"));
session.setAttribute("rMandalName",mname);

StringBuffer rPanchayat = new StringBuffer();
rPanchayat.append(request.getParameter("rPanchayat"));
session.setAttribute("rPanchayat",rPanchayat);

StringBuffer pname =new StringBuffer();
pname.append(request.getParameter("rPanchayatName"));
session.setAttribute("rPanchayatName",pname);
//System.out.println("rPanchayatName:"+pname);

StringBuffer drill=new StringBuffer();
drill.append(request.getParameter("drill"));

session.setAttribute("drill",drill);
//System.out.println("Drill:"+drill);
if(drill.toString().equals("null"))
{
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
					<a href="rws_school_abstract_rpt1_excel.jsp">Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
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
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>District</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
			<td class="btext" colspan="36" align="center">Classification</td>
			<td class="btext" colspan="8" align="center">Facilities</td>
			
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Upper Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Sr.Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Govt.</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Local Body</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			<td class=btext>Govt.Aided</td>	
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Private</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

             <td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			
			
		</tr>
	
	
	<%
	
	getDnameQuery.delete(0,getDnameQuery.length());
	
	
		 getDnameQuery.append("select dcode,dname from rws_district_tbl where dcode <> '16' order by dcode");
		//System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery.toString());
		ResultSet rs2 = ps1.executeQuery(); 
		
		
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0,columnTotal13=0,columnTotal14=0,columnTotal15=0, columnTotal16=0,columnTotal17=0,columnTotal18=0,columnTotal19=0,columnTotal20=0,
		columnTotal21=0,columnTotal22=0,columnTotal23=0,columnTotal24=0,columnTotal25=0, columnTotal26=0,columnTotal27=0,columnTotal28=0,columnTotal29=0,columnTotal30=0,
		columnTotal31=0,columnTotal32=0,columnTotal33=0,columnTotal34=0,columnTotal35=0, columnTotal36=0,columnTotal37=0,columnTotal38=0,columnTotal39=0,columnTotal40=0,
		columnTotal41=0,columnTotal42=0,columnTotal43=0,columnTotal44=0,columnTotal45=0, columnTotal46=0,columnTotal47=0,columnTotal48=0,columnTotal49=0,columnTotal50=0,
		columnTotal51=0,columnTotal52=0,columnTotal53=0,columnTotal54=0,columnTotal55=0, 
		columnTotal56=0,columnTotal57=0,columnTotal58=0,columnTotal59=0,columnTotal60=0,
		columnTotal61=0,columnTotal62=0,columnTotal63=0,columnTotal64=0,columnTotal65=0, columnTotal66=0,columnTotal67=0,columnTotal68=0,columnTotal69=0,columnTotal70=0,
		columnTotal71=0,columnTotal72=0,columnTotal73=0,columnTotal74=0,columnTotal75=0, 
		columnTotal76=0,columnTotal77=0,columnTotal78=0,columnTotal79=0,columnTotal80=0,
		columnTotal81=0,columnTotal82=0,columnTotal83=0,columnTotal84=0,columnTotal85=0, columnTotal86=0,columnTotal87=0,columnTotal88=0,columnTotal89=0,columnTotal90=0,
        columnTotal91=0,columnTotal92=0;

		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		
		
		while(rs2.next())
		{
			getHabCountQuery.delete(0,getHabCountQuery.length());
			getHabCountQuery.append("select hab_code,count(*) from rws_school_master_tbl where substr(hab_code,1,2)='"+rs2.getString(1)+"' group by hab_code having count (*) >=1 ");
			getHabRs = getHabSt.executeQuery(getHabCountQuery.toString());
			int habCount = 0 ;
			getHabRs.afterLast();
			getHabRs.previous();
			habCount = getHabRs.getRow();
			//System.out.println("sizee:"+habCount);
			
			getDataQuery.delete(0,getDataQuery.length());
			getDataQuery.append("select count(hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as a1,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as a2,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)')then 1 else 0 end) as a3,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as a4,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as a5,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as a6,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as a7,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as a8,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as b1,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as b2,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end)as  b3,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as b4,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as b5,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as b6,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as b7,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as b8,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as c1,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as c2,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c3,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as c4,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as c5,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as c6,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as c7,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c8,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as d1,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as d2,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d3,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as d4,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as d5,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as d6,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as d7,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d8,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as e1,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as e2,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e3,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as e4,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as e5,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as e6,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as e7,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e8,sum(case when SCHOOL_CLASSIFICATION = 'Government' then 1 else 0 end) as f,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as f1,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as f2,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f3,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as f4,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as f5,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as f6,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as f7,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f8,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' then 1 else 0 end) as g,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as g1,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as g2,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g3,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as g4,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as g5,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as g6,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as g7,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g8,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' then 1 else 0 end) as h,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as h1,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as h2,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as h3,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as h4,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as h5,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as h6,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as h7,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as h8,sum(case when SCHOOL_CLASSIFICATION = 'Private' then 1 else 0 end) as i,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as i1,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as i2,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i3,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as i4,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as i5,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as i6,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as i7,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i8,sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as j,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as k,	sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as l,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as m,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as n,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as o,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as p,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as q from rws_school_master_tbl where  substr(hab_code,1,2)='"+rs2.getString(1)+"'");
           ps =conn.prepareStatement(getDataQuery.toString());
			//System.out.println("getDataQuery:"+getDataQuery);
			ResultSet rs1 = ps.executeQuery();
		
			rs1.next();
		/* // System.out.println("1:"+habCount);
		// System.out.println("2:"+rs1.getString(2));
		// System.out.println("3:"+rs1.getString(3));
		// System.out.println("4:"+rs1.getString(4));
		// System.out.println("5:"+rs1.getString(5));
		// System.out.println("6:"+rs1.getString(6));
		// System.out.println("7:"+rs1.getString(7));
		// System.out.println("8:"+rs1.getString(8));
		// System.out.println("9:"+rs1.getString(9));
		// System.out.println("10:"+rs1.getString(10));
		// System.out.println("11:"+rs1.getString(11));
		// System.out.println("12:"+rs1.getString(12));
		// System.out.println("13:"+rs1.getString(13));
		// System.out.println("14:"+rs1.getString(14));
		// System.out.println("15:"+rs1.getString(15));
		// System.out.println("16:"+rs1.getString(16));
		// System.out.println("17:"+rs1.getString(17));
		// System.out.println("18:"+rs1.getString(18));
		// System.out.println("19:"+rs1.getString(19));
		// System.out.println("20:"+rs1.getString(20));
		// System.out.println("21:"+rs1.getString(21));
		// System.out.println("22:"+rs1.getString(22));
		// System.out.println("23:"+rs1.getString(23));
		// System.out.println("24:"+rs1.getString(24));
		// System.out.println("25:"+rs1.getString(25));
		// System.out.println("26:"+rs1.getString(26));
		// System.out.println("27:"+rs1.getString(27));
		// System.out.println("28:"+rs1.getString(28));
		// System.out.println("29:"+rs1.getString(29));
		// System.out.println("30:"+rs1.getString(30));

		// System.out.println("41:"+rs1.getString(41));
		// System.out.println("42:"+rs1.getString(42));
		// System.out.println("43:"+rs1.getString(43));
		// System.out.println("44:"+rs1.getString(44));
		// System.out.println("45:"+rs1.getString(45));
		// System.out.println("46:"+rs1.getString(46));
		// System.out.println("47:"+rs1.getString(47));
		// System.out.println("48:"+rs1.getString(48));
		// System.out.println("49:"+rs1.getString(49));
		// System.out.println("50:"+rs1.getString(50));


		// System.out.println("51:"+rs1.getString(51));
		// System.out.println("52:"+rs1.getString(52));
		// System.out.println("53:"+rs1.getString(53));
		// System.out.println("54:"+rs1.getString(54));
		// System.out.println("55:"+rs1.getString(55));
		// System.out.println("56:"+rs1.getString(56));
		// System.out.println("57:"+rs1.getString(57));
		// System.out.println("58:"+rs1.getString(58));
		// System.out.println("59:"+rs1.getString(59));
		// System.out.println("60:"+rs1.getString(60));

		// System.out.println("61:"+rs1.getString(61));
		// System.out.println("62:"+rs1.getString(62));
		// System.out.println("63:"+rs1.getString(63));
		// System.out.println("64:"+rs1.getString(64));
		// System.out.println("65:"+rs1.getString(65));
		// System.out.println("66:"+rs1.getString(66));
		// System.out.println("67:"+rs1.getString(67));
		// System.out.println("68:"+rs1.getString(68));
		// System.out.println("69:"+rs1.getString(69));
		// System.out.println("70:"+rs1.getString(70));


		
		// System.out.println("71:"+rs1.getString(71));
		// System.out.println("72:"+rs1.getString(72));
		// System.out.println("73:"+rs1.getString(73));
		// System.out.println("74:"+rs1.getString(74));
		// System.out.println("75:"+rs1.getString(75));
		// System.out.println("76:"+rs1.getString(76));
		// System.out.println("77:"+rs1.getString(77));
		// System.out.println("78:"+rs1.getString(78));
		// System.out.println("79:"+rs1.getString(79));
		// System.out.println("80:"+rs1.getString(80));

		// System.out.println("81:"+rs1.getString(81));
		// System.out.println("82:"+rs1.getString(82));
		// System.out.println("83:"+rs1.getString(83));
		// System.out.println("84:"+rs1.getString(84));
		// System.out.println("85:"+rs1.getString(85));
		// System.out.println("86:"+rs1.getString(86));
		// System.out.println("87:"+rs1.getString(87));
		// System.out.println("88:"+rs1.getString(88));
		// System.out.println("89:"+rs1.getString(89));
		// System.out.println("90:"+rs1.getString(90));

		// System.out.println("91:"+rs1.getString(91));
		// System.out.println("92:"+rs1.getString(92));*/





		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><a href="rws_school_abstract_rpt1.jsp?drill=next&rDistrict=<%=rs2.getString(1)%>&rDistrictName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue align="right"><%=habCount%></td>
			<td class=rptValue align="right"><%=rs1.getString(2)%></td>
			<td class=rptValue align="right"><%=rs1.getString(3)%></td>
			<td class=rptValue align="right"><%=rs1.getString(4)%></td>
			<td class=rptValue align="right"><%=rs1.getString(5)%></td>
			<td class=rptValue align="right"><%=rs1.getString(6)%></td>
			<td class=rptValue align="right"><%=rs1.getString(7)%></td>
			<td class=rptValue align="right"><%=rs1.getString(8)%></td>
			<td class=rptValue align="right"><%=rs1.getString(9)%></td>
			<td class=rptValue align="right"><%=rs1.getString(10)%></td>
			<td class=rptValue align="right"><%=rs1.getString(11)%></td>
			<td class=rptValue align="right"><%=rs1.getString(12)%></td>
			<td class=rptValue align="right"><%=rs1.getString(13)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(14)%></td>
			<td class=rptValue align="right"><%=rs1.getString(15)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(16)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(17)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(18)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(19)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(20)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(21)%></td>
			<td class=rptValue align="right"><%=rs1.getString(22)%></td>
			<td class=rptValue align="right"><%=rs1.getString(23)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(24)%></td>
			<td class=rptValue align="right"><%=rs1.getString(25)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(26)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(27)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(28)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(29)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(30)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(31)%></td>
			<td class=rptValue align="right"><%=rs1.getString(32)%></td>
			<td class=rptValue align="right"><%=rs1.getString(33)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(34)%></td>
			<td class=rptValue align="right"><%=rs1.getString(35)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(36)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(37)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(38)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(39)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(40)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(41)%></td>
			<td class=rptValue align="right"><%=rs1.getString(42)%></td>
			<td class=rptValue align="right"><%=rs1.getString(43)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(44)%></td>
			<td class=rptValue align="right"><%=rs1.getString(45)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(46)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(47)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(48)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(49)%></td>
			<td class=rptValue align="right"><%=rs1.getString(50)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(51)%></td>
			<td class=rptValue align="right"><%=rs1.getString(52)%></td>
			<td class=rptValue align="right"><%=rs1.getString(53)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(54)%></td>
			<td class=rptValue align="right"><%=rs1.getString(55)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(56)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(57)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(58)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(59)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(60)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(61)%></td>
			<td class=rptValue align="right"><%=rs1.getString(62)%></td>
			<td class=rptValue align="right"><%=rs1.getString(63)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(64)%></td>
			<td class=rptValue align="right"><%=rs1.getString(65)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(66)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(67)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(68)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(69)%></td>
			<td class=rptValue align="right"><%=rs1.getString(70)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(71)%></td>
			<td class=rptValue align="right"><%=rs1.getString(72)%></td>
			<td class=rptValue align="right"><%=rs1.getString(73)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(74)%></td>
			<td class=rptValue align="right"><%=rs1.getString(75)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(76)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(77)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(78)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(79)%></td>
			<td class=rptValue align="right"><%=rs1.getString(80)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(81)%></td>
			<td class=rptValue align="right"><%=rs1.getString(82)%></td>
			<td class=rptValue align="right"><%=rs1.getString(83)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(84)%></td>
			<td class=rptValue align="right"><%=rs1.getString(85)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(86)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(87)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(88)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(89)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(90)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(91)%></td>
			<td class=rptValue align="right"><%=rs1.getString(92)%></td>
		
			
			

			

		</tr>		
		<%
		columnTotal1 += habCount;columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		columnTotal13 += rs1.getInt(13);columnTotal14 += rs1.getInt(14);columnTotal15 += rs1.getInt(15);
		columnTotal16 += rs1.getInt(16);columnTotal17 += rs1.getInt(17);columnTotal18 += rs1.getInt(18);
		columnTotal19 += rs1.getInt(19);columnTotal20 += rs1.getInt(20);
         
	    columnTotal21 += rs1.getInt(21);columnTotal22 += rs1.getInt(22);
		columnTotal23 += rs1.getInt(23);columnTotal24 += rs1.getInt(24);columnTotal25 += rs1.getInt(25);
		columnTotal26 += rs1.getInt(26);columnTotal27 += rs1.getInt(27);columnTotal28 += rs1.getInt(28);
		columnTotal29 += rs1.getInt(29);columnTotal20 += rs1.getInt(30);
		columnTotal31 += rs1.getInt(31);columnTotal32 += rs1.getInt(32);
		columnTotal33 += rs1.getInt(33);columnTotal34 += rs1.getInt(34);columnTotal35 += rs1.getInt(35);
		columnTotal36 += rs1.getInt(36);columnTotal37 += rs1.getInt(37);columnTotal38 += rs1.getInt(38);
		columnTotal39 += rs1.getInt(39);columnTotal40 += rs1.getInt(40);
		columnTotal41 += rs1.getInt(41);columnTotal42 += rs1.getInt(42);
		columnTotal43 += rs1.getInt(43);columnTotal44 += rs1.getInt(44);columnTotal45 += rs1.getInt(45);
		columnTotal46 += rs1.getInt(46);columnTotal47 += rs1.getInt(47);columnTotal48 += rs1.getInt(48);
		columnTotal49 += rs1.getInt(49);columnTotal50 += rs1.getInt(50);
		columnTotal51 += rs1.getInt(51);columnTotal52 += rs1.getInt(52);
		columnTotal53 += rs1.getInt(53);columnTotal54 += rs1.getInt(54);columnTotal55 += rs1.getInt(55);
		columnTotal56 += rs1.getInt(56);columnTotal57 += rs1.getInt(57);columnTotal58 += rs1.getInt(58);
		columnTotal59 += rs1.getInt(59);columnTotal60 += rs1.getInt(60);
		columnTotal61 += rs1.getInt(61);columnTotal62 += rs1.getInt(62);
		columnTotal63 += rs1.getInt(63);columnTotal64 += rs1.getInt(64);columnTotal65 += rs1.getInt(65);
		columnTotal66 += rs1.getInt(66);columnTotal67 += rs1.getInt(67);columnTotal68 += rs1.getInt(68);
		columnTotal69 += rs1.getInt(69);columnTotal60 += rs1.getInt(70);
		columnTotal71 += rs1.getInt(71);columnTotal72 += rs1.getInt(72);
		columnTotal73 += rs1.getInt(73);columnTotal74 += rs1.getInt(74);columnTotal75 += rs1.getInt(75);
		columnTotal76 += rs1.getInt(76);columnTotal77 += rs1.getInt(77);columnTotal78 += rs1.getInt(78);
		columnTotal79 += rs1.getInt(79);columnTotal70 += rs1.getInt(80);
		columnTotal81 += rs1.getInt(81);columnTotal82 += rs1.getInt(82);
		columnTotal83 += rs1.getInt(83);columnTotal84 += rs1.getInt(84);columnTotal85 += rs1.getInt(85);
		columnTotal86 += rs1.getInt(86);columnTotal87 += rs1.getInt(87);columnTotal88 += rs1.getInt(88);
		columnTotal89 += rs1.getInt(89);columnTotal90 += rs1.getInt(90);	 columnTotal91 += rs1.getInt(91);
		columnTotal92 += rs1.getInt(92);


		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal13%></td>
			<td class=rptValue align="right"><%=columnTotal14%></td>
			<td class=rptValue align="right"><%=columnTotal15%></td>
			<td class=rptValue align="right"><%=columnTotal16%></td>
			<td class=rptValue align="right"><%=columnTotal17%></td>
			<td class=rptValue align="right"><%=columnTotal18%></td>
			<td class=rptValue align="right"><%=columnTotal19%></td>
			<td class=rptValue align="right"><%=columnTotal20%></td>
			<td class=rptValue align="right"><%=columnTotal21%></td>
			<td class=rptValue align="right"><%=columnTotal22%></td>
			<td class=rptValue align="right"><%=columnTotal23%></td>								
			<td class=rptValue align="right"><%=columnTotal24%></td>
			<td class=rptValue align="right"><%=columnTotal25%></td>	
			<td class=rptValue align="right"><%=columnTotal26%></td>		
			<td class=rptValue align="right"><%=columnTotal27%></td>		
			<td class=rptValue align="right"><%=columnTotal28%></td>		
			<td class=rptValue align="right"><%=columnTotal29%></td>		
			<td class=rptValue align="right"><%=columnTotal30%></td>		
			<td class=rptValue align="right"><%=columnTotal31%></td>
			<td class=rptValue align="right"><%=columnTotal32%></td>
			<td class=rptValue align="right"><%=columnTotal33%></td>								
			<td class=rptValue align="right"><%=columnTotal34%></td>
			<td class=rptValue align="right"><%=columnTotal35%></td>	
			<td class=rptValue align="right"><%=columnTotal36%></td>		
			<td class=rptValue align="right"><%=columnTotal37%></td>		
			<td class=rptValue align="right"><%=columnTotal38%></td>		
			<td class=rptValue align="right"><%=columnTotal39%></td>		
			<td class=rptValue align="right"><%=columnTotal40%></td>	
			<td class=rptValue align="right"><%=columnTotal41%></td>
			<td class=rptValue align="right"><%=columnTotal42%></td>
			<td class=rptValue align="right"><%=columnTotal43%></td>								
			<td class=rptValue align="right"><%=columnTotal44%></td>
			<td class=rptValue align="right"><%=columnTotal45%></td>	
			<td class=rptValue align="right"><%=columnTotal46%></td>		
			<td class=rptValue align="right"><%=columnTotal47%></td>		
			<td class=rptValue align="right"><%=columnTotal48%></td>		
			<td class=rptValue align="right"><%=columnTotal49%></td>
			<td class=rptValue align="right"><%=columnTotal50%></td>	
			<td class=rptValue align="right"><%=columnTotal51%></td>
			<td class=rptValue align="right"><%=columnTotal52%></td>
			<td class=rptValue align="right"><%=columnTotal53%></td>								
			<td class=rptValue align="right"><%=columnTotal54%></td>
			<td class=rptValue align="right"><%=columnTotal55%></td>	
			<td class=rptValue align="right"><%=columnTotal56%></td>		
			<td class=rptValue align="right"><%=columnTotal57%></td>		
			<td class=rptValue align="right"><%=columnTotal58%></td>		
			<td class=rptValue align="right"><%=columnTotal59%></td>	
			<td class=rptValue align="right"><%=columnTotal60%></td>	
			<td class=rptValue align="right"><%=columnTotal61%></td>
			<td class=rptValue align="right"><%=columnTotal62%></td>
			<td class=rptValue align="right"><%=columnTotal63%></td>								
			<td class=rptValue align="right"><%=columnTotal64%></td>
			<td class=rptValue align="right"><%=columnTotal65%></td>	
			<td class=rptValue align="right"><%=columnTotal66%></td>		
			<td class=rptValue align="right"><%=columnTotal67%></td>		
			<td class=rptValue align="right"><%=columnTotal68%></td>		
			<td class=rptValue align="right"><%=columnTotal69%></td>
			<td class=rptValue align="right"><%=columnTotal70%></td>	
			<td class=rptValue align="right"><%=columnTotal71%></td>
			<td class=rptValue align="right"><%=columnTotal72%></td>
			<td class=rptValue align="right"><%=columnTotal73%></td>								
			<td class=rptValue align="right"><%=columnTotal74%></td>
			<td class=rptValue align="right"><%=columnTotal75%></td>	
			<td class=rptValue align="right"><%=columnTotal76%></td>		
			<td class=rptValue align="right"><%=columnTotal77%></td>		
			<td class=rptValue align="right"><%=columnTotal78%></td>		
			<td class=rptValue align="right"><%=columnTotal79%></td>
			<td class=rptValue align="right"><%=columnTotal80%></td>	
			<td class=rptValue align="right"><%=columnTotal81%></td>
			<td class=rptValue align="right"><%=columnTotal82%></td>
			<td class=rptValue align="right"><%=columnTotal83%></td>								
			<td class=rptValue align="right"><%=columnTotal84%></td>
			<td class=rptValue align="right"><%=columnTotal85%></td>	
			<td class=rptValue align="right"><%=columnTotal86%></td>		
			<td class=rptValue align="right"><%=columnTotal87%></td>		
			<td class=rptValue align="right"><%=columnTotal88%></td>		
			<td class=rptValue align="right"><%=columnTotal89%></td>	
			<td class=rptValue align="right"><%=columnTotal90%></td>	
			<td class=rptValue align="right"><%=columnTotal91%></td>
			<td class=rptValue align="right"><%=columnTotal92%></td>

			
		</tr>
		<%
	}
	else
	{}
	%>
	 
				
<%
}
catch(Exception e)
{
	e.printStackTrace();
}
}
else if(drill.toString()!=null && drill.toString().equals("next"))
{
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
					<a href="rws_school_abstract_rpt1_excel.jsp">Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Mandal</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
			<td class="btext" colspan="36" align="center">Classification</td>
			<td class="btext" colspan="8" align="center">Facilities</td>
		</tr>
		<tr align="center">
			
			<td class=btext>Anganwadi</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Upper Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Sr.Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Govt.</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Local Body</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			<td class=btext>Govt.Aided</td>	
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Private</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

             <td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			
		</tr>
		<tr>
			<td class="btext" colspan="92">District:<%=dname%></td>
		</tr>
	<%
	getDnameQuery.delete(0,getDnameQuery.length());
		getDnameQuery.append("select mcode,mname from rws_mandal_tbl where dcode = '"+rDistrict+"' order by mcode");
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery.toString());
		ResultSet rs2 = ps1.executeQuery(); 
		
		
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0,columnTotal13=0,columnTotal14=0,columnTotal15=0,columnTotal16=0,columnTotal17=0,columnTotal18=0,columnTotal19=0,columnTotal20=0,
		columnTotal21=0,columnTotal22=0,columnTotal23=0,columnTotal24=0,columnTotal25=0, columnTotal26=0,columnTotal27=0,columnTotal28=0,columnTotal29=0,columnTotal30=0,
		columnTotal31=0,columnTotal32=0,columnTotal33=0,columnTotal34=0,columnTotal35=0, columnTotal36=0,columnTotal37=0,columnTotal38=0,columnTotal39=0,columnTotal40=0,
		columnTotal41=0,columnTotal42=0,columnTotal43=0,columnTotal44=0,columnTotal45=0, columnTotal46=0,columnTotal47=0,columnTotal48=0,columnTotal49=0,columnTotal50=0,
		columnTotal51=0,columnTotal52=0,columnTotal53=0,columnTotal54=0,columnTotal55=0, 
		columnTotal56=0,columnTotal57=0,columnTotal58=0,columnTotal59=0,columnTotal60=0,
		columnTotal61=0,columnTotal62=0,columnTotal63=0,columnTotal64=0,columnTotal65=0, columnTotal66=0,columnTotal67=0,columnTotal68=0,columnTotal69=0,columnTotal70=0,
		columnTotal71=0,columnTotal72=0,columnTotal73=0,columnTotal74=0,columnTotal75=0, 
		columnTotal76=0,columnTotal77=0,columnTotal78=0,columnTotal79=0,columnTotal80=0,
		columnTotal81=0,columnTotal82=0,columnTotal83=0,columnTotal84=0,columnTotal85=0, columnTotal86=0,columnTotal87=0,columnTotal88=0,columnTotal89=0,columnTotal90=0,
        columnTotal91=0,columnTotal92=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		
		
		while(rs2.next())
		{
			getHabCountQuery.delete(0,getHabCountQuery.length());
			
			getHabCountQuery.append("select hab_code,count(*) from rws_school_master_tbl where substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rs2.getString(1)+"' group by hab_code having count (*) >=1 ");
			getHabRs = getHabSt.executeQuery(getHabCountQuery.toString());
			int habCount = 0 ;
			getHabRs.afterLast();
			getHabRs.previous();
			habCount = getHabRs.getRow();
			////// System.out.println("sizee:"+habCount);
			
			
			getDataQuery.delete(0,getDataQuery.length());
			 getDataQuery.append("select count(hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as a1,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as a2,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)')then 1 else 0 end) as a3,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as a4,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as a5,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as a6,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as a7,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as a8,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as b1,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as b2,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end)as  b3,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as b4,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as b5,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as b6,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as b7,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as b8,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as c1,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as c2,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c3,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as c4,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as c5,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as c6,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as c7,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c8,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as d1,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as d2,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d3,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as d4,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as d5,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as d6,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as d7,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d8,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as e1,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as e2,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e3,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as e4,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as e5,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as e6,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as e7,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e8,sum(case when SCHOOL_CLASSIFICATION = 'Government' then 1 else 0 end) as f,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as f1,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as f2,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f3,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as f4,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as f5,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as f6,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as f7,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f8,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' then 1 else 0 end) as g,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as g1,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as g2,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g3,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as g4,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as g5,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as g6,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as g7,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g8,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' then 1 else 0 end) as h,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as h1,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as h2,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as h3,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as h4,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as h5,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as h6,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as h7,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as h8,sum(case when SCHOOL_CLASSIFICATION = 'Private' then 1 else 0 end) as i,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as i1,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as i2,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i3,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as i4,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as i5,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as i6,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as i7,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i8,sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as j,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as k,	sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as l,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as m,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as n,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as o,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as p,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as q from rws_school_master_tbl where  substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rs2.getString(1)+"'");


			//// System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery.toString());
			ResultSet rs1 = ps.executeQuery();
			
			rs1.next();
		%>
		<tr>
			<td class=rptValue><%=sno++%></td>
			<td class=rptValue nowrap><a href="rws_school_abstract_rpt1.jsp?drill=next1&rDistrict=<%=rDistrict%>&rDistrictName=<%=dname%>&rMandal=<%=rs2.getString(1)%>&rMandalName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue align="right"><%=habCount	%></td>
			<td class=rptValue align="right"><%=rs1.getString(2)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(3)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(4)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(5)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(6)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(7)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(8)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(9)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(10)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(11)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(12)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(13)%></td>								
			<td class=rptValue align="right"><%=rs1.getInt(14)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(15)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(16)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(17)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(18)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(19)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(20)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(21)%></td>
			<td class=rptValue align="right"><%=rs1.getString(22)%></td>
			<td class=rptValue align="right"><%=rs1.getString(23)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(24)%></td>
			<td class=rptValue align="right"><%=rs1.getString(25)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(26)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(27)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(28)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(29)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(30)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(31)%></td>
			<td class=rptValue align="right"><%=rs1.getString(32)%></td>
			<td class=rptValue align="right"><%=rs1.getString(33)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(34)%></td>
			<td class=rptValue align="right"><%=rs1.getString(35)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(36)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(37)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(38)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(39)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(40)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(41)%></td>
			<td class=rptValue align="right"><%=rs1.getString(42)%></td>
			<td class=rptValue align="right"><%=rs1.getString(43)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(44)%></td>
			<td class=rptValue align="right"><%=rs1.getString(45)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(46)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(47)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(48)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(49)%></td>
			<td class=rptValue align="right"><%=rs1.getString(50)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(51)%></td>
			<td class=rptValue align="right"><%=rs1.getString(52)%></td>
			<td class=rptValue align="right"><%=rs1.getString(53)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(54)%></td>
			<td class=rptValue align="right"><%=rs1.getString(55)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(56)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(57)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(58)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(59)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(60)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(61)%></td>
			<td class=rptValue align="right"><%=rs1.getString(62)%></td>
			<td class=rptValue align="right"><%=rs1.getString(63)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(64)%></td>
			<td class=rptValue align="right"><%=rs1.getString(65)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(66)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(67)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(68)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(69)%></td>
			<td class=rptValue align="right"><%=rs1.getString(70)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(71)%></td>
			<td class=rptValue align="right"><%=rs1.getString(72)%></td>
			<td class=rptValue align="right"><%=rs1.getString(73)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(74)%></td>
			<td class=rptValue align="right"><%=rs1.getString(75)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(76)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(77)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(78)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(79)%></td>
			<td class=rptValue align="right"><%=rs1.getString(80)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(81)%></td>
			<td class=rptValue align="right"><%=rs1.getString(82)%></td>
			<td class=rptValue align="right"><%=rs1.getString(83)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(84)%></td>
			<td class=rptValue align="right"><%=rs1.getString(85)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(86)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(87)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(88)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(89)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(90)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(91)%></td>
			<td class=rptValue align="right"><%=rs1.getString(92)%></td>
		</tr>		
		<%
		columnTotal1 += habCount;columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		columnTotal13 += rs1.getInt(13);columnTotal14 += rs1.getInt(14);columnTotal15 += rs1.getInt(15);
		columnTotal16 += rs1.getInt(16);columnTotal17 += rs1.getInt(17);columnTotal18 += rs1.getInt(18);
		columnTotal19 += rs1.getInt(19);columnTotal20 += rs1.getInt(20);
		columnTotal21 += rs1.getInt(21);columnTotal22 += rs1.getInt(22);
		columnTotal23 += rs1.getInt(23);columnTotal24 += rs1.getInt(24);columnTotal25 += rs1.getInt(25);
		columnTotal26 += rs1.getInt(26);columnTotal27 += rs1.getInt(27);columnTotal28 += rs1.getInt(28);
		columnTotal29 += rs1.getInt(29);columnTotal20 += rs1.getInt(30);
		columnTotal31 += rs1.getInt(31);columnTotal32 += rs1.getInt(32);
		columnTotal33 += rs1.getInt(33);columnTotal34 += rs1.getInt(34);columnTotal35 += rs1.getInt(35);
		columnTotal36 += rs1.getInt(36);columnTotal37 += rs1.getInt(37);columnTotal38 += rs1.getInt(38);
		columnTotal39 += rs1.getInt(39);columnTotal40 += rs1.getInt(40);
		columnTotal41 += rs1.getInt(41);columnTotal42 += rs1.getInt(42);
		columnTotal43 += rs1.getInt(43);columnTotal44 += rs1.getInt(44);columnTotal45 += rs1.getInt(45);
		columnTotal46 += rs1.getInt(46);columnTotal47 += rs1.getInt(47);columnTotal48 += rs1.getInt(48);
		columnTotal49 += rs1.getInt(49);columnTotal50 += rs1.getInt(50);
		columnTotal51 += rs1.getInt(51);columnTotal52 += rs1.getInt(52);
		columnTotal53 += rs1.getInt(53);columnTotal54 += rs1.getInt(54);columnTotal55 += rs1.getInt(55);
		columnTotal56 += rs1.getInt(56);columnTotal57 += rs1.getInt(57);columnTotal58 += rs1.getInt(58);
		columnTotal59 += rs1.getInt(59);columnTotal60 += rs1.getInt(60);
		columnTotal61 += rs1.getInt(61);columnTotal62 += rs1.getInt(62);
		columnTotal63 += rs1.getInt(63);columnTotal64 += rs1.getInt(64);columnTotal65 += rs1.getInt(65);
		columnTotal66 += rs1.getInt(66);columnTotal67 += rs1.getInt(67);columnTotal68 += rs1.getInt(68);
		columnTotal69 += rs1.getInt(69);columnTotal60 += rs1.getInt(70);
		columnTotal71 += rs1.getInt(71);columnTotal72 += rs1.getInt(72);
		columnTotal73 += rs1.getInt(73);columnTotal74 += rs1.getInt(74);columnTotal75 += rs1.getInt(75);
		columnTotal76 += rs1.getInt(76);columnTotal77 += rs1.getInt(77);columnTotal78 += rs1.getInt(78);
		columnTotal79 += rs1.getInt(79);columnTotal70 += rs1.getInt(80);
		columnTotal81 += rs1.getInt(81);columnTotal82 += rs1.getInt(82);
		columnTotal83 += rs1.getInt(83);columnTotal84 += rs1.getInt(84);columnTotal85 += rs1.getInt(85);
		columnTotal86 += rs1.getInt(86);columnTotal87 += rs1.getInt(87);columnTotal88 += rs1.getInt(88);
		columnTotal89 += rs1.getInt(89);columnTotal90 += rs1.getInt(90);	 columnTotal91 += rs1.getInt(91);
		columnTotal92 += rs1.getInt(92);


		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal13%></td>
			<td class=rptValue align="right"><%=columnTotal14%></td>
			<td class=rptValue align="right"><%=columnTotal15%></td>
			<td class=rptValue align="right"><%=columnTotal16%></td>
			<td class=rptValue align="right"><%=columnTotal17%></td>
			<td class=rptValue align="right"><%=columnTotal18%></td>
			<td class=rptValue align="right"><%=columnTotal19%></td>
			<td class=rptValue align="right"><%=columnTotal20%></td>
			<td class=rptValue align="right"><%=columnTotal21%></td>
			<td class=rptValue align="right"><%=columnTotal22%></td>
			<td class=rptValue align="right"><%=columnTotal23%></td>								
			<td class=rptValue align="right"><%=columnTotal24%></td>
			<td class=rptValue align="right"><%=columnTotal25%></td>	
			<td class=rptValue align="right"><%=columnTotal26%></td>		
			<td class=rptValue align="right"><%=columnTotal27%></td>		
			<td class=rptValue align="right"><%=columnTotal28%></td>		
			<td class=rptValue align="right"><%=columnTotal29%></td>		
			<td class=rptValue align="right"><%=columnTotal30%></td>		
			<td class=rptValue align="right"><%=columnTotal31%></td>
			<td class=rptValue align="right"><%=columnTotal32%></td>
			<td class=rptValue align="right"><%=columnTotal33%></td>								
			<td class=rptValue align="right"><%=columnTotal34%></td>
			<td class=rptValue align="right"><%=columnTotal35%></td>	
			<td class=rptValue align="right"><%=columnTotal36%></td>		
			<td class=rptValue align="right"><%=columnTotal37%></td>		
			<td class=rptValue align="right"><%=columnTotal38%></td>		
			<td class=rptValue align="right"><%=columnTotal39%></td>		
			<td class=rptValue align="right"><%=columnTotal40%></td>	
			<td class=rptValue align="right"><%=columnTotal41%></td>
			<td class=rptValue align="right"><%=columnTotal42%></td>
			<td class=rptValue align="right"><%=columnTotal43%></td>								
			<td class=rptValue align="right"><%=columnTotal44%></td>
			<td class=rptValue align="right"><%=columnTotal45%></td>	
			<td class=rptValue align="right"><%=columnTotal46%></td>		
			<td class=rptValue align="right"><%=columnTotal47%></td>		
			<td class=rptValue align="right"><%=columnTotal48%></td>		
			<td class=rptValue align="right"><%=columnTotal49%></td>
			<td class=rptValue align="right"><%=columnTotal50%></td>	
			<td class=rptValue align="right"><%=columnTotal51%></td>
			<td class=rptValue align="right"><%=columnTotal52%></td>
			<td class=rptValue align="right"><%=columnTotal53%></td>								
			<td class=rptValue align="right"><%=columnTotal54%></td>
			<td class=rptValue align="right"><%=columnTotal55%></td>	
			<td class=rptValue align="right"><%=columnTotal56%></td>		
			<td class=rptValue align="right"><%=columnTotal57%></td>		
			<td class=rptValue align="right"><%=columnTotal58%></td>		
			<td class=rptValue align="right"><%=columnTotal59%></td>	
			<td class=rptValue align="right"><%=columnTotal60%></td>	
			<td class=rptValue align="right"><%=columnTotal61%></td>
			<td class=rptValue align="right"><%=columnTotal62%></td>
			<td class=rptValue align="right"><%=columnTotal63%></td>								
			<td class=rptValue align="right"><%=columnTotal64%></td>
			<td class=rptValue align="right"><%=columnTotal65%></td>	
			<td class=rptValue align="right"><%=columnTotal66%></td>		
			<td class=rptValue align="right"><%=columnTotal67%></td>		
			<td class=rptValue align="right"><%=columnTotal68%></td>		
			<td class=rptValue align="right"><%=columnTotal69%></td>
			<td class=rptValue align="right"><%=columnTotal70%></td>	
			<td class=rptValue align="right"><%=columnTotal71%></td>
			<td class=rptValue align="right"><%=columnTotal72%></td>
			<td class=rptValue align="right"><%=columnTotal73%></td>								
			<td class=rptValue align="right"><%=columnTotal74%></td>
			<td class=rptValue align="right"><%=columnTotal75%></td>	
			<td class=rptValue align="right"><%=columnTotal76%></td>		
			<td class=rptValue align="right"><%=columnTotal77%></td>		
			<td class=rptValue align="right"><%=columnTotal78%></td>		
			<td class=rptValue align="right"><%=columnTotal79%></td>
			<td class=rptValue align="right"><%=columnTotal80%></td>	
			<td class=rptValue align="right"><%=columnTotal81%></td>
			<td class=rptValue align="right"><%=columnTotal82%></td>
			<td class=rptValue align="right"><%=columnTotal83%></td>								
			<td class=rptValue align="right"><%=columnTotal84%></td>
			<td class=rptValue align="right"><%=columnTotal85%></td>	
			<td class=rptValue align="right"><%=columnTotal86%></td>		
			<td class=rptValue align="right"><%=columnTotal87%></td>		
			<td class=rptValue align="right"><%=columnTotal88%></td>		
			<td class=rptValue align="right"><%=columnTotal89%></td>	
			<td class=rptValue align="right"><%=columnTotal90%></td>	
			<td class=rptValue align="right"><%=columnTotal91%></td>
			<td class=rptValue align="right"><%=columnTotal92%></td>

		</tr>
		<%
	}
	else if(drill.toString()!=null && drill.toString().equals("next1"))
{
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
					<a href="rws_school_abstract_rpt1_excel.jsp">Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Panchayat</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
			<td class="btext" colspan="36" align="center">Classification</td>
			<td class="btext" colspan="8" align="center">Facilities</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Upper Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Sr.Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Govt.</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Local Body</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			<td class=btext>Govt.Aided</td>	
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Private</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

             <td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

		</tr>
		<tr>
			<td class="btext" colspan="17">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%></td>
		</tr>
	<%
	
	getDnameQuery.delete(0,getDnameQuery.length());
		getDnameQuery.append("select pcode,pname from rws_panchayat_tbl where dcode = '"+rDistrict+"' and mcode = '"+rMandal+"' order by pcode");
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery.toString());
		ResultSet rs2 = ps1.executeQuery(); 
		
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0,columnTotal13=0,columnTotal14=0,columnTotal15=0,columnTotal16=0,columnTotal17=0,columnTotal18=0,columnTotal19=0,columnTotal20=0,
		columnTotal21=0,columnTotal22=0,columnTotal23=0,columnTotal24=0,columnTotal25=0, columnTotal26=0,columnTotal27=0,columnTotal28=0,columnTotal29=0,columnTotal30=0,
		columnTotal31=0,columnTotal32=0,columnTotal33=0,columnTotal34=0,columnTotal35=0, columnTotal36=0,columnTotal37=0,columnTotal38=0,columnTotal39=0,columnTotal40=0,
		columnTotal41=0,columnTotal42=0,columnTotal43=0,columnTotal44=0,columnTotal45=0, columnTotal46=0,columnTotal47=0,columnTotal48=0,columnTotal49=0,columnTotal50=0,
		columnTotal51=0,columnTotal52=0,columnTotal53=0,columnTotal54=0,columnTotal55=0, 
		columnTotal56=0,columnTotal57=0,columnTotal58=0,columnTotal59=0,columnTotal60=0,
		columnTotal61=0,columnTotal62=0,columnTotal63=0,columnTotal64=0,columnTotal65=0, columnTotal66=0,columnTotal67=0,columnTotal68=0,columnTotal69=0,columnTotal70=0,
		columnTotal71=0,columnTotal72=0,columnTotal73=0,columnTotal74=0,columnTotal75=0, 
		columnTotal76=0,columnTotal77=0,columnTotal78=0,columnTotal79=0,columnTotal80=0,
		columnTotal81=0,columnTotal82=0,columnTotal83=0,columnTotal84=0,columnTotal85=0, columnTotal86=0,columnTotal87=0,columnTotal88=0,columnTotal89=0,columnTotal90=0,
        columnTotal91=0,columnTotal92=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
	
		while(rs2.next())
		{
			getHabCountQuery.delete(0,getHabCountQuery.length());
			 getHabCountQuery.append("select hab_code,count(*) from rws_school_master_tbl where substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rs2.getString(1)+"' group by hab_code having count (*) >=1 ");
			getHabRs = getHabSt.executeQuery(getHabCountQuery.toString());
			int habCount = 0 ;
			getHabRs.afterLast();
			getHabRs.previous();
			habCount = getHabRs.getRow();
			////// System.out.println("sizee:"+habCount);
			getDataQuery.delete(0,getDataQuery.length());
			getDataQuery.append("select count(hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as a1,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as a2,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)')then 1 else 0 end) as a3,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as a4,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as a5,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as a6,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as a7,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as a8,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as b1,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as b2,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end)as  b3,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as b4,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as b5,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as b6,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as b7,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as b8,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as c1,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as c2,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c3,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as c4,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as c5,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as c6,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as c7,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c8,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as d1,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as d2,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d3,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as d4,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as d5,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as d6,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as d7,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d8,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as e1,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as e2,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e3,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as e4,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as e5,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as e6,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as e7,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e8,sum(case when SCHOOL_CLASSIFICATION = 'Government' then 1 else 0 end) as f,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as f1,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as f2,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f3,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as f4,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as f5,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as f6,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as f7,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f8,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' then 1 else 0 end) as g,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as g1,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as g2,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g3,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as g4,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as g5,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as g6,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as g7,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g8,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' then 1 else 0 end) as h,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as h1,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as h2,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as h3,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as h4,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as h5,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as h6,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as h7,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as h8,sum(case when SCHOOL_CLASSIFICATION = 'Private' then 1 else 0 end) as i,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as i1,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as i2,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i3,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as i4,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as i5,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as i6,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as i7,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i8,sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as j,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as k,	sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as l,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as m,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as n,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as o,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as p,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as q from rws_school_master_tbl where   substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rs2.getString(1)+"'");
			////// System.out.println("query:"+getDataQuery);
			ps=conn.prepareStatement(getDataQuery.toString());
			ResultSet rs1 = ps.executeQuery();
			
			rs1.next();
		%>
		<tr>
			<td class=rptValue ><%=sno++%></td>
			<td class=rptValue  nowrap><a href="rws_school_abstract_rpt1.jsp?drill=next2&rDistrict=<%=rDistrict%>&rDistrictName=<%=dname%>&rMandal=<%=rMandal%>&rMandalName=<%=mname%>&rPanchayat=<%=rs2.getString(1)%>&rPanchayatName=<%=rs2.getString(2)%>"><%=rs2.getString(2)%></a></td>
			<td class=rptValue align="right"><%=habCount	%></td>
			<td class=rptValue align="right"><%=rs1.getString(2)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(3)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(4)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(5)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(6)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(7)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(8)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(9)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(10)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(11)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(12)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(13)%></td>								
			<td class=rptValue align="right"><%=rs1.getInt(14)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(15)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(16)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(17)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(18)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(19)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(20)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(21)%></td>
			<td class=rptValue align="right"><%=rs1.getString(22)%></td>
			<td class=rptValue align="right"><%=rs1.getString(23)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(24)%></td>
			<td class=rptValue align="right"><%=rs1.getString(25)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(26)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(27)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(28)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(29)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(30)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(31)%></td>
			<td class=rptValue align="right"><%=rs1.getString(32)%></td>
			<td class=rptValue align="right"><%=rs1.getString(33)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(34)%></td>
			<td class=rptValue align="right"><%=rs1.getString(35)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(36)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(37)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(38)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(39)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(40)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(41)%></td>
			<td class=rptValue align="right"><%=rs1.getString(42)%></td>
			<td class=rptValue align="right"><%=rs1.getString(43)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(44)%></td>
			<td class=rptValue align="right"><%=rs1.getString(45)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(46)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(47)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(48)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(49)%></td>
			<td class=rptValue align="right"><%=rs1.getString(50)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(51)%></td>
			<td class=rptValue align="right"><%=rs1.getString(52)%></td>
			<td class=rptValue align="right"><%=rs1.getString(53)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(54)%></td>
			<td class=rptValue align="right"><%=rs1.getString(55)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(56)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(57)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(58)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(59)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(60)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(61)%></td>
			<td class=rptValue align="right"><%=rs1.getString(62)%></td>
			<td class=rptValue align="right"><%=rs1.getString(63)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(64)%></td>
			<td class=rptValue align="right"><%=rs1.getString(65)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(66)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(67)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(68)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(69)%></td>
			<td class=rptValue align="right"><%=rs1.getString(70)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(71)%></td>
			<td class=rptValue align="right"><%=rs1.getString(72)%></td>
			<td class=rptValue align="right"><%=rs1.getString(73)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(74)%></td>
			<td class=rptValue align="right"><%=rs1.getString(75)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(76)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(77)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(78)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(79)%></td>
			<td class=rptValue align="right"><%=rs1.getString(80)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(81)%></td>
			<td class=rptValue align="right"><%=rs1.getString(82)%></td>
			<td class=rptValue align="right"><%=rs1.getString(83)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(84)%></td>
			<td class=rptValue align="right"><%=rs1.getString(85)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(86)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(87)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(88)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(89)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(90)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(91)%></td>
			<td class=rptValue align="right"><%=rs1.getString(92)%></td>
		</tr>		
		<%
		columnTotal1 += habCount;columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		columnTotal13 += rs1.getInt(13);columnTotal14 += rs1.getInt(14);columnTotal15 += rs1.getInt(15);
		columnTotal16 += rs1.getInt(16);columnTotal17 += rs1.getInt(17);columnTotal18 += rs1.getInt(18);
		columnTotal19 += rs1.getInt(19);columnTotal20 += rs1.getInt(20);
		columnTotal21 += rs1.getInt(21);columnTotal22 += rs1.getInt(22);
		columnTotal23 += rs1.getInt(23);columnTotal24 += rs1.getInt(24);columnTotal25 += rs1.getInt(25);
		columnTotal26 += rs1.getInt(26);columnTotal27 += rs1.getInt(27);columnTotal28 += rs1.getInt(28);
		columnTotal29 += rs1.getInt(29);columnTotal20 += rs1.getInt(30);
		columnTotal31 += rs1.getInt(31);columnTotal32 += rs1.getInt(32);
		columnTotal33 += rs1.getInt(33);columnTotal34 += rs1.getInt(34);columnTotal35 += rs1.getInt(35);
		columnTotal36 += rs1.getInt(36);columnTotal37 += rs1.getInt(37);columnTotal38 += rs1.getInt(38);
		columnTotal39 += rs1.getInt(39);columnTotal40 += rs1.getInt(40);
		columnTotal41 += rs1.getInt(41);columnTotal42 += rs1.getInt(42);
		columnTotal43 += rs1.getInt(43);columnTotal44 += rs1.getInt(44);columnTotal45 += rs1.getInt(45);
		columnTotal46 += rs1.getInt(46);columnTotal47 += rs1.getInt(47);columnTotal48 += rs1.getInt(48);
		columnTotal49 += rs1.getInt(49);columnTotal50 += rs1.getInt(50);
		columnTotal51 += rs1.getInt(51);columnTotal52 += rs1.getInt(52);
		columnTotal53 += rs1.getInt(53);columnTotal54 += rs1.getInt(54);columnTotal55 += rs1.getInt(55);
		columnTotal56 += rs1.getInt(56);columnTotal57 += rs1.getInt(57);columnTotal58 += rs1.getInt(58);
		columnTotal59 += rs1.getInt(59);columnTotal60 += rs1.getInt(60);
		columnTotal61 += rs1.getInt(61);columnTotal62 += rs1.getInt(62);
		columnTotal63 += rs1.getInt(63);columnTotal64 += rs1.getInt(64);columnTotal65 += rs1.getInt(65);
		columnTotal66 += rs1.getInt(66);columnTotal67 += rs1.getInt(67);columnTotal68 += rs1.getInt(68);
		columnTotal69 += rs1.getInt(69);columnTotal60 += rs1.getInt(70);
		columnTotal71 += rs1.getInt(71);columnTotal72 += rs1.getInt(72);
		columnTotal73 += rs1.getInt(73);columnTotal74 += rs1.getInt(74);columnTotal75 += rs1.getInt(75);
		columnTotal76 += rs1.getInt(76);columnTotal77 += rs1.getInt(77);columnTotal78 += rs1.getInt(78);
		columnTotal79 += rs1.getInt(79);columnTotal70 += rs1.getInt(80);
		columnTotal81 += rs1.getInt(81);columnTotal82 += rs1.getInt(82);
		columnTotal83 += rs1.getInt(83);columnTotal84 += rs1.getInt(84);columnTotal85 += rs1.getInt(85);
		columnTotal86 += rs1.getInt(86);columnTotal87 += rs1.getInt(87);columnTotal88 += rs1.getInt(88);
		columnTotal89 += rs1.getInt(89);columnTotal90 += rs1.getInt(90);	 columnTotal91 += rs1.getInt(91);
		columnTotal92 += rs1.getInt(92);


		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal13%></td>
			<td class=rptValue align="right"><%=columnTotal14%></td>
			<td class=rptValue align="right"><%=columnTotal15%></td>
			<td class=rptValue align="right"><%=columnTotal16%></td>
			<td class=rptValue align="right"><%=columnTotal17%></td>
			<td class=rptValue align="right"><%=columnTotal18%></td>
			<td class=rptValue align="right"><%=columnTotal19%></td>
			<td class=rptValue align="right"><%=columnTotal20%></td>
			<td class=rptValue align="right"><%=columnTotal21%></td>
			<td class=rptValue align="right"><%=columnTotal22%></td>
			<td class=rptValue align="right"><%=columnTotal23%></td>								
			<td class=rptValue align="right"><%=columnTotal24%></td>
			<td class=rptValue align="right"><%=columnTotal25%></td>	
			<td class=rptValue align="right"><%=columnTotal26%></td>		
			<td class=rptValue align="right"><%=columnTotal27%></td>		
			<td class=rptValue align="right"><%=columnTotal28%></td>		
			<td class=rptValue align="right"><%=columnTotal29%></td>		
			<td class=rptValue align="right"><%=columnTotal30%></td>		
			<td class=rptValue align="right"><%=columnTotal31%></td>
			<td class=rptValue align="right"><%=columnTotal32%></td>
			<td class=rptValue align="right"><%=columnTotal33%></td>								
			<td class=rptValue align="right"><%=columnTotal34%></td>
			<td class=rptValue align="right"><%=columnTotal35%></td>	
			<td class=rptValue align="right"><%=columnTotal36%></td>		
			<td class=rptValue align="right"><%=columnTotal37%></td>		
			<td class=rptValue align="right"><%=columnTotal38%></td>		
			<td class=rptValue align="right"><%=columnTotal39%></td>		
			<td class=rptValue align="right"><%=columnTotal40%></td>	
			<td class=rptValue align="right"><%=columnTotal41%></td>
			<td class=rptValue align="right"><%=columnTotal42%></td>
			<td class=rptValue align="right"><%=columnTotal43%></td>								
			<td class=rptValue align="right"><%=columnTotal44%></td>
			<td class=rptValue align="right"><%=columnTotal45%></td>	
			<td class=rptValue align="right"><%=columnTotal46%></td>		
			<td class=rptValue align="right"><%=columnTotal47%></td>		
			<td class=rptValue align="right"><%=columnTotal48%></td>		
			<td class=rptValue align="right"><%=columnTotal49%></td>
			<td class=rptValue align="right"><%=columnTotal50%></td>	
			<td class=rptValue align="right"><%=columnTotal51%></td>
			<td class=rptValue align="right"><%=columnTotal52%></td>
			<td class=rptValue align="right"><%=columnTotal53%></td>								
			<td class=rptValue align="right"><%=columnTotal54%></td>
			<td class=rptValue align="right"><%=columnTotal55%></td>	
			<td class=rptValue align="right"><%=columnTotal56%></td>		
			<td class=rptValue align="right"><%=columnTotal57%></td>		
			<td class=rptValue align="right"><%=columnTotal58%></td>		
			<td class=rptValue align="right"><%=columnTotal59%></td>	
			<td class=rptValue align="right"><%=columnTotal60%></td>	
			<td class=rptValue align="right"><%=columnTotal61%></td>
			<td class=rptValue align="right"><%=columnTotal62%></td>
			<td class=rptValue align="right"><%=columnTotal63%></td>								
			<td class=rptValue align="right"><%=columnTotal64%></td>
			<td class=rptValue align="right"><%=columnTotal65%></td>	
			<td class=rptValue align="right"><%=columnTotal66%></td>		
			<td class=rptValue align="right"><%=columnTotal67%></td>		
			<td class=rptValue align="right"><%=columnTotal68%></td>		
			<td class=rptValue align="right"><%=columnTotal69%></td>
			<td class=rptValue align="right"><%=columnTotal70%></td>	
			<td class=rptValue align="right"><%=columnTotal71%></td>
			<td class=rptValue align="right"><%=columnTotal72%></td>
			<td class=rptValue align="right"><%=columnTotal73%></td>								
			<td class=rptValue align="right"><%=columnTotal74%></td>
			<td class=rptValue align="right"><%=columnTotal75%></td>	
			<td class=rptValue align="right"><%=columnTotal76%></td>		
			<td class=rptValue align="right"><%=columnTotal77%></td>		
			<td class=rptValue align="right"><%=columnTotal78%></td>		
			<td class=rptValue align="right"><%=columnTotal79%></td>
			<td class=rptValue align="right"><%=columnTotal80%></td>	
			<td class=rptValue align="right"><%=columnTotal81%></td>
			<td class=rptValue align="right"><%=columnTotal82%></td>
			<td class=rptValue align="right"><%=columnTotal83%></td>								
			<td class=rptValue align="right"><%=columnTotal84%></td>
			<td class=rptValue align="right"><%=columnTotal85%></td>	
			<td class=rptValue align="right"><%=columnTotal86%></td>		
			<td class=rptValue align="right"><%=columnTotal87%></td>		
			<td class=rptValue align="right"><%=columnTotal88%></td>		
			<td class=rptValue align="right"><%=columnTotal89%></td>	
			<td class=rptValue align="right"><%=columnTotal90%></td>	
			<td class=rptValue align="right"><%=columnTotal91%></td>
			<td class=rptValue align="right"><%=columnTotal92%></td>

		</tr>
		<%
	}
	else if(drill.toString()!=null && drill.toString().equals("next2"))
{
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
					<a href="rws_school_abstract_rpt1_excel.jsp">Excel</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan=94>District-Schools-Abstract-Report</td>	
		</tr>
		<tr align="center" bgcolor="#ffffff">
			<td class=btext rowspan=3>Sno</td>
			<td class=btext rowspan=3>Village</td>
			<td class=btext colspan=92>Status as on Today</td>			
		</tr>
		<tr>
			<td class=btext rowspan="2">No. of Habs</td>
			<td class=btext rowspan="2">No. of Schools</td>
			<td class=btext rowspan="2">Total Strength</td>			
			<td class="btext" colspan="45" align="center">Category</td>
			<td class="btext" colspan="36" align="center">Classification</td>
			<td class="btext" colspan="8" align="center">Facilities</td>
		</tr>
		<tr align="center">
			<td class=btext>Anganwadi</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Upper Primary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Sr.Secondary</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Govt.</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Local Body</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

			<td class=btext>Govt.Aided</td>	
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>


			<td class=btext>Private</td>
			<td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>

             <td class=btext>DW only</td>
			<td class=btext>Both(Drink and sani)</td>
			<td class=btext>DW(DW only & Both(Drink & sani))  </td>
			<td class=btext>Sanitation (Toilet Only)</td>
			<td class=btext>Sanitation (Urinal Only)</td>
			<td class=btext>Sanitation (Both)</td>
			<td class=btext>Both (Drink. and Sani.)</td>
			<td class=btext>Sanitation((Toilets & urinals & both) & both(drink & sani))</td>
		</tr>
		<tr>
			<td class="btext" colspan="17">District:<%=dname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal:<%=mname%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Panchayat:<%=pname%></td>
		</tr>
	<%
	
	getDnameQuery.delete(0,getDnameQuery.length());
		 getDnameQuery.append("select vcode,vname from rws_village_tbl where dcode = '"+rDistrict+"' and mcode = '"+rMandal+"' and pcode = '"+rPanchayat+"' order by pcode");
		////// System.out.println("query:"+getDnameQuery);
		PreparedStatement ps1=conn.prepareStatement(getDnameQuery.toString());
		ResultSet rs2 = ps1.executeQuery(); 
		
		int sno = 1;
		int rowTotal = 0,columnTotal1=0,columnTotal2=0,columnTotal3=0,columnTotal4=0,columnTotal5=0,columnTotal6=0,columnTotal7=0,columnTotal8=0,columnTotal9=0,columnTotal10=0,columnTotal11=0,columnTotal12=0,columnTotal13=0,columnTotal14=0,columnTotal15=0,columnTotal16=0,columnTotal17=0,columnTotal18=0,columnTotal19=0,columnTotal20=0,
		columnTotal21=0,columnTotal22=0,columnTotal23=0,columnTotal24=0,columnTotal25=0, columnTotal26=0,columnTotal27=0,columnTotal28=0,columnTotal29=0,columnTotal30=0,
		columnTotal31=0,columnTotal32=0,columnTotal33=0,columnTotal34=0,columnTotal35=0, columnTotal36=0,columnTotal37=0,columnTotal38=0,columnTotal39=0,columnTotal40=0,
		columnTotal41=0,columnTotal42=0,columnTotal43=0,columnTotal44=0,columnTotal45=0, columnTotal46=0,columnTotal47=0,columnTotal48=0,columnTotal49=0,columnTotal50=0,
		columnTotal51=0,columnTotal52=0,columnTotal53=0,columnTotal54=0,columnTotal55=0, 
		columnTotal56=0,columnTotal57=0,columnTotal58=0,columnTotal59=0,columnTotal60=0,
		columnTotal61=0,columnTotal62=0,columnTotal63=0,columnTotal64=0,columnTotal65=0, columnTotal66=0,columnTotal67=0,columnTotal68=0,columnTotal69=0,columnTotal70=0,
		columnTotal71=0,columnTotal72=0,columnTotal73=0,columnTotal74=0,columnTotal75=0, 
		columnTotal76=0,columnTotal77=0,columnTotal78=0,columnTotal79=0,columnTotal80=0,
		columnTotal81=0,columnTotal82=0,columnTotal83=0,columnTotal84=0,columnTotal85=0, columnTotal86=0,columnTotal87=0,columnTotal88=0,columnTotal89=0,columnTotal90=0,
        columnTotal91=0,columnTotal92=0;
		Statement getHabSt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ResultSet getHabRs = null;
		
		
		while(rs2.next())
		{
			
			getHabCountQuery.delete(0,getHabCountQuery.length());
			getHabCountQuery.append("select hab_code,count(*) from rws_school_master_tbl where substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rPanchayat+"' and substr(hab_code,8,3)='"+rs2.getString(1)+"' group by hab_code having count (*) >=1 ");
			getHabRs = getHabSt.executeQuery(getHabCountQuery.toString());
			int habCount = 0 ;
			getHabRs.afterLast();
			getHabRs.previous();
			habCount = getHabRs.getRow();
			////// System.out.println("sizee:"+habCount);			
			getDataQuery.delete(0,getDataQuery.length());
			 getDataQuery.append("select count(hab_code) as aa,count(school_code) as b,sum(no_of_students) as j,sum(case when SCHOOL_CATEGORY_CODE = '01' then 1 else 0 end) as a,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as a1,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as a2,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)')then 1 else 0 end) as a3,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as a4,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as a5,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as a6,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as a7,sum(case when  SCHOOL_CATEGORY_CODE = '01'  and  ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as a8,sum(case when SCHOOL_CATEGORY_CODE = '02' then 1 else 0 end) as b,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as b1,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as b2,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end)as  b3,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as b4,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as b5,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as b6,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as b7,sum(case when  SCHOOL_CATEGORY_CODE = '02'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as b8,sum(case when SCHOOL_CATEGORY_CODE = '03' then 1 else 0 end) as c,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as c1,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as c2,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c3,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as c4,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as c5,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as c6,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as c7,sum(case when  SCHOOL_CATEGORY_CODE = '03'  and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as c8,sum(case when SCHOOL_CATEGORY_CODE = '04' then 1 else 0 end) as d,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as d1,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as d2,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d3,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as d4,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as d5,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as d6,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as d7,sum(case when  SCHOOL_CATEGORY_CODE = '04'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as d8,sum(case when SCHOOL_CATEGORY_CODE = '05' then 1 else 0 end) as e,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as e1,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as e2,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e3,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as e4,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as e5,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as e6,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as e7,sum(case when  SCHOOL_CATEGORY_CODE = '05'  and ( FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as e8,sum(case when SCHOOL_CLASSIFICATION = 'Government' then 1 else 0 end) as f,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as f1,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as f2,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f3,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as f4,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as f5,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as f6,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as f7,sum(case when SCHOOL_CLASSIFICATION = 'Government' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as f8,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' then 1 else 0 end) as g,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as g1,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as g2,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g3,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as g4,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as g5,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as g6,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as g7,sum(case when SCHOOL_CLASSIFICATION = 'Local Body' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as g8,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' then 1 else 0 end) as h,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as h1,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as h2,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' ) then 1 else 0 end) as h3,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as h4,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as h5,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as h6,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as h7,sum(case when SCHOOL_CLASSIFICATION = 'Govt.Aided' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as h8,sum(case when SCHOOL_CLASSIFICATION = 'Private' then 1 else 0 end) as i,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as i1,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as i2,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i3,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as i4,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as i5,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as i6,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as i7,sum(case when SCHOOL_CLASSIFICATION = 'Private' and  (FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)') then 1 else 0 end) as i8,sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only' then 1 else 0 end) as j,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as k,	sum(case when FACILITIES_AVAILABLE  = 'Drinking Water Only'  or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as l,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' then 1 else  0 end) as m,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' then 1 else  0 end) as n,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Both)' then 1 else  0 end) as o,sum(case when FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else  0 end) as p,sum(case when FACILITIES_AVAILABLE  = 'Sanitation (Toilet Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Urinal Only)' or FACILITIES_AVAILABLE  = 'Sanitation (Both)' or FACILITIES_AVAILABLE  = 'Both (Drink. and Sani.)' then 1 else 0 end) as q from rws_school_master_tbl where  substr(hab_code,1,2)='"+rDistrict+"' and substr(hab_code,6,2)='"+rMandal+"' and substr(hab_code,13,2)='"+rPanchayat+"' and substr(hab_code,8,3)='"+rs2.getString(1)+"'");
			////// System.out.println("query:"+getDataQuery);
			
			ps=conn.prepareStatement(getDataQuery.toString());
			
			ResultSet rs1 = ps.executeQuery();
			
			rs1.next();
		%>
		<tr>
			<td class=rptValue ><%=sno++%></td>
			<td class=rptValue nowrap><%=rs2.getString(2)%></td>
				<td class=rptValue align="right"><%=habCount	%></td>
			<td class=rptValue align="right"><%=rs1.getString(2)==null? "-" : rs1.getString(2)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(3)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(4)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(5)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(6)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(7)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(8)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(9)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(10)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(11) %></td>
			<td class=rptValue align="right"><%=rs1.getInt(12)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(13)%></td>								
			<td class=rptValue align="right"><%=rs1.getInt(14)%></td>
			<td class=rptValue align="right"><%=rs1.getInt(15)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(16) ==null ? "0" : rs1.getInt(16)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(17) ==null ? "0" : rs1.getInt(17)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(18) ==null ? "0" : rs1.getInt(18)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(19) ==null ? "0" : rs1.getInt(19)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(20) ==null ? "0" : rs1.getInt(20)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(21) ==null ? "0" : rs1.getInt(21)%></td>
			<td class=rptValue align="right"><%=rs1.getString(22) ==null ? "0" : rs1.getInt(22)%></td>
			<td class=rptValue align="right"><%=rs1.getString(23) ==null ? "0" : rs1.getInt(23)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(24) ==null ? "0" : rs1.getInt(24)%></td>
			<td class=rptValue align="right"><%=rs1.getString(25) ==null ? "0" : rs1.getInt(25)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(26) ==null ? "0" : rs1.getInt(26)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(27) ==null ? "0" : rs1.getInt(27)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(28) ==null ? "0" : rs1.getInt(28)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(29) ==null ? "0" : rs1.getInt(29)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(30) ==null ? "0" : rs1.getInt(30)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(31) ==null ? "0" : rs1.getInt(31)%></td>
			<td class=rptValue align="right"><%=rs1.getString(32) ==null ? "0" : rs1.getInt(32)%></td>
			<td class=rptValue align="right"><%=rs1.getString(33) ==null ? "0" : rs1.getInt(33)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(34) ==null ? "0" : rs1.getInt(34)%></td>
			<td class=rptValue align="right"><%=rs1.getString(35)==null ? "0" : rs1.getInt(35)%></td>
			<td class=rptValue align="right"><%=rs1.getString(36)==null ? "0" : rs1.getInt(36)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(37)==null ? "0" : rs1.getInt(37)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(38)==null ? "0" : rs1.getInt(38)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(39)==null ? "0" : rs1.getInt(39)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(40)==null ? "0" : rs1.getInt(40)%></td>
			<td class=rptValue align="right"><%=rs1.getString(41)==null ? "0" : rs1.getInt(41)%></td>
			<td class=rptValue align="right"><%=rs1.getString(42)==null ? "0" : rs1.getInt(42)%></td>
			<td class=rptValue align="right"><%=rs1.getString(43)==null ? "0" : rs1.getInt(43)%></td>							
			<td class=rptValue align="right"><%=rs1.getString(44)==null ? "0" : rs1.getInt(44)%></td>
			<td class=rptValue align="right"><%=rs1.getString(45)==null ? "0" : rs1.getInt(45)%></td>
			<td class=rptValue align="right"><%=rs1.getString(46)==null ? "0" : rs1.getInt(46)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(47)==null ? "0" : rs1.getInt(47)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(48)==null ? "0" : rs1.getInt(48)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(49)==null ? "0" : rs1.getInt(49)%></td>
			<td class=rptValue align="right"><%=rs1.getString(50)==null ? "0" : rs1.getInt(50)%></td>
			<td class=rptValue align="right"><%=rs1.getString(51)==null ? "0" : rs1.getInt(51)%></td>
			<td class=rptValue align="right"><%=rs1.getString(52)==null ? "0" : rs1.getInt(52)%></td>
			<td class=rptValue align="right"><%=rs1.getString(53)==null ? "0" : rs1.getInt(53)%></td>							
			<td class=rptValue align="right"><%=rs1.getString(54)==null ? "0" : rs1.getInt(54)%></td>
			<td class=rptValue align="right"><%=rs1.getString(55)==null ? "0" : rs1.getInt(55)%></td>
			<td class=rptValue align="right"><%=rs1.getString(56)==null ? "0" : rs1.getInt(56)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(57)==null ? "0" : rs1.getInt(57)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(58)==null ? "0" : rs1.getInt(58)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(59)==null ? "0" : rs1.getInt(59)%></td>
			<td class=rptValue align="right"><%=rs1.getString(60)==null ? "0" : rs1.getInt(60)%></td>
			<td class=rptValue align="right"><%=rs1.getString(61)==null ? "0" : rs1.getInt(61)%></td>
			<td class=rptValue align="right"><%=rs1.getString(62)==null ? "0" : rs1.getInt(62)%></td>
			<td class=rptValue align="right"><%=rs1.getString(63)==null ? "0" : rs1.getInt(63)%></td>							
			<td class=rptValue align="right"><%=rs1.getString(64)==null ? "0" : rs1.getInt(64)%></td>
			<td class=rptValue align="right"><%=rs1.getString(65)==null ? "0" : rs1.getInt(65)%></td>
			<td class=rptValue align="right"><%=rs1.getString(66)==null ? "0" : rs1.getInt(66)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(67)==null ? "0" : rs1.getInt(67)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(68)==null ? "0" : rs1.getInt(68)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(69)==null ? "0" : rs1.getInt(69)%></td>
			<td class=rptValue align="right"><%=rs1.getString(70)==null ? "0" : rs1.getInt(70)%></td>
			<td class=rptValue align="right"><%=rs1.getString(71)==null ? "0" : rs1.getInt(71)%></td>
			<td class=rptValue align="right"><%=rs1.getString(72)==null ? "0" : rs1.getInt(72)%></td>
			<td class=rptValue align="right"><%=rs1.getString(73)==null ? "0" : rs1.getInt(73)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(74)==null ? "0" : rs1.getInt(74)%></td>
			<td class=rptValue align="right"><%=rs1.getString(75)==null ? "0" : rs1.getInt(75)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(76)==null ? "0" : rs1.getInt(76)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(77)==null ? "0" : rs1.getInt(77)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(78)==null ? "0" : rs1.getInt(78)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(79)==null ? "0" : rs1.getInt(79)%></td>
			<td class=rptValue align="right"><%=rs1.getString(80)==null ? "0" : rs1.getInt(80)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(81)==null ? "0" : rs1.getInt(81)%></td>
			<td class=rptValue align="right"><%=rs1.getString(82)==null ? "0" : rs1.getInt(82)%></td>
			<td class=rptValue align="right"><%=rs1.getString(83)==null ? "0" : rs1.getInt(83)%></td>								
			<td class=rptValue align="right"><%=rs1.getString(84)==null ? "0" : rs1.getInt(84)%></td>
			<td class=rptValue align="right"><%=rs1.getString(85)==null ? "0" : rs1.getInt(85)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(86)==null ? "0" : rs1.getInt(86)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(87)==null ? "0" : rs1.getInt(87)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(88)==null ? "0" : rs1.getInt(88)%></td>		
			<td class=rptValue align="right"><%=rs1.getString(89)==null ? "0" : rs1.getInt(89)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(90)==null ? "0" : rs1.getInt(90)%></td>	
			<td class=rptValue align="right"><%=rs1.getString(91)==null ? "0" : rs1.getInt(91)%></td>
			<td class=rptValue align="right"><%=rs1.getString(92)==null ? "0" : rs1.getInt(92)%></td>
		</tr>		
		<%
		columnTotal1 += habCount;columnTotal2 += rs1.getInt(2);columnTotal3 += rs1.getInt(3);
		columnTotal4 += rs1.getInt(4);columnTotal5 += rs1.getInt(5);columnTotal6 += rs1.getInt(6);
		columnTotal7 += rs1.getInt(7);columnTotal8 += rs1.getInt(8);columnTotal9 += rs1.getInt(9);
		columnTotal10 += rs1.getInt(10);columnTotal11 += rs1.getInt(11);columnTotal12 += rs1.getInt(12);
		columnTotal13 += rs1.getInt(13);columnTotal14 += rs1.getInt(14);columnTotal15 += rs1.getInt(15);
		columnTotal16 += rs1.getInt(16);columnTotal17 += rs1.getInt(17);columnTotal18 += rs1.getInt(18);
		columnTotal19 += rs1.getInt(19);columnTotal20 += rs1.getInt(20);
		columnTotal21 += rs1.getInt(21);columnTotal22 += rs1.getInt(22);
		columnTotal23 += rs1.getInt(23);columnTotal24 += rs1.getInt(24);columnTotal25 += rs1.getInt(25);
		columnTotal26 += rs1.getInt(26);columnTotal27 += rs1.getInt(27);columnTotal28 += rs1.getInt(28);
		columnTotal29 += rs1.getInt(29);columnTotal20 += rs1.getInt(30);
		columnTotal31 += rs1.getInt(31);columnTotal32 += rs1.getInt(32);
		columnTotal33 += rs1.getInt(33);columnTotal34 += rs1.getInt(34);columnTotal35 += rs1.getInt(35);
		columnTotal36 += rs1.getInt(36);columnTotal37 += rs1.getInt(37);columnTotal38 += rs1.getInt(38);
		columnTotal39 += rs1.getInt(39);columnTotal40 += rs1.getInt(40);
		columnTotal41 += rs1.getInt(41);columnTotal42 += rs1.getInt(42);
		columnTotal43 += rs1.getInt(43);columnTotal44 += rs1.getInt(44);columnTotal45 += rs1.getInt(45);
		columnTotal46 += rs1.getInt(46);columnTotal47 += rs1.getInt(47);columnTotal48 += rs1.getInt(48);
		columnTotal49 += rs1.getInt(49);columnTotal50 += rs1.getInt(50);
		columnTotal51 += rs1.getInt(51);columnTotal52 += rs1.getInt(52);
		columnTotal53 += rs1.getInt(53);columnTotal54 += rs1.getInt(54);columnTotal55 += rs1.getInt(55);
		columnTotal56 += rs1.getInt(56);columnTotal57 += rs1.getInt(57);columnTotal58 += rs1.getInt(58);
		columnTotal59 += rs1.getInt(59);columnTotal60 += rs1.getInt(60);
		columnTotal61 += rs1.getInt(61);columnTotal62 += rs1.getInt(62);
		columnTotal63 += rs1.getInt(63);columnTotal64 += rs1.getInt(64);columnTotal65 += rs1.getInt(65);
		columnTotal66 += rs1.getInt(66);columnTotal67 += rs1.getInt(67);columnTotal68 += rs1.getInt(68);
		columnTotal69 += rs1.getInt(69);columnTotal60 += rs1.getInt(70);
		columnTotal71 += rs1.getInt(71);columnTotal72 += rs1.getInt(72);
		columnTotal73 += rs1.getInt(73);columnTotal74 += rs1.getInt(74);columnTotal75 += rs1.getInt(75);
		columnTotal76 += rs1.getInt(76);columnTotal77 += rs1.getInt(77);columnTotal78 += rs1.getInt(78);
		columnTotal79 += rs1.getInt(79);columnTotal70 += rs1.getInt(80);
		columnTotal81 += rs1.getInt(81);columnTotal82 += rs1.getInt(82);
		columnTotal83 += rs1.getInt(83);columnTotal84 += rs1.getInt(84);columnTotal85 += rs1.getInt(85);
		columnTotal86 += rs1.getInt(86);columnTotal87 += rs1.getInt(87);columnTotal88 += rs1.getInt(88);
		columnTotal89 += rs1.getInt(89);columnTotal90 += rs1.getInt(90);	 columnTotal91 += rs1.getInt(91);
		columnTotal92 += rs1.getInt(92);


		}
		%>
		<tr>
			<td class=btext colspan="2">Total</td>
			<td class=rptValue align="right"><%=columnTotal1%></td>
			<td class=rptValue align="right"><%=columnTotal2%></td>
			<td class=rptValue align="right"><%=columnTotal3%></td>
			<td class=rptValue align="right"><%=columnTotal4%></td>
			<td class=rptValue align="right"><%=columnTotal5%></td>
			<td class=rptValue align="right"><%=columnTotal6%></td>
			<td class=rptValue align="right"><%=columnTotal7%></td>
			<td class=rptValue align="right"><%=columnTotal8%></td>
			<td class=rptValue align="right"><%=columnTotal9%></td>
			<td class=rptValue align="right"><%=columnTotal10%></td>
			<td class=rptValue align="right"><%=columnTotal11%></td>
			<td class=rptValue align="right"><%=columnTotal12%></td>
			<td class=rptValue align="right"><%=columnTotal13%></td>
			<td class=rptValue align="right"><%=columnTotal14%></td>
			<td class=rptValue align="right"><%=columnTotal15%></td>
			<td class=rptValue align="right"><%=columnTotal16%></td>
			<td class=rptValue align="right"><%=columnTotal17%></td>
			<td class=rptValue align="right"><%=columnTotal18%></td>
			<td class=rptValue align="right"><%=columnTotal19%></td>
			<td class=rptValue align="right"><%=columnTotal20%></td>
			<td class=rptValue align="right"><%=columnTotal21%></td>
			<td class=rptValue align="right"><%=columnTotal22%></td>
			<td class=rptValue align="right"><%=columnTotal23%></td>								
			<td class=rptValue align="right"><%=columnTotal24%></td>
			<td class=rptValue align="right"><%=columnTotal25%></td>	
			<td class=rptValue align="right"><%=columnTotal26%></td>		
			<td class=rptValue align="right"><%=columnTotal27%></td>		
			<td class=rptValue align="right"><%=columnTotal28%></td>		
			<td class=rptValue align="right"><%=columnTotal29%></td>		
			<td class=rptValue align="right"><%=columnTotal30%></td>		
			<td class=rptValue align="right"><%=columnTotal31%></td>
			<td class=rptValue align="right"><%=columnTotal32%></td>
			<td class=rptValue align="right"><%=columnTotal33%></td>								
			<td class=rptValue align="right"><%=columnTotal34%></td>
			<td class=rptValue align="right"><%=columnTotal35%></td>	
			<td class=rptValue align="right"><%=columnTotal36%></td>		
			<td class=rptValue align="right"><%=columnTotal37%></td>		
			<td class=rptValue align="right"><%=columnTotal38%></td>		
			<td class=rptValue align="right"><%=columnTotal39%></td>		
			<td class=rptValue align="right"><%=columnTotal40%></td>	
			<td class=rptValue align="right"><%=columnTotal41%></td>
			<td class=rptValue align="right"><%=columnTotal42%></td>
			<td class=rptValue align="right"><%=columnTotal43%></td>								
			<td class=rptValue align="right"><%=columnTotal44%></td>
			<td class=rptValue align="right"><%=columnTotal45%></td>	
			<td class=rptValue align="right"><%=columnTotal46%></td>		
			<td class=rptValue align="right"><%=columnTotal47%></td>		
			<td class=rptValue align="right"><%=columnTotal48%></td>		
			<td class=rptValue align="right"><%=columnTotal49%></td>
			<td class=rptValue align="right"><%=columnTotal50%></td>	
			<td class=rptValue align="right"><%=columnTotal51%></td>
			<td class=rptValue align="right"><%=columnTotal52%></td>
			<td class=rptValue align="right"><%=columnTotal53%></td>								
			<td class=rptValue align="right"><%=columnTotal54%></td>
			<td class=rptValue align="right"><%=columnTotal55%></td>	
			<td class=rptValue align="right"><%=columnTotal56%></td>		
			<td class=rptValue align="right"><%=columnTotal57%></td>		
			<td class=rptValue align="right"><%=columnTotal58%></td>		
			<td class=rptValue align="right"><%=columnTotal59%></td>	
			<td class=rptValue align="right"><%=columnTotal60%></td>	
			<td class=rptValue align="right"><%=columnTotal61%></td>
			<td class=rptValue align="right"><%=columnTotal62%></td>
			<td class=rptValue align="right"><%=columnTotal63%></td>								
			<td class=rptValue align="right"><%=columnTotal64%></td>
			<td class=rptValue align="right"><%=columnTotal65%></td>	
			<td class=rptValue align="right"><%=columnTotal66%></td>		
			<td class=rptValue align="right"><%=columnTotal67%></td>		
			<td class=rptValue align="right"><%=columnTotal68%></td>		
			<td class=rptValue align="right"><%=columnTotal69%></td>
			<td class=rptValue align="right"><%=columnTotal70%></td>	
			<td class=rptValue align="right"><%=columnTotal71%></td>
			<td class=rptValue align="right"><%=columnTotal72%></td>
			<td class=rptValue align="right"><%=columnTotal73%></td>								
			<td class=rptValue align="right"><%=columnTotal74%></td>
			<td class=rptValue align="right"><%=columnTotal75%></td>	
			<td class=rptValue align="right"><%=columnTotal76%></td>		
			<td class=rptValue align="right"><%=columnTotal77%></td>		
			<td class=rptValue align="right"><%=columnTotal78%></td>		
			<td class=rptValue align="right"><%=columnTotal79%></td>
			<td class=rptValue align="right"><%=columnTotal80%></td>	
			<td class=rptValue align="right"><%=columnTotal81%></td>
			<td class=rptValue align="right"><%=columnTotal82%></td>
			<td class=rptValue align="right"><%=columnTotal83%></td>								
			<td class=rptValue align="right"><%=columnTotal84%></td>
			<td class=rptValue align="right"><%=columnTotal85%></td>	
			<td class=rptValue align="right"><%=columnTotal86%></td>		
			<td class=rptValue align="right"><%=columnTotal87%></td>		
			<td class=rptValue align="right"><%=columnTotal88%></td>		
			<td class=rptValue align="right"><%=columnTotal89%></td>	
			<td class=rptValue align="right"><%=columnTotal90%></td>	
			<td class=rptValue align="right"><%=columnTotal91%></td>
			<td class=rptValue align="right"><%=columnTotal92%></td>
		</tr>
		<%
	}
%>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>
