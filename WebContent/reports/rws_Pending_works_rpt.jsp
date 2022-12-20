<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
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
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
           if(document.f1.wrktype.value=='')
			{
				alert("Please Select WorkType");
				return false;
			}
			if(document.f1.year.value=='')
			{
				alert("Please Select Year");
				return false;
			}
			 if(document.f1.program.value=='')
			{
				alert("Please Select Programmes");
				return false;
			}
			else
			{   
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.pname.value = document.f1.combo2.options[document.f1.combo2.options.selectedIndex].text;
				//alert("hai"+document.f1.pname.value);
				document.f1.action="./rws_Pending_works_list.jsp";
				document.f1.submit();
			}	
		}
		
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Pending Works Monitoring Report</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
    String rwrktype=request.getParameter("wrktype");
    if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");    
	   }
	%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") || loggedUser.substring(0,3).equals("col") || loggedUser.equals("secrwss")))
		{
			System.out.println("in selected dist:in if");	
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<% if(loggedUser.substring(0,3).equals("col")){
				System.out.println("in selected dist:in if1111111111");
			}else{%>
				<option value="00">ALL</option>
<%	System.out.println("in selected dist:in if22222222222");
				}
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";
			if(dcode!=null && !dcode.equals("")){
				query+=" and dcode='"+dcode+"'";
			}
			query+=" order by dcode";
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
		System.out.println("in selected dist:in else");
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
	%>
	</SELECT>
	</td>
	</tr>
	<tr>
		<td class=rptLabel>Work Type&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<select name="wrktype" id="combo" style="width:150px" class="mycombo" >
		<option value="">SELECT</option>
		<%--  <%
		String ary="SELECT CATEGORY_NAME,category_code FROM rws_work_category_tbl";
		  Statement stmt1=conn.createStatement();
		   ResultSet rs1=stmt1.executeQuery(ary);
		  while(rs1.next())
	      {
			   if(rwrktype != null && rwrktype.equals(rs1.getString(2)))
			  {
			   %>
			<option value="<%=rs1.getString(2)%>" SELECTED><%=rs1.getString(1)%></option>
			<%
			 session.setAttribute("assetCode", rwrktype);
			session.setAttribute("assetName", rs1.getString(1));
		  }else {
			  %>
			<option value=<%=rs1.getString(2)%> ><%=rs1.getString(1)%></option>
			<%
			session.setAttribute("assetCode", rwrktype);

		  }
		  } 
		%> --%>
		
				<option value="">-Select-</option>
				<option value='1'>PROJECTS-MVS</option>
				<option value='2'>NORMAL-SVS</option>
				<option value='3'>DISTRICT LEVEL</option>
       </select>
		
		
		
		</td>
		</tr>
		<tr>
		
		 <td class=rptLabel>No.of Years Pending&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px"  >
				<option value="">-Select-</option>
				<option value='1'>1</option>
				<option value='2'>2</option>
				<option value='3'>3</option>
				<option value='4'>4</option>
				<option value='5'>5</option>
         </select>
				</td>
				</tr>
				<tr>
								
	<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
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
		</td>


 
</tr>			
<% }
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4  align="center">
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Pending Works">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">


</form>
</body>
</html>