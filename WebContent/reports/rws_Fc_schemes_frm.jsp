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
	WorksData1 wd = new WorksData1();
	int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));
	//int fyear1=0;
	//System.out.println("1:"+request.getParameter("fy"));
	//System.out.println("2:"+request.getParameter("ty"));
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
			
			if(document.f1.status.value=='')
			{
				alert("Please Select CoverageStatus");
				return false;
			}
				if(document.f1.scheme.value=='' && document.f1.scheme1.value=='')
				{
				alert("Please Select scheme");
				return false;
				}
				else if(document.f1.scheme.value!='' && document.f1.scheme1.value!='')
				{
				alert("Please Select Any one scheme only");
                document.f1.scheme.value="";
				document.f1.scheme1.value="";
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
				}
				if(document.f1.panch.value!="")
				{
				document.f1.pname.value = document.f1.panch.options[document.f1.panch.selectedIndex].text;
				}
				if(document.f1.village.value!="")
				{
				document.f1.vname.value = document.f1.village.options[document.f1.village.selectedIndex].text;
				}
				if(document.f1.scheme.value!="")
				{
				document.f1.sname.value = document.f1.scheme.options[document.f1.scheme.selectedIndex].text;
				}
				if(document.f1.scheme1.value!="")
				{
				document.f1.sname1.value = document.f1.scheme1.options[document.f1.scheme1.selectedIndex].text;
				}
				}
				else
				{
					document.f1.dname.value = document.f1.district.value;
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
				if(document.f1.scheme.value!="")
				{
				document.f1.sname.value = document.f1.scheme.options[document.f1.scheme.selectedIndex].text;
				}
				if(document.f1.scheme1.value!="")
				{
				document.f1.sname1.value = document.f1.scheme1.options[document.f1.scheme1.selectedIndex].text;
				}
				}
				document.f1.action="./rws_Fc_schemes_rpt.jsp";
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
		<td align="center" class="rptHeading" colspan=3>Habitations Having/Not Having Schemes -- Report</td>	
	</tr>
	<%
try
{
	
	String dcode = request.getParameter("district");
	String mcode=request.getParameter("mandal");
	String pcode=request.getParameter("panch");
	String vcode=request.getParameter("village");
	String habcode=request.getParameter("habitation");
	
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
    

	<tr><td class=rptLabel>Mandal&nbsp;&nbsp;</td>
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
	

	<%	
}
	catch(Exception e)
		{
// System.out.println("Exception in bill Report frm jsp:"+e);
        }
%>
	
	<tr><td class=rptLabel>Coverage Status&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="status" id="combo" class="mycombo" style="width:150px"  >
		<option value="">-Select-</option>
			<option value="FC">FC</option>
			<option value="PC1">PC1</option>
			<option value="PC2">PC2</option>
			<option value="PC3">PC3</option>
			<option value="PC4">PC4</option>
			
				</td>
	</tr>
	<tr><td class=rptLabel colspan="2">
	<table align="center">
		<tr><td class=rptLabel> 
		Not Having Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme" id="combo" class="mycombo" style="width:150px">
			<option value="">-Select-</option>
			<%
			query="SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_code<> 10 and type_of_asset_code<> '08' and type_of_asset_code<> '06' and type_of_asset_code<> '07' and type_of_asset_code<> '05' order by (case type_of_asset_name when 'CPWS' THEN 1 when 'PWS' THEN 2 when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6 when 'PONDS' THEN 7 when 'OPEN WELLS' THEN 8 END) ASC";
			//System.out.println(query);
			stmt=conn.createStatement();
			rs.close();
			rs=stmt.executeQuery(query);
			while(rs.next())
			{
			%>
			<option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option> 
			<%
			}
			 
			%>
				</td>
	</tr>
	<tr><td></td><td align="left" ><font color="blue" face="verdana" size="2">OR</font></td></tr>
		<tr><td class=rptLabel> Having Scheme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="scheme1" id="combo" class="mycombo" style="width:150px">
			<option value="">-Select-</option>
			<%
			query="SELECT type_of_asset_code , UPPER(type_of_asset_name) FROM rws_asset_type_tbl where type_of_asset_code<> 10 and type_of_asset_code<> '08' and type_of_asset_code<> '06' and type_of_asset_code<> '07' and type_of_asset_code<> '05' order by (case type_of_asset_name when 'CPWS' THEN 1 when 'PWS' THEN 2 when 'MPWS' THEN 3 when 'DIRECT PUMPING' THEN 4 when 'HANDPUMPS' THEN 5 when 'SHALLOW HAND PUMPS' THEN 6 when 'PONDS' THEN 7 when 'OPEN WELLS' THEN 8 END) ASC";
			//System.out.println(query);
			stmt=conn.createStatement();
			rs.close();
			rs=stmt.executeQuery(query);
			while(rs.next())
			{
			%>
			<option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option> 
			<%
			}
			 
			%>
				</td>
	</tr>
</table>
		</td>
	</tr>

	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3  align="center">
			<input type=button id="vbutton" onclick="fnSubmit1()" class=btext value="Get Habitations">
		
			
		</td>
	</tr>

</table>

<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
	<INPUT type="hidden" name="mname">
	<INPUT type="hidden" name="pname">
	<INPUT type="hidden" name="vname">
	<INPUT type="hidden" name="habname">
	<INPUT type="hidden" name="sname">
	<INPUT type="hidden" name="sname1">



</form>
</body>
</html>