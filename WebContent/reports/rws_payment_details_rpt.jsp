<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<html>
<form>
<script>
function wopen(url, name, w, h)
{
	var width = 950;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null;
StringBuffer dist=new StringBuffer(request.getParameter("district"));

StringBuffer cat=new StringBuffer(request.getParameter("program"));
StringBuffer  year=new StringBuffer(request.getParameter("year"));
 ////System.out.println("year:"+year);
 StringBuffer  yr=null;
 if(request.getParameter("year")!=null){
 yr=new StringBuffer(request.getParameter("year"));
 }else{
	 yr.append("All");
 }

 ////System.out.println("cat:"+cat);
StringBuffer  dname=new StringBuffer(request.getParameter("dname"));
StringBuffer catname=new StringBuffer(request.getParameter("pname"));
int count=0;
//String brv=null;
%>
<table border = 0 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<caption>
<table border = 0 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr>
<td class="bwborder" align="right"><a href="javascript:onclick=history.go(-1)">Back</a></td>
</tr>
</caption>
<table border = 1 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr  align="center" class=btext> District:&nbsp;<%=dname%>&nbsp;&nbsp;&nbsp;Work Category: &nbsp;<%=catname%>&nbsp;&nbsp;Financial Year:&nbsp;<%=yr%></tr>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=10 >Payment Details Report</td>	
</tr>
<tr align="center">
<td class=btext  rowspan=2>Sl.No</td>
<td class=btext rowspan=2>Division</td>
<td class=btext colspan=2 >Bills</td>
<td class=btext colspan=2>Vouchers</td>
</tr>
<tr align="center">
	<td class=btext >No's</td>
	<td class=btext >Amount(in Rupees)</td>
	<td class=btext >No's</td>
	<td class=btext >Amount(in Rupees)</td>
</tr>
<%
StringBuffer qry= new StringBuffer();
qry.append("select division_office_code,division_office_name,circle_office_code from rws_division_office_tbl");
if(dist!=null && !dist.equals("all"))
{
 qry.append(" where circle_office_code='"+dist+"'");
}
qry.append(" order by division_office_code");
////System.out.println("qry:"+qry );

stmt1=conn.createStatement();
stmt2=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();

Hashtable ht=new Hashtable();
Hashtable htbamt=new Hashtable();
Hashtable vno=new Hashtable();
Hashtable vamt=new Hashtable();

StringBuffer qry1= new StringBuffer();

 qry1.append("select count(bill_no),substr(office_code,2,3) from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and category_code='"+cat+"'");
if(year!=null && !year.equals("")){
qry1.append("and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'");
}
qry1.append(" group by substr(office_code,2,3)") ;
//System.out.println("qry1.toString()"+qry1.toString());
rs1=stmt1.executeQuery(qry1.toString()); 

 while(rs1.next())
{
 ht.put(rs1.getString(2),rs1.getString(1));
}
 
 qry1.delete(0,qry1.length());
 
 qry1.append("select sum(BILL_AMT_CONTRACTOR),substr(office_code,2,3) from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and category_code='"+cat+"'");
if(year!=null && !year.equals("")){
qry1.append(" and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'");
}
qry1.append("group by substr(office_code,2,3)");
//System.out.println("2.qry1.toString()"+qry1.toString());
rs2=stmt2.executeQuery(qry1.toString()); 
while(rs2.next())
{
 htbamt.put(rs2.getString(2),rs2.getString(1));
}

qry1.delete(0,qry1.length());
qry1.append("select count(VOUCHER_NO),substr(office_code,2,3)from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and category_code='"+cat+"'");
if(year!=null && !year.equals("")){
qry1.append(" and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'");
}
qry1.append(" group by substr(office_code,2,3)") ;

rs3=stmt3.executeQuery(qry1.toString()); 
while(rs3.next())
{
 vno.put(rs3.getString(2),rs3.getString(1));
}
qry1.delete(0,qry1.length());

qry1.append("select sum(VOUCHER_AMT ),substr(office_code,2,3)from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and category_code='"+cat+"'");
if(year!=null && !year.equals("")){
qry1.append(" and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'");
}
qry1.append(" group by substr(office_code,2,3)  " );
rs4=stmt4.executeQuery(qry1.toString()); 
while(rs4.next())
{
 vamt.put(rs4.getString(2),rs4.getString(1));
}
int bno=0,vsno=0;
long bnamt=0,vnamt=0;

//coding for printing
stmt=conn.createStatement();
rs=stmt.executeQuery(qry.toString());

StringBuffer billNo=new StringBuffer();
StringBuffer billAmt=new StringBuffer();
StringBuffer vcno=new StringBuffer();
StringBuffer vcamt=new StringBuffer();


while(rs.next())
{
	billNo.delete(0,billNo.length());
	billNo.append(ht.get(rs.getString(3)+rs.getString(1))!=null && !ht.get(rs.getString(3)+rs.getString(1)).equals("null") ?ht.get(rs.getString(3)+rs.getString(1)):"0");
	
	billAmt.delete(0,billAmt.length());
	billAmt.append(htbamt.get(rs.getString(3)+rs.getString(1))!=null && !htbamt.get(rs.getString(3)+rs.getString(1)).equals("null")?htbamt.get(rs.getString(3)+rs.getString(1)):"0");
	
	vcno.delete(0,vcno.length());
	vcno.append(vno.get(rs.getString(3)+rs.getString(1))!=null && !vno.get(rs.getString(3)+rs.getString(1)).equals("null")? vno.get(rs.getString(3)+rs.getString(1)):"0");
	
	vcamt.delete(0,vcamt.length());
	vcamt.append(vamt.get(rs.getString(3)+rs.getString(1))!=null && !vamt.get(rs.getString(3)+rs.getString(1)).equals("null")?vamt.get(rs.getString(3)+rs.getString(1)):"0");
    
	%>
<tr>
<td class=rptvalue><%=++count%></td>
<td class=rptvalue><a href="#" onclick="wopen('./rws_work_billvoucher_details_rpt.jsp?divname=<%=rs.getString(2)%>&year=<%=year%>&cat=<%=cat%>&officecode=<%=rs.getString(3)+rs.getString(1)%>','popup', 500, 400)"><%=rs.getString(2)%></a></td>
<td class=rptvalue align="right"><%=billNo%></td>
<%if(Double.parseDouble(billAmt.toString()) >0.0) {%>
 <td class=rptvalue align="right"><a href="#" onclick="wopen('./rws_bill_voucher_details_rpt.jsp?divname=<%=rs.getString(2)%>&year=<%=year%>&brv=<%="bill"%>&cat=<%=cat%>&officecode=<%=rs.getString(3)+rs.getString(1)%>','popup', 500, 400)"><%=billAmt%></a></td>
 <%} else{%><td class=rptvalue align="right"><%=billAmt%></td><%}%>
<td class=rptvalue align="right"><%=vcno%></td>
<% if(Double.parseDouble(vcamt.toString()) >0.0) {%>
<td class=rptvalue align="right"><a href="#" onclick="wopen('./rws_bill_voucher_details_rpt.jsp?divname=<%=rs.getString(2)%>&year=<%=year%>&brv=<%="voucher"%>&cat=<%=cat%>&officecode=<%=rs.getString(3)+rs.getString(1)%>','popup', 500, 400)"><%=vcamt%></a></td>
 <%}else {%> <td class=rptvalue align="right"><%=vcamt%></td><%}%>

 </tr>
<%
//System.out.println("billNo.toString()"+billNo.toString());
bno+=Integer.parseInt(billNo.toString());	 
vsno+=Integer.parseInt(vcno.toString());
//bnamt+=workData.round((Double.parseDouble(billAmt)),2);
//vnamt+=workData.round((Double.parseDouble(vcamt)),2);
bnamt+=(new Double(billAmt.toString())).longValue();
vnamt+=(new Double(vcamt.toString())).longValue();

 }

Runtime.getRuntime().gc();
 %>

<tr align="center">
<td class=btext colspan=2>Total</td>
<td class=btext align="right"><%=bno%></td>
<td class=btext align="right"><%=bnamt%></td>
<td class=btext align="right"><%=vsno%></td>
<td class=btext align="right"><%=vnamt%></td>
</tr>
<table>
</table>
</table>
<%@ include file = "footer.jsp" %>
</form>

</html>