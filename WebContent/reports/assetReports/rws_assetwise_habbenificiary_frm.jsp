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
	WorksData1 wd = new WorksData1();
	int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	//int fyear1=0;
	//System.out.println("1:"+request.getParameter("fy"));
	//System.out.println("2:"+request.getParameter("ty"));
%>
<html>
<head>

<script language="JavaScript">
	
		function fnSubmit1()
	{
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			
			
				if(document.f1.scheme.value=='' )
				{
				alert("Please Select Asset Type");
				return false;
				}
				
						
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				
				if(document.f1.scheme.value!="")
				{
				document.f1.sname.value = document.f1.scheme.options[document.f1.scheme.selectedIndex].text;
				}
				
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
					
				if(document.f1.scheme.value!="")
				{
				document.f1.sname.value = document.f1.scheme.options[document.f1.scheme.selectedIndex].text;
				}
				
				}
				document.f1.action="./rws_assetwise_hab_benificiary_rpt.jsp";
				document.f1.submit();
			}	
		}
		
		
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Asset wise Hab Benefited Form</td>	
	</tr>
	<%
try
{
	
	String dcode = request.getParameter("district");
	String mcode=request.getParameter("mandal");
	String pcode=request.getParameter("panch");
	String vcode=request.getParameter("village");
	String habcode=request.getParameter("habitation");
	
	%>

<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")||loggedUser.equals("guest")||loggedUser.equals("psrwss")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
								
	if(rs.getString(1).equals(dcode))
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
			stmt = conn.createStatement();
			query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
    

	
	




	<%	
}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	

	
		<tr><td class=rptLabel> 
		Asset Type&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo" class="mycombo" style="width:150px"  >
			<option value="">-Select-</option>
			<%
			query="select type_of_asset_code,type_of_asset_name from rws_asset_type_tbl where type_of_asset_code in (01,02,03,04,09,06,07,05) order by 1";
			//System.out.println(query);
			stmt=conn.createStatement();
			rs.close();
			rs=stmt.executeQuery(query);
			while(rs.next())
			{
			%>
			<option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option> 
			<%
			}
			 
			%>
				</td>
	</tr>
	


		</td>
	</tr>

	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit1()" class=btext value="View Report">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
	<INPUT type="hidden" name="mname">
	<INPUT type="hidden" name="pname">
	<INPUT type="hidden" name="vname">
	<INPUT type="hidden" name="habname">
	<INPUT type="hidden" name="sname">
	<INPUT type="hidden" name="sname1">



</form>
</body>
</html>