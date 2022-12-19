<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<html>
<head>
<script language="JavaScript">
function customlistenerMethod()
{
	var popFeatures = "width=900,height=450,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		myNewWin = window.open('./tot_transactions.jsp','newWinddow',popFeatures);
		myNewWin.focus();	
}
</script>
</head>
<body>
<table border = 0 cellspacing = 0 cellpadding = 0 width="80%"   style="border-collapse:collapse"  ALIGN=CENTER>
	<caption>
	
		<table border=0 rules=none style="border-collapse:collapse" align = "right">
		
			
	<tr align="right">
	
	<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; </td>
	<td ><a href="javascript:onclick=history.go(-1)">Back |&nbsp; </td>
	 <td align="right" class="bwborder">
					<a href="rws_reporting_parameterwise_xls.jsp">Excel
					</td>
	</tr>  
	
	<tr>
		<td colspan=2 align=center>
		<input type=button id="clm" onclick="return customlistenerMethod()" value="Get Data" class = btext></td>
	</tr>
	</table>
	</caption>
	
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