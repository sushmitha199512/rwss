<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
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
		//alert("in fun88888");
	       document.getElementById('vbutton').disabled=true;
	}

}
	function fnSubmit()
	{
	
		var logValue = '<%=loggedUser%>';
		//if(logValue=="admin" || logValue=="100000")
		//{
			if(document.f1.district.value=='00')
			{
			    document.f1.drill.value='null';
			   // alert("Please Select District");
			}
			 if(document.f1.finyear.value=='')
			{
				//alert(document.f1.finyear.value);
				alert("Please Select Financial Year");
				return false;
			}
			
		
			else
		{

				//alert("6");
				document.f1.drill.value='null';
			
			document.f1.distname.value = document.f1.combo.options[document.f1.combo.options.selectedIndex].text;
			//document.f1.pname.value = document.f1.combo2.options[document.f1.combo2.options.selectedIndex].text;
			document.f1.action="./rws_ftk_test_ftkuptomonth_rpt.jsp";
			document.f1.submit();
		}
		//}
		//else
		//{
		//	document.f1.drill.value='1';
			//document.f1.distname.value = document.f1.districts.value;
			//document.f1.action="./rws_work_gen.jsp";
//			document.f1.submit();
	//	}
	}


</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width="20%">
		<caption>
              
			<table  border=0 rules=none style="border-collapse:collapse" width="200" align="right" bgcolor="#edf2f8">
				

			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>

			</table>
		</caption>

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=4>Water Quality FTK Report</td>
	</tr>

<%

		String district, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;
		district = request.getParameter("district");
		rConstituency = request.getParameter("constituency");
		Statement stmt2=null,stmt3=null;

try
{
%>
<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:120px">
				<option value="00">ALL</option>
<%
			stmt = conn.createStatement();
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d order by d.dname";
		 rs = stmt.executeQuery(query);
			while(rs.next())
			{%>
			



			<%}
			rs.close();
			stmt.close();
%>
		</SELECT>
		</td>
<td class=rptLabel></td><td class=rptLabel></td>

<%@ include file="financialYear.jsp" %>
	



		<%

}
catch(Exception e)
{
	System.out.println("THE ERROR IN DISTRICT... " +e);
	e.printStackTrace();
}

%>




<!-- end of habitations -->


<%
	//if(district != null ){	////////System.out..println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4 align=center>
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

</form>
</body>
</html>

