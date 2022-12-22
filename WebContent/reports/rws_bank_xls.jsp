

<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

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
</script>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/table.css'/>">
<body  bgcolor="#edf2f8">
<form name=f1>
<table>
<%

String sdate=request.getParameter("sdate1");
String pmode=request.getParameter("pmode");
String tid=request.getParameter("tid");
String pname="";
//System.out.println("program namegggggggggg:"+pmode);
if(pmode.equals("O"))
{
pname="Operational";
}
else if(pmode.equals("P"))
{
pname="Processed";
}
else if(pmode.equals("R"))
{
pname="Rejected";
}
if((sdate!=null && !sdate.equals(""))  && (tid!=null && !tid.equals("")))
{
%>
<table><tr align="center" class="btext"><td align="center" colspan="8"><h4>Bank Payments<h4></td></tr>
<%if(pmode!=null && !pmode.equals(""))
	{%>
	<tr align="right"><td  class="btext" colspan="2">Activation Flag:<font color="black"><%=pname%></font></td></tr>
	<%}%>
	<tr align="right"><td  class="btext" colspan="2">Date:<font color="black"><%=sdate%></font></td></tr>
<table id="tbl" border = 1 align=center bordercolor=navy style="border-collapse:collapse" width="70%" >
		
		<tr align="center">
			<td class=btext>Sl.No</td>
			<td class=btext>Group TransactionId</td>
			<td class=btext>TransactionId</td>
			<td class=btext>Circle</td>
			<td class=btext>Division</td>
			<td class=btext>Date</td>
			<td class=btext>Account No</td>
			<td class=btext>Amount</td>
			
		</tr>
<%
try
{
			//System.out.println("in program3");
	Statement st5=conn.createStatement();
	ResultSet rs5=null;
String q="select txid,txid_div,dname,division_office_name,to_char(send_date,'dd/mm/yyyy'),ACCOUNT_NO   ,BILL_AMOUNT_CENTRAL from rws_bill_bank_settlement_tbl p,rws_district_tbl a,rws_division_office_tbl b where a.dcode=b.CIRCLE_OFFICE_CODE and b.DIVISION_OFFICE_CODE =substr(p.office_code,4,1)  and a.dcode=substr(p.office_code,2,2) and to_char(send_date,'dd/mm/yyyy')='"+sdate+"' ";
if(pmode!=null && !pmode.equals(""))
	{
	q+= " and BILL_ACTIVATION_FLAG  ='"+pmode+"' ";
}
if(tid!=null && !tid.equals(""))
	{
	q+= " and txid  ='"+tid+"' ";
}
q+=" order by  txid,txid_div";
//System.out.println("query:"+q);
rs5=st5.executeQuery(q);
int count=1;
double total=0.0;
String gtxidValueOld = "",gtxidValue="";
//System.out.println("in program4");
while(rs5.next())
	{
	
 gtxidValue = ""+rs5.getString(1);
     
		%>
	<tr width="200%" height="80%">
<td class="rptvalue" align="center" ><%=count++%></td>
<%if(!gtxidValue.equals(gtxidValueOld)){
   %>
<td class="rptvalue"><%=rs5.getString(1)%></td>
<%}else{
        %>
<td  class=rptValue nowrap>&nbsp;</td>
<%}%>
<td class="rptvalue">&nbsp;<%=rs5.getString(2)%></td>
<td class="rptvalue"><%=rs5.getString(3)%></td>
<td class="rptvalue"><%=rs5.getString(4)%></td>
<td class="rptvalue"><%=rs5.getString(5)%></td>
<td class="rptvalue">&nbsp;<%=rs5.getString(6)%></td>
<td class="rptvalue" align="right"><%=rs5.getString(7)%></td>
<%
	gtxidValueOld = gtxidValue;
%>
</tr>
<%
	total=total+rs5.getDouble(7);	
}
%>
<tr><td colspan="7" class="btext" align="right">Total</td><td class="rptvalue" align="right"><%=Math.round(total)%></td></tr>
<%	
}
catch(Exception e)
{
	System.out.println("Error in report page:"+e);
}%>
</form>
<%}%>

</table>


