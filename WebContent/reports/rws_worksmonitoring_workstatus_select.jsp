<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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
		
		document.f1.action="./rws_worksmonitoring_workstatus_drill1.jsp"
		document.f1.submit();
		
	}
	

</script>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
%>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">
<form name=f1  action="<%= request.getRequestURI()%>">
<input type="hidden" value="1" name="drill">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>DistrictWise-Works Report</font></td>	
	</tr>
	
<%

		String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("rDistrict");
		rConstituency = request.getParameter("constituency");

try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		////System.out.println("IN DISTRICT STARTING...");

%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<select name="rDistrict" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				
				<option value="00" SELECTED>All</option>
<%
				
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			////System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<select name="rDistrict" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				
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
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				
				<option value="00">ALL</option>
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
	////System.out.println("THE ERROR IN DISTRICT... " +e);
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
			////System.out.println("IN CONSTITUENCY STARTING...");
%>
	<tr>
		<td class=rptLabel>Division&nbsp;&nbsp;<font color="red"></font></td>
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
				////System.out.println("IN CONSTITUENCY ALL...");
%>			
		<td class=rptLabel>Division&nbsp;&nbsp;<font color="red"></font></td>
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
					
					/*query="SELECT DISTINCT c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME from  rws_CONSTITUENCY_TBL c,rws_habitation_directory_tbl HD,rws_district_tbl d where substr(HD.hab_code,3,3)=c.CONSTITUENCY_CODE and d.dcode=substr(HD.hab_code,1,2) and c.dcode=d.dcode and substr(HD.hab_code,1,2)='"+rDistrict+"' order BY c.CONSTITUENCY_CODE,c.CONSTITUENCY_NAME";*/

                     query="SELECT DISTINCT c.division_office_code,c.division_office_name from  rws_division_office_tbl c where c.circle_office_code='"+rDistrict+"' order BY c.division_office_code,c.division_office_name";


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
	////System.out.println("The ERROR IN CONSTITUENCY..." + e);
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
	//if(rDistrict != null ){	////System.out.println("View Report Enabled...");
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
