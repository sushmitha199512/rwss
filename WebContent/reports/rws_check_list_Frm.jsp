<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>
<title></title>

<script language="JavaScript">
<!--
	/*
	function assetTypeFunction()
	{
		if(document.f1.schemeCombo.selectedIndex.equals("0"))
		{			
			alert("SELECT Asset Type TO GET SCHEMES...");			
			document.f1.assetType.focus();			
		}		
	}
	*/
//-->
</script>
<%
	String query = null, query1 = null, query2 = null, query3 = null, query4 = null, query5 = null, query6 = null, query7 = null, query8 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rs7 = null, 
	rs8 = null;
	Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null, 
	stmt7 = null, stmt8 = null;
%>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<%
	//System.out.println("*****************Form Begined*****************");
%>
<table width=100%> <!-- Main Table Starts Here -->
	<tr>
		<td>
		<!-- Home Table Starts Here -->
<table  border=0 rules=none style="border-collapse:collapse" bgcolor="#edf2f8" align=right>
	<tr>
		<td align="right" class="bwborder"><a href="./rws_check_list_Frm.jsp">Home</td> 
	</tr>
</table>
		<!-- Home Table Ends Here -->
<br>
		<!-- Main Fieldset Starts Here (Asset Check List) -->
<fieldset>
	<legend class=btext>Asset Check List Form</legend>
		<label>
			<table width=100%>				
				<tr>
					<td>
<%
	String rAssetType = null;
	String assetTypeName = null;
	String rCircle = null;
	String circleName = null;
	String rDivision = null;
	String rSubDivision = null;
	String rMandal = null;
	String rPanchayat = null;
	String rVillage = null;
	String rHabitation = null;
	String rScheme = null;
	rAssetType = request.getParameter("assetType");
	rCircle = request.getParameter("circleOffice");
	rDivision = request.getParameter("divisionOffice");
	rSubDivision = request.getParameter("subDivisionOffice");
	rMandal = request.getParameter("mandalCombo");
	rPanchayat = request.getParameter("panchayatCombo");
	rVillage = request.getParameter("villageCombo");
	rHabitation = request.getParameter("habitationCombo");
	rScheme = request.getParameter("schemeCombo");
	//System.out.println("rAssetType = " + rAssetType);
	//System.out.println("rCircle = " + rCircle);
	//System.out.println("rDivision = " +  rDivision);
	//System.out.println("rSubDivision = " + rSubDivision);
	//System.out.println("rMandal = " + rMandal);
	//System.out.println("rPanchayat = " + rPanchayat);
	//System.out.println("rVillage = " + rVillage);
	//System.out.println("rHabitation = " + rHabitation);
	//System.out.println("rScheme = " + rScheme);
%>
		<!-- Sub Fieldset Starts Here (Office Details) -->
<fieldset>
	<legend class=btext>Office Details</legend>
		<label>
			<table width=100%>
				<tr>		
					<td class=rptLabel>Circle</td>
					<td class=btext>
						<select name="circleOffice" class=mycombo onChange="this.form.submit()" style="width:150px">
							<option value=0>SELECT...</option>
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", rCircle);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT CIRCLE_OFFICE_CODE, CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL ";
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rCircle != null && rCircle.equals(rs.getString(1)))
			{
%>

						<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("circleCode", rCircle);
				session.setAttribute("circleName", rs.getString(2));		
			}
			else 
			{
%>	
						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("circleCode",rCircle);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Circle = " + e);
}
%>
						</select>
					</td>

					<td class=rptLabel>Division</td>
					<td class=btext>
						<select name="divisionOffice" class=mycombo onChange="this.form.submit()" style="width:120px">
							<option value=0>SELECT...</option>
<%
				session.setAttribute("divisionCode", null);
				session.setAttribute("divisionName", rDivision);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT DIVISION_OFFICE_CODE, DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = '" +rCircle+ "' ORDER BY DIVISION_OFFICE_CODE ";		
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rDivision != null && rDivision.equals(rs.getString(1)))
			{
%>

				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("divisionCode", rDivision);
				session.setAttribute("divisionName", rs.getString(2));	
			}
			else 
			{
%>	
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("divisionCode",rDivision);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Division = " + e);
}
%>
						</select>
					</td>
					
					<td class=rptLabel>Sub Division</td>
					<td class=btext>
						<select name="subDivisionOffice" class=mycombo onChange="this.form.submit()" style="width:120px">
							<option value=0>SELECT...</option>
<%
				session.setAttribute("subDivisionCode", null);
				session.setAttribute("subDivisionName", rSubDivision);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT SUBDIVISION_OFFICE_CODE, SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND DIVISION_OFFICE_CODE = " +rDivision+ " ";		
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rSubDivision != null && rSubDivision.equals(rs.getString(1)))
			{
%>

				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("subDivisionCode", rSubDivision);
				session.setAttribute("subDivisionName", rs.getString(2));	
			}
			else 
			{
%>	
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("subDivisionCode",rSubDivision);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in SubDivision = " + e);
}
%>
						</select>
					</td>
				</tr>
			</table>
		</label>
</fieldset>
			<!-- Sub Fieldset Ends Here (Office Details) -->

			<!-- Sub Fieldset Starts Here (Habitation Details) -->
<fieldset>
		<legend class=btext>Habitation Details</legend>
			<label>
				<table>
					<tr>
						<td class=rptLabel>Asset Type&nbsp<font color="red">*</font></td>
						<td class=btext>
							<select name="assetType" class=mycombo onChange="this.form.submit()" style="width:120px">
								<option value=0>SELECT...</option>
<%
				session.setAttribute("assetTypeCode", null);
				session.setAttribute("assetTypeName", rAssetType);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT TYPE_OF_ASSET_CODE, TYPE_OF_ASSET_NAME FROM RWS_ASSET_TYPE_TBL ORDER BY TYPE_OF_ASSET_CODE ";
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rAssetType != null && rAssetType.equals(rs.getString(1)))
			{
%>

				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("assetTypeCode", rAssetType);
				session.setAttribute("assetTypeName", rs.getString(2));		
			}
			else 
			{
%>	
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("assetTypeCode",rAssetType);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in AssetType = " + e);
}
%>
							</select>
						</td>
<%		
	circleName = String.valueOf(session.getAttribute("circleName"));
	if (circleName.equals("null") || circleName.equals("0"))
	{
		//System.out.println("Here");
%>
						
						<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	District</td>
						<td class=btext>&nbsp;&nbsp;&nbsp;
							<input type="text" name="districtName" class=prptLabel style="width:150px" readonly></td>
<%
	}
	else
	{
		//System.out.println("NOT HERE");
%>
						
						<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	District</td>
						<td class=btext>&nbsp;&nbsp;&nbsp;
							<input type="text" name="districtName" class=prptLabel value="<%=circleName%>" style="width:150px" readonly></td>
<%
	}	
%>
						<td class=rptLabel>&nbsp;&nbsp;Mandal</td>
						<td class=btext>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="mandalCombo" class=mycombo onChange="this.form.submit()" style="width:120px">
								<option value=0>SELECT...</option>

<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
try
{	
		stmt = conn.createStatement();
		if(rCircle == null && rDivision == null && rSubDivision == null)
		{
			//System.out.println("FIRST IF...");
			query = " SELECT DISTINCT MCODE, MNAME FROM RWS_MANDAL_TBL M WHERE DCODE = '" +rCircle+ "' ORDER BY MCODE ";
		}
		if(rCircle != null && !rCircle.equals("0") && rDivision.equals("0"))
		{
			//System.out.println("SECOND IF...");
			query = " SELECT DISTINCT MCODE, MNAME FROM RWS_MANDAL_TBL M WHERE DCODE = '" +rCircle+ "' ORDER BY MCODE ";
		}
		if(rDivision != null && !rDivision.equals("0") && rSubDivision.equals("0"))
		{
			//System.out.println("THIRD IF...");
			query = " SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MS WHERE M.DCODE = '" +rCircle+ "' AND M.DCODE = MS.DCODE AND M.MCODE = MS.MCODE AND MS.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND MS.DIVISION_OFFICE_CODE ='" +rDivision+ "' ";
		}
		if(rSubDivision != null && !rSubDivision.equals("0"))
		{
			//System.out.println("FOURTH IF...");
			query = " SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MS WHERE M.DCODE = '" +rCircle+ "' AND M.DCODE = MS.DCODE AND M.MCODE = MS.MCODE AND MS.CIRCLE_OFFICE_CODE = '" +rCircle+ "' AND MS.DIVISION_OFFICE_CODE ='" +rDivision+ "' AND MS.SUBDIVISION_OFFICE_CODE = '" +rSubDivision+ "' ";
		}		
		rs = stmt.executeQuery(query);		
		while (rs.next())
		{
			if(rMandal != null && rMandal.equals(rs.getString(1)))
			{
%>

								<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("mandalCode", rMandal);
				session.setAttribute("mandalName", rs.getString(2));	
			}
			else 
			{
%>	
								<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("mandalCode",rMandal);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Mandal = " + e);
}
%>
							</select>
						</td>					
					</tr>

					<tr>
						<td class=rptLabel>Panchayat</td>
						<td class=btext>
							<select name="panchayatCombo" class=mycombo onChange="this.form.submit()" style="width:150px">
								<option value=0>SELECT...</option>
<%
				session.setAttribute("panchayatCode", null);
				session.setAttribute("panchayatName", rPanchayat);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT PCODE, PNAME FROM RWS_PANCHAYAT_TBL P WHERE DCODE = '" +rCircle+ "' AND MCODE = '" +rMandal+ "' ORDER BY PCODE ";		
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rPanchayat != null && rPanchayat.equals(rs.getString(1)))
			{
%>

				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("panchayatCode", rPanchayat);
				session.setAttribute("panchayatName", rs.getString(2));	
			}
			else 
			{
%>	
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("panchayatCode",rPanchayat);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Panchayat = " + e);
}
%>
							</select>
						</td>

						<td class=rptLabel>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Village</td>
						<td class=btext>&nbsp;&nbsp;&nbsp;
							<select name="villageCombo" class=mycombo onChange="this.form.submit()" style="width:150px">
								<option value=0>SELECT...</option>
<%
				session.setAttribute("villageCode", null);
				session.setAttribute("villageName", rVillage);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT VCODE, VNAME FROM RWS_VILLAGE_TBL V WHERE DCODE = '" +rCircle+ "' AND MCODE = '" +rMandal+ "' AND PCODE = '" +rPanchayat+ "' ORDER BY VCODE ";		
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rVillage != null && rVillage.equals(rs.getString(1)))
			{
%>

							<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
					session.setAttribute("villageCode", rVillage);
					session.setAttribute("villageName", rs.getString(2));	
			}
			else 
			{
%>	
							<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("villageCode",rVillage);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Village = " + e);
}
%>
							</select>
						</td>
					</tr>

					<tr>
						<td class=rptLabel>Habitation</td>
						<td class=btext>
							<select name="habitationCombo" class=mycombo onChange="this.form.submit()" style="width:150px">
								<option value=0>SELECT...</option>
<%
				session.setAttribute("habitationCode", null);
				session.setAttribute("habitationName", rVillage);
try
{		
		stmt = conn.createStatement();
		query = "SELECT DISTINCT PANCH_CODE, PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE SUBSTR(PANCH_CODE,1,2) = '" +rCircle+ "' AND SUBSTR(PANCH_CODE,6,2)  = '" +rMandal+ "' AND SUBSTR(PANCH_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(PANCH_CODE,8,3) = '" +rVillage+ "' ORDER BY PANCH_CODE ";		
		rs = stmt.executeQuery(query);
		
		while (rs.next())
		{
			if(rHabitation != null && rHabitation.equals(rs.getString(1)))
			{
%>

								<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<% 			
				session.setAttribute("habitationCode", rHabitation);
				session.setAttribute("habitationName", rs.getString(2));	
			}
			else 
			{
%>	
								<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%		
				session.setAttribute("habitationCode",rHabitation);		
			} 
		}
		rs.close();
		stmt.close();
}
catch(Exception e)
{
	//System.out.println("The Error is in Habitation = " + e);
}
%>
							
					</tr>										
				</table>							
		</label>
</fieldset>
			<!-- Sub Fieldset Ends Here (Habitation Details) -->
					</td>
				</tr>				
			</table>
			<!-- Main Fieldset Ends Here (Asset Check List) -->

		</td> <!-- Main Table Ends Here -->
	</tr>
</table>

<%@ include file="./rws_chck_list_asset_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcir_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdiv_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivsdiv_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivsdivmand_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivsdivmandpan_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivsdivmandpanvill_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivsdivmandpanvillhabi_rpt.jsp"%>

<%@ include file="./rws_chck_list_assetcirmand_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirmandpan_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirmandpanvill_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirmandpanvillhabi_rpt.jsp"%>

<%@ include file="./rws_chck_list_assetcirdivmand_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivmandpan_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivmandpanvill_rpt.jsp"%>
<%@ include file="./rws_chck_list_assetcirdivmandpanvillhab_rpt.jsp"%>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>