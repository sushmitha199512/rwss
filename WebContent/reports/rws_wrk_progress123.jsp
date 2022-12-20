<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
	Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
	Statement ste1 = null,ste2=null,stmte=null,sse1=null;
	Statement st2 = null,st22=null,ss1=null,swc=null,pns=null;
	ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null,wcrs=null,pnrs;
	Statement stmt1 = null;
	ResultSet rs1 = null,rse=null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null,querywc=null,querypn=null;
	//String[] record = null;
	int Count=0,Cnt=0,slno=0,sl=0,Counts=0,ano=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	
	//String dCode = request.getParameter("dcode");
	//String schCode = request.getParameter("scheme");
	String wCode = request.getParameter("work_id");
	
	//// System.out.println("programme Name "+pName);
	 
	 
try
{
%>	

<html>
<head>
 <script>
   // window.history.forward(1);
 </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0  width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_hab_coverage_status_rpt.jsp?">Back|&nbsp;</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
	<td align="center" class="rptHeading" colspan=18>Work Progress Integrated Report</td>	
</tr>

</table>

		<%@ include file="./rws_admin_chklist.jsp" %>
	   	<%@ include file="./rws_tech_chklist.jsp"%>
		<%@ include file="./rws_workcompletion_chklist.jsp"%>
		<%@ include file="./rws_contract_chklist.jsp"%>
		<%@ include file="./rws_programsched_chklist.jsp"%>
		<%@ include file="./rws_workexpenditure_chklist.jsp"%>
<%
}//end of try brace
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
%>

</form>
</body>
<center><font color="navy" size=3><b>Designed & Developed by National Informatics Centre, AP State Centre</b></font></center>
</html>
