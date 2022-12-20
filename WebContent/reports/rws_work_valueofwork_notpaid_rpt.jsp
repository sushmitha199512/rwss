<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//////// ////System.out.println("***********************FROM BEGINING***********************");
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
		if(document.f1.district.value=='00')
				document.f1.drill.value='null';
			else
				document.f1.drill.value='1';
			document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
			document.f1.action="./rws_work_valueofwork_notpaid_rpt1.jsp";
			document.f1.submit();
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
		<td align="center" class="rptHeading" colspan=3>Value Of Work Done But Not Paid Report</td>	
	</tr>
	
<%

		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");

try
{
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px">
				<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where dcode <>16 order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{

	%>
					 <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
	<%
			}
						rs.close();
						stmt.close();
%>
		</SELECT>
		</td></tr>
	   <%
}
catch(Exception e)
{
	//////// ////System.out.println("THE ERROR IN DISTRICT... " +e);
	e.printStackTrace();
}
%>
			
	
	</tr>
<tr><td class=rptLabel colspan="2" align="center">
<input type="radio" value="1" name="planNonplan" checked>Plan&nbsp;&nbsp;
<input type="radio" value ="2" name="planNonplan">Non Plan&nbsp;&nbsp;
<input type="radio" value= "3" name="planNonplan">Both
</td>
</tr>



<!-- end of habitations -->


<%	
	//if(district != null ){	//////// ////System.out.println("View Report Enabled...");
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
<INPUT type="hidden" name="distname">
<input type="hidden" name="catCode" value="1">
</form>
</body>
</html>
