<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
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
		if(user=="admin" || user=="100000")
		{
			if(document.f1.district.value=='')
			{
				alert("Please Select District");
				return false;
			}
			else if(document.f1.division.value=='')
			{
				alert("Please Select Division");
				return false;
			}
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.action="./rws_work_voucher_frm1.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.action="./rws_work_voucher_frm1.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Select Work for Voucher</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
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
			/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
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

		<tr>
		<%if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{%>
		<td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
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
			<%
		}
		else
		{
						%>
			<td class=rptLabel>Division&nbsp;&nbsp;<font color="red">*</font></td>
			<td>
			<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query="SELECT * from rws_division_office_tbl where circle_office_code='"+dcode+"' and division_office_code='"+loggedUser.substring(3,4)+"'";
				rs = stmt.executeQuery(query);
				if(rs.next())
				{
					divcode=rs.getString(3);
		%>
					<input type="text" name="divname" readonly="true" class="mytext" style="width:150px" value="<%=rs.getString(4)%>">
					<input type="hidden" name="division" value="<%=rs.getString(3)%>">
		<%
				}
		}

%>
		</td></tr>


		<tr><td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="program" id="combo" class="mycombo" style="width:150px">
				<option value="">-Select-</option>
<%
			Statement stmt1 = conn.createStatement();
			query="select distinct b.programme_code,b.programme_name from rws_work_admn_tbl a,rws_programme_tbl b,rws_work_commencement_tbl wc,rws_work_bill_tbl bill where a.work_id=wc.work_id and a.work_id=bill.work_id and wc.work_id=bill.work_id and grounding_date is not null and a.programme_code=b.programme_code and substr(a.work_id,5,2)='"+dcode+"' and substr(a.office_code,4,1)='"+divcode+"'  order by 2";
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
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. You can enter the Vouchers for the Works which are having Mile Stones Information and Bills Information

</p>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
</form>
</body>
</html>
