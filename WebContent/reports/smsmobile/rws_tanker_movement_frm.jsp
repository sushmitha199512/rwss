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
	String qry3="";
	
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
				if(loggedUser=="admin"||loggedUser=="100000" ||loggedUser=="guest")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
					/* document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text; */
					 
					
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
					/* document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text; */
					
				}
			
				document.f1.action="./rws_tanker_movement_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Tanker Movement Report</td>	
	</tr>
	<%
try
{
	String dcode = request.getParameter("district");
	String mcode = request.getParameter("mandal");
	String panchayat = request.getParameter("panchayat");
	String village = request.getParameter("village");
	String habcode = request.getParameter("habcode");
	
	
%>
	<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
		if(loggedUser!=null && (loggedUser.equals("admin")||loggedUser.equals("100000") ||loggedUser.equals("guest")))
		{
		%>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onchange="this.form.submit()">
			
			<option value="all">ALL</option>
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
				
		%>
		</SELECT>
		<%
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

	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="mandal" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				
				<option value="">-Select-</option>
            <%if(dcode!=null && !dcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct mcode,mname from rws_mandal_tbl   where dcode='"+dcode+"' order by mname";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(mcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
					
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
	</SELECT>
    </td>
	</tr>
	 <tr><td class=rptLabel>Panchayat&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="panchayat" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				
				<option value="">-Select-</option>
            <%if(dcode!=null && !dcode.equals("") && mcode!=null && !mcode.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct pcode,pname from rws_panchayat_tbl   where dcode='"+dcode+"' and mcode='"+mcode+"' order by pname";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(panchayat)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
					
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
	</SELECT>
    </td>
	</tr>
	<tr><td class=rptLabel>Village&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="village" id="combo" class="mycombo" style="width:150px"  onchange="this.form.submit()">
				
				<option value="">-Select-</option>
            <%if(dcode!=null && !dcode.equals("") && mcode!=null && !mcode.equals("") && panchayat!=null && !panchayat.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct vcode,vname from rws_village_tbl   where dcode='"+dcode+"' and mcode='"+mcode+"' and pcode='"+panchayat+"' order by vname";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(village)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
					
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
	</SELECT>
    </td>
	</tr>
	<tr><td class=rptLabel>Habitation&nbsp;&nbsp;</td>
		<td class=btext>
		<SELECT name="habcode" id="combo" class="mycombo" style="width:150px"  >
				
				<option value="">-Select-</option>
            <%if(dcode!=null && !dcode.equals("") && mcode!=null && !mcode.equals("") && panchayat!=null && !panchayat.equals("") && village!=null && !village.equals("")) {
			Statement stmt2 = conn.createStatement();
			query="select  distinct panch_code,panch_name from rws_panchayat_raj_tbl   where substr(panch_code,1,2)='"+dcode+"' and substr(panch_code,6,2)='"+mcode+"' and substr(panch_code,13,2)='"+panchayat+"' and substr(panch_code,8,3)='"+village+"' order by panch_name";
			// System.out.println("qqq:"+query);
			ResultSet rs2 = stmt2.executeQuery(query);
			while(rs2.next())
			{
				 if(rs2.getString(1).equals(habcode)){
	%>
					 <option value="<%=rs2.getString(1)%>" selected><%=rs2.getString(2)%></option> 
	<%} else{%>
					 <option value="<%=rs2.getString(1)%>" ><%=rs2.getString(2)%></option> 
					
	<%}
			}

						if(rs2!=null)rs2.close();
						if(stmt2!=null)stmt2.close();
	} %>
	</SELECT>
    </td>
	</tr>
	<tr>
	<td class=rptLabel>From Date<font color="red">*</font>&nbsp;</td>
		<td class=btext>
	
	<input type=text   name="fromDate"   class="mycombo" style="width:100px"  />
					    			   <a href="javascript: showCalendarFuture(document.getElementById('fromDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>
	</tr><tr>
	<td class=rptLabel>To Date<font color="red">*</font>&nbsp;</td>
		<td class=btext>
	<input type=text   name="toDate"   class="mycombo" style="width:100px"     />
					    			   <a href="javascript: showCalendarFuture(document.getElementById('toDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>
	</tr><tr>
	<%
}
	catch(Exception e)
		{
		e.printStackTrace();
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Details">
	</td>
	</tr>
</table>
<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
<INPUT type="hidden" name="mname">
<INPUT type="hidden" name="sname">
<%@ include file="/reports/connClose.jsp" %>  <%}finally{}%>



</form>
</body>
</html>