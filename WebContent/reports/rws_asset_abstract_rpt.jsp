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
		if(document.f1.rDistrict.value=="00")
		{
			document.f1.drill.value='null';
			var covStatusQry = "";
			var j = 0;
			for(i=0;i<document.f1.covStatus.length;i++)
			{
				if(document.f1.covStatus[i].selected)
				{
					j++;
				}
			}
			if(j>0)
			{
				covStatusQry = " and(";
			}
			var k = 0;
			for(i=0;i<document.f1.covStatus.length;i++)
			{
				if(document.f1.covStatus[i].selected)
				{
					k++;
					if(k==j)
						covStatusQry += " coverage_status='"+document.f1.covStatus[i].value+"'";
					else
						covStatusQry += " coverage_status='"+document.f1.covStatus[i].value+"' OR";
				}
			}
			if(j>0)
			{
				covStatusQry += ")";
			}
			document.forms[0].covStatusQry.value = covStatusQry;
			document.f1.action="./rws_asset_abstract_rpt1.jsp"
			document.f1.submit();
		}
		else
		{  
		    //alert("in this else loop"); 
		    //alert("rdistrict"+document.f1.rDistrict.options[document.f1.rDistrict.selectedIndex].text);
		   	document.f1.drill.value='next';
			var covStatusQry = "";
			var j = 0;
			for(i=0;i<document.f1.covStatus.length;i++)
			{
				if(document.f1.covStatus[i].selected)
				{
					j++;
				}
			}
			if(j>0)
			{
				covStatusQry = " and(";
			}
			var k = 0;
			for(i=0;i<document.f1.covStatus.length;i++)
			{
				if(document.f1.covStatus[i].selected)
				{
					k++;
					if(k==j)
						covStatusQry += " coverage_status='"+document.f1.covStatus[i].value+"'";
					else
						covStatusQry += " coverage_status='"+document.f1.covStatus[i].value+"' OR";
				}
			}
			if(j>0)
			{
				covStatusQry += ")";
			}
			document.forms[0].covStatusQry.value = covStatusQry;
			document.f1.action="./rws_asset_abstract_rpt1.jsp"
			document.f1.submit();
		}
	}
	

</script>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
        String loggedUser = user.getUserId();
		
%>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">
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
		<td align="center" class="rptHeading" colspan=3>Assets-Abstract Report</td>	
	</tr>
	
<%

		String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		rDistrict = request.getParameter("rDistrict");
		rConstituency = request.getParameter("constituency");

try
{
%>
	<td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  order by d.dname";
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
		<TR>
		<td class=rptLabel>Coverage Status</td>
		<td class=btext>
			<SELECT name="covStatus" id="combo" class="mediumlongcombo" style="width:150px" multiple="true" SIZE="7">
			<option value="PC1">PC1</option>
			<option value="PC2">PC2</option>
			<option value="PC3">PC3</option>
			<option value="PC4">PC4</option>
			<option value="FC">FC</option>
			<option value="NC">NC</option>
			<option value="NSS">NSS</option>
			</SELECT>
			</TR>
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
<INPUT type="hidden" name="covStatusQry">
</form>
</body>
</html>
