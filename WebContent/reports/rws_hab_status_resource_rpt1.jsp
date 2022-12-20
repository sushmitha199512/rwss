<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<body bgcolor="#edf2f8">
<form>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		
<%
Statement stmt1=null,stmt2=null,st3=null,st4=null,st5=null,st6=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
nic.watersoft.commons.RwsUser user=null;
String loggedUser = null;
/* if(session.getAttribute("RWS_USER")==null)
{ */
	%>
	<%-- <%@ include file="/commons/rws_header4.jsp"%> --%>
	<%
/* }
else
{ */
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		loggedUser = user.getUserId();
		/* if(loggedUser==null  || loggedUser.equals(""))
		{ */
			%>
			<%-- <%@ include file="/commons/rws_header4.jsp"%> --%>
			<%
		/* }
		else
		{ */
		%>
			<%-- <%@ include file="/commons/rws_header2.jsp"%> --%>
		<%
		//}
//}

String aa=request.getParameter("searchstring");
String rdistrict=request.getParameter("district1");
// // System.out.println("rdistrict:"+rdistrict);
int sno=0;
// // // System.out.println("Entered String:"+aa);
%>

<table border = 0 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
 <tr>
					<td align="right" colspan=8 class="bwborder">
					<% if(loggedUser!=null  && !loggedUser.equals("")) {%>
					<a href="/pred/home.jsp?loginMode=watersoft">Home|
					<%} else {%>
						<a href="/pred/rws_login_frm.jsp">Home|
						<%}%>
					 
				<a href="javascript:history.back(-1)">Back&nbsp;</a>
				     </td>
				</tr>
				</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
  <tr bgcolor="lavander" align="center">
		<td align="center" class="rptHeading"  colspan=24><font color="ffffff">Habitation Status-Resource Report</font></td>	
	</tr>
	     <tr>
	     <td class=btext  rowspan=2>SNO</td>
		 <td class=btext  rowspan=2>Constituency Name</td>
	     <td class=btext  rowspan=2>Mandal Name</td>
		 <td class=btext   rowspan=2>Panchayat Name</td>
		 <td class=btext  rowspan=2>Village Name</td>
		 <td class=btext  rowspan=2>Habitation Name</td>
		 <td class=btext  rowspan=2>Habitation Code</td>
 		 <td class=btext  rowspan=2>Coverage Status</td>
		 <td class=btext   rowspan=2>Lpcd(Safe Supply)</td>
		 <td class=btext  colspan=3 rowspan=1 align="center">Physical&nbsp;Progress</td>
		 <td class=btext  colspan=2 rowspan=1 align="center">Financial&nbsp;Progress(Amt in lakhs)</td>
		 <td class=btext rowspan=2 >Schools</td> 
 		 <td class=btext rowspan=2 >Sources</td>
		 <td class=btext rowspan=2 >Census Plain Pop</td>
		 <td class=btext  rowspan=2>Census SC Popu</td>
		 <td class=btext rowspan=2>Census ST Popu</td>    
		 <td class=btext rowspan=2>No Of Exisiting Sources</td>
		 <td class=btext rowspan=2>No Of  Safe Sources</td>
		 <td class=btext rowspan=2>Total Water Supply (Unsafe)</td>
		 <td class=btext rowspan=2>Total Water Supply (Safe)</td>
		 </tr>
		 <tr>
			<td class="btext" >Asset Lead Habs </td>
			<!--td class="btext" >Asset Other Habs </td-->
			<td class="btext">Works Lead Habs </td>
			<td class="btext">Works Other Habs </td>
		
			<td class="btext" >Asset </td>
			<td class="btext" >Works </td>
		 </tr>
		
<%
 try{
 Statement stmtt1 = conn.createStatement();
String queryy="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,d.dcode,d.dname,h.coverage_status, h.census_plain_popu,h.census_sc_popu,h.census_st_popu,h.exist_water_level,h.existing_sources_no,h.safe_sources_no,(nvl(hs.HPS_OTH_SUPPLY_UNSAFE,'0')+nvl(hs.PWS_UNSAFE_SUPPLY,'0')+nvl(hs.MPWS_UNSAFE_SUPPLY,'0')+nvl(hs.OWS_OTH_SUPPLY,'0')+nvl(hs.PONDS_OTH_SUPPLY,'0')+nvl(hs.SHP_DK_SUPPLY,'0')+nvl(hs.OTHERS_SUPPLY,'0')) as Unsafe,(nvl(hs.HPS_OTH_SUPPLY,'0')+nvl(hs.PWS_SUPPLY,'0')+nvl(hs.MPWS_SUPPLY,'0')+nvl(hs.cpws_supply,'0')+nvl(hs.OTHERS_SUPPLY_SAFE,'0')) as Safe,c.constituency_code,c.constituency_name from rws_mandal_tbl m,rws_constituency_tbl c, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h,rws_hab_supply_status_tbl hs  where d.dcode=m.dcode and m.dcode=p.dcode and "+
	 "m.mcode=p.mcode and  "+
	 "p.pcode=v.pcode and  "+
	 "p.dcode=v.dcode and  "+
	 "v.mcode=m.mcode and  "+
	 "substr(pr.panch_code,1,2)=d.dcode and  "+
	 "substr(pr.panch_code,6,2)=m.mcode and  "+
	 "substr(pr.panch_code,8,3)=v.vcode and  "+
	 "substr(pr.panch_code,13,2)=p.pcode and  "+
	 "substr(h.hab_code,1,2)=d.dcode and  "+
	 "substr(h.hab_code,6,2)=m.mcode and  "+
	 "substr(h.hab_code,8,3)=v.vcode and  "+
	 "substr(h.hab_code,13,2)=p.pcode and h.hab_code=hs.hab_code and hs.hab_code=pr.panch_code and  "+
	 "pr.panch_name like '"+aa.toUpperCase()+"%' and d.dcode='"+rdistrict+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code  and d.dcode=c.dcode and c.mcode=m.mcode  order by d.dcode,c.constituency_code,c.constituency_name,m.mcode,p.pcode,v.vcode,pr.panch_code";

//System.out.println("qry:"+queryy);
ResultSet rsss=stmtt1.executeQuery(queryy);
if(rsss.isBeforeFirst()){
while(rsss.next())
{

%>
   <tr>
  <td class=rptValue><%=++sno%></td>
   <td class=rptValue><%=rsss.getString(21).toUpperCase()%></td>
  <td class=rptValue><%=rsss.getString(4)%></td>
  <td class=rptValue><%=rsss.getString(6)%></td>
  <td class=rptValue><%=rsss.getString(8)%></td>
  <td class=rptValue nowrap><%=rsss.getString(2)%></td>
  <td class=rptValue nowrap><%=rsss.getString(1)%></td>
  <td class=rptValue align="center"><%=rsss.getString(11)%></td>
   <td class=rptValue align="right"><%=rsss.getString(15)%></td>
   
 
<%
  //String qry2="select  distinct  b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code  and   d.panch_code=b.hab_code and substr(d.panch_code,1,2)='"+rsss.getString(9)+"' and substr(d.panch_code,6,2)='"+rsss.getString(3)+"' and substr(d.panch_code,13,2)='"+rsss.getString(5)+"' and substr(d.panch_code,1,16)='"+rsss.getString(1)+"' and  b.type_of_asset_code=a.type_of_asset_code ";
  String qry2="select distinct b.asset_code from rws_asset_mast_tbl b,rws_asset_type_tbl a, rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where b.hab_code=h.hab_code and b.asset_code=s.asset_code and substr (b.hab_code,1,16)='"+rsss.getString(1)+"'  and b.type_of_asset_code=a.type_of_asset_code ";
 stmt=conn.createStatement();
 stmt1=conn.createStatement();
 stmt2=conn.createStatement();
 st3=conn.createStatement();
 st4=conn.createStatement();
 st5=conn.createStatement();
 st6=conn.createStatement();
 //System.out.println(" qry2:"+qry2);
 int astcount=0,codecount=0;;
 rs1=stmt1.executeQuery(qry2);
while(rs1.next())
	{
	  astcount++;
      String qryy=" select count(*) from rws_asset_hab_tbl  where asset_code='"+rs1.getString(1)+"' ";
	 System.out.println(" qryyy:"+qryy);
	   rs5=st5.executeQuery(qryy);
	   if(rs5.next())
		{
		   codecount+=rs5.getInt(1)-1;
		  }
}
    if(astcount>0)
	{%>
	<td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="Assets"%>">
	<%=astcount%></a></td>
	<%}else{%>
	<td class="rptValue" align="right">-</td>
	<%}%>
	<!--td class="rptValue" align="right">
	<%=codecount%></td-->
 <%
 String qry3="select  distinct work_id  from  rws_work_admn_tbl a,rws_habitation_directory_tbl h where a.lead_habitation=h.hab_code and h.hab_code='"+rsss.getString(1)+"' and work_id not in (select asset_code from rws_asset_mast_tbl) ";
System.out.println(" qry3:"+qry3);
 rs2=stmt2.executeQuery(qry3);
 int workid=0,workcount=0;
 while(rs2.next())
 {
	workid++;
	String qry="select count(*) from rws_admn_hab_lnk_tbl where work_id='"+rs2.getString(1)+"' and work_id not in (select asset_code from rws_asset_mast_tbl)  ";
	//System.out.println("qry:"+qry);
	rs6=st6.executeQuery(qry);
	if(rs6.next())
	{
	  workcount+=rs6.getInt(1)-1;
	}
  }
%>
<td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="Works"%>">
	<%=workid%></a></td>
<td class="rptValue" align="right">
	<%=workcount%></td><%
 String costqry="select (select sum(asset_cost) from rws_asset_mast_tbl b,rws_asset_type_tbl a, rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where b.hab_code=h.hab_code and b.asset_code=s.asset_code and substr (b.hab_code,1,16) ='"+rsss.getString(1)+"' and b.type_of_asset_code=a.type_of_asset_code )a,(select sum(sanction_amount) from rws_work_admn_tbl a,rws_habitation_directory_tbl h where a.lead_habitation=h.hab_code and a.lead_habitation='"+rsss.getString(1)+"'  and work_id not in (select asset_code from rws_asset_mast_tbl))b from dual";
  //// System.out.println("costqry:"+costqry);
 rs=stmt.executeQuery(costqry);
while(rs.next()){
 if(rs.getString(1)!=null && !rs.getString(1).equals("0")){
	 %><td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="Assets"%>"><%=rs.getString(1)%></td><%}else {%>
	<td class="rptValue" align="right">-</td>
	<%}if(rs.getString(2)!=null && !rs.getString(2).equals("0")){%>
	 <td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?code=<%="Works"%>&dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>"><%=rs.getString(2)%></a></td>
		<%}else {%>
	<td class="rptValue" align="right">-</td>
		<%}
}
String qschool="select  count(*) from rws_school_master_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code and substr (v.panch_code,1,2)='"+rsss.getString(9)+"' and substr(v.panch_code,6,2)='"+rsss.getString(3)+"'  and substr(v.panch_code,13,2)='"+rsss.getString(5)+"'  and  substr(v.panch_code,1,16)='"+rsss.getString(1)+"'";
// // System.out.println("school qry:"+qschool);
rs4=st4.executeQuery(qschool);
while(rs4.next()) 
{
	if(!rs4.getString(1).equals("0")){
	%>
	<td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?&dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="school"%>"><%=rs4.getString(1)%></a></td>

 <% }
 else
	{%>
<td class="rptValue" align="right"><%="-"%></td>
<%}
  
 }

 String qsource="select  count(*) from rws_source_tbl s, rws_complete_hab_view v where s.hab_code=v.panch_code  and substr (v.panch_code,1,2)='"+rsss.getString(9)+"' and substr(v.panch_code,6,2)='"+rsss.getString(3)+"'  and substr(v.panch_code,13,2)='"+rsss.getString(5)+"'  and  substr(v.panch_code,1,16)='"+rsss.getString(1)+"'";
// // System.out.println("source qry:"+qsource);
rs3=st3.executeQuery(qsource);
while(rs3.next()) 
{
	if(!rs3.getString(1).equals("0")){
	%>
	<td class="rptValue" align="right"><a href="./rws_assets_resource_rpt.jsp?&dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="source"%>"><%=rs3.getString(1)%></a></td>

 <% }
 else
	{%>
<td class="rptValue" align="right"><%="-"%></td>
<%}
  
 }
 %>
	 <td class=rptValue align="right"><%=rsss.getString(12)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(13)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(14)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(16)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(17)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(18)%></td>
	 <td class=rptValue align="right"><%=rsss.getString(19)%></td>
 

 <%}

 }
else{
 %>
 <tr>
<td class="rptValue" align=center colspan=8>No Records Match With This Selection Criteira</td></tr>
<%}
 }catch(Exception e)
 {
	 // // // System.out.println("Exception in Search String hab report:"+e);
 }finally{
 if(conn!=null)
  conn.close();
 }
 %>
 
 </table>
  <%@ include file = "footer.jsp" %>
  
 </table>
 
 </form></body>
 

</html>

