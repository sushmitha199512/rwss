<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dddcode="";
	if(loggedUser.substring(0,3).equals("col")){
		dddcode=(String)session.getAttribute("district");    
	   }
	%>
<html>
<head>

<script language="JavaScript">
	
		function fnSubmit1()
	{
		
		 
            var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}		
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" || loggedUser=="secrwss")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
								
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;

					
				}
               // alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_school_eduinsti_rpt.jsp";
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
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>



			</table>
		</caption>
	<%
try
{
	String dcode = request.getParameter("district1");
	String divcode = request.getParameter("division");
	String dcode1 = request.getParameter("district1");
	String divcode1 = request.getParameter("division");
%>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Schools-Educational Institutions</td>	
	</tr>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")||loggedUser.equals("secrwss") || loggedUser.substring(0,3).equals("col")))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";
			if(dddcode!=null && !dddcode.equals("")){
				query+=" and dcode='"+dddcode+"'";
			}
			query+=" order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode1))
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
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode1=rs.getString(1);
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="mandal" id="combo" class="mycombo" style="width:150px"  >
				<option value="">-Select-</option>
<%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct mcode,mname from rws_mandal_tbl   where dcode='"+dcode+"' order by mname";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(divcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
	<%}
			}
						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
    </td></tr>

	<%	
}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" colspan=3 class=btext>
			<input type="button" name="reptype"  value="Get Report" onclick="fnSubmit1();"/>
           </td>
	</tr>


</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="dname1">
<INPUT type="hidden" name="mname1">


</form>
</body>
</html>