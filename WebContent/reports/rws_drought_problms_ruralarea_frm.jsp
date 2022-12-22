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
	String qry3="";
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		//alert(1);
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			if(document.f1.date.value=='')
				{
				alert("Please select From Date");
				return false;
				}
			if(document.f1.date1.value=='')
			{
			alert("Please select ToDate");
			return false;
			}
			
			 else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" ||loggedUser=="1000DR" )
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
					document.f1.date.value = document.f1.date.options[document.f1.date.selectedIndex].text;
					
					 
					
				}
				else 
				{
					document.f1.dname.value = document.f1.district.value;
					document.f1.date.value = document.f1.date.options[document.f1.date.selectedIndex].text;
			
					
				}
					
			
				document.f1.action="./rws_drought_problms_ruralarea_rpt.jsp";
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
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>News Paper Clippings</td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
	String date = request.getParameter("date");
	String date1=request.getParameter("date1");
	
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("1000DR")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
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
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

	<tr><td class=rptLabel>From Date&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="date" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				<option value="">-Select-</option>
				
            <%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			
			
			query="select  to_char(PAPER_DATE,'dd/mm/yyyy') from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where substr(hab_code,1,2)='"+dcode+"'  order by to_char(PAPER_DATE,'dd/mm/yyyy')  ";
			//System.out.println("qqqfrm date:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				if(rs2.getString(1).equals(date)){
	%>
	
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(1)%></option> 
	<%} else { %>
					 
				<option value="<%=rs2.getString(1)%>" ><%=rs2.getString(1)%></option> 	
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
    </td>
	</tr>
	
		<tr><td class=rptLabel>To Date&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="date1" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				<option value="">-Select-</option>
				
            <%if(date!=null && !date.equals("")) {
			Statement stmt2 = conn.createStatement();
			
			
			query="select  to_char(PAPER_DATE,'dd/mm/yyyy') from RWS_DROUGHT_NEWSPAPER_ITEM_TBL where substr(hab_code,1,2)='"+dcode+"'  and PAPER_DATE>=to_date('"+date+"','dd/mm/yyyy') order by to_char(PAPER_DATE,'dd/mm/yyyy') ";
			//System.out.println("qqq to date:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				if(rs2.getString(1).equals(date1)){
				
	%>
	
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(1)%></option> 
	<%} else{  %>
	
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(1)%></option> 
					
	<%}
			}	

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
    </td>
	</tr>
	
	
	
	<%
}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="sname">
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>



</form>
</body>
</html>