<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%

	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.fromDate.value=='')
			{
				alert("Please Select  From Date");
				return false;
			}else if(document.f1.toDate.value=='')
			{
				alert("Please Select  To Date");
				
			}
					
			else
			{
				
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
					if(document.f1.district.value=="ALL"){
				document.f1.action="./rws_Wq_lab_view_alldist_rpt.jsp";
				}else{
				document.f1.action="./rws_WQ_lab_view_rpt.jsp";}
				document.f1.submit();
			}	
		}
		</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
	
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>DISTRICT WATER QUALITY PROFILE FOR LAB TESTING</td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
		
%>
	<tr><td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District&nbsp;&nbsp;<font color="red">*</font>

		<%
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px">
				<option value="">Select</option>	
					<%
			stmt = conn.createStatement();
			String query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				%>
				<option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option> 
				
				<% 
				}
				
				
				%>
				
	<%
		
		
	%>
	
	</tr>
			
			
					<tr align=center>
<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="20" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<td  align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendarFuture(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="20" height="17" border="0" alt="" align="absmiddle"/></a><td>
</tr>
<%

}
	catch(Exception e)
		{
				e.printStackTrace();
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
</form>
</body>
</html>