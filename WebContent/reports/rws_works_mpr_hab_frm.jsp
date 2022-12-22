 <%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/reports/conn.jsp" %>
<body>
<%
stmt = conn.createStatement();
String qry = "select c.*,a.hab_code,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU as totpop from RWS_WORKS_ACTION_PLAN_HABS_TBL a,rws_complete_hab_view c where a.hab_code=c.panch_code and a.work_id='"+request.getParameter("workId")+"'";
//System.out.println("qry:"+qry);
rs = stmt.executeQuery(qry);
int workCount = 1;
%>
<table border = 0 cellspacing = 0 cellpadding = 0 width=100%>
<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr align="right">
			<td class="bwborder">
				<a href="javascript:self.close()">Close</a>
			</td>
		</tr>
	</table>
</table>
<p align=center><font face=verdana size=3 color=blue>Habitations for the Work</font></p>
<table align="center" border = 1 cellspacing = 0 cellpadding = 0 bordercolor=#000000 style="border-collapse:collapse">
			<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>District</td>
			<td class=btext>Mandal</td>
			<td class=btext>Panchayat</td>
			<td class=btext>Village</td>
			<td class=btext>Habitation</td>
			<td class=btext>HabCode</td>
			<td class=btext>Status</td>
			<td class=btext>Population</td>
			</tr>
<%
while(rs.next())
{
%>
	<tr>
			<td class=rptValue><%=workCount++%></td>
			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(10)%></td>
			<td class=rptValue><%=rs.getString("hab_code")%></td>
			<td class=rptValue><%=rs.getString(12)%></td>
			<td class=rptValue  align=right><%=rs.getString("totpop")%></td>
	</tr>
<%
}
%>

</table>		
</body>