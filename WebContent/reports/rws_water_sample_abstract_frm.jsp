<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%@ include file = "conn.jsp" %>
<%	


nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dcode="";
	if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");    
	   }

	try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

    Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
	
	

%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">

function fnSubmit()
{    
	
	 if(document.f1.district.value!="" && document.f1.district.value!="-1")
		{
			document.f1.dName.value = document.f1.district.options[document.f1.district.selectedIndex].text;
		}
	if(document.f1.district.selectedIndex=="")
	{
	     alert("please SELECT District");
		 return false;
	}
	    document.f1.action="./rws_water_sample_abstract_rpt.jsp";
		document.f1.submit();
}
	
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="<%= request.getRequestURI()%>">


<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<!--<font color="#FFFFFF">Borewell Status Graph</font>-->
                <font color="#FFFFFF">Water Quality Abstract Report</font>
			</td>	
		</tr>


<%
	String rDist = null;
    String  rYear=null;
	String rMonth=null;
	String dCode=null;
	String dName=null;
	
%>
<TR> 
	<TD   valign=top  align="center" height="35%" width="100%">

<%

 %>

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>

<tr>
		<% 
	rDist = request.getParameter("district");
    rYear=request.getParameter("year");
	rMonth=request.getParameter("month");
	////System.out.println("Rdist   "   +rDist);
	if(rDist==null || rDist.equals("0"))
	{
	%>
		<td class = btext ><font color=navy><b>Circle</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>

	<!--  	<option value="51"> ALL		</option>  -->
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	else if(rDist != null && rDist.equals("51"))
	{%>
	<td class = btext><font color=navy><b>District</b> </font>
	<font color="red"><b>*</b></font></td>
	<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >
	<option value="0">SELECT...</option>
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		
	} 
	else if(rDist.equals("51") )  
	{
	%>
	 <td class = btext><font color=navy><b>Circle</b> </font>
	 <font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
	if(dcode!=null && !dcode.equals("")){
		rs =stmt.executeQuery("SELECT circle_office_code,circle_office_name from rws_circle_office_tbl where circle_office_code='"+dcode+"' order by circle_office_name");
		
	}else{
	rs =stmt.executeQuery("SELECT circle_office_code,circle_office_name from rws_circle_office_tbl order by circle_office_name");}
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		 <option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %> 
	<% 			
			session.setAttribute("dName",rs.getString(2));
			session.setAttribute("dCode",rDist);


		}// END OF IF
		else 
		{
%>		 <option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %> 
<%			
		session.setAttribute("dName",rs.getString(2));
		session.setAttribute("dCode",rDist);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	<tr>

</tr>
<tr>
 <td class = btext ><font color=navy><b>Month</b> </font>
		
		</td>
		<td class = btext colspan=3><SELECT name="month" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>

		 <% 
		stmt2=conn.createStatement();
     String qry1=" select distinct to_char(TEST_DATE ,'MON'),to_number(to_char(test_date,'mm')) from rws_ftk_testing_tbl union select distinct to_char (samp_collect_date,'MON'),to_number(to_char(samp_collect_date,'mm')) from rws_water_sample_collect_tbl order by 2 ";
    rs2=stmt2.executeQuery(qry1);
	while(rs2.next())
	{%>
	 <option value="<%= rs2.getString(1) %>" ><%= rs2.getString(1) %> 
	
	<%}


	%>
</tr>
<tr>

<td class = btext ><font color=navy><b>Year</b> </font>
		
		</td>
		<td class = btext colspan=3><SELECT name="year" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
	<!-- 	<option value="51"> ALL		</option>    -->

      <% 
		stmt1=conn.createStatement();
     String qry="select distinct to_char(TEST_DATE ,'yyyy'),to_number(to_char(test_date,'yyyy')) from rws_ftk_testing_tbl union select distinct to_char(samp_collect_date,'yyyy'),to_number(to_char(samp_collect_date,'yyyy')) from rws_water_sample_collect_tbl order by 2 DESC";
    rs1=stmt1.executeQuery(qry);
	while(rs1.next())
	{%>
	 <option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %> 
	
	<%}


	%>
</tr>

	</table>


 
	
    
		</TR>
<TR>	
<TD colspan=2 align=center valign=top>	

		<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	finally
	{
	if(rs!=null)
	{
	rs.close();
	}
	if(stmt!=null)
	{
	stmt.close();
	}
	if(conn!=null)
	{
		conn.close();
	}
	} 

		%>
</TD></TR>
</TABLE>
<input type="hidden" name="dName"/>
</form>

</body>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="connClose.jsp" %>  <%}finally{}%>


</html>
