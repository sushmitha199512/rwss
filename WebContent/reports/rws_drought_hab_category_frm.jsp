<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>


<%
	//String query = null;
StringBuffer query=new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.dcode.value=='')
			{
				alert("Please Select District");
				return false;
			}
			if(document.f1.statusDate.value=='')
				{
				alert("Please Select Status On Date");
				return false;
				
				}
					
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" ||loggedUser=="secrwss" ||loggedUser=="minrwss")
				{
					document.f1.dname.value = document.f1.dcode.options[document.f1.dcode.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.dcode.value;
				
				}
				//alert(document.f1.dname.value);
				document.f1.action="./rws_drought_hab_category_rpt.jsp";
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
			
			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>



	
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Drought Habitations Report Based on Category</td>	
	</tr>
	<%
try
{
	
	//String dcode = request.getParameter("district");
	//StringBuffer dcode=new StringBuffer(request.getParameter("district")!=null?request.getParameter("district"):"");
StringBuffer dcode = new StringBuffer();
dcode.append(request.getParameter("dcode"));
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.MINISTER) || loggedUser.toString().equals(Constants.SEC_USER)))
		{
			
		%>
			<SELECT name="dcode" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="ALL">-ALL-</option>
		<%
			stmt = conn.createStatement();
		query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
			rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode.toString()))
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
			//// ////System.out.println("in selected dist:");
			stmt = conn.createStatement();
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
				
				//dcode=rs.getString(1);
				dcode=new StringBuffer(rs.getString(1));
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="dcode" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
		
	
<tr><td class=rptLabel>Status On Date&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<input type="text" name=statusDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].statusDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a>
		</td>
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
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">

</form>
</body>
</html>