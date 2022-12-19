<%@ include file="/commons/rws_prajapatham_header1.jsp"%>
<%@ include file="/commons/rws_prajapatham_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<html>
<head>

<script language="JavaScript">
	function unview()
	{
	    var a=document.getElementById('combo').value;
		
		if(a=="-1")
		{
	       //document.getElementById('vbutton').disabled=true;
		}
		 
	}
	function fnSubmit()
	{
			
		document.f1.constituency.value="-1";
		document.f1.action="/pred/reports/rws_praja_drill_byProg.jsp?"
		document.f1.submit();	
	}
	

</script>
<%
	//System.out.println("***********************FROM BEGINING***********************");
	String query = null;
%>
</head>
<body bgcolor="#edf2f8" onLoad="unview()">
<form name=f1  action="<%= request.getRequestURI()%>">
<input type="hidden" name="constituency">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=prajapatham">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Prajapatham Work Wise Report</font></td>	
	</tr>
<%
		String rDistrict = null,rProgramme;
		rDistrict = request.getParameter("district");
		//System.out.println("rDistrict = " +rDistrict);
		//System.out.println("rConstituency = " +rConstituency);
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);		
		
try
{
	if(rDistrict == null || rDistrict.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>
<!-- district dropdown -->
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">ALL</option>
				<!-- <option value="00">All</option> -->
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", rDistrict);
	}
		
	
	else
		if(rDistrict != null || rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!-- <option value="-1">SELECT...</option> -->
				<option value="00" SELECTED>ALL</option> 
<% 
				session.setAttribute("districtCode",null);
				session.setAttribute("districtName",rDistrict);

		
		} 
		else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<!-- <option value="-1">SELECT...</option> -->
				<!-- <option value="00">ALL</option> -->
<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
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
}
catch(Exception e)
{
	//System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
%>
			</select>
		</td>
	</tr>
	
<!-- end of Districts -->
<!--  Programme drop down starts here -->

<%
		
		rProgramme = request.getParameter("programme");
		//System.out.println("rDistrict = " +rDistrict);
		//System.out.println("rConstituency = " +rConstituency);
		//System.out.println("rMandal = " +rMandal);		
		//System.out.println("rPanchayat = " +rPanchayat);		
		
try
{
	if(rProgramme == null || rProgramme.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>

	<tr>
		<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="programme" id="programmeCombo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="ALL">ALL</option>
				<!-- <option value="00">All</option> -->
<%
				session.setAttribute("programmeCode", null);
				session.setAttribute("programmeName", rProgramme);
	}
		
	
	else
		if(rProgramme != null || rProgramme.equals("ALL"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="programme" id="programmeCombo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!-- <option value="-1">SELECT...</option>  -->
				<option value="ALL" SELECTED>ALL</option> 
<% 
				session.setAttribute("programmeCode",null);
				session.setAttribute("programmeName",rProgramme);

		
		} 
		else 
			if(!rProgramme.equals("-1"))  
			{
%>
		<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="programme" id="programmeCombo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<!-- <option value="-1">SELECT...</option> -->
				<option value="ALL">ALL</option>
<%
					session.setAttribute("programmeCode", rProgramme);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				query="SELECT distinct programme_code,programme_name from rws_programme_tbl";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rProgramme != null && rProgramme.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("programmeCode", rProgramme);
						session.setAttribute("programmeName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("programmeCode", rProgramme);
						}
				}			
					rs.close();			
					stmt.close();
}
catch(Exception e)
{
	//System.out.println("THE ERROR IN DISTRICT... " +e);
	//e.printStackTrace();
}
finally{

if(conn!=null)
conn.close();


}

%>
			</select>
		</td>
	</tr>
<!--  end of programme drop down -->

<%	
	//if(rDistrict != null ){	//System.out.println("View Report Enabled...");
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
<%
	//}
%>
</table>
<%@ include file = "footer.jsp" %>

</form>
</body>
</html>
