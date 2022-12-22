
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
try{
String workid=request.getParameter("workid");
String type=request.getParameter("type");
stmt=conn.createStatement();
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptValue>Bills For the Work Id:&nbsp;<%=workid%></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" >

<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Bill No</td>
			<td class=btext>Bill Date</td>
			<td class="btext">Bill Amount <BR>(In Rupees)<font color=red>*</font></td>
			<td class="btext">Bill Amount<br>Admissable<font color=red>*</font></td>
</tr>

<%
int count=0;
String qry="select WORK_ID,BILL_SL_NO,BILL_NO,to_char(BILL_DATE,'dd/mm/yyyy'),BILL_AMT_CONTRACTOR ,BILL_AMT_ADMISSIBLE  from rws_work_bill_tbl where work_id='"+workid+"' and bill_type='"+type+"' order by 2";
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>
</tr>
<% } 
}catch(Exception e){
e.printStackTrace();
}
%>
</table>