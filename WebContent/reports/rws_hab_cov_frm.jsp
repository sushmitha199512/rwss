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
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
 if(document.f1.finyear.value=='0')
			{
				alert("Please Select Financial Year");
				return false;
			}
if(document.f1.scheme.value=='0' || document.f1.scheme.value=='')
			{
				alert("Please Select Scheme");
				return false;
			}
		
			
			
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" || loggedUser==("1000DR"))
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
				
				}
				//alert(document.f1.dname.value);
				document.f1.action="./rws_hab_cov_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Coverage Of Habitations Under TPP- Report</td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
	
	
	
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest") || loggedUser.equals("1000DR")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" >
		 <option value="ALL" >ALL</option>
		<%
			stmt = conn.createStatement();
			query="SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname";
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
			//// System.out.println("in selected dist:");
			stmt = conn.createStatement();
					query="SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'";
			rs = stmt.executeQuery(query);
			if(rs.next())
			{
				dcode=rs.getString(1);
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
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

<tr>
<%@ include file="financialYear.jsp" %>
</tr>
<tr>
<td class=rptLabel>Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo3" style="width:120px" multiple size=5 class="hightlongcombo" >

				<option value="0">-select-</option>
				
<%
		Statement stmt3 = conn.createStatement();
		String 	query3="select * from  rws_asset_type_tbl  order by 1";
		ResultSet rs3 = stmt3.executeQuery(query3);
		while(rs3.next())
		{%>
		<option value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option> 
		<%}
		rs3.close();
	
%>
		</SELECT>
		</td>
</tr>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">





</form>
</body>
</html>