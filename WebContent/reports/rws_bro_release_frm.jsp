<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>

<html>
<head>
<script language="javascript">
function fnSubmit()
{
	if(document.f1.finyear.value=="")
	{
      alert("Please select Financial Year");
    }else{
		document.f1.action="./rws_bro_releases_rpt.jsp";
		document.f1.submit();
	}
}
</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>BRO Releases </td>	
	</tr>
	<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			 stmt = conn.createStatement();
			String query="SELECT distinct FIN_YEAR  FROM rws_bro_master_tbl order by FIN_YEAR desc";
			//System.out.println("qqq:"+query);
			 rs = stmt.executeQuery(query);
			while(rs.next())
			{
				
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> 
	<%
			}
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
%>
</td></tr>
<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>

</table>
</html>