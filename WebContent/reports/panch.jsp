<%@ include file="header_rpt.jsp"%>
<%@ page import="java.text.DecimalFormat,ChartDirector.*,java.sql.*" %>
<%@ include file="conn3.jsp"%>
</head>
 <body bgcolor="#edf2f8">
 <table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="lavander" align="center">
			<td align="center" class="textborder" colspan="2" >
				<font color="#FFFFFF">Coverage Status Report</font>
			</td>	
		</tr>
	</table>
<%
String dname=request.getParameter("dname");
String status_date=(String)session.getAttribute("status_date");
String cover_status=(String)session.getAttribute("cover_status");
String coverage_status=request.getParameter("coverage_status");
Statement stmt3=conn.createStatement();
ResultSet rs3;
if(status_date.equals("4/1/2007 0:0:0"))
{
 rs3=stmt3.executeQuery("select b.hab_code,b.coverage_status,c.panch_name from rws_district_tbl a,rws_habitation_directory_tbl b,rws_panchayat_raj_tbl c where substr(b.hab_code,1,2)=a.dcode and  c.panch_code=b.hab_code and a.dname='"+dname+"' and  b.coverage_status='"+cover_status+"'");
}
else{
rs3=stmt3.executeQuery("select b.hab_code,b.coverage_status,c.panch_name from rws_district_tbl a,rws_habitation_dir_his_tbl b,rws_panchayat_raj_tbl c where substr(b.hab_code,1,2)=a.dcode and  c.panch_code=b.hab_code and a.dname='"+dname+"' and  b.coverage_status='"+cover_status+"'");
}
%>

<center>
<table border=2 cellsapcing=1>
<a href="districts.jsp" align="right">BACK</a>
<tr bgcolor="#CCCCCC">
<td class=btext>
<font size=3 color="#9900FF">Sl.No</td>
<td class=btext>
<font size=3 color="#9900FF">Hab Code</td>
<td class=btext>
<font size=3 color="#9900FF">Name Of The Panchayat</td>
</tr>
</th>
<%
int slno=0;
while(rs3.next())
{
	++slno;
%>
<tr bgcolor="#FFFFFF">
<td>
<font size=2><%= slno%></td>
<td>
<font size=2><%= rs3.getString(1)%></td>
<td>
<font size=2><%= rs3.getString(3)%></td>
</tr>
<% 
}
conn.close();
%>
</table>
</center>
</body>
</html>
<%@ include file="footer.jsp"%>
