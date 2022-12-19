<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_ho_header1.jsp"%>
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
 function show()
	{
		if(document.forms[0].nvoucher[0].checked)
		{
		  document.getElementById('selecthab').style.display='none';
		}

    }
	function show1()
	{
	  if(document.forms[0].nvoucher[1].checked){
	  document.getElementById('selecthab').style.display='block';}
	}


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
					var hvoucher="";
					if(document.forms[0].fromDate.value=="")
					{
						alert("Please  Select From Date");
						return false;
					}
					if(document.forms[0].toDate.value=="")
					{
						alert("Please  Select To Date");
						return false;
					}
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
					document.f1.divname.value = document.f1.division.options[document.f1.division.selectedIndex].text;
					document.f1.action="./rws_revoke_bill_process.jsp?&voucher="+hvoucher;
					document.f1.submit();
			}	
		}
		else
		{
			document.f1.action="./rws_revoke_bill_process.jsp";
			document.f1.submit();
		}
	}
	
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=200>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="../masters/rws_HO_homepage_frm.jsp">My Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Revoke Bills form</td>	
	</tr>
	
<%
try
{
	String dcode = request.getParameter("district");
	String divcode = request.getParameter("division");
	if(dcode==null)dcode="";
	if(divcode==null)divcode="";
	////System.out.println("divcode:"+divcode);
%>
	<tr><td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
<%
			stmt = conn.createStatement();
			
			query="SELECT distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d where d.circle_office_code<>16  order by 2";
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
				////System.out.println("div qry:"+query);
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


<tr>
<td colspan=2>
<div id="selecthab" style="display:block">
<table border=0  width=100%>
<tr>
<td class=btext colspan=2>Bill Entry Dates:</td>
</tr>
<tr>
<td align="center" class=rptvalue colspan=2>From Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendar(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<td  align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendar(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
</tr>
</table>
</td></tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Works">
		</td>
	</tr>
	<tr >
</table>
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="divname">
</form>
</body>
</html>