<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	String dddcode="";
	if(loggedUser.substring(0,3).equals("col")){
		dddcode=(String)session.getAttribute("district");    
	   }
	%>
<html>
<head>

<script language="JavaScript">
	
		function fnSubmit1()
	{
		if(document.f1.reptype[0].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
                      
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                //document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					//document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_gps_status_con_rpt.jsp";
				document.f1.submit();
			}	
		}
        if(document.f1.reptype[1].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}

      if(document.f1.reptype[2].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_nfc_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}
     if(document.f1.reptype[3].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_fc_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}
   if(document.f1.reptype[4].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_all_nfc_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}
      if(document.f1.reptype[5].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_all_fc_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}

       if(document.f1.reptype[6].checked)
          {
		    var loggedUser = '<%=loggedUser%>';
			if(document.f1.district1.value=='')
			{
				alert("Please Select District");
				return false;
			}
            if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
            
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname1.value = document.f1.district1.options[document.f1.district1.selectedIndex].text;
					
	                document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				

				
				else
				{
					document.f1.dname1.value = document.f1.district1.value;
					document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				
				}
                //alert("....hai....."+document.f1.dname1.value);
				document.f1.action="./rws_district_wise_all_gps_status_rpt.jsp";
				document.f1.submit();
			}	
		}

}
		
		
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=450>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				
			<% 
if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr>
<%} %>



			</table>
		</caption>
	<%
try
{
	String dcode = request.getParameter("district1");
	String divcode = request.getParameter("division");
	String dcode1 = request.getParameter("district1");
	String divcode1 = request.getParameter("division");
%>
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=450>		

	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Coverage Status </td>	
	</tr>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") ||loggedUser.equals("secrwss") || loggedUser.substring(0,3).equals("col")))
		{
		%>
			<SELECT name="district1" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";
			if(dddcode!=null && !dddcode.equals("")){
				query+=" and dcode='"+dddcode+"'";
			}
			query+=" order by dname";
			rs = stmt.executeQuery(query);
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode1))
				{
				%>
				<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option> 
				<%
				}
				else
				{
				%>
				<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> 
				<%
				}
				}
				rs.close();			
				stmt.close();
				}
		else
		{
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode1=rs.getString(1);
	%>
				<input type="text" name="dname1" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district1" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="mandal" id="combo" class="mycombo" style="width:150px"  >
				<option value="51">-ALL-</option>
<%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct mcode,mname from rws_mandal_tbl   where dcode='"+dcode+"' order by mname";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(divcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
	<%}
			}
						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
    </td></tr>

	
	<tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>1.&nbsp;<input type="radio" name="reptype" id="con" value="con" onclick="fnSubmit1();"/>Consolidate(Fully and Partially GP's Count)</td></tr>
    <tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>2.&nbsp;<input type="radio" name="reptype" id="det" value="det" onclick="fnSubmit1();"/>Detailed(All Mandals & District-Mandal)</td></tr>
	<tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>3.&nbsp;<input type="radio" name="reptype" id="nfc" value="nfc" onclick="fnSubmit1();"/>Mandal Wise Not Fully Covered GP's</td></tr>
    <tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>4.&nbsp;<input type="radio" name="reptype" id="fc" value="fc" onclick="fnSubmit1();"/>Mandal Wise Fully Covered GP's</td></tr>
    <tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>5.&nbsp;<input type="radio" name="reptype" id="pnfc" value="pnfc" onclick="fnSubmit1();"/>Panchayat Wise Not Fully Covered Hab's</td></tr>
    <tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>6.&nbsp;<input type="radio" name="reptype" id="pfc" value="pfc" onclick="fnSubmit1();"/>Panchayat Wise Fully Covered Hab's</td></tr>
    <tr bgcolor="#8A9FCD" align="center"><td align="left" colspan=3 class=btext>7.&nbsp;<input type="radio" name="reptype" id="allp" value="allp" onclick="fnSubmit1();"/>Panchayat Wise both Fully and Partially Covered Hab's</td></tr>
	
</table><br>
<table align="center">
<font color="red">Note:***</font>&nbsp;&nbsp;Please Select any of the above Option to View the Report<br>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1.&nbsp;Consolidate -District wise both Fully and Partially Covered Habitation(s) Count.</td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.&nbsp;Detailed </td></tr>
<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. Only District - All Mandals wise both Fully and Partially Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. District and Mandal - Panchayat wise Fully and Partially Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3.&nbsp;Mandal Wise Not Fully Covered - Mandal wise Only Partially Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.&nbsp;Mandal Wise Fully Covered - Mandal wise Only Fully Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.&nbsp;Panchayat Wise Not Fully Covered - Panchayat Wise Only Partially Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.&nbsp;Panchayat Wise Fully Covered - Panchayat Wise Only Fully Covered Habitation Details.  </td></tr>
<tr><td nowrap>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7.&nbsp;Panchayat Wise Fully & Partially Covered - Panchayat Wise both Fully and Partially Covered Habitation Details.  </td></tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
</table>
	<%	


}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>


<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="dname1">
<INPUT type="hidden" name="mname1">


</form>
</body>
</html>