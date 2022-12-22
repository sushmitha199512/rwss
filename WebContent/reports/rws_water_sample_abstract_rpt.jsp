<%@ include file="/commons/rws_header1.jsp"%>

<%@ include file="conn.jsp" %>
<%@page import="java.util.*" %>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
<%@ include file="/commons/rws_header2.jsp" %>

<% } 

String dcode=request.getParameter("district");
String year=request.getParameter("year");
String month=request.getParameter("month");
String dname=request.getParameter("dName");
String mon=request.getParameter("month");
String yr=request.getParameter("year");
if(month!=null && !month.equals("") && month.equals("51") || month.equals("0"))
{
  mon="ALL";
}
if(yr!=null && !yr.equals("") && yr.equals("51") || yr.equals("0"))
{
  yr="ALL";
}
int gsample2=0,gsample1=0;
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null;
ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null;
%>
<html>
<body>
<form>
<p align=center>
<table border = 1 cellspacing = 0 cellpadding = 0 width="80%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			


			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="/pred/home.jsp">Home|</a></td>
				<td class="bwborder"><a
			href="./rws_water_sample_abstract_excel.jsp?district=<%=dcode%>&month=<%=month%>& year=<%=year%> &dname=<%=dname%>" target="_new"></a>
	<td class="bwborder"><a href="javaScript:window.print();">print</a></td></tr>
<%  } else {%>

<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				<td class="bwborder"><a href="#" onclick="window.close()">Close |</a></td>
				<td class="bwborder"><a
			href="./rws_water_sample_abstract_excel.jsp?district=<%=dcode%>&month=<%=month%>& year=<%=year%> &dname=<%=dname%>" target="_new"></a>
	<td class="bwborder"><a href="javaScript:window.print();">print</a></td></tr>
	
<%} %>



<tr align="right">
				<td class="bwborder"></td>
			
			</tr>  
		</table>
	</caption>
	<tr class=btext align="center">
		<font color="navy">District:<%=dname%> &nbsp;Month:<%=mon%> &nbsp; Year :<%=yr%>
	</tr>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14"> Water Quality Abstract  Report</td>
</tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" ><tr align=center>

               <td class=btext>Sl.No</td>
               <td class=btext>Circle</td>
               <td class=btext>Division</td>
                <td class=btext>Total No. of Drinking Water Sources</td> 
			    <td class=btext>Total No. of Sources having FTK Test results</td>
			   <td class=btext>Total No. of Water Samples Forwarded to the Laboratory </td>
			   <td class=btext>Total No. of Water Samples having Chemical Test results</td>
			   <td class=btext>Total No. of Water Samples having Bacteriological Test results</td>
			   <td class=btext>Total No. of Water Samples having Laboratory Test Results</td>
		   
			   </tr>

<%int sno=1;
 try{
//mpws,cpws,pws
String qry1="select count(*),substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or  M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
qry1+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
 System.out.println("qry1:"+qry1);
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(qry1);
Hashtable aht=new Hashtable();
while(rs1.next())
{
  aht.put(rs1.getString(2)+rs1.getString(3),rs1.getString(1));
}
//hp
String qry2="select count(*) ,substr(m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')";

	qry2+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt2=conn.createStatement();
// System.out.println("qry2:"+qry2);
rs2=stmt2.executeQuery(qry2);
Hashtable hpht=new Hashtable();
while(rs2.next())
 {
   hpht.put(rs2.getString(2)+rs2.getString(3),rs2.getString(1));
 }
 //open
 String qry3="select count(*) ,substr(m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code ";

	qry3+="group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt3=conn.createStatement();
// System.out.println("qry3:"+qry3);
rs3=stmt3.executeQuery(qry3);
Hashtable opht=new Hashtable();
while(rs3.next())
 {
   opht.put(rs3.getString(2)+rs3.getString(3),rs3.getString(1));
 }
 // shp
 String qry4="select count(*),substr (m.hab_code,1,2),m.division_office_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry4+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt4=conn.createStatement();
// System.out.println("qry4:"+qry4);
rs4=stmt4.executeQuery(qry4);
Hashtable shpht=new Hashtable();
while(rs4.next())
 {
   shpht.put(rs4.getString(2)+rs4.getString(3),rs4.getString(1));
 }
//ponds
String qry5="select count(*),substr (m.hab_code,1,2),m.division_office_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code";
 	qry5+=" group by substr (m.hab_code,1,2),m.division_office_code order by 2";
stmt5=conn.createStatement();
// System.out.println("qry5:"+qry5);
rs5=stmt5.executeQuery(qry5);
Hashtable pondht=new Hashtable();
while(rs5.next())
 {
   pondht.put(rs5.getString(2)+rs5.getString(3),rs5.getString(1));
 }
//ftk
String qry6="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_ftk_testing_tbl c,rws_complete_hab_view hd  where hd.panch_code=substr(c.source_code,1,16) ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
	{
	  qry6+=" and to_char(test_date,'MON')='"+month+"' ";
	}
 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
	{
     qry6+=" and to_char(test_date,'yyyy')='"+year+"' ";
	}
qry6+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
stmt6=conn.createStatement();
// System.out.println("qry6:"+qry6);
rs6=stmt6.executeQuery(qry6);
Hashtable ftkht=new Hashtable();
while(rs6.next())
{
  ftkht.put(rs6.getString(2)+rs6.getString(3),rs6.getString(1));
}

String qry7="select count(*),substr(hd.panch_code,1,2),c.division_office_code  from rws_water_sample_collect_tbl c,rws_complete_hab_view hd where hd.panch_code=c.hab_code  and c.test_id is not null";

if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
{
  qry7+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
}
 if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
{
   qry7+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
}
qry7+=" group by  substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";


stmt7=conn.createStatement();
 System.out.println("qry7:"+qry7);
rs7=stmt7.executeQuery(qry7);
Hashtable water=new Hashtable();
while(rs7.next())
{
  water.put(rs7.getString(2)+rs7.getString(3),rs7.getString(1));
}
String qry8="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
 {
  qry8+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
 }
if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
{
  qry8+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
}
qry8+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
stmt8=conn.createStatement();
 System.out.println("qry8:"+qry8);
rs8=stmt8.executeQuery(qry8);
Hashtable testsamples=new Hashtable();
while(rs8.next())
{
  testsamples.put(rs8.getString(2)+rs8.getString(3),rs8.getString(1));
}

String qryc1="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=1 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
 {
  qryc1+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
 }
if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
{
  qryc1+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
}
qryc1+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
stmt10=conn.createStatement();
 System.out.println("qryc1:"+qryc1);
rs10=stmt10.executeQuery(qryc1);
Hashtable testsamples1=new Hashtable();
while(rs10.next())
{
  testsamples1.put(rs10.getString(2)+rs10.getString(3),rs10.getString(1));
}


String qryc2="select count(*),substr(hd.panch_code,1,2),c.division_office_code from rws_water_sample_collect_tbl c,rws_complete_hab_view hd ,RWS_WQ_TEST_RESULTS_TBL r where r.test_code=2 and hd.panch_code=c.hab_code and c.test_id is not null and r.test_id=c.test_id ";
if(month!=null && !month.equals("") && !month.equals("0") &&  !month.equals("51"))
 {
  qryc2+=" and to_char(SAMP_COLLECT_DATE,'MON')='"+month+"' ";
 }
if(year!=null && !year.equals("") && !year.equals("0") && !year.equals("51"))
{
  qryc2+=" and to_char(SAMP_COLLECT_DATE,'yyyy')='"+year+"' ";
}
qryc2+=" group by substr(hd.panch_code,1,2),c.division_office_code  order by 2 ";
stmt11=conn.createStatement();
 System.out.println("qryc2:"+qryc2);
rs11=stmt11.executeQuery(qryc2);
Hashtable testsamples2=new Hashtable();
while(rs11.next())
{
  testsamples2.put(rs11.getString(2)+rs11.getString(3),rs11.getString(1));
}


String query= "select a.circle_office_code,a.circle_office_name,b.division_office_code, b.division_office_name from rws_circle_office_tbl a,rws_division_office_tbl b where a.circle_office_code=b.circle_office_code";
	  if(dcode!=null && !dcode.equals("") && !dcode.equals("51"))
	  {
	   query+=" and  a.circle_office_code='"+dcode+"' ";
	  }
	  query+=" order by circle_office_name ";
// System.out.println("query:"+query);
	   int gtotdw=0,gftk=0,gsample=0,gtsample=0;
	  stmt=conn.createStatement();
	  rs=stmt.executeQuery(query);
	  while(rs.next())
		{
		  String ast=""+aht.get(rs.getString(1)+rs.getString(3));
		  if(ast!=null && !ast.equals("") && !ast.equals("null")){} else{ ast="0";}
		  String hp=""+hpht.get(rs.getString(1)+rs.getString(3));
		  if(hp!=null && !hp.equals("") && !hp.equals("null")){} else{ hp="0";}
		  String open=""+opht.get(rs.getString(1)+rs.getString(3));
		  if(open!=null && !open.equals("") && !open.equals("null")){} else{ open="0";}
		  String shp=""+shpht.get(rs.getString(1)+rs.getString(3));
		  if(shp!=null && !shp.equals("") && !shp.equals("null")){} else{ shp="0";}
		  String pond=""+pondht.get(rs.getString(1)+rs.getString(3));
		  if(pond!=null && !pond.equals("") && !pond.equals("null")){} else{ pond="0";}
		  String ftk=""+ftkht.get(rs.getString(1)+rs.getString(3));
		  if(ftk!=null && !ftk.equals("") && !ftk.equals("null")){} else{ ftk="0";}
		  String sample=""+water.get(rs.getString(1)+rs.getString(3));
		  if(sample!=null && !sample.equals("") && !sample.equals("null")){} else{ sample="0";}
		  String tsample=""+testsamples.get(rs.getString(1)+rs.getString(3));
		  
		  if(tsample!=null && !tsample.equals("") && !tsample.equals("null")){} else{ tsample="0";}
		  String tsample1=""+testsamples1.get(rs.getString(1)+rs.getString(3));
		  String tsample2=""+testsamples2.get(rs.getString(1)+rs.getString(3));
		  if(tsample1!=null && !tsample1.equals("") && !tsample1.equals("null")){} else{ tsample1="0";}
		  if(tsample2!=null && !tsample2.equals("") && !tsample2.equals("null")){} else{ tsample2="0";}
		  int totdw=Integer.parseInt(ast)+Integer.parseInt(hp)+Integer.parseInt(open)+Integer.parseInt(shp)+Integer.parseInt(pond);
		  
		  %>
		   <tr>
			<td class=rptvalue><%=sno++%></td>
			<td class=rptvalue><%=rs.getString(2)%></td>
			<td class=rptvalue><%=rs.getString(4)%></td>
			<td class=rptvalue align="right"><%=totdw%></td>
			<td class=rptvalue align="right"><%=ftk%></td>
			<td class=rptvalue align="right"><%=sample%></td>
			<td class=rptvalue align="right"><%= tsample1%></td>
			<td class=rptvalue align="right"><%= tsample2 %></td>
			<td class=rptvalue align="right"><%=tsample%></td>
		   </tr>
	 <% gtotdw+=totdw;
		   gftk+=Integer.parseInt(ftk);
		   gsample+=Integer.parseInt(sample);
		   gtsample+=Integer.parseInt(tsample);
		   gsample1+=Integer.parseInt(tsample1);
		   gsample2+=Integer.parseInt(tsample2);
		}
		 
		  
		  %>
<tr>
	<td class="btext" colspan="3">Total:</td>
    <td class=btext align="right"><%=gtotdw%></td>
	<td class=btext align="right"><%=gftk%></td>
	<td class=btext align="right"><%=gsample%></td>
	<td class=btext align="right"><%= gsample1 %></td>
	<td class=btext align="right"><%= gsample2 %></td>
	<td class=btext align="right"><%=gtsample%></td>


</table>
</form>
<pre align="left"><font color="red">
Note:-Total No. of Drinking Water Sources = Sum ( PWS+MPWS+CPWS+HANDPUMPS+OPENWELLS+PONDS+ SHALLOWHANDPUMPS )
</font></pre>

</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%}catch(Exception e)
{
	// System.out.println(" Exception in jsp:"+e);
}finally{
	if(rs1!=null){rs1.close();}
	if(stmt1!=null){	stmt1.close();}

	if(rs2!=null){rs2.close();}
	if(stmt2!=null){	stmt2.close();}

	if(rs3!=null){rs3.close();}
	if(stmt3!=null){	stmt3.close();}

	if(rs4!=null){rs4.close();}
	if(stmt4!=null){	stmt4.close();}

	if(rs5!=null){rs5.close();}
	if(stmt5!=null){	stmt5.close();}

	if(rs6!=null){rs6.close();}
	if(stmt6!=null){	stmt5.close();}

	if(rs7!=null){rs7.close();}
	if(stmt7!=null){	stmt7.close();}
	
	if(rs8!=null){rs8.close();}
	if(stmt8!=null){	stmt8.close();}
	
	if(rs!=null){rs.close();}
	if(stmt!=null){	stmt.close();}

	if(conn!=null){conn.close();}
}
	   
%>
</html>