
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	
	if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
		response.sendRedirect("UnAuthorize.jsp");	
	}
%>
<script>
 
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
			if(document.f1.mandal.value=='')
			{
				alert("Please Select Mandal");
				return false;
			}
			else
			{
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				if(document.f1.mandal.value!="")
				{
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				}
				if(document.f1.panch.value!="")
				{
				document.f1.pname.value = document.f1.panch.options[document.f1.panch.selectedIndex].text;
				}
				if(document.f1.village.value!="")
				{
				document.f1.vname.value = document.f1.village.options[document.f1.village.selectedIndex].text;
				}
				document.f1.action="./rws_Hab_SC_ST_rpt.jsp";
				document.f1.submit();
			}	
		}
		else
		{
			//document.f1.pname.value = document.f1.program.options[document.f1.program.selectedIndex].text;
			document.f1.action="./rws_Hab_SC_ST_rpt.jsp";
			document.f1.submit();
		}
	}

</script>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="get">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=75% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=2>Habitation SC/ST/Minority Status</td>	
	</tr>
<%
	String dcode = request.getParameter("district");
	String mcode=request.getParameter("mandal");
	String pcode=request.getParameter("panch");
	String vcode=request.getParameter("village");
	String habcode=request.getParameter("habitation");
	
	%>

<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000")))
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
    

	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="mandal" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 if(dcode!=null && !dcode.equals(""))
			 {
                   query=" select mcode,mname from rws_mandal_tbl where dcode='"+dcode+"' order by mname ";
			        stmt=conn.createStatement();
					rs.close();
					rs=stmt.executeQuery(query);
                    while(rs.next())
				{
                  if(rs.getString(1).equals(mcode))
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

			 }%>
    </td>
	</tr>
	
<tr><td class=rptLabel>Panchayat&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="panch" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 if(mcode!=null && !mcode.equals(""))
			 {
                   query=" select pcode,pname from rws_panchayat_tbl where dcode='"+dcode+"' and mcode='"+mcode+"'  order by pname ";
			        stmt=conn.createStatement();
					rs.close();
					rs=stmt.executeQuery(query);
                    while(rs.next())
				{
                  if(rs.getString(1).equals(pcode))
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

			 }%>
    </td>
	</tr>

	<tr><td class=rptLabel>Village&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="village" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 if(pcode!=null && !pcode.equals(""))
			 {
                   query=" select vcode,vname from rws_village_tbl where dcode='"+dcode+"' and mcode='"+mcode+"'  and pcode='"+pcode+"' order by vname ";
			        stmt=conn.createStatement();
					rs.close();
					rs=stmt.executeQuery(query);
                    while(rs.next())
				{
                  if(rs.getString(1).equals(vcode))
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

			 }%>
    </td>
	</tr>

	<tr><td class=rptLabel>Habitaion&nbsp;&nbsp;<font color="red"></font></td>
		<td class=btext>
		<SELECT name="habitation" id="combo" class="mycombo" style="width:150px"  onChange="this.form.submit()">
			<option value="">-Select-</option>
			<%
			 if(vcode!=null && !vcode.equals(""))
			 {
                   query=" select panch_code,panch_name from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"'  and substr(panch_code,13,2)='"+pcode+"' and substr(panch_code,8,3)='"+vcode+"' order by panch_name ";
			        stmt=conn.createStatement();
					rs.close();
					rs=stmt.executeQuery(query);
                    while(rs.next())
				{
                  if(rs.getString(1).equals(habcode))
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

			 }%>
    </td>
	</tr>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Habitations">
		</td>
	</tr>
	</table>
	<INPUT type="hidden" name="dname">
	<INPUT type="hidden" name="mname">
	<INPUT type="hidden" name="pname">
	<INPUT type="hidden" name="vname">
	<INPUT type="hidden" name="habname">
	</body>
	</html>