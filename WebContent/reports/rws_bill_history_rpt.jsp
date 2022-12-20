<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import ="nic.watersoft.works.rws_works_WorksDAO" %>
<%@ page import ="nic.watersoft.works.rws_works_WorkStatus_form" %>

<%
Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
 String dname=request.getParameter("dname");
 String pname=request.getParameter("pname");
 String divname=request.getParameter("divname");
 String yname=request.getParameter("yname");
 String wname=request.getParameter("wname");
 String bill=request.getParameter("Bill");
 String mode=request.getParameter("mode");
// System.out.println("mode:::"+mode);
 String workid = request.getParameter("workid");
if(mode!=null && mode.equals("1")){
%>

<%}%>
<html>
<script>
function fnBill()
{
   var bil=document.forms[0].Bill.value;
  // alert(bil);
   var dname='<%=dname%>';
   var mode = '<%=mode%>';
   var workidd = '<%=workid%>';
   if(mode=="2")
	{
	   url = "./rws_bill_history_rpt.jsp?dname="+dname+"&mode=2&workid="+workidd+"&bill="+bil;
	}
	else{
		url="./rws_bill_history_rpt.jsp?dname="+dname+"&bill="+bil;
	}

   
   document.forms[0].action=url;
   document.forms[0].submit();
}

</script>


<body bgcolor="#edf2f8">
<form action="<%= request.getRequestURI()%>" method="post">
<table border = 0 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
		 <tr>
			<td align="right" class="bwborder">
			<a href="javascript:onclick=history.go(-1)">Back</a> | <a href="../home.jsp">Home</a>|<a href="javascript:window.print()">Print</td> 
			</tr>
		</table>
</caption>
<%
if(mode!=null && mode.equals("1")){
	workid = wname.substring(0,14);
%>
<tr  align="center"><td class=btext>District:<font color=black><%=dname%></font>&nbsp;&nbsp;Division:<font color=black><%=divname%></font>&nbsp;&nbsp;
Work Category:<font color=black><%=pname%></font>&nbsp;&nbsp;Year:<font color=black><%=yname%></font>&nbsp;&nbsp;</td>
</tr>
<tr align="center"><td class=btext>Work:<font color=black><%=wname%></font></td></tr>
<%}else if(mode!=null && mode.equals("2"))
{
	String qryy="select dname,division_office_name,category_name,work_name,to_char(admin_date,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_category_tbl b,rws_district_tbl c,rws_division_office_tbl d ,RWS_WORK_BILL_TBL e where a.category_code=b.category_code and substr (a.office_code,2,2) =c.dcode and substr(a.office_code,2,2)=d.circle_office_code and c.dcode=d.circle_office_code and substr (a.office_code,4,1) =d.division_office_code and e.work_id ='"+workid+"' and a.work_id=e.work_id ";
stmt3=conn.createStatement();
rs3=stmt3.executeQuery(qryy);
if(rs3.next())
	{
%>
<tr align="center">
<td class=btext>District:<font color=black><%=rs3.getString(1)%></font>&nbsp;&nbsp;
Division:<font color=black><%=rs3.getString(2)%></font>&nbsp;&nbsp;
Work Category:<font color=black><%=rs3.getString(3)%></font>&nbsp;&nbsp;
Admin Sanction Date:<font color=black><%=rs3.getString(5)%></font>&nbsp;&nbsp;</td></tr>
<tr align="center"><td class=btext>Work:<font color=black><%=workid%>-<%=rs3.getString(4)%></font></td></tr>
<%}
}%>
<tr>
		<td class="btext" align="center" colspan="15">Select Bill:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<select name="Bill" style="width:185px" onchange="fnBill()">
		<option value="">-Select-</option>
		<%

String qry="select  distinct BILL_SL_NO,BILL_NO,to_char(BILL_DATE,'dd/mm/yyyy'),BILL_AMT_ADMISSIBLE,BILL_DATE from RWS_WORK_BILL_TBL ";
if(workid!=null && !workid.equals("")){
qry+=" where work_id='"+workid+"' order by BILL_DATE " ; 
}
//System.out.println("qry:"+qry);
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
if(rs.isBeforeFirst())
{
	 if(bill!=null && bill.equals("all")){%>
		<option value="all" selected>All</option>
		<%}else{%>
		<option value="all">All</option>
		<%}
	while(rs.next()){
  
		 if(bill!=null && bill.equals(rs.getString(2)))
		{%>
			<option value="<%=rs.getString(2)%>" selected><%=rs.getString(2)%></option>
		<%}else{%>

		<option value="<%=rs.getString(2)%>" ><%=rs.getString(2)%></option>
		<%}
	}
}
else
{
%>
	<script>
		alert("No Bills raised for this Work - You are redirected to Previous page");
		document.location.href="rws_bill_history_frm.jsp";
	</script>
<%
}


if(bill!=null && !bill.equals("") &&  !bill.equals("null")){
//System.out.println("bill:"+bill);
int count=0;
String qry1="select  distinct BILL_SL_NO,BILL_NO,to_char(BILL_DATE,'dd/mm/yyyy'),BILL_AMT_Contractor,BILL_AMT_ADMISSIBLE  from RWS_WORK_BILL_TBL where  work_id ='"+workid+"' ";
if(!bill.equals("all")) 
{
	
qry1+=" and  BILL_NO='"+bill+"' ";
}
qry1+=" order by BILL_SL_NO ";
stmt1=conn.createStatement();
//System.out.println("qry1:"+qry1);
rs1=stmt1.executeQuery(qry1);

while(rs1.next())
{%>
<tr align="left">
  <td  colspan="20"><br><br><font color="red" face="verdana" size=2 ><%=++count%></font>.	 &nbsp;<font color="red" face="verdana" size=2>Bill SlNo:</font><font color=black><%=rs1.getString(1)%></font>&nbsp;&nbsp;
   <font color="red" face="verdana" size=2> Bill Date:</font><font color=black><%=rs1.getString(3)%></font>&nbsp;&nbsp;
    <font color="red" face="verdana" size=2 >Bill Amount(in Rupes):</font><font color=black><%=rs1.getString(4)%></font>   <font color="red" face="verdana" size=2 >Admissible Amount(in Rupes):</font><font color=black><%=rs1.getString(5)%></font></td>
  </tr>

<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr><td class=btext colspan="15">Bill Details</td></tr>

	<tr align="center">
		 <td class=btext>Sl.No</td>
		 <td class=btext>Type Of Contractor</td>
		 <td class=btext>Mile Stone Sl No</td>
		 <td class=btext>Mile Stone No</td>
		 <td class=btext>Mile Stone Component</td>
		 <td class=btext>Sub Component</td>
		 <td class=btext>Quantity to be executed(No./Length in Mts.)</td>
		 <td class=btext>Value of sub-component to be executed(ECV)</td>
		 <td class=btext>Value of sub-component to be executed(%)</td>
		 <td class=btext>Target Date as per Agmt.</td>
		 <td class=btext>Revised target date as per EOAT</td>
		 <td class=btext>Achievement date</td>
		 <td class=btext>Quantity executed(No./Length in Mts.)</td>
		 <td class=btext>Value of workdone</td>
		 <td class=btext nowrap>% of work done</td>
		 <td class=btext>Physical Stage</td>
	</tr>
	  <tr>
		  <td class=rptsubvalue align="center">1</td>
		  <td class=rptsubvalue align="center">2</td>
		  <td class=rptsubvalue align="center">3</td>
		  <td class=rptsubvalue align="center">4</td>
		  <td class=rptsubvalue align="center">5</td>
		  <td class=rptsubvalue align="center">6</td>
		  <td class=rptsubvalue align="center">7</td>
		  <td class=rptsubvalue align="center">8</td>
		  <td class=rptsubvalue align="center">9</td>
		  <td class=rptsubvalue align="center">10</td>
		  <td class=rptsubvalue align="center">11</td>
		  <td class=rptsubvalue align="center">12</td>
		   <td class=rptsubvalue align="center">13</td>
		  <td class=rptsubvalue align="center">14</td>
		  <td class=rptsubvalue align="center">15</td>
		   <td class=rptsubvalue align="center">16</td>
	  </tr>


<%

int sno=0;
	 String  mqry="select decode(TYPE_OF_CONTRACTOR ,'1','CIVIL','2','ELECTRICAL','3','MECHANICAL','4','BORE WELL','5','SPILL OVER'),MAJOR_MILESTONE_CODE ,MILESTONE_SLNO,MILESTONE_NAME ,MILESTONE_STAGE_NAME,COMPONENT_NO, to_char(TARGET_DATE,'dd/mm/yyyy'),nvl(to_char(EOAT_DT,'dd/mm/yyyy'),'-'),nvl(to_char(ah.ACHIEVE_DATE ,'dd/mm/yyyy'),'-'),nvl(COMPONENT_NO_ACH,'0'),nvl(Percent_completed,'0'),decode(MS_STAGE,'1','Not Started','2','In Progress','3','Completed'),nvl(percent_completed_work_val,'0'),nvl(percent_completed_val,'0'),nvl(Percent_completed_work,'0')   from  rws_work_milestone_bill_tbl ah,rws_milestone_tbl mi, rws_milestone_stage_tbl smi where  ah.MILESTONE_CODE =mi.MILESTONE_CODE and ah.MILESTONE_CODE =smi.MILESTONE_CODE and ah.MILESTONE_STAGE_CODE=smi.MILESTONE_STAGE_CODE and ah.work_id='"+workid+"' and  bill_no='"+rs1.getString(2)+"' ";
	mqry+=" order by MAJOR_MILESTONE_CODE,MILESTONE_SLNO ";
	stmt2=conn.createStatement();
	//System.out.println("mqry:"+mqry);
	rs2=stmt2.executeQuery(mqry);
	while(rs2.next())
	{%>
		<tr>
		  <td class=rptvalue><%=++sno%></td>
		  <td class=rptvalue nowrap><%=rs2.getString(1)%></td>
		  <td class=rptvalue nowrap><%=rs2.getString(2)%></td>
		  <td class=rptvalue nowrap><%=rs2.getString(3)%></td>
		  <td class=rptvalue nowrap><%=rs2.getString(4)%></td>
		  <td class=rptvalue nowrap><%=rs2.getString(5)%></td>
		  <td class=rptvalue nowrap align="right"><%=rs2.getString(6)%></td>
		  <td class=rptvalue nowrap align="right"><%=rs2.getString(13)%></td>
		  <td class=rptvalue nowrap align="right"><%=rs2.getString(15)%></td>
		  <td class=rptvalue nowrap align="center"><%=rs2.getString(7)%></td>
		  <td class=rptvalue nowrap align="center"><%=rs2.getString(8)%></td>
		  <td class=rptvalue nowrap align="center"><%=rs2.getString(9)%></td>
		  <td class=rptvalue nowrap align="right"><%=rs2.getString(10)%></td>
		  <td class=rptvalue nowrap align="right"><%=rs2.getString(14)%></td>
		   <td class=rptvalue nowrap align="right"><%=rs2.getString(11)%></td>
		   <td class=rptvalue nowrap align="center"><%=rs2.getString(12)==null?"-":rs2.getString(12)%></td>
		</tr>
		
	<%}
	if(sno==0)%><tr><td colspan="15" align="center">No Records </td></tr>
	</table><br>
	
<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr><td class=btext colspan="15">Voucher Details</td></tr>
	<tr align="center">
		 <td class=btext>Sl.No</td>
		 <td class=btext>MBook No</td>
		 <td class=btext>Voucher No</td>
		 <td class=btext>Voucher Date</td>
		 <td class=btext>Voucher Amount(in Rupes)</td>
		 <td class=btext>Cheque No</td>
		 <td class=btext>Cheque Date</td>
		 <td class=btext>Contractor Name</td>

</tr>
<%
	int cnt=0;
String vqry="select mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl(to_char(CHEQUE_DT,'dd/mm/yyyy'),'-'),nvl(contractor_name_company,'-'),bill_sl_no from rws_work_exp_voucher_tbl a,rws_contractor_tbl b where a.contractor_code=b.contractor_code(+) and  work_id='"+workid+"'  and bill_sl_no='"+rs1.getString(1)+"' ";
//System.out.println("vqry"+vqry);
Statement vstmt=conn.createStatement();
ResultSet vrs=vstmt.executeQuery(vqry);
while(vrs.next())
{%><tr>
	<td class=rptvalue nowrap><%=++cnt%></td>
    <td class=rptvalue nowrap><%=vrs.getString(1)%></td>
    <td class=rptvalue nowrap><%=vrs.getString(2)%></td>
    <td class=rptvalue nowrap><%=vrs.getString(3)%></td>
    <td class=rptvalue nowrap align="right"><%=vrs.getString(4)%></td>
    <td class=rptvalue nowrap><%=vrs.getString(5)%></td>
    <td class=rptvalue nowrap><%=vrs.getString(6)%></td>
    <td class=rptvalue nowrap><%=vrs.getString(7)%></td>
    
</tr>
<%}	
if(cnt==0)
	{%><tr><td colspan="15" align="center">No Records </td></tr>
	<%}

}
}%><br></table>
<input type="hidden" name="dname" value="<%=dname%>">
<input type="hidden" name="divname" value="<%=divname%>">
<input type="hidden" name="pname" value="<%=pname%>">
<input type="hidden" name="yname" value="<%=yname%>">
<input type="hidden" name="wname" value="<%=wname%>">
<INPUT type="hidden" name="mode" value="<%=mode%>">
</form>
</html>







