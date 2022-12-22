<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "conn.jsp" %>
<% try {
	ResultSet r1=null;
	
	Statement stmt1 = null,s1=null,s2=null,s3;
	Statement stmt2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5=null;

	ResultSet rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null,r2=null,r3;
	ResultSet rs4 = null;
	ResultSet rs5=null;
	%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">
<!--

function fnSubmit()
{

	document.f1.action="./rws_om_proposal_rpt.jsp";
	document.f1.submit();
	}
	function valSubmit()
	{ 
		alert("Please SELECT Circle");
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
	font-size:8pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">
<%@ include file = "header_rpt.jsp" %>
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="60%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
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
				<font color="#FFFFFF">O & M Proposal Details</font>
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
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		<tr>
			<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
			</td>
			<td class = btext>
				<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

				<option value="0">SELECT...</option>
				<%
					rDist = request.getParameter("district");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c,rws_division_office_tbl d,rws_subdivision_office_tbl sd, rws_panchayat_raj_tbl pr, rws_asset_hab_tbl ah,RWS_ASSET_MAST_TBL  am,rws_om_proposal_tbl a  where c.circle_office_code=substr(a.office_code,2,2) and sd.division_office_code=substr(a.office_code,4,1) and sd.subdivision_office_code=substr(a.office_code,5,2) and c.circle_office_code=d.circle_office_code and d.circle_office_code=sd.circle_office_code and d.division_office_code=sd.division_office_code and pr.panch_code=ah.hab_code and ah.asset_code=a.asset_code and ah.asset_code=am.asset_code and a.asset_code=am.asset_code "); 
	
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
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
						%>
			</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
			</td>
			<td class = btext>
				  <SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<%
					rMand = request.getParameter("mandal");
	// //System.out.println("mandal name   "   +rMand);
		if(rDist != null && !rDist.equals("0"))
		{
		stmt1 = conn.createStatement();
		String st="SELECT distinct d.division_office_code,d.division_OFFICE_NAME,a.office_code FROM RWS_division_OFFICE_TBL d,rws_om_proposal_tbl a where d.CIRCLE_OFFICE_CODE=substr(a.office_code,2,2) and substr(a.office_code,4,1)=d.division_office_code and d.CIRCLE_OFFICE_CODE="+rDist+" order by division_OFFICE_NAME";

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
			}
		}// END OF IF 
		if(rMand.equals("0") || rMand==null)
		{
			session.setAttribute("mName",null);		}
		}// END OF While

								%>
			</td>
		</tr>
		<tr>
			<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font>
			</td>
			<td class = btext>
				<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>	
				<%
						rPanch = request.getParameter("panchayat");

	if(rMand != null && !rMand.equals("0"))
	{
	stmt2 = conn.createStatement();
	String St2="SELECT distinct sd.subdivision_office_code,sd.subdivision_OFFICE_NAME,a.office_code FROM RWS_subdivision_OFFICE_TBL sd,rws_om_proposal_tbl a where sd.CIRCLE_OFFICE_CODE=substr(a.office_code,2,2) and substr(a.office_code,4,1)=sd.division_office_code and substr(a.office_code,5,2)=sd.subdivision_office_code  and  sd.division_office_code="+rMand+" and sd.circle_office_code="+rDist+" order by sd.subdivision_OFFICE_NAME";
	/*String St2="SELECT distinct sd.subdivision_office_code,sd.subdivision_OFFICE_NAME,a.office_code FROM RWS_subdivision_OFFICE_TBL sd,rws_om_proposal_tbl a where sd.CIRCLE_OFFICE_CODE=substr(a.office_code,2,2) and substr(a.office_code,4,1)=sd.division_office_code and substr(a.office_code,5,2)=sd.subdivision_office_code order by sd.subdivision_OFFICE_NAME";*/
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
		</tr>

		<tr>
			<td class = btext nowrap >
				<font color=navy><b>Represented By</b> </font>
			</td>
			<td class = btext>
				<SELECT name="repname" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
				<%	if(rDist != null && !rDist.equals("0"))
					{
					repName = request.getParameter("repname");
					stmt = conn.createStatement();
					rs =stmt.executeQuery("SELECT * from rws_publiC_rep_tbl order by rep_code");	
					while(rs.next())
					{
					if(repName != null && repName.equals(rs.getString(1)) )
					{
				%>
					<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
				<% 	 RepName=rs.getString(2);
				session.setAttribute("repname",RepName);
	
					}// END OF IF
					else 
					{
				%>	
					<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
				<%		
					} 
				}// END OF While
				if(repName.equals("0")|| repName==null)
		{
			session.setAttribute("repname",null);		}
				}// END OF if
				%>
			</td>
		</tr>
		<tr>
			<td class = btext>
				<font color="navy"><b>Constituency</b></font>
			</td>
			<td class = btext>
				<SELECT name="cons" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<%
				String	Consti = request.getParameter("cons");
	// //System.out.println("Constituency name   "   +Consti);

		if(rDist != null && !rDist.equals("0"))
					{
		s1 = conn.createStatement();
		String st="SELECT distinct  c.CONSTITUENCY_CODE, c.CONSTITUENCY_NAME from rws_om_proposal_tbl om, rws_asset_mast_tbl am,rws_CONSTITUENCY_TBL c where substr(am.hab_code,3,3)=c.CONSTITUENCY_CODE and am.asset_code=om.asset_code order by c.CONSTITUENCY_NAME";

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

		}// END OF IF 
		if(Consti.equals("0"))
		{
			session.setAttribute("consti",null);		}	
		}		
				%>
			</td>
		</tr>
		<tr>
			<td class = btext nowrap>
				<font color=navy><b>Financial Year</b> </font>
			</td>
			<td class = btext>
				<SELECT name="finyear" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
				<%String	fy = request.getParameter("finyear");
			// //System.out.println("finantial year  "   +fy);	
			
				if(rDist != null && !rDist.equals("0"))
				{

			s3 = conn.createStatement();
			String stt="SELECT distinct   FINANCIAL_YEAR from rws_om_proposal_tbl om, rws_asset_mast_tbl am  where am.asset_code=om.asset_code order by FINANCIAL_YEAR ";

			r3 =s3.executeQuery(stt);
			while(r3.next())
			{
			if(fy != null && fy.equals(r3.getString(1)))
			{
%>
		<option value="<%= r3.getString(1)%>" SELECTed><%= r3.getString(1) %>
		<%	String finyr=r3.getString(1);
			session.setAttribute("Fyr",finyr);		
			
			}// END OF IF
			else
			{
%>
		<option value="<%= r3.getString(1)%>"><%= r3.getString(1)%>
		
<%	

		}// END OF IF 
					}
	if(fy.equals("0") || fy==null)
		{
			session.setAttribute("Fyr",null);		}
	}
				%>
				
			</td>
		</tr>
		<tr>
			<td colspan="2" class = btext nowrap >
				<font color=navy><b>Asset Type:</b> </font>
				<INPUT TYPE="radio" NAME="assetType" value="01">PWS
				<INPUT TYPE="radio" NAME="assetType" value="02">MPWS<br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;
				<INPUT TYPE="radio" NAME="assetType" value="03">CPWS
				<INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS
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

<TD  valign=top height=40% align="center" width="100%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">O & M Proposal Details</font>
			</td>
			</tr>	
		</table>
<div  style="position:relative;overflow-y:auto;left:0;height:220;width:100%;top:0;">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=100%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">	
		<tr  bgcolor="#ffffff">
			<td class = btext >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="a.PROPOSAL_NAME,Proposal Name" disabled checked>
			</td>
			<td class = btext>
				Work Description
			</td>
		<tr>
			<td class = btext >
				<INPUT TYPE="checkbox" NAME="ch"  id="ck" value="PANCH_NAME,Habitation" disabled checked>
			</td>
			<td class = btext>
				Habitation
			</td>
		<tr>
			<td class = btext >
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="a.OM_PROPOSAL_ID,OM Proposal ID"></td> <td class = btext>Proposal ID
			</td>
			<tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.work_id,'---'),Work Id">
			</td>
			<td class = btext>
				Work Id
			</td> 
		<tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.NO_OF_HABS,'0'),No of Habitations">
			</td>
			<td class = btext>
				No of Habitations
			</td>
		<tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value="nvl(a.ESTIMATE_COST,'0'),Estimate Cost (Rs. in Lakhs)">
			</td>
			<td class = btext>
				Estimated Cost
			</td>
			
		<tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(DECODE(a.FLAG,'N','Not Considered','C','Considered','A','Sanctioned','D','Differdred','P','Pending for Sanction'),'--'),Status">
			</td>
			<td class = btext>	
				Status
			</td>
		<tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "to_char(a.PREPARED_ON,'dd/mm/yyy'),Prepared On">
			</td>
			<td class = btext>
				Prepared On
			</td>
		 	 <tr>
		 	 <td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.ADMIN_NO,'---'),Administrative NO">
			</td>
				<td class = btext>
					Administrative NO
				</td>
		 <tr>	
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(to_char(a.ADMIN_Date,'dd/mm/yyyy'),'--'),Administration Date">
			</td>
			<td class = btext>
				Administration Date
			</td>
			  <tr>
		<td class = btext>
			<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(DECODE(a.STATE_CENTRAL,'C','Centre','S','State'),'--'),Sanctioned At">
		</td>
			<td class = btext>Sanctioned At
		</td> 
		 <tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.SANCTIONED_AMOUNT,'0'),Sanctioned Amount(Rs.in Lakhs)">
			</td>
			<td class = btext>
				Sanctioned Amount
			</td>
		 <tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.ADMN_SANC_AUTH,'--'),Sanction Authority">
			</td>
			<td class = btext>
				Sanction Authority
			</td>
					 <tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "A.PREPARED_BY,Prepared By">
			</td>
			<td class = btext>
				Prepared By
			</td> 

		<!--  <tr>
			<td class = btext>
				<INPUT TYPE="checkbox" NAME="ch" id="ck" value= "nvl(a.GO_NO,'--'),Govt. Order NO">
			</td>
			<td class = btext>
				Govt. Order NO
			</td> -->
		</tr>
	</table>
	</div>
		<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>
					<td width="100%" colspan="2" align="center" class = btext nowrap>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<A HREF="javascript:clearAll('ch','ck')">clearAll Fields</A>
				</td>
			</tr>	
		</table>

</TD>

<TR>
<TD colspan=2 align=center valign=top>
	<% if(rDist!=null && !rDist.equals("0")) {%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
 <%} else{ %>
	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button onclick="valSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
<% } %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}%>