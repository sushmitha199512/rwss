<%System.out.println("in rpt page");%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>

<%@ include file = "conn.jsp" %>
<%@ page import="java.util.*"%>
<%

nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

DecimalFormat ndf = new DecimalFormat("####.00");
Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null;
ResultSet rs1=null,rs2=null,rs3=null,rs4=null ,rs5=null;
 String dcode=request.getParameter("district");
 String cat=request.getParameter("program");
 String divcode=request.getParameter("division");
 String year=request.getParameter("year");
System.out.println("in rpt page"+year);
  String dname=request.getParameter("dname");
 String catname=request.getParameter("pname");
 String divname=request.getParameter("divname");
// String yname=request.getParameter("yname");
System.out.println("d"+dcode);
System.out.println("div"+divcode);
System.out.println("cat"+cat);
System.out.println("year"+year);
%>
<html>
<body>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<table border = 0 align="right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
			

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>
		</table>
		
<table align="center">
<tr><td  class=btext>District:&nbsp;<font color=black><%=dname%></font>&nbsp;&nbsp;&nbsp;Division:&nbsp;<font color=black><%=divname%></font>&nbsp;&nbsp;&nbsp;Work Category:&nbsp;<font color=black><%=catname%></font>&nbsp;&nbsp;&nbsp;YEAR:&nbsp;<font color=black><%=year%></font>&nbsp;&nbsp;&nbsp;</td></tr>
</table>
<table >
 <tr>
<tr><td width="30%" bgcolor="red" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Total Payments >Sanction Amount.  </td></tr>
<tr><td width="30%" bgcolor="green" bordercolor=""></td><td class=rptValue>&nbsp;-&nbsp;BANK-PAO Payments. </td></tr>
<tr><td width="30%" bgcolor="#00CDCD" bordercolor=""></td><td class=rptValue nowrap>&nbsp;-&nbsp;Contractor Agreement Value Less than Bill Amount. </td></tr>
</table>
<table align="right">
		<tr  >
			<td class="rptHeading" >
			<font face=verdana size=2 color=red>(Amount Displayed is in Rupees)
			</font><b style="font-family: Rupee Foradian;">`</b></td>	
		</tr>
		</table><br>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
	<tr >
	<td class=btext nowrap>Sl No.</td>
	<td class=btext>Work Id/<br>Work Name</td>
	<td class=btext>Program</td>
	<td class=btext>Adminstrative No</td>			
	<td class=btext>Admin Sanction<br> Date</td>
	<td class=btext>Sanction Amount</td>
	<td class=btext>Contractor <br>Agreement Value</td>
	<td class=btext>Bill Amount</td>
	<td class=btext>Voucher Amount</td>
	<td class=btext>Bank Payment</td>
	<td class=btext>PAO Payment</td>
	<td class=btext>Total<br>(Bank+Pao)</td>
	</tr>
<%
try{
Hashtable ht=new Hashtable();
Hashtable ht1=new Hashtable();
Hashtable ht2=new Hashtable();
Hashtable ht4=new Hashtable();
Hashtable ht5=new Hashtable();
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

String qry4="select nvl(sum(BILL_AMOUNT_CENTRAL),0),a.work_id from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
stmt4=conn.createStatement();
rs4=stmt4.executeQuery(qry4);
while(rs4.next())
{
  ht4.put(rs4.getString(2),rs4.getString(1));
}
String qry5="select nvl(sum(BILL_AMOUT_STATE ),0),a.work_id from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id group by a.work_id ";
stmt5=conn.createStatement();
rs5=stmt5.executeQuery(qry5);
while(rs5.next())
{
  ht5.put(rs5.getString(2),rs5.getString(1));
}
long tbamt=0,tvamt=0,tsamt=0;
double tcamt=0.0,tbank=0.0,tstate=0.0;
int count=0;
String qry="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount*100000,programme_name,subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s  where a.programme_code=p.programme_code and a.subprogramme_code=s.subprogramme_code and p.programme_code=s.programme_code and  substr(office_code,2,2)='"+dcode+"' and substr(office_code,4,1)='"+divcode+"' and category_code='"+cat+"' and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"' "; 
//System.out.println("qrybank"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
if(rs.isBeforeFirst())
   {
while(rs.next())
{String state="",bank="";
	String bamt=""+ht.get(rs.getString(1));
	if(bamt!=null  && !bamt.equals("")  && !bamt.equals("null")){}else{ bamt="0";}
	String camt=""+ht1.get(rs.getString(1));
	//System.out.println(camt+"-"+rs.getString(1));
	if(camt!=null  && !camt.equals("")  && !camt.equals("null")){}else{ camt="0";}
	String vamt=""+ht2.get(rs.getString(1));
	if(vamt!=null  && !vamt.equals("")  && !vamt.equals("null")){}else{ vamt="0";}
	String BPamt=""+ht4.get(rs.getString(1));
	if(BPamt!=null  && !BPamt.equals("")  && !BPamt.equals("null")){}else{ BPamt="0";}
	//String []aa=BPamt.split("@");state=aa[0];bank=aa[1];}else{state="0";bank="0";}
	String pamt=""+ht5.get(rs.getString(1));
	if(pamt!=null  && !pamt.equals("")  && !pamt.equals("null")){}else{ pamt="0";}
	%>
		<tr>
		<td class=rptvalue align="center"><%=++count%></td>
		<td class="rptValue" nowrap><%=rs.getString(1)%>/<br><input type="text" name="a" class="mytext" style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')" value="<%=rs.getString(2)%>" onmouseout="UnTip()"/></td>
		<td class=rptvalue nowrap><%=rs.getString("programme_name")%>/<br><%=rs.getString("subprogramme_name")%></td>
		<td class="rptValue" nowrap><input type="text" name="a" class="mytext" style="width:120px" readonly="true" onmouseover="Tip(this.value,TITLE,'Admn.No')" value="<%=rs.getString(3)%>" onmouseout="UnTip()"/></td>
		<td class=rptvalue nowrap><%=rs.getString(4)%></td>
		<td class=rptvalue nowrap align=right><font color="#B404AE"><b><%=rs.getString(5)%></b></font></td>
		<td class=rptvalue nowrap align=right><font color="black"><b><%=camt%></b></font></td>

		<%if(Double.parseDouble(""+camt)<Double.parseDouble(""+bamt)){%>
		<td class=rptvalue nowrap align=right><font color="#00CDCD"><b><%=bamt%></b></td>
		<%}else{%>
		<td class=rptvalue nowrap align=right><font color="blue"><b><%=bamt%></b></td>
		<%}%>
		<td class=rptvalue nowrap align=right><%=vamt%></td>
		<td class=rptvalue nowrap align=right ><font color="green"><b><%=BPamt%></b></font></td>
		<td class=rptvalue nowrap align=right ><font color="green"><b><%=pamt%></b></font></td>
		<%double tot=Double.parseDouble(""+BPamt)+Double.parseDouble(""+pamt);
	if(rs.getInt(5)<tot){
		%>
		<td class=rptvalue nowrap align=right ><font color="red"><b><%=ndf.format(tot)%></b></font></td>
		<%}else {%>
			<td class=rptvalue nowrap align=right ><font color="#B404AE"><b><%=ndf.format(tot)%></b></font></td>
<%}%>
	 </tr>
<%
	tbamt+=Long.parseLong(bamt);
	//System.out.println((new Double(Double.parseDouble(camt))));
	tcamt+=(new Double(Double.parseDouble(camt)));
	tvamt+=Long.parseLong(vamt);;
	tsamt+=Long.parseLong(rs.getString(5));
	tbank+=Double.parseDouble(""+BPamt);
		tstate+=Double.parseDouble(""+pamt);
	} %>
<tr>
<td class=btext colspan="5" align="right">Totals</td>
<td class=btext align="right"><font color="#B404AE"><%=tsamt%></font></td>
<td class=btext align="right"><font color="black"><%=ndf.format(tcamt)%></font></td>
<td class=btext align="right"><font color="blue"><%=ndf.format(tbamt)%></font></td>
<td class=rptvalue align="right"><%=ndf.format(tvamt)%></td>
<td class=btext align="right"><font color="green"><%=ndf.format(tbank)%></font></td>
<td class=btext align="right"><font color="green"><%=ndf.format(tstate)%></font></td>
<%double tot1=Double.parseDouble(""+tbank)+Double.parseDouble(""+tstate);%>
<td class=btext align="right"><font color="#B404AE"><%=ndf.format(tot1)%></font></td>
</tr>
<%}else{ %>
	<script>
	alert(" No Matching data is Found- You are redirected to Previous page");
	document.location.href="rws_BankPao_Payment_det_frm.jsp";
	</script>
<%}}catch(Exception e)
		{
		System.out.println("error::"+e);
		}%>
 </table>
 <br>
<%@ include file = "footer.jsp" %>
 </body>
</html>