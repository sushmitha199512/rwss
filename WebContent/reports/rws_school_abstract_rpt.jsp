<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	////System.out.println("***********************FROM BEGINING***********************");
StringBuffer query = new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());
		
%>
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
		var logValue = '<%=loggedUser.toString()%>';
		if(logValue=="admin" || logValue=="100000" || logValue=="guest")
		{
			if(document.f1.rDistrict.value=='00')
				document.f1.drill.value='null';
			else
				document.f1.drill.value='next';
			document.f1.rDistrictName.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
			document.f1.action="./rws_school_abstract_rpt1.jsp"
			document.f1.submit();
		}
		else
		{
			document.f1.drill.value='next';
			document.f1.rDistrictName.value = document.f1.rDistrictName.value;
			document.f1.action="./rws_school_abstract_rpt1.jsp"
			document.f1.submit();
		}
	}
	

</script>
</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>DistrictWise-Schools-Abstract Report</td>	
	</tr>
	
<%

StringBuffer rDistrict = new StringBuffer();

rDistrict.append(request.getParameter("rDistrict"));

StringBuffer rConstituency=new StringBuffer();
rConstituency.append(request.getParameter("constituency"));


StringBuffer rMandal=new StringBuffer();
rMandal.append(request.getParameter("rMandal"));

StringBuffer rPanchayat=new StringBuffer();
rPanchayat.append(request.getParameter("rPanchayat"));


StringBuffer rVillage=new StringBuffer();
rVillage.append(request.getParameter("rVillage"));

StringBuffer rHabitation=new StringBuffer();
rHabitation.append(request.getParameter("rHabitation"));

		//String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		//rDistrict = request.getParameter("rDistrict");
		//rConstituency = request.getParameter("constituency");
		
	

try
{
%>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals("admin")||loggedUser.toString().equals("100000") ||loggedUser.toString().equals("guest")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%



			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query.append("SELECT distinct d.dcode,d.dname from rws_district_tbl d order by d.dname");
			rs = stmt.executeQuery(query.toString());
			while(rs.next())
			{
								
	%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
	<%
			}
						rs.close();			
						stmt.close();
		}
		else
		{
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.toString().substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
	%>
				<input type="text" name="rDistricts" value="<%=rs.getString(2)%>">
				<input type="hidden" name="rDistrict" value="<%=rs.getString(1)%>">
				<input type="hidden" name="rDistrictName" value="<%=rs.getString(2)%>">
	<%
			}
		}
		
}
catch(Exception e)
{
	//////System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
			
		</td>
	</tr>




<!-- end of habitations -->


<%	
	//if(rDistrict != null ){	//////System.out.println("View Report Enabled...");
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
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="rDistrictName">
</form>
</body>
</html>
