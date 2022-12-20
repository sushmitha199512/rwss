<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String pcode=request.getParameter("pcode");
String pname=request.getParameter("pname");
if(pname!=null && !pname.equals("02"))
{
	pname=request.getParameter("pname");
}else{
pname="20% ARWS";
}
String mode = request.getParameter("mode");
////System.out.println("11111111111111");
stmt=conn.createStatement();
////System.out.println("ffffffffffffffff");
Statement stmt1=conn.createStatement();
nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();

////System.out.println("ssssssssssssss");
%>
<table width="100%"  align="center">
<table border = 0 align="right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="javascript:window.close()">Close</a>
					</td>
				</tr>
			</table>
		</caption>
		</table>
<table align="center">

<tr><td  class=rptHeading>Releases in the Program:&nbsp;<%=pname%></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Program</td>
			<td class=btext>Sub Program</td>
			<td class=btext>Bill No</td>			
			<td class=btext>M Book No</td>			
			<td class=btext>Voucher No</td>
			<td class=btext>Voucher Date</td>
			<td class=btext>Voucher Amount</td>
			<td class=btext>Cheque No</td>			
			<td class=btext>Cheque Date</td>
			</tr>

<%
DecimalFormat ndf = new DecimalFormat("####.00");

int count=0;
String qry= "";
Hashtable ht=new Hashtable();
String qry1="select programme_name,a.work_id from rws_work_exp_voucher_tbl a,rws_work_admn_prog_lnk_tbl b,rws_programme_tbl p,rws_work_admn_tbl c where a.work_id=b.work_id and a.programme_code=b.programme_code and p.programme_code=b.programme_code and b.work_id=c.work_id and a.work_id=c.work_id ";

if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		qry1 +=" and substr(office_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		qry1+=" and  substr(office_code,4,1)='"+userid.substring(3,4)+"' ";
	}

qry1+="group by programme_name,a.work_id ";

//System.out.println("qry1:"+qry1);
ResultSet rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
  ht.put(rs1.getString(2),rs1.getString(1));
}

qry = "select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT,programme_name,subprogramme_name from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_programme_tbl p,rws_subprogramme_tbl s  where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id and c.programme_code=p.programme_code and c.subprogramme_code=s.subprogramme_code and s.programme_code=p.programme_code  and c.programme_code='"+pcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no ";
if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		qry +=" and substr(office_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		qry+=" and  substr(office_code,4,1)='"+userid.substring(3,4)+"' ";
	}

qry+="order by VOUCHER_DT desc";

 ////System.out.println("qry2:"+qry);
rs=stmt.executeQuery(qry);
String prgName="";
double ddd = 0.0;
while(rs.next())
{ 
	
	ddd += rs.getDouble(4);
	
	prgName=""+ht.get(rs.getString("work_id"));
	if(prgName!=null && !prgName.equals("null")){}else{prgName="-";}
%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("work_id")%></td>
<td class=rptValue><%=rs.getString("work_name")%></td>
<td class=rptValue><%=rs.getString("programme_name")%>/<%=prgName%></td>
<td class=rptValue><%=rs.getString("subprogramme_name")%></td>
<td class=rptValue><%=rs.getString("bill_no")%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(4)))%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>
</tr>
<% } 
%>
<tr>
<td class=rptHeading colspan="9" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
<td class=rptHeading colspan="2" align="center"></td>
</tr>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>