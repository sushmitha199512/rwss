<%@ include file = "header_rpt.jsp" %>
<%@ include file = "conn.jsp" %>

<%	try {
	ResultSet r1=null;
	//Statement stmt = null;
	
	String rDist = null;
%>

<html>
<head>
<title> WaterSoft </title>
<script language="JavaScript">
<!--
function fnSubmit()
{

	document.f1.action="./rws_om_proposal_list_rpt.jsp";
	document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("Please SELECT District");
	}
//-->
</script>
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
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=40%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			<tr>
				<td  class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
	</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
			<td algin="center" class="textborder" colspan="4"><font color="#FFFFFF">O & M Proposal List Print</font></td>	
		</tr>
	</table>

<table  bordercolor= navy width="40%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<td class = mystyle nowrap><font color=navy><b>Proposal Id</b> </font></td>
		<td class = mystyle><SELECT name="proposalId" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>		
<%
	rDist = request.getParameter("proposalId");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT om_proposal_id FROM rws_om_proposal_tbl order by om_proposal_id");
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(1) %>
			

<% 			

		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(1) %>
<%		
		} 
	}// END OF While

%>
</SELECT></td>
</tr>
</table>
<br>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=submit onclick="fnSubmit()" value=Submit class = btext></td>
	</tr>
</table>
</TD></TR>
</form>
<%@ include file = "footer.jsp" %>
</body>
</html>
<%} catch(Exception e)
{
			e.printStackTrace();
}
finally
{
	conn.close();
}
%>