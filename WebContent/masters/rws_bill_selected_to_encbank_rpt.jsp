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
<body  >
<table >	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" >
						<a href="#" onclick="window.close()"> Close</a>|<a href="#" onclick="window.print()">Print</a>
					</td>
				</tr>
			</table>
		</caption>
</table>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	  if(userid!=null && ! (Constants.EE_BUDGET.equals(users.getUserId()))){
	   	   response.sendRedirect("../commons/rws_not_authorization.jsp");
	      }
	DecimalFormat ndf = new DecimalFormat("####.00");
	double col4=0.0;
	Statement st1 = null;
	ResultSet rs1 = null;
try
{
	st1 = conn.createStatement();
	String q1 = "select substr(office_code,2,3),sum(BILL_AMOUNT_CENTRAL) from rws_bill_bank_bridge_temp_tbl group by substr(office_code,2,3)";
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
	<table border = 0 align=center  style="border-collapse:collapse">
		<thead>
		<tr align="center">
			<td class="gridhdbg">Sl. No</td>
			<td class="gridhdbg">District</td>
			<td  class="gridhdbg">Division</td>
			<td class="gridhdbg">Amount(Rupees.)</td>
	</tr>
</thead>
<tbody>
<%
		int countt = 0;
           int styleCount=0;
           String style="";
		while(rs.next()){
		String release = ""+ht1.get(rs.getString(1)+rs.getString(2));
		if(release!=null && !release.equals("null")){
			
		}else{
			release="0";
			continue;
		}
		col4 += Double.parseDouble(release);
		
		if(styleCount%2==0){
			 style="gridbg1";
		 }else{
			 style="gridbg2";
		 }
		%>
		<tr >
			<td class=<%=style %> style="text-align: left;"><%=count++%></td>
			<td class=<%=style %> style="text-align: left;" ><%=rs.getString(3)%></td>
			<td class=<%=style %> style="text-align: left;" ><%=rs.getString(4)%></td>
			<td class=<%=style %> style="text-align: right;"><%=ndf.format(Double.parseDouble(release))%></td>
		
				
	</tr>
	  <%
	  styleCount++;
		}
	  %>
		<tr class="gridhdbg">
			<td style="text-align: right;" colspan=3 >Total</td>
			<td nowrap style="text-align: right;"><%=ndf.format(col4)%></td>
	  </tr>
	  
	  	</tbody>
	</table>
<%}
	catch(Exception e){
  System.out.println("Exception in rws_bill_selected_to_encbank_rpt.jsp: "+e.getMessage());
	}
	finally{
	try{
		if(rs!=null)rs.close();if(stmt!=null)stmt.close();
		if(rs1!=null)rs1.close();if(st1!=null)st1.close();
		if(conn!=null)conn.close();
	}catch(Exception x){  System.out.println("Exception in rws_bill_selected_to_encbank_rpt.jsp: "+x.getMessage());}
	}%>
</body>
</html>