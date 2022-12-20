<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>

<script language="JavaScript">
function unview()
{
    var a=document.getElementById('combo').value;	
	if(a=="-1")
	{	
      
	}
}
	function fnSubmit()
	{
		if(document.f1.district.value=="-1")
		{
			alert("Please Select District ");
		}else{
			
		document.f1.action="./rws_work_admn_tech_rpt.jsp";
		document.f1.submit();	
		}
	}

</script>
<%	String query = null; 
Statement stmt1=null,stmt2=null;
ResultSet rs1=null,rs2=null;%>
</head>

<body bgcolor="#edf2f8">
<form name=f1 action="<%=request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</td></tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Difference In Admn and Tech Habs Report</td>	
	</tr>
<%
		String rDistrict,rwrktype,ryear= null;
		rDistrict = request.getParameter("district");
		rwrktype=request.getParameter("wrktype");
		ryear=request.getParameter("fnyear");
	
try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		
<%
		session.setAttribute("districtCode", null);
		session.setAttribute("districtName", rDistrict);
		}
		else if(rDistrict != null || rDistrict.equals("00"))
		{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		
<% 
		session.setAttribute("districtCode",null);
		session.setAttribute("districtName",rDistrict);
		} 
		else if(!rDistrict.equals("-1"))  
		{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		
<%
		session.setAttribute("districtCode", rDistrict);
		}
		
		stmt = conn.createStatement();
		query="SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  order by d.dname";
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rDistrict != null && rDistrict.equals(rs.getString(1)))
			{					
%>
			<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			session.setAttribute("districtCode", rDistrict);
			session.setAttribute("districtName", rs.getString(2));
			}
			else
			{					
%>
			<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
			session.setAttribute("districtCode", rDistrict);
			}
		}			
		rs.close();			
		stmt.close();
		%>
		<tr>
		<td class=rptLabel>Work Type&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="wrktype" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		 <%String ary="SELECT CATEGORY_NAME,category_code FROM rws_work_category_tbl";
		   stmt1=conn.createStatement();
		   rs1=stmt1.executeQuery(ary);
		  while(rs1.next())
	      {
			   if(rwrktype != null && rwrktype.equals(rs1.getString(2)))
			  {
			   %>
			<option value="<%=rs1.getString(2)%>" SELECTED><%=rs1.getString(1)%></option>
			<%
			 session.setAttribute("assetCode", rwrktype);
			session.setAttribute("assetName", rs1.getString(1));
		  }else {
			  %>
			<option value=<%=rs1.getString(2)%> ><%=rs1.getString(1)%></option>
			<%
			session.setAttribute("assetCode", rwrktype);

		  }
		  }
		%>
		 </tr>
		 <tr>
		<td class=rptLabel>Year&nbsp;&nbsp;</td>
		<td class=btext>
		<select name="fnyear" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		<%String ary1="select distinct to_char(admin_date,'yyyy') from rws_work_admn_tbl where admin_date is not null order by to_char (admin_date,'yyyy') desc  ";
		   stmt2=conn.createStatement();
		   rs2=stmt2.executeQuery(ary1);
		  while(rs2.next())
	      {
			   if(ryear != null && ryear.equals(rs2.getString(1)))
			  {
			   %>
			<option value="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(1)%></option>
			<%
			 session.setAttribute("year", ryear);
			
		  }else {
			  %>
			<option value=<%=rs2.getString(1)%> ><%=rs2.getString(1)%></option>
			<%
			session.setAttribute("year", ryear);

		  }
		  }
		%>
		</tr>
<%}
catch(Exception e)
{
	System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
	</select>
	</td>
	</tr>

<tr bgcolor="#8A9FCD" align="center">
<td colspan=3 align=center>
<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
</td>
</tr>

</table>
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
