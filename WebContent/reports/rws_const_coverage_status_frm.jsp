<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, rHabitation = null;

  	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	rDistrict = request.getParameter("district");
	String dcode="";
	if(loggedUser.substring(0,3).equals("col")){
		dcode=(String)session.getAttribute("district");  
		rDistrict=dcode;
	   }
	

 %>



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
	{ //alert("hhhhhhhhhhhh");
		if(document.f1.district.value=="-1")
		{
			alert("Please Select District");
		}
        
       else
       {
		document.f1.action="./rws_const_coverage_rpt.jsp";
		document.f1.submit();	
		}
	}

</script>
<%	String query = null; %>
</head>

<body bgcolor="#edf2f8" onLoad="unview()">
<form name=f1 action="<%=request.getRequestURI()%>">

<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">
<% 
/* if(loggedUser!=null && !loggedUser.equals(Constants.SEC_USER))
{  */%>
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home</td></tr>
<% // } else {%>
	<!-- <tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</td></tr> -->
<%//} %>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Constituency Wise Coverage Status Report</td>	
	</tr>
<%
		
       System.out.println("districtName"+rDistrict);
		rConstituency = request.getParameter("constituency");
		rMandal = request.getParameter("mandal");
		rPanchayat = request.getParameter("panchayat");
		rVillage = request.getParameter("village");		
		
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
		<option value="00">All</option>
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
		<option value="00" SELECTED>All</option>
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
		<option value="00">ALL</option>
<%
		session.setAttribute("districtCode", rDistrict);
		}
		
		stmt = conn.createStatement();
		query="SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  ";
		if(dcode!=null && !dcode.equals("")){
			query+=" and d.dcode='"+dcode+"'";
		}
		query+=" order by d.dname";
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
}
catch(Exception e)
{
	//// System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
	</select>
	</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00") )
		{	
				
%>
	<tr>
		<td class=rptLabel>Constituency</td>
		<td class=btext>
		<SELECT name="constituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="00">SELECT...</option>
<%
		session.setAttribute("constituencyCode", null);
		session.setAttribute("constituencyName", rConstituency);
		}
		else if(rDistrict != null || !rDistrict.equals("-1") || !rDistrict.equals("00") || rConstituency != null)
		{
			System.out.println("in 2");		
%>		
		<td class=rptLabel>Constituency</td>
		<td class=btext>
		<SELECT name="constituency" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="00">SELECT...</option>				
<%
		if(rConstituency != null && rConstituency.equals("00"))
		{
%>
		<option value="00" SELECTED>ALL</option>
<%
		}
		else
		{
%>
		<option value="00">ALL</option>
<%
		}
System.out.println("in 3"+rDistrict);		
		stmt = conn.createStatement();
		query = "select distinct c.constituency_code,c.constituency_name from rws_constituency_tbl c,rws_district_tbl d where d.dcode=c.dcode  and c.dcode='"+rDistrict+"' order by c.constituency_code";
		//// System.out.println("query:"+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rConstituency != null && rConstituency.equals(rs.getString(1)))
			{
%>
			<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			session.setAttribute("constituencyName",rs.getString(2));
			session.setAttribute("constituencyCode",rConstituency);
			}
			else
			{
%>
			<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
			}
		}
		session.setAttribute("constituencyCode",rConstituency);
		rs.close();
		stmt.close();
	 }			
				
}
catch(Exception e)
{
	//// System.out.println("The ERROR IN MANDAL..." + e);
	//e.printStackTrace();
}

%>
	</select>
	</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null)
		{	
%>
	<tr>
		<td class=rptLabel>Mandal</td>
		<td class=btext>
		<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
<%
		session.setAttribute("mandalCode", null);
		session.setAttribute("mandalName", rMandal);
		}
		else if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1"))
		{
%>			
		<td class=rptLabel>Mandal</td>
		<td class=btext>
		<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>				
<%
		if(rMandal != null && rMandal.equals("00"))
		{
%>
		<option value="00" SELECTED>ALL</option>
<%
		}
		else
		{
%>
		<option value="00">ALL</option>
<%
		}

		stmt = conn.createStatement();
		query = "select m.mcode,m.mname from rws_constituency_tbl c,rws_mandal_tbl m where m.dcode=c.dcode and m.mcode=c.mcode and m.dcode= '" +rDistrict+ "' and constituency_code='" +rConstituency+ "' order by m.mname";
		//// System.out.println("query:"+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rMandal != null && rMandal.equals(rs.getString(1)))
			{
%>
			<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			session.setAttribute("mandalName",rs.getString(2));
			session.setAttribute("mandalCode",rMandal);
			}
			else
			{
%>
			<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
			}
		}
		session.setAttribute("mandalCode",rMandal);
		rs.close();
		stmt.close();
	 }			
				
}
catch(Exception e)
{
	//// System.out.println("The ERROR IN MANDAL..." + e);
	//e.printStackTrace();
}

%>
	</select>
	</td>
	</tr>
<%
try
{	
	 if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1"))
	 {	
%>
	<tr>
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
		<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
<%
		session.setAttribute("panchayatCode", null);
		session.setAttribute("panchayatName", rPanchayat);
	 }
	 else if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1") || rMandal != null || !rMandal.equals("00") || !rMandal.equals("-1"))
	 {
%>			
		<td class=rptLabel>Panchayat</td>
		<td class=btext>
		<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>				
<%
		if(rPanchayat != null && rPanchayat.equals("00"))
		{
%>
			<option value="00" SELECTED>ALL</option>
<%
		}
		else
		{
%>
			<option value="00">ALL</option>
<%
		}

		stmt = conn.createStatement();
		query ="select distinct pcode,pname from rws_panchayat_tbl p,rws_constituency_tbl c where c.dcode=p.dcode and c.mcode=p.mcode and p.dcode= '"+rDistrict+"'  and p.mcode='"+rMandal+"' and c.constituency_code= '" +rConstituency+ "' order by pname "; 
			
		//// System.out.println("panch:"+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{
			if(rPanchayat != null && rPanchayat.equals(rs.getString(1)))
			{
%>
			<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
			session.setAttribute("panchayatName",rs.getString(2));
			session.setAttribute("panchayatCode",rPanchayat);
			}
			else
			{
%>
			<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
			}
		}
		session.setAttribute("panchayatCode",rPanchayat);
		rs.close();
		stmt.close();
   }			
				
}
catch(Exception e)
{
	//// System.out.println("The ERROR IN PANCHAYAT..." + e);
	//e.printStackTrace();
}

%>
	</select>
	</td>
	</tr>
<%
try
{	
		if(rDistrict == null || rDistrict.equals("00") || rDistrict.equals("-1") || rConstituency == null || rConstituency.equals("00") || rConstituency.equals("-1") || rMandal == null || rMandal.equals("00") || rMandal.equals("-1") || rPanchayat == null || rPanchayat.equals("00") || rPanchayat.equals("-1"))
		{	
%>
	<tr>
		<td class=rptLabel>Village</td>
		<td class=btext>
		<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
<%
		session.setAttribute("villageCode", null);
		session.setAttribute("villageName", rVillage);
		}
		else
			if(rDistrict != null && !rDistrict.equals("00") || rConstituency != null || !rConstituency.equals("00") || !rConstituency.equals("-1") || rMandal != null || !rMandal.equals("00") || !rMandal.equals("-1") || rPanchayat != null || !rPanchayat.equals("00") || !rPanchayat.equals("-1"))
			{
				//// System.out.println("IN VILLAGE ALL...");
%>			
		<td class=rptLabel>Village</td>
		<td class=btext>
		<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>				
	
<%
			if(rVillage != null && rVillage.equals("00"))
			{
%>
				<option value="00" SELECTED>ALL</option>
<%
			}
			else
			{
%>
				<option value="00">ALL</option>
<%
			}

			stmt = conn.createStatement();
			query = "select distinct vcode,vname from rws_village_tbl v,rws_constituency_tbl c where c.dcode=v.dcode and c.mcode=v.mcode and v.dcode= '"+rDistrict+"' and v.mcode='"+rMandal+"' and v.pcode= '"+rPanchayat+"' and c.constituency_code='"+rConstituency+ "' ";
			// System.out.println("villages:"+query);
			rs = stmt.executeQuery(query);
			while(rs.next())
			{
				if(rVillage != null && rVillage.equals(rs.getString(1)))
				{
%>
				<option value = "<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
				session.setAttribute("villageName",rs.getString(2));
				session.setAttribute("villageCode",rVillage);
				}
				else
				{
%>
				<option value = <%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
				}
			}
			session.setAttribute("villageCode",rVillage);
			rs.close();
			stmt.close();
	}
}
catch(Exception e)
{
	//// System.out.println("The ERROR IN VILLAGE..." + e);
	//e.printStackTrace();
}
finally
{
if(conn!=null)
conn.close();
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

</table><br>

<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
