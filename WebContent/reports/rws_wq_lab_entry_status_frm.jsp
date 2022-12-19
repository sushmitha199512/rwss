<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%		try{
	
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
    String query=null;
%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">

/*function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="-1")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}*/

function fnSubmit()
	{   
	    if(document.f1.district.value!="" && document.f1.district.value!="-1")
		{
			document.f1.circleName.value = document.f1.district.options[document.f1.district.selectedIndex].text;
		}
			
		if(document.f1.district.selectedIndex==" ")
		{
	    alert("Please Select Circle...");
		return false;
		}

		
		else
		{
			document.f1.action="./rws_wq_lab_entry_status_rpt.jsp";
			document.f1.submit();
		}
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

<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF"></font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rDiv = null;
	String rSubdiv = null;
	String aType = null;
	String lab = null;
	String rYear = null;
	String distName=null;
	String rMand=null;
	String rMonth=null;
	String aCode = null;
	
	rDist = request.getParameter("district");
	//out.println("district"+rDist);
	rDiv = request.getParameter("division");
	//out.println("mandal"+rDiv);
	rSubdiv = request.getParameter("subdivision");
	//out.println("panchayat"+rSubdiv);
	lab = request.getParameter("lab");
	aType = request.getParameter("assetType");
	////System.out..println("asset"+aType);
	
	rMand=request.getParameter("mandal");

//	System.out.println("mcode:"+rDiv);

    rYear=request.getParameter("year");
	rMonth=request.getParameter("month");
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	
	if(rDist == null || rDist.equals("-1"))
	{
		//////System.out..println("IN Circle STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
			 <option value="00" SELECTED>All</option>   
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			//////System.out..println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
		<!--  		 <option value="00" SELECTED>All</option> -->
<% 
			//	session.setAttribute("circleCode",rDist);
               // session.setAttribute("circleName","ALL");
				
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--   	 <option value="00" SELECTED>All</option> -->
<%
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct sc.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE  order by c.circle_OFFICE_name";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						session.setAttribute("circleName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						}
				}			
					if(rs!=null){
					rs.close();	}
					if(stmt!=null)
					{stmt.close();}

%>
			</select>
		</td>
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
	<!--  	<option value="51"> ALL		</option>  -->

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

	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>

</table>
</TD>
</TR>
</table>


<% 
 } catch(Exception e)
    { 
	 e.printStackTrace();
	 }
 
 %>

<input type="hidden" name="circleName"/>
<input type="hidden" name="divisionName"/>
<input type="hidden" name="subdivisionName"/>
<input type="hidden" name="mandalName"/>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>

