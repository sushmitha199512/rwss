
<%@ include file = "conn3.jsp" %>
<%if(request.getParameter("excel") != null && request.getParameter("excel").equals("1")){
response.setContentType("application/vnd.ms-excel");}
else
{ %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%} %>
<%		
	PreparedStatement stmt2 = null;
	//ResultSet rs1 = null;
	ResultSet rs2 = null;
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">


	

</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 0 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
		<%if(request.getParameter("excel") == null){%>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</a>|<a href="rws_head_of_acc_form.jsp?excel=1" target="_new">Excel</a></td> 
				<%} %>
			</tr>
			</table>
		</caption>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="16">
				<font color="#FFFFFF">Head Of Account Details </font>
			</td>	
		</tr>
		<tr>
	    <td class="btext" >S.NO.</td>
		<td class="btext" >Major Head Code</td>
		<td class="btext" >Major Head Name</td>
		<td class="btext" >Submajor Head Code</td>
		<td class="btext" >Submajor Head Name</td>
		<td class="btext" >Minor Head Code</td>
		<td class="btext" >Minor Head Name</td>
		<td class="btext" >Group Head Code</td>
		<td class="btext" >Group Head Name</td>
		<td class="btext" >Subhead Code</td>
		<td class="btext" >Subhead Name</td>
		<td class="btext" >Detailed Head Code</td>
		<td class="btext" >Detailed Head Name</td>
		<td class="btext" >Subdetailed Head Code</td>
		<td class="btext" >Subdetailed Head Name</td>
	<!-- 	<td class="btext" nowrap>Integrated Head Of Account</td> -->
	</tr>
	
		<%

	try
	{
	%>

		
	
<%
int slno = 0;
String qry = "";
	qry = "select distinct nvl(a.major_head_code,'-'),nvl(a.major_head_name,'-'),nvl(b.submajor_head_code,'-'),nvl(b.submajor_head_name,'-'),nvl(c.MINOR_HEAD_CODE,'-'),nvl(c.MINOR_HEAD_name,'-'),nvl(d.GRP_SUBHEAD_CODE,'-'),nvl(d.GRPr_SUBHEAD_name,'-'),nvl(e.SUBHEAD_CODE,'-'),nvl(e.SUBHEAD_name ,'-'),nvl(f.DETAIL_HEAD_CODE,'-'),nvl(f.DETAIL_HEAD_name,'-'), nvl(g.SUBDETAIL_HEAD_CODE,'-'),nvl(g.SUBDETAIL_HEAD_name,'-') from rws_majorhead_tbl a,rws_submajorhead_tbl b,rws_minorhead_tbl c,rws_groupsubhead_tbl d,rws_subhead_tbl e,rws_detailhead_tbl f,rws_subdetail_tbl g where a.major_head_code=b.major_head_code(+) and b.submajor_head_code=c.submajor_head_code(+) and c.minor_head_code=d.minor_head_code(+) and d.grp_subhead_code=e.grp_subhead_code(+) and e.subhead_code=f.subhead_code(+) and f.detail_head_code=g.detail_head_code(+)";
	System.out.println("Query:"+qry);
		Statement stt = conn.createStatement();
		ResultSet rep = stt.executeQuery(qry);
		while(rep.next())
		{
			++ slno;
%><tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue nowrap><%=rep.getString(1)%></td>
		<td class=rptValue nowrap><%=rep.getString(2)%></td>		
		<td class=rptValue nowrap><%=rep.getString(3)%></td>		
		<td class=rptValue nowrap><%=rep.getString(4)%></td>				
		<td class=rptValue nowrap><%=rep.getString(5)%></td>				
		<td class=rptValue nowrap><%=rep.getString(6)%></td>		
		<td class=rptValue nowrap><%=rep.getString(7)%></td>				
		<td class=rptValue nowrap><%=rep.getString(8)%></td>		
		<td class=rptValue nowrap><%=rep.getString(9)%></td>		
		<td class=rptValue nowrap><%=rep.getString(10)%></td>								
		<td class=rptValue nowrap><%=rep.getString(11)%></td>								
		<td class=rptValue nowrap><%=rep.getString(12)%></td>								
		<td class=rptValue nowrap><%=rep.getString(13)%></td>								
		<td class=rptValue nowrap><%=rep.getString(14)%></td>								
	<!-- <td class=rptValue nowrap><%=rep.getString(1)+" "+rep.getString(3)+" "+rep.getString(5)+" "+rep.getString(7)+" "+rep.getString(9)+" "+rep.getString(11)+" "+rep.getString(13)%></td>								
		-->
		</tr>
		<%}if(slno == 0){
		%>
		<tr>
		<td colspan="16" align="center"><font face="verdana" size="2" color="red">No Records</font></td>
		</tr>
		<%}%>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
		System.out.println("connclose");
	}%>