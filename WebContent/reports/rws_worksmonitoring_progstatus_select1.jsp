<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
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
		
		//document.f1.action="./rws_worksmonitoring_progstatus_drill.jsp"
		document.f1.action="./rws_wrk_prg1.jsp"
		document.f1.submit();
		
	}
	

</script>
<%
	//System.out.println("***********************FROM BEGINING***********************");
	String query = null;
%>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">
<form name=f1  method=post action="<%= request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Programme Work Wise </font></td>	
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
				

%>
			</select>
		</td>
	</tr>
<%
	
		

} 
catch(Exception e)
{
}
finally
{
	conn.close();
}
%>
			</select>
		</td>
	</tr>


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
