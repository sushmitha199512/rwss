<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String dcode=request.getParameter("dcode");
String dname=request.getParameter("dnamee");
String divcode=request.getParameter("divcode");
String divname=request.getParameter("divname");
String mode = request.getParameter("mode");
String special = request.getParameter("special");
//String value=divcode+dcode;
String fyear=(String)session.getAttribute("sfyear");
//System.out.println("session fyear:::::::::"+fyear);
String fyear1=(String)session.getAttribute("sfyear1");
//System.out.println("session fyear1:::::::::"+fyear1);

String pQry = "";
if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ('02','01','48','32','23','49','51','18','37','60')";
stmt=conn.createStatement();
int sno=1;
%>
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Releases in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%></td></tr></table><BR>

<table border = 0>	
				<tr  align="center">
			<td align="center" class="rptHeading" style="width:350"></td>
			<td class="rptHeading" style="width:500" align="right">
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)<!-- <img src="../images/smallrs.jpg" width="14" height="14"> --></font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">

   <tr align=center>  
            <td class=btext>S.No</td>
			<td class=btext>WORK_ID.</td><td class=btext>WORK_NAME.</td>
<td class=btext>PROGRAMME_NAME.</td>
<td class=btext>SUBPROGRAMME_NAME.</td>
			<td class=btext>BILL_SL_NO</td>
            <td class=btext>VOUCHER_NO</td><td class=btext>VOUCHER_DT</td>
            <td class=btext>CHEQUE_NO</td>
<td class=btext>CHEQUE_DT</td>
			<td class=btext> VOUCHER_AMT </td>
			<td class=btext> % </td>
			</tr>

<%
DecimalFormat ndf = new DecimalFormat("####.00");
int count=0;
String qry = "";

//qry="select a.work_id,a.bill_sl_no,a.voucher_no,a.cheque_no,nvl(to_char(UPDATE_DATE,'dd-mm-yyyy'),'_'),nvl(sum(voucher_amt),0),substr(b.office_code,2,3) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and BILL_SL_NO <> '0' and office_code is not null and substr(office_code,2,3)='"+dcode+""+divcode+"' and VOUCHER_DT like '%11' group by a.work_id,a.bill_sl_no,a.update_date,substr(b.office_code,2,3),a.work_id,a.bill_sl_no,a.update_date,a.voucher_no,a.cheque_no,a.work_id,a.bill_sl_no,a.update_date,a.voucher_no,a.cheque_no"; 
//voucher qry with voucher date condition
//qry="select a.work_id,a.bill_sl_no,a.voucher_no,a.cheque_no,nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+""+divcode+"' and BILL_SL_NO <> '0' and (to_char(VOUCHER_DT,'yy')='"+fyear+"' and substr(to_char(VOUCHER_DT,'dd-mm-yy'),4,2)>='03' or to_char(VOUCHER_DT,'yy')='"+fyear1+"' and substr(to_char(VOUCHER_DT,'dd-mm-yy'),4,2)<='04') group by a.work_id,a.bill_sl_no,a.voucher_no,a.cheque_no";

//voucher qry with cheque date condition
//qry="select distinct a.work_id,a.bill_sl_no,a.voucher_no,a.cheque_no,a.CHEQUE_DT,nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+""+divcode+"' and BILL_SL_NO <> '0' and (to_char(CHEQUE_DT,'yy')='"+fyear+"' and substr(to_char(CHEQUE_DT,'dd-mm-yy'),4,2)>='03' or to_char(CHEQUE_DT,'yy')='"+fyear1+"' and substr(to_char(CHEQUE_DT,'dd-mm-yy'),4,2)<='04') group by a.work_id,a.bill_sl_no,a.voucher_no,a.cheque_no,a.CHEQUE_DT";

qry="select a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,a.voucher_no,to_char(VOUCHER_DT,'dd-mm-yy'),a.cheque_no,to_char(a.CHEQUE_DT,'dd-mm-yyyy'), nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b,rws_programme_tbl p, rws_subprogramme_tbl sp where b.programme_code=p.programme_code and (b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code) and a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+""+divcode+"' and (to_char(CHEQUE_DT,'yy')='"+fyear+"' and substr(to_char(CHEQUE_DT,'dd-mm-yy'),4,2)>='03' or to_char(CHEQUE_DT,'yy')='"+fyear1+"' and substr(to_char(CHEQUE_DT,'dd-mm-yy'),4,2)<='04') group by a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,a.voucher_no,a.cheque_no,a.CHEQUE_DT,a.VOUCHER_DT";





//System.out.println("qry22222222:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
while(rs.next())
{
	ddd += rs.getDouble(10);
	
	%>
<tr>
<!-- <td class=rptValue><%=sno++%></td> -->
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>
<td class=rptValue><%=rs.getString(7)%></td>
<td class=rptValue><%=rs.getString(8)%></td><td class=rptValue><%=rs.getString(9)%></td>
<td class=rptValue align="right"><%=rs.getString(10)%></td>


<td class=rptValue align="right"><%=ndf.format(rs.getDouble(10)/100000)%></td>

</tr>
<% } 
%> 
<tr>
<td class=rptHeading colspan="10" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
</tr>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>