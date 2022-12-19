<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%	
	/* nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId(); */
	Statement st1=null,st2=null,st3=null,st4=null;
	ResultSet rs1 = null,rs2 = null,rs3 = null,rs4=null;

	int fcgtotal = 0, pc1gtotal = 0, pc2gtotal = 0, pc3gtotal = 0, pc4gtotal = 0, ncgtotal = 0, nssgtotal = 0, uitotal=0, nodatatotal=0;		
	String query = null,qu=null, a1="",codename=null,mand=null,mname=null,dist=null,dname=null,panch=null,pname=null,vill=null,vname=null,habcode=null,hname=null,code=null,sourcecode=null;
     
	 code=request.getParameter("code");
	 dist=request.getParameter("dcode");
	 mand=request.getParameter("mcode");
	 panch=request.getParameter("pcode");
	 habcode=request.getParameter("hcode");
	%>
<html>
<title> WaterSoft </title>
<head>

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}


</style>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">


<table border = 1 cellspacing = 0 cellpadding = 0 width=50% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
				<%-- <% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><a href="javascript:history.back(-1)">Back|</a><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="javascript:history.back(-1)" >Back</td></tr>
<%} %> --%>
<tr><a href="javascript:history.back(-1)">Back|</a><a href="/pred/rws_login_frm.jsp">Home</td></tr>
	</table>
</caption>
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan=13 >
			<font color="ffffff">Status Report </font></td>
	</tr>
	<%if(code.equals("HP"))
	{ %>
	<tr>
			
		<td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>HP Code</td>
		<td class="btext" align=center>HP Location</td>
		<td class="btext" align=center>Status</td>
		<td class="btext" align=center>As On</td>
		<td class="btext" align=center>FLORIDE</td>
		<td class="btext" align=center>IRON</td>
		<td class="btext" align=center>TDS</td>
		<td class="btext" align=center>NITRATE</td>
		<td class="btext" align=center>PH Value</td>
		</tr>
		
	<%}else
	{ %>
	<tr>
			
		<td class="btext" align=center>S.NO.</td>
		<td class="btext" align=center>SourceCode/<br/>Source Name</td>
		<td class="btext" align=center>Source Location</td>
		<td class="btext" align=center>Status</td>
		<td class="btext" align=center>As On</td>
		<td class="btext" align=center>FLORIDE</td>
		<td class="btext" align=center>IRON</td>
		<td class="btext" align=center>TDS</td>
		<td class="btext" align=center>NITRATE</td>
		<td class="btext" align=center>PH Value</td>
		</tr>
		
	 <%
	}
try
{
	 int slno=0,total=0;
st1=conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
String testValueQuery="";

	if(code.equals("HP"))
	{
		String hpCountQuery=" select HP_CODE,nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from RWS_HP_SUBCOMP_PARAM_TBL where substr(HP_CODE,1,16)='"+habcode+"' and substr(asset_code,7,2)='04'";
		String shpCountQuery=" select SHALLOWHP_CODE,nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from RWS_SHALLOWHANDPUMPS_TBL where hab_code='"+habcode+"'";
		st2=conn.createStatement(); 
		rs2=st2.executeQuery(hpCountQuery);
		while(rs2.next()){
			
		
		%>
		<tr>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><%=rs2.getString(1) %></td>
		<td class=rptValue align="left"><%=rs2.getString(2) %></td>
		<td class=rptValue align="left"><%=rs2.getString(3) %></td>
		<%
		String maxDate="select nvl(to_char(max(PREPARED_ON),'dd/mm/yyyy'),'-') from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where TEST_CODE ='1' and a.TEST_ID =b.TEST_ID and source_code='"+rs2.getString(1)+"'";
		//System.out.println("maxDate---"+maxDate);
		st4=conn.createStatement(); 
		rs4=st4.executeQuery(maxDate);
		if(rs4.next()){
			//System.out.println("11111111111111");
			%>
			<td class=rptValue align="left"><%=rs4.getString(1) %></td>
			<%
			if(!rs4.getString(1).equals("-")){
		  testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where  a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='13' and source_code='"+rs2.getString(1)+"'";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
			%>
			<td class=rptValue align="right"><%=rs3.getString(1) %></td>
			
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='16' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='05' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='15' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='04' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		}
			else{
				%>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<%
			}
		
		}
		st4.close();
		rs4.close();
		%>
        </tr>
		<%
		}
		
		st2.close();
		rs2.close();
		
		st2=conn.createStatement(); 
		rs2=st2.executeQuery(shpCountQuery);
		//System.out.println(shpCountQuery);
		while(rs2.next()){
			
		
		%>
		<tr>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><%=rs2.getString(1) %></td>
		<td class=rptValue align="left"><%=rs2.getString(2) %></td>
		<td class=rptValue align="left"><%=rs2.getString(3) %></td>
		<%
		String maxDate="select nvl(to_char(max(PREPARED_ON),'dd/mm/yyyy'),'-') from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where TEST_CODE ='1' and a.TEST_ID =b.TEST_ID and source_code='"+rs2.getString(1)+"'";
		//System.out.println("maxDate---"+maxDate);
		st4=conn.createStatement(); 
		rs4=st4.executeQuery(maxDate);
		if(rs4.next()){
			//System.out.println("2222222222222");
			%>
			<td class=rptValue align="left"><%=rs4.getString(1) %></td>
			<%
			if(!rs4.getString(1).equals("-")){
		  testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where  a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='13' and source_code='"+rs2.getString(1)+"'";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
			%>
			<td class=rptValue align="right"><%=rs3.getString(1) %></td>
			
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='16' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='05' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='15' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='04' and source_code='"+rs2.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right">&nbsp;<%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
			}
			else{
				%>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				<td class=rptValue align="right">--</td>
				
				<%
			}
		
		}
		st4.close();
		rs4.close();
		%>
        </tr>
		<%
		}
		st2.close();
		rs2.close();
	}
	else{
	 if(code.equals("PWS"))
	{
		qu="select SOURCE_CODE,nvl(SOURCE_NAME,'-'),nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from rws_source_tbl where hab_code='"+habcode+"' and substr(asset_code,7,2)='01'";
	}
	else if(code.equals("MPWS"))
	{
		qu="select SOURCE_CODE,nvl(SOURCE_NAME,'-'),nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from rws_source_tbl where hab_code='"+habcode+"' and substr(asset_code,7,2)='02'";
	}
	else if(code.equals("CPWS"))
	{
		qu="select SOURCE_CODE,nvl(SOURCE_NAME,'-'),nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from rws_source_tbl where hab_code='"+habcode+"' and substr(asset_code,7,2)='03'";
	}
	else if(code.equals("DP"))
	{
		qu="select SOURCE_CODE,nvl(SOURCE_NAME,'-'),nvl(LOCATION,'-'),nvl(decode(status,'W','Working','N','Not Working','C','Condemned','D','Dried','S','Seasonal'),'--') from rws_source_tbl where hab_code='"+habcode+"' and substr(asset_code,7,2)='09'";
	}
	
	 rs1=st1.executeQuery(qu);
	
	while(rs1.next())
	{
	
	
	%>  <tr>
		<td class=rptValue align="left"><%=++slno%></td>
        <td class=rptValue align="left"><%=rs1.getString(1) %>/<br/><%=rs1.getString(2) %></td>
		<td class=rptValue align="left"><%=rs1.getString(3) %></td>
		<td class=rptValue align="left"><%=rs1.getString(4) %></td>
		<%
		String maxDate="select nvl(to_char(max(PREPARED_ON),'dd/mm/yyyy'),'-') from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where TEST_CODE ='1' and a.TEST_ID =b.TEST_ID and source_code='"+rs1.getString(1)+"'";
		//System.out.println("maxDate---"+maxDate);
		st4=conn.createStatement(); 
		rs4=st4.executeQuery(maxDate);
		if(rs4.next()){
			
			%>
			<td class=rptValue align="left"><%=rs4.getString(1) %></td>
			<%
			if(!rs4.getString(1).equals("-")){
		  testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where  a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='13' and source_code='"+rs1.getString(1)+"'";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
			%>
			<td class=rptValue align="right"><%=rs3.getString(1) %></td>
			
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='16' and source_code='"+rs1.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='05' and source_code='"+rs1.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='15' and source_code='"+rs1.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
		testValueQuery="select TESTING_PARAMETER_VALUE from  RWS_WQ_TEST_RESULTS_LNK_TBL a, RWS_WQ_TEST_RESULTS_TBL b where a.TEST_ID =b.TEST_ID  and TEST_CODE ='1' and PREPARED_ON=to_date('"+rs4.getString(1)+"','dd/mm/yyyy') and TESTING_PARAMETER_CODE='04' and source_code='"+rs1.getString(1)+"' group by TESTING_PARAMETER_VALUE  order by max(PREPARED_ON) desc";
		st3=conn.createStatement(); 
		rs3=st3.executeQuery(testValueQuery);
		if(rs3.next()){
		%>
		<td class=rptValue align="right"><%=rs3.getString(1) %></td>
		
			<%
		}
		st3.close();
		rs3.close();
			}
			else{
			%>
			<td class=rptValue align="right">--</td>
			<td class=rptValue align="right">--</td>
			<td class=rptValue align="right">--</td>
			<td class=rptValue align="right">--</td>
			<td class=rptValue align="right">--</td>
			<%
			}
		}
	st4.close();
	rs4.close();
		%>
         </tr>
		
		
	
<% 	
	}}}
catch(Exception e)
{
	e.printStackTrace();
}
finally
{
	conn.close();
}
%>
</table>


<%@ include file = "footer.jsp" %>
</form>
</body>
</html>

