<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_ho_header1.jsp" %>
<%
String dist=request.getParameter("district");
String div=request.getParameter("division");
String vc=request.getParameter("voucher");
String frmDt=request.getParameter("fromDate");
String toDt=request.getParameter("toDate");
String da="",mn="",ya="",dt="",mt="",yt="";
String dname=request.getParameter("dname");
String divname=request.getParameter("divname");

session.setAttribute("fromDate",frmDt);
 session.setAttribute("toDate",toDt);

if(frmDt!=null && !frmDt.equals("null") && !frmDt.equals(""))
{
da=frmDt.substring(0,2);
mn=frmDt.substring(3,5);
ya=frmDt.substring(6,10);
}
if(toDt!=null && !toDt.equals("null") && !toDt.equals(""))
{
dt=toDt.substring(0,2);
mt=toDt.substring(3,5);
yt=toDt.substring(6,10);
}
String mn1="",mt1="";
String month[] = {"JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"};
if(mn.equals("01"))mn1=month[0];	 if(mn.equals("02"))mn1=month[1];	  if(mn.equals("03"))mn1=month[2];
if(mn.equals("04"))mn1=month[3];	 if(mn.equals("05"))mn1=month[4];	  if(mn.equals("06"))mn1=month[5];
if(mn.equals("07"))mn1=month[6];	 if(mn.equals("08"))mn1=month[7];	  if(mn.equals("09"))mn1=month[8];
if(mn.equals("10"))mn1=month[9];	 if(mn.equals("11"))mn1=month[10]; if(mn.equals("12"))mn1=month[11];
if(mt.equals("01"))mt1=month[0];	 if(mt.equals("02"))mt1=month[1];	  if(mt.equals("03"))mt1=month[2];
if(mt.equals("04"))mt1=month[3];	 if(mt.equals("05"))mt1=month[4];	  if(mt.equals("06"))mt1=month[5];
if(mt.equals("07"))mt1=month[6];	 if(mt.equals("08"))mt1=month[7];	  if(mt.equals("09"))mt1=month[8];
if(mt.equals("10"))mt1=month[9];	 if(mt.equals("11"))mt1=month[10]; if(mt.equals("12"))mt1=month[11];
%>
<script>
 function fnSave(index)
 {
	var checkchoice=0;
	var checkchoice1=0;
	var nv='<%=vc%>';
    if(nv==1){
	for(var i=1;i<=index;i++)
		{
		
			if(document.getElementById('check['+i+']').checked)
			{
				var bamt=document.getElementById('bamt'+i).value;
				var vamt=document.getElementById('vamt'+i).value;
				if(fnCheck(bamt,vamt,i) && fnCheck1(bamt,vamt,i))
				{
					checkchoice1++;
					
				}
				else
				{
				  alert("Before Check Select Box Please provide Central Amount or Satate Amount for Sl.No" + i);
				  return false;
				}
					checkchoice++;
			}
		}
	} else if(nv==2)
	{ 
      for(var i=1;i<=index;i++)
		{
		
			if(document.getElementById('check['+i+']').checked)
			{
				var bamt=document.getElementById('bamt'+i).value;
				var vamt=0;
				if(fnCheck(bamt,vamt,i))
				{
					checkchoice1++;
					
				}
				else
				{
				  alert("Before Check Select Box Please provide Central Amount or Satate Amount for Sl.No" + i);
				  return false;
				}
					checkchoice++;
			}
		}

	}
		if(checkchoice==0)  
		{
		alert("Please Select At least One Checkbox");
		return false;
		}
		else if(checkchoice==checkchoice1)
		{ 
			var fdate='<%=frmDt%>';
			var tdate='<%=toDt%>';
		
		document.forms[0].action="rws_push_bill_save.jsp?fromDate="+fdate+"&toDate="+tdate;
		document.forms[0].submit();  

		}
    
  
 }

 function fnCheck(bamt,vamt,num)
 {
	var camt=document.getElementById('central'+num).value;
	var samt=document.getElementById('state'+num).value;
	if(isNaN(camt) || camt=="")camt=0; if(isNaN(samt) || samt=="")samt=0;
	 if(camt==0 && samt==0 ){
		 alert("Please Provide Central Amount or State Amount");
	 }
	 else if((parseFloat(camt)+parseFloat(samt))>parseFloat(bamt))
	 {
	   alert(" Central Amount + State Amount(Rs."+(parseFloat(camt)+parseFloat(samt))+") must be less than or equal to Bill Admissible Amount(Rs."+bamt+")");
	   document.getElementById('central'+num).value="";
	   document.getElementById('state'+num).value="";
	   document.getElementById('check['+num+']').checked=false;
	    return false;
	 }else{
		 return true;
	 }
 }
 function fnCheck1(bamt,vamt,num)
 {
	var camt=document.getElementById('central'+num).value;
	var samt=document.getElementById('state'+num).value;
	var nv='<%=vc%>';
   if(isNaN(camt) || camt=="")camt=0; if(isNaN(samt) || samt=="")samt=0;
  
   if(nv==1){
   if(camt==0 && samt==0 ){
		 alert("Please Provide Central Amount or State Amount");
	 }
	 else if((parseFloat(camt)+parseFloat(samt))==parseFloat(vamt))
	{
	    return true;
	   }else{
	   alert("Central Amount + State(Rs."+(parseFloat(camt)+parseFloat(samt))+") Amount must be  equal to Voucher Amount(Rs."+vamt+")");
	   document.getElementById('central'+num).value="";
	   document.getElementById('state'+num).value="";
	   document.getElementById('check['+num+']').checked=false;
	    return false;
		
	 }
   } else if(nv==2){
	  if(camt==0 && samt==0 ){
	  alert("Please Provide Central Amount or State Amount");
	 }else{
		 return true;
	 }
   }
 }
</script>
<body>
<form>
<table boroder=0 width=100%>
<tr align=center ><td class=btext colspan=15> Circle:<%=dname%>&nbsp;&nbsp; Division:<%=divname%></td></tr>
<tr align=center ><td class=btext colspan=15>Works List</td></tr>
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../masters/rws_HO_homepage_frm.jsp">My Home</td> 
				</tr>
			</table>
		</caption>
</table>

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse" >
<%if(vc!=null && !vc.equals("") && vc.equals("2")){%>
<tr align=center ><td class=btext colspan=15> From Date:<%=frmDt%>&nbsp;&nbsp; To Date:<%=toDt%></td></tr>
<%}%>
<tr align=center>
	<td class=btext>Sl No.</td>
	<td class=btext>Work Id</td>
	<td class=btext>Work Name</td>
	<td class=btext>Admin No</td>
	<td class=btext>Admin Date</td>
	<td class=btext>Est Cost(In Lakhs)</td>
	<td class=btext>Bill Sl No</td>
	<td class=btext>Bill No</td>
	<td class=btext>Bill Date</td>
	<td class=btext>Bill Enterd Date</td>
	<td class=btext>EE Forward Date</td>
	<td class=btext>Bill Amt<br>Contractor(in Rs.)</td>
	<td class=btext>Bill Admissible<br>Amt(in Rs.)</td>
	<td class=btext>Voucher<br>Amt(in Rs.)</td>
	<td class=btext>Voucher Date</td>
	<td class=btext>Push Amount<br>for Bills</td>
	<td class=btext>Select</td>
</tr>
<%
int cnt=1,cmt=0;
String qry="";
try{
	if(vc!=null && !vc.equals("") && vc.equals("1")){
	qry="select a.work_id,c.work_name,c.admin_no,to_char(admin_date,'dd/MM/yyyy'),sanction_amount,a.bill_sl_no,to_char (bill_date,'dd/MM/yyyy'),to_char(a.update_date,'dd/MM/yyyy'),bill_amt_admissible,sum(voucher_amt),to_char(voucher_dt,'dd/MM/yyyy'),bill_amt_contractor,bill_no,ee_fwd_date from rws_work_bill_tbl a,rws_work_exp_voucher_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and a.bill_sl_no<>'0' and a.bill_sl_no=b.bill_sl_no and a.work_id=c.work_id and b.work_id=c.work_id and ee_fwd_date is null and a.work_id||a.bill_sl_no not in(select distinct work_id||bill_sl_no from rws_bill_bank_bridge_tbl where substr(work_id,5,2)='"+dist+"') and substr(office_code,2,2)='"+dist+"' and substr(office_code,4,1)='"+div+"' group by a.work_id,c.work_name,c.admin_no,to_char(admin_date,'dd/MM/yyyy'),sanction_amount,a.bill_sl_no,to_char (bill_date,'dd/MM/yyyy'),to_char(a.update_date,'dd/MM/yyyy'),bill_amt_admissible,to_char(voucher_dt,'dd/MM/yyyy'),bill_amt_contractor,bill_no,ee_fwd_date  order by a.work_id,a.bill_sl_no ";
	System.out.println("qry1:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
		{
			cmt++;%>
		<tr>
		<td class=rptvalue><%=cnt%></td>
		<td class=rptvalue><%=rs.getString(1)%></td>
		<td class=rptvalue><%=rs.getString(2)%></td>
		<td class=rptvalue><%=rs.getString(3)%></td>
		<td class=rptvalue><%=rs.getString(4)%></td>
		<td class=rptvalue align="right"><%=rs.getString(5)%></td>
		<td class=rptvalue><%=rs.getString(6)%></td>
		<td class=rptvalue><%=rs.getString(13)%></td>
		<td class=rptvalue><%=rs.getString(7)%></td>
		<td class=rptvalue ><%=rs.getString(8)%></td>
		<%if(rs.getString(13)!=null && !rs.getString(13).equals("")){%>
		<td class=rptvalue align="right"><%=rs.getString(13)%></td>
		<%}else{%>
		<td class=rptvalue align="right" >-</td><%}%>
		<td class=rptvalue align="right"><%=rs.getString(12)%></td>
		<td class=rptvalue align="right"><%=rs.getString(9)%></td>
		<td class=rptvalue align="right"><%=rs.getString(10)%></td>
		<td class=rptvalue><%=rs.getString(11)%></td>
		<input type="hidden" name="blsno<%=cnt%>" value="<%=rs.getString(6)%>"/>
		<input type="hidden" name="bamt<%=cnt%>" value="<%=rs.getString(9)%>"/>
		<input type="hidden" name="vamt<%=cnt%>" value="<%=rs.getString(10)%>"/>
		<td class=rptvalue>Central:<input type="text" style="width:70px" name="central<%=cnt%>"  onkeypress="return extractNumber(this,8,3,false)" onkeyup="return fnCheck('<%=rs.getString(9)%>','<%=rs.getString(10)%>',<%=cnt%>)" onchange="fnCheck1('<%=rs.getString(9)%>','<%=rs.getString(10)%>',<%=cnt%>)"/>
		<br>State:&nbsp;&nbsp;&nbsp;<input type="text" style="width:70px" name="State<%=cnt%>" onkeypress="return extractNumber(this,8,3,false)"  onkeyup="return fnCheck('<%=rs.getString(9)%>','<%=rs.getString(10)%>',<%=cnt%>)" onchange="fnCheck1('<%=rs.getString(9)%>','<%=rs.getString(10)%>',<%=cnt%>)"/>
		</td>
		<td class=rptvalue align="center"><input type="checkbox" name="check[<%=cnt%>]" value="<%=rs.getString(1)%>" />
		</td>
		</tr>
		<%
		cnt++;
	}
	
	} else{
		qry="select b.work_id,work_name,admin_no,to_char(admin_date,'dd/MM/yyyy'),sanction_amount,a.bill_sl_no,to_char (bill_date,'dd/MM/yyyy'),to_char(a.update_date,'dd/MM/yyyy'),bill_amt_admissible,bill_amt_contractor,bill_no,ee_fwd_date from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and bill_sl_no <>0 and ee_fwd_date is null and a.work_id||bill_sl_no not in(select distinct work_id || bill_sl_no from rws_work_exp_voucher_tbl where substr(work_id,5,2)='"+dist+"') and to_date(to_char(update_date))>='"+da+"/"+mn1+"/"+ya+"' and to_date(to_char(update_date)) <='"+dt+"/"+mt1+"/"+yt+"'  and a.work_id||bill_sl_no not in (select work_id||bill_sl_no from rws_bill_bank_bridge_tbl where substr(a.work_id,5,2)='"+dist+"') and  substr(a.work_id,5,2)='"+dist+"' and substr(office_code,4,1)='"+div+"'    order by a.work_id,a.bill_sl_no";

	System.out.println("qry2:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
		{
			cmt++;%>
		<tr>
		<td class=rptvalue><%=cnt%></td>
		<td class=rptvalue><%=rs.getString(1)%></td>
		<td class=rptvalue><%=rs.getString(2)%></td>
		<td class=rptvalue><%=rs.getString(3)%></td>
		<td class=rptvalue><%=rs.getString(4)%></td>
		<td class=rptvalue align="right"><%=rs.getString(5)%></td>
		<td class=rptvalue><%=rs.getString(6)%></td>
		<td class=rptvalue><%=rs.getString(11)%></td>
		<td class=rptvalue><%=rs.getString(7)%></td>
		<td class=rptvalue ><%=rs.getString(8)%></td>
		<%if(rs.getString(12)!=null && !rs.getString(12).equals("")){%>
		<td class=rptvalue  align="right"><%=rs.getString(12)%></td>
		<%}else{%>
		<td class=rptvalue  align="right">-</td><%}%>
		<td class=rptvalue align="right"><%=rs.getString(10)%></td>
		<td class=rptvalue align="right"><%=rs.getString(9)%></td>
		<td class=rptvalue align="right">0</td>
		<td class=rptvalue align="right">-</td>
		<input type="hidden" name="blsno<%=cnt%>" value="<%=rs.getString(6)%>"/>
		<input type="hidden" name="bamt<%=cnt%>" value="<%=rs.getString(9)%>"/>
		<td class=rptvalue>Central:<input type="text" style="width:70px" name="central<%=cnt%>"  onkeypress="return extractNumber(this,8,3,false)" onkeyup="return fnCheck('<%=rs.getString(9)%>','0',<%=cnt%>)" onchange="fnCheck1('<%=rs.getString(9)%>','0',<%=cnt%>)"/>
		<br>State:&nbsp;&nbsp;&nbsp;<input type="text" style="width:70px" name="State<%=cnt%>" onkeypress="return extractNumber(this,8,3,false)"  onkeyup="return fnCheck('<%=rs.getString(9)%>','',<%=cnt%>)" onchange="fnCheck1('<%=rs.getString(9)%>','0',<%=cnt%>)"/>
		</td>
		<td class=rptvalue align="center"><input type="checkbox" name="check[<%=cnt%>]" value="<%=rs.getString(1)%>" />
		</td>
		</tr>
		<%
		cnt++;
	}
	}
	
	if(cmt==0)
	{%>
		  <script>
		  alert("No Push Bills For this Criteria ");
		  document.location.href="rws_push_bills_frm.jsp";
		  </script>
		<%}
	%>
	<tr>
	<td class=btext align="center" colspan=17><input type="button" name="Save<%=cnt-1%>" value="Push Bills" onclick="fnSave(<%=cnt-1%>)"></td></tr>
<%}
	catch(Exception e){
	//System.out.println("Exception in Push bill :"+e);
	}%>
<input type="hidden" name="count" value="<%=cnt%>">
<input type="hidden" name="dist" value="<%=dist%>">
<input type="hidden" name="div" value="<%=div%>">
<input type="hidden" name="vc" value="<%=vc%>">
<input type="hidden" name="dname" value="<%=dname%>">
<input type="hidden" name="divname" value="<%=divname%>">
</form>