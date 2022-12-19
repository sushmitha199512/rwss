<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<style type="text/css">
<!--

table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif
}

-->
</style>
<html>
<body  bgcolor="#edf2f8">
<table border = 0 width="600px">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
						<a href="rws_bill_release_to_bank.jsp">Close</a>|<a href="#" onclick="window.print()">Print</a>
					</td>
				</tr>
			</table>
		</caption>
</table>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	////System.out.println("user di:"+userid);
	DecimalFormat ndf = new DecimalFormat("####.00");
	double col4=0.0;
	Statement st1 = null;
	//Statement st = null;
	ResultSet rs1 = null;
try
{
	st1 = conn.createStatement();
	String q1 = "select substr(office_code,2,3),sum(bill_amount_central) from rws_bill_bank_bridge_temp_tbl group by substr(office_code,2,3)";
	rs1 = st1.executeQuery(q1);
	Hashtable ht1 = new Hashtable();
	while(rs1.next())
	{
		ht1.put(rs1.getString(1),rs1.getString(2));
	}
	String qry = "select dcode,division_office_code,dname,division_office_name from rws_district_tbl d,rws_division_office_tbl div where d.dcode=div.circle_office_code order by 1,2";
	  stmt = conn.createStatement();
	  rs = stmt.executeQuery(qry);
	  int count = 1;
	  %>
	<table border = 1 align=center bordercolor=navy style="border-collapse:collapse">
		<thead>
		<tr align="center">
			<th ><font face=verdana size=2><b>Sl. No</th>
			<th ><font face=verdana size=2><b>District</th>
			<th ><font face=verdana size=2><b>Division</th>
			<th><font face=verdana size=2><b>Amount(Rupees.)</B></font></th>
	</tr>
</thead>
<tbody>
<%
		int countt = 0;
		while(rs.next()){
		String release = ""+ht1.get(rs.getString(1)+rs.getString(2));
		if(release!=null && !release.equals("null")){}else{release="0";}
		col4 += Double.parseDouble(release);
		if(countt%2==0){%>
		<tr  class="normalRow">
			<td align="center" style="background:#FFFFFF; width:10px"><%=count++%></td>
			<td nowrap align="left" style="background:#FFFFFF" ><%=rs.getString(3)%></td>
			<td nowrap align="left" style="background:#FFFFFF" ><%=rs.getString(4)%></td>
			<td align="right"  style="background:#FFFFFF"><%=ndf.format(Double.parseDouble(release))%></td>
		<%}else{%>
		<tr  class="alternateRow">
			<td align="center" style="background:#C9C299; width:10px" ><%=count++%></td>
			<td nowrap align="left" style="background:#C9C299" ><%=rs.getString(3)%></td>
			<td nowrap align="left" style="background:#C9C299" ><%=rs.getString(4)%></td>
			<td align="right" style="background:#C9C299"><%=ndf.format(Double.parseDouble(release))%></td>
		<%}
		countt++;%>		
	</tr>
	  <%}
	  %>
		<tr class="normalRow">
			<td align="center" colspan=3 class=btext>Total</td>
			<td nowrap class="btext" align="right"><%=ndf.format(col4)%></td>
	  </tr>
	  <tr  class="alternateRow"><TD COLSPAN=4>&nbsp;</TD></TR>
	</tbody>
	</table>
<%}
	catch(Exception e){
	//System.out.println("error in report:"+e.getMessage());
	}
	finally{
	try{
		if(rs!=null)rs.close();if(stmt!=null)stmt.close();
		if(rs1!=null)rs1.close();if(st1!=null)st1.close();
		if(conn!=null)conn.close();
	}catch(Exception eee){eee.getMessage();}
	}%>
</body>
</html>