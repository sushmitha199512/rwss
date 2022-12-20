<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="./conn.jsp"%>
<% 
response.setContentType("application/vnd.ms-excel");
response.setHeader("Content-Disposition", "inline; filename="
		+ "total_transaction_detail.xls");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Total Transactions</title>
</head>
<body>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");
	int sno=1;
	int styleCount=0;
    String style="";
		try{
		String sql="select to_char(Max(Report_Date),'dd/mm/yyyy') as Report_Date from Rws_Transaction_Tbl";
		//System.out.println("sqlFund"+sql);
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		if(rs.next()){			
		%>
		   <table width="80%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center  align=center>
		<td class="gridhdbg" colspan="17"><b>Molule Wise Updated Details for <%=rs.getString("Report_Date")  %></b></td>
		
		</tr>
  
	 <tr>
	
	<td class=gridhdbg>Sl.No</td>
    <td class=gridhdbg>Module</td>
    <td class=gridhdbg>Parameter</td>
    <td class=gridhdbg>Previous Month</td>
    <td class=gridhdbg>Reporting Month</td>
    <td class=gridhdbg>Cumulative Since Inception</td>
    
   
   
	
       </tr>

	
		
	
		<%
		List<String> listData = new ArrayList<String>();
		String moduleName="", data ="";
		String sqlFund="select MODULE,TRAN_PARAM,TRANS_CURR_MON,TRANS_PREV_MON,TRANS_TOT from Rws_Transaction_Tbl where to_char(Report_Date,'dd/mm/yyyy')='"+rs.getString("Report_Date")+"' order by module,TRAN_PARAM";
		//System.out.println("sqlFund"+sqlFund);
		Statement stmt1=conn.createStatement();
		ResultSet rs1=stmt1.executeQuery(sqlFund);
		while(rs1.next()){
			
			 if(styleCount%2==0){
				 style="gridbg1";
			 }else{
				 style="gridbg2";
			 }
			 styleCount++;
			 data = rs1.getString("MODULE")+rs1.getString("TRAN_PARAM")+rs1.getDouble("TRANS_PREV_MON")+rs1.getDouble("TRANS_CURR_MON")+rs1.getDouble("TRANS_TOT");
			//System.out.println("data :"+data);
			 if(!listData.contains(data)){
				 listData.add(data);
			
		%>
		<tr >
		<% if(moduleName.equals(rs1.getString("MODULE"))){%>
		<td class="<%=style%> "style="text-align: right;"></td>
		<td class="<%=style%> "style="text-align: left;"></td>
		<%}else{
			%>
			<td class="<%=style%> "style="text-align: right;"><%=sno++ %></td>
		<td class="<%=style%> "style="text-align: left;"><%=rs1.getString("MODULE") %></td>
		<%} %>
		<td class="<%=style%> "style="text-align: left;"><%=rs1.getString("TRAN_PARAM") %></td>
		
		<% if(rs1.getString("MODULE").equals("Funds")){%>
		<td class="<%=style%> "style="text-align: right;"><%=ndf.format(rs1.getDouble("TRANS_PREV_MON")) %></td> 
		<td class="<%=style%> "style="text-align: right;"><%=ndf.format(rs1.getDouble("TRANS_CURR_MON")) %></td> 
		<td class="<%=style%> "style="text-align: right;"><%=ndf.format(rs1.getDouble("TRANS_TOT")/100000) %>(In Lakhs)</td>
		<%}else{
			%>
			<td class="<%=style%> "style="text-align: right;"><%=rs1.getInt("TRANS_PREV_MON") %></td> 
		<td class="<%=style%> "style="text-align: right;"><%=rs1.getInt("TRANS_CURR_MON") %></td> 
			<td class="<%=style%> "style="text-align: right;"><%=rs1.getInt("TRANS_TOT") %></td>
		<%} %>
		
		</tr>
		<%
		moduleName=rs1.getString("MODULE");
			 }
		}
		rs1.close();
		stmt1.close();%>
	 
	 
	<%}
		rs.close();
		stmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		if(conn!=null)
			conn.close();
	} %>    
</table>

</body>
</html>