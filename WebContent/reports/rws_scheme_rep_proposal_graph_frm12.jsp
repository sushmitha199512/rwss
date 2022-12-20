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
	
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">
<!--
function fnSubmit()
{

	document.f1.action="./rws_circle_rep_proposal_graph_rpt.jsp";
	document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("SELECT CIRCLE");
		
	}
		function valMand()
	{ 
		alert("SELECT DIVISION");
		
	}
	function valPanch()
	{ 
		alert("SELECT SUB DIVISION");
		
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
<%@ include file = "header_rpt.jsp" %>
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Office Wise Representative Proposal</font>
			</td>	
		</tr>


<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Tchart = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String dCode=null;
	String mCode=null;
	String pCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;	
%>
<TR> 
	<TD   valign=top  align="center" height="30%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>

	<td class = btext nowrap><font color="navy" nowrap><b>Type of Chart</b></font>
	<font color="red"><b>*</b></font>
	</td>
	<td class = btext colspan=3>
	<SELECT name="chart" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		
<%
	Tchart = request.getParameter("chart");
	////System.out.println("Type of chart is   "   +Tchart);
	
	if(Tchart != null && !Tchart.equals("0"))
		{
		if(Tchart.equals("p"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Pie</option>
					<option value="b">Bar</option>		
					<option value="l">Horizantal Bar</option>
				

			<%} else if(Tchart.equals("b"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Bar </option>
					<option value="p">Pie </option>
					<option value="l">Horizantal Bar</option>
					

			<%} else if(Tchart.equals("l"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Horizantal Bar </option>
					<option value="p">Pie </option>
					<option value="b">Bar</option>		
					
				
			<%} 
		}
		else
		{%>
			<option value="p">Pie </option>
			<option value="b">Bar</option>		
			<option value="l">Horizantal Bar</option>


		<%}%>
	
</SELECT></td>

</tr>
<tr>
		<% 
	rDist = request.getParameter("district");
	////System.out.println("Rdist   "   +rDist);
	if(rDist==null || rDist.equals("0"))
	{
	%>
		<td class = btext><font color=navy><b>Circle</b> </font>
		<font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0" >SELECT...</option>
		<option value="51"> ALL		</option>
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	else if(rDist != null && rDist.equals("51"))
	{%>
	<td class = btext><font color=navy><b>Circle</b> </font>
	<font color="red"><b>*</b></font>
	</td>
	<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
	<option value="0">SELECT...</option>
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		
	} 
	else if(!rDist.equals("0"))  
	{
	%>
	 <td class = btext><font color=navy><b>Circle</b> </font>
	 <font color="red"><b>*</b></font>
	 </td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
		

	rs =stmt.executeQuery("SELECT distinct c.CIRCLE_OFFICE_CODE , c.circle_office_name from rws_circle_office_tbl c, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and  a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code");
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
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
		//session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	<tr>
	<%	try
		{
		rMand = request.getParameter("mandal");
		////System.out.println("mandal name   "   +rMand);
		
			stmt1 = conn.createStatement();
		String st="SELECT distinct d.division_OFFICE_CODE , d.division_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and c.circle_office_code=d.circle_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)='"+ rDist + "'" ;
			rs1 =stmt1.executeQuery(st);
		if(rDist == null || rDist.equals("0") ){%>
		<td class = btext><font color="navy"><b>Division</b></font></td>
		<td class = btext colspan=3>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
	
	<%
		session.setAttribute("mName",null);
		session.setAttribute("mCode",rMand);
		}
		else if(rMand==null)
			{%>
		<td class = btext><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
		 <option value="5200"> ALL</option> 
		 	
		<%
				 while(rs1.next())
					{%> 
					<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	%>

				
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode",rMand);

				}
					

		else if(rDist != null && !rDist.equals("0") && !rDist.equals("51") && rMand!=null && !rMand.equals("5200"))
		{%>
			<td class = btext ><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
		 <option value="5200"> ALL	</option> 

		<%	
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
			else if(rMand != null && rMand.equals("5200"))
			{%>

			<td class = btext><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		<option value="5200" SELECTed> ALL	</option> 

			<%
				 while(rs1.next())
					{%> 
					<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	%>

				
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode",rMand);

				}
			
		
			else if(rDist.equals("51"))
			{%>
			
			<td class = btext><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
						
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode",null);

				}
			}catch(Exception e){//System.out.println("THe error in division " +e);}
			////System.out.println("out of if");
				%>
		
	</SELECT></td>		
		</tr>
	<tr>
<%
		try {
		rPanch = request.getParameter("panchayat");
		////System.out.println("panchayat code   "   +rPanch);

		if(rDist == null || rDist.equals("0") || rPanch==null ){%>
		<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		  <option value="5300" > ALL</option> 
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
		else if(!rDist.equals("0") && !rDist.equals("51") && rMand.equals("0")){%>
				<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%
		session.setAttribute("pName",null);
		session.setAttribute("pCode",null);
	
		}
		else if(!rDist.equals("0") && !rDist.equals("51") && !rMand.equals("5200") && rPanch.equals("0")){%>
				<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%
		session.setAttribute("pName",null);
		session.setAttribute("pCode",null);
	
		}

	else if(rMand != null &&  !rMand.equals("5200") && !rMand.equals("0") && !rDist.equals("0") && !rDist.equals("51")  && rPanch.equals("5300") )
	{
		%>
	<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" SELECTed> ALL</option> 
		<% 
		session.setAttribute("pName",null);
		session.setAttribute("pCode",rPanch);
	
		}
		else if(!rPanch.equals("0")  && !rDist.equals("51") && !rMand.equals("5200"))
		{%>
				<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
				<td class = btext colspan=3>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<option value="5200" SELECTed> ALL	</option>
			<%
					session.setAttribute("pName",null);
				session.setAttribute("pCode",rPanch);
	
			}
			
	  else if( rMand.equals("5200") || rDist.equals("51"))
		{%>

			<td class = btext nowrap><font color="navy"><b>Sub Division</b></font></td>
			<td class = btext colspan=3>
				<SELECT name="panchayat" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>

<%			session.setAttribute("pName",null);
			session.setAttribute("pCode",null);
	
	}
	
	}catch(Exception e) {//System.out.println("THe error in subdivsion " +e);}
		
%>
</SELECT></td>
<tr>
			<td class = btext nowrap >
				<font color=navy><b>From Date</b> </font>
			</td>
			<td class = btext >
				<SELECT name="FDate" style="width:100px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs1=stmt1.executeQuery("select distinct to_char(rp.rep_date,'dd/mm/yyyy') from rws_rep_proposal_tbl rp "); 
	
	while(rs1.next())
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 FDATE=rs1.getString(1);


	session.setAttribute("FDATE",FDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			<td class = btext nowrap >
				<font color=navy><b>To Date</b> </font>
			</td>
			<td class = btext >
				<SELECT name="TDate" style="width:100px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
<%
					toDate = request.getParameter("TDate");
	// //System.out.println("Rdist   "   +rDist);

	while(rs1.next())
	{
		
		if(toDate != null && toDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 TDATE=rs1.getString(1);


	session.setAttribute("TDATE",TDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
						%>
		</tr>
	
</table>
<INPUT TYPE="hidden" name="chart" value="<%=Tchart%>">
</TD>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	if(rDist!=null && !rDist.equals("0")  && !Tchart.equals("0"))

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
</TD></TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>


