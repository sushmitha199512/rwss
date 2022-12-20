<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<script language="javascript">
function fnGet()
{
		if(document.f1.paymode.value=="")
			alert("Please Select Payment Type");
		else
		{
			document.f1.submit();
		}
}
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
String pmode=request.getParameter("paymode");
String pname="";
//System.out.println("program namegggggggggg:"+pmode);
if(pmode.equals("1"))
{
pname="PAO";
}
else if(pmode.equals("2"))
pname="Saving Bank A/C";
else if(pmode.equals("3"))
pname="PD A/C";

if(pmode!=null && !pmode.equals(""))
{
	%>
	<table><tr align="center" class="btext"><td align="center" colspan="8"><h4>State Share Payments<h4></td></tr>
	<tr align="right"><td  class="btext" colspan="2">Payment Mode:<font color="black"><%=pname%></font></td></tr>
<table id="tbl" border = 1 align=center bordercolor=navy style="border-collapse:collapse">
		
		<tr align="center">
			<td class=btext>Sl.No</td>
			<td class=btext>TransactionId</td>
			<td class=btext>Circle</td>
			<td class=btext>Division</td>
			<td class=btext>Grant</td>
			<td class=btext>Amount</td>
			<td class=btext>Date</td>
		</tr>
<%
try
{
	Statement st5=conn.createStatement();
	ResultSet rs5=null;
String q="select txid,txid_div,dname,division_office_name,grant_name,amount_released,to_char(send_date,'dd/mm/yyyy') from rws_bill_pao_settlement_tbl p,rws_district_tbl a,rws_division_office_tbl b where payment_mode='"+pmode+"' and a.dcode=b.CIRCLE_OFFICE_CODE and b.DIVISION_OFFICE_CODE =substr(p.office_code,4,1)  and a.dcode=substr(p.office_code,2,2)";
//System.out.println("query:"+q);
rs5=st5.executeQuery(q);
int count=1;
double total=0.0;
while(rs5.next())
	{
		%>
	<tr>
<td class="rptvalue"><%=count++%></td>
<td class="rptvalue"><%=rs5.getString(1)%></td>
<td class="rptvalue"><%=rs5.getString(3)%></td>
<td class="rptvalue"><%=rs5.getString(4)%></td>
<td class="rptvalue"><%=rs5.getString(5)%></td>
<td class="rptvalue"><%=rs5.getString(6)%></td>
<td class="rptvalue"><%=rs5.getString(7)%></td>
</tr>
<%
	total=total+rs5.getDouble(6);	
}
%>
<tr><td colspan="5" class="btext" align="right">Total</td><td class="rptvalue"><%=Math.round(total)%></td></tr>
<%
}
catch(Exception e)
{
	System.out.println("Error in report page:"+e);
}%>

<%}%>
</form>
</table>


