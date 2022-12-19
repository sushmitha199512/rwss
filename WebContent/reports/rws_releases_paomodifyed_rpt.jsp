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
			<td class=btext>WORK_ID.</td>
<td class=btext>WORK_NAME.</td>

<td class=btext>PROGRAMME_NAME.</td>
<td class=btext>SUBPROGERMME_NAME.</td>
			<td class=btext>BILL_SL_NO</td>
			<td class=btext>BILL_DATE	</td>
			<td class=btext>TOTAL_ BILL_AMOUNT </td>
<td class=btext>%</td>

			</tr>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
int count=0;
String qry = "";

//qry="select  distinct  work_id,bill_sl_no,to_char(state_send_date,'dd-mm-yyyy'),nvl(BILL_AMOUT_STATE,0) from rws_bill_pao_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null and substr(office_code,2,3)='"+dcode+""+divcode+"'"; 

//qry="select  distinct  work_id,bill_sl_no,to_char(state_send_date,'dd-mm-yyyy'), nvl(BILL_AMOUT_STATE,0) from rws_bill_pao_bridge_det_tbl a where a.bill_sl_no<>'0' and a.office_code is not null and substr(office_code,2,3)='"+dcode+""+divcode+"' and (to_char(state_send_date,'yy')='"+fyear+"' and substr(to_char(state_send_date,'dd-mm-yy'),4,2)>='03' or to_char(state_send_date,'yy')='"+fyear1+"' and substr(to_char(state_send_date,'dd-mm-yy'),4,2)<='04')";

qry="select  distinct  a.work_id,b.work_name,p.programme_name,sp.subprogramme_name,a.bill_sl_no,to_char(state_send_date,'dd-mm-yyyy'), nvl(BILL_AMOUT_state,0) from rws_bill_pao_bridge_det_tbl a ,rws_work_admn_tbl b ,rws_programme_tbl p, rws_subprogramme_tbl sp where b.programme_code=p.programme_code and (b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code) and a.work_id=b.work_id  and a.office_code is not null and substr(a.office_code,2,3)='"+dcode+""+divcode+"' and (to_char(state_send_date,'yy')='"+fyear+"' and substr(to_char(state_send_date,'dd-mm-yy'),4,2)>='03' or to_char(state_send_date,'yy')='"+fyear1+"' and substr(to_char(state_send_date,'dd-mm-yy'),4,2)<='04')";

//System.out.println("qr5555555555y:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
while(rs.next())
{
	ddd += rs.getDouble(7);
		
	%>
<tr>
<td class=rptValue><%=sno++%></td>
<!--<td class=rptValue><%=++count%></td>-->
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>

<td class=rptValue align="right"><%=rs.getString(7)%></td>


<td class=rptValue align="right"><%=ndf.format(rs.getDouble(7)/100000)%></td>
</tr>
<% } 
%> 
<tr>
<td class=rptHeading colspan="7" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
</tr>
</table>