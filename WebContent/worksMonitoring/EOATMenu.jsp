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

    System.out.println("test1...................");
    %>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			if(document.f1.division.value=='')
				{
				alert("Please Select Division");
				return false;
				
				}
			if(document.f1.subdivision.value=='')
			{
			alert("Please Select Sub Division");
			return false;
			
			}
			if(document.f1.year.value=='')
			{
			alert("Please Select Year");
			return false;
			
			}
			if(document.f1.programme.value=='')
			{
			alert("Please Select Programme");
			return false;
			
			}
					
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
				
				}
				//alert(document.f1.dname.value);
				document.f1.action="./EOATReport.jsp";
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
		<td align="center" class="rptHeading" colspan=3>EOAT Report</td>	
	</tr>
	<%
try
{
	
	//String dcode = request.getParameter("district");
	//StringBuffer dcode=new StringBuffer(request.getParameter("district")!=null?request.getParameter("district"):"");
StringBuffer dcode = new StringBuffer();
dcode.append(request.getParameter("district"));
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)))
		{
			
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="51">-ALL-</option>
		<%
			stmt = conn.createStatement();
		    query.append("SELECT distinct circle_office_code,circle_office_name  from rws_circle_office_tbl  order by circle_office_name");
			rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(circle_office_code.toString()))
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
				
				// division begin
				
			
				//division end
				
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
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
			
			
			<!--  <tr align=center>
<td align="center" class=rptvalue> Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendar(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
	-->
	
	
<tr><td class=rptLabel>Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="year1" id="combo" class="mycombo" style="width:150px"  >
				<option value="">-Select-</option>
		<%
		Statement stmt3 = conn.createStatement();
		query.delete(0,query.length());        
		query.append("select  distinct year from RWS_DROUGHT_HABITATION_TBL where year in('2012','2013','2014','2015','2016') order by year desc");
		
		    //System.out.println("year:"+query.toString());
			ResultSet rs3 = stmt3.executeQuery(query.toString());
			while(rs3.next())
			{%>
			 <option value="<%=rs3.getString(1)%>" ><%=rs3.getString(1)%></option> 
	<%}
			%>
			</select></td>
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