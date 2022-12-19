<html>

<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
%>
<script>
 
  function fnSubmit()
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
			var user = '<%=loggedUser%>';
			if(user=="admin" || user=="100000")
			{
				
				//alert("hi");
				document.f1.dname.value = document.f1.district.options[document.f1.district.selectedIndex].text;
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				//document.f1.stype.value=document.f1.stype.options[document.f1.stype.selectedIndex].text;
				
            	document.f1.action="./rws_tanks_rpt.jsp";
				document.f1.submit(); 
			}
	
			else
			{ 
				//alert("hello");
				document.f1.dname.value = document.f1.dname.value;
				document.f1.mname.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
				//document.f1.mname.value = document.f1.mname.value;
				//document.f1.stype.value=document.f1.stype.options[document.f1.stype.selectedIndex].text;
				
            	document.f1.action="./rws_tanks_rpt.jsp";
				document.f1.submit();
			}
	}
	

</script>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=75% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=2>Drinking Water Facilities available through Schemes</td>	
	</tr>
<%
	String dcode = request.getParameter("district");
    // System.out.println("dcode"+dcode);
    String mcode=request.getParameter("mandal");
    //String scode=request.getParameter("stype");
  //  System.out.println("scode"+scode);

	//String habcode=request.getParameter("habitation");
	
	%>

<tr><td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<%
try{
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
				  //System.out.print("inif");
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
                    rs.close();			
					stmt.close();
                    
			 } 
			 
			 
			 
			 %>
    </td>
	</tr>
    
<!-- 
	<tr><td class=rptLabel>Tank Type&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="stype" id="combo" class="mycombo" style="width:150px"  >
			<option value="">-Select-</option>

			<option value="">GLSR</option>
			<option value="">OHBR</option>
			<option value="">OHSR</option>
			

				</td>
	</tr> -->
		<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Report">
		</td>
	</tr>
	</table>
	<INPUT type="hidden" name="dname">
	<INPUT type="hidden" name="mname">

</form>
</body>
</html>
<%}catch(Exception e){}%>