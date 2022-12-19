
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
String officecode=request.getParameter("officecode");
String cat=request.getParameter("cat");
String year=request.getParameter("year");
String divname=request.getParameter("divname");
//String billvoc=request.getParameter("brv");
//println("year:"+year);
stmt=conn.createStatement();
stmt1=conn.createStatement();
stmt2=conn.createStatement();
stmt3=conn.createStatement();
stmt4=conn.createStatement();
stmt5=conn.createStatement();
%>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" align="center" >

<tr align=center  class=btext>Work wise Details of under division:<%=divname%> </tr>
<tr align="center">
<td class=btext  rowspan=2>Sl.No</td>
<td class=btext rowspan=2>Work Id</td>
<td class=btext rowspan=2>Work Name</td>
<td class=btext rowspan=2 >No of MileStones</td>
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

int count=0;
Hashtable ht=new Hashtable();
Hashtable bnoht=new Hashtable();
Hashtable bamtht=new Hashtable();
Hashtable vnoht=new Hashtable();
Hashtable vamtht=new Hashtable();
String qry1="select count(milestone_code),work_id from RWS_MILESTONE_TARGET_ACH_TBL group by work_id ";
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
	ht.put(rs1.getString(2),rs1.getString(1));
}
String qry2="select count(bill_no),a.work_id from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id  group by a.work_id";
rs2=stmt2.executeQuery(qry2);
while(rs2.next())
{
  bnoht.put(rs2.getString(2),rs2.getString(1));
}

String qry3="select sum(BILL_AMT_CONTRACTOR ),a.work_id from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id";
rs3=stmt3.executeQuery(qry3);
while(rs3.next())
{
  bamtht.put(rs3.getString(2),rs3.getString(1));
}
String qry4="select count(VOUCHER_NO),a.work_id from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
rs4=stmt4.executeQuery(qry4);
while(rs4.next())
{
  vnoht.put(rs4.getString(2),rs4.getString(1));
}
String qry5="select sum(VOUCHER_AMT ),a.work_id from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
rs5=stmt5.executeQuery(qry5);
while(rs5.next())
{
  vamtht.put(rs5.getString(2),rs5.getString(1));
}

int tbillno=0,tvno=0,tmcount=0;
long tbamt=0,tvamt=0;
String qry="select WORK_ID,work_name from rws_work_admn_tbl where  substr(office_code,2,3)='"+officecode+"' and category_code='"+cat+"' and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"' ";
//System.out.println("qry"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{
	String mcount=""+ht.get(rs.getString(1));
	if(mcount!=null && !mcount.equals("null")  && !mcount.equals("")){}else{mcount="0";} 
    String bno=""+bnoht.get(rs.getString(1));
	if(bno!=null && !bno.equals("null")  && !bno.equals("")){}else{bno="0";} 
	String bamt1=""+bamtht.get(rs.getString(1));
	if(bamt1!=null && !bamt1.equals("null")  && !bamt1.equals("")){}else{bamt1="0";} 
	String vno=""+vnoht.get(rs.getString(1));
	if(vno!=null && !vno.equals("null")  && !vno.equals("")){}else{vno="0";} 
   String vamt=""+vamtht.get(rs.getString(1));
	if(vamt!=null && !vamt.equals("null")  && !vamt.equals("")){}else{vamt="0";} 


	%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue align="right"><%=mcount%></td>
<td class=rptValue align="right"><%=bno%></td>
<td class=rptValue align="right"><%=bamt1%></td>
<td class=rptValue align="right"><%=vno%></td>
<td class=rptValue align="right"><%=vamt%></td>

</tr>
<%
tmcount+=Integer.parseInt(mcount);
tbillno+=Integer.parseInt(bno);
tvno+=Integer.parseInt(vno);
tbamt+=(new Double(bamt1)).longValue();
tvamt+=(new Double(vamt)).longValue();

} 
%>
<tr>
<td colspan=3 align="center" class=btext>Total</td>
<td class=btext align="right"><%=tmcount%></td>
<td class=btext align="right"><%=tbillno%></td>
<td class=btext align="right"><%=tbamt%></td>
<td class=btext align="right"><%=tvno%></td>
<td class=btext align="right"><%=tvamt%></td>
</table>

