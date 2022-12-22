<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<script>
function fnReport()
{
	alert("Please Update the Printable Settings");
	window.print();
}
</script>
<body  bgcolor="#edf2f8">
<table border = 0 width="200px">	
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
			<tr>
				<td align="right" class="bwborder">
				<a href="javascript:fnReport()"><font face=verdana size=3 color=red>Print this Page</font></a>
				</td>
			</tr>
		</table>
	</caption>
</table>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	DecimalFormat ndf = new DecimalFormat("####.00");
	double col4=0.0,col5=0.0,col7=0.0,col8=0.0,col10=0.0,col11=0.0,col13=0,col14=0;
	Statement st1 = conn.createStatement();
	Statement st2 = conn.createStatement();
	Statement st3 = conn.createStatement();
	Statement st4 = conn.createStatement();
	Statement st5 = conn.createStatement();
	Statement st6 = conn.createStatement();
	ResultSet rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null;
try
{
	String q1 = "select nvl(sum(b.LOC_AMOUNT),0),substr(office_to_code,2,3) from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id and b.work_id is null and fin_year='2010-2011' group by substr(office_to_code,2,3)";
	rs1 = st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(2),rs1.getString(1)); 
	}
	String q2 = "select nvl(sum(b.LOC_AMOUNT),0),substr(office_code,2,3) from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c,rws_bro_master_tbl d where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id and b.bro_id=d.bro_id and a.bro_id=d.bro_id and fin_year='2010-2011' group by substr(office_code,2,3)";
	rs2 = st1.executeQuery(q2);
	Hashtable ht2 = new Hashtable();
	while(rs2.next())
	{
		ht2.put(rs2.getString(2),rs2.getString(1)); 
	}
	String q3 = "select nvl(sum(voucher_amt),0),substr(b.office_code,2,3)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(b.office_code,2,3) in(select substr(office_to_code,2,3) from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is null) group by substr(b.office_code,2,3)";
	q3 = "select nvl(sum(voucher_amt),0),substr(b.office_code,2,3)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id AND A.WORK_ID NOT in(select WORK_ID from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is NOT null) and BILL_SL_NO <> '0'  group by substr(b.office_code,2,3)";
	rs3 = st3.executeQuery(q3);
	Hashtable ht3 = new Hashtable();
	while(rs3.next())
	{
		ht3.put(rs3.getString(2),rs3.getString(1)); 
	}
	String q4 = "select nvl(sum(voucher_amt),0),substr(b.office_code,2,3)  from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and a.work_id in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) group by substr(b.office_code,2,3)";
	rs4 = st4.executeQuery(q4);
	Hashtable ht4 = new Hashtable();
	while(rs4.next())
	{
		ht4.put(rs4.getString(2),rs4.getString(1)); 
	}
	String q5 = "select nvl(sum(BILL_AMT_CONTRACTOR),0),substr(b.office_code,2,3)  from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id not in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) and bill_sl_no<>'0'  group by substr(b.office_code,2,3)";
	rs5 = st5.executeQuery(q5);
	Hashtable ht5 = new Hashtable();
	while(rs5.next())
	{
		ht5.put(rs5.getString(2),rs5.getString(1)); 
	}
	String q6 = "select nvl(sum(BILL_AMT_CONTRACTOR),0),substr(b.office_code,2,3)  from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) and bill_sl_no<>'0'  group by substr(b.office_code,2,3)";
	rs6 = st6.executeQuery(q6);
	Hashtable ht6 = new Hashtable();
	while(rs6.next())
	{
		ht6.put(rs6.getString(2),rs6.getString(1)); 
	}
	String qry = "select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code";
	if(userid.equals("admin") || userid.equals("100000") || userid.equals("psrwss")){}
	else
	{	qry +=" and dcode='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
			qry +=" and division_office_code='"+userid.substring(3,4)+"'";
	}
	qry += " order by 1,2";
	  stmt = conn.createStatement();
	  rs = stmt.executeQuery(qry);
	  int count = 1;
	  %>
	<table id="tbl" border = 1 align=center bordercolor=navy style="border-collapse:collapse">
		<thead class="fixedHeader">
		<tr align="center">
			<th class="rptValue"><b>Sl. No</th>
			<th class="rptValue"><b>District</th>
			<th class="rptValue"><b>Division</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Releases During the Year  <BR> </font><font face=verdana size=2 color=black>SVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Releases During the Year  <BR> </font><font face=verdana size=2 color=black>MVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Releases During the Year  <BR> </font><font face=verdana size=2 color=black> Total</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Expenditure Incurred as on Date <BR> </font><font face=verdana size=2 color=black>SVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Expenditure Incurred as on Date<BR></font><font face=verdana size=2 color=black>MVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Expenditure Incurred as on Date<BR></font><font face=verdana size=2 color=black> Total</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Balance Amount as on Date<BR></font><font face=verdana size=2 color=black>SVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Balance Amount as on Date<BR></font><font face=verdana size=2 color=black>MVS</th>
			<th ><font face=verdana size=2 color=black><b>Balance Amount as on Date<BR></font><font face=verdana size=2 color=black> Total</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Due from Bill<BR></font><font face=verdana size=2 color=black>SVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Due from Bill<BR></font><font face=verdana size=2 color=black>MVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Due from Bill<BR></font><font face=verdana size=2 color=black> Total</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Required as on Date<BR></font><font face=verdana size=2 color=black>SVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Required as on Date<BR></font><font face=verdana size=2 color=black>MVS</th>
			<th class="rptValue"><font face=verdana size=2 color=black><b>Amount Required as on Date<BR></font><font face=verdana size=2 color=black> Total(In Rupees)</th>
	</tr>
	<tr align="center">
    <td class="rptValue">1</td>
    <td class="rptValue">2</td>
    <td class="rptValue">3</td>
    <td class="rptValue">4</font></td>
    <td class="rptValue">5</font></td>
    <td class="rptValue">6(4+5)</font></td>
    <td class="rptValue">7</font></td>
    <td class="rptValue">8</font></td>
    <td class="rptValue">9(7+8)</font></td>
    <td class="rptValue">10(4-7)</font></td>
    <td class="rptValue">11(5-8)</font></td>
    <td class="rptValue">12(6-9)</font></td>
    <td class="rptValue">13</font></td>
    <td class="rptValue">14</font></td>
    <td class="rptValue">15(13+14)</font></td>
    <td class="rptValue">16(13-10)</font></td>
    <td class="rptValue">17(14-11)</font></td>
    <td class="rptValue">18(15-12)Rs.</font></td>
  </tr>
</thead>
<tbody>
	<%
		  int countt = 0;
		 while(rs.next()){
		Enumeration e = ht4.keys();
		String divrelease = ""+ht1.get(rs.getString(1)+rs.getString(2));
		if(divrelease!=null && !divrelease.equals("null")){}else{divrelease="0";}
		String workrelease = ""+ht2.get(rs.getString(1)+rs.getString(2));
		if(workrelease!=null && !workrelease.equals("null")){}else{workrelease="0";}
		String divexp = ""+ht3.get(rs.getString(1)+rs.getString(2));
		if(divexp!=null && !divexp.equals("null")){}else{divexp="0";}
		String workexp = ""+ht4.get(rs.getString(1)+rs.getString(2));
		if(workexp!=null && !workexp.equals("null")){}else{workexp="0";}
		String divbill = ""+ht5.get(rs.getString(1)+rs.getString(2));
		if(divbill!=null && !divbill.equals("null")){}else{divbill="0";}
		String workbill = ""+ht6.get(rs.getString(1)+rs.getString(2));
		if(workbill!=null && !workbill.equals("null")){}else{workbill="0";}
		col4 += Double.parseDouble(divrelease);
		col5 += Double.parseDouble(workrelease);
		col7 += Double.parseDouble(divexp);
		col8 += Double.parseDouble(workexp);
		col10 += (col4*100000)-col7;
		col11 += (col5*100000)-col8;
		col13 += Double.parseDouble(divbill);
		col14 += Double.parseDouble(workbill);%>
			<td class="rptValue" align="center" ><%=count++%></td>
			<td class="rptValue"nowrap align="left" ><%=rs.getString(3)%></td>
			<td class="rptValue" nowrap align="left" ><%=rs.getString(4)%></td>
		<%if(divrelease!=null && !divrelease.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divrelease)*100000)%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divrelease)*100000)%></td>
		<%}%>
		 <%if(workrelease!=null && !workrelease.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workrelease)*100000)%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workrelease)*100000)%></td>
		<%}%>
		 <%if(Double.parseDouble(divrelease)+Double.parseDouble(workrelease)>0) {%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divrelease)*100000)+(Double.parseDouble(workrelease)*100000))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divrelease)*100000)+(Double.parseDouble(workrelease)*100000))%></td>
		<%}%>
		<%if(divexp!=null && !divexp.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divexp))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divexp))%></td>
		<%}%>
		 <%if(workexp!=null && !workexp.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workexp))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workexp))%></td>
		<%}%>
		 <%if(Double.parseDouble(divexp)+Double.parseDouble(workexp)>0) {%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divexp))+(Double.parseDouble(workexp)))%></td>
		<%}else{%>
		<td nowrap  class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divexp))+(Double.parseDouble(workexp)))%></td>
		<%}%>

		<td nowrap  class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divrelease)*100000)-(Double.parseDouble(divexp)))%></td>
		<td nowrap  class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(workrelease)*100000)-(Double.parseDouble(workexp)))%></td>
		<td nowrap  class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(((Double.parseDouble(divrelease)*100000)-(Double.parseDouble(divexp)))+((Double.parseDouble(workrelease)*100000)-(Double.parseDouble(workexp))))%></td>

		<%if(divbill!=null && !divbill.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divbill))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(divbill))%></td>
		<%}%>
		 <%if(workbill!=null && !workbill.equals("0")){%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workbill))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workbill))%></td>
		<%}%>
		 <%if(Double.parseDouble(divbill)+Double.parseDouble(workbill)>0) {%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divbill))+(Double.parseDouble(workbill)))%></td>
		<%}else{%>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divbill))+(Double.parseDouble(workbill)))%></td>
		<%}%>
		<td nowrap class="rptValue" align="right"><%=ndf.format(Double.parseDouble(divbill)-((Double.parseDouble(divrelease)*100000)-(Double.parseDouble(divexp))))%></td>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(Double.parseDouble(workbill)-((Double.parseDouble(workrelease)*100000)-(Double.parseDouble(workexp))))%></td>
		<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((Double.parseDouble(divbill)-((Double.parseDouble(divrelease)*100000)-(Double.parseDouble(divexp))))+(Double.parseDouble(workbill)-((Double.parseDouble(workrelease)*100000)-(Double.parseDouble(workexp)))))%></td>
	</tr>
	  <%}
	  %>
		<tr>
			<td align="center"   colspan=3 class="rptValue">Total(In Rs.)</td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col4*100000)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col5*100000)%></td>
			<td nowrap align="right" class="rptValue"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((col4*100000)+(col5*100000))%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col7)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col8)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((col7)+(col8))%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((col4*100000)-col7)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((col5*100000)-col8)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(((col4*100000)-col7)+((col5*100000)-col8))%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col13)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col14)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col13+col14)%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col13-((col4*100000)-col7))%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(col14-((col5*100000)-col8))%></td>
			<td nowrap class="rptValue" align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format((col13-((col4*100000)-col7))+(col14-((col5*100000)-col8)))%></td>
	  </tr>
	  <tr>
		<td align=center   colspan=3 class="rptValue">Total(In Lakhs.)</td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col4)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col5)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col4+col5)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col7/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col8/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col7/100000+col8/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(((col4*100000)-col7)/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(((col5*100000)-col8)/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format((((col4*100000)-col7)+((col5*100000)-col8))/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col13/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(col14/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format((col13/100000)+(col14/100000))%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format((col13-((col4*100000)-col7))/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format((col14-((col5*100000)-col8))/100000)%></td>
		<td nowrap class="rptValue" align="right"><%=ndf.format(((col13-((col4*100000)-col7))+(col14-((col5*100000)-col8)))/100000)%></td>
	  </tr>
	</tbody>
	</table>
<%}
	catch(Exception e){
	System.out.println("error in report:"+e.getMessage());}
	finally{
		if(rs!=null)rs.close();if(stmt!=null)stmt.close();
		if(rs1!=null)rs1.close();if(st1!=null)st1.close();
		if(rs2!=null)rs2.close();if(st2!=null)st2.close();
		if(rs3!=null)rs3.close();if(st3!=null)st3.close();
		if(rs4!=null)rs4.close();if(st4!=null)st4.close();
		if(rs5!=null)rs5.close();if(st5!=null)st5.close();
		if(rs6!=null)rs6.close();if(st6!=null)st6.close();
		if(conn!=null)conn.close();
	}%>
</body>
</html>