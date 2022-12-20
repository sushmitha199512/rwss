<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<style type="text/css">
<!--
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;
margin: 0px;
padding: 0
}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}
div#tbl-container22 {
width: 850px;
height: 430px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
padding: 4px 4px 4px 4px;
font-size: 11px;
height: 18px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;
padding: 4px 4px 4px 4px; 
font-size: 11px;.
height: 18px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table th {
width: 120px;
}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #2B3856;
color: white;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 20;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
width:120px;
}
-->
</style>
<script language="javascript">
function fnPrint()
{
	var width = 900;
	var height = 600;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_bill_tobe_release_rpt_secy_prt.jsp";
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow1 = window.open(url, "_New", properties);
	newWindow1.focus();
}
function wopen(url, name, w, h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table.css'/>">
<body  bgcolor="#edf2f8">
<table border = 0>	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
						<a href="../home.jsp">Home</a><a href="../home.jsp"><!-- Print --></a>
					</td>
				</tr>
			</table>
		</caption>
		<tr  align="center">
			<td align="center" class="rptHeading" style="width:350">Releases Vs Expenditures Vs Payment Dues Report</td>
			<td class="rptHeading" style="width:500" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
</table>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	//System.out.println("user ID :"+userid);
	DecimalFormat ndf = new DecimalFormat("####.00");
	double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0;
	Statement st1 = null;
	Statement st2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	Statement st6 = null;
	Statement stt = null;
	ResultSet rss = null,rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null;
try
{
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
	stt = conn.createStatement();
	String q = "select sum(OP_CL_BAL),programme_code from RWS_GRANT_OP_CL_BAL_TBL ";
   if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		q +=" where substr(office_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		q+=" and  substr(office_code,4,1)='"+userid.substring(3,4)+"' ";
	}
	q+=" group by programme_code";
	////System.out.println("qqqqq1:"+q);
	rss = stt.executeQuery(q);
	Hashtable ht = new Hashtable();
	while(rss.next())
	{
		ht.put(rss.getString(2),rss.getString(1)); 
	}
	String q1 = "select nvl(sum(b.LOC_AMOUNT),0),programme_code from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id and fin_year='2010-2011' ";
	   if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		q1 +="  and  substr(office_to_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		q1+=" and  substr(office_to_code,4,1)='"+userid.substring(3,4)+"' ";
	}
	q1+= "	group by programme_code";
	////System.out.println("qqqqq1:"+q1);
	rs1 = st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(2),rs1.getString(1)); 
	}
	String q3 = "select nvl(sum(voucher_amt),0),b.programme_code from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' ";
	  if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		q3 +="  and  substr(office_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		q3+=" and  substr(office_code,4,1)='"+userid.substring(3,4)+"' ";
	}
	
	q3+=" group by b.programme_code";
	//System.out.println("qqqqq1:"+q3);
	rs3 = st3.executeQuery(q3);
	Hashtable ht2 = new Hashtable();
	while(rs3.next())
	{
		ht2.put(rs3.getString(2),rs3.getString(1)); 
	}
	String q5 = "select nvl(sum(BILL_AMT_CONTRACTOR),0),nvl(sum(BILL_AMT_ADMISSIBLE),0),b.programme_code from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_sl_no<>'0' ";
	if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		q5 +="  and  substr(office_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		q5+=" and  substr(office_code,4,1)='"+userid.substring(3,4)+"' ";
	}
	q5+=" group by b.programme_code";
	//System.out..println("qqqqq1:"+q5);
	rs5 = st5.executeQuery(q5);
	Hashtable ht3 = new Hashtable();
	Hashtable ht4 = new Hashtable();
	while(rs5.next())
	{
		ht3.put(rs5.getString(3),rs5.getString(1)); 
		ht4.put(rs5.getString(3),rs5.getString(2)); 
	}
	String qry = "select programme_code,programme_name from rws_programme_tbl order by programme_name";
	
////System.out.println("qreeey:"+qry);
	  stmt = conn.createStatement();
	  rs = stmt.executeQuery(qry);
	  int count = 1;
	  %>
<div id="tbl-container22">
	<table id="tbl" border = 0 align=center bordercolor=navy style="border-collapse:collapse">
		<thead class="fixedHeader">
		<tr align="center">
			<th class="locked"><font face=verdana size=2 color=white><b>Sl. No</th>
			<th class="locked"><font face=verdana size=2 color=white><b>Program</th>
			<th><font face=verdana size=2 color=white><b>OB</th>
			<th><font face=verdana size=2 color=white><b>Releases During the Year  <BR> </font></th>
			<th><font face=verdana size=2 color=white><b>OB+Total Releases</B></font></th>
			<th><font face=verdana size=2 color=white><b>Expenditure Incurred as on Date </B> </font></th>
			<th><font face=verdana size=2 color=white><b>Amount in Hand as on Date</B></font></th>
			<th><font face=verdana size=2 color=white><b>Total Bill Raised Amount</B></font></th>
			<th><font face=verdana size=2 color=white><b>Total Bill Admissable Amount</B></font></th>
			<th><font face=verdana size=2 color=white><b>Amount to be Released(Rupees.)</B></font></th>
			<th><font face=verdana size=2 color=white><b>Amount to be Released(Lakhs.)</B></font></th>
	</tr>
	<tr align="center" style="position: relative; top: expression(this.offsetParent.scrollTop-1);">
		<td class="locked" style="background-color: #2B3856"><font face=verdana size=2 color=white>1</td>
		<td class="locked" style="background-color: #2B3856"><font face=verdana size=2 color=white>2</td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>4</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>5</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>6(4+5)</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>7</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>8(6-7)</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>9</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>10</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>11(6-10)</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>12(6-10)</font></td>
  </tr>
</thead>
<tbody>
<%
		  String ob = "";
		  int countt = 0;
		while(rs.next()){
		ob = ""+ht.get(rs.getString(1));
		if(ob!=null && !ob.equals("null")){}else{ob="0";}
		String release = ""+ht1.get(rs.getString(1));
		if(release!=null && !release.equals("null")){}else{release="0";}
		String exp = ""+ht2.get(rs.getString(1));
		if(exp!=null && !exp.equals("null")){}else{exp="0";}
		String bill = ""+ht3.get(rs.getString(1));
		if(bill!=null && !bill.equals("null")){}else{bill="0";}
		String bill1 = ""+ht4.get(rs.getString(1));
		if(bill1!=null && !bill1.equals("null")){}else{bill1="0";}
		
		col4 += Double.parseDouble(ob);
		col5 += Double.parseDouble(release)*100000;
		col6 += Double.parseDouble(release)*100000+Double.parseDouble(ob);
		col7 += Double.parseDouble(exp);
		col8 += (Double.parseDouble(release)*100000+Double.parseDouble(ob))-Double.parseDouble(exp);

		col9 += Double.parseDouble(bill);
		col10 += Double.parseDouble(bill1);
		
		col11 += (Double.parseDouble(release)*100000+Double.parseDouble(ob))-Double.parseDouble(bill1);
		col12 += ((Double.parseDouble(release)*100000+Double.parseDouble(ob))-Double.parseDouble(bill1))/100000;

		if(countt%2==0){%>
		<tr  class="normalRow">
			<td align="center" style="background:#FFFFFF" class="locked"><%=count++%></td>
			<td nowrap align="left" style="background:#FFFFFF" class="locked"><a href="./rws_prog_div_release_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=rs.getString(2)%>"><%=rs.getString(2)%></a></td>
		<%}else{%>
		<tr  class="alternateRow">
			<td align="center" style="background:#C9C299" class="locked"><%=count++%></td>
			<td nowrap align="left" style="background:#C9C299" class="locked"><a href="./rws_prog_div_release_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=rs.getString(2)%>"><%=rs.getString(2)%></a></td>
		<%}
		countt++;%>
		<!-- OB -->
		<%if(ob!=null && !ob.equals("0")){%>
		<td class="rptValue" align="right"><a href="#" onClick="wopen('rws_ob_releases_prog_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=rs.getString(2)%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(ob))%></a></td>
		<%}else{%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(ob))%></td>
		<%}%>
		<!-- Releases -->
		<%if(release!=null && !release.equals("0")){%>
		<td class="rptValue" align="right"><a href="#" onClick="wopen('rws_prog_release_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=rs.getString(2)%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(release)*100000)%></a></td>
		<%}else{%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(release)*100000)%></td>
		<%}%>
		 <!-- OB+Releases -->
		<td class="rptValue" align="right"><%=ndf.format((Double.parseDouble(release)*100000)+(Double.parseDouble(ob)))%></td>
		<!-- Expenditure -->
		<%if(exp!=null && !exp.equals("0")){
			String ss="";
			if(rs.getString(1)!=null && rs.getString(1).equals("02"))
			{
				ss=rs.getString(1);
			}
			else{
				ss=rs.getString(2);
			}
			%>
		<td class="rptValue" align="right"><a href="#" onClick="wopen('rws_prog_voucher_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=ss%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(exp))%></a></td>
		<%}else{%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(exp))%></td>
		<%}%>
		<td class="rptValue" align="right"><%=ndf.format(((Double.parseDouble(release)*100000)+(Double.parseDouble(ob)))-Double.parseDouble(exp))%></td>
		<!-- Bills -->
		<%if(bill!=null && !bill.equals("0")){
			String ss="";
			if(rs.getString(1)!=null && rs.getString(1).equals("02"))
			{
				ss=rs.getString(1);
			}
			else{
				ss=rs.getString(2);
			}
			%>
		<td class="rptValue" align="right"><a href="#" onClick="wopen('rws_prog_bill_rpt.jsp?pcode=<%=rs.getString(1)%>&pname=<%=ss%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(bill))%></a></td>
		<%}else{%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(bill))%></td>
		<%}%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(bill1))%></td>
		<!-- Balance -->
		<!-- Amount to be issued -->
		<td class="rptValue" align="right"><%=ndf.format(((Double.parseDouble(release)*100000)+(Double.parseDouble(ob)))-Double.parseDouble(bill1))%></td>
		<td class="rptValue" align="right"><%=ndf.format((((Double.parseDouble(release)*100000)+(Double.parseDouble(ob)))-Double.parseDouble(bill1))/100000)%></td>	
	</tr>
	  <%}
	  %>
		<tr class="alternateRow">
			<td align="center"  class="locked" colspan=2>Total(In Rs.)</td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col4)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col5)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col6)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col7)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col8)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col9)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col10)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col11)%></td>
			<td>&nbsp;</td>
	  </tr>
	  <tr class="normalRow">
		<td align="center"  class="locked" colspan=2>Total(In Lakhs.)</td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col4/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col5/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col6/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col7/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col8/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col9/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col10/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col11/100000)%></td>
			<td>&nbsp;</td>
	  </tr>
	</tbody>
	</table>
	</div>
<%}
	catch(Exception e){
	//System.out.println("error in report:"+e.getMessage());
	}
	finally{
	try{
		if(rs!=null)rs.close();if(stmt!=null)stmt.close();
		if(rs1!=null)rs1.close();if(st1!=null)st1.close();
		if(rs2!=null)rs2.close();if(st2!=null)st2.close();
		if(rs3!=null)rs3.close();if(st3!=null)st3.close();
		if(rs4!=null)rs4.close();if(st4!=null)st4.close();
		if(rs5!=null)rs5.close();if(st5!=null)st5.close();
		if(rs6!=null)rs6.close();if(st6!=null)st6.close();
		if(conn!=null)conn.close();
	}catch(Exception eee){eee.getMessage();}
	}%>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>