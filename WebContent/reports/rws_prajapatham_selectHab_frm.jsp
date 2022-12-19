<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>

<script language="JavaScript">
function unview()
{
    var a=document.getElementById('combo').value;
	
	if(a=="-1")
	{
       document.getElementById('vbutton').disabled=true;
	}
	 
}
	function fnSubmit()
	{
		
		if(document.forms[0].habitation.value=="-1" || document.forms[0].habitation.value=="00")
		{
		document.f1.action="/pred/reports/rws_prajapatham_drill.jsp"
		document.f1.submit();
		}
		else
		{
			document.f1.action="/pred/reports/rws_prajapatham_rpt.jsp"
			document.f1.submit();
		}
	}
	

</script>
<%
	//System.out.println("***********************FROM BEGINING***********************");
	String query = null;
%>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">
<form name=f1  action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=prajapatham">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Prajapatham Work Wise Report</font></td>	
	</tr>
<%
		String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("district");
		rConstituency = request.getParameter("constituency");
		rMandal = request.getParameter("mandal");
		rPanchayat = request.getParameter("panchayat");
		rVillage = request.getParameter("village");	
		rHabitation=request.getParameter("habitation");	
		
		//System.out.println("rDistrict = " +rDistrict);
		//System.out.println("rConstituency = " +rConstituency);
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);		
		
try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				
				<option value="00" SELECTED>All</option>
<%
				
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				
				<option value="00" SELECTED>All</option>
<% 
				
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDistrict);

		
		} 
		else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				
				<option value="00">ALL</option>
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				query="SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_habitation_directory_tbl h,RWS_PRAJAPADAM_TBL praja where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and SUBSTR(PRAJA.HAB_CODE,1,2)=D.DCODE order by d.dname";
				//System.out.println("query is "+query);
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
	//e.printStackTrace();
}
%>
			</select>
		</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00") || rConstituency == null)
		{	
			//System.out.println("IN CONSTITUENCY STARTING...");
%>
	<tr>
		<td class=rptLabel>Constituency&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="constituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT</option>
<%
				session.setAttribute("constituencyCode", null);
				session.setAttribute("constituencyName", rConstituency);
		}
		else
			if(rDistrict != null || !rDistrict.equals("-1") || !rDistrict.equals("00") || rConstituency != null)
			{
				//System.out.println("IN CONSTITUENCY ALL...");
%>			
		<td class=rptLabel>Constituency&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="constituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
							
	

<%
				if(rConstituency != null && rConstituency.equals("00"))
				{
%>
				<option value="00" SELECTED>ALL</option>	
<%
				}
				else if(rDistrict != null && !rDistrict.equals("-1") && rConstituency.equals("-1"))
				{
%>
					<option value="00" SELECTED>ALL</option>	
<%
				}
				else
					{
%>
				
				<option value="-1">SELECT</option>
<%
					}
					stmt = conn.createStatement();
					
					query="SELECT DISTINCT c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME from  rws_CONSTITUENCY_TBL c,rws_habitation_directory_tbl HD,rws_district_tbl d,RWS_PRAJAPADAM_TBL PRAJA where substr(HD.hab_code,3,3)=c.CONSTITUENCY_CODE and d.dcode=substr(HD.hab_code,1,2) and c.dcode=d.dcode and substr(HD.hab_code,1,2)='"+rDistrict+"' AND SUBSTR(PRAJA.HAB_CODE,1,2)=C.DCODE AND SUBSTR(PRAJA.HAB_CODE,3,3)=C.CONSTITUENCY_CODE order BY c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME";


					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rConstituency != null && rConstituency.equals(rs.getString(1)))
						{
%>
				
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("constituencyName",rs.getString(2));
						session.setAttribute("constituencyCode",rConstituency);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("constituencyCode",rConstituency);
					rs.close();
					stmt.close();
			}			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN CONSTITUENCY..." + e);
	//e.printStackTrace();
}

%>
			</select>
		</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1"))
		{	
			//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1"))
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
						
	
<%
				if(rMandal != null && rMandal.equals("00"))
				{
%>
				<option value="00" SELECTED>ALL</option>
<%
				}
				else if(rConstituency != null && !rConstituency.equals("-1") && rMandal.equals("-1"))
				{
%>
					<option value="00" SELECTED>ALL</option>
						
<%
				}
	
				else
				
					{
%>
				
				<option value="-1">SELECT</option>
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_HABITATION_DIRECTORY_TBL H, RWS_CONSTITUENCY_TBL C,RWS_PRAJAPADAM_TBL PRAJA WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' AND SUBSTR(PRAJA.HAB_CODE,1,2)=M.DCODE AND SUBSTR(PRAJA.HAB_CODE,3,3)=C.CONSTITUENCY_CODE AND SUBSTR(PRAJA.HAB_CODE,6,2)=M.MCODE";

					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rMandal != null && rMandal.equals(rs.getString(1)))
						{
%>
				
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalName",rs.getString(2));
						session.setAttribute("mandalCode",rMandal);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("mandalCode",rMandal);
					rs.close();
					stmt.close();
			}			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN MANDAL..." + e);
	//e.printStackTrace();
}

%>
			</select>
		</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1"))
		{	
			//System.out.println("IN PANCHAYAT STARTING...");
%>
	<tr>
		<td class=rptLabel>Panchayat&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("panchayatCode", null);
				session.setAttribute("panchayatName", rPanchayat);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1") || rMandal != null || !rMandal.equals("00") || !rMandal.equals("-1"))
			{
				//System.out.println("IN PANCHAYAT ALL...");
%>			
		<td class=rptLabel>Panchayat&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
							
	
<%
				if(rPanchayat != null && rPanchayat.equals("00"))
				{
%>
				<option value="00" SELECTED>ALL</option>	
<%
				}
				else if(rMandal != null && !rMandal.equals("-1") && rPanchayat.equals("-1"))
				{
%>
					<option value="00" SELECTED>ALL</option>	
<%
				}
				else
					{
%>
				<option value="-1">SELECT</option>
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT P.PCODE, P.PNAME FROM RWS_PANCHAYAT_TBL P, RWS_HABITATION_DIRECTORY_TBL HD, RWS_CONSTITUENCY_TBL C,RWS_PRAJAPADAM_TBL PRAJA WHERE P.PCODE = SUBSTR(HD.HAB_CODE,13,2) and C.dcode=P.dcode AND P.DCODE = '"+rDistrict+"' AND P.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND P.MCODE = '"+rMandal+"' AND P.MCODE = SUBSTR(HD.HAB_CODE,6,2)  AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and SUBSTR(PRAJA.HAB_CODE,1,2)=P.DCODE AND SUBSTR(PRAJA.HAB_CODE,3,3)=C.CONSTITUENCY_CODE AND SUBSTR(PRAJA.HAB_CODE,6,2)=P.MCODE AND SUBSTR(PRAJA.HAB_CODE,13,2)=P.PCODE";
					//System.out.println("query is "+query);
					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rPanchayat != null && rPanchayat.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("panchayatName",rs.getString(2));
						session.setAttribute("panchayatCode",rPanchayat);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("panchayatCode",rPanchayat);
					rs.close();
					stmt.close();
			}			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN PANCHAYAT..." + e);
	//e.printStackTrace();
}

%>
			</select>
		</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("00") || rPanchayat.equals("-1"))
		{	
			//System.out.println("IN VILLAGE STARTING...");
%>
	<tr>
		<td class=rptLabel>Village&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("villageCode", null);
				session.setAttribute("villageName", rVillage);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1") || rMandal != null || !rMandal.equals("00") || !rMandal.equals("-1") || rPanchayat != null || !rPanchayat.equals("00") || !rPanchayat.equals("-1"))
			{
				//System.out.println("IN VILLAGE ALL...");
%>			
		<td class=rptLabel>Village&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
							
	
<%
				if(rVillage != null && rVillage.equals("00"))
				{
%>
				<option value="00" SELECTED>ALL</option>	
<%
				}
				else if(rPanchayat != null && !rPanchayat.equals("-1") && rVillage.equals("-1"))
				{
%>
					<option value="00" SELECTED>ALL</option>	
<%
				}
				else
					{
%>
				<option value="-1">SELECT</option>
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT V.VCODE, V.VNAME FROM RWS_VILLAGE_TBL V, RWS_HABITATION_DIRECTORY_TBL HD, RWS_CONSTITUENCY_TBL C,RWS_PRAJAPADAM_TBL PRAJA WHERE V.VCODE = SUBSTR(HD.HAB_CODE,8,3) AND V.DCODE = '"+rDistrict+"' AND V.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND V.MCODE ='"+rMandal+"' AND V.MCODE = SUBSTR(HD.HAB_CODE,6,2) AND V.PCODE = '"+rPanchayat+"' AND V.PCODE = SUBSTR(HD.HAB_CODE,13,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.dcode=V.dcode and C.CONSTITUENCY_CODE = '" +rConstituency+ "' AND SUBSTR(PRAJA.HAB_CODE,1,2)=V.DCODE AND SUBSTR(PRAJA.HAB_CODE,3,3)=C.CONSTITUENCY_CODE AND SUBSTR(PRAJA.HAB_CODE,6,2)=V.MCODE AND SUBSTR(PRAJA.HAB_CODE,13,2)=V.PCODE AND SUBSTR(PRAJA.HAB_CODE,8,3)=V.VCODE";

					

					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rVillage != null && rVillage.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("villageName",rs.getString(2));
						session.setAttribute("villageCode",rVillage);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("villageCode",rVillage);
					rs.close();
					stmt.close();
			}
			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN VILLAGE..." + e);
	//e.printStackTrace();
}
finally
{
//if(conn!=null)
//conn.close();
}
%>
			</select>
		</td>
	</tr>

<!-- for habitations -->
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("00") || rPanchayat.equals("-1")|| rVillage == null || rVillage.equals("00") || rVillage.equals("-1"))
		{	
			//System.out.println("IN VILLAGE STARTING...");
%>
	<tr>
		<td class=rptLabel>Habitation&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("habCode", null);
				session.setAttribute("habName", rHabitation);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1") || rMandal != null || !rMandal.equals("00") || !rMandal.equals("-1") || rPanchayat != null || !rPanchayat.equals("00") || !rPanchayat.equals("-1")|| rVillage != null || !rVillage.equals("00"))
			{
				//System.out.println("IN VILLAGE ALL...");
%>			
		<td class=rptLabel>Habitation&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
								
	
<%
				if(rHabitation != null && rHabitation.equals("00"))
				{
%>
				<option value="00" SELECTED>ALL</option>
<%
				}
				else if(rVillage != null && !rVillage.equals("-1") && rHabitation.equals("-1"))
				{
%>
					<option value="00 SELECTED">ALL</option>	
<%
				}
				else
					{
%>
				<option value="-1">SELECT</option>
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT P.PANCH_CODE, P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P,RWS_PRAJAPADAM_TBL PRAJA WHERE SUBSTR(P.PANCH_CODE,1,2)  = '"+rDistrict+"'  AND SUBSTR(P.PANCH_CODE,3,3)='"+rConstituency+"' AND SUBSTR(P.PANCH_CODE,6,2)  ='"+rMandal+"'  AND SUBSTR(P.PANCH_CODE,13,2)  = '"+rPanchayat+"'  AND SUBSTR(P.PANCH_CODE,8,3)  = '"+rVillage+"' AND PRAJA.HAB_CODE=P.PANCH_CODE";
					//System.out.println("habcode query is "+query);
					

					rs = stmt.executeQuery(query);
					while(rs.next())
					{
						if(rHabitation != null && rHabitation.equals(rs.getString(1)))
						{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("habName",rs.getString(2));
						session.setAttribute("habCode",rHabitation);
						}
						else
						{
%>
					<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						}
					}
					session.setAttribute("habCode",rHabitation);
					rs.close();
					stmt.close();
			}
			
				
}
catch(Exception e)
{
	//System.out.println("The ERROR IN VILLAGE..." + e);
	//e.printStackTrace();
}
finally
{

conn.close();
}
%>
			</select>
		</td>
	</tr>


<!-- end of habitations -->


<%	
	//if(rDistrict != null ){	//System.out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
