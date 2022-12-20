<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.DateFormat"%>

<%
 String dist=request.getParameter("district");
 String div=request.getParameter("division");
 String frmDate = request.getParameter("frmDate");
 String toDate = request.getParameter("toDate");
 String dname=request.getParameter("dname");
 String divname=request.getParameter("divname");
%>
<table width="60%" align=center>
<tr><td width="20%" bgcolor="pink" bordercolor="black"></td><td class=rptValue>&nbsp;- Releases Made but Vouchers  Payments Not Made</td></tr>
<tr><td width="20%" bgcolor="white"></td><td class=rptValue>&nbsp;- Releases Not Made  and  Vouchers Payments   Not Made</td></tr>
<tr><td width="20%" bgcolor="yellow" ></td><td class=rptValue>&nbsp;- Releases Not Made but  Vouchers Payments Made</td></tr>
<tr><td width="20%" bgcolor="green" ></td><td class=rptValue>&nbsp;- Releases  Made  and   Vouchers Payments Made</td></tr>
</table>
<table>
<tr><td width="25%" align="right" class=btext>(Amounts Displayed in Rupees)</td></tr></table>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>|<a href="./rws_bank_details_xls.jsp?district=<%=dist%>&division=<%=div%>&frmDate=<%=frmDate%>
			&dname=<%=dname%>&divname=<%=divname%>&toDate=<%=toDate%>" target=_new>Excel</a>
			</td>
		</tr>
	</table>
<table>
<tr><td class=btext align="left">District:<font face="verdana" size="1" color="black"><%=dname%></font>&nbsp;Division:<font face="verdana" size="1" color="black"><%=divname%></font>&nbsp;From Date:<font face="verdana" size="1" color="black"><%=frmDate%></font>&nbsp;To Date:<font face="verdana" size="1" color="black"><%=toDate%></font></td></tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=15 >Bills Vs Releases  Vs  Vouchers </td>	
</tr>
<tr><td class=btext>Sl.No</td>
<td class=btext>Work Id</td>
<td class=btext>Work Name</td>
<td class=btext>Program/<BR>Sub Program</td>
<td class=btext>Bill No</td>
<td class=btext>Bill Date</td>
<td class=btext>Bill Entered Date</td>
<td class=btext>Bill Amount Admissible</td>
<td class=btext>Central Releases</td>
<td class=btext>State Releases</td>
<td class=btext>Cheque Date</td>
<td class=btext>Voucher Amount</td>
</tr>
<% int sno=0;
Statement stmt1=conn.createStatement();
Statement stmt2=conn.createStatement();
Statement stmt3=conn.createStatement();
Statement stmt4=conn.createStatement();
Statement stmt5=conn.createStatement();
Statement stmt6=conn.createStatement();


ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null;
Hashtable ht = new Hashtable(); 
Hashtable ht1 = new Hashtable(); 
Hashtable ht2 = new Hashtable(); 
Hashtable ht3 = new Hashtable(); 
Hashtable ht4 = new Hashtable(); 

String qry3="select a.work_id||a.bill_sl_no from rws_bill_bank_bridge_tbl a,rws_work_bill_tbl b where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and a.work_id||a.bill_sl_no not in (select distinct work_id||bill_sl_no from rws_work_exp_voucher_tbl) and to_date(update_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy') and to_date (update_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy')";
rs3=stmt3.executeQuery(qry3);
while(rs3.next())
{
 ht.put(rs3.getString(1),rs3.getString(1));
}
String qry4="select work_id || bill_sl_no from rws_work_exp_voucher_tbl where voucher_amt is not null and work_id || bill_sl_no not in(select work_id || bill_sl_no from rws_bill_bank_bridge_tbl) and substr(work_id,5,2)='"+dist+"' ";
rs4=stmt4.executeQuery(qry4);
while(rs4.next())
{
 ht1.put(rs4.getString(1),rs4.getString(1));
}
String qry5="select a.work_id||a.bill_sl_no from rws_bill_bank_bridge_tbl a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and substr(a.work_id,5,2)='"+dist+"' ";
rs5=stmt5.executeQuery(qry5);
while(rs5.next())
{
 ht2.put(rs5.getString(1),rs5.getString(1));
}
String qry6="select b.work_id||b.bill_sl_no,bill_amount_central||'@'||bill_amout_state from rws_work_bill_tbl b,rws_bill_bank_bridge_tbl t where b.work_id||b.bill_sl_no=t.work_id||t.bill_sl_no and substr (b.work_id,5,2)='"+dist+"' and b.bill_sl_no<>'0' and to_date (update_date,'dd/mm/yy')>= to_date ('"+frmDate+"', 'dd/MM/yy') and to_date(update_date,'dd/mm/yy')<= to_date ('"+toDate+"', 'dd/MM/yy') order by b.work_id ";
rs6=stmt6.executeQuery(qry6);
while(rs6.next())
{
 ht3.put(rs6.getString(1),rs6.getString(2));
}
String qry2="select a.work_id||a.bill_sl_no, nvl(to_char(CHEQUE_DT,'dd/MM/yyyy'),'-')||'@'||nvl(voucher_amt,'0') from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b  where a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no  and substr(a.work_id,5,2)='"+dist+"' ";
rs2=stmt2.executeQuery(qry2);
while(rs2.next())
{
 ht4.put(rs2.getString(1),rs2.getString(2));
}

String qry="select a.work_id,work_name,bill_no,to_char(bill_date,'dd/MM/yyyy'), to_char(update_date,'dd/mm/yyyy'),bill_sl_no,BILL_AMT_ADMISSIBLE,programme_name,subprogramme_name from rws_work_admn_tbl a,rws_work_bill_tbl  b,rws_programme_tbl p,rws_subprogramme_tbl s  where a.programme_code=p.programme_code and p.programme_code=s.programme_code  and a.subprogramme_code=s.subprogramme_code and  a.work_id=b.work_id and  substr(office_code,2,2)='"+dist+"' and substr(office_code,4,1)='"+div+"' and  bill_sl_no<>'0'  and to_date(update_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')   and to_date(update_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy')  order by a.work_id,bill_no ";

int count=0;
String  wid="";
stmt=conn.createStatement( ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
rs=stmt.executeQuery(qry);
if(rs.next())
{
wid=rs.getString(1);
rs.previous();
}else{%>
 <script>
	alert("No Records For This  Criteria");
	document.location.href="rws_bank_details_frm.jsp";
</script>
<%}
while(rs.next())
{
   String css = "<font color=black face=verdana size=2>";
   String color="white";
	String da=""+ht.get(rs.getString(1)+rs.getString(6));
	if(da!=null  && !da.equals("")  && !da.equals("null")){
	 color="pink";
	css = "<font color=black face=verdana size=2>";	 
	}else{ da="-";}
	String vnr=""+ht1.get(rs.getString(1)+rs.getString("bill_sl_no"));
    if(vnr!=null  && !vnr.equals("")  && !vnr.equals("null")){ color="yellow";
	css = "<font color=black face=verdana size=2>";	 
	}else{ vnr="-";}
String pa=""+ht2.get(rs.getString(1)+rs.getString("bill_sl_no"));
 if(pa!=null  && !pa.equals("")  && !pa.equals("null")){ color="green";
	css = "<font color=white face=verdana size=2>";	 
	}else{ pa="-";}
String amt=""+ ht3.get(rs.getString(1)+rs.getString("bill_sl_no"));
String a1="-",a2="-";
if(amt!=null  && !amt.equals("")  && !amt.equals("null")) {
	  String []aa=amt.split("@");
	  a1=aa[0];a2=aa[1];
}
String vamt=""+ ht4.get(rs.getString(1)+rs.getString("bill_sl_no"));
String a3="-",a4="-";
if(vamt!=null  && !vamt.equals("")  && !vamt.equals("null")) {
	  String []bb=vamt.split("@");
	  a3=bb[0];a4=bb[1];
}


   %>
 <tr bgcolor="<%=color%>">
 <%if(rs.getString(1).equals(wid)){
  count++;   
 }
  if(count==1)
	{%>
 <td class=rptvalue align="center"><%=++sno%></td>
 <td class=rptvalue><%=css%><%out.println(rs.getString(1));%></td>
 <td class=rptvalue style=width:300px><%=css%><%out.println(rs.getString(2));%></td>
 <%}else{%>
 <td class=rptvalue align="center" colspan="3"><%=css%></td>
  <%
  count--;	  
  }%>
  <td class=rptvalue  nowrap><%=css%><%=rs.getString("programme_name")%>/<BR><%=rs.getString("subprogramme_name")%>
  </td>

 <td class=rptvalue  style=width:300px><%=css%><%out.println(rs.getString(3));%></td>
 <td class=rptvalue><%=css%><%out.println(rs.getString(4));%></td>
 <td class=rptvalue><%=css%><%out.println(rs.getString(5));%></td>
<td class=rptvalue><%=css%><%out.println(rs.getString(7));%></td>
<td class=rptvalue><%=css%><%=a1%></td>
<td class=rptvalue><%=css%><%=a2%></td>
 <td class=rptvalue><%=css%><%=a3%></td>
 <td class=rptvalue><%=css%><%=a4%></td>

  </tr>
	<%
	 wid=rs.getString(1);
	}%>
</table>
<p align="left">
	<font color="red" face="verdana" size="2">Note: Works  are displyed only For Bill Entered Date after 14-MAR-2011</font>
</p>
<%@ include file = "/reports/connClose1.jsp" %>
