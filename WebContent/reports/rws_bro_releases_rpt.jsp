<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<%String year=request.getParameter("finyear");
    // System.out.println(" year:"+year);

	 Statement stmt1=null;
	 ResultSet rs1=null;
%>

<html>
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
<body>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home|
					<a href="javascript:history.go(-1)">Back</td> 
				</tr>
			</table>
		</caption>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=15> BRO Releases Report</td></tr>
<tr align=center >
    <td class=btext>Sl.No</td>
	<td class=btext>Bro Id</td>
	<td class=btext>Bro Reference</td>
	<td class=btext>Bro Date</td>
    <td class=btext>Budget Estimate</td>
    <td class=btext>Sanction Amount</td>
    <td class=btext>BRO Amount</td>
	<td class=btext>BRO Amount &nbsp;Allocation to&nbsp;Programs</td>
	<td class=btext>Loc Details</td>
	<td class=btext>Balance BRO Amount(7-8)</td></tr>
	<tr align=center >
			<td class=rptvalue><font color=red>1</font></td>
			<td class=rptvalue><font color=red>2</font></td>
			<td class=rptvalue><font color=red>3</font></td>
			<td class=rptvalue><font color=red>4</font></td>
			<td class=rptvalue><font color=red>5</font></td>
			<td class=rptvalue><font color=red>6</font></td>
			<td class=rptvalue><font color=red>7</font></td>
			<td class=rptvalue><font color=red>8</font></td>
			<td class=rptvalue><font color=red>9</font></td>
			<td class=rptvalue><font color=red>10</font></td>
			</tr>
  
<% int sno=1;
ArrayList brolist=new ArrayList();
String qry="SELECT  BRO_ID,BRO_REFERENCE," 
    	        	+ " to_char(BRO_DATE,'dd/mm/yyyy')BRO_DATE,BUDGET_ESTIMATE,SANCTION_AMOUNT," 
    				+ " BRO_AMOUNT  FROM rws_bro_master_tbl where fin_year='"+year+"' ";
stmt=conn.createStatement();
stmt1=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
	 brolist.add(rs.getString(1));
	 brolist.add(rs.getString(2));
	 brolist.add(rs.getString(3));
	 brolist.add(rs.getString(4));
     brolist.add(rs.getString(5));
     brolist.add(rs.getString(6));
}
for(int i=0;i<brolist.size();i++)
{
	
	%>
  <tr>
  <td class=rptValue><%=sno++%></td>
  <td class=rptValue nowrap><%=brolist.get(i)%></td>
  <td class=rptValue nowrap><%=brolist.get(i+1)%></td>
  <td class=rptValue><%=brolist.get(i+2)%></td>
  <td class=rptValue align=right><%=brolist.get(i+3)%></td>
  <td class=rptValue align=right><%=brolist.get(i+4)%></td>
  <td class=rptValue align=right><%=Double.parseDouble(""+brolist.get(i+5))%></td>
<%
String qry1="select (select  sum(AMT_NOW_AUTH ) from  rws_bro_details_tbl where bro_id='"+brolist.get(i)+"')a,(select sum(loc_amount) from rws_loc_master_tbl where bro_id='"+brolist.get(i)+"')b from dual ";
//System.out.println("sssss"+qry1);
rs1=stmt1.executeQuery(qry1);
rs1.next();
double amt1=rs1.getDouble(1);
double locamt=rs1.getDouble(2);
if(amt1>0.0) {
%>
<td class=rptvalue align=right><a href="#" onclick="wopen('./rws_bro_details_rpt.jsp?bro_id=<%=brolist.get(i)%>','popup', 500, 400)"><%=amt1%></a></td>
<%} else {%><td class=rptvalue align=right><%=amt1%></td>
<%}
if(locamt>0.0){%>
<td class=rptvalue align=right><a href="#" onclick="wopen('./rws_loc_details_rpt.jsp?bro_id=<%=brolist.get(i)%>','popup', 500, 400)"><%=locamt%></a></td>
<%}else{%><td class=rptvalue align=right><%=locamt%></td>
<%}%>
<td class=rptValue align=right><%=workData.round((Double.parseDouble(""+brolist.get(i+5))-amt1),2)%></td>
	<%
i+=5;
}%>

 </tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
</body>
</html>