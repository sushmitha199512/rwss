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
    ResultSet rs6=null;
    Statement stmt6=null;
    
	
	

%>
<span><p>
<head>
<title>WaterSoft</title>


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
<form name=f1 action="rws_complaints_rpt.jsp">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../rws_login_frm1.html">Home</td> 
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
    String fromdate=null;
    String fromDate=null;
    String adate=null;
    String aDate=null;
    
    
    
	
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

	</table>


 
	
    
		</TR>
<TR>	
<TD colspan=2 align=center valign=top>	

		<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=submit  value="View Report" class = btext></td>
	</tr>
</table>
	<%//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	finally
	{
try
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
catch(Exception o)
{
o.printStackTrace();
}
	} 

		%>
</TD></TR>
</TABLE>
<input type="hidden" name="dName"/>
</form>

</td></tr>
<%@ include file="/commons/rws_footer.jsp" %>
<%@ include file="connClose.jsp" %>  <%}finally{}%>


</span>
