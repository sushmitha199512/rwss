<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_ho_header1.jsp"%>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
String dist=request.getParameter("district");
String div=request.getParameter("division");
String frmDt=request.getParameter("fromDate");
String toDt=request.getParameter("toDate");
String da="",mn="",ya="",dt="",mt="",yt="";
String dname=request.getParameter("dname");
String divname=request.getParameter("divname");
if(frmDt!=null && !frmDt.equals(""))
{
da=frmDt.substring(0,2);
mn=frmDt.substring(3,5);
ya=frmDt.substring(6,10);
}
if(toDt!=null && !toDt.equals(""))
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
function toggleRowColor(that)
{
	var rowColor='#ccccff';
	//var rowColor='#e3e4fa';
	if(that)
	{
		if(that.style.background==rowColor)
		that.style.background="white";
		else if(that.style.background=="white")
		that.style.background=rowColor;
		else that.style.background=rowColor;
	}
}
 function fnSave(index)
 {
	 var checkchoice = 0;
      for(var i=1;i<=index;i++)
		{
			if(document.getElementById('check['+i+']').checked)
			{
					checkchoice++;
			}
		}
		if(checkchoice==0)  
		{
			alert("Please Select At least One Bill to Revoke");
			return false;
		}
		else
		{ 
			var fdate='<%=frmDt%>';
			var tdate='<%=toDt%>';
			document.forms[0].action="rws_revoke_bill_save.jsp?fromDate="+fdate+"&toDate="+tdate;
			document.forms[0].submit();  
		}  
 }
</script>
<table boroder=0 width=100%>
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="../masters/rws_HO_homepage_frm.jsp">My Home</a></td>
				</tr>
			</table>
			</caption><tr align=center ><td class=btext colspan=15> Circle: <%=dname%>&nbsp;&nbsp; Division: <%=divname%></td></tr>
<tr align=center ><td class=btext colspan=15> Bill Entered Date Between:- From <%=frmDt%> to <%=toDt%></td></tr></table>
<body>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<form method="post">
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
	<td class=btext>Sl No.</td>
	<td class=btext>Work Id</td>
	<td class=btext>Work Name</td>
	<td class=btext>Admin Date</td>
	<td class=btext>Est Cost(In Rs.)</td>
	<td class=btext>Bill No</td>
	<td class=btext>Bill Date</td>
	<td class=btext>Bill Enterd Date</td>
	<td class=btext>Bill Amt<br>Contractor<br>(In Rs.)</td>
	<td class=btext>Bill Admissible<br>Amt<br>(In Rs.)</td>
	<td class=btext>Released Amt Central<br>(In Rs.)</td>
	<td class=btext>Released Amt State<br>(In Rs.)</td>
	<td class=btext>State Tx ID/Central Tx ID</td>
	<td class=btext>Bill Push Date</td>
	<td class=btext>Voucher<br>Amt<br>(In Rs.)</td>
	<td class=btext>Select</td>
</tr>
<%
int cnt=1,cmt=0;
String qry="";
try{
		qry="select distinct b.work_id,work_name,admin_no,to_char(admin_date,'dd/MM/yyyy'),sanction_amount,a.bill_sl_no,to_char (bill_date,'dd/MM/yyyy'),to_char(a.update_date,'dd/MM/yyyy'),bill_amt_admissible,bill_amt_contractor,bill_no,to_char(a.ee_fwd_date,'dd/MM/yyyy'),nvl(BILL_AMOUT_STATE,0) as state,nvl(BILL_AMOUNT_CENTRAL,0) as central,to_char(bank_send_date,'dd/mm/yyyy') as bank_send_date from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_bill_bank_bridge_tbl bb where a.work_id=b.work_id and b.work_id=bb.work_id and a.work_id||a.bill_sl_no=bb.work_id||bb.bill_sl_no and TXID is null and STATE_TXID is null and to_date(to_char(update_date))>='"+da+"/"+mn1+"/"+ya+"' and to_date(to_char(update_date)) <='"+dt+"/"+mt1+"/"+yt+"'  and a.work_id||a.bill_sl_no not in (select work_id||bill_sl_no from rws_work_exp_voucher_tbl where substr(a.work_id,5,2)='"+dist+"') and  substr(a.work_id,5,2)='"+dist+"' and substr(b.office_code,4,1)='"+div+"' order by b.work_id,a.bill_sl_no";

	//System.out.println("qry:"+qry);
	stmt=conn.createStatement();
	rs=stmt.executeQuery(qry);
	while(rs.next())
		{
			cmt++;%>
		<tr onclick="toggleRowColor(this)">
		<td class=rptvalue><%=cnt%></td>
		<td class=rptvalue><%=rs.getString(1)%></td>
		<td class=rptvalue><input type="text" name="aa" class="mytext" style="width:160px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')" value="<%=rs.getString(2)%>" onmouseout="UnTip()"/></td>
		<td class=rptvalue><%=rs.getString(4)%></td>
		<td class=rptvalue align="right"><%=nic.watersoft.commons.RwsOffices.IndianFormat1(""+ndf.format(rs.getDouble(5)*100000))%></td>
		<td class=rptvalue><input type="text" name="aa" class="mytext" style="width:60px" readonly="true" onmouseover="Tip(this.value,TITLE,'Work Name')" value="<%=rs.getString(11)%>" onmouseout="UnTip()"/></td>
		<td class=rptvalue><%=rs.getString(7)%></td>
		<td class=rptvalue ><%=rs.getString(8)%></td>
		
		<td class=rptvalue align="right"><%=nic.watersoft.commons.RwsOffices.IndianFormat1(rs.getString(10))%></td>
		<td class=rptvalue align="right"><%=nic.watersoft.commons.RwsOffices.IndianFormat1(rs.getString(9))%></td>
		<td class=rptvalue align="right"><%=nic.watersoft.commons.RwsOffices.IndianFormat1(rs.getString("state"))%></td>
		<td class=rptvalue align="right"><%=nic.watersoft.commons.RwsOffices.IndianFormat1(rs.getString("central"))%></td>
		<td class=rptvalue align="center">-/-</td>
		<td class=rptvalue align="left"><%=rs.getString("bank_send_date")%></td>
		<td class=rptvalue align="right">0</td>
		<input type="hidden" name="blsno<%=cnt%>" value="<%=rs.getString(6)%>"/>
		<td  align="center"><input type="checkbox" name="check[<%=cnt%>]" value="<%=rs.getString(1)%>" />
		</td>
		</tr>
		<%
		cnt++;
	}
	
	if(cmt==0)
	{%>
		  <script>
		  alert("No Revoke Bills For this Criteria ");
		  document.location.href="rws_revoke_bills_frm.jsp";
		  </script>
		<%}
	%>
	<tr>
	<td align="center" colspan=17><input type="button" name="Save<%=cnt-1%>" value="Revoke Bills" onclick="fnSave(<%=cnt-1%>)" class=btext ></td></tr>
<%}
	catch(Exception e){
	//System.out.println("Exception in Push bill :"+e);
	}%>
<input type="hidden" name="count" value="<%=cnt%>">
<input type="hidden" name="dist" value="<%=dist%>">
<input type="hidden" name="div" value="<%=div%>">
<input type="hidden" name="dname" value="<%=dname%>">
<input type="hidden" name="divname" value="<%=divname%>">
</form>
</body>