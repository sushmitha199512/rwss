<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
	try
	{
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt6 = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		Statement st3 = null;
		ResultSet rs3 = null;
		Statement st4 = null;
		ResultSet rs4 = null;
		Statement st5 = null;
    	ResultSet rs5 = null;
		ResultSet rs6 = null;

%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
<!--
	function fnSubmit()
		{
		document.f1.action="./rws_wq_sam_res_rpt.jsp";
		document.f1.submit();
		}
//-->
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

<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
		</table>
	</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Water Quality Status Report</font>
			</td>	
		</tr>

<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Tchart = null;
	String distName = null;
	String mandalName = null;
	String panchName = null;
	String dCode = null;
	String mCode = null;
	String pCode = null;
	
%>
<tr> 
	<td valign=top  align="center" height="30%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>	
	<tr>
<% 
	rDist = request.getParameter("district");
	//System.out.println("Rdist   "   +rDist);
	
	if(rDist==null || rDist.equals("0"))
	{
%>
		<td class = btext><font color=navy><b>District</b> </font></td>
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

			<option value="0">SELECT...</option>
			<option value="51"> ALL</option>
		
<%		
		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
	}
	else 
		if(rDist != null && rDist.equals("51"))
		{	
%>
		<td class = btext><font color=navy><b>District</b> </font></td>
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
			
			<option value="0">SELECT...</option>
			<option value="51" SELECTed> ALL</option>
<% 
		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		
		} 
		else if(!rDist.equals("0"))  
		{
%>
		<td class = btext><font color=navy><b>District</b> </font></td>
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

			<option value="0">SELECT...</option>
			<option value="51">ALL</option> 
	
<%
		//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);		
		}
	
		stmt = conn.createStatement();
		rs =stmt.executeQuery("SELECT distinct d.dcode, d.dname from rws_district_tbl d, rws_mandal_tbl m, rws_panchayat_tbl p, RWS_WATER_SAMPLE_COLLECT_TBL s where d.dcode=substr(s.hab_code,1,2) and m.mcode=substr(s.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(s.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode order by  d.dname");

	
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
%>			
		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
			//session.setAttribute("dName",null);
			session.setAttribute("dCode",rDist);

			} 
		}// END OF While
		
%>

		</select>
		</td>


		

		

		</select>
				</td>			
		</tr>
		<tr>
	<%	try
		{
		if(rDist == null || rDist.equals("0") ){%>
	<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
	<%	session.setAttribute("mName",null);
		session.setAttribute("mCode",rMand);

		}
		rMand = request.getParameter("mandal");
		////System.out.println("mandal name   "   +rMand);
		
		if(rDist != null && !rDist.equals("0") && !rDist.equals("51"))
		{%>
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
		 <option value="52"> ALL	</option> 
		<%
			stmt1 = conn.createStatement();
			String st="SELECT  distinct m.mcode,m.mname  from rws_district_tbl d, rws_mandal_tbl m, rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and substr(h.hab_code,1,2)="+rDist + " order by m.mname";
			rs1 =stmt1.executeQuery(st);
			if(rMand!=null && !rMand.equals("52"))
			{
				////System.out.println("heellllloooo");
				while(rs1.next())
				{
					if(rMand != null && rMand.equals(rs1.getString(1)))
					{
					%>
						<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
						<%
							session.setAttribute("mName",rs1.getString(2));
							session.setAttribute("mCode",rMand);

					}// END OF IF
					else
					{
						%>
						<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
		
						<%	
					}
				}// END OF while
			}// END OF if
			else if(rMand != null && rMand.equals("52"))
				{
				 while(rs1.next())
					{%> 
					<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	%>
					<option value="52" SELECTed> ALL	</option>
				
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode",rMand);

				}
			else if(rMand == null || rMand.equals("0"))
				{
				 while(rs1.next())
					{%> 
					<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	
				
				session.setAttribute("mName",null);
				session.setAttribute("mCode",null);

			}
		    
			else if(rDist.equals("51"))
			{%>
			
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext>
	<SELECT name="mandal" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
						
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode",null);

				}
			}catch(Exception e){}
			////System.out.println("out of if");
				%>
		
	</SELECT></td>
	
	<tr>
<%
		try {
		rPanch = request.getParameter("panchayat");
		////System.out.println("panchayat code   "   +rPanch);

		if(rDist == null || rDist.equals("0") || rPanch==null ){%>
		<td class = btext><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="53" > ALL</option> 
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
		else if(!rDist.equals("0") && !rDist.equals("51") && rMand.equals("0")){%>
				<td class = btext><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="53" > ALL</option> 
<%
		session.setAttribute("pName",null);
		session.setAttribute("pCode",null);
	
		}

	else if(rMand != null &&  !rMand.equals("52") && !rMand.equals("0") && !rDist.equals("0") && !rDist.equals("51")  && rPanch.equals("53") )
	{
		%>
	<td class = btext><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="53" SELECTed> ALL</option> 
		<% 
		session.setAttribute("pName",null);
		session.setAttribute("pCode",rPanch);
	
		}
		else if(!rPanch.equals("0")  && !rDist.equals("51") && !rMand.equals("52"))
		{%>
				<td class = btext><font color="navy"><b>Panchayat</b></font></td>
				<td class = btext>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<option value="52" SELECTed> ALL	</option>
			<%
					session.setAttribute("pName",null);
				session.setAttribute("pCode",rPanch);
	
			}
			
	  else if( rMand.equals("52") || rDist.equals("51"))
		{%>

			<td class = btext><font color="navy"><b>Panchayat</b></font></td>
			<td class = btext>
				<SELECT name="panchayat" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>

<%			session.setAttribute("pName",null);
			session.setAttribute("pCode",null);
	
	}
	
	}catch(Exception e) {}
		
%>
</SELECT></td>

</table>
<INPUT TYPE="hidden" name="chart" value="<%=Tchart%>">
</TD>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	if(rDist!=null && !rDist.equals("0") )

		{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%}	 
		} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}

		%>
</TD>

</TR>




</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>


