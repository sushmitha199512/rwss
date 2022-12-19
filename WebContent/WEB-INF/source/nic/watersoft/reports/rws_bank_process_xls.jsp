<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
  String datew=request.getParameter("datewise");
  Statement stmt1=conn.createStatement();
  ResultSet rs1=null;
  String qry1="";
  String div=request.getParameter("div");
  String cir=request.getParameter("cir");
%>
<table>
<tr><td class=btext>Bank Wise Releases - Central</td></tr></table>
<tr><td align="center" class=btext>Date :<font face="verdana" size=2 color="green"><%=datew%></font></td></tr>
<%String qry="select distinct division_office_name,txid,txid_div,office_code,bill_amount_central from rws_bill_bank_settlement_tbl a,rws_complete_office_view v where substr (office_code,2,2) =v.circle_office_code and substr(office_code,4,1)=v.division_office_code and to_char (processed_start_date,'dd/mm/yyyy')='"+datew+"' and bill_activation_flag='P'  ";
 if(cir!=null && !cir.equals("") && div!=null && !div.equals(""))
 {
	 qry+= "  and  substr (office_code,2,2) ='"+cir+"' and  substr (office_code,4,1)='"+div+"' "; 
 }
 qry+=" order by txid,txid_div ";
int count=0;
long gtot=0;
int count1=0;
stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);

rs=stmt.executeQuery(qry);
rs.next();
String prevgtid="";
String gtid=rs.getString(2);
%>
<tr><td><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%></B>
</td></tr><br>
<%
rs.previous();
while(rs.next())
{
	if(gtid.equals(rs.getString(2))){%>
	<tr><td class=btext colspan=4><%=++count%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp;TransactionId:<%=rs.getString(3)%>&nbsp;</td></tr>
   <%
	}else{
	 if(!prevgtid.equals(rs.getString(2))){	
		 %>
<tr><td><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%>
</B></td></tr><br>
<%
	 } else{}%>
	<tr><td class=btext colspan=4><%=++count1%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp; TransactionId:<%=rs.getString(3)%>&nbsp;</td></tr>
   
	<% }
		

		%>
   <tr>
   <td>
   <table border=1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
	   <td class=rptvalue width="15%" align="center"><font color="red">Work Id</font></td>
	   <td class=rptvalue width="50%" align="center"><font color="red">Work Name</font></td>
	   <td class=rptvalue width="15%" align="center"><font color="red">Bill No</font></td>
	   <td class=rptvalue width="20%" align="center"><font color="red">Bill Amount  Processed<br>(In Rupees)</font></td>
	</tr>
      
<%

long amt=0;
qry1="select a.work_id,work_name,bill_no,bill_amount_central,bill_activation_flag from rws_bill_bank_bridge_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and txid='"+rs.getString(2)+"'   and a.office_code='"+rs.getString(4)+"' ";
//System.out.println("qry1:"+qry1);
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{%>
    <tr>
	    <td class=rptvalue>&nbsp;<%=rs1.getString(1)%></td>
		<td class=rptvalue><%=rs1.getString(2)%></td>
		<td class=rptvalue><%=rs1.getString(3)%></td>
		<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
		
	</tr>
<%
  amt+=rs1.getInt(4);	
}%>
<tr>
<td class=btext colspan=3 align="center">Total:</td><td align="right" class=btext><%=amt%></td>
</tr>
</td>
</tr>
</table>
<%
 gtot+=amt;	
	prevgtid=rs.getString(2);
}%>
</td>
</tr>
<tr><td class=btext align="right">Grand Total:&nbsp;&nbsp;&nbsp;&nbsp; <%=gtot%></td></tr>
</table>



