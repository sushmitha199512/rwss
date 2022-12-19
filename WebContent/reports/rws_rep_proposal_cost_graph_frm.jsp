<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%try {
Statement stmt1 = null,s1=null,s2=null,s3;
	Statement stmt2 = null;
	ResultSet rs1 = null,r1;
	ResultSet rs2 = null;
	Statement st3 = null;
	ResultSet rs3 = null,r2=null,r3;
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

	if(document.f1.chart.selectedIndex=="")
	{
		alert("SELECT TYPE OF CHART...")
		return false;
	}
	if(document.f1.district.selectedIndex=="")
	{
		alert("SELECT CIRCLE...")
		return false;
	}
	if(document.f1.cons.selectedIndex=="")
	{
		alert("SELECT CONSTITUENCY...")
		return false;
	}
	if(document.f1.finyear.selectedIndex=="")
	{
		alert("SELECT FINANCIAL YEAR...")
		return false;
	}

	document.f1.action="./rws_rep_proposal_cost_graph_rpt.jsp";
	document.f1.submit();
	}	
//-->
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

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
				<font color="#FFFFFF">Constituency - Cost - Year Details</font>
			</td>	
		</tr>
	
<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null,RepName=null,Const=null;
	String panchName=null;
	String repName=null;
	String Tchart = null;	
	
%>
<TR>
<TD   valign=top  align="center" height="40%" width="10%">


		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>

	<td class = btext><font color="navy" nowrap><b>Type of Chart</b></font>
	<font color="red"><b>*</b></font>
	</td>
	<td class = btext colspan=4>
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
			<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
	rDist = request.getParameter("district");
	////System.out.println("Rdist   "   +rDist);

	stmt = conn.createStatement();
	
	rs =stmt.executeQuery("SELECT distinct c.CIRCLE_OFFICE_CODE , c.circle_office_name,d.division_office_name,sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code  order by c.circle_office_name");
	
	

	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
			

<% 			
	 distName=rs.getString(2);
		session.setAttribute("dName",distName);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%		
		} 
		
	}// END OF While
	

%>
				
			</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
			</td>
			<td class = btext colspan=4>
				  <SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				

<%
	rMand = request.getParameter("mandal");
	// //System.out.println("mandal name   "   +rMand);
		if(rDist != null && !rDist.equals("0"))
		{
		stmt1 = conn.createStatement();
		String st="SELECT distinct d.division_OFFICE_CODE , d.division_office_name,sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)="+rDist;

		rs1 =stmt1.executeQuery(st);
		while(rs1.next())
		{
			if(rMand != null && rMand.equals(rs1.getString(1)))
			{
%>
		<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
		<%
	mandalName=rs1.getString(2);

	//out.println("DDDDDDDDDDDDDDDDDDDD"+mandalName);
	session.setAttribute("mName",mandalName);
			}// END OF IF
			else
			{
%>
		<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
	<%		}
		
		
		}// END OF IF 
		if(rMand.equals("0") || rMand==null)
		{
			session.setAttribute("mName",null);		}
		}// END OF While
		

%>					
			</td>
		</tr>
		<tr>
			<td nowrap class = btext >
				<font color="navy"><b>Sub Division</b></font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
			
<%
	rPanch = request.getParameter("panchayat");
	////System.out.println("RPaNCH IS  "+rPanch);

	if(rMand != null && !rMand.equals("0"))
	{
	stmt2 = conn.createStatement();
	/*String St2="SELECT subdivision_office_code,subdivision_office_name FROM RWS_SUBDIVISION_OFFICE_TBL where division_office_code="+rMand+" and CIRCLE_OFFICE_CODE="+rDist+" order by subdivision_office_name";*/
	String St2="SELECT distinct sd.subdivision_OFFICE_CODE , sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)='"+rDist+"' and substr(a.office_code,4,1)='"+rMand+"'";
	rs2 =stmt2.executeQuery(St2);
		while(rs2.next())
		{
			if(rPanch != null && rPanch.equals(rs2.getString(1))) 
			{

%>
	<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>

<%panchName=rs2.getString(2);
	session.setAttribute("pName",panchName);

			}// END OF IF
			else
			{
%>
<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
<%	
			}

		
		}// END OF FOR
		
	}// END OF IF
	else

		{
			session.setAttribute("pName",null);		}
	
%>

</td>
		
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Constituency</b></font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="cons" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
			<%
		String	Consti = request.getParameter("cons");
		if(rDist != null && !rDist.equals("0"))
		{
	
	// //System.out.println("Constituency name   "   +Consti);

		
		s1 = conn.createStatement();
		String st="SELECT distinct c.CONSTITUENCY_CODE, c.CONSTITUENCY_NAME from rws_CONSTITUENCY_TBL c,rws_rep_proposal_tbl a  where substr(lead_hab_code,3,3)=c.CONSTITUENCY_CODE and substr(a.office_code,2,2)='"+rDist+"' order by c.CONSTITUENCY_NAME";

		r1 =s1.executeQuery(st);
		while(r1.next())
		{
			if(Consti != null && Consti.equals(r1.getString(1)))
			{
%>
		<option value="<%= r1.getString(1)%>" SELECTed><%= r1.getString(2) %>
		<%	Const=r1.getString(2);
			session.setAttribute("consti",Const);
		
			
			}// END OF IF
			else
			{
%>
		<option value="<%= r1.getString(1)%>"><%= r1.getString(2) %>
		
<%	
			}

	
		}// END OF While
		if(Consti.equals("0"))
		{
			session.setAttribute("consti",null);		}		
}//end of if
	

%>
</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color=navy><b>Financial Year</b> </font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="finyear" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
		<%
		String	fy = request.getParameter("finyear");
		String fiy = request.getParameter("finyear");
		if(rDist != null && !rDist.equals("0"))
		{
			
			s3 = conn.createStatement();
			String stt="SELECT distinct   substr(proposal_id,3,4) from rws_rep_proposal_tbl  a WHERE substr(a.office_code,2,2)='"+rDist+"'";  

			r3 =s3.executeQuery(stt);
			while(r3.next())
			{
				fy = r3.getString(1);
				String  fnyr=r3.getString(1).substring(2,4);
					int fiyr =Integer.parseInt(fnyr);
					fiyr = fiyr + 1;
					if(fiyr>=10)
					{
						fy = fy + "-" + fiyr ;
					}
					else 
						fy = fy + "-0" + fiyr ;

					
					//System.out.println("yeeeaaarrr   "+fy);
				if(fiy != null && fiy.equals(r3.getString(1)))
				{
					
					
%>					
					<option value="<%= r3.getString(1)%>" SELECTed><%= fy %>
		<%			
					String finyr=r3.getString(1);
					session.setAttribute("Fyr",fy);
		
			
				}// END OF IF
				else
				{
			%>
				<option value="<%= r3.getString(1)%>"><%= fy%>		
			<%	
		
				}
		}
			}
		
			
		
		%>
		</td>
		</tr>
		<TR >
		<td class = btext nowrap >
				<font color=navy><b>Asset Name</b> </font>
			</td>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="01" >PWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="02">MPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="03">CPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS</TD>
		</TR>
		<tr>
			<td class = btext nowrap>
				<font color=navy><b>Grant Type</b> </font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="prg" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
		<%String	pc = request.getParameter("prg");
		if(rDist != null && !rDist.equals("0"))
		{
			
			s3 = conn.createStatement();
			String stt="select distinct rp.PROGRAMME_CODE, p.PROGRAMME_NAME  from rws_rep_proposal_tbl rp,RWS_PROGRAMME_TBL  p where rp.PROGRAMME_CODE=p.PROGRAMME_CODE and  substr(rp.office_code,2,2)='" + rDist +"'";  

			r3 =s3.executeQuery(stt);
			while(r3.next())
			{
			if(pc != null && pc.equals(r3.getString(1)))
			{
%>
		<option value="<%= r3.getString(1)%>" SELECTed><%= r3.getString(2) %>
		<%	String pcode=r3.getString(2);
			session.setAttribute("pCode",pcode);
		
			
			}// END OF IF
			else
			{
%>
		<option value="<%= r3.getString(1)%>"><%= r3.getString(2)%>
		
<%	
	
		
			}
		}
		if(pc.equals("0") || pc==null)
		{
			session.setAttribute("Pc",null);		}
		}// END OF IF 
		
		%>
		</td>
		</tr>

	</table>
</TD>
<%
	String fYear = request.getParameter("finyear");
	// //System.out.println("Finantial year   "   +fYear);

// //System.out.println(distName);
// //System.out.println(mandalName);
// //System.out.println(panchName);
	%>		
<INPUT TYPE="hidden" name="dName" value="<%=distName%>">
<INPUT TYPE="hidden" name="mName" value="<%=mandalName%>">
<INPUT TYPE="hidden" name="pName" value="<%=panchName%>">
<INPUT TYPE="hidden" name="rptName" value="<%=RepName%>">
<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">

</TR>
<TR>
<TD colspan=2 align=center valign=top>
<% if(rDist!=null && !rDist.equals("0")) {%>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View  Report" class = btext></td>
	</tr>
</table>
<%} else{ %>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View  Report" class = btext></td>
	</tr>
</table>
<% } %>
</TD></TR>
</TABLE>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}%>