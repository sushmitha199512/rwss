<%@ include file="/commons/rws_header1.jsp"%>
<%@include file="/commons/rws_header4.jsp" %>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>
<%@page import="org.apache.commons.lang.StringUtils"%>
<html>
<%

/* nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId(); */
%>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
			document.f1.action="./rws_asset_hab_abstract_home_rpt.jsp";
				document.f1.submit();
		}
		</script>

</head>


<body>
<form name=f1  action="<%= request.getRequestURI()%>" method="post">

<br>
<br>
<br>
<br>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
	<tr align="right">
	<td ></a><a href="javascript:onclick=history.go(-1)">Back  &nbsp; </a></td>
	</tr>  
	</table>
	</caption>
	<tr>
		<td class=rptLabel align="center" colspan=3>Habitation & Assets Report</td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
%>
<%
		
		/* if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)))
		{ */
		%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		
			<SELECT name="district" id="combo" class="mycombo" style="width:150px">
						<option value="00">ALL</option>
		<%System.out.println("------------>>>--60----");
			stmt = conn.createStatement();
			String query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dcode";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<% System.out.println("----"+rs.getString(1) + "-------->>>--60----"+rs.getString(2));%>
				<%
				}
				rs.close();			
				stmt.close();
				
	%>
	</SELECT>
	</td>
	</tr>
<%
		/* }
		else
		{
			
							stmt = conn.createStatement();
							
						String	query = "select dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"' ";
							
							rs = stmt.executeQuery(query);	
							if(rs.next())
							{
						 */		
							
	%>
	
	<%-- <tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<input type="text" name="dname" value=<%=rs.getString(2)%> class="mytext" style="width:150px" readonly/>
				
				<input type="hidden" name="district" value="<%=rs.getString(1)%>"/>
				</td>
				</tr> --%>
	<%
	/* 
			}
							stmt.close();
							rs.close();
										 */
						
		
	%>
	


	<%
//}	
}
	catch(Exception e)
		{
   e.printStackTrace();
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Details">
	</td>
	</tr>
</table>

<center><%@ include file = "/commons/rws_footer.jsp" %></center>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="sname">
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>



</form>
</body>

</html>