<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<%
		List recs=(ArrayList)session.getAttribute("excelrecords");
		DecimalFormat ndf = new DecimalFormat("######.##");
 %>
<html>
<body>
		<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	ALIGN=CENTER>
	<caption>
	
	</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Contractor Status Report</td>
	</tr>


</table>
<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
	style="border-collapse:collapse" ALIGN=CENTER>
	<tr align=center>

		<td class=btext >Sl.No</td>
		<td class=btext >Contractor Code</td>
		<td class=btext >Contrator Name</td>
		<td class=btext >Pan/Votter ID</td>
		<td class=btext >No Of Works entrusted</td>
		<td class=btext >Estimate Cost<br>(In lakhs)</td>
		<td class=btext >Agreement Value <br>(In Rupees)</td>
		<td class=btext >No. of Works Completed</td>
		<td class=btext >Amount Released<br>(In Lakhs)<br>(Bank+Pao)</td>
		<td class=btext >No Of OnGoing Works</td>
		<td class=btext >Total Amount Pai<br>d(In lakhs)</td>
		<td class=btext >Balance Estimate cost<br>(In Lakhs)</td>
		
			


	</tr>
<%
 int sno=1;
			for(int i=0;i<recs.size();i++)
			{
			  String value=(String)recs.get(i);
			String records[]=value.split("@");
		
			%>
		<tr><td class=rptvalue><%=sno++ %></td><td><%=records[0] %></td><td class=rptvalue><%=records[1] %></td><td class=rptvalue><%=records[2] %>  /  <%=records[3] %></td><td><%=records[4] %></td><td class=rptvalue align=center><%=ndf.format(Double.parseDouble(records[5])) %></td><td class=rptvalue width="60" align=center><%=ndf.format(Double.parseDouble(records[6])) %> </td><td class=rptvalue align=center><%=records[7] %></td><td class=rptvalue align=center><%=ndf.format(Double.parseDouble(records[8])) %></td><td class=rptvalue align=center><%=records[9] %></td><td class=rptvalue align=center><%=ndf.format(Double.parseDouble(records[10])) %></td><td class=rptvalue align=center><%=ndf.format(Double.parseDouble(records[11])) %></td></tr>
<%
			}
 %>

</body>
</html>
