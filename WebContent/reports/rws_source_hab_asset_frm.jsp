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
	
		function fnSubmit1()
	{
		var loggedUser = '<%=loggedUser%>';
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
			if(document.f1.source.value=='0')
			{
				alert("Please Select Source");
				return false;
			}
			
			else
			{
				if(loggedUser=="admin"||loggedUser=="100000")
				{
					document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				if(document.f1.mandal.value!="")
				{
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				document.f1.sname.value = document.f1.source.options[document.f1.source.selectedIndex].text;
				}
				
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
					document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
						document.f1.sname.value = document.f1.source.options[document.f1.source.selectedIndex].text;
				}
				document.f1.action="./rws_source_hab_asset_rpt.jsp";
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
					<td align="right" class="bwborder"><a href="/pred/home.jsp">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Source - Asset Coverage Report</td>	
	</tr>
	<%
try
{
	
	String dcode = request.getParameter("district");
	String mcode=request.getParameter("mandal");
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
			
			query="select distinct  d.dcode,d.dname   from rws_district_tbl d,rws_source_tbl a,rws_asset_mast_tbl b,rws_complete_hab_view c ,rws_source_habitation_tbl d,rws_subsource_type_tbl e where  b.asset_code=a.asset_code and substr(a.source_code,1,16)=c.panch_code and b.hab_code=c.panch_code and a.source_code=d.source_code and a.source_type_code=e.source_type_code and d.dcode<>16 and substr(a.source_code,1,2)=d.dcode and substr(b.hab_code,1,2)=d.dcode and d.dcode=substr(d.hab_code,1,2) order by d.dname";
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
			query="select distinct d.dcode,d.dname   from rws_district_tbl d,rws_source_tbl a,rws_asset_mast_tbl b,rws_complete_hab_view c ,rws_source_habitation_tbl e,rws_subsource_type_tbl e where  b.asset_code=a.asset_code and substr(a.source_code,1,16)=c.panch_code and b.hab_code=c.panch_code and a.source_code=e.source_code and a.source_type_code=e.source_type_code and d.dcode<>16 and substr(a.source_code,1,2)=d.dcode and substr(b.hab_code,1,2)=d.dcode and d.dcode=substr(e.hab_code,1,2)  and  d.dcode='"+loggedUser.substring(1,3)+"'";
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
                   query="select distinct  d.mcode,d.mname   from rws_mandal_tbl d,rws_source_tbl a,rws_asset_mast_tbl b,rws_complete_hab_view c ,rws_source_habitation_tbl e,rws_subsource_type_tbl e where  b.asset_code=a.asset_code and substr(a.source_code,1,16)=c.panch_code and b.hab_code=c.panch_code and a.source_code=e.source_code and a.source_type_code=e.source_type_code and d.dcode<>16 and substr(a.hab_code,1,2)=d.dcode and substr(b.hab_code,6,2)=d.mcode and d.mcode=substr(e.hab_code,6,2) and d.dcode='"+dcode+"' order by d.mname";
				   System.out.println("query**"+query);
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
		<!-- <tr><td class=rptLabel>Sources&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="source" id="combo2" class="mycombo" style="width:150px"  >
		<option value="0">-Select-</option>
		<option value="2">Surface Sources</option>
		<option value="1">Sub Surface Sources</option>
		</select>
		</td>
		</tr> -->
		<tr><td class=rptLabel>Source&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="source" id="combo2" class="mycombo" style="width:150px" > 
			<%
			 if(dcode!=null && !dcode.equals("")  && mcode!=null && !mcode.equals(""))
			 {
                   query=" select distinct f.source_type_code,f.source_type_name from rws_source_tbl a,rws_asset_mast_tbl b,rws_complete_hab_view c ,rws_source_habitation_tbl e,rws_subsource_type_tbl e,rws_source_type_tbl f where  b.asset_code=a.asset_code and substr(a.source_code,1,16)=c.panch_code and b.hab_code=c.panch_code and  a.source_code=e.source_code  and    a.source_type_code=f.source_type_code and substr(b.hab_code,6,2)='"+mcode+"' and substr(b.hab_code,1,2)='"+dcode+"' order by f.source_type_name ";
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
			

<%
}
			 catch(Exception e)
			 {
				 e.printStackTrace();
			 }
			 %>
			 <tr bgcolor="#8A9FCD" align="center">
			<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit1()" class=btext value="Get Habitations">
			</td>
			</tr>
			</table>
<%@ include file = "/commons/rws_footer.jsp" %>

<INPUT type="hidden" name="dname">
	<INPUT type="hidden" name="mname">
	<INPUT type="hidden" name="sname">
	
	</form>
</body>
</html>