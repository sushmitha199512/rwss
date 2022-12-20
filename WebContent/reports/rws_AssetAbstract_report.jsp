<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
        String loggedUser = user.getUserId();
		
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
		var logValue = '<%=loggedUser%>';
		if(logValue=="admin" || logValue=="100000" || logValue=="guest"|| logValue=="minrwss"|| logValue=="secrwss"|| logValue=="ce_vqc"|| logValue=="ce_stp"|| logValue=="ce_nab"|| logValue=="pdccdu"|| logValue=="pdswsm"|| logValue=="cerwss"|| logValue=="ENC" )
		{
			document.f1.rDistrictName.value = document.f1.rDistrict.options[document.f1.rDistrict.options.selectedIndex].text;
			document.f1.action="./rws_AssetAbstract_report1.jsp"
			document.f1.submit();
						
		}
		else
		{
			//alert(" in user change selected");
			document.f1.rDistrictName.value = document.f1.rDistrictName.value;
			document.f1.action="./rws_AssetAbstract_report1.jsp"
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
		<td align="center" class="rptHeading" colspan=3>Asset Abstract Report</td>	
	</tr>
	
<%

		String rDistrict,yrcreation= null;
		rDistrict = request.getParameter("rDistrict");
		//yrcreation= request.getParameter("yrcreation");
		//rConstituency = request.getParameter("constituency");

try
{
%>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")||loggedUser.equals("guest")||loggedUser.equals("minrwss")||loggedUser.toString().equals("secrwss")||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			rs = stmt.executeQuery(query);
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
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
	%>
				<input type="text" name="rDistricts" value="<%=rs.getString(2)%>">
				<input type="hidden" name="rDistrict" value="<%=rs.getString(1)%>">
				<input type="hidden" name="rDistrictName" value="<%=rs.getString(2)%>">
	<%
			}
		}
	%>
	<tr><td class=rptLabel>Year &nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
			<SELECT name="yrcreation" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct to_char(date_creation,'YYYY')from rws_asset_mast_tbl where date_creation is not null order by 1 desc";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
			%>
					<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
	         <%
			}
						rs.close();			
						stmt.close();
		
		%>	
	
		<%
		
}
catch(Exception e)
{
	////System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
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
<INPUT type="hidden" name="drill">
<INPUT type="hidden" name="rDistrictName">
</form>
</body>
</html>
