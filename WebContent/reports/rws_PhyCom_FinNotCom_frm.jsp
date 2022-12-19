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
	//alert("in fun");	
		var logValue = '<%=loggedUser%>';
		//if(logValue=="admin" || logValue=="100000")
		//{
			if(document.f1.district.value=='')
			{
			    alert("Please Select District ");
				return false;
			}
			 if(document.f1.finyear.value=='')
			{
				alert("Please Select Financial Year");
				return false;
			}
			else if(document.f1.program.value=='')
			{
				alert("Please Select Programmes");
				return false;
			}
			
		
			else
		{
				//document.f1.drill.value='null';
				if(logValue=="admin" || logValue=="100000")
			{
			document.f1.distname.value = document.f1.district.options[document.f1.district.options.selectedIndex].text;
			}
			//document.f1.pname.value = document.f1.combo2.options[document.f1.combo2.options.selectedIndex].text;
			document.f1.action="./rws_PhyCom_FinNotCom_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=5>Physically Completed Financially notCompleted works</td>
	</tr>

<%
		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");
		Statement stmt2=null,stmt3=null;
try
{
%>
<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
           <option value="">-Select-</option>
           <option value="All">ALL</option> 
		 <%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
					<%
					}
				rs.close();			
				stmt.close();
				%></select>
				 
			<%
		}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				//dcode=rs.getString(1);
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
			<td class=btext>
			
				<input type="text" name="distname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%>

	
	  <%@ include file="/reports/financialYear.jsp" %>
</tr>
		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo2" style="width:140px" multiple size="10" class="hightlongcombo">

				<option value="">-select-</option>
				<%
				String progCode="";
				String nrdwpQuery="select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
				Statement statement=conn.createStatement();
				ResultSet  resultSet=statement.executeQuery(nrdwpQuery);
				while(resultSet.next()){
					if(!progCode.equals("")){
						progCode=progCode+","+resultSet.getString(1);
					}
					else{
						progCode=resultSet.getString(1);
					}
				}
				resultSet.close();
				//System.out.println("progCode"+progCode);
				if(!progCode.equals("")){
				%>
				<option value=<%=progCode%>>NRDWP Related</option>	
					<%
					}
					%>
			
<%
		stmt2 = conn.createStatement();
		String 	query2="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
		ResultSet rs2 = stmt2.executeQuery(query2);
		while(rs2.next())
		{%>
		<option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option> 
		<%}
		rs2.close();
		
%>
		</SELECT>
		</td>
		
		
		
<td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

				<option value="0">-select-</option>
				
<%
		stmt3 = conn.createStatement();
		String 	query3="select * from  rws_asset_type_tbl  order by 1";
		ResultSet rs3 = stmt3.executeQuery(query3);
		while(rs3.next())
		{%>
		<option value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option> 
		<%}
		rs3.close();
	
%>
		</SELECT>
		</td>
 
</tr>
		</tr>
		<%

}
catch(Exception e)
{
	System.out.println("THE ERROR IN DISTRICT... " +e);
	e.printStackTrace();
}
%>
<!-- end of habitations -->
<%
	//if(district != null ){	////////System.out..println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "footer.jsp" %>
<INPUT type="hidden" name="distname">
</form>
</body>
</html>

