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

String cover_status=request.getParameter("coverage_status");
String status_date=request.getParameter("status_date");
session.setAttribute("status_date",status_date);
session.setAttribute("cover_status",cover_status);
Statement stmt2=conn.createStatement();
ResultSet rs2;
if(status_date.equals("4/1/2006 0:0:0"))
{
 rs2=stmt2.executeQuery("select a.coverage_status,b.dname,count(a.hab_code) from rws_habitation_dir_his_tbl a,rws_district_tbl b where coverage_status='"+cover_status+"' and substr(a.hab_code,1,2)=b.dcode group by a.coverage_status,b.dname");
}
else
{
	 rs2=stmt2.executeQuery("select a.coverage_status,b.dname,count(a.hab_code) from rws_habitation_directory_tbl a,rws_district_tbl b where coverage_status='"+cover_status+"' and substr(a.hab_code,1,2)=b.dcode group by a.coverage_status,b.dname");
}
%>

<center>
<table border=2 cellspacing=1>
<a href="rws_compare.jsp" align="right">BACK</a>
<tr bgcolor="#CCCCCC">
<td class=btext>
<font size=3 color="#9900FF">Sl.No</td>

<td class=btext>
<font size=3 color="#9900FF">Dname</td>

<td class=btext>
<font size=3 color="#9900FF">No.Of.Habitations</td>
</tr>
</th>
<%
int slno=0;
while(rs2.next())
{
	++slno;
%>
<tr bgcolor="#FFFFFF">
<td><font size=2><%=slno%></font></td>
<td><font size=2><%= rs2.getString(2)%></font></td>
<td><font size=2><a href="panch.jsp?dname=<%= rs2.getString(2)%>&coverage_status=<%=rs2.getString(1)%>"><%= rs2.getString(3)%></a></font></td>

</tr>
<% 
}


%>
</table>
</center>
</body>
</html>
<%@ include file="footer.jsp"%>