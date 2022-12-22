<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
String pmode=request.getParameter("paymode");
		//System.out.println("program name:"+pmode);

%>
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
<h4>State Share Payment Report</h4>
<table border = 0 width="600px">	
		<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				 <td class="bwborder"><a href="./rws_bill_pao_xls.jsp?paymode=<%=pmode%>">Excel|</a></td>
			</tr>
		</table>
	</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">
	<tr>
		<td class="textborder" align="left">Select Payment Type<span class="mandatory">*</span></td>
		<td><select name="paymode" style="width:150px" class="mycombo">
		<option value="">-Select-</option>
		<%try{
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select  distinct payment_mode,decode(payment_mode,'1','PAO','2','Saving Bank A/C','3','PD A/C') AS pname from rws_bill_pao_settlement_tbl");
		while(rs.next())
		{		
				if(pmode!=null && pmode.equals(rs.getString(1))) 
			 {
			%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
			<%}
			else
				{
			 %>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
			<%}
				
		}}catch(Exception e)
		{
		System.out.println("Error:"+e);
		}%>
		</select>
		</td>
	</tr>
	<tr>
	<td colspan="2" align=center>
	<input type="button" value="Get Report" onclick="fnGet()" class="btext">
	</td>
	</tr>
</table>
<br>
<%if(pmode!=null && !pmode.equals(""))
{
%>
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
</form>
<%}%>

</table>


