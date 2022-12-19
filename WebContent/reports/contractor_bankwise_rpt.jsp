<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>


<%
DecimalFormat ndf = new DecimalFormat("####.00");
  String datew=request.getParameter("datewise");
  String con=request.getParameter("contractor");
  Statement stmt1=conn.createStatement();
  ResultSet rs1=null;
  String qry1="";
%>
<table>
<tr><td class=btext>Bill Wise Releases - Contractor </td></tr></table>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>|<a href="./contractor_bankwise_xls.jsp?datewise=<%=datew%>&contractor=<%=con%>" target=_new>Excel</a>
			</td>
		</tr>
</table>
</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr><td align="center" class=btext>Date :<font face="verdana" size=2 color="green"><%=datew%></font></td></tr>
<%
String qry="select contractor_name_company,a.TXID_CONTRACTOR ,a.contractor_code from rws_contractor_settlement_tbl a,rws_contractor_tbl c where a.contractor_code=c.contractor_code";

if(con!=null && !con.equals(""))
{
	qry+=" and a.contractor_code='"+con+"'";
}
System.out.println("qry:"+qry);
int count=0;
double gtot=0.0;
int count1=0;
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
//rs.next();
%>
<!--  <td bgcolor="green"><font color="white" face="verdana" size="2"><B>Group TransactionId:&nbsp;&nbsp;</B></font></td> -->
<%
while(rs.next())
{
%> 
 <tr><td class=btext colspan=4><%=++count%>.Contractor Name:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp;TransactionId:<%=rs.getString(2)%>&nbsp;</td></tr>
  <tr>
   <td>
   <table border=1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
	   <td class=rptvalue width="15%" align="center"><font color="red">Work Id</font></td>
	   <td class=rptvalue width="50%" align="center"><font color="red">Work Name</font></td>
	   <td class=rptvalue width="15%" align="center"><font color="red">Bill No</font></td>
	   <td class=rptvalue width="20%" align="center"><font color="red">Bill Amount  Processed<br>(In Rupees)</font></td>
	</tr>
 <%
double amt=0.0;
 qry1="select b.WORK_ID,WORK_NAME,BILL_SL_NO,BILL_AMOUNT_CENTRAL from rws_contractor_settlement_tbl a,rws_bill_bank_bridge_det_tbl b,rws_work_admn_tbl c,rws_contractor_selection_tbl d  where a.TXID_CONTRACTOR=b.TXID and b.work_id=c.work_id and a.contractor_code='"+rs.getString(3)+"' and  d.contractor_code=a.contractor_code and c.work_id=d.work_id";
 rs1=stmt1.executeQuery(qry1);
 System.out.println("qry1:"+qry1);
 boolean cFlag=false;
 while(rs1.next())
 {
	 cFlag=true;
 %>
     <tr>
 	    <td class=rptvalue><%=rs1.getString(1)%></td>
 		<td class=rptvalue><%=rs1.getString(2)%></td>
 		<td class=rptvalue align="right"><%=rs1.getString(3)%></td>
 		<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
 		
 	</tr>
 <%
   amt+=rs1.getDouble(4);
  }
  
  
  if(!cFlag){
	  
	   amt=0.0;
	  qry1="select b.WORK_ID,WORK_NAME,BILL_SL_NO,BILL_AMOUNT_CENTRAL from rws_contractor_settlement_tbl a,rws_bill_bank_bridge_det_tbl b,rws_work_admn_tbl c,rws_work_contractor_map_tbl d  where a.TXID_CONTRACTOR=b.TXID and b.work_id=c.work_id and a.contractor_code='"+rs.getString(3)+"' and  d.contractor_code=a.contractor_code and c.work_id=d.work_id";
	  rs1=stmt1.executeQuery(qry1);
	  System.out.println("qry1:"+qry1);
	 
	  while(rs1.next())
	  {
	 	
	  %>
	      <tr>
	  	    <td class=rptvalue><%=rs1.getString(1)%></td>
	  		<td class=rptvalue><%=rs1.getString(2)%></td>
	  		<td class=rptvalue align="right"><%=rs1.getString(3)%></td>
	  		<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
	  		
	  	</tr>
	  <%
	    amt+=rs1.getDouble(4);
	   }
  }
  
  %>
  
  
 <tr>
 <td class=btext colspan=3 align="center">Total:</td><td align="right" class=btext><%=ndf.format(amt)%></td>
 </tr>
 </td>
 </tr>
 </table>
 <%
  gtot=gtot+amt;
}
 %>
 </td>
 </tr>
 <tr><td class=btext align="right">Grand Total:&nbsp;&nbsp;&nbsp;&nbsp; <%=ndf.format(gtot)%></td></tr>
 </table>


 
 
 