<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
//String loggedUser = user.getUserId();
StringBuffer loggedUser=new StringBuffer();
	loggedUser.append(user.getUserId());
	
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
		
			
			
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest" || loggedUser==("1000DR")||loggedUser==("minrwss")||loggedUser==("secrwss"))
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
				
				}
				//alert(document.f1.dname.value);
				document.f1.action="./rws_drought_contigencyplan_habs_rpt.jsp";
				document.f1.submit();
			}	
		}
		</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=500>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>ABSTRACT OF CONTEGENCY PLAN - HABITATIONS FOR DROUGHT</td>	
	</tr>
	<%
	
	StringBuffer query=new StringBuffer();
	StringBuffer dcode=new StringBuffer();
try
{
	//String dcode = request.getParameter("district");
	dcode.append(request.getParameter("district"));
	
	
	
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser.toString()!=null && (loggedUser.toString().equals("admin")||loggedUser.toString().equals("100000") ||loggedUser.toString().equals("guest") || loggedUser.toString().equals("1000DR") || loggedUser.toString().equals("minrwss")|| loggedUser.toString().equals("secrwss")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="00">-ALL-</option>
		<%
			stmt = conn.createStatement();
		    query.delete(0,query.length()); 
			query.append("SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 order by dname");
			rs = stmt.executeQuery(query.toString());
				while(rs.next())
				{
				if(rs.getString(1).equals(dcode.toString()))
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
			query.delete(0,query.length()); 
			query.append("SELECT dcode,dname from rws_district_tbl where dcode='"+loggedUser.substring(1,3)+"'");
			rs = stmt.executeQuery(query.toString());
			if(rs.next())
			{
				dcode.append(rs.getString(1));
	%>
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>
			
			

<tr><td class=rptLabel>Year&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="year1" id="combo" class="mycombo" style="width:150px"  >
		<!--		<option value="">-Select-</option>-->
		<%
		Statement stmt3 = conn.createStatement();
		query.delete(0,query.length());        
		query.append("select  distinct year from RWS_DROUGHT_HABITATION_TBL    order by year");
		
		    //System.out.println("year:"+query.toString());
			ResultSet rs3 = stmt3.executeQuery(query.toString());
			while(rs3.next())
			{%>
			 <option value="<%=rs3.getString(1)%>" ><%=rs3.getString(1)%></option> 
	<%}
			%>
			</select></td>
     		</tr>
	
<%

}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
	finally{
		 query=null;
		 dcode=null;
		 loggedUser=null;
	}
%>
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