<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		//alert(document.f1.works[0].value);
		if(document.f1.district.value=='')
		{
			alert("Please Select District");
		}
		else if(document.f1.catcode.value=='')
		{
			alert("Please Select Work Category");
		}
		else if(document.f1.works[0].checked ||  document.f1.works[1].checked)
		{
			document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			document.f1.wcname.value = document.f1.catcode.options[document.f1.catcode.selectedIndex].text;
			document.f1.action="./rws_work_exp_works_frm.jsp";
			document.f1.submit();
		}

	}
	

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Payments Status Report</td>	
	</tr>
	<!-- Completed Works and their Payments-->
	<tr><td class=rptLabel colspan="2" align="center">
<input type="radio" value="1" name="works"  checked >Completed Works&nbsp;&nbsp;
<input type="radio" value="2" name="works" >Ongoing Works&nbsp;&nbsp;

</td>
	
<%
try
{
	String dcode = request.getParameter("district");
	if(dcode==null)dcode="";
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				if(rs.getString(1).equals(dcode))
				{
	%>
					 <option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
	<%
				}
				else
				{
	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
	<%
				}
			}
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
%>
		</SELECT>
		</td></tr>
		<tr><td class=rptLabel>Work Category&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="catcode" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			query="select distinct category_code,category_name from rws_work_category_tbl order by category_code";
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
	%>
					 <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
%>
</td></tr>
<%	
}catch(Exception e){}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="wcname">
</form>
</body>
</html>
