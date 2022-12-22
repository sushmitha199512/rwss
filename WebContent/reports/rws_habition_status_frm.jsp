<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****FROM BEGINING*****");
	String query, query1, query2, query3, query4 = null;
	ResultSet rs1, rs2, rs3, rs4 = null;
	Statement stmt1, stmt2, stmt3, stmt4 = null;	
%>
<html>
<head>

<script language="JavaScript">

	function fnSubmit()
	{
		if(document.f1.district.selectedIndex == "00")
		{
			alert("SELECT DISTRICT To VIEW REPORT...");
			return false;
		}
		document.f1.action="./rws_planning_format1_rpt.jsp";
		document.f1.submit();		
	}

</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>RWS Planning Format - I</font></td>	
	</tr>
<%
		String rDistrict, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("district");
		rMandal = request.getParameter("mandal");
		rPanchayat = request.getParameter("panchayat");
		rVillage = request.getParameter("village");
		rHabitation = request.getParameter("habitation");
		//System.out.println("rDistrict = " +rDistrict);		
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);		
		//System.out.println("rVillage =" +rVillage);		
		//System.out.println("rHabitation =" +rHabitation);




try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDistrict);

		
		} 
		else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				query = "SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rDistrict != null && rDistrict.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
						session.setAttribute("districtName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("districtCode", rDistrict);
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
	
		if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00"))
		{	
			//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
		}
		else
			if(rDistrict != null && !rDistrict.equals("-1") && !rDistrict.equals("00"))
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext>
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
					query1 = "SELECT distinct m.mcode, m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and d.dcode="+rDistrict + " order by m.mname";

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
		
	
		if(rDistrict == null || rDistrict.equals("-1") || rMandal == null || rMandal.equals("-1") || rMandal.equals("00"))
		{
			//System.out.println("IN PANCHAYAT STARTING...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("panchayatName",null);
				session.setAttribute("panchayatCode",null);
		}
		else
			if(rDistrict != null || !rDistrict.equals("-1") || rMandal != null)
			{
				//System.out.println("IN PANCHAYAT ALL...");
%>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
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
				query2 = "SELECT distinct p.pcode, p.pname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code  and m.mcode="+rMandal+" and d.dcode="+rDistrict+" order by p.pname ";
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
		
	if(rDistrict == null || rDistrict.equals("-1") || rMandal == null || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("-1") || rPanchayat.equals("00"))
		{
			//System.out.println("IN VILLAGE STARTING...");
%>
		<td class=rptLabel>Village</td>
		<td class=btext>
			<SELECT name="village" style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("villageName",null);
				session.setAttribute("villageCode",null);
		}
		else
			if(rDistrict != null || !rDistrict.equals("-1") || rMandal != null || rPanchayat != null)
			{
				//System.out.println("IN VILLAGE ALL...");
%>
		<td class=rptLabel>Village</td>
		<td class=btext>
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
				query3 = "SELECT DISTINCT V.VCODE, V.VNAME FROM RWS_VILLAGE_TBL V, RWS_HABITATION_DIRECTORY_TBL HD WHERE V.VCODE = SUBSTR(HD.HAB_CODE,8,3) AND V.DCODE = '"+rDistrict+"' AND V.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND V.MCODE ='"+rMandal+"' AND V.MCODE = SUBSTR(HD.HAB_CODE,6,2) AND V.PCODE = '"+rPanchayat+"' AND V.PCODE = SUBSTR(HD.HAB_CODE,13,2) ";
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

	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>

</table>
<input type="hidden" name="pass" value=0>
<input type="hidden" name="pageno" value=1>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>