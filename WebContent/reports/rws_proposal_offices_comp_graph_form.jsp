<%@ include file="/commons/rws_header1.jsp" %>
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
		alert("SELECT TYPE OF CHART...");		
		return false;
	}
	
	
	
	var f = f1.finyear.selectedIndex;
	if(f == -1)
	{
		alert("SELECT ONE OR MORE FINANCIAL YEARS...");		
		return false;
	}
	document.f1.action="./rws_proposal_offices_comp_graph_rpt.jsp";
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
	font-size:8pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:7pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">
 
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		<tr>
			 
		</tr>
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Office Wise Cost Details</font>
			</td>	
		</tr>
	
<%
	String rDist = null;
	String rCir = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null,RepName=null,Const=null;
	String panchName=null;
	String repName=null;
	String Tchart = null;	
	String fy = null;	
	String	Consti = null;
	
%>
<TR>
<TD   valign=top  align="center" height="40%" width="10%">


		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>

	<td class = btext>
		<font color="navy" nowrap><b>Type of Chart</b></font>
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
<TR>
		<td class = btext nowrap >
				<font color="navy"><b>Select Office </b> </font>
				<font color="red"><b>*</b></font>
			</td>
<%
	rDist = request.getParameter("offType");
	//System.out.println("Rdist   "   +rDist);
	if(rDist !=null && rDist.equals("01"))
	{
		//System.out.println("Rdist   if   " +rDist);%>

			
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="01" checked>CIRCLE
			</TD>
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="02" onclick="this.form.submit()">DIVISION
			</TD>
			<TD class="clrborder" colspan=2>
				<INPUT TYPE="radio" NAME="offType" value="03" onclick="this.form.submit()">SUB DIVISION
			</TD>
			
		</TR>
	<%}
		else if(rDist !=null && rDist.equals("02"))
		{
			//System.out.println("Rdist   if   " +rDist);%>

			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="01"onclick="this.form.submit()">CIRCLE
			</TD>
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="02" checked>DIVISION
			</TD>
			<TD class="clrborder" colspan=2>
				<INPUT TYPE="radio" NAME="offType" value="03" onclick="this.form.submit()">SUB DIVISION
			</TD>
			
		</TR>
	<%}
		else if(rDist !=null && rDist.equals("03"))
		{
			//System.out.println("Rdist   if   " +rDist);%>

			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="01" onclick="this.form.submit()">CIRCLE
			</TD>
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="02" onclick="this.form.submit()">DIVISION
			</TD>
			<TD class="clrborder" colspan=2>
				<INPUT TYPE="radio" NAME="offType" value="03" checked>SUB DIVISION
			</TD>
			
		</TR>
	<%}
		else
		{
			//System.out.println("Rdist  else "   +rDist);
%>
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="01" onclick="this.form.submit()">CIRCLE
			</TD>
			<TD class="clrborder">
				<INPUT TYPE="radio" NAME="offType" value="02" onclick="this.form.submit()">DIVISION
			</TD>
			<TD class="clrborder" colspan=2>
				<INPUT TYPE="radio" NAME="offType" value="03" onclick="this.form.submit()">SUB DIVISION
			</TD>
			
		</TR>
		<%}
				Consti = request.getParameter("cir");
				//System.out.println("Constituency name   "   +Consti);
		
				s1 = conn.createStatement();
				String st="SELECT distinct c.CIRCLE_OFFICE_CODE , c.circle_office_name,d.division_office_name,sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code  order by c.circle_office_name";

				r1 =s1.executeQuery(st);
		 if(rDist !=null && rDist.equals("01"))
			{
			%>
		
		<tr>
			<td class = btext nowrap >
				<font color="navy"><b>Circle</b></font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
		
			<select MULTIPLE size=3 name="consq" style="width:150px" >
				
				
			<%
				
				while(r1.next())
				{
					if(Consti != null && Consti.equals(r1.getString(1)))
					{
%>
					<option value="<%= r1.getString(1)%><%="-"%><%= r1.getString(2) %>" SELECTed><%= 	r1.getString(2) %>
				<%	Const=r1.getString(2);
					session.setAttribute("consti",Const);
					
		
			
					}// END OF IF
					else
					{
			%>
					<option value="<%= r1.getString(1)%><%="-"%><%= r1.getString(2) %>"><%= r1.getString(2) %>
		<%	
			session.setAttribute("mName",null);
			session.setAttribute("pName",null);
			}
	
			}// END OF While
			}
			if(rDist !=null && rDist.equals("02"))
			{ %>
				<tr>
					<td class = btext> 
					<font color=navy><b>Circle</b> </font>
					<font color="red"><b>*</b></font>
				</td>
				<td class = btext colspan=4>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
				rCir = request.getParameter("district");
				while(r1.next())
				{
		
				if(rCir != null && rCir.equals(r1.getString(1)) )
				{
%>
					<option value="<%= r1.getString(1) %>" SELECTed><%= r1.getString(2) %>
			<% 			
					distName=r1.getString(2);
					session.setAttribute("dName",distName);		
				}// END OF IF
				else 
				{
%>					<option value="<%= r1.getString(1) %>" ><%= r1.getString(2) %>
<%				} 
		
			}// END OF While


	if(rCir != null && !rCir.equals("0"))
		{
		rMand = request.getParameter("mandal");
		%>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
			</td>
			<td class = btext colspan=4>
		
			<select MULTIPLE size=3 name="divi" style="width:150px" >
		<%

		stmt1 = conn.createStatement();
		String st1="SELECT distinct d.division_OFFICE_CODE , d.division_office_name,sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)="+rCir;

		rs1 =stmt1.executeQuery(st1);
		while(rs1.next())
			{
%>
		<option value="<%= rs1.getString(1)%><%="-"%><%= rs1.getString(2) %>"><%= rs1.getString(2) %>
	<%		
	session.setAttribute("mName",rs1.getString(2));
	session.setAttribute("pName",null);
	}

		

		}// END OF IF 
		

%>					
			</td>
		</tr>

	<%		}

		if(rDist !=null && rDist.equals("03"))
			{ %>
				<tr>
					<td class = btext> 
					<font color=navy><b>Circle</b> </font>
					<font color="red"><b>*</b></font>
				</td>
				<td class = btext colspan=4>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
				rCir = request.getParameter("district");
				while(r1.next())
				{
		
				if(rCir != null && rCir.equals(r1.getString(1)) )
				{
%>
					<option value="<%= r1.getString(1) %>" SELECTed><%= r1.getString(2) %>
			<% 			
					distName=r1.getString(2);
					session.setAttribute("dName",distName);		
				}// END OF IF
				else 
				{
%>					<option value="<%= r1.getString(1) %>" ><%= r1.getString(2) %>
<%				} 
		
			}// END OF While
%>
				
			</td>
		</tr>
		<tr>
			<td class = btext nowrap >
				<font color="navy"><b>Division</b></font>
				<font color="red"><b>*</b></font>
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
		String st2="SELECT distinct d.division_OFFICE_CODE , d.division_office_name,sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)="+rCir;

		rs1 =stmt1.executeQuery(st2);
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
	<%			
	}
		
		
		}// END OF IF 
		
		}// END OF While
		

%>					
			</td>
		</tr>
		<%

	if(rMand != null && !rMand.equals("0"))
		{
		//rMand = request.getParameter("mandal");
		%>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b> Sub Division</b></font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
		
			<select MULTIPLE size=3 name="subdivi" style="width:150px" >
		<%

		stmt1 = conn.createStatement();
		String st1="SELECT distinct sd.subdivision_OFFICE_CODE , sd.subdivision_office_name from rws_circle_office_tbl c,rws_division_office_tbl d, rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr,rws_Rep_proposal_tbl a, RWS_PROPOSAL_HAB_LNK_TBL ah where  c.circle_office_code=substr(a.office_code,2,2) and d.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.proposal_id=ah.proposal_id and pr.panch_code=ah.hab_code and substr(a.office_code,2,2)='"+rCir+"' and substr(a.office_code,4,1)='"+rMand+"'";

		rs1 =stmt1.executeQuery(st1);
		while(rs1.next())
			{
%>
		<option value="<%= rs1.getString(1)%><%="-"%><%= rs1.getString(2) %>"><%= rs1.getString(2) %>
	<%	
			session.setAttribute("pName",rs1.getString(2));
		}

		

		}// END OF IF 
		

%>					
			</td>
		</tr>

	<%		}

	

try {	%>
</SELECT>
</td>
		</tr>
		<tr>
			<td class = btext  >
				<font color=navy><b>Financial Year</b> </font>
				<font color="red"><b>*</b></font>
			</td>
			<td class = btext colspan=4>
				<select MULTIPLE size=3 name="finyear" style="width:150px" >
				<!-- <SELECT name="finyear" style="width:150px" class="mycombo" onChange="this.form.submit()"> -->
				<!-- <option value="0">SELECT...</option>	 -->
		<%	
			
			String fiy = request.getParameter("finyear");
			
			//System.out.println("yeeeaaarrr   "+fy);
			s3 = conn.createStatement();
			String stt="SELECT distinct   substr(proposal_id,3,4) from rws_rep_proposal_tbl  a";  

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
					session.setAttribute("Fyr",fy);
		
			%>
				<option value="<%= r3.getString(1) %>"><%= fy%>		
			<%	
		
				
		}
			
		if(fy.equals("0") || fy==null)
		{
			session.setAttribute("Fyr",null);		}}catch(Exception e)
	{//System.out.println("eerroorr is "+e);

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

			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Graph" class = btext></td>
	</tr>
</table>


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