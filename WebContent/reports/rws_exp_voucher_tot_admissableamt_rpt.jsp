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
String value=divcode+dcode;
String fyear=(String)session.getAttribute("sfyear");
//System.out.println("session fyear:::::::::"+fyear);
String fyear1=(String)session.getAttribute("sfyear1");
//System.out.println("session fyear1:::::::::"+fyear1);
ResultSet rs1=null;
String pQry = "";
if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ('02','01','48','32','23','49','51','18','37','60')";
stmt=conn.createStatement();
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
      <td class=btext>SLNO.</td>
			<td class=btext>WORK_ID.</td>
            <td class=btext>WORK_NAME</td>
			<td class=btext>PROGRAMME_NAE</td>
			<td class=btext>SUBPROGRAMME_NAME  </td>
			<td class=btext>BILL_SL_NO</td>
			<td class=btext>BILL_NO</td>
			<td class=btext>BILL_DATE  </td>
			<td class=btext>BILL_AMT_ADMISSIBLE  </td>
<td class=btext>% </td>
</tr>

<%
DecimalFormat ndf = new DecimalFormat("####.00");
int count=0;
String qry = "";

//qry = " select a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,a.bill_no,to_char(bill_date,'dd-mm-yy'),bill_amt_admissible from rws_work_bill_tbl a,rws_work_admn_tbl b ,rws_programme_tbl p, rws_subprogramme_tbl sp where  b.programme_code=p.programme_code and (b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code) and  a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+divcode+"'  and bill_sl_no<>'0' and EE_FWD_DATE is not null and(to_char(BILL_DATE,'yy')='"+fyear+"' and substr(to_char(BILL_DATE,'dd-mm-yy'),4,2)>='03'or to_char(BILL_DATE,'yy')='"+fyear1+"' and substr(to_char(BILL_DATE,'dd-mm-yy'),4,2)<='04')" +pQry;




qry="select a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,a.bill_no,to_char(bill_date,'dd-mm-yy'),bill_amt_admissible from rws_work_bill_tbl a,rws_work_admn_tbl b ,rws_programme_tbl p, rws_subprogramme_tbl sp where  b.programme_code=p.programme_code and (b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code) and  a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+divcode+"'  and bill_sl_no<>'0' and EE_FWD_DATE is not null " +pQry;


//raised que
//qry="select a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,a.bill_no,to_char(bill_date,'dd-mm-yy'),bill_amt_contractor from rws_work_bill_tbl a,rws_work_admn_tbl b ,rws_programme_tbl p, rws_subprogramme_tbl sp where b.programme_code=p.programme_code and (b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code) and a.work_id=b.work_id and substr(b.office_code,2,3)='"+dcode+divcode+"'  and bill_sl_no<>'0' and EE_FWD_DATE is not null and (to_char(BILL_DATE,'yy')='"+fyear+"' and substr(to_char(BILL_DATE,'dd-mm-yy'),4,2)>='03'or to_char(BILL_DATE,'yy')='"+fyear1+"' and substr(to_char(BILL_DATE,'dd-mm-yy'),4,2)<='04')" +pQry;

//System.out.println("qry:"+qry);
rs1=stmt.executeQuery(qry);
double ddd = 0.0;
while(rs1.next())
{
	ddd += rs1.getDouble(8);
	%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs1.getString(1)%></td>
<td class=rptValue><%=rs1.getString(2)%></td>
<td class=rptValue><%=rs1.getString(3)%></td>
<td class=rptValue><%=rs1.getString(4)%></td>
<td class=rptValue><%=rs1.getString(5)%></td>
<td class=rptValue ><%=rs1.getString(6)%></td>
<td class=rptValue ><%=rs1.getString(7)%></td>
<td class=rptValue align="right" ><%=rs1.getString(8)%></td>

<td class=rptValue align="right"><%=ndf.format(rs1.getDouble(8)/100000)%></td>
</tr>
<% } 
%> 
<tr>
<td class=rptHeading colspan="7" align="center">Total</td>
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