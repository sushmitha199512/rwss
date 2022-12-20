<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
String query = null;
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
%>
<html>
<head>
<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
		if(document.forms[0].district.value=="0" )
		{
			alert("Please Select District");
			return false;
		}
		if(document.forms[0].finyear.value=="0")
		{
			alert("Please Select Year");
			return false;
		}
       if(document.forms[0].category.value=="0" )
		{
			alert("Please Select Category");
			return false;
		}
		if(loggedUser=="admin"||loggedUser=="100000")
				{
			document.forms[0].distname.value = document.forms[0].district.options[document.forms[0].district.options.selectedIndex].text;
				}
			document.forms[0].action="./rws_work_ongoing_rpt.jsp";
			document.forms[0].submit();
			}
</script>
</head>
<body bgcolor="#edf2f8">
<form   action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td>
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Ongoing Works - Habitations Benefitted Report</td>
	</tr>
<%
	String district="";
	district = request.getParameter("district");
	try
{
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")||loggedUser.equals("guest")||loggedUser.equals("psrwss")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
								
	if(rs.getString(1).equals(district))
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
						rs.close();			
						stmt.close();
		}
		else
		{
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				district=rs.getString(1);
	%>
				<input type="text" name="distname" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
	   <%@ include file="/commons/rws_works_financialYear.jsp" %>
		<tr><td class=rptLabel>Category&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="category" id="combo1" class="mycombo" style="width:150px">
		<option value='0'>Select</option>
		<option value='1'>Projects</option>
		<option value='2'>Normal</option>
		<option value='3'>District Level</option>
		 </SELECT></td>
		<%
}
catch(Exception e)
{
		e.printStackTrace();
}
%>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
</table>
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="distname">
</form>
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>
</body>
</html>

