<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%
  String datew=request.getParameter("datewise");
  Statement stmt1=conn.createStatement();
  ResultSet rs1=null;
  String qry1="";
  String div="",cir="";
if(request.getParameter("division")!=null && !request.getParameter("division").equals(""))
  {
	String cirdiv=request.getParameter("division");
	div=cirdiv.substring(2,3);
	cir=cirdiv.substring(0,2);
  }
else
  {
		String cirdiv=request.getParameter("division");
		if(cirdiv!=null && !cirdiv.equals("")){
		div=cirdiv.substring(2,3);
		cir=cirdiv.substring(0,2);}
   }
%>
<table>
<tr><td class=btext>Bill Wise Releases - State </td></tr></table>
<table border = 0 cellspacing = 0 cellpadding = 0 width=80%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder"><a href="#" onclick="javascript:history.go(-1)">Back</a>|<a href="../home.jsp">Home</a>|<a href="./rws_bankwise_state_xls.jsp?datewise=<%=datew%>&cir=<%=cir%>&div=<%=div%>" target=_new>Excel</a>
			</td>
		</tr>
</table>
</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr><td align="center" class=btext>Date :<font face="verdana" size=2 color="green"><%=datew%></font></td></tr>
<%
/*String qry="select distinct division_office_name,txid,txid_div,office_code,amount_released,to_char(SEND_DATE,'dd/mm/yyyy'),circle_office_code, division_office_code,programme_name,programme_code from rws_bill_pao_settlement_tbl a,rws_complete_office_view v,rws_programme_tbl p where substr (office_code,2,2) =v.circle_office_code and substr(office_code,4,1)=v.division_office_code and to_char(SEND_DATE,'dd/mm/yyyy')='"+datew+"'  and  p.programme_name =a.grant_name ";*/
//updated by swapna on 15-09-2011 for programme_code updation
String qry="select distinct division_office_name,txid,txid_div,office_code,amount_released,to_char(SEND_DATE,'dd/mm/yyyy'),circle_office_code, division_office_code,grant_name,programme_code from rws_bill_pao_settlement_tbl a,rws_complete_office_view v where substr (office_code,2,2) =v.circle_office_code and substr(office_code,4,1)=v.division_office_code and to_char(SEND_DATE,'dd/mm/yyyy')='"+datew+"' ";

 if(cir!=null && !cir.equals("") && div!=null && !div.equals(""))
 {
	 qry+= "  and  substr (office_code,2,2) ='"+cir+"' and  substr (office_code,4,1)='"+div+"' "; 
 }
 qry+=" order by txid,circle_office_code,division_office_code "; 
 //System.out.println("qry:"+qry);
int count=0;
double gtot=0;
int count1=0;

stmt=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=stmt.executeQuery(qry);

double amt=0.0;
if(rs.isBeforeFirst())
{
rs.next();
String prevgtid="";
String gtid=rs.getString(2);
%>
<td bgcolor="green"><font color="white" face="verdana" size="2"><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%></B></font>
</td>
<%
rs.previous();

while(rs.next())
{
	if(gtid.equals(rs.getString(2))){%>
	<tr><td class=btext colspan=4><%=++count%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp;&nbsp; TransactionId:<%=rs.getString(3)%>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;  Grant Name:<%=rs.getString("grant_name")%></td></tr>
   <%
	}else{
	 if(!prevgtid.equals(rs.getString(2))){	
		 %>
<tr><td bgcolor="green"><font color="white" face="verdana" size="2"><B>Group TransactionId:&nbsp;&nbsp;<%=rs.getString(2)%>
</B></font></td></tr>
<%
	 } else{}%>
	<tr><td class=btext colspan=4><%=++count1%>.Division:<%out.println(rs.getString(1));%>&nbsp;&nbsp;&nbsp; &nbsp; TransactionId:<%=rs.getString(3)%>&nbsp;&nbsp;&nbsp;&nbsp;  Grant Name:<%=rs.getString("grant_name")%></td></tr>
   
	<% }%>
   <tr>
   <td>
   <table border=1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
	  <tr>
	   <td class=rptvalue width="15%" align="center"><font color="red">Work Id</font></td>
	   <td class=rptvalue width="50%" align="center"><font color="red">Work Name</font></td>
	   <td class=rptvalue width="15%" align="center"><font color="red">Bill No</font></td>
	   <td class=rptvalue width="10%" align="center"><font color="red">BMS TR NO</font></td>
	   <td class=rptvalue width="20%" align="center"><font color="red">Bill Amount  Processed<br>(In Rupees)</font></td>
	</tr>
      
<%

//System.out.println("kkkkkkkkkk");
//this query is updated by swapna on 15112011 compared programecode with workid  insted of comparing programecode in workadmin table
qry1="select a.work_id,work_name,bill_no,bill_amout_state,bill_activation_flag,nvl(BMS_TR_NO,'-') from rws_bill_pao_bridge_det_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and c.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and state_txid='"+rs.getString(2)+"'   and  substr (a.office_code,2,2) ='"+rs.getString("circle_office_code")+"' and  substr (a.office_code,4,1)='"+rs.getString("division_office_code")+"'   and substr(a.work_id,1,2)='"+rs.getString("programme_code")+"' "; 
//and programme_code='"+rs.getString("programme_code")+"' 
//System.out.println("qry1:"+qry1);
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
 {%>
    <tr>
	    <td class=rptvalue><%=rs1.getString(1)%></td>
		<td class=rptvalue><%=rs1.getString(2)%></td>
		<td class=rptvalue><%=rs1.getString(3)%></td>
		<td class=rptvalue><%=rs1.getString(6)%></td> 
		<td class=rptvalue align="right"><%=rs1.getString(4)%></td>
		
	</tr>
  <%
   amt=amt+rs1.getDouble(4);	
  }%>
<tr>
<td class=btext colspan=4 align="center">Total:</td><td align="right" class=btext><%=amt%></td>
</tr>
</td>
</tr>
</table>
<%
 gtot=gtot+amt;	
  prevgtid=rs.getString(2);
}}%>
</td>
</tr>
<tr><td class=btext align="right">Grand Total:&nbsp;&nbsp;&nbsp;&nbsp; <%=Math.round(gtot)%></td></tr>
</table>



