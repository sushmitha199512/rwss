<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<%
	//////// // System.out.println("***********************FROM BEGINING***********************");
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
   user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user.getUserId();
   //System.out.println("loggeduser:"+loggedUser);
   Statement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String rDivion= null;
    String rCircle = null;;
	String rSubDivision = null;
	String assetCode=null;
	
	/* rDivion = request.getParameter("division"); */
	rCircle = request.getParameter("circle");	
	
	
	
%>
<html>
<head>

<script language="JavaScript">

	function fnSubmit()
	{
	 
	 
	   var circle=document.forms[0].circle.value;
	  /*  var division=document.forms[0].division.value; */
	  
	  
	   if(circle=="-1")
	   {
	    alert("please Select Circle");
		return false;
	   }
	/*  else  if(division=="-1")
	   {
	    alert("please Select Division");
				return false;
	   } */
	 
	  
	  else
	  {
		  document.forms[0].action="./rws_Pushkar_Ghatwise_report1_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Pushkar Abstract Report</td>	
	</tr>
	
<%
try
{
%>
<!--  <tr><td class=rptLabel colspan="2" align="center">
<input type="radio" value="1" name="habtype" checked onclick="show()">Asset Code&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="show1()">Work Id&nbsp;&nbsp;

</td>
</tr> -->

	
	

	<tr>
	<td colspan=2>
	<!-- <div id="selecthab" style="display:block"> -->
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
 
		
 
		<%
		
		if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)))
		{
		%>
		<tr><td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Circle&nbsp;&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class=btext>
			<SELECT name="circle"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="-1" SELECTED>SELECT..</option>
		<%
			
		
					stmt = conn.createStatement();
					
					query = "select  distinct * from RWS_CIRCLE_OFFICE_TBL where CIRCLE_OFFICE_CODE in('04','05','06','07','13')";
					
					rs = stmt.executeQuery(query);	
					while(rs.next())
					{
						if(rCircle!= null && rCircle.equals(rs.getString(2)))
						{					
	%>
					<option value="<%=rs.getString(2)%>" SELECTED><%=rs.getString(3)%></option>
	<%				
	session.setAttribute("circleName", rs.getString(3));
							
						}
						else{
							%>
							<option value="<%=rs.getString(2)%>" ><%=rs.getString(3)%></option>
			<%
						}
						}
						rs.close();			
						stmt.close();
%>
					
					</SELECT>
					</td></tr>
					<%
		}
		else
		{
			
							stmt = conn.createStatement();
							
							query = "select  distinct * from RWS_CIRCLE_OFFICE_TBL where circle_office_code='"+loggedUser.substring(1,3)+"' and CIRCLE_OFFICE_CODE in('04','05','06','07','13')";
							
							rs = stmt.executeQuery(query);	
							if(rs.next())
							{
				
							
	%>
	
	<tr><td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Circle&nbsp;&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class=btext>
		<input type="text" name="circleName" value=<%=rs.getString(3)%> class="mytext" style="width:150px" readonly/>
				
				<input type="hidden" name="circle" value="<%=rs.getString(2)%>"/>
				</td>
				</tr>
	<%
	session.setAttribute("circleName", rs.getString(3));
			}
							stmt.close();
							rs.close();
										
						
		}
	%>
	<%
		
		/* if(loggedUser.toString()!=null && (loggedUser.toString().equals(Constants.ADMIN)||loggedUser.toString().equals(Constants.LAKH_USER) ||loggedUser.toString().equals(Constants.GUEST) || loggedUser.toString().equals(Constants.DROUGHT_USER) || loggedUser.toString().equals(Constants.SEC_USER)))
		{ */
		%>
	<!-- <tr>
		<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Division<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class=btext>
			<SELECT name="division"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="-1" SELECTED>SELECT..</option> -->
			<%     		
				
				
				/* stmt = conn.createStatement();
				
				query = "select  distinct * from RWS_DIVISION_OFFICE_TBL where circle_office_code='"+rCircle+"'";
				
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDivion!= null && rDivion.equals(rs.getString(3)))
					{	 */				
%>
				<%-- <option value="<%=rs.getString(3)%>" SELECTED><%=rs.getString(4)%></option> --%>
<%
					/* session.setAttribute("divisionName", rs.getString(4));
						
					}
					else{ */
						%>
						<%-- <option value="<%=rs.getString(3)%>" ><%=rs.getString(4)%></option> --%>
		<%
				/* 	}
					}
					rs.close();			
					stmt.close(); */
				
%>
							

			<!-- </select>
		</td>
	</tr> -->
	<%/* 
		}
		else{ */
		%>
	<!-- <tr>
		<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;Division<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class=btext>
			<SELECT name="division"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="-1" SELECTED>SELECT..</option> -->
			<%     		
				
				
			/* 	stmt = conn.createStatement();
				
				query = "select  distinct * from RWS_DIVISION_OFFICE_TBL where circle_office_code='"+loggedUser.substring(1,3)+"' and division_office_code='"+rs1.getString(1)+"' and status <> 'UI'";
				
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDivion!= null && rDivion.equals(rs.getString(3)))
					{ */					
%>
				<%-- <option value="<%=rs.getString(3)%>" SELECTED><%=rs.getString(4)%></option> --%>
<%
					/* session.setAttribute("divisionName", rs.getString(4));
					}
					else{ */
						%>
						<%-- <option value="<%=rs.getString(3)%>" ><%=rs.getString(4)%></option> --%>
		<%
					/* }
					}
					rs.close();			
					stmt.close(); */
				
		
%>
							

			<!-- </select>
		</td>
	</tr> -->
	<%//} %>

			
			
			
		
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
	 e.printStackTrace(); 
}
finally{
	
}
%>
<%@ include file = "/reports/footer.jsp" %>
</form>
</body>
</html>
