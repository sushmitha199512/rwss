<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("****************************");	
	Statement stmt1, stmt2, stmt3, stmt4, stmt5, stmt6, stmt7 = null;
	ResultSet rs1, rs2, rs3, rs4, rs5, rs6, rs7 = null;
	String query, query1, query2, query3, query4, query5, query6, query7  = null;
%>
<html>
<head>
<script language="JavaScript">
<!--
	function fnSubmit()
	{
		document.f1.action="./rws_source_loc_rpt.jsp";
		document.f1.submit();		
	}
//-->
</script>

<title>WaterSoft</title>
</head>

<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" width = "50" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="8">Source Test Details</font></td>	
	</tr>
<%
		String rDist, rMandal, rPanchayat, rVillage, rHabitation, rSource, fromDate, toDate = null;
		rDist = request.getParameter("district");
		rMandal = request.getParameter("mandal");
		rPanchayat = request.getParameter("panchayat");
		rVillage = request.getParameter("village");
		rHabitation = request.getParameter("habitation");
		rSource = request.getParameter("source");
		fromDate = request.getParameter("fromDate");
		toDate = request.getParameter("toDate");
		//System.out.println("rDistrict = " +rDist);		
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);	
		//System.out.println("rVillage =" +rVillage);		
		//System.out.println("rHabitation =" +rHabitation);		
		//System.out.println("rSource =" +rSource);		
		//System.out.println("fromDate =" +fromDate);		
		//System.out.println("toDate =" +toDate);
	try
	{
		if(rDist == null || rDist.equals("-1"))
		{
			//System.out.println("IN DISTRICT STARTING...");
%>
	<tr>
		<td class=rptLabel>District</td>
		<td class=btext colspan=3 align=center>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDist);
		}	
		else
			if(rDist != null)
			{
				//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District</td>
		<td class=btext align=center colspan=3>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>						
<% 
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDist);	
			} 
			else 
				if(!rDist.equals("-1"))  
				{
%>
		<td class=rptLabel>District</td>
		<td class=btext colspan=3>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>						
<%
				session.setAttribute("districtCode", rDist);
				}
				stmt = conn.createStatement();
				query = "SELECT UNIQUE D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_SOURCE_TBL SOR WHERE SUBSTR(SOR.HAB_CODE,1,2) = D.DCODE ORDER BY D.DCODE";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
				session.setAttribute("districtCode", rDist);
				session.setAttribute("districtName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN DISTRICT... " +e);
	}
%>
			</select>
		</td>
	</tr>
<%
	try
	{
		if(rDist == null)
		{
			//System.out.println("MANDAL DISABLED...");
%>
		<td class=rptLabel>Mandal</td>
		<td class=btext align=center colspan=3>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist == null || rDist.equals("-1"))
			{	
				//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext align=center colspan=3>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
			}
			else
				if(rDist != null && !rDist.equals("-1"))
				{
					//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext align=center colspan=3>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%				
				}
				stmt1 = conn.createStatement();
				query1 = "SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_SOURCE_TBL SOR WHERE M.MCODE = SUBSTR(SOR.HAB_CODE,6,2) AND M.DCODE = SUBSTR(SOR.HAB_CODE,1,2) AND M.DCODE = '"+rDist+"' ORDER BY M.MCODE ";

				rs1 = stmt1.executeQuery(query1);
					while(rs1.next())
					{
						if(rMandal != null && rMandal.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
				session.setAttribute("mandalName",rs1.getString(2));
				session.setAttribute("mandalCode",rMandal);
						}
						else
							{
%>
				<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
							}
					}
				session.setAttribute("mandalCode",rMandal);
					rs1.close();
					stmt1.close();				
	}
	catch(Exception e)
	{
		//System.out.println("The ERROR IN MANDAL..." + e);
	}

%>
			</select>
		</td>
	</tr>
		
	<tr>
		
<%
	try
	{
		if(rMandal == null || rMandal.equals("-1"))
		{
			//System.out.println("PANCHAYAT DISABLED...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext align=center colspan=3>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1"))
			{
				//System.out.println("IN PANCHAYAT STARTING...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class = btext colspan=3>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("panchayatName",null);
				session.setAttribute("panchayatCode",null);
			}
			else
				if(rDist != null || !rDist.equals("-1") || rMandal != null)
				{
					//System.out.println("IN PANCHAYAT ALL...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext align=center colspan=3>

			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				}
				stmt2 = conn.createStatement();
				query2 = "SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL, RWS_SOURCE_TBL  WHERE PCODE = SUBSTR(HAB_CODE,13,2) AND DCODE='"+rDist+"' AND DCODE = SUBSTR(HAB_CODE,1,2) AND MCODE ='"+rMandal+"' AND MCODE=SUBSTR(HAB_CODE,6,2) ";
				rs2 = stmt2.executeQuery(query2);		
					while(rs2.next())
					{					
						if(rPanchayat != null && rPanchayat.equals(rs2.getString(1)))
						{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
				session.setAttribute("panchayatName", rs2.getString(2));
				session.setAttribute("panchayatCode", rs2.getString(1));
						}
						else
							{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
				session.setAttribute("panchayatCode",rPanchayat);
							}
					}
				rs2.close();
				stmt2.close();
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN PANCHAYAT... " +e);
	}
%>
			</select>
		</td>
	</tr>

	<tr>
<%
	try
	{
		
		if(rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1"))
		{
			//System.out.println("VILLAGE DISABLED...");
%>
		<td class=rptLabel>Village</td>
		<td class=btext align=center colspan=4>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1"))
			{
				//System.out.println("IN VILLAGE STARTING...");
%>
		<td class = rptLabel>Village</td>
		<td class = btext colspan=3>
			<SELECT name="village" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("villageName",null);
				session.setAttribute("villageCode",null);
			}
			else
				if(rDist != null || !rDist.equals("-1") || rMandal != null || rPanchayat != null)
				{
					//System.out.println("IN VILLAGE ALL...");
%>
		<td class=rptLabel>Village</td>
		<td class=btext align=center colspan=3>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				}
				stmt3 = conn.createStatement();
				query3 = "SELECT DISTINCT VCODE,VNAME FROM RWS_VILLAGE_TBL, RWS_SOURCE_TBL  WHERE VCODE = SUBSTR(HAB_CODE,8,3) AND DCODE='"+rDist+"' AND DCODE = SUBSTR(HAB_CODE,1,2) AND MCODE ='"+rMandal+"' AND MCODE=SUBSTR(HAB_CODE,6,2) AND PCODE='"+rPanchayat+"' AND PCODE=SUBSTR(HAB_CODE,13,2) ";
				rs3 = stmt3.executeQuery(query3);		
					while(rs3.next())
					{					
						if(rVillage != null && rVillage.equals(rs3.getString(1)))
						{
%>
				<option value ="<%=rs3.getString(1)%>" SELECTED><%=rs3.getString(2)%></option>
<%
				session.setAttribute("villageName", rs3.getString(2));
				session.setAttribute("villageCode", rs3.getString(1));
						}
						else
							{
%>
				<option value = <%=rs3.getString(1)%> ><%=rs3.getString(2)%></option>
<%
				session.setAttribute("villageCode",rVillage);
							}
					}
				rs3.close();			
				stmt3.close();		
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN VILLAGE... " +e);
	}
%>
			</select>
		</td>
	</tr>

		<tr>
<%
	try
	{
		
		if(rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1"))
		{
			//System.out.println("HABITATION DISABLED...");
%>
		<td class=rptLabel>Habitation</td>
		<td class=btext align=center colspan=3>
			<SELECT name="habitation" style="width:300px" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1"))
			{
				//System.out.println("IN HABITATION STARTING...");
%>
		<td class = rptLabel>Habitation</td>
		<td class = btext colspan=3>
			<SELECT name="habitation" style="width:300px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("habitationName",null);
				session.setAttribute("habitationCode",null);
			}
			else
				if(rDist != null || !rDist.equals("-1") || rMandal != null || rPanchayat != null || rVillage != null )
				{
					//System.out.println("IN HABITATION ALL...");
%>
		<td class=rptLabel>Habitation</td>
		<td class=btext align=center colspan=3>
			<SELECT name="habitation" style="width:300px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				}
				stmt4 = conn.createStatement();
				query4 = "SELECT DISTINCT PANCH_CODE, PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL PR,RWS_SOURCE_TBL RS WHERE RS.HAB_CODE=PR.PANCH_CODE AND SUBSTR(PANCH_CODE,1,2)='"+rDist+"' AND SUBSTR(PANCH_CODE,6,2)='"+rMandal+"' AND SUBSTR(PANCH_CODE,8,3)='"+rVillage+"' AND SUBSTR(PANCH_CODE,13,2)='"+rPanchayat+"' ";
				//System.out.println("query = " + query4);
				rs4 = stmt4.executeQuery(query4);		
					while(rs4.next())
					{					
						if(rHabitation != null && rHabitation.equals(rs4.getString(1)))
						{
%>
				<option value ="<%=rs4.getString(1)%>" SELECTED><%=rs4.getString(2)%>-<%=rs4.getString(1)%></option>
<%
				session.setAttribute("habitationName", rs4.getString(2));
				session.setAttribute("habitationCode", rs4.getString(1));
						}
						else
							{
%>
				<option value = <%=rs4.getString(1)%> ><%=rs4.getString(2)%>-<%=rs4.getString(1)%></option>
<%
				session.setAttribute("habitationCode",rHabitation);
							}
					}
				rs4.close();			
				stmt4.close();	
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN HABITATION... " +e);
	}
%>
			</select>
		</td>
	</tr>
	
	<tr>
<%
	try
	{
		
		if(rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1"))
		{
			//System.out.println("SOURCE DISABLED...");
%>
		<td class=rptLabel>Source</td>
		<td class=btext align=center colspan=3>
			<SELECT name="source" style="width:300px" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1"))
			{
				//System.out.println("IN SOURCE STARTING...");
%>
		<td class = rptLabel>Source</td>
		<td class = btext colspan=3>
			<SELECT name="source" style="width:300px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("sourceName",null);
				session.setAttribute("sourceCode",null);
			}
			else
				if(rDist != null || !rDist.equals("-1") || rMandal != null || rPanchayat != null || rVillage != null || rHabitation != null)
				{
					//System.out.println("IN SOURCE ALL...");
%>
		<td class=rptLabel>Source</td>
		<td class=btext align=center colspan=3>
			<SELECT name="source" style="width:300px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				}
				stmt5 = conn.createStatement();
				query5 = "SELECT DISTINCT SOURCE_CODE, SOURCE_NAME FROM RWS_SOURCE_TBL SOR WHERE SOR.HAB_CODE='"+rHabitation+"' AND SUBSTR(SOR.HAB_CODE,1,2)='"+rDist+"' AND SUBSTR(SOR.HAB_CODE,6,2)='"+rMandal+"' AND SUBSTR(SOR.HAB_CODE,8,3)='"+rVillage+"' AND SUBSTR(SOR.HAB_CODE,13,2)='"+rPanchayat+"' ";
				//System.out.println("query = " + query5);
				rs5 = stmt5.executeQuery(query5);		
					while(rs5.next())
					{					
						if(rSource != null && rSource.equals(rs5.getString(1)))
						{
%>
				<option value ="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(2)%>-<%=rs5.getString(1)%></option>
<%
				session.setAttribute("sourceName", rs5.getString(2));
				session.setAttribute("sourceCode", rs5.getString(1));
						}
						else
							{
%>
				<option value = <%=rs5.getString(1)%> ><%=rs5.getString(2)%>-<%=rs5.getString(1)%></option>
<%
				session.setAttribute("sourceCode",rSource);
							}
					}
				rs5.close();			
				stmt5.close();	
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN SOURCE... " +e);
	}
%>
			</select>
		</td>
	</tr>

	<tr bgcolor="#8A9FCD" align= center>
		<td class=btext colspan = 4><font color=navy><b>Select Dates</b></font></td>		
	</tr>
<%
	if(rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1") || rSource == null || rSource.equals("-1"))
	{
		//System.out.println("FROM DISABLED...");
%>
	<tr>
		<td class=rptLabel>From</td>
		<td class=btext>
			<SELECT name="fromDate" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
	}
	else
		if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1") || rSource == null || rSource.equals("-1"))
		{
			//System.out.println("FROM ALL...");
%>
		<td class=btext>From</td>
		<td class=btext>
			<SELECT name="fromDate" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist != null || !rDist.equals("-1") || rMandal != null || rPanchayat != null || rVillage != null || rHabitation != null || rSource != null)
			{
				//System.out.println("FROM SELECTION...");
%>
		<td class=rptLabel>From</td>
		<td class=btext>
			<SELECT name="fromDate" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
			}
			stmt6 = conn.createStatement();		
			query6 = "select UNIQUE to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') as samp_date from RWS_WATER_SAMPLE_COLLECT_TBL ";
			rs6 =stmt6.executeQuery(query6);
		
				while(rs6.next())
				{			
					if(fromDate != null && fromDate.equals(rs6.getString(1)))
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
				}
				rs6.close();			
				stmt6.close();
%>
			</select>
		</td>
<%
	if(rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1") || rSource == null || rSource.equals("-1") || fromDate == null || fromDate.equals("-1"))
	{
		//System.out.println("TO DISABLED...");

%>
		<td class=rptLabel>To</td>
		<td class=btext>
			<SELECT name="toDate" class="mycombo" onChange="this.form.submit()" DISABLED>
				<option value="-1">SELECT...</option>
<%
	}
	else
		if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1") || rHabitation == null || rHabitation.equals("-1") || rSource == null || rSource.equals("-1") || fromDate == null || fromDate.equals("-1"))
		{
			//System.out.println("TO ALL...");
%>
		<td class=rptLabel>To</td>
		<td class=btext>
			<SELECT name="toDate" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
		}
		else
			if(rDist != null || !rDist.equals("-1") || rMandal != null || rPanchayat != null || rVillage != null || rHabitation != null || rSource != null || fromDate != null)
			{
				//System.out.println("TO SELECTION...");
%>
		<td class=rptLabel>To</td>
		<td class=btext>
			<SELECT name="toDate" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
			}
		if(fromDate != null && !fromDate.equals("-1"))
		{	
		//System.out.println("HERE");
			try
			{
				//System.out.println("NOT HERE");
				stmt7 = conn.createStatement();		
				query7="select UNIQUE to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') from RWS_WATER_SAMPLE_COLLECT_TBL where SAMP_COLLECT_DATE >= to_date('"+fromDate+"', 'dd/MM/yyyy')";	
		
				rs7 = stmt7.executeQuery(query7);
					while(rs7.next())
					{		
						if(toDate != null && toDate.equals(rs7.getString(1)))
						{
%>
				<option value="<%=rs7.getString(1)%>" SELECTED><%=rs7.getString(1)%></option>
<%
						}
						else
							{
%>
				<option value="<%=rs7.getString(1)%>"><%=rs7.getString(1)%></option>
<%		

							}
					}
					rs7.close();			
					stmt7.close();
			}	
			catch(Exception e)
			{
				//System.out.println("THE ERROR IN TO... " +e);
			}	
		}
%>
			</select>
		</td>
	</tr>
<%
	if(rSource != null && !rSource.equals("-1") && fromDate != null && !fromDate.equals("00") && toDate != null && !toDate.equals("00"))
	{
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=8 align=center>
			<input type=button onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	}
%>

</table>
<%	
	conn.close();	
%>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>