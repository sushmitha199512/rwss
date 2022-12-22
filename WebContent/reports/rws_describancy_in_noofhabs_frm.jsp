<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.util.*" %>
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
		var user = '<%=loggedUser%>';
		if(user=="admin" || user=="100000" || user=="guest")
		{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
           

			else
			{
	
				
				document.f1.action="./rws_describancy_in_noofhabs_rpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			}
	}
	function load()
{
	
	
	document.getElementById("district").disabled=false;
	document.getElementById("division").disabled=false;

}
	

</script>

</head>
<body bgcolor="#edf2f8" >
<form name=f1  action="<%= request.getRequestURI()%>" method="get" >
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Describancy in Number Of Habs Report</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divname = request.getParameter("division");
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			<option value="">-Select-</option>
			
<%  
			if(dcode!=null && dcode.equals("all")){%>
			<option value="all" selected>All</option> 
		<%}else{%>
				<option value="all" >All</option> 
			<%}stmt = conn.createStatement();
			
			//query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname";
			query="SELECT distinct d.dcode,d.dname  from rws_district_tbl d ,rws_work_admn_tbl w  where d.dcode<>16  and substr(w.work_id,5,2)=d.dcode  order by d.dname";
			//System.out.println("1:"+query);
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
				<input type="text" name="dname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
				<input type="hidden" name="district" value="<%=rs.getString(1)%>">
	<%
			}
		}
	%></tr>

		<%
				 if(dcode!=null && !dcode.equals("all"))
	    {%>
		<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
		<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			//query="select category_code,category_name from rws_work_category_tbl order by category_code";
			query="select  distinct a.division_office_code,a.division_office_name from rws_division_office_tbl a,rws_work_admn_tbl w where substr(w.office_code,2,2)=a.circle_office_code and substr(w.office_code,4,1)=a.division_office_code  ";
			if(dcode!=null && !dcode.equals("all"))
			{
			 query+=" and substr(w.office_code,2,2)='"+dcode+"'  ";
			}
			 query+=" order by a.division_office_name";
			//System.out.println("qqq:"+query);
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
				if(divname!=null && divname.equals(rs1.getString(1)))
				{ %>
					 <option value="<%=rs1.getString(1)%>" selected><%=rs1.getString(2)%></option> 
	<%}else{%>
						<option value="<%=rs1.getString(1)%>" ><%=rs1.getString(2)%></option> 
				<%}
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
%>
</td></tr>
<%}

else if(dcode !=null && dcode.equals("all"))
	
			
			{%>
			<tr>
			<td class = btext><font color="navy"><b>Division</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="division" id="combo" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="">-Select-</option>
	<INPUT TYPE="hidden" name="division" value="0"> 
	</td>
	</tr>
						
			<%	
				//session.setAttribute("division",null);
	
	}

	
}catch(Exception e){e.printStackTrace();}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
	<tr>
	

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<!--<INPUT type="hidden" name="divpname">-->

</form>
</body>
</html>