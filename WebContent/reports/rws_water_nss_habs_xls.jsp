<%@ include file="conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html>
<script language="JavaScript">
function wopen(url, name, w, h)
{
  w += 32;
  h += 96;
  var win = window.open(url,name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes'); 
 win.focus();
}
</script>
<%
String fy=request.getParameter("financialYear");
String tdsfy[]=fy.split("/");
String yearStart = tdsfy[0];
String yearEnd = tdsfy[1];
String financialYear = tdsfy[2];
String dcode=request.getParameter("dcode");
String check=request.getParameter("check");
//System.out.println("check:"+check);

String cstatus=request.getParameter("cstatus");
 if(cstatus.equals("NSS") || cstatus.equals("FC") || cstatus.equals("PC1") || cstatus.equals("PC2") || cstatus.equals("PC3") || cstatus.equals("PC4"))
 {
%>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=9>Water Quality <%=cstatus%> Habitation Status</td>	
</tr>
<tr>
<td class=gridhdbg align="center">SNO</td>
<td class=gridhdbg align="center">District</td>
<td class=gridhdbg align="center">Mandal</td>
<td class=gridhdbg align="center">Panchayat</td>
<td class=gridhdbg align="center">Village</td>
<td class=gridhdbg align="center">HabCode</td>
<td class=gridhdbg align="center">Habitation</td>
<td class=gridhdbg align="center">Total Sources</td>
<%-- <td class=gridhdbg align="center"><%=check%> Contaminated Sources</td> --%>
 <td class=gridhdbg align="center">Actual Tested Sources</td>
<%-- <td class=gridhdbg align="center"><%=check%> Contamination</td> --%>
</tr>
<%
try{
	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null;
	ResultSet rs1=null, rs2=null, rs3=null, rs4=null, rs5=null, rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	int sno=0,tot1=0,tot2=0;
	Hashtable ht = new Hashtable();
	Hashtable ht1 = new Hashtable();
	Hashtable ht2= new Hashtable();
	Hashtable ht3 = new Hashtable();
	Hashtable ht4 = new Hashtable();
	Hashtable ht5 = new Hashtable();
	Hashtable ht6= new Hashtable();
	Hashtable ht8= new Hashtable();
	Hashtable ht10=new Hashtable();

	String ary6="select count(distinct  source_code),substr(source_code,1,16)  from rws_wq_test_results_tbl where substr(source_code,1,2)='"+dcode+"' and PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' group by substr(source_code,1,16) ";
	//System.out.println("ary6:"+ary6);
	stmt7=conn.createStatement();
	rs7=stmt7.executeQuery(ary6);
	while(rs7.next())
	{
	  ht6.put(rs7.getString(2),rs7.getString(1));
	}

	 String ary="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,rws_source_tbl subCompTbl,rws_complete_hab_view v WHERE m.hab_code=v.panch_code and M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND (M.TYPE_OF_ASSET_CODE='01' or M.TYPE_OF_ASSET_CODE='02' or M.TYPE_OF_ASSET_CODE='03' or M.TYPE_OF_ASSET_CODE='09') and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  and substr(m.hab_code,1,2)='"+dcode+"' group by  m.hab_code";
	//System.out.println("qq:"+ary);
	stmt1=conn.createStatement();
	rs1=stmt1.executeQuery(ary);
	while(rs1.next())
	{
	  ht.put(rs1.getString(2),rs1.getString(1));
	}
	String ary1="select count(*) ,m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND m.hab_code=r.panch_code and substr(m.hab_code,1,2)='"+dcode+"' group by m.hab_code ";
	//System.out.println("qq111:"+ary1);
	stmt2=conn.createStatement();
	rs2=stmt2.executeQuery(ary1);
	while(rs2.next())
	{
	  ht1.put(rs2.getString(2),rs2.getString(1));
	}
	String ary2="select count(*) ,m.hab_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code and  substr(m.hab_code,1,2)='"+dcode+"' group by m.hab_code ";
	//System.out.println("qq222:"+ary2);
	stmt3=conn.createStatement();
	rs3=stmt3.executeQuery(ary2);
	while(rs3.next())
	{
	  ht2.put(rs3.getString(2),rs3.getString(1));
	}
	String ary3="select count(*),m.hab_code FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S, RWS_SHALLOWHANDPUMPS_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code  and substr (m.hab_code,1,2)='"+dcode+"' group by m.hab_code ";
	//System.out.println("qq3:"+ary3);
	stmt4=conn.createStatement();
	rs4=stmt4.executeQuery(ary3);
	while(rs4.next())
	{
	  ht3.put(rs4.getString(2),rs4.getString(1));
	}
	String ary4="select count(*),m.hab_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code and substr(m.hab_code,1,2)='"+dcode+"' group by  m.hab_code  ";
	//System.out.println("qq444:"+ary4);
	stmt5=conn.createStatement();
	rs5=stmt5.executeQuery(ary4);
	while(rs5.next())
	{
	  ht4.put(rs5.getString(2),rs5.getString(1));
	} 

	String ary5="select count(distinct source_code),substr(source_code,1,16)  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl c where substr(source_code,1,2)='"+dcode+"' and a.test_id=c.test_id and PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' ";

	/* if(check.equals("flouride"))
	{
		//System.out.println("flouride");
	ary5+=" and  c.testing_parameter_code='13' and c.testing_parameter_value>1.5  ";
	}
	else if(check.equals("tds"))
	{
		ary5+="  and c.testing_parameter_code='05' and c.testing_parameter_value> 2000 ";
	}
	else if(check.equals("salinity"))
	{
		ary5+="  and c.testing_parameter_code='12' and  (0.03+((1.806*c.testing_parameter_value)/1000) > 1.836) ";
	}
	else if(check.equals("iron"))
	{
	ary5+="  and c.testing_parameter_code='16' and c.testing_parameter_value> 0.3 ";
	}
	else if(check.equals("nitrate"))
	{
		ary5+="  and c.testing_parameter_code='15' and c.testing_parameter_value> 45 ";
	}
	 */
	ary5+=" group by substr(source_code,1,16)";

	//System.out.println("qry5:"+ary5);
	stmt6=conn.createStatement();
	rs6=stmt6.executeQuery(ary5);
	while(rs6.next())
	{
		//System.out.println(rs6.getString(2)+"@"+rs6.getString(1));
	  ht5.put(rs6.getString(2),rs6.getString(1));
	}

	String ary8="select count(*),m.hab_code  FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl,rws_complete_hab_view r WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='01' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE and r.panch_code=m.hab_code and substr(m.hab_code,1,2)='"+dcode+"' group by  m.hab_code  ";
	//System.out.println("qry8:"+ary8);
	stmt8=conn.createStatement();
	rs8=stmt8.executeQuery(ary8);
	while(rs8.next())
	{
	  ht8.put(rs8.getString(2),rs8.getString(1));
	}	 

	/////////////modified on 12032015/////////

	String qry="select distinct v.* from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl c,RWS_WQ_PARA_TEST_TBL d where c.TESTING_PARAMETER_CODE=d.TESTING_PARAMETER_CODE and w.TEST_CODE=d.TEST_CODE and v.panch_code=substr (source_code,1,16)  and COVERAGE_STATUS='"+cstatus+"' and w.test_id=c.test_id and w.test_code='1' and PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"'";
	 if(dcode!=null && !dcode.equals("") &&  !dcode.equals("00"))
	{
	 qry+= " and substr(v.panch_code,1,2)='"+dcode+"' ";
	}
	 if(check.equals("flouride"))
		{
			//System.out.println("flouride");
		qry+=" and  c.testing_parameter_code=13 and to_number(TRIM(c.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE))  ";
	 	}
		else if(check.equals("tds"))
		{
		qry+="  and c.testing_parameter_code=05 and to_number(TRIM(c.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		}
		else if(check.equals("salinity"))
		{
		qry+="  and c.testing_parameter_code=12 and  (0.03+((1.806*to_number(TRIM(c.TESTING_PARAMETER_VALUE)))/1000) > to_number(TRIM(d.MAX_PERMISSIBLE_VALUE))) ";
		}
		else if(check.equals("iron"))
		{
		qry+="  and c.testing_parameter_code=16 and to_number(TRIM(c.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		}
		else if(check.equals("nitrate"))
		{
		qry+="  and c.testing_parameter_code=15 and to_number(TRIM(c.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		}
	 /* if(check.equals("12"))
	 {
		 qry+=" and testing_parameter_code='"+check+"'  and testing_parameter_value >(0.03+(1.806*testing_parameter_value/1000))";
	 }
	 */
	qry+=" order by dname ";
	stmt=conn.createStatement();
	//System.out.println("qry.........."+qry);
	rs=stmt.executeQuery(qry);
	int totdw=0;
	String style="";
	int styleCount=0;
	while(rs.next())
	{
		//System.out.println("aad"+rs.getString(9));
		String ast=""+ht.get(rs.getString(9)); if(ast!=null && !ast.equals("") && !ast.equals("null")){} else{ ast="0";}		
		String hp=""+ht1.get(rs.getString(9)); if(hp!=null && !hp.equals("") && !hp.equals("null")){} else{ hp="0";}
		String op=""+ht2.get(rs.getString(9));if(op!=null && !op.equals("") && !op.equals("null")){} else{ op="0";}
		String shp=""+ht3.get(rs.getString(9));if(shp!=null && !shp.equals("") && !shp.equals("null")){} else{ shp="0";}
		String pond=""+ht4.get(rs.getString(9));if(pond!=null && !pond.equals("") && !pond.equals("null")){} else{ pond="0";}
		String ohbrs=""+ht8.get(rs.getString(9));if(ohbrs!=null && !ohbrs.equals("") && !ohbrs.equals("null")){} else{ ohbrs="0";}
		String ts=""+ht5.get(rs.getString(9));if(ts!=null && !ts.equals("") && !ts.equals("null")){} else{ ts="0";}
		String ats=""+ht6.get(rs.getString(9));if(ats!=null && !ats.equals("") && !ats.equals("null")){} else{ ats="0";}
		
		/* String ary9="select distinct source_code,substr(source_code,1,16)  from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl c where substr(source_code,1,2)='"+dcode+"' and a.test_id=c.test_id and PREPARED_ON between '"+yearStart+"' and '"+yearEnd+"' and source_code='"+rs.getString(9)+"' ";
		ary9+=" group by source_code";
		System.out.println("ary9:"+ary9);
		stmt9=conn.createStatement();
		rs9=stmt9.executeQuery(ary9);
		while(rs9.next())
		{
			System.out.println(rs9.getString(1)+"@"+rs9.getString(2));
		//  ht5.put(rs9.getString(2),rs9.getString(3));
		} */
		
		/* String contaminatedvalues=""+ht10.get(rs.getString(1));
//		System.out.println("contaminatedvalues"+contaminatedvalues);
		if(contaminatedvalues!=null && !contaminatedvalues.equals("") && !contaminatedvalues.equals("null"))
		{
			
		} 
		else{
			contaminatedvalues="0";
			}
		 */
		totdw=Integer.parseInt(ast)+Integer.parseInt(hp)+Integer.parseInt(op)+Integer.parseInt(shp)+Integer.parseInt(pond)+Integer.parseInt(ohbrs);
		String  val="District: "+rs.getString(2)+"  Mandal: "+rs.getString(4)+":   Panchayat: "+rs.getString(6) +":  Village :"+rs.getString(8)+":  Habitation:" +rs.getString(10) ;
		
		if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		 styleCount++;
		
		
		%><tr>
		<td class=<%=style %> style="text-align: left;" ><%=++sno%></td>
	 	<td class=<%=style %> style="text-align: left;" ><%=rs.getString(2)%></td>
		<td class=<%=style %> style="text-align: left;" ><%=rs.getString(4)%></td>
		<td class=<%=style %> style="text-align: left;" ><%=rs.getString(6)%></td>
		<td class=<%=style %> style="text-align: left;" ><%=rs.getString(8)%></td>
		<td class=<%=style %> style="text-align: left;" ><%=rs.getString(9)%>&nbsp;</td>
		<td class=<%=style %> style="text-align: left;" ><%=rs.getString(10)%></td>
		<td class=<%=style %> style="text-align: right;" ><%=totdw%></td>
		<td class=<%=style %> style="text-align: right;" ><a href="#"onclick="wopen('./rws_water_nss_habs_rpt1.jsp?habcode=<%=rs.getString(9)%>&yearStart=<%=yearStart %>&yearEnd=<%=yearEnd %>&check=<%=check%>&value=<%=val%>','popup', 640, 480)" ><%=ts%></a></td>
		<%-- <td class=<%=style %> style="text-align: right;" ><a href="#"onclick="wopen('./rws_water_nss_habs_rpt1.jsp?type=1&&habcode=<%=rs.getString(9)%>&check=<%=check%>&value=<%=val%>','popup', 640, 480)" ><%=ats%></a></td> --%>
		<%-- <td class=<%=style %> style="text-align: right;" ><a href="#"onclick="wopen('./rws_water_nss_habs_rpt1.jsp?type=2&&habcode=<%=rs.getString(9)%>&check=<%=check%>&value=<%=val%>','popup', 640, 480)" ><%=contaminatedvalues%></a></td> --%>
		</tr>
	<%}
	 if(rs!=null) rs.close();
	 if(stmt!=null) stmt.close();
	//System.out.println(" sno:" +sno);
	if(sno==0)
	{%>
		<tr>
		 <td class=gridhdbg style="text-align: center;" colspan="9">No Records Matching With This Selection Criteria </td>
	<%}
	 
}catch(Exception e) {
    System.out.println("Exception in NSS Habitation:" +e);	
}finally{
 if(conn!=null) conn.close();
}
%>
</table>
</body>

<% }else {
	String qry="";
	 Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
	 ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
	%>
	<body>
	<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
			<caption>
				<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
					

				



				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
			  <%if(check.equals("flouride")) {%>
				<td align="center" class="rptHeading" colspan=9>Flouride Contamination Habitations </td>
				<%}else if(check.equals("tds")) {%>
				<td align="center" class="rptHeading" colspan=9>TDS Contamination Habitations </td>
				<%}%>
			</tr>
	<tr>
	<td class=gridhdbg>SNO</td>
	<td class=gridhdbg>District</td>
	<td class=gridhdbg>Mandal</td>
	<td class=gridhdbg>Panchayat</td>
	<td class=gridhdbg>Village</td>
	<td class=gridhdbg>HabCode</td>
	<td class=gridhdbg>Habitation</td>
	<td class=gridhdbg>Prepared On</td>
	<%if(check.equals("flouride")) {%>
	<td class=gridhdbg>Flouride Value</td>

	<%}else if(check.equals("tds")) {%>
	<td class=gridhdbg>TDS Value</td>
	<%}else if(check.equals("salinity")){%>
	<td class=gridhdbg>Chloride Value</td>

	<%}else if(check.equals("salinitytds")){%>
	<td class=gridhdbg>Chloride Value/TDS Value</td>
	<%} %>

	</tr>
	<% try{
	boolean flag=false;
	int sno=0;
	ArrayList tdsList=new ArrayList();
	Hashtable tb=new Hashtable();
	ArrayList salinityList=new ArrayList();

	if(check.equals("salinitytds")){
	stmt4=conn.createStatement();
	stmt5=conn.createStatement();
	String qr1="select v.PANCH_CODE,b.testing_parameter_value from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b,RWS_WQ_PARA_TEST_TBL d where b.TESTING_PARAMETER_CODE=d.TESTING_PARAMETER_CODE and  w.TEST_CODE=d.TEST_CODE and substr(w.source_code,1,2)='"+dcode+"' and v.panch_code=substr (w.source_code,1,16) and w.test_id=b.test_id  and my_to_number(b.testing_parameter_value) is not null";
		qr1+=" and b.testing_parameter_code='05' and to_number(TRIM(b.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		qr1+=" and (to_date(w.PREPARED_ON))>=(select  MAX(to_date(c.prepared_on)) from  rws_wq_test_results_tbl c where substr(c.source_code,1,2)='"+dcode+"' and c.source_code=w.source_code) ";
		qr1+=" order by w.PREPARED_ON desc ";

	//System.out.println("qr1"+qr1);
	rs4=stmt4.executeQuery(qr1);
	while(rs4.next()){
	tdsList.add(rs4.getString(1));
	tb.put(rs4.getString(1),rs4.getString(2));
	}

	String qr2="select v.dname,v.mname,v.pname,v.vname,v.PANCH_CODE,v.panch_name,w.PREPARED_ON,b.testing_parameter_value from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b,RWS_WQ_PARA_TEST_TBL d where b.TESTING_PARAMETER_CODE=d.TESTING_PARAMETER_CODE and  w.TEST_CODE=d.TEST_CODE and substr(w.source_code,1,2)='"+dcode+"' and v.panch_code=substr (w.source_code,1,16) and w.test_id=b.test_id  and my_to_number(b.testing_parameter_value) is not null";
		qr2+="  and b.testing_parameter_code='12' and (0.03+((1.806*to_number(TRIM(b.TESTING_PARAMETER_VALUE)))/1000) > to_number(TRIM(d.MAX_PERMISSIBLE_VALUE))) ";
	qr2+=" and (to_date(w.PREPARED_ON))>=(select  MAX(to_date(c.prepared_on)) from  rws_wq_test_results_tbl c where substr(c.source_code,1,2)='"+dcode+"' and c.source_code=w.source_code) ";
	qr2+=" order by w.PREPARED_ON desc ";

	//System.out.println("qr2"+qr2);
	rs5=stmt5.executeQuery(qr2);
	Set habs1=new HashSet();
	while(rs5.next()){
	  if(!tdsList.contains(rs5.getString(5))){
	 //System.out.println("Not Found");
	continue;
	}
	if(!habs1.contains(rs5.getString(5))){
           habs1.add(rs5.getString(5));
	}else{
	  continue;
	}
	String day=rs5.getString(7).substring(8,10);
	String mnth=rs5.getString(7).substring(5,7);
	String year=rs5.getString(7).substring(0,4);
	String preparedOn=day+"/"+mnth+"/"+year;
	flag=true;
	%>
	<tr>
		<td class=rptValue align="center"><%=++sno%></td>
		<td class=rptValue align="left"><%=rs5.getString(1)%></td>
		<td class=rptValue align="left"><%=rs5.getString(2)%></td>
		<td class=rptValue align="left"><%=rs5.getString(3)%></td>
		<td class=rptValue align="left"><%=rs5.getString(4)%></td>
		<td class=rptValue align="left"><%=rs5.getString(5)%>&nbsp;</td>
		<td class=rptValue align="left"><%=rs5.getString(6)%></td>
		<td class=rptValue align="left"><%=preparedOn %></td>
		<td class=rptValue align="right"><%=rs5.getString(8)%> / <%=tb.get(rs5.getString(5)) %></td>
	</tr>
	<% 	
	}
	}
	else{
	 qry="select v.dname,v.mname,v.pname,v.vname,v.PANCH_CODE,v.panch_name,w.PREPARED_ON,b.testing_parameter_value,w.source_code,b.testing_parameter_code from rws_wq_test_results_tbl w,rws_complete_hab_view v,rws_wq_test_results_lnk_tbl b,RWS_WQ_PARA_TEST_TBL d where b.TESTING_PARAMETER_CODE=d.TESTING_PARAMETER_CODE and  w.TEST_CODE=d.TEST_CODE and substr(w.source_code,1,2)='"+dcode+"' and v.panch_code=substr (w.source_code,1,16) and w.test_id=b.test_id  and my_to_number(b.testing_parameter_value) is not null";
		if(check.equals("flouride"))
		{			//System.out.println("flouride");
		qry+=" and  b.testing_parameter_code='13' and to_number(TRIM(b.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
	    }
		else if(check.equals("tds"))
		{
		qry+="  and b.testing_parameter_code='05' and to_number(TRIM(b.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		}
		else if(check.equals("salinity"))
		{
		qry+="  and b.testing_parameter_code='12' and  (0.03+((1.806*to_number(TRIM(b.TESTING_PARAMETER_VALUE)))/1000) > to_number(TRIM(d.MAX_PERMISSIBLE_VALUE))) ";
		}
		else if(check.equals("iron"))
		{
		qry+="  and b.testing_parameter_code='16' and to_number(TRIM(b.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE))";
		}
		else if(check.equals("nitrate"))
		{
		qry+="  and b.testing_parameter_code='15' and to_number(TRIM(b.TESTING_PARAMETER_VALUE))>to_number(TRIM(d.MAX_PERMISSIBLE_VALUE)) ";
		}

	qry+=" and (to_date(w.PREPARED_ON))>=(select  MAX(to_date(c.prepared_on)) from  rws_wq_test_results_tbl c where substr(c.source_code,1,2)='"+dcode+"' and c.source_code=w.source_code) ";
	 


	qry+=" order by w.PREPARED_ON desc ";

	//System.out.println("qry112231:"+qry);

	stmt=conn.createStatement();
	//System.out.println("qry11:"+qry);
	Set habs=new HashSet();

	rs=stmt.executeQuery(qry);




	while(rs.next())
	{

	flag=true;
	//2012-05-22
	String day=rs.getString(7).substring(8,10);
	String mnth=rs.getString(7).substring(5,7);
	String year=rs.getString(7).substring(0,4);

	String preparedOn=day+"/"+mnth+"/"+year;

	   
			if(!habs.contains(rs.getString(5))){
	            habs.add(rs.getString(5));
	}else{
	  continue;
	}
	%>
	<tr>
		<td class=rptValue align="center"><%=++sno%></td>
		<td class=rptValue align="left"><%=rs.getString(1)%></td>
		<td class=rptValue align="left"><%=rs.getString(2)%></td>
		<td class=rptValue align="left"><%=rs.getString(3)%></td>
		<td class=rptValue align="left"><%=rs.getString(4)%></td>
		<td class=rptValue align="left"><%=rs.getString(5)%></td>
		<td class=rptValue align="left"><%=rs.getString(6)%></td>
	<td class=rptValue align="left"><%=preparedOn %></td>
		<%if(check.equals("flouride"))
		{%>
		<td class=rptValue align="right"><%=rs.getString(8)%></td>
		<%}else if(check.equals("tds")){%>
		<td class=rptValue align="right"><%=rs.getString(8)%></td>
		<%}else if(check.equals("salinity")){%>
		<td class=rptValue align="right"><%=rs.getString(8)%></td>
	<%} %>
		</tr>
	<%}
	}
	if(!flag){
	%>
	<td class=rptValue align="center" colspan=9>NO RECORDS FOUND</td>
	<% }
	if(rs!=null) rs.close();
	if(stmt!=null) stmt.close();

	}catch(Exception e)
	  {
	e.printStackTrace();
		
	  }
	 %>
	</table>
	</body>
	<%}%>
<%@ include file="/commons/rws_footer.jsp"%>
</html>


<%@ include file="/commons/rws_footer.jsp"%>
</html>

