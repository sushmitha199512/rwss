<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		if(document.f1.district.value=='')
		{
			alert("Please Select District");
		}
		else if(document.f1.program.value=='')
		{
			alert("Please Select Program");
		}
		else
		{
			document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
			document.f1.action="./rws_work_exp_voucher_works_frm.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Expenditure VS Vouchers</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>'16' order by d.dname";
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
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
%>
		</SELECT>
		</td></tr>
		<tr><td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="division" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="">-Select-</option>
<%
			if(dcode!=null && !dcode.equals(""))
			{
				stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl d where circle_office_code='"+dcode+"' order by 3";
				rs.close();
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rs.getString(3).equals(divcode))
					{
		%>
						 <option value="<%=rs.getString(3)%>" selected><%=rs.getString(4)%></option> 
		<%
					}
					else
					{
		%>
						 <option value="<%=rs.getString(3)%>"><%=rs.getString(4)%></option> 
		<%
					}
				}
			}
						if(rs!=null)rs.close();
						if(stmt!=null)stmt.close();
%>
		</SELECT>
		</td></tr>
		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			query="select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b where a.programme_code=b.programme_code and substr(work_id,5,2)='"+dcode+"' and admin_date<'01/APR/2010' order by 2";
			ResultSet rs1 = stmt1.executeQuery(query);
			while(rs1.next())
			{
	%>
					 <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option> 
	<%
			}
						if(rs1!=null)rs1.close();
						if(stmt1!=null)stmt1.close();
%>
</td></tr>
<%	
}catch(Exception e){}
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Works">
		</td>
	</tr>
<%
	//}
%>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****: <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. You can enter the Vouchers for the Works which are sanctioned before </font><font face=verdana size=2 color=blue>01/04/2010</font>
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>2. You can enter the Vouchers for the Works which are having Contractor Details and already Having Expenditure
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. Remaining Works  should enter through 'WORK PROGRESS' form.

</p>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
</form>
</body>
</html>
