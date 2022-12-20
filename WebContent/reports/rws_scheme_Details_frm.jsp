<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%@page import="javax.sql.DataSource" %>
<%
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	//System.out.println("user:::"+loggedUser);
	String dcode = request.getParameter("district");
	//System.out.println("dcode:::"+dcode);
	  
	String query = null;
	int sno=1;
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.util.Date currentDate = new java.util.Date();
	String currentMonth = dateFormat.format(currentDate).substring(5,7);
	//System.out.println("The Current Month::"+currentMonth);
		WorksData1 wd = new WorksData1();
	int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	String month="";
	String aType="";
	
%>
<script>
 
  function fnSubmit()
	{
			//alert("in");
			var user = '<%=loggedUser%>';
			if(user=="admin" || user=="100000" || user=="guest")
			{
				if(document.f1.district.value=='')
				 {
					alert("Please Select District");
					return false;
				 }
			else  if(document.f1.scheme.value=='')
				 {
				alert("Please Select Scheme");
				return false;
				}
			else if(document.f1.category.value=='')
				{
				alert("Please Select category");
				return false;
				}
			else 	if(document.f1.program.value=='')
				{
				alert("Please Select Program");
				return false;
				}
				else
			{
			var vals = '';
			document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			for(var i=0;i<document.f1["program"].options.length;i++){
			if(document.f1["program"].options[i].selected==true)
			vals = vals + (document.f1["program"].options[i].text)+",";
			}
					
			document.f1.pname.value = vals.substring(0,vals.length-1);
			//alert(document.f1.pname.value );
			//alert(document.f1.pname.value);
			document.f1.sname.value = document.f1.scheme.options[document.f1.scheme.selectedIndex].text;
			//alert(document.f1.sname.value);
			document.f1.action="./rws_scheme_Details_list.jsp";
			document.f1.submit();
			}
			
			}
			else
			    {
			//alert("in 1");
			if(document.f1.scheme.value=='')
			{
			alert("Please Select Scheme");
			return false;
			}
			else if(document.f1.category.value=='')
			{
			alert("Please Select category");
			return false;
			}
			else 	if(document.f1.program.value=='')
			{
			alert("Please Select Program");
			return false;
			}
			else
			{
				document.f1.action="./rws_scheme_Details_list.jsp";
				document.f1.submit();
			}
			}
			}
	
	

</script>
<html>

<head>
<title></title>

 </head>
<body bgcolor="#edf2f8">
 <form name="f1"> 
<BR>
<BR>
<BR>
<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="40%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					
					<td align="right" class="bwborder">
					<a href="javascript:history.go(-1)">Back</a>|
					<a href="../home.jsp">Home</a>
					
					</td>
				</tr>
			</table>
		</caption>
		<tr bgcolor="#8D9EAF" align="center">
		<td align="center" class="rptHeading" colspan=2><font style="text-transform: uppercase;">Progress Report of  Schemes </font></td>	
		</tr>
		<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  >
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
		 <tr>
	<td class=rptLabel>Scheme &nbsp;&nbsp;<font color="red">*</font></td>
	<td><SELECT name="scheme" id="combo" class="mycombo" style="width:150px" >
      <option> - Select - </option>
		<option value="03">CPWS</option>
		<option value="01">PWS</option>
		<option value="02">MPWS</option>
		</select>
		</tr>
		<tr><td class=rptLabel>Category&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="category" id="combo2" style="width:150px" >
		<option value="">-select-</option>
<%
			Statement stmt3 = conn.createStatement();
			String 	query3="SELECT * from rws_work_category_tbl  order by 1 ";
			ResultSet rs3 = stmt3.executeQuery(query3);
			while(rs3.next())
			{%>
				<option value="<%=rs3.getString(1)%>" ><%=rs3.getString(2)%></option> 
			<%}
			rs3.close();
			stmt3.close();
%>
		</SELECT>
		</td></tr>
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
	    Statement stmt2 = conn.createStatement();
		String 	query2="select * from  rws_programme_tbl  where NRDWP_RELATED='N' order by 1";
		ResultSet rs2 = stmt2.executeQuery(query2);
		while(rs2.next())
		{%>
		<option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option> 
		<%}
		rs2.close();
		
%>
		</SELECT>
		</td></tr>
		<tr align="center">
		<td colspan=2 align=center>
		<input type=button value="View Report" class = btext onclick="fnSubmit()">
		</td>
		</tr>
		</table>

		<INPUT type="hidden" name="dname">
		<INPUT type="hidden" name="sname">
		<INPUT type="hidden" name="pname">
		</body>
		</form>
		<%@ include file = "footer.jsp" %>
		</html>