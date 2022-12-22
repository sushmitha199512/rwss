<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
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
		document.f1.action="./rws_prajapatham_rpt.jsp"
		document.f1.submit();	
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
<!-- district dropdown -->
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!-- <option value="00">All</option> -->
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
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!-- <option value="00" SELECTED>All</option> -->
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
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!-- <option value="00">ALL</option> -->
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				query="SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  order by d.dname";
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
	
	
<!-- mandal dropdown when constituency is selected-->
<%

try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") )
		{	
			//System.out.println("IN MANDAL STARTING...");
%>
	<tr>
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", rMandal);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") )
			{
				//System.out.println("IN MANDAL ALL...");
%>			
		<td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
				if(rMandal != null && rMandal.equals("00"))
				{
%>
				<!-- <option value="00" SELECTED>ALL</option> -->
<%
				}
				else
					{
%>
				<!-- <option value="00">ALL</option> -->
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT M.MCODE, M.MNAME FROM RWS_MANDAL_TBL M, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE ";
					//System.out.println("query is "+query);
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
	
	
	
<!-- for habitations -->
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1") )
		{	
			//System.out.println("IN VILLAGE STARTING...");
%>
	<tr>
		<td class=rptLabel>Habitation&nbsp;&nbsp;<font color="red">*</font></td>
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
		<td class=rptLabel>Habitation&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>				
	
<%
				if(rHabitation != null && rHabitation.equals("00"))
				{
%>
				<!-- <option value="00" SELECTED>ALL</option> -->
<%
				}
				else
					{
%>
				<!-- <option value="00">ALL</option> -->
<%
					}
					stmt = conn.createStatement();
					query = "SELECT DISTINCT P.PANCH_CODE, P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P WHERE SUBSTR(P.PANCH_CODE,1,2)  = '"+rDistrict+"'  AND SUBSTR(P.PANCH_CODE,6,2)  ='"+rMandal+"'";
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

if(conn!=null)
conn.close();
}
%>
			</select>
		</td>
	</tr>


<!-- end of habitations -->


<%	
	if(rDistrict != null && rMandal!=null && !rHabitation.equals("-1")){	//System.out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	}
%>
</table>
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
