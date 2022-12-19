<% ////System.out.println("ddddddddddddddddddddd");%>
<%@page import="java.util.*" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<script type="text/javascript"> 
  
$(function(){blinkOn()}) 
  
function blinkOn(){ 
    $(".notice").css("background-color", "green"); 
    setTimeout("blinkOff()", 300); 
} 
  
function blinkOff(){ 
    $(".notice").css("background-color", "WHITE"); 
    setTimeout("blinkOn()", 300); 
} 
</script> 
<script language="javascript">
function wopen(url, name, w, h)
{
	var width = 950;
	var height = 450;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}

</script> 
<% DecimalFormat ndf = new DecimalFormat("####.00");
 String dcode=request.getParameter("district");
 String progcode=request.getParameter("progcode");
 ////System.out.println("dcode in second jsp:"+dcode);
 ////System.out.println("pcode in second jsp:"+progcode);
%>
<table width="100%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Works List" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Admin No</td>
			<td class=btext>Admin Date</td>
			<td class=btext>Grounding Date</td>
			<td class=btext>Sanction Amount</td>
			<td class=btext>Total No.of <br> Mile Stones</td>
			<td class=btext>% of Component to be <br> executed in the MileStone(s)<br> w.r.to total <br>Work Estimate Cost</td>
			<td class=btext>Work- % Achievement for All Mile Stone(s) <br>till date</td>
			<td class=btext>Payment to be made for <br> Work % Achievement</td>
			<td class=btext>Voucher Amount Raised(Lakhs )</td>
			<td class=btext>Payment Due<br><br>(11-12)</td></tr>
			<tr align=center>
			<td class=btext>1</td>
			<td class=btext>2</td>
			<td class=btext>3</td>
			<td class=btext>4</td>
			<td class=btext>5</td>
			<td class=btext>6</td>
			<td class=btext>7</td>
			<td class=btext>8</td>
			<td class=btext>9</td>
			<td class=btext>10</td>
			<td class=btext>11</td>
			<td class=btext>12</td>
			<td class=btext>13</td></tr>
	<%
int count=0;
String qry="select a.work_id,a.work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,to_char(grounding_date,'dd/mm/yyyy')  from rws_work_admn_tbl a,rws_work_commencement_tbl b where a.work_id=b.work_id and b.grounding_date is not null and substr(a.work_id,5,2)='"+dcode+"'  and programme_code='"+progcode+"'  and work_cancel_dt is null";
 ////System.out.println("qryyyyyyyyyyyyy:"+qry);
 stmt=conn.createStatement();
 rs=stmt.executeQuery(qry);
 
String qry1="select sum(PERCENT_COMPLETED_WORK),work_id,count(*) from rws_milestone_target_ach_tbl a,rws_milestone_tbl b,rws_milestone_stage_tbl c where a.milestone_code=b.milestone_code and b.milestone_code=c.milestone_code and a.milestone_stage_code=c.milestone_stage_code group by work_id ";
////System.out.println(" qry1:"+qry1);
Hashtable ht= new Hashtable();
Hashtable countht= new Hashtable();
Statement stmt1=conn.createStatement();
 ResultSet rs1=stmt1.executeQuery(qry1);
 while(rs1.next())
 {
	 ht.put(rs1.getString(2),rs1.getString(1));
	 countht.put(rs1.getString(2),rs1.getString(3));
	 
 }

 String qry2="select sum(PERCENT_COMPLETED),work_id from rws_milestone_target_ach_tbl a,rws_milestone_tbl b,rws_milestone_stage_tbl c where a.milestone_code=b.milestone_code and b.milestone_code=c.milestone_code and a.milestone_stage_code=c.milestone_stage_code and PERCENT_COMPLETED is not null group by work_id ";
 ////System.out.println(" qry2:"+qry2);
Hashtable ht1= new Hashtable();
Statement stmt2=conn.createStatement();
 ResultSet rs2=stmt2.executeQuery(qry2);
 while(rs2.next())
 {
	 ht1.put(rs2.getString(2),rs2.getString(1));
 }

 String qry3="select sum(VOUCHER_AMT),work_id from RWS_WORK_EXP_VOUCHER_TBL group by work_id ";
 ////System.out.println(" qry3:"+qry3); 
 Hashtable ht2= new Hashtable();
 Statement stmt3=conn.createStatement();
 ResultSet rs3=stmt3.executeQuery(qry3);
 while(rs3.next())
 {
	 ht2.put(rs3.getString(2),rs3.getString(1));
 }
while(rs.next())
{
	String target=""+ht.get(rs.getString(1));
	String  tarcomp=""+ht1.get(rs.getString(1));
	String  vamt=""+ht2.get(rs.getString(1));
	String msCount = ""+countht.get(rs.getString(1));
	if(msCount!=null && msCount.equals("null"))msCount="0";
	double samt=rs.getDouble(5);
	double vcamt=0.0,taramt=0.0,tarcopamt=0.0;
	if(vamt!=null && !vamt.equals("null")){vcamt=(Double.parseDouble(vamt)/100000);}else{vcamt=0.0;}
	if(target!=null && !target.equals("null")) {target=target; taramt=Double.parseDouble(target);
	} else {taramt=0.0; target="0";}
	if(tarcomp!=null && !tarcomp.equals("null")) {tarcomp=tarcomp;tarcopamt=Double.parseDouble(tarcomp);} else {tarcopamt=0.0; tarcomp="0";}
   double x=0.0;
   //////System.out.println("tarcopamt:"+tarcopamt);
  // ////System.out.println("taramt:"+taramt);
 if(tarcopamt ==0.0 &&  taramt==0.0){x=0.0;} 
else{x=(tarcopamt/taramt)*samt; }
   double y=x-vcamt;   


	//////System.out.println("x:"+x);
	//////System.out.println("y:"+y);
	%>
	<tr><td class=rptvalue><%=++count%></td>
	<td class=rptvalue><a href="rws_wrk_progress_resource_rpt.jsp?work_id=<%=rs.getString(1)%>"><%=rs.getString(1)%></td>
	<td class=rptvalue><%=rs.getString(2)%></td>
	<td class=rptvalue><%=rs.getString(3)%></td>
	<td class=rptvalue><%=rs.getString(4)%></td>
	<td class=rptvalue><%=rs.getString(6)%></td>
	<td class=rptvalue align=right><%=samt%></td>
	<%if(msCount!=null && !msCount.equals("0")) {%>
	<td class=rptvalue align=right><a href="#" onclick="wopen('./rws_work_milestone_rpt.jsp?workid=<%=rs.getString(1)%>','popup', 500, 400)" ><%=msCount%></a></td>
	<%}else{ %>
	<td class=rptvalue align=right><%=msCount%></td>
	<%}%>
	<td class=rptvalue align=right><%=target%></td>
	<td class=rptvalue align=right><%=tarcomp%></td>
	<td class=rptvalue align=right ><%=ndf.format(Math.round((y+vcamt)*100)/100f) %></td>
	<%
	String a=""+vcamt;
	if(a!=null && !a.equals("0.0")) {%>
	<td class=rptvalue align=right><a href="#" onclick="wopen('./rws_work_voucher_issued_rpt.jsp?workid=<%=rs.getString(1)%>','popup', 500, 400)" ><%=ndf.format(Math.round(vcamt*100)/100f)%></a></td>
	<%}else{ %>
	<td class=rptvalue align=right>0</td>
	<%}%>
	<%
	String b=""+y;
	if(b!=null && !b.equals("0.0")) {%>
	<td class="notice" align=right><font face=verdana size=2><%=ndf.format(Math.round(y*100)/100f)%></font></td>
	<%}else{ %>
	<td class=rptvalue align=right>0</td>
	<%}%>
	</tr>
	<%}
if(count==0)
{%>
<tr><td colspan=10 align="center">No Records Matching With This Selection Criteria</td></tr>
<%}
%>
</table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>


