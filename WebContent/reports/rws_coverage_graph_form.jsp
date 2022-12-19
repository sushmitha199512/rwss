<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
 
	 function unview()
{
		
    var a=document.getElementById('combo').value;
	 
	if(a=="0")
	{
       document.getElementById('vbuton').disabled=true;
	}
	 
}

function fnSubmit()
{
	if(document.f1.chart.value=="0")
	{
		alert("Please Select Type Of Chart");
	}
	else if(document.f1.district.value=="0")
	{
		alert("Please Select District");
	}
	else if(document.f1.FDate.value!="")
	{
		document.f1.action="./rws_coverage_status_graph_rpt.jsp";
		document.f1.submit();
		
	}	
}
	function valSubmit()
	{ 		alert("please SELECT District");
		
	}
		function valMand()
	{ 
		alert("please SELECT Mandal");
		
	}
	function valPanch()
	{ 
		alert("please SELECT Panchayat");
		
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
<body bgcolor="#edf2f8" onLoad="unview()">

<form name=f1 method="get" action="<%= request.getRequestURI()%>">

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
				<font color="#FFFFFF">Coverage Status Graph</font>
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
	<TD   valign=top  align="center" height="35%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>

	<td class = btext nowrap><font color="navy" ><b>Type of Chart</b></font>
	<font color="red">*</font></td>
	<td class = btext colspan=3>
	<SELECT name="chart"   style="width:150px" class="mycombo" onchange="this.form.submit()">
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
					<option value="d">Area</option>

			<%} else if(Tchart.equals("b"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Bar </option>
					<option value="p">Pie </option>
					<option value="l">Horizantal Bar</option>
					<option value="d">Area</option>

			<%} else if(Tchart.equals("l"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Horizantal Bar </option>
					<option value="p">Pie </option>
					<option value="b">Bar</option>		
					<option value="d">Area</option>


			<%} else if(Tchart.equals("d"))
			{
				////System.out.println("KKKKKKKKKKKKKKKKKK    :");%>
					<option value="<%=Tchart %>" SELECTed>Area </option>
					<option value="p">Pie </option>
					<option value="b">Bar</option>		
					<option value="l">Horizantal Bar</option>
		
			<%} 
		}
		else
		{%>
			<option value="p">Pie </option>
			<option value="b">Bar</option>		
			<option value="l">Horizantal Bar</option>
			<option value="d">Area</option>

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
		<td class = btext ><font color=navy><b>District</b> </font>
		<font color="red"><b>*</b></font>
		</td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	else if(rDist != null && rDist.equals("51"))
	{%>
	<td class = btext><font color=navy><b>District</b> </font>
	<font color="red"><b>*</b></font></td>
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
	 <td class = btext><font color=navy><b>District</b> </font>
	 <font color="red"><b>*</b></font></td>
		<td class = btext colspan=3><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dcode,d.dname");

	
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
			String st="SELECT  distinct m.mcode,m.mname  from rws_district_tbl d, rws_mandal_tbl m, rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and substr(h.hab_code,1,2)="+rDist + " order by m.mcode,m.mname";
			rs1 =stmt1.executeQuery(st);
		
		if(rDist == null || rDist.equals("0") ){%>
		<td class = btext><font color="navy"><b>Mandal</b></font></td>
		<td class = btext colspan=3>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
	
	<%
		session.setAttribute("mName",null);
		session.setAttribute("mCode","0");
		}				
		
		else if(rDist != null && !rDist.equals("0") && !rDist.equals("51") && rMand.equals("0") && !rMand.equals("5200"))
		{%>
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
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
				session.setAttribute("mCode","0");

				}

		if(rDist != null && !rDist.equals("0") && !rDist.equals("51") && !rMand.equals("0") && !rMand.equals("5200"))
		{%>
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
		 <option value="5200"> ALL</option> 

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
							session.setAttribute("mCode",rs1.getString(1));

					}// END OF IF
					else
					{
						%>
						<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
		
						<%	
					}
				}// END OF while
			}// END OF if
			else if(rMand != null && rMand.equals("5200") && !rDist.equals("51") && !rDist.equals("0"))
			{%>

			<td class = btext><font color="navy"><b>Mandal</b></font></td>
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
				session.setAttribute("mCode","0");

				}
			
		
			else if(rDist.equals("51"))
			{%>
			
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	<INPUT TYPE="hidden" name="mandal" value="0"> 
						
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode","0");

				}
			}catch(Exception e){}
			////System.out.println("out of if");
				%>
		
	</SELECT></td>		
		</tr>
	<tr>
<%
		try {
		rPanch = request.getParameter("panchayat");
		
		stmt2 = conn.createStatement();
		String St2=	"select distinct p.pcode,p.pname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)='"+rDist+ "' and substr(h.hab_code,6,2)='"+rMand+"' order by p.pcode,p.pname";
		rs2 =stmt2.executeQuery(St2);


		if(rDist == null || rDist.equals("0") ){%>
		<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
	else if((!rDist.equals("51") && !rDist.equals("0")) && (rMand==null || rMand.equals("0"))){%>
		<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
		else if(!rDist.equals("0") && !rDist.equals("51") && !rMand.equals("5200") && rPanch.equals("0")){%>
				<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%	
			 while(rs2.next())
					{%> 
					<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				 <% }	

		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");
	
		}

	else if(rMand != null &&  !rMand.equals("5200") && !rMand.equals("0") && !rDist.equals("0") && !rDist.equals("51")  && rPanch.equals("5300") )
	{
		%>
	<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" SELECTed> ALL</option> 
		<% 
			 while(rs2.next())
					{%> 
					<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				 <% }	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");
	
		}
		else if(!rDist.equals("0") &&!rDist.equals("51") && !rMand.equals("5200") && !rMand.equals("0")  && !rPanch.equals("5300") && !rPanch.equals("0"))
			{			%>
		<td class = btext><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
			
			<%
				////System.out.println("heellllloooo");
			while(rs2.next())
			{
				if(rPanch != null && rPanch.equals(rs2.getString(1))) 
				{
				%>
				<option value="<%= rs2.getString(1)%>" selected><%= rs2.getString(2) %>
				<%
					session.setAttribute("pName",rs2.getString(2));
					session.setAttribute("pCode",rs2.getString(1));
				}// END OF IF
				else
				{
				%>
				<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				<%	
				}
			}// END while
			}
	  else if( rMand.equals("5200") || rDist.equals("51"))
		{%>

			<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
			<td class = btext colspan=3>
				<SELECT name="panchayat" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<INPUT TYPE="hidden" name="panchayat" value="0"> 
				

<%			session.setAttribute("pName",null);
			session.setAttribute("pCode","0");

	
	}
	
	}catch(Exception e) {
	//System.out.println("Error is sadiq "+e); 
	} 
		
%>
</SELECT></td>
</tr>
<tr>
			<td class = btext nowrap >
				<font color=navy><b>Status Date</b> </font>
				<font color=red><b>*</b> </font>
			</td>
			<td class = btext >
				<SELECT name="FDate" id="combo"style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!-- <option value="0">SELECT...</option>	 -->
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//rs1=stmt1.executeQuery("select distinct to_char(status_date,'dd/mm/yyyy') from rws_habitation_directory_tbl "); 
	rs1=stmt1.executeQuery("select DISTINCT (to_Date(status_date,'dd/mm/yyyy')) as status_date1, TO_CHAR(status_date,'DD-MON-YYYY') AS STATUS_DATE from rws_habitation_directory_tbl "); 
	
	while(rs1.next())
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(2)) )
		{
%>
		<option value="<%= rs1.getString(2) %>" SELECTed><%= rs1.getString(2) %>
			

<% 			
	 FDATE=rs1.getString(2);


	session.setAttribute("FDATE",FDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(2) %>" ><%= rs1.getString(2) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			
		</tr>
	
</table>

</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	//if(rDist!=null && !rDist.equals("0"))

		//{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="vbuton" onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%//}	 
		} catch(Exception e){	//System.out.println("Error is ali "+e);`
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
</html>
<%@ include file = "footer.jsp" %>


