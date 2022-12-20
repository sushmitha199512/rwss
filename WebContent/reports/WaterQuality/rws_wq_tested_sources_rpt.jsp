<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<% String Dcode = request.getParameter("District"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
		<title>Source Wise Contamination Level Based on Latest Test</title>
	</head>
	<body bgcolor="#edf2f8">
	<form name="f1">
		<table border="1" align="center" bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff" width="80%">		
			<thead>
				<tr>
			     	<th colspan="20">
						<caption>
							<table border="0" rules="none" style="border-collapse:collapse" width="100%" align="right" bgcolor="#edf2f8">
							    <thead>		
									<tr>
										<th align="center" class="bwborder">
										<label><font color="navy"><b>District</b></font></label>
										<select name="District" style="width:150px" class="mycombo" onchange="this.form.submit()" >
											<option value="0">SELECT...</option>
											<% try{
														int Count=1;
														String style="", Dname="-", Mname="-", Pname="-", Vname="-", Hcode="-", Hname="-", Sname="-", Location="-" ,ph="-", Diss_Solids="-", Hardness="-", Alkalinity="-", CL="-", F="-", SO4="", NO3="-", Fe="-";
														String query1="",query2="",query3="",query4="",query5="";
														PreparedStatement  ps1=null,ps2=null,ps3=null,ps4=null,ps5=null;
														ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
														query1="SELECT DCODE, DNAME FROM RWS_DISTRICT_TBL ORDER BY DNAME";
														ps1=conn.prepareStatement(query1);
														rs1=ps1.executeQuery();
														while(rs1.next()){
															if(Dcode != null && Dcode.equals(rs1.getString(1)))	{	
											 %>	
											 <option value="<%= rs1.getString(1)%>" selected><%= rs1.getString(2) %>
											 <% } else { %>			
											<option value="<%=rs1.getString(1) %>"><%=rs1.getString(2) %></option>
											<% } } %>
										</select>
										</th> 
									</tr>
								</thead>
							</table>
						</caption>
					</th>
				</tr>			
			    <tr>
			     	<th colspan="20">
						<caption>
							<table border="0" rules="none" style="border-collapse:collapse" width="100%" align="right" bgcolor="#edf2f8">
							    <thead>		
									<tr>
										<th align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a> | <a href="javascript:history.go(-1)">Back | </a><a href="rws_wq_tested_sources_xls_rpt.jsp?District=<%=Dcode%>" target="_new">Excel</a></th> 
									</tr>
								</thead>
							</table>
						</caption>
					</th>
				</tr>
				<tr bgcolor="#8A9FCD" align="center">
					<th align="center" class="rptHeading" colspan="20">Habitation Wise Sources Contamination Level Based on Latest Test</th>	
				</tr>
			</thead>
			<tbody>
				<tr align="center">
					<td class="btext" >SlNO</td>
					<td class="btext" >District Name</td>
					<td class="btext" >Mandal Name</td>
					<td class="btext" >Panchayat Name</td>
					<td class="btext">Village Name</td>
					<td class="btext">Habitation Code</td>
					<td class="btext">Habitation Name</td>
					<td class="btext">Source Code</td>
					<td class="btext">Source Name</td>
					<td class="btext">Location</td>
					<td class="btext">Test Date</td>
					<td class="btext" >PH Value <br/>(6.5 - 8.5)</td>
					<td class="btext" >Dissolved Solids <br/> Mg/Lit. <br/> (500 - 2000)</td>
					<td class="btext" >Total Hardness <br/> Mg/Lit. <br/> (300 - 600)</td>
					<td class="btext">Total Alkalinity <br/> Mg/Lit. <br/> (200 - 600)</td>
					<td class="btext">Chloride (As CL) <br/> Mg/Lit. <br/> (250 - 1000)</td>
					<td class="btext">Flouride (As F) <br/> Mg/Lit. <br/> (1.0 - 1.5)</td>
					<td class="btext">Sulphate (As SO<sub>4</sub>) <br/> Mg/Lit. <br/> (200 - 400)</td>
					<td class="btext">Nitrate (As NO<sub>3</sub>) <br/> Mg/Lit. <br/> (45)</td>
					<td class="btext">Iron (As Fe) <br/> Mg/Lit. <br/> (0.3 - 1.0)</td>
				</tr>
				<%	if(Dcode != null && !Dcode.equals("0") && !Dcode.equals("")){
							query2="SELECT D.DNAME,M.MNAME,P.PNAME,V.VNAME,PANCH_CODE,PANCH_NAME FROM RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_PANCHAYAT_TBL P,RWS_VILLAGE_TBL V,RWS_PANCHAYAT_RAJ_TBL H WHERE D.DCODE=M.DCODE AND M.DCODE=P.DCODE AND M.MCODE =P.MCODE AND P.DCODE=V.DCODE AND P.MCODE=V.MCODE AND P.PCODE=V.PCODE AND SUBSTR (H.PANCH_CODE,1,2) = V.DCODE AND SUBSTR(H.PANCH_CODE,6,2) = V.MCODE AND SUBSTR(H.PANCH_CODE,13,2) = V.PCODE AND SUBSTR (H.PANCH_CODE,8,3) = V.VCODE";
							//System.out.println("query2 :- "+query2);
							ps2=conn.prepareStatement(query2);
							rs2=ps2.executeQuery();
							Hashtable Hab_Details = new Hashtable();
							while(rs2.next()){
								Hab_Details.put(rs2.getString(5),rs2.getString(1)+"@"+rs2.getString(2)+"@"+rs2.getString(3)+"@"+rs2.getString(4)+"@"+rs2.getString(5)+"@"+rs2.getString(6));
							}				
							query3="SELECT DISTINCT SOURCE_CODE, NVL(SOURCE_NAME,'-'), NVL(LOCATION,'-') FROM RWS_SOURCESNAME_LOCATIONS ORDER BY SOURCE_CODE";
							//System.out.println("query3 :- "+query3);
							ps3=conn.prepareStatement(query3);
							rs3=ps3.executeQuery();
							Hashtable Source_Details = new Hashtable();
							while(rs3.next()){
								Source_Details.put(rs3.getString(1), rs3.getString(2)+"@"+rs3.getString(3));
							}
							query4="SELECT TEST_ID, NVL(TESTING_PARAMETER_CODE,'00'), NVL(TESTING_PARAMETER_VALUE,'-') FROM RWS_SOURCES_TESTED WHERE SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND TEST_CODE='01' AND TESTING_PARAMETER_CODE in (04,05,06,07,12,13,14,15,16)  ORDER BY TEST_ID, TESTING_PARAMETER_CODE";
							//System.out.println("query4 :- "+query4);
							ps4=conn.prepareStatement(query4);
							rs4=ps4.executeQuery();
							Hashtable TestPara_Details = new Hashtable();
							while(rs4.next()){
								TestPara_Details.put(rs4.getString(1)+rs4.getString(2), rs4.getString(3));
							}
							query5="SELECT DISTINCT SUBSTR(SOURCE_CODE,1,16), SOURCE_CODE, MAX(TEST_ID), TO_CHAR(MAX(PREPARED_ON),'DD-MON-YYYY') FROM RWS_SOURCES_TESTED WHERE SUBSTR(SOURCE_CODE,1,2)='"+Dcode+"' AND TEST_CODE='01' GROUP BY SOURCE_CODE ORDER BY SOURCE_CODE";
							//System.out.println("query5 :- "+query5);
							ps5=conn.prepareStatement(query5);
							rs5=ps5.executeQuery();
							while(rs5.next()){
								if(Hab_Details.get(rs5.getString(1))!=null){
									 String Habs = (String) Hab_Details.get(rs5.getString(1));
									 String Habvalues[] = Habs.split("@");
									 Dname = Habvalues[0];
									 Mname = Habvalues[1];
									 Pname = Habvalues[2];
									 Vname = Habvalues[3];
									 Hcode = Habvalues[4];
									 Hname = Habvalues[5];
								 }else{
									 Dname = "-";
									 Mname = "-";
									 Pname = "-";
									 Vname = "-";
									 Hcode = "-";
									 Hname = "-";
								 }
								 if(Source_Details.get(rs5.getString(2))!=null){
									 String source = (String) Source_Details.get(rs5.getString(2));
									 String srcvalues[] = source.split("@");
									 Sname = srcvalues[0];
									 Location = srcvalues[1];
								 }else{
									 Sname = "-";
									 Location = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"04")!=null){
									 ph = (String) TestPara_Details.get(rs5.getString(3)+"04");
								 }else{
									 ph = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"05")!=null){
									 Diss_Solids = (String) TestPara_Details.get(rs5.getString(3)+"05");
								 }else{
									 Diss_Solids = "-";
								 }								 
								 if(TestPara_Details.get(rs5.getString(3)+"06")!=null){
									 Hardness = (String) TestPara_Details.get(rs5.getString(3)+"06");
								 }else{
									 Hardness = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"07")!=null){
									 Alkalinity = (String) TestPara_Details.get(rs5.getString(3)+"07");
								 }else{
									 Alkalinity = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"12")!=null){
									 CL = (String) TestPara_Details.get(rs5.getString(3)+"12");
								 }else{
									 CL = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"13")!=null){
									 F = (String) TestPara_Details.get(rs5.getString(3)+"13");
								 }else{
									 F = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"14")!=null){
									 SO4 = (String) TestPara_Details.get(rs5.getString(3)+"14");
								 }else{
									 SO4 = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"15")!=null){
									 NO3 = (String) TestPara_Details.get(rs5.getString(3)+"15");
								 }else{
									 NO3 = "-";
								 }
								 if(TestPara_Details.get(rs5.getString(3)+"16")!=null){
									 Fe = (String) TestPara_Details.get(rs5.getString(3)+"16");
								 }else{
									 Fe = "-";
								 }							 
								 
								 if(Count%2==0){
									 style="gridbg1";
								 }else{
									 style="gridbg2";
								 }	
			    %>
			    <tr>
			    	<td class=<%=style %> style="text-align: center;"><%=Count %></td>	
					<td class=<%=style %> style="text-align: left;"><%=Dname %></td>
					<td class=<%=style %> style="text-align: left;"><%=Mname %></td>
					<td class=<%=style %> style="text-align: left;"><%=Pname %></td>
					<td class=<%=style %> style="text-align: left;"><%=Vname %></td>
					<td class=<%=style %> style="text-align: left;"><%=Hcode %></td>
					<td class=<%=style %> style="text-align: left;"><%=Hname %></td>
					<td class=<%=style %> style="text-align: left;"><%=rs5.getString(2) %></td>
					<td class=<%=style %> style="text-align: left;"><%=Sname %></td>
					<td class=<%=style %> style="text-align: left;"><%=Location %></td>
					<td class=<%=style %> style="text-align: left;"><%=rs5.getString(4) %></td>
					<td class=<%=style %> style="text-align: left;"><%=ph %></td>
					<td class=<%=style %> style="text-align: left;"><%=Diss_Solids %></td>
					<td class=<%=style %> style="text-align: left;"><%=Hardness %></td>
					<td class=<%=style %> style="text-align: left;"><%=Alkalinity %></td>
					<td class=<%=style %> style="text-align: left;"><%=CL %></td>
					<td class=<%=style %> style="text-align: left;"><%=F %></td>
					<td class=<%=style %> style="text-align: left;"><%=SO4 %></td>
					<td class=<%=style %> style="text-align: left;"><%=NO3 %></td>
					<td class=<%=style %> style="text-align: left;"><%=Fe %></td>
				</tr>
			    <%
				         Count++;
							} 
						}
					}catch(SQLException ex){
						System.out.println("Error :- " + ex);
					}finally{
							conn.close();
					}
				%>
				
			</tbody>
		</table>	
	</form>	
	</body>
<%@ include file = "/commons/rws_footer.jsp" %>
</html>