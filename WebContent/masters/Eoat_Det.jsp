<%@ page import="java.sql.*"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "/reports/conn3.jsp" %>
</head>
<body topmargin="0" leftmargin="0" bgcolor="#edf2f8">
 
<table align=center>
<tr><td align=right><a href="" onclick="javascript:window.close()">Close</a></td></tr>
<tr><td>
<table border=2 align=center style="border-collapse:collapse;" bordercolor="#8A9FCD" bgcolor="#ffffff">
<tr>
<tr bgcolor="#8A9FCD"><td colspan=5><b><font face=verdana size=2 color="#ffffff">EOAT Details</font></b></td></tr>
<td class="clrborder"><font color='maroon'><B>SNo</B></td>
<td class="clrborder" nowrap><font color='maroon'><B>Work Details</B></td>
<td class="clrborder"><font color='maroon'><B>EOAT DATE</B></td>
<td class="clrborder"><font color='maroon'><B>EOAT PERIOD (DAYS)</B></td>
</tr>

<%
try
{
	//System.out.println("request.getParameter(code)"+request.getParameter("code"));
	Statement st = conn1.createStatement();
	 rs = st.executeQuery("SELECT work_id,to_char(eoat_dt,'mm/dd/yyy'),EOAT_PERIOD FROM RWS_contract_EOAT_tbl where CONTRACTOR_CODE=to_number("+(request.getParameter("code"))+")");
	while(rs.next())
	{
	%>
	<tr >
	<td align=center class="bwborder"><%=rs.getRow()%></td>
	<td align=center class="bwborder"><%=rs.getString(1)%>&nbsp;-&nbsp;</td>
	<td class="bwborder"><%=rs.getString(2)%></td>
	<td class="bwborder"><%=rs.getString(3)%></td>
	</tr>
	
<%
	}
}
catch(Exception e)
{
	//System.out.println("Exception="+e);
}

%>
</tr>
</table>
</td></tr>
</table>
</body>
</html>