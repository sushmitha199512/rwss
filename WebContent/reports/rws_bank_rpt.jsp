<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
String sdate=request.getParameter("sentdate");
String pmode=request.getParameter("activation");
String tid=request.getParameter("tid");

		//System.out.println(" send  date:"+sdate);

%>
<html xmlns="http://www.w3.org/1999/xhtml">

<script language="javascript">

function fnGet()
{
		if(document.f1.sentdate.value=="")
			alert("Please Select Date");
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
<h4>Bank Payment Report</h4>
<table border = 0 width="600px">	
		<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
			    <td class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|</a></td>
				 <td class="bwborder"><a href="./rws_bank_xls.jsp?sdate1=<%=sdate%>&pmode=<%=pmode%>&tid=<%=tid%>">Excel|</a></td>
			</tr>
		</table>
	</caption>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">
		<tr>
<td class="textborder" align="left">Select Date <span class="mandatory">*</span></td>
		<td><select name="sentdate" style="width:150px" class="mycombo" onchange="forms[0].submit()">
		<option value="">-Select-</option>
		<%try{
			Statement stmt1 = conn.createStatement();
			String qq="select  distinct to_char(send_date,'dd/mm/yyyy') from RWS_BILL_bank_SETTLEMENT_TBL order by 1";
			ResultSet rs1 = stmt1.executeQuery(qq);
			//System.out.println("q:"+qq);
		while(rs1.next())
		{	
				if(sdate!=null && sdate.equals(rs1.getString(1))) 
			 {
			%>
				<option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(1)%></option>
			<%}
			else
				{
			 %>
				<option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
			<%}
		}}catch(Exception e)
		{
		System.out.println("Error:"+e);
		}%>
		</select>
		</td>
	</tr>
		
	<tr>
		<td class="textborder" align="left">Select Activation Flag</td>
		<td><select name="activation" style="width:150px" class="mycombo" onchange="forms[0].submit()">
		<option value="">-Select-</option>
		<%try{
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select  distinct BILL_ACTIVATION_FLAG  ,decode(BILL_ACTIVATION_FLAG  ,'I','Initialized','P','Processed','R','Rejected') AS pname from rws_bill_bank_settlement_tbl where to_char(send_date,'dd/mm/yyyy')='"+sdate+"' ") ;
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
<td class="textborder" align="left">Select Transaction Id </td>
		<td><select name="tid" style="width:150px" class="mycombo" >
		<option value="">-Select-</option>
		<%try{
			Statement stmt2 = conn.createStatement();
			String qq1="select distinct txid from RWS_BILL_bank_SETTLEMENT_TBL  where  to_char(send_date,'dd/mm/yyyy')='"+sdate+"'  and BILL_ACTIVATION_FLAG ='"+pmode+"' order by 1";
			ResultSet rs2 = stmt2.executeQuery(qq1);
			//System.out.println("q:"+qq1);
		while(rs2.next())
		{	
				if(tid!=null && tid.equals(rs2.getString(1))) 
			 {
			%>
				<option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(1)%></option>
			<%}
			else
				{
			 %>
				<option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
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
<table><tr><td class="rptHeading" style="width:2500" align="right">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)</font><b style="font-family: Rupee Foradian;">`</b></td></tr></table>

<%if((sdate!=null && !sdate.equals("")) && (pmode!=null && !pmode.equals("")) && (tid!=null && !tid.equals("")))
{
%>
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
<td class="rptvalue"><%=rs5.getString(2)%></td>
<td class="rptvalue"><%=rs5.getString(3)%></td>
<td class="rptvalue"><%=rs5.getString(4)%></td>
<td class="rptvalue"><%=rs5.getString(5)%></td>
<td class="rptvalue"><%=rs5.getString(6)%></td>
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


