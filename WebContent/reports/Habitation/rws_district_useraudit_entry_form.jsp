<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<%
	try {

		Statement stmt1 = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;
		ResultSet rs1 = null;
		Statement stmt3 = null;
		ResultSet rs3 = null;
		//Statement st4 = null;
		//ResultSet rs4 = null;
		//Statement st5=null;
		//ResultSet rs5=null;	
		String query = null;
%>

<html>
<head>

<title>WaterSoft</title>
<script language="javascript" type="text/javascript" src="/pred/resources/javascript/datetimepicker.js" ></script>


<script language="JavaScript">
	/*function unview()
	 {
	 var a=document.getElementById('circ1').value;
	
	 if(a=="-1")
	 {
	 document.getElementById('circ').disabled=true;
	 }
	
	 }*/

	function fnSubmit() {
		if (document.f1.district.value != ""
				&& document.f1.district.value != "-1") {
			document.f1.circleName.value = document.f1.district.options[document.f1.district.selectedIndex].text;
		}
		if (document.f1.division.value != ""
				&& document.f1.division.value != "00") {
			document.f1.divisionName.value = document.f1.division.options[document.f1.division.selectedIndex].text;
		}
		if (document.f1.division.value != ""
			&& document.f1.division.value=='00') {
		   document.f1.divisionName.value = document.f1.division.options[document.f1.division.selectedIndex].text;
	     }
		if (document.f1.subdivision.value != ""
				&& document.f1.subdivision.value != "00") {
			document.f1.subdivisionName.value = document.f1.subdivision.options[document.f1.subdivision.selectedIndex].text;
		}
		
		var StartDate=document.getElementById('demo1').value;
		var EndDate=document.getElementById('demo2').value;
		var sDate = new Date(StartDate);
		var eDate = new Date(EndDate);
		var tommorow=new Date();
		tommorow.setDate(tommorow.getDate() + 1);
		
		
			
		if (document.f1.district.selectedIndex == "") {
			alert("Please Select Circle...");
			return false;
 		}else if(StartDate=='')
		{
 			alert("Please enter from date");	
 			return false;
 			}
 		else if(EndDate=='')
 		{
 		alert("Please enter To date");	
 		return false;
 		}
 		
 		else if((sDate > eDate))
 			{
 			alert("Please enter valid dates till today ");
 			location.reload();
 			}
 		
 					
 		else {
			document.f1.action = "./rws_report.audit_user.jsp";
			document.f1.submit();
		}
	}
	 
function userCheck()
{
	var response = '';
	 var path=  window.location.href;
	 var arr  = path.split("pred/");
	alert();
	 $.ajax({ type: "POST",   
	          url: "switch.do?prefix=/admin&page=/ajaxCall.do&modeCheck=AuthCheck&urlPath="+encodeURIComponent(arr[1]),
	          async: false,
	          success : function(resp)
	          {
	        	  alert(resp);
	             // window.location = '/../commons/UnAuthorize.jsp';
	              //document.location.href="/pred/commons/UnAuthorize.jsp";
	          }
	 });  		
}
</script>

<style>
.mystyle {
	border-width: 1;
	color: #000000;
	font-weight: bold;
	font-family: verdana;
	font-size: 9pt;
}

.btext {
	border-width: 1;
	color: #336600;
	font-weight: bold;
	font-family: verdana;
	font-size: 9pt;
	background-color: #ffffff
}
</style>
</head>
<body bgcolor="#edf2f8" onload="userCheck();" >
<form name=f1 method="post" action="<%=request.getRequestURI()%>">

<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows"
			width="42%" bordercolor=navy style="border-collapse: collapse"
			bgcolor="#ffffff">
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					align="right" bgcolor="#edf2f8">

					<tr>
						<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="textborder" colspan="2"><font
					color="#FFFFFF">User Audit</font></td>
			</tr>
			
			<%
				    String rDist = null;
					String rDiv = null;
					String rSubdiv = null;
										
					rDist = request.getParameter("district");
					//out.println("district"+rDist);
					rDiv = request.getParameter("division");
					//out.println("mandal"+rDiv);
					rSubdiv = request.getParameter("subdivision");
					//out.println("panchayat"+rSubdiv);
				
			%>
			
			<TR>
				<TD valign=top align="center" height="40%" width="10%">
					<table bordercolor=navy width="100%" height="100%" border=1
						rules="rows" style="border-collapse: collapse" align=center
						bgcolor="#ffffff">

						<%
							if (rDist == null || rDist.equals("-1")) {
									//////System.out..println("IN Circle STARTING...");
						%>

						<tr>
							<td class=btext><font color=navy><b>Circle</b> </font> <font
								color=red><b>*</b> </font>
							<td class=btext><select name="district" id="circ1"
								style="width: 150px" class="mycombo"
								onChange="this.form.submit()">
									<option value="-1">SELECT...</option>
									<!-- <option value="00" SELECTED>All</option>-->
									<%
										session.setAttribute("circleCode", null);
										session.setAttribute("circleName", null);

											}

											else if (rDist != null || rDist.equals("00")) {
												//////System.out..println("IN DISTRICT ALL...");
									%>
									<td class=btext><font color=navy><b>Circle</b> </font> <font
										color=red><b>*</b> </font>
								<td class=btext><select name="district" id="circ1"
										style="width: 150px" class="mycombo"
										onChange="this.form.submit()">
											<option value="-1">SELECT...</option>
											<!-- <option value="00" SELECTED>All</option>-->
											<%
												session.setAttribute("circleCode", rDist);
												session.setAttribute("circleName", "ALL");

													} else if (!rDist.equals("-1")) {
											%>
											<td class=btext><font color=navy><b>Circle</b> </font> <font
												color=red><b>*</b> </font>
										<td class=btext><SELECT name="district" id="circ1"
												class="mycombo" style="width: 150px"
												onChange="this.form.submit()">
													<option value="-1">SELECT...</option>
													<!-- <option value="00" SELECTED>All</option>-->
													<%
// 														session.setAttribute("circleCode", rDist);
															}
															stmt = conn.createStatement();

															query = "SELECT distinct sc.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE  order by sc.circle_OFFICE_code";
															rs = stmt.executeQuery(query);
															while (rs.next()) {
																if (rDist != null && rDist.equals(rs.getString(1))) {
													%>
													<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
													<%
														            session.setAttribute("circleCode", rDist);
																	session.setAttribute("circleName", rs.getString(2));

																} else {
													%>
													<option value=<%=rs.getString(1)%>><%=rs.getString(2)%></option>
													<%
														session.setAttribute("circleCode", rDist);
																}
															}
															if (rs != null) {
																rs.close();
															}
															if (stmt != null) {
																stmt.close();
															}
													%>
											</select></td>
						</tr>
						<%
							 if (rDist == null || rDist.equals("-1")) { %>
							 
							 <tr>
							 <td class=btext nowrap><font color="navy"><b>Division</b></font>
							 <td class=btext><SELECT name="division" style="width: 150px" class="mycombo" onChange="this.form.submit()" disabled>
 							 <option value="-1">SELECT...</option></SELECT></td> 
							 </tr>
												<%}%>
						
							
						<%
							 if (rDist != null && !rDist.equals("-1") && !rDist.equals("00")) {
												%>
									<tr>
									<td class=btext nowrap><font color="navy"><b>Division</b></font>
									<td class=btext><SELECT name="division" style="width: 150px" class="mycombo" onChange="this.form.submit()">
 									<option value="-1">SELECT...</option>
									
                                   <!-- prakash modified code	 -->

									<%
									session.setAttribute("divName", "ALL");
									%>
								     <% if(rDiv != null && rDiv.equals("00"))
										{  %>
										<option value="00" SELECTED>ALL</option>	
									 <% 
                                     session.setAttribute("divName", "ALL");
									 }
								     else{ %>
								     <option value="00">ALL</option>
								      <% } %>
									 															
                                          											<%
														stmt1 = conn.createStatement();
														query = "SELECT distinct sc.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d, rws_water_sample_collect_tbl sc  where d.circle_OFFICE_CODE = sc.circle_office_code and sc.division_office_code=d.division_office_code and d.STATUS<>'UI'and d.CIRCLE_OFFICE_CODE= '"
																+ rDist + "' order by sc.division_OFFICE_code ";

														rs1 = stmt1.executeQuery(query);
														while (rs1.next()) {
															if (rDiv != null && rDiv.equals(rs1.getString(1))) {
											%>
											<option value="<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
											<%
												session.setAttribute("divName", rs1.getString(2));
												session.setAttribute("divCode", rDiv);
															} else {
											%>
											<option value=<%=rs1.getString(1)%>><%=rs1.getString(2)%></option>
											<%
												}
														}
														session.setAttribute("divCode", rDiv);
														if (rs1 != null) {
															rs1.close();
														}
														if (stmt1 != null) {
															stmt1.close();
														}
													}
											%>
									</select></td>
						</tr>
						
						<tr>
							<%
								if (rDist == null || rDist.equals("-1") || rDist.equals("00")
											|| rDiv == null || rDiv.equals("-1")
											|| rDiv.equals("00")) {
										//////System.out..println("IN subdivision STARTING...");
							%>
							<td nowrap class=btext><font color="navy"><b>Sub
										Division</b></font></td>
							<td class=btext><SELECT name="subdivision"
								style="width: 150px" class="mycombo"
								onChange="this.form.submit()" disabled>
									<option value="-1">SELECT...</option>
									<%
										session.setAttribute("subdivName", null);
										session.setAttribute("subdivCode", null);
											}

											else if (rDist != null || !rDist.equals("-1") || rDiv != null) {
												//////System.out..println("IN subdivision ALL...");
									%>
									<td nowrap class=btext><font color="navy"><b>Sub
												Division</b></font></td>
									<td class=btext><SELECT name="subdivision"
										style="width: 150px" class="mycombo"
										onChange="this.form.submit()">
											<option value="00">SELECT...</option>
  										 
											<%
												session.setAttribute("subdivName", "ALL");
											
                   // 				prakash modified code

                                   if(rSubdiv != null && rSubdiv.equals("00"))
										{  %>
										<option value="00" SELECTED>ALL</option>	
									 <% 
                                     session.setAttribute("subdivName", "ALL");
									 }
								     else{ %>
								    	 <option value="00">ALL</option>
								  <% } 

               
											%>
											<!--<option value="00" SELECTED>ALL</option>-->

											<%
												
											%>
											<!--<option value="00">ALL</option>-->
											<%
												//}
														stmt2 = conn.createStatement();
														query = "SELECT distinct sc.subdivision_office_code,sd.subdivision_OFFICE_NAME FROM  rws_water_sample_collect_tbl sc,  RWS_subdivision_OFFICE_TBL sd where sd.circle_office_code=sc.circle_office_code and sd.division_office_code= sc.division_office_code and sd.subdivision_office_code=sc.subdivision_office_code and sd.circle_office_code='"
																+ rDist
																+ "' and sd.division_office_code='"
																+ rDiv
																+ "' order by sc.subdivision_OFFICE_code";
														rs2 = stmt2.executeQuery(query);
														while (rs2.next()) {
															if (rSubdiv != null && rSubdiv.equals(rs2.getString(1))) {
											%>
											<option value="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
											<%
												session.setAttribute("subdivName", rs2.getString(2));
																session.setAttribute("subdivCode", rSubdiv);
															} else {
											%>
											<option value=<%=rs2.getString(1)%>><%=rs2.getString(2)%></option>
											<%
												session.setAttribute("subdivCode", rSubdiv);
															}
														}
														if (rs2 != null) {
															rs2.close();
														}
														if (stmt2 != null) {
															stmt2.close();
														}
													}
											%>
									</select></td>
						</tr>
						<tr>
<tr>
 		<td class = btext nowrap>
			<font color=navy><b>From Date:</b> </font>
			</td>
		
	    	<td class = btext >
			<input type="text" name="FDate" id="demo1"  style="width:150px"  >
					
			<a href="javascript: showCalendarFuture(document.getElementById('demo1'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
			</td>
			</tr>

			<tr>
 		    <td class = btext nowrap>
			<font color=navy><b>To Date:</b> </font>
			</td>
		
		   <td class = btext >
			<input name="TDate" id="demo2" style="width:150px">
			<a href="javascript: showCalendarFuture(document.getElementById('demo2'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
			</td>
			</tr>
			
 			<tr> 
			<td class = btext><input type="radio" name="access" value="useraccess" id="radio1" checked>User Accessed watersoft &nbsp;</td>
			<td class=btext><input type="radio" name="access" value="usernotaccess" id="radio2">User Not Accessed watersoft
			</td>
			</tr>
			
			
					<!--*********************************************************************************************-->	
			</table>
			</TD>
			<TR>
				<TD colspan=2 align=center valign=top>
					

					<table bordercolor=navy width="40%" border=0 rules=none
						style="border-collapse: collapse" align=center>
						<tr>
							<td colspan=2 align=center><input type=button id="circ"
								onclick="fnSubmit()" value="View Report" class=btext></td>
						</tr>
					</table> 
				
<%
 	//} 

 	} catch (Exception e) {
 		e.printStackTrace();
 	} finally {
 		conn.close();
 	}
 %>
 </td>
 </tr>
 
 
 </table>
 	<input type="hidden" name="circleName" /> 
					<input type="hidden" name="divisionName" />
					<input type="hidden" name="subdivisionName" />
</form>
</body>
</html>

<%@ include file = "/commons/rws_footer.jsp" %>