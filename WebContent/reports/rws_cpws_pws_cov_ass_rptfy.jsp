<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="conn.jsp"%>
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css"
	type="text/css">
	<style>
    #link { 
    color: #CBFCFC;
    font-size: 10px; } 
  </style>
<script>
function viewReport(URL){
	var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if (URL != "") {
		myNewWin = window.open(URL, 'newWinddow', popFeatures);
		myNewWin.focus();
	}
}
function closeJS(){	
}
</script>
<form>
	<%
Calendar cal = Calendar.getInstance();
StringBuffer year = new StringBuffer();
year.append(String.valueOf(cal.get(Calendar.YEAR)));
int prevYear = Integer.parseInt(year.toString()) - 1;
StringBuffer finYear = new StringBuffer();
if (request.getParameter("finyear") != null) {
	finYear.append(request.getParameter("finyear"));
} else {
	finYear.append(session.getAttribute("finYear"));
}
//System.out.println("fin year  "+finYear.toString());
StringBuffer habTableName = new StringBuffer();
java.util.Date d = new java.util.Date();
StringBuffer s = new StringBuffer();
s.append(finYear.substring(0, 4));
if (finYear.toString().substring(0, 4).equals(year.toString())) {
	habTableName.append("rws_habitation_directory_tbl");
} else if (finYear.toString().substring(0, 4)	.equals(String.valueOf(prevYear))) {
	habTableName.append("RWS_HABITATION_DIR_HIS_TBL");
} else {
	habTableName.append("RWS_HABITATION_DIR_HIS" + s + "_TBL");
}
//System.out.println("hab table"+habTableName);
/* session.setAttribute("habTableName", habTableName); */
String ys=finYear.toString().substring(0, 4);
String ye=finYear.toString().substring(5, 9);
//System.out.println(ys+"   "+ye);
Statement stmt1=null,stmt2=null;
Statement st1=null,st2=null,st3=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs6=null,rs7=null,rs8=null;
Statement stmt6=null;
ResultSet pwsrs=null;
ResultSet pwscovrs=null;
ResultSet pwspoprs=null;
Statement pwsst=null;
Statement pwscovst=null;
Statement pwspopst=null;
int gtot=0;
int gatot=0;
int bgtot=0;
int tot=0;
int tot1=0;
int tot2=0;
ResultSet r1=null,r2=null,r3=null,r4=null,r5=null,r6=null,r7=null,r8=null,r9=null,r10=null,r11=null;
Statement t1=null,t2=null,t3=null,t4=null,t5=null,t6=null,t7=null,t8=null,t9=null;
String dcode=request.getParameter("rDistrict");
session.setAttribute("dcode",dcode);
int sno=1;
String qry="";
String queryasset="";
%>
	<table border=0 cellspacing=0 cellpadding=0 width="80%" 	style="border-collapse: collapse" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"	align="right">
				<tr align="right">
					<td><a href="javascript:onclick=history.go(-1)">Back&nbsp;|</a></td>
					<td><a href="/pred/home.jsp?loginMode=watersoft">Home </a></td>
					<%-- <td><a	href="./rws_cpws_pws_excel_rpt.jsp?district=<%=dcode%>"	target="_new">Excel</a></td> --%>
				</tr>
			</table>
		</caption>
		<tr align="center">
			<td align="center" class="gridhdbg" colspan="26">Coverage Of Habitations(Surface Water & Ground Water)-Report for the F.Y.(<%=finYear.toString() %>)</td>
		</tr>
		<tr>
			<td class=gridhdbg rowspan="3">Sl.No</td>
			<td class=gridhdbg rowspan="3">District</td>		
			<td class=gridhdbg colspan="15">Ground Water</td>
			<td class=gridhdbg colspan="15">Surface Water</td>		
		</tr>
		<tr>			
			<td class=gridhdbg colspan="3">CPWS</td>
			<td class=gridhdbg colspan="3">PWS</td>
			<td class=gridhdbg colspan="3">MPWS</td>
			<td class=gridhdbg colspan="3">Direct Pumping</td>
			<td class=gridhdbg colspan="3">HP & SHP</td>	
			<td class=gridhdbg colspan="3">CPWS</td>
			<td class=gridhdbg colspan="3">PWS</td>
			<td class=gridhdbg colspan="3">MPWS</td>
		</tr>
		<tr>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>
			<td class=gridhdbg>no.of Schemes</td>
			<td class=gridhdbg>Habitations Covered</td>
			<td class=gridhdbg>Population</td>			
		</tr>
		<%try{
		String query = "",cpwsquery="",cpwspop="",pwscount="",pwscov="",pwspop="";
		int s1=0,s2=0,s3=0,s4=0,s5=0,s6=0,s7=0,s8=0,s9=0,s10=0,s11=0,s12=0,s13=0,s14=0,s15=0,s1Surface=0,s4Surface=0,s7Surface=0;
		int gtot1=0,gtot2=0,g4=0, g5=0,g6=0, g7=0,g8=0,g9=0,g10=0,g11=0,g12=0,g13=0,g14=0,g15=0,gtotSurface=0,gtot1Surface=0,gtot2Surface=0,g4Surface=0, g5Surface=0,g6Surface=0, g7Surface=0,g8Surface=0,g9Surface=0;
		int gOW=0,gOWH=0,gOWPop=0;
		int gO=0,gOH=0,gOPop=0;	
		
		Set cpwsSet=new HashSet();
		Set pwsSet=new HashSet();
		Set mpwsSet=new HashSet();
		Set dpSet=new HashSet();
		Set hpSet=new HashSet();
		Set openwell=new HashSet();
		Set othersSet=new HashSet();
			 	if (session.getAttribute("cpwsSet") == null) { 
					String popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('03') "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  "
							
							+" union select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('03')  "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  ";
							
				//	System.out.println("hghjdf  "+popCalculateQuery);
					Statement sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {
							if (!cpwsSet.contains(r10.getString(1))) {
								cpwsSet.add(r10.getString(1));
							}									
					}
					sm1.close();
					r10.close();
					popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('01') "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  "
							
							+" union select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('01')  "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  ";
							
					//System.out.println("hghjdf  "+popCalculateQuery);
					sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {
					
							if (cpwsSet.contains(r10.getString(1))) {
								continue;
							}
							if (!pwsSet.contains(r10.getString(1))) {
								pwsSet.add(r10.getString(1));
							}
										
					}
					sm1.close();
					r10.close();
					popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('02') "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  "
							
							+" union select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('02') "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  ";
							
				//	System.out.println("hghjdf  "+popCalculateQuery);
					sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {					
							if (cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1))) {
								continue;
							}
							if (!mpwsSet.contains(r10.getString(1))) {
								mpwsSet.add(r10.getString(1));
							}										
					}
					sm1.close();
					r10.close();
					popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('09') "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  "
							
							+" union select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and type_of_asset_code in ('09')  "
							+" and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  ";
							
					//System.out.println("hghjdf  "+popCalculateQuery);
					 sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {						
							if (cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1))
									|| mpwsSet.contains(r10.getString(1))) {
								continue;
							}
							if (!dpSet.contains(r10.getString(1))) {
								dpSet.add(r10.getString(1));
							}									
					}
					sm1.close();
					r10.close();
						String popCalculateQuery2 = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
								+habTableName+ " c where a.asset_code=b.asset_code and b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and type_of_asset_code in ('04','05')  order by type_of_asset_code";
					//	System.out.println("1122  "+popCalculateQuery2);
						sm1 = conn.createStatement();
						r10 = sm1.executeQuery(popCalculateQuery2);
						while (r10.next()) {
							if (cpwsSet.contains(r10.getString(1)) || pwsSet.contains(r10.getString(1))
									|| mpwsSet.contains(r10.getString(1)) || dpSet.contains(r10.getString(1))) {
								continue;
							}
							if (!hpSet.contains(r10.getString(1))) {
								hpSet.add(r10.getString(1));
							}
						}
						sm1.close();
						r10.close();
						session.setAttribute("cpwsSet", cpwsSet);
						session.setAttribute("pwsSet", pwsSet);
						session.setAttribute("mpwsSet", mpwsSet);
						session.setAttribute("dpSet", dpSet);
						session.setAttribute("hpSet", hpSet);							
			 	}else {
					cpwsSet = (HashSet) session.getAttribute("cpwsSet");
					pwsSet = (HashSet) session.getAttribute("pwsSet");
					mpwsSet = (HashSet) session.getAttribute("mpwsSet");
					dpSet = (HashSet) session.getAttribute("dpSet");
					hpSet = (HashSet) session.getAttribute("hpSet");					
				} 
				cpwsquery = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  group by substr(c.hab_code,1,2)";
				//System.out.println(cpwsquery);				
				st1 = conn.createStatement();
				rs4 = st1.executeQuery(cpwsquery);
				Hashtable cpws = new Hashtable();
				while (rs4.next()) {
					cpws.put(rs4.getString(2), rs4.getInt(1));
				}
				st1.close();
				rs4.close();
				cpwsquery = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1' and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')) group by substr(c.hab_code,1,2)";
			//	System.out.println(cpwsquery);				
				st1 = conn.createStatement();
				rs4 = st1.executeQuery(cpwsquery);
				Hashtable cpwssl = new Hashtable();
				while (rs4.next()) {
					cpwssl.put(rs4.getString(2), rs4.getInt(1));
				}
				st1.close();
				rs4.close();
				pwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
				pwsst = conn.createStatement();
				pwsrs = pwsst.executeQuery(pwscount);
				Hashtable pws = new Hashtable();
				while (pwsrs.next()) {
					pws.put(pwsrs.getString(2), pwsrs.getInt(1));
				}
				pwsst.close();
				pwsrs.close();
				pwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')  and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2'))  group by substr(c.hab_code,1,2)";
				pwsst = conn.createStatement();
				pwsrs = pwsst.executeQuery(pwscount);
				Hashtable pwssl = new Hashtable();
				while (pwsrs.next()) {
					pwssl.put(pwsrs.getString(2), pwsrs.getInt(1));
				}
				pwsst.close();
				pwsrs.close();
				String mpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
				t1 = conn.createStatement();
			//	System.out.println("qry2:"+mpwscount);
				r1 = t1.executeQuery(mpwscount);
				Hashtable mpws = new Hashtable();
				while (r1.next()) {
					mpws.put(r1.getString(2), r1.getInt(1));
				}
				t1.close();
				r1.close();
				mpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and  a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')) group by substr(c.hab_code,1,2)";
				t1 = conn.createStatement();
				//System.out.println("qry2:"+mpwscount);
				r1 = t1.executeQuery(mpwscount);
				Hashtable mpwssl = new Hashtable();
				while (r1.next()) {
					mpwssl.put(r1.getString(2), r1.getInt(1));
				}
				t1.close();
				r1.close();
				String dpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='09'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
				t7 = conn.createStatement();
				// System.out.println("qry2:"+dpwscount);
				r7 = t7.executeQuery(dpwscount);
				Hashtable dmpws = new Hashtable();
				while (r7.next()) {
					dmpws.put(r7.getString(2), r7.getInt(1));
				}
				t7.close();
				r7.close();
				dpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='09'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2')   and a.asset_code not in (select a.asset_code  from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='09'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='1'  and a.asset_code not in (select asset_code from RWS_SOURCE_TBL where SOURCE_TYPE_CODE='2') )  group by substr(c.hab_code,1,2)";
				t7 = conn.createStatement();
				// System.out.println("qry2:"+dpwscount);
				r7 = t7.executeQuery(dpwscount);
				Hashtable dmpwssl = new Hashtable();
				while (r7.next()) {
					dmpwssl.put(r7.getString(2), r7.getInt(1));
				}
				t7.close();
				r7.close();
				
				String hpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c where a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code in ('04','05')  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status <> 'UI'  group by substr(c.hab_code,1,2)";
				t4 = conn.createStatement();
			//	System.out.println("qry2:"+hpwscount);
				r4 = t4.executeQuery(hpwscount);
				Hashtable hmpws = new Hashtable();
				while (r4.next()) {
					hmpws.put(r4.getString(2), r4.getInt(1));
				}	
				t4.close();
				r4.close();
				/*********************Surface Source*****************************/
				Set cpwsSetSurface=new HashSet();
				Set pwsSetSurface=new HashSet();
				Set mpwsSetSurface=new HashSet();	
			 	if (session.getAttribute("cpwsSetSurface") == null) { 
					String popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('03')  union "
							+" select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and  a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('03') ";
				//System.out.println("cpwsSetSurfacehghjdf  "+popCalculateQuery);
					Statement sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {						
							if (!cpwsSetSurface.contains(r10.getString(1))) {
								cpwsSetSurface.add(r10.getString(1));
							}								
					}
					sm1.close();
					r10.close();		
					 popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('01')  union "
							+" select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and  a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('01') ";
				//System.out.println("cpwsSetSurfacehghjdf  "+popCalculateQuery);
					 sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {
						
							if (cpwsSetSurface.contains(r10.getString(1))) {
								continue;
							}
							if (!pwsSetSurface.contains(r10.getString(1))) {
								pwsSetSurface.add(r10.getString(1));
							}
				
					}
					sm1.close();
					r10.close();			
					 popCalculateQuery = "select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('02')  union "
							+" select distinct  b.hab_code,type_of_asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"
							+habTableName+ " c,RWS_SOURCE_TBL s,RWS_ASSET_SOURCE_LNK_TBL sl where sl.ASSET_CODE=a.ASSET_CODE and "
							+" s.source_code=sl.source_code and  a.asset_code=b.asset_code and "
							+" b.hab_code=c.hab_code  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null "
							+" and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and type_of_asset_code in ('02') ";
				//System.out.println("cpwsSetSurfacehghjdf  "+popCalculateQuery);
					sm1 = conn.createStatement();
					r10 = sm1.executeQuery(popCalculateQuery);
					while (r10.next()) {					
							if (cpwsSetSurface.contains(r10.getString(1)) || pwsSetSurface.contains(r10.getString(1))) {
								continue;
							}
							if (!mpwsSetSurface.contains(r10.getString(1))) {
								mpwsSetSurface.add(r10.getString(1));
							}						
					}
					sm1.close();
					r10.close();			
						session.setAttribute("cpwsSetSurface", cpwsSetSurface);
						session.setAttribute("pwsSetSurface", pwsSetSurface);
						session.setAttribute("mpwsSetSurface", mpwsSetSurface);												
				}else {
					cpwsSetSurface = (HashSet) session.getAttribute("cpwsSetSurface");
					pwsSetSurface = (HashSet) session.getAttribute("pwsSetSurface");
					mpwsSetSurface = (HashSet) session.getAttribute("mpwsSetSurface");									
				} 
				cpwsquery = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' group by substr(c.hab_code,1,2)";
			//	System.out.println(cpwsquery);				
				st1 = conn.createStatement();
				rs4 = st1.executeQuery(cpwsquery);
				Hashtable cpwsSurface = new Hashtable();
				while (rs4.next()) {
					cpwsSurface.put(rs4.getString(2), rs4.getInt(1));
				}
				st1.close();
				rs4.close();
				cpwsquery = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2'and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.hab_code=c.hab_code and type_of_asset_code='03'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY') and  c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
			//	System.out.println(cpwsquery);				
				st1 = conn.createStatement();
				rs4 = st1.executeQuery(cpwsquery);
				Hashtable cpwsSurfacesl = new Hashtable();
				while (rs4.next()) {
					cpwsSurfacesl.put(rs4.getString(2), rs4.getInt(1));
				}
				st1.close();
				rs4.close();
				pwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' group by substr(c.hab_code,1,2)";
				pwsst = conn.createStatement();
				pwsrs = pwsst.executeQuery(pwscount);
				Hashtable pwsSurface = new Hashtable();
				while (pwsrs.next()) {
					pwsSurface.put(pwsrs.getString(2), pwsrs.getInt(1));
				}
				pwsst.close();
				pwsrs.close();
				pwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='01'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
				pwsst = conn.createStatement();
				pwsrs = pwsst.executeQuery(pwscount);
				Hashtable pwsSurfacesl = new Hashtable();
				while (pwsrs.next()) {
					pwsSurfacesl.put(pwsrs.getString(2), pwsrs.getInt(1));
				}
				pwsst.close();
				pwsrs.close();
				mpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' group by substr(c.hab_code,1,2)";
				t1 = conn.createStatement();
				//System.out.println("qry2:"+mpwscount);
				r1 = t1.executeQuery(mpwscount);
				Hashtable mpwsSurface = new Hashtable();
				while (r1.next()) {
					mpwsSurface.put(r1.getString(2), r1.getInt(1));
				}
				t1.close();
				r1.close();
				mpwscount = "select nvl(count(distinct a.asset_code),0),substr(c.hab_code,1,2) from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s,rws_asset_source_lnk_tbl sl where a.ASSET_CODE=sl.ASSET_CODE and s.source_code=sl.source_code and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2' and a.asset_code not in (select a.asset_code from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c,RWS_SOURCE_TBL s where a.ASSET_CODE=s.ASSET_CODE and a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code='02'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW') and s.SOURCE_TYPE_CODE='2') group by substr(c.hab_code,1,2)";
					t1 = conn.createStatement();
				//	System.out.println("qry2:"+mpwscount);
					r1 = t1.executeQuery(mpwscount);
					Hashtable mpwsSurfacesl = new Hashtable();
					while (r1.next()) {
						mpwsSurfacesl.put(r1.getString(2), r1.getInt(1));
					}
					t1.close();
					r1.close();					
				/*******************************************************/				
				Statement ssmt = conn.createStatement();
				if (dcode != null && !dcode.equals("") && dcode.equals("00")) {
					qry = "select  dcode,dname from rws_district_tbl where dcode<>'16' order by dcode";
				} else if (dcode != null && !dcode.equals("") && !dcode.equals("00")) {
					qry = "select  dcode,dname from rws_district_tbl where dcode='" + dcode + "' order by dcode";
				}
				stmt1 = conn.createStatement();
				//System.out.println("qry2:"+qry);
				int styleCount = 0;
				String style = "";
				rs1 = stmt1.executeQuery(qry);
				while (rs1.next()) {
				//	System.out.println("in looooooooooooooooooooooooooooooooooooooop");
					//System.out.println("system" );
					int cpwsPop = 0, pwsPop = 0, mpwsPop = 0, dpPop = 0, hpPop = 0, oWPop = 0, oPop = 0;
					int cpwsCount = 0, pwsCount = 0, mpwsCount = 0, dpCount = 0, hpCount = 0, openWellCount = 0,	oCount = 0;
					String popQuery = "select distinct b.hab_code,nvl(CENSUS_PLAIN_POPU,0) ,nvl(CENSUS_SC_POPU,0) , nvl(CENSUS_ST_POPU,0),type_of_asset_code   from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c where a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code in ('01','02','03','04','09','05') and substr(c.hab_code,1,2)='"
							+ rs1.getString(1) + "'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW')  order by type_of_asset_code";
					 //System.out.println("Query:"+popQuery);
					r11 = ssmt.executeQuery(popQuery);
					int notScheme = 0;
					while (r11.next()) {
						if (r11.getString(5).equals("03")) {
							if (cpwsSet.contains(r11.getString(1))) {
								cpwsCount++;
								cpwsPop += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} else if (r11.getString(5).equals("01")) {
							if (cpwsSet.contains(r11.getString(1))) {
								continue;
							}
							if (pwsSet.contains(r11.getString(1))) {
								pwsCount++;
								pwsPop += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} else if (r11.getString(5).equals("02")) {
							if (cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))) {
								continue;
							}
							if (mpwsSet.contains(r11.getString(1))) {
								mpwsCount++;
								mpwsPop += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} else if (r11.getString(5).equals("09")) {
							if (cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))
									|| mpwsSet.contains(r11.getString(1))) {
								continue;
							}
							if (dpSet.contains(r11.getString(1))) {
								dpCount++;
								dpPop += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						}
						else if (r11.getString(5).equals("04") || r11.getString(5).equals("05")) {
							if (cpwsSet.contains(r11.getString(1)) || pwsSet.contains(r11.getString(1))
									|| mpwsSet.contains(r11.getString(1)) || dpSet.contains(r11.getString(1))) {
								continue;
							}
							if (hpSet.contains(r11.getString(1))) {
								hpCount++;
								hpPop += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						}
					}
					r11.close();
					String astCpws ="";
					int x=0,y=0,z=0;
					if(cpws.get(rs1.getString(1))!=null)
						x=(Integer)cpws.get(rs1.getString(1));
					if(cpwssl.get(rs1.getString(1))!=null)
						y=(Integer)cpwssl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astCpws = "" + z;
					x=0;z=0;y=0;
					String astPws ="";
					if(pws.get(rs1.getString(1))!=null)
						x=(Integer)pws.get(rs1.getString(1));
					if(pwssl.get(rs1.getString(1))!=null)
						y=(Integer)pwssl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astPws = "" + z;
					x=0;z=0;y=0;
					String astMpws ="";
					if(mpws.get(rs1.getString(1))!=null)
						x=(Integer)mpws.get(rs1.getString(1));
					if(mpwssl.get(rs1.getString(1))!=null)
						y=(Integer)mpwssl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astMpws = "" + z;
					String astHp="";
					if(hmpws.get(rs1.getString(1))!=null)
					astHp = "" + (Integer)hmpws.get(rs1.getString(1));
					if (astHp != null && !astHp.equals("") && !astHp.equals("null")) {
					} else {
						astHp = "0";
					}
					x=0;z=0;y=0;
					String astDp ="";
					if(dmpws.get(rs1.getString(1))!=null)
						x=(Integer)dmpws.get(rs1.getString(1));
					if(dmpwssl.get(rs1.getString(1))!=null)
						y=(Integer)dmpwssl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astDp = "" + z;
					
					s1 = Integer.parseInt(astCpws);
					gtot += s1;
					gtot1 += cpwsCount;
					gtot2 += cpwsPop;
					s4 = Integer.parseInt(astPws);
					g4 += s4;
					g5 += pwsCount;
					g6 += pwsPop;
					s7 = Integer.parseInt(astMpws);
					g7 += s7;
					g8 += mpwsCount;
					g9 += mpwsPop;
					s10 = Integer.parseInt(astHp);
					g10 += s10;					
					g11 += hpPop;
					g12 += hpCount;					
					s13 = Integer.parseInt(astDp);
					g13 += s13;
					g14 += dpCount;
					g15 += dpPop;
					
					/**********************surface source*******************************/
					int cpwsPopSurface = 0, pwsPopSurface = 0, mpwsPopSurface = 0;
					int cpwsCountSurface = 0, pwsCountSurface = 0, mpwsCountSurface = 0;
					 popQuery = "select distinct b.hab_code,nvl(CENSUS_PLAIN_POPU,0) ,nvl(CENSUS_SC_POPU,0) , nvl(CENSUS_ST_POPU,0),type_of_asset_code   from rws_asset_mast_tbl a,rws_asset_hab_tbl b,"+habTableName+" c where a.asset_code=b.asset_code and b.hab_code=c.hab_code and type_of_asset_code in ('01','02','03') and substr(c.hab_code,1,2)='"
							+ rs1.getString(1) + "'  and a.DATE_CREATION<=to_date('31-03-"+ye+"','DD-MM-YYYY')  and c.coverage_status is not null and c.coverage_status not in ('UI','NW')  order by type_of_asset_code";
					 //System.out.println("Query:"+popQuery);
					r11 = ssmt.executeQuery(popQuery);
					int notSchemeSurface = 0;
					while (r11.next()) {
						if (r11.getString(5).equals("03")) {
							if (cpwsSetSurface.contains(r11.getString(1))) {
								cpwsCountSurface++;
								cpwsPopSurface += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} else if (r11.getString(5).equals("01")) {
							if (cpwsSetSurface.contains(r11.getString(1))) {
								continue;
							}
							if (pwsSetSurface.contains(r11.getString(1))) {
								pwsCountSurface++;
								pwsPopSurface += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} else if (r11.getString(5).equals("02")) {
							if (cpwsSetSurface.contains(r11.getString(1)) || pwsSetSurface.contains(r11.getString(1))) {
								continue;
							}
							if (mpwsSetSurface.contains(r11.getString(1))) {
								mpwsCountSurface++;
								mpwsPopSurface += Integer.parseInt(r11.getString(2)) + Integer.parseInt(r11.getString(3))
										+ Integer.parseInt(r11.getString(4));
							}
						} 
					}
					r11.close();
					x=0;z=0;y=0;
					String astCpwsSurface ="";
					if(cpwsSurface.get(rs1.getString(1))!=null)
						x=(Integer)cpwsSurface.get(rs1.getString(1));
					if(cpwsSurfacesl.get(rs1.getString(1))!=null)
						y=(Integer)cpwsSurfacesl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astCpwsSurface = "" + z;
					x=0;z=0;y=0;
					String astPwsSurface ="";
					if(pwsSurface.get(rs1.getString(1))!=null)
						x=(Integer)pwsSurface.get(rs1.getString(1));
					if(pwsSurfacesl.get(rs1.getString(1))!=null)
						y=(Integer)pwsSurfacesl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astPwsSurface = "" + z;					
					x=0;z=0;y=0;
					String astMpwsSurface ="";
					if(mpwsSurface.get(rs1.getString(1))!=null)
						x=(Integer)mpwsSurface.get(rs1.getString(1));
					if(mpwsSurfacesl.get(rs1.getString(1))!=null)
						y=(Integer)mpwsSurfacesl.get(rs1.getString(1));
					z=x+y;
					if(z!=0)
						astMpwsSurface = "" + z;		
					s1Surface = Integer.parseInt(astCpwsSurface);
					gtotSurface += s1Surface;
					gtot1Surface += cpwsCountSurface;
					gtot2Surface += cpwsPopSurface;
					s4Surface = Integer.parseInt(astPwsSurface);
					g4Surface += s4Surface;
					g5Surface += pwsCountSurface;
					g6Surface += pwsPopSurface;
					s7Surface = Integer.parseInt(astMpwsSurface);
					g7Surface += s7Surface;
					g8Surface += mpwsCountSurface;
					g9Surface += mpwsPopSurface;
					if (styleCount % 2 == 0) {
						style = "gridbg1";
					} else {
						style = "gridbg2";
					}
					styleCount++;
		%>
		<tr>
			<td class=<%=style %> style="text-align: right;"><%=sno++%></td>
			<td class=<%=style %> style="text-align: left;"><%=rs1.getString(2)%></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpws&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astCpws%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpws&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=cpwsCount %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=cpwsPop %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pws&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astPws%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pws&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=pwsCount %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=pwsPop %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpws&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astMpws%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpws&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=mpwsCount %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=mpwsPop %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=dp&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astDp%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=dp&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=dpCount %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=dpPop %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=hp&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astHp%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=hp&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=hpCount %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=hpPop %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpwsSurface&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astCpwsSurface%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpwsSurface&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=cpwsCountSurface %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=cpwsPopSurface %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pwsSurface&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astPwsSurface%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pwsSurface&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=pwsCountSurface %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=pwsPopSurface %></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpwsSurface&type=asset&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=astMpwsSurface%></a></td>
			<td class=<%=style %> style="text-align: right;"><a href="#"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpwsSurface&type=hab&dcode=<%=rs1.getString(1) %>&finYear=<%=finYear%>')"><%=mpwsCountSurface %></a></td>
			<td class=<%=style %> style="text-align: right;"><%=mpwsPopSurface %></td>		
		</tr>
		<%
}
	r1.close();							
%>
		<tr>
			<td class="gridhdbg " style="text-align: right;" colspan="2">Total</td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpws&type=asset&finYear=<%=finYear%>')"><%=gtot%></a></font></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpws&type=hab&finYear=<%=finYear%>')"><%=gtot1%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=gtot2%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pws&type=asset&finYear=<%=finYear%>')"><%=g4%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pws&type=hab&finYear=<%=finYear%>')"><%=g5%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g6%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpws&type=asset&finYear=<%=finYear%>')"><%=g7%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpws&type=hab&finYear=<%=finYear%>')"><%=g8%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g9%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=dp&type=asset&finYear=<%=finYear%>')"><%=g13%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=dp&type=hab&finYear=<%=finYear%>')"><%=g14%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g15%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=hp&type=asset&finYear=<%=finYear%>')"><%=g10%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=hp&type=hab&finYear=<%=finYear%>')"><%=g12%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g11%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpwsSurface&type=asset&finYear=<%=finYear%>')"><%=gtotSurface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=cpwsSurface&type=hab&finYear=<%=finYear%>')"><%=gtot1Surface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=gtot2Surface%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pwsSurface&type=asset&finYear=<%=finYear%>')"><%=g4Surface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=pwsSurface&type=hab&finYear=<%=finYear%>')"><%=g5Surface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g6Surface%></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpwsSurface&type=asset&finYear=<%=finYear%>')"><%=g7Surface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><a href="#" id="link"
				onclick="viewReport('rws_cpws_pws_cov_ass_rpt_drillfy.jsp?name=mpwsSurface&type=hab&finYear=<%=finYear%>')"><%=g8Surface%></a></td>
			<td class="gridhdbg " style="text-align: right;"><%=g9Surface%></td>
		</tr>
	</table>
	<%	
}
catch(Exception e)
{
e.printStackTrace();
}
finally
{
try
{
if(rs4 != null)
{
rs4.close();
}
if(st1 != null)
{
st1.close();
}
if(rs6 != null)
{
rs6.close();
}
if(st2 != null)
{
st2.close();
}
if(rs7 != null)
{
rs7.close();
}
if(st3 != null)
{
st3.close();
}
if(pwsrs != null)
{
pwsrs.close();
}
if(pwsst !=null)
{
pwsst.close();
}
if(pwspoprs != null)
{
pwspoprs.close();
}
if(pwspopst !=null)
{
pwspopst.close();
}
if(pwscovrs != null)
{
pwscovrs.close();
}
if(pwscovst !=null)
{
pwscovst.close();
}
if(r1 !=null)
{
r1.close();
}
if(t1 != null)
{
t1.close();
}
if(r2 !=null)
{
r2.close();
}
if(t2 != null)
{
t2.close();
}
if(r3 !=null)
{
r3.close();
}
if(t3 != null)
{
t3.close();
}
if(r4 !=null)
{
r4.close();
}
if(t4 != null)
{
t4.close();
}
if(r5 !=null)
{
r5.close();
}
if(t5 != null)
{
t5.close();
}
if(r6 !=null)
{
r6.close();
}
if(t6 != null)
{
t6.close();
}
if(r7 !=null)
{
r7.close();
}
if(t7 != null)
{
t7.close();
}
if(r8 !=null)
{
r8.close();
}
if(t8 != null)
{
t8.close();
}
if(r9 !=null)
{
r9.close();
}
if(t9 != null)
{
t9.close();
}
if(rs1 != null)
{
rs1.close();
}
if(stmt1 != null)
{
stmt1.close();
}
if( conn != null )
{
conn.close();
}
}
catch(Exception p)
{
p.printStackTrace();
}
}
%>

</form>	
</body>
</html>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
<%@ include file="/commons/rws_footer.jsp" %>



