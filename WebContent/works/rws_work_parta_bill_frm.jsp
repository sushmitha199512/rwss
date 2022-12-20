<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	if(user!=null){
	       if(loggedUser!=null && (!loggedUser.equals("admin") && !loggedUser.equals("100000") && !loggedUser.substring(4, 6).equals("EE")  && !loggedUser.substring(4, 6).equals("AO"))){
	      response.sendRedirect("../commons/UnAuthorize.jsp");
	       }
	}
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
				document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
				document.f1.action="./rws_parta_works_bill.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			document.f1.action="./rws_parta_works_bill.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Select Work for Part A Bill</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
	//System.out.println("divcode:"+divcode);
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<option value="ALL">ALL</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.dcode,d.dname from rws_district_tbl d ,rws_notgroundworks_status_tbl  c where substr(c.work_id,5,2)=d.dcode and d.dcode<>16  order by d.dname";
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
				<input type="text" name="dname" class="mytext" style="width:150px" value="<%=rs.getString(2)%>">
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
			if(dcode!=null && !dcode.equals("") && !dcode.equals("ALL"))
			{
				stmt.close();
				stmt = conn.createStatement();
				query="SELECT distinct CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME  from rws_division_office_tbl d,rws_notgroundworks_status_tbl c,rws_work_admn_tbl b where c.work_id=b.work_id and substr(c.work_id,5,2)=circle_office_code and DIVISION_OFFICE_CODE=substr(b.office_code,4,1) and circle_office_code='"+dcode+"' and status<>'UI' order by 3";
				rs.close();
System.out.println("div QUery"+query);
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rs.getString(2).equals(divcode))
					{
		%>
						 <option value="<%=rs.getString(2)%>" selected><%=rs.getString(3)%></option> 
		<%
					}
					else
					{
		%>
						 <option value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option> 
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
				//System.out.println("div qry:"+query);
				rs = stmt.executeQuery(query);
				if(rs.next())
				{
					divcode=rs.getString(3);
		%>
					<input type="text" name="divname" class="mytext" style="width:150px" value="<%=rs.getString(4)%>">
					<input type="hidden" name="division" value="<%=rs.getString(3)%>">
		<%
				}
		}

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

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="pname">
<INPUT type="hidden" name="divname">
</form>
</body>
</html>