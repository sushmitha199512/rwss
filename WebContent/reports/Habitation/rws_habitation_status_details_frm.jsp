
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%> 
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	//////// // System.out.println("***********************FROM BEGINING***********************");
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
   user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user.getUserId();
   //System.out.println("loggeduser:"+loggedUser);
   Statement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String district= null;
    String mandal = null;;
	
	
	district = request.getParameter("district");
	mandal = request.getParameter("mandal");	

	
	
%>
<html>
<head>

<script language="JavaScript">
function check()
{

 
   var district=document.forms[0].district.value;
   if(district=="ALL")
   {
	   <%session.setAttribute("dname", "ALL");%>
	   document.getElementById('mandal').disabled=true;
   }
   
}

	function fnSubmit()
	{
	 
	 
	   var district=document.forms[0].district.value;
	   var mandal=document.forms[0].mandal.value;
	  
	  
	   if(district=="-1")
	   {
	    alert("please Select District");
		return false;
	   }
	   
	 else  if(mandal=="-1")
	   {
	    alert("please Select Mandal");
				return false;
	   }
	 else if (document.forms[0].finyear.value == '0') {
			alert("Please Select Financial Year");
			return false;
		}
	  else
	  {
		 document.forms[0].action="./rws_habitation_status_rpt.jsp";
			document.forms[0].submit(); 
	    }
	 
	  
	  
	}

	
		
</script>

</head>
<body bgcolor="#edf2f8" onload="check()">
<form  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			

			<tr align="right">
			<td ><a href="/pred/home.jsp?loginMode=watersoft">Home |&nbsp; <a href="javascript:onclick=history.go(-1)">Back  </td>
			</tr>


				
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Habitation Status Details</td>	
	</tr>
	
<%
try
{
%>


	
	

	<tr>
	<td colspan=2>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
 
		
 
		<%
		
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER) || loggedUser.toString().equals("minrwss")))
		{
		%>
		<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit();">
			<option value="-1" >SELECT..</option>
			<option value="ALL" SELECTED>ALL</option>
		<%
			
		String query3="select dcode,dname from rws_district_tbl order by dcode";
	
			stmt1 = conn.createStatement();
				rs1 = stmt1.executeQuery(query3);
				while(rs1.next()){
						
					
						if(district!= null && district.equals(rs1.getString(1)))
						{	
							
	%>
					<option value="<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
	<%
						session.setAttribute("dname", rs1.getString(2));
	
						}
						else{
							%>
							<option value="<%=rs1.getString(1)%>" ><%=rs1.getString(2)%></option>
			<%
			
						}
						
					}
					rs1.close();			
					stmt1.close();%>
					
					</SELECT>
					</td></tr>
					<%
		}
		else
		{
			
							stmt = conn.createStatement();
							
							query = "select dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"' ";
							
							rs = stmt.executeQuery(query);	
							if(rs.next())
							{
								
							
	%>
	
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<input type="text" name="dname" value=<%=rs.getString(2)%> class="mytext" style="width:150px" readonly/>
				
				<input type="hidden" name="district" value="<%=rs.getString(1)%>"/>
				</td>
				</tr>
	<%
	
			}
							stmt.close();
							rs.close();
										
						
		}
	%>
	<%
		
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)||loggedUser.toString().equals("minrwss")))
		{
		%>
	<tr>
		<td class=rptLabel>Mandal<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="-1" >SELECT..</option>
			<option value="ALL" SELECTED>ALL</option>
			<%     		
				query1="select distinct mcode,mname from rws_mandal_tbl where dcode='"+district+"'  order by mname";
				System.out.println("query1"+query1);
				stmt1 = conn.createStatement();
				rs1 = stmt1.executeQuery(query1);
				while(rs1.next()){
				
					if(mandal!= null && mandal.equals(rs1.getString(1)))
					{					
%>
				<option value="<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
				
						
					}
					else{
						%>
						<option value="<%=rs1.getString(1)%>" ><%=rs1.getString(2)%></option>
		<%				
					}
					
				}
				rs1.close();			
				stmt1.close();
%>
							

			</select>
		</td>
	</tr>
	<%
		}
		else{
		%>
	<tr>
		<td class=rptLabel>Mandal<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="-1" >SELECT..</option>
			<option value="ALL" SELECTED>ALL</option>
			<%     		
				query1="select distinct mcode,mname from rws_mandal_tbl where dcode='"+loggedUser.substring(1,3)+"' order by mname";
				System.out.println("query1"+query1);
				stmt1 = conn.createStatement();
				rs1 = stmt1.executeQuery(query1);
				while(rs1.next()){
				
				
					if(mandal!= null && mandal.equals(rs1.getString(1)))
					{					
%>
				<option value="<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<% 						
						
					}
					else{
						%>
						<option value="<%=rs1.getString(1)%>" ><%=rs1.getString(2)%></option>
		<%				
					}
					
				}
				rs1.close();			
				stmt1.close();
		
%>
							

			</select>
		</td>
	</tr>
	<%} %>
 
	<%@ include file="/reports/financialYear.jsp"%>		
		
</table>

</td></tr>
<tr>
<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit()" class=btext value="GetData">
		</td>
		</tr>
	</table>
	
	
								
<%
}
catch(Exception e){
	/* e.printStackTrace(); */
}
finally{
	
}
%>
<%@ include file = "/reports/footer.jsp" %>
</form>
</body>
</html>
