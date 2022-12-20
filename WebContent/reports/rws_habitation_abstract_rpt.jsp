<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	////System.out.println("***********************FROM BEGINING***********************");
	
StringBuffer query=new StringBuffer();
//String query = null;
	nic.watersoft.commons.RwsUser user=null;
		user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		
		StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());

          java.util.Date date =new  java.util.Date();
			  int year=date.getYear()+1900;
              String currentYear= String.valueOf(year); 
             int finYear_Start=2006;
                   
               
		
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
		if(document.f1.finyear.value==0 ){
			alert("please select financial year");
			return;
		}else{
		var logValue = '<%=loggedUser%>';
		if(logValue=="admin" || logValue=="100000"|| logValue=="guest" || logValue=="minrwss" || logValue=="secrwss"|| logValue=="ce_vqc"|| logValue=="ce_stp"|| logValue=="ce_nab"|| logValue=="pdccdu"|| logValue=="pdswsm"|| logValue=="cerwss"|| logValue=="ENC")
		{
			if(document.f1.rDistrict.value=='00')
				document.f1.drill.value='null';
			else
				document.f1.drill.value='null';
			
			document.f1.rDistrictName.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
			document.f1.action="./rws_habitation_abstract_rpt1.jsp"
			document.f1.submit();
		}
		else
		{
			document.f1.drill.value='next';
			document.f1.rDistrictName.value = document.f1.rDistrictName.value;
			document.f1.action="./rws_habitation_abstract_rpt1.jsp"
			document.f1.submit();
		}
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
		<td align="center" class="rptHeading" colspan=3>Habitation-Status-Abstract-Report</td>	
	</tr>
	
<%
StringBuffer rDistrict=new StringBuffer();
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
		if(loggedUser.toString()!=null && (loggedUser.toString().equals("admin")||loggedUser.toString().equals("100000")||loggedUser.toString().equals("guest") ||loggedUser.toString().equals("secrwss")||loggedUser.toString().equals("minrwss")||loggedUser.toString().equals("ENC")||loggedUser.toString().equals("cerwss")||loggedUser.toString().equals("pdswsm")||loggedUser.toString().equals("pdccdu")||loggedUser.toString().equals("ce_nab")||loggedUser.toString().equals("ce_stp")||loggedUser.toString().equals("ce_vqc")))
		{
		%>
			<SELECT name="rDistrict" id="combo" class="mycombo" style="width:150px">
			<option value="00">ALL</option>
<%
			stmt = conn.createStatement();

           query.delete(0, query.length());
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
			
			query.delete(0, query.length());
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'");
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

%>

<!--  Added by Sai Prasad N -->

<tr><td class=rptLabel>Financial Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="finyear" id="combo1" class="mycombo" style="width:150px">
		<option value="0">Select</option>

<%
int fy=0;
            while(year>=finYear_Start)
{
     fy=year+1;
%>
			<option value="<%=year+"-"+fy%>"><%=year+"-"+fy%></option> 
	<%
year--;
	
}	

		
}
catch(Exception e)
{
	e.printStackTrace();
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
