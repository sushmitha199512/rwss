<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn3.jsp" %>
<%
	//.out.println("*****FROM BEGINING*****");
	String query, query1, query2, query3, query4 = null;
	//ResultSet rs1 = null;
	//Statement stmt1 = null;	
%>
<html>
<head>

<script language="JavaScript">
        window.history.forward(1);

	function fnSubmit()
	{
		alert("hi");
		alert(document.f1.district.value);
		alert(document.f1.scheme.value);
		if(document.f1.district.value == "")
		{
			alert("Circle Mandatory...");
			return false;
		}
		
		if(document.f1.scheme.value == "")
		{
			alert("Scheme Mandatory...");
			return false;
		}
		
		document.f1.action="./rws_spill_new_compl_works.jsp?district="+document.f1.district.value+"&scheme="+document.f1.scheme.value;
		document.f1.submit();		
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=250>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Spill/New  Works Report</font></td>	
	</tr>
<%
	String rDist= null,rWork=null,rDiv=null,rSubDiv=null,rScheme=null,rYear=null;
	
try
{
%>
	<tr>
		<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo">
			
		<%
		stmt = conn.createStatement();
		query = "SELECT distinct circle_office_code,d.circle_office_name from rws_circle_office_tbl d order by  d.circle_office_code";
		rs = stmt.executeQuery(query);
		//System.out.println("CIRCLE OFFICE QUERY"+query);
		
		while(rs.next())
		{
							
%>
		<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
		}
		%>
		</select></td></tr>
		<tr>
		<td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="scheme" style="width:150px" class="mycombo">
			
		<%
		stmt1 = conn.createStatement();
		query = "select * from rws_work_category_tbl order by category_code";
		rs1 = stmt.executeQuery(query);
		//System.out.println("CIRCLE OFFICE QUERY"+query);
		
		while(rs1.next())
		{
							
%>
		<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
<%
		}
		%>
		</select></td></tr>
		
		<%
	}
	catch(Exception e)
	{
		e.printStackTrace();
	}
	finally
	{
		conn.close();
	}
%>
<tr rowspan="2"><td colspan="2">&nbsp;</td></tr>
<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>