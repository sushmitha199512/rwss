<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<body bgcolor="#edf2f8">
<form>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		
<%
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;
String aa=request.getParameter("searchstring");
String rdistrict=request.getParameter("district1");
// System.out.println("rdistrict:"+rdistrict);
int sno=0;
// // System.out.println("Entered String:"+aa);
%>

<table border = 0 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
 <tr>
					<td align="right" colspan=8 class="bwborder">
					<a href="../home.jsp">Home|</a> 
				<a href="javascript:history.back(-1)">Back&nbsp;</a>
				     </td>
				</tr>
				</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
  <tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading"  colspan=8>Habitation Status-Resource Report</td>	
	</tr>
	     <tr>
	     <td class=btext >SNO</td>
	     <td class=btext >Mandal Name</td>
		 <td class=btext >Panchayat Name</td>
		 <td class=btext >Village Name</td>
 		 <td class=btext >Habitation Name</td>
 		 <td class=btext >Coverage Status</td>
 		 <td class=btext >Assets</td> 
 		 <td class=btext >Works</td>
 		 </tr>
<%
 try{
 Statement stmtt1 = conn.createStatement();
String queryy="select distinct pr.panch_code,pr.panch_name,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,d.dcode,d.dname,h.coverage_status from rws_mandal_tbl m, rws_district_tbl d, rws_panchayat_tbl p, rws_village_tbl v , rws_panchayat_raj_tbl pr, rws_habitation_directory_tbl h where d.dcode=m.dcode and m.dcode=p.dcode and "+
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
	 "substr(h.hab_code,13,2)=p.pcode and  "+
	 "pr.panch_name like '"+aa.toUpperCase()+"%' and d.dcode='"+rdistrict+"' and h.coverage_status is not null and h.coverage_status <> 'UI' and h.hab_code=pr.panch_code   order by d.dcode,m.mcode,p.pcode,v.vcode,pr.panch_code";

// System.out.println("qry:"+queryy);
ResultSet rsss=stmtt1.executeQuery(queryy);
if(rsss.isBeforeFirst()){
while(rsss.next())
{

%>
   <tr>
  <td class=rptValue><%=++sno%></td>
  <td class=rptValue><%=rsss.getString(4)%></td>
  <td class=rptValue><%=rsss.getString(6)%></td>
  <td class=rptValue><%=rsss.getString(8)%></td>
  <td class=rptValue><%=rsss.getString(2)%></td>
  <td class=rptValue><%=rsss.getString(11)%></td>
 
<%
  String qry2="select  distinct  count(*) from rws_asset_mast_tbl b,rws_asset_type_tbl a,rws_panchayat_raj_tbl d,rws_asset_scheme_tbl s,rws_habitation_directory_tbl h where d.panch_code=h.hab_code and b.asset_code=s.asset_code  and   d.panch_code=substr(scheme_code,1,16) and substr(d.panch_code,1,2)='"+rsss.getString(9)+"' and substr(d.panch_code,6,2)='"+rsss.getString(3)+"' and substr(d.panch_code,13,2)='"+rsss.getString(5)+"' and substr(d.panch_code,1,16)='"+rsss.getString(1)+"' and  b.type_of_asset_code=a.type_of_asset_code";
 stmt1=conn.createStatement();
 rs1=stmt1.executeQuery(qry2);
 if(rs1.next())
 {%>
   <td class="rptValue"><a href="./rws_assets.jsp?dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>&code=<%="Assets"%>"><%=rs1.getString(1)%></a></td>
   
 <%}
 String qry3="select distinct count(*) from rws_admn_hab_lnk_tbl a,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h  where h.hab_code=pr.panch_code and a.hab_code=pr.panch_code and substr(pr.panch_code,1,2)='"+rsss.getString(9)+"' and  substr(pr.panch_code,6,2)='"+rsss.getString(3)+"' and substr(pr.panch_code,13,2)='"+rsss.getString(5)+"' and substr(pr.panch_code,1,16)='"+rsss.getString(1)+"'";
 stmt2=conn.createStatement();
 rs2=stmt2.executeQuery(qry3);
 if(rs2.next())
 {%>
 <td class="rptValue"><a href="./rws_assets.jsp?code=<%="Works"%>&dcode=<%=rsss.getString(9)%>&mcode=<%=rsss.getString(3)%>&pcode=<%=rsss.getString(5)%>&hcode=<%=rsss.getString(1)%>&hname=<%=rsss.getString(2)%>"><%=rs2.getString(1)%>
 
 <%}
 %>
 </tr>
 <%
}
}
else{
 %>
 <tr>
<td class="rptValue" align=center colspan=8>No Records Match With This Selection Criteira</td></tr>
<%}
 }catch(Exception e)
 {
  // System.out.println("Exception in Search String hab report:"+e);
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

