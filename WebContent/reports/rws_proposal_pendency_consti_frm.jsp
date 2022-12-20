<%@ page import="java.util.*"%>
<%@ include file = "conn3.jsp" %>
<%	 try {
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
ResultSet r1=null;	
	Statement s1=null,s2=null;
	Statement stmt2 = null;
	 rs1 = null;
	ResultSet rs2 = null;
	Statement st3 = null;
	ResultSet rs3 = null,r2=null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
	 Statement st6=null;
	 ResultSet rs6=null;%>
<script language="JavaScript">
<!--

	function fnSubmit()
	{

		 if(document.f1.district.selectedIndex=="")
			{
			alert("SELECT Represented By....");		
			return false;
			}
			else
		{
			document.f1.action="rws_proposal_pendency_consti_rpt.jsp";
			document.f1.submit();
		}
	}
	function valSubmit()
	{ 
		alert("Please SELECT Circle");
	}
//-->
</script>
<%@ include file = "header_rpt.jsp" %>
<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null,RepName=null,Const=null;
	String panchName=null;
	String repName=null;
	String aType=null;
	String aComp=null,scComp=null, compName=null, scName=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;
%>
<form name=f1 >
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=40%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
	
		
		<tr>
			<td  align="right" class="bwborder">
				Date:<%=sdf.format(new java.util.Date())%>
			</td>
		</tr>
			<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td algin="center" class="textborder" colspan="5"><font color="#FFFFFF">Pendency Details Report
			</font></td>	
		</tr>
		<tr>
			<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
					rDist = request.getParameter("district");
					// //System.out.println("Rdist   "   +rDist);	
					stmt = conn.createStatement();
					//rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd,RWS_ASSET_MAST_TBL  a, rws_panchayat_raj_tbl p, RWS_ASSET_SUBCOMP_PARAM_TBL ac where c.circle_office_code=a.circle_office_code and d.division_office_code=a.division_office_code and sd.subdivision_office_code=a.subdivision_office_code and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and a.asset_code=ac.asset_code order by c.circle_office_name");
	
		rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,  rws_work_proposal_tbl  wp  where c.circle_OFFICE_CODE = substr(wp.office_code,2,2)   order by circle_OFFICE_NAME");
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
						{%>	
							<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
						<%		session.setAttribute("dName",null);		
						} 
					}// END OF While

						%>
			</td>
		</tr>
		<tr>
			<td class = btext nowrap >
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
						//String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_ASSET_SUBCOMP_PARAM_TBL ac, RWS_ASSET_MAST_TBL  a,  RWS_division_OFFICE_TBL d where a.asset_code= ac.asset_code and d.circle_office_code=a.circle_office_code and d.division_office_code= a.division_office_code and a.circle_office_code="+rDist+" order by d.division_OFFICE_NAME";
						String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d,  rws_work_proposal_tbl  wp  where d.circle_OFFICE_CODE = substr(wp.office_code,2,2)and substr(wp.office_code,4,1)=d.division_office_code and d.CIRCLE_OFFICE_CODE= '"+ rDist + "' order by division_OFFICE_NAME";

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
								<%	
									session.setAttribute("mName",null);
							}
						}// END OF while 
					}// END OF 1 if
								%>
			</td>
		</tr>
		<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
					rPanch = request.getParameter("panchayat");
					if(rMand != null && !rMand.equals("0"))
					{
						stmt2 = conn.createStatement();
					String St2="SELECT distinct  d.subdivision_office_code,d.subdivision_OFFICE_NAME FROM  rws_work_proposal_tbl  wp,  RWS_subdivision_OFFICE_TBL d where d.circle_office_code=substr(wp.office_code,2,2) and d.division_office_code= substr(wp.office_code,4,1) and d.subdivision_office_code=substr(wp.office_code,5,2) and d.circle_office_code='"+rDist+"' and d.division_office_code='"+rMand+"' order by d.subdivision_OFFICE_NAME";
						rs2 =stmt2.executeQuery(St2);
						while(rs2.next())
						{
							if(rPanch != null && rPanch.equals(rs2.getString(1))) 
							{

					%>
						<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>
					<%
						panchName=rs2.getString(2);
						session.setAttribute("pName",panchName);
							}// END OF IF
							else
							{
					%>
								<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
					<%			session.setAttribute("pName",null);
							}
					}// END OF WHILE
				}// END OF IF
				else{
				session.setAttribute("pName",null);
				}%>
			</td>
			</tr>
		<tr>
			<td class = btext nowrap >
				<font color=navy><b>Represented By</b> </font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="repname" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
				
<%			
			 repName = request.getParameter("repname");
			// //System.out.println("Representative code   "   +repName);
		st4 = conn.createStatement();
	rs4 =st4.executeQuery("SELECT distinct r.REP_CODE,r.REP_NAME  from rws_publiC_rep_tbl r, rws_rep_proposal_tbl a where a.rep_code=r.rep_code  order by rep_code ");
	if(repName!=null && !repName.equals("0") && repName.equals("00"))
	{%>
	<option value="00" SELECTed>ALL </option>	
	<%
	//session.setAttribute("repname","ALL");
	session.setAttribute("repcode","00");
	}
	else
	{%>
		<option value="00">ALL</option>	
	<%
	
	}
		
	while(rs4.next())
	{
		
		if(repName != null && repName.equals(rs4.getString(1)) )
		{
%>
		<option value="<%= rs4.getString(1) %>" SELECTed><%= rs4.getString(2) %>
			

<% 	 RepName=rs4.getString(2);
	session.setAttribute("repcode",rs4.getString(1));
	session.setAttribute("repname",RepName);
	
		}// END OF IF
		else 
		{
%>		<option value="<%= rs4.getString(1) %>" ><%= rs4.getString(2) %>
<%		
		} 

		
	}// END OF While
	
	%>
</td>
		</tr>
		<tr>
			<td class = btext>
				<font color="navy"><b>Constituency</b></font>
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
</tr>
		<tr>
			<td class = btext nowrap >
				<font color=navy><b>From Date</b> </font>
			</td>
			<td class = btext colspan=2>
				<SELECT name="FDate" style="width:100px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs1=stmt1.executeQuery("select distinct to_char(rep_date,'dd/mm/yyyy') as rep_date1, rep_date from rws_rep_proposal_tbl order by rep_date"); 
	
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
		<TR >
		<td class = btext nowrap >
				<font color=navy><b>Asset Name</b> </font>
			</td>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="01" >PWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="02">MPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="03">CPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS</TD>
		</TR>
	
	<% if(rDist!=null && !rDist.equals("0")) {%>

	<tr>
		<td colspan=5 align=center>
			<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>

 <%} else{ %>
		<tr>
			<td colspan=5 align=center>
				<input type=button onclick="valSubmit()" value="View Report" class = btext>
			</td>
		</tr>

<% } %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e)
{
	e.printStackTrace();

}
finally
{
	conn.close();
}

%>