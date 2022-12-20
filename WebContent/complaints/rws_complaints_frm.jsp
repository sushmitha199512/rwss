<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		try{
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
    Statement stmt5=null;
    Statement stmt6=null;
    ResultSet rs6=null;
    String fromDate=null;
    String fromdate=null;
    String aDate=null;
    String adate=null;
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
	    document.f1.action="./rws_complaints_rpt.jsp";
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
		
		<tr>
				<td align="right" class="bwborder"><a href="../rws_login_frm.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<!--<font color="#FFFFFF">Borewell Status Graph</font>-->
                <font color="#FFFFFF">Total Complaints  Report</font>
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
		<td class = btext ><font color=navy><b>District</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>
		
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
	 <td class = btext><font color=navy><b>District</b> </font>
	 <font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT dcode,dname from rws_district_tbl order by dname");
	
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
	<tr>
		<td class=btext><font color=navy><b>Complaint Date</b></font><font color=red><b>*</b></font></td>
		<td class=btext>
			<SELECT name="fromdate" style="width:150px" class="mycombo" >
				<option value="0">SELECT...</option>
                <option value="51">ALL</option>
 
<%		
		stmt5 = conn.createStatement();
		
		
		
		rs5 =stmt5.executeQuery("select distinct to_char(complaint_date,'dd/mm/yyyy') from rws_complaints_register_tbl order by to_char(complaint_date,'dd/mm/yyyy')");
		
		while(rs5.next())
		{			
		if(fromDate != null && fromDate.equals(rs5.getString(1)))
			{
%>
			<option value="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(1)%></option>
<%
			}
			else
			{
%>
			<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%></option>
<%
			}
             session.setAttribute("FDATE",fromDate);
			
		}
%>
			</select>
		</td>
	</tr>

<tr>
		<td class=btext><font color=navy><b>Attended Date</b></font><font color=red><b>*</b></font></td>
		<td class=btext>
			<SELECT name="adate" style="width:150px" class="mycombo" >
				<option value="0">SELECT...</option>
		        <option value="51">ALL</option>
<%

		stmt6 = conn.createStatement();
		
		
		
		rs6 =stmt6.executeQuery("select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl order by to_char(attended_date,'dd/mm/yyyy')");
		
		while(rs6.next())
		{			
		if(aDate != null && aDate.equals(rs6.getString(1)))
			{
%>
			<option value="<%=rs6.getString(1)%>" SELECTED><%=rs6.getString(1)%></option>
<%
			}
			else
			{
%>
			<option value="<%=rs6.getString(1)%>"><%=rs6.getString(1)%></option>
<%
			}
             session.setAttribute("ADATE",aDate);
			
		}
%>
			</select>
		</td>
	</tr>






	<tr>





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
  


</html>