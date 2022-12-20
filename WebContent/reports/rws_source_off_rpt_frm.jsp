<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("****************************");	
	String query, query1, query2, query3, query4 = null;
	ResultSet rs1, rs2, rs3, rs4 = null;
	Statement stmt1, stmt2, stmt3, stmt4 = null;	
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="rwsstyle.css">

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>

<title>WaterSoft</title>



</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_source_off_rpt_frm.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="mystyle" colspan="4"><font color="navy">Source Test Details</font></td>	
	</tr>
<%
		String rDist, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDist = request.getParameter("district");
		rMandal = request.getParameter("mandal");
		rPanchayat = request.getParameter("panchayat");
		rVillage = request.getParameter("village");
		rHabitation = request.getParameter("habitation");
		//System.out.println("rDistrict = " +rDist);		
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);		
		//System.out.println("rVillage =" +rVillage);		
		//System.out.println("rHabitation =" +rHabitation);




	try
	{
		if(rDist == null || rDist.equals("-1"))
		{
			//System.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=btext colspan=3 align=left><font color=navy><b>District</b></font></td>
		<td class=btext colspan=3 align=center>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDist);
		}
		
	
	else
			if(rDist != null || rDist.equals("00"))
			{
				//System.out.println("IN DISTRICT ALL...");
%>
				<td class=btext align=left colspan=3><font color=navy><b>District</b></font></td>
				<td class=btext align=center colspan=3>
					<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
						<option value="-1">SELECT...</option>
						<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDist);

		
			} 
			else 
				if(!rDist.equals("-1"))  
				{
%>
					<td class = btext colspan=3><font color=navy><b>District</b> </font></td>
					<td class = btext colspan=3>
					<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
						<option value="-1">SELECT...</option>
						<option value="00">ALL</option>
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
		<td class=btext align=left colspan=3><font color=navy><b>Mandal</b></font></td>
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
			<td class=btext align=left colspan=3><font color=navy><b>Mandal</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
			}
			else
				if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
				{
					//System.out.println("IN MANDAL ALL...");
%>			
			<td class=btext align=left colspan=3><font color=navy><b>Mandal</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>				
	
<%
					if(rMandal != null && rMandal.equals("00"))
					{
%>
					<option value="00" SELECTED>ALL</option>
<%
					}
					else
					{
%>
					<option value="00">ALL</option>
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
				else
					if(rDist.equals("00"))
					{
%>
				<td class=btext align=left colspan=3><font color=navy><b>Mandal</b></font></td>
				<td class=btext align=center colspan=3>
					<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
						<option value="-1">SELECT...</option>		
<%
					}
				
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
		
		if(rMandal == null || rDist.equals("00") || rMandal.equals("00") || rMandal.equals("-1"))
		{
			//System.out.println("PANCHAYAT DISABLED...");
%>
			<td class=btext align=left colspan=3><font color=navy><b>Panchayat</b></font></td>
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
			<td class = btext nowrap colspan=3><font color="navy"><b>Panchayat</b></font></td>
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
			<td class=btext align=left colspan=3><font color=navy><b>Panchayat</b></font></td>
			<td class=btext align=center colspan=3>

				<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				if(rPanchayat != null && rPanchayat.equals("00"))
				{					
%>
					<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("panchayatName", null);
					session.setAttribute("panchayatCode", rPanchayat);		
				}
				else
				{					
%>
					<option value="00">ALL</option>
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
			
%>
			

<%		
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
		
		if(rMandal == null || rDist.equals("00") || rMandal.equals("00") || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("00") || rPanchayat.equals("-1"))
		{
			//System.out.println("VILLAGE DISABLED...");
%>
			<td class=btext align=left colspan=3><font color=navy><b>Village</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="-1">SELECT...</option>
<%
		}
	else
		if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1"))
		{
			//System.out.println("IN VILLAGE STARTING...");
%>
			<td class = btext nowrap colspan=3><font color="navy"><b>Village</b></font></td>
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
			<td class=btext align=left colspan=3><font color=navy><b>Village</b></font></td>
			<td class=btext align=center colspan=3>

				<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				if(rVillage != null && rVillage.equals("00"))
				{					
%>
					<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("villageName", null);
					session.setAttribute("villageCode", rVillage);		
				}
				else
				{					
%>
					<option value="00">ALL</option>
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
		
		if(rMandal == null || rDist.equals("00") || rMandal.equals("00") || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("00") || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("00") || rVillage.equals("-1"))
		{
			//System.out.println("HABITATION DISABLED...");
%>
			<td class=btext align=left colspan=3><font color=navy><b>Habitation</b></font></td>
			<td class=btext align=center colspan=3>
				<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="-1">SELECT...</option>
<%
		}
	else
		if(rDist == null || rDist.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rVillage == null || rVillage.equals("-1"))
		{
			//System.out.println("IN HABITATION STARTING...");
%>
			<td class = btext nowrap colspan=3><font color="navy"><b>Habitation</b></font></td>
			<td class = btext colspan=3>
				<SELECT name="habitation" style="width:150px" class="mycombo" onchange="this.form.submit()" >
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
			<td class=btext align=left colspan=3><font color=navy><b>Habitation</b></font></td>
			<td class=btext align=center colspan=3>

				<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="-1">SELECT...</option>
<%
				if(rHabitation != null && rHabitation.equals("00"))
				{					
%>
					<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("habitationName", null);
					session.setAttribute("habitationCode", rHabitation);		
				}
				else
				{					
%>
					<option value="00">ALL</option>
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
			
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN HABITATION... " +e);
	}
%>
				</select>
			</td>
		</tr>

</table>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>