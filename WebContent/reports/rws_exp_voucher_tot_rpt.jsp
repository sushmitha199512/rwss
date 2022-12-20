<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp"%>
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
width: 1050px;
height: 550px;
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
						<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		<tr  align="center">
			<td align="centre" class="rptHeading" style="width:950">Summarized Financial Report(All Years) for<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Releases Vs Expenditures Vs Payment Dues Report</td>
			<td class="rptHeading" style="width:500" align="center">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
</table>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	//System.out.println("user di:"+userid);
	DecimalFormat ndf = new DecimalFormat("####.00");
	double col4=0.0,col5=0.0,col6=0.0,col7=0.0,col8=0.0,col9=0.0,col10=0.0,col11=0.0,col12=0.0,col13=0.0,col14=0.0,col15=0.0;
	Statement st1 = null;
	Statement st2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5 = null;
	Statement st6 = null;
	Statement stt = null;
    Statement st7= null;

	ResultSet rss = null,rs1 = null,rs2 = null,rs3 = null,rs4 = null,rs5 = null,rs6 = null,rs7=null;
try
{
 
	st1 = conn.createStatement();
	st2 = conn.createStatement();
	st3 = conn.createStatement();
	st4 = conn.createStatement();
	st5 = conn.createStatement();
	st6 = conn.createStatement();
    st7 = conn.createStatement();
	stt = conn.createStatement();
   // System.out.println("hththththththtconn:"+conn);
	String qry = "select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code";
	if(userid.equals("admin") || userid.equals("100000") || userid.equals("psrwss") || userid.equals("guest")){}
	else
	{	qry +=" and dcode='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
			qry +=" and division_office_code='"+userid.substring(3,4)+"'";
	}
	qry += " order by 1,2";
  // System.out.println("district11........:"+qry);
	  stmt = conn.createStatement();
	  rs = stmt.executeQuery(qry);
	  int count = 1;
	 

  
//query to display total bill raised and forwarded by EE

//String q5 = "select nvl(sum(BILL_AMT_CONTRACTOR),0),nvl(sum(BILL_AMT_ADMISSIBLE),0),substr(b.office_code,2,3) from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and EE_FWD_DATE is not null and bill_sl_no<>'0' and to_char(bill_date,'yy')='"+fyear+"' group by substr(b.office_code,2,3)";

String q5="select nvl(sum(BILL_AMT_CONTRACTOR),0),nvl(sum(BILL_AMT_ADMISSIBLE),0),substr(b.office_code,2,3) from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and EE_FWD_DATE is not null and bill_sl_no<>'0' group by substr(b.office_code,2,3)";
//System.out.println("admissable amt........."+q5); 


//Financial Year 
//String q5="select to_char(BILL_DATE,'dd-MON-yy') ,nvl(sum(BILL_AMT_CONTRACTOR),0),nvl(sum(BILL_AMT_ADMISSIBLE),0),substr(b.office_code,2,3) from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and EE_FWD_DATE is not null and bill_sl_no<>'0' and BILL_DATE >=to_date('01-MAR-2011','dd-MON-yyyy') AND  BILL_DATE <=to_date('01-OCT-2011','dd-mon-yyyy') group by substr(b.office_code,2,3),BILL_DATE";


	rs5 = st5.executeQuery(q5);
    Hashtable ht2 = new Hashtable();  
	Hashtable ht1 = new Hashtable();
	Hashtable ht3 = new Hashtable();
	Hashtable ht4 = new Hashtable();
	Hashtable ht5 = new Hashtable(); 
	Hashtable ht7 = new Hashtable();  
	Hashtable ht8=new Hashtable();
	while(rs5.next())
	{
		ht3.put(rs5.getString(3),rs5.getString(1)); 
		ht4.put(rs5.getString(3),rs5.getString(2)); 
         
		/*ht3.put(rs5.getString(4),rs5.getString(2)); 
		ht4.put(rs5.getString(4),rs5.getString(3)); 
        ht8.put(rs5.getString(4),rs5.getString(1));  */
	}
  // System.out.println("total bill  raised........:"+q5);

//total amt voucher

//String q3 = "select nvl(sum(voucher_amt),0),substr(b.office_code,2,3) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and to_char(VOUCHER_DT,'yy')='"+fyear+"' group by substr (b.office_code,2,3)";


String q3="select nvl(sum(voucher_amt),0),substr(b.office_code,2,3) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <>'0' group by substr(b.office_code,2,3)";
//System.out.println("total voucher amt ...:"+q3);

	rs3 = st3.executeQuery(q3);
	//Hashtable ht2 = new Hashtable();
	while(rs3.next())
	{
		ht2.put(rs3.getString(2),rs3.getString(1)); 
	}

//query for Bank/pao amount Dispalying


//String q1 = "select nvl(sum(BILL_AMOUNT_CENTRAL),0),substr(a.office_code,2,3) from rws_bill_bank_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null and  to_char(BANK_SEND_DATE,'yy')='"+fyear+"' group by substr (a.office_code,2,3)";



String q1="select nvl(sum(BILL_AMOUNT_CENTRAL),0),substr(a.office_code,2,3) from rws_bill_bank_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null group by substr (a.office_code,2,3)";
//System.out.println("bank amt ........."+q1);
	 rs6 = st6.executeQuery(q1);
	 
	while(rs6.next())
	{
		ht5.put(rs6.getString(2),rs6.getString(1));
		
	}


//String q6 = "select nvl(sum(BILL_AMOUT_STATE),0),substr(a.office_code,2,3) from rws_bill_pao_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null and to_char(STATE_SEND_DATE,'yy')='"+fyear+"' group by substr (a.office_code,2,3)";

String q6="select nvl(sum(BILL_AMOUT_STATE),0),substr(a.office_code,2,3) from rws_bill_pao_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null group by substr (a.office_code,2,3)";

//System.out.println("state amt ........"+q6);
	 rs7 = st7.executeQuery(q6);
	 
	while(rs7.next())
	{
		ht7.put(rs7.getString(2),rs7.getString(1));
		
	}



 %>


<div id="tbl-container22">
	<table id="tbl" border = 0 align=center bordercolor=navy style="border-collapse:collapse">
		<thead class="fixedHeader">
		<tr align="center">
			<th class="locked" ><font face=verdana size=2 color=white><b>Sl. No</th>
			<th class="locked"><font face=verdana size=2 color=white><b>District</th>
			<th class="locked"><font face=verdana size=2 color=white><b>Division</th>
			<!-- <th><font face=verdana size=2 color=white><b>OB</th>
			<th><font face=verdana size=2 color=white><b>Releases During the Year  <BR> </font></th>
			<th><font face=verdana size=2 color=white><b>OB+Total Releases</B></font></th>
			<th><font face=verdana size=2 color=white><b>Expenditure Incurred as on Date </B> </font></th>
			<th><font face=verdana size=2 color=white><b>Amount in Hand as on Date</B></font></th> -->
			<th width="130"><font face=verdana size=2 color=white><b>Total Bill Raised Amount</B></font></th>
			<th width="130"><font face=verdana size=2 color=white><b>Total Bill Admissable Amount</B></font></th>
			<th colspan=3  width="280"><font face=verdana size=2 color=white><b>Total Releases</B></font></th>
			<th width="130"><font face=verdana size=2 color=white><b>Total Expenditure of Voucher</B></font></th>
			<th width="130"><font face=verdana size=2 color=white><b>Total Amount in Hand </B></font></th>
             <th width="130"><font face=verdana size=2 color=white><b>Total Release Amount Due </B></font></th>

	</tr>
	<tr align="center" style="position: relative; top: expression(this.offsetParent.scrollTop-1);"> 
		<td style="background-color: #2B3856"  width="160" colspan=5><font face=verdana size=2 color=white></font></td>
		<td style="background-color: #2B3856 " ><font face=verdana size=2 color=white >&nbsp;&nbsp;Bank&nbsp;&nbsp;</font></td>
		<td style="background-color: #2B3856" width="120" ><font face=verdana size=2 color=white>&nbsp;&nbsp;PAO&nbsp;&nbsp;</font></td>

		<td style="background-color: #2B3856" width="160"><font face=verdana size=2 color=white>&nbsp;&nbsp;Total(Bank+Pao)&nbsp;&nbsp;</font></td>
		<td style="background-color: #2B3856"  colspan=3><font face=verdana size=2 color=white></font></td>
  </tr>
  	<tr align="center" style="position: relative; top: expression(this.offsetParent.scrollTop-1);">
		<td class="locked" style="background-color: #2B3856"><font face=verdana size=2 color=white>1</td>
		<td class="locked" style="background-color: #2B3856"><font face=verdana size=2 color=white>2</td>
		<td class="locked" style="background-color: #2B3856"><font face=verdana size=2 color=white>3</td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>4</font></td>
		<td style="background-color: #2B3856" ><font face=verdana size=2 color=white>5</font></td>
		<td style="background-color: #2B3856 " ><font face=verdana size=2 color=white>6</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>7</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white></font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>8</font></td>
		<td style="background-color: #2B3856"><font face=verdana size=2 color=white>9
		(8-6+7)</font></td>
   <td style="background-color: #2B3856"><font face=verdana size=2 color=white>10(5-6+7)</font></td>
		
  </tr>
</thead>
<tbody>

<tr  class="alternateRow">
			<td align="center" style="background:#C9C299" class="locked"><%=count++%></td>
			<td nowrap align="left" style="background:#C9C299" class="locked">Hyderbad</td>
			<td nowrap align="left" style="background:#C9C299" class="locked">Head Office</td>
			<td colspan=22>&nbsp;</td>
</tr>
	<%
		 int countt = 0;
		 while(rs.next()){

		//raised Amount
		String release = ""+ht3.get(rs.getString(1)+rs.getString(2));
	   //System.out.println("raised amt="+release);
      	if(release!=null && !release.equals("null"))
			{
		   }
		   else
			{
			   release="0";
		   }

		col5 += Double.parseDouble(release);
		//System.out.println("relese122="+col5);

//admisable amount

      String bill1 = ""+ht4.get(rs.getString(1)+rs.getString(2));
		if(bill1!=null && !bill1.equals("null")){}else{bill1="0";}
       col10 += Double.parseDouble(bill1);
//System.out.println("admisable="+bill1);

//totall voucher 

String exp = ""+ht2.get(rs.getString(1)+rs.getString(2));
		if(exp!=null && !exp.equals("null")){}
		else{
			exp="0";
			}
//System.out.println("voucher="+exp);

col8 += Double.parseDouble(exp);

//PAO/BANK

      String bamt = ""+ht5.get(rs.getString(1)+rs.getString(2));
	  if(bamt!=null && !bamt.equals("null"))
		{
	  }else
		  
	  {bamt="0";}

     //System.out.println("CENTRAL="+bamt);

     col7 += Double.parseDouble(bamt);


 String pamt = ""+ht7.get(rs.getString(1)+rs.getString(2));
	  if(pamt!=null && !pamt.equals("null"))
		{
	  }else
		  
	  {pamt="0";}
     //System.out.println("STATE="+pamt);
     col12 += Double.parseDouble(pamt);

 col13 += (Double.parseDouble(bamt)+Double.parseDouble(pamt))-(Double.parseDouble(bill1));

 col11 += (Double.parseDouble(bamt)+Double.parseDouble(pamt))-(Double.parseDouble(exp));

//Pao+Bank

col14+=Double.parseDouble(pamt)+Double.parseDouble(bamt);
//System.out.println("col14="+col14);

//amt hand 

     String hamt=""+bamt+pamt;
	 
	  if(hamt!=null && !hamt.equals("null"))
		{
	  }else
		  
	  {hamt="0";} 

//System.out.println("hamt="+hamt);


	if(countt%2==0)
		{%>
			<tr  class="normalRow">
				<td align="center" style="background:#FFFFFF" class="locked"><%=count++%></td>
				<td nowrap align="left" style="background:#FFFFFF" class="locked"><%=rs.getString(3)%></td>
				<td nowrap align="left" style="background:#FFFFFF" class="locked"><%=rs.getString(4)%></td>
				
			<%}
	else
			  {
		%>
			<tr  class="alternateRow">
				<td align="center" style="background:#C9C299" class="locked"><%=count++%></td>
				<td nowrap align="left" style="background:#C9C299" class="locked"><%=rs.getString(3)%></td>
				<td nowrap align="left" style="background:#C9C299" class="locked"><%=rs.getString(4)%></td>
							<%}
			countt++;%>


		<!-- Releases -->
		<%if(release!=null && !release.equals("0"))
			{
			%>
		 <td class="rptValue" align="right"><a href="#" onClick="wopen('rws_exp_voucher_tot_releaseamt_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(release))%></a>
		 </td>
		 <%//System.out.println("relese22="+ndf.format(Double.parseDouble(release)*100000));%>
		<%}
		 else
		 {%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(release)*100000)%></td>
      <%//System.out.println("relese33="+ndf.format(Double.parseDouble(release)*100000));%>
		<%}%>

		<!-- admisable -->

				<%if(bill1!=null && !bill1.equals("0"))
			{
			%>
			 <td class="rptValue" align="right"><a href="#" onClick="wopen('rws_exp_voucher_tot_admissableamt_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)"><%=ndf.format(Double.parseDouble(bill1))%></td></a>
	 <%}
		 else
		 {%>
		 
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(bill1)*100000)%></td>
		<%}%>
	

		<!--total Releases -->
       <%if(bamt!=null && !bamt.equals("0"))
			{
			%>
			 <td class="rptValue" align="right"> <a href="#" onClick="wopen('rws_exp_voucher_tot_bankamt_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)">  <%=ndf.format(Double.parseDouble(bamt))%> </td>
<%}
		 else
		 {%>

		 
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(bamt)*100000)%></td>
		

		<%}%>

      <%if(pamt!=null && !pamt.equals("0"))
			{
			%>

			 <td class="rptValue" align="right" ><a href="#" onClick="wopen('rws_exp_voucher_tot_paoamt_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)"> <%=ndf.format(Double.parseDouble(pamt))%></td>
			 

			 <%}
		 else
		 {%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(pamt)*100000)%></td>
		

		<%}%>
         
		 <%if(hamt!=null && !hamt.equals("0"))
			{
			%>

			 <td class="rptValue" align="right" > <%=ndf.format(Double.parseDouble(pamt)+Double.parseDouble(bamt))%></td>
			 

			 <%}
		 else
		 {%>
		<td class="rptValue" align="right">0.0</td>
		

		<%}%>

		<!-- Voucher -->
<%if(exp!=null && !exp.equals("0"))
			{
			%>

			 <td class="rptValue" align="right">
			 <a href="#" onClick="wopen('rws_exp_voucher_tot_voucheramt_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)">
			 <%=ndf.format(Double.parseDouble(exp))%></td>
         
			  <%}
		 else
		 {%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(exp)*100000)%></td>

		<%}%>


		<!--  amt hand -->
<%if(hamt!=null && !hamt.equals("0"))
			{
			%>
		 <td class="rptValue" align="right"> <!-- <a href="#" onClick="wopen('rws_releases_amthandmodifyed_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)"> -->
	<%=ndf.format(((Double.parseDouble(bamt))+(Double.parseDouble(pamt)))-(Double.parseDouble(exp)))%></td>


			  <%}
		 else
		 {%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(hamt)*100000)%></td>
		
		

		<%}%>

		<!-- due amount -->

		<%if(bill1!=null && !bill1.equals("0"))
			{
			%>
			 <td class="rptValue" align="right"> <!-- <a href="#" onClick="wopen('rws_releases_amtduemodifyed_rpt.jsp?dcode=<%=rs.getString(1)%>&divcode=<%=rs.getString(2)%>&dnamee=<%=rs.getString(3)%>&divname=<%=rs.getString(4)%>','popup', 900, 300)"> --><%=ndf.format((Double.parseDouble(bill1))-((Double.parseDouble(bamt))+(Double.parseDouble(pamt))))%></td> 



			  <%}
		 else
		 {%>
		<td class="rptValue" align="right"><%=ndf.format(Double.parseDouble(exp)*100000)%></td>

		<%}%>


		</tr>
   <%}
	  %>
		<tr class="normalRow">
			<td align="center"  class="locked" colspan=3>Total(In Rs.)</td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col5)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col10)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col7)%></td>
 
		<td nowrap class="text2bold1" align="right"><%=ndf.format(col12)%></td>
		 <td nowrap class="text2bold1" align="right"><%=ndf.format(col14)%></td>
       <td nowrap class="text2bold1" align="right"><%=ndf.format(col8)%></td>

      <td nowrap class="text2bold1" align="right"><%=ndf.format(col11)%></td>
       <td nowrap class="text2bold1" align="right"><%=ndf.format(col13)%></td>
	
			<td>&nbsp;</td>
	  </tr>
	  <tr class="alternateRow">
		<td align="center"  class="locked" colspan=3>Total(In Lakhs.)</td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col5/100000)%></td>
			<td nowrap class="text2bold1" align="right"><%=ndf.format(col10/100000)%></td>
         <td nowrap class="text2bold1" align="right"><%=ndf.format(col7/100000)%></td>
		 <td nowrap class="text2bold1" align="right"><%=ndf.format(col12/100000)%></td>
 <td nowrap class="text2bold1" align="right"><%=ndf.format(col14/100000)%></td>
 <td nowrap class="text2bold1" align="right"><%=ndf.format(col8/100000)%></td>
 
  <td nowrap class="text2bold1" align="right"><%=ndf.format(col11/100000)%></td>
          <td nowrap class="text2bold1" align="right"><%=ndf.format(col13/100000)%></td>

			<td>&nbsp;</td>
	  </tr>
	</tbody>
	</table>
	</div>
<%}

	catch(Exception e){
	System.out.println("error in report:"+e.getMessage());
	e.printStackTrace();}
	finally{
	try{
		if(rs!=null)rs.close();if(stmt!=null)stmt.close();
		if(rs1!=null)rs1.close();if(st1!=null)st1.close();
		if(rs2!=null)rs2.close();if(st2!=null)st2.close();
		if(rs3!=null)rs3.close();if(st3!=null)st3.close();
		if(rs4!=null)rs4.close();if(st4!=null)st4.close();
		if(rs5!=null)rs5.close();if(st5!=null)st5.close();
		if(rs6!=null)rs6.close();if(st6!=null)st6.close();
		//System.out.println("dgfgdjdfgdf");
		if(conn!=null)conn.close();
	}catch(Exception eee){eee.getMessage();

	}
	}%>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>