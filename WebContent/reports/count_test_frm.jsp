
<%@ include file = "conn.jsp" %>
<%		try{
	Statement stmt1 = null;
    ResultSet rs1 = null;
	
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">

function fnSubmit()
{       
	if(document.f1.programme.selectedIndex=="")
	{
	     alert("please SELECT Grant");
		 return false;
	}
	
	
		document.f1.action="./count_test_rpt.jsp?pcode="+document.f1.programme.value;
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
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				                <font color="#FFFFFF">RWSS Programmes </font>
			</td>	
		</tr>


<%
    String pcode = null;
	String pname = null;
	
%>
<TR> 
	<TD   valign=top  align="center" height="35%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>

<tr>
		<% 
	pcode=request.getParameter("programme_code");
		////System.out.println("Rdist   "   +rDist);
	if(pcode==null || pcode.equals("0"))
	{
	%>
		<td class = btext ><font color=navy><b>Grant</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="programme" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>
		
<%		session.setAttribute("pname",null);
		session.setAttribute("pcode",pcode);
		}
	

	else if(pcode != null && pcode.equals("51"))
	{%>
	<td class = btext><font color=navy><b>Programme code</b> </font>
	<font color="red"><b>*</b></font></td>
	<td class = btext colspan=3><SELECT name="pcode" style="width:150px" class="mycombo"  >
	<option value="0">SELECT...</option>
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("programme_name",pname);
		session.setAttribute("programme_code",pcode);

		
	} 
	else if(pcode.equals("51") )  
	{
	%>
	 <tr><td class = btext><font color=navy><b>District</b> </font>
	 <font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" >

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("programme_code",pcode);

		
	}
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct programme_code,programme_name   from rws_programme_tbl  order by programme_code");
	
	while(rs.next())
	{
		
		if(pcode != null && pcode.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
	<% 			
			request.setAttribute("programme_name",rs.getString(2));
			session.setAttribute("programme_code",rs.getString(1));


		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
		//session.setAttribute("dName",null);
		session.setAttribute("programme_code",pcode);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	
</table>

</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	//if(rDist!=null && !rDist.equals("0") && rDist.equals("51"))

	//	{
	//	
	%>

			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%
			//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);
		}
	finally
	{
		conn.close();
	}

		%>
</TD></TR>
</TABLE>
</form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>
