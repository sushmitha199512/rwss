<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@ page import="java.util.*"%>
<%
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
	DecimalFormat ndf = new DecimalFormat("####.00");
 String dcode=request.getParameter("district");
 String cat=request.getParameter("program");
 String divcode=request.getParameter("division");
 String year=request.getParameter("year");
  String dname=request.getParameter("dname");
 String catname=request.getParameter("pname");
 String divname=request.getParameter("divname");
 String yname=request.getParameter("yname");
//System.out.println("d"+dcode);
//System.out.println("div"+divcode);
//System.out.println("cat"+cat);
//System.out.println("year"+year);
%>
<html>
<body>

<table border = 0 align="right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder" nowrap>
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					</td>
				</tr>
			</table>
		</caption>
		</table>
<table align="center">
<tr><td  class=btext>District:&nbsp;<font color=black><%=dname%></font>&nbsp;&nbsp;&nbsp;Division:&nbsp;<font color=black><%=divname%></font>&nbsp;&nbsp;&nbsp;Work Category:&nbsp;<font color=black><%=catname%></font>&nbsp;&nbsp;&nbsp;Financial year&nbsp;<font color=black><%=yname%></font>&nbsp;</td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
	<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Program</td>
			<td class=btext>Sub Program</td>
			<td class=btext>Adminstrative No</td>			
			<td class=btext>Admin Sanction Date</td>
			<td class=btext>Sanction Amount</td>
			<td class=btext>Contractor Agreement Value</td>
			<td class=btext>Bill Amount</td>
			<td class=btext>Voucher Amount</td>
	  </tr>

<%

Hashtable ht=new Hashtable();
Hashtable ht1=new Hashtable();
Hashtable ht2=new Hashtable();
String qry1="select nvl(sum(BILL_AMT_CONTRACTOR),0),a.work_id from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
stmt1=conn.createStatement();
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
  ht.put(rs1.getString(2),rs1.getString(1));
}
String qry2="select nvl(sum(AGREEMENT_VALUE),0),a.work_id from rws_contractor_selection_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
stmt2=conn.createStatement();
rs2=stmt2.executeQuery(qry2);
while(rs2.next())
{
  ht1.put(rs2.getString(2),rs2.getString(1));
}
String qry3="select nvl(sum(VOUCHER_AMT),0),a.work_id from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id  ";
stmt3=conn.createStatement();
rs3=stmt3.executeQuery(qry3);
while(rs3.next())
{
  ht2.put(rs3.getString(2),rs3.getString(1));
}
long tbamt=0,tvamt=0,tsamt=0;
double tcamt=0.0;
int count=0;
String qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount*100000,programme_name,subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s  where a.programme_code=p.programme_code and a.subprogramme_code=s.subprogramme_code and p.programme_code=s.programme_code and  substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"' and category_code='"+cat+"' and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"' "; 
System.out.println("qryqqqqqq"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
	String bamt=""+ht.get(rs.getString(1));
	if(bamt!=null  && !bamt.equals("")  && !bamt.equals("null")){}else{ bamt="0";}
	String camt=""+ht1.get(rs.getString(1));
	//System.out.println(camt+"-"+rs.getString(1));
	if(camt!=null  && !camt.equals("")  && !camt.equals("null")){}else{ camt="0";}
	String vamt=""+ht2.get(rs.getString(1));
	if(vamt!=null  && !vamt.equals("")  && !vamt.equals("null")){}else{ vamt="0";}
	
	%>
  <tr>
		  <td class=rptvalue><%=++count%></td>
		  <%if(Long.parseLong(rs.getString(5)) < Long.parseLong(bamt)){%>
		  <td class=rptvalue nowrap><font color=red><%=rs.getString(1)%></font></td>
		  <%}else {%>
			<td class=rptvalue nowrap><%=rs.getString(1)%></td>
		  <%}%>
		  <td class=rptvalue nowrap><%=rs.getString(2)%></td>
		  <td class=rptvalue nowrap><%=rs.getString("programme_name")%></td>
		  <td class=rptvalue nowrap><%=rs.getString("subprogramme_name")%></td>
		  <td class=rptvalue nowrap><%=rs.getString(3)%></td>
		  <td class=rptvalue nowrap><%=rs.getString(4)%></td>
		  <td class=rptvalue nowrap align=right><b style="font-family: Rupee Foradian;">`</b><%=rs.getString(5)%></td>
		  <td class=rptvalue nowrap align=right><b style="font-family: Rupee Foradian;">`</b><%=camt%></td>
		  <td class=rptvalue nowrap align=right><b style="font-family: Rupee Foradian;">`</b><%=bamt%></td>
		  <td class=rptvalue nowrap align=right><b style="font-family: Rupee Foradian;">`</b><%=vamt%></td>
	 </tr>
<%
	tbamt+=Long.parseLong(bamt);
	//System.out.println((new Double(Double.parseDouble(camt))));
	tcamt+=(new Double(Double.parseDouble(camt)));
	tvamt+=Long.parseLong(vamt);;
	tsamt+=Long.parseLong(rs.getString(5));
	} %>
<tr>
<td class=btext colspan="7" align="center">Total</td>
<td class=rptValue align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(tsamt)%></td>
<td class=rptValue align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(tcamt)%></td>
<td class=rptValue align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(tbamt)%></td>
<td class=rptValue align="right"><b style="font-family: Rupee Foradian;">`</b><%=ndf.format(tvamt)%></td>
</tr>
 </table>
<%@ include file = "footer.jsp" %>
 </body>
</html>