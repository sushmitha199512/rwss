
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file = "conn.jsp" %>
<%
	//////// System.out.println("***********************FROM BEGINING***********************");
	String query = null,query1 = null;
	nic.watersoft.commons.RwsUser user=null;
   user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user.getUserId();
   Statement stmt1=null,stmt2=null;
    ResultSet rs1=null,rs2=null;
    String rDistrict = null;
	String rMandal = null;
	String rPanch = null;
	String rVillage=null;
	String rHab=null;
	String fromDate=null;
	
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanch = request.getParameter("panchayat");
	rVillage=request.getParameter("village");
	rHab = request.getParameter("hab");
	
%>
<html>
<head>

<script language="JavaScript">

	function fnSubmit()
	{
	 
	 if(document.forms[0].habtype[0].checked)
	 {
	   //alert("1");
	   var dist=document.forms[0].district.value;
	   var mand=document.forms[0].mandal.value;
	   var panch=document.forms[0].panchayat.value;
	   var vill=document.forms[0].village.value;
	   var hab=document.forms[0].hab.value;
	   //alert(dist);
	   if(dist=="00")
	   {
	     document.forms[0].action="./rws_dist_status_rpt123.jsp";
	    document.forms[0].submit(); 
	   }
	   if(dist!="00" && mand=="-1" && panch=="-1" && vill=="-1" && hab=="-1")
	   {
	    //alert("any dist selected");
	     document.forms[0].action="./rws_mandal_status_rpt123.jsp";
         document.forms[0].submit(); 
	   }
	   //alert(mand);
	    if(dist!="00" && mand!="-1" && panch=="-1" && vill=="-1" && hab=="-1")
	   {
	    //alert("in mandal select ");
	     document.forms[0].action="./rws_panch_status_rpt123.jsp";
		 document.forms[0].submit();
	   }
	    if(dist!="00" && mand!="-1" && panch!="-1" && vill=="-1" && hab=="-1")
	    {
	     //alert("in panch select ");
	     document.forms[0].action="./rws_village_status_rpt1.jsp";
		 document.forms[0].submit();
	    }
	   if(dist!="00" && mand!="-1" && panch!="-1" && vill!="-1" && hab=="-1")
	    {
	     //alert("in vill select ");
	    document.forms[0].action="./rws_panch_only_status_rpt123.jsp";
		document.forms[0].submit();
	    }
	    if(dist!="00" && mand!="-1" && panch!="-1" && vill!="-1" && hab!="-1")
	    {
	     //alert("in Hab select ");
	    document.forms[0].action="./rws_hab_only_status_rpt.jsp";
		document.forms[0].submit();
	    }
	 }
	  }
	  
	  function fnSubmit1()
	  {
	    //alert("hab2");
	   if(document.forms[0].habtype[1].checked)
	   {
	   // alert("hab type 2");
	   var rDistrict=document.forms[0].district1.value;
	    // alert(rDistrict);
	   var val=document.getElementById('searchstring').value;
	   if(rDistrict=="-1")
	   {
	    alert("please Select District");
	   }
	   else if(val=="")
	   {
	    alert("Please Enter String");
	   }
	   else{
        var url="./rws_hab_coverage_status_rpt1.jsp";
        // alert(url);
	   document.forms[0].action=url;
	   document.forms[0].submit();
	   }
	  }
	
	}
 function show()
	{
	document.getElementById('search').style.display='none';
	document.getElementById('selecthab').style.display='block';
    }
	function show1()
	{
	document.getElementById('selecthab').style.display='none';
	document.getElementById('search').style.display='block';
	// document.getElementById('selecthab').style.display='none';
	}
	function check()
	{
	 if(document.forms[0].habtype[0].checked)
	 {
	  document.getElementById('search').style.display='none';
	 }
	 if(document.forms[0].habtype[1].checked)
	 {
	  document.getElementById('selecthab').style.display='none';
	 }
	 
	 // document.getElementById('selecthab').style.display='none';
	
	}
	

</script>

</head>
<body bgcolor="#edf2f8" onload="check()">
<form method=post >
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</td> 
				</tr>
			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Habitation Status-Resource Report</td>	
	</tr>
	
<%
try
{
%>
 
<tr><td class=rptLabel colspan="2" align="center">
<input type="radio" value="1" name="habtype" checked onclick="show()">Select Habitation&nbsp;&nbsp;
<input type="radio" value="2" name="habtype" onclick="show1()">Search your Habitation&nbsp;&nbsp;

</td>
</tr>
<%	
  //String hab=request.getParameter("habtype");
  // // System.out.println("hab:"+hab); 
	if(rDistrict == null || rDistrict.equals("00"))
	{
%>
	<tr>
	<td colspan=2>
	<div id="selecthab" style="display:block">
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
	<td class=rptLabel>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">All</option>
				
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", null);
	}
		
	else 
			if(!rDistrict.equals("00"))  
			{
%>     
		<td class=rptLabel>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district"  class="mycombo" style="width:150px" onChange="this.form.submit()">
			<option value="00">All</option>
							
<%     		session.setAttribute("districtCode", "All");
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= D.DCODE order by d.dname";
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
			</select>
		</td>
	</tr>
	<%
	
	if(rDistrict == null || rDistrict.equals("-1"))
	{
	
%>

	<tr>
	
		<td class=rptLabel>Mandal&nbsp;&nbsp;</td>
		<td class=btext>
			<select name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">All</option>-->
<%
				session.setAttribute("mandalCode", null);
				session.setAttribute("mandalName", null);
	}
		
	else 
			if(!rDistrict.equals("-1"))  
			{
%>
		<td class=rptLabel>Mandal&nbsp;&nbsp;</td>
		<td class=btext>
			<SELECT name="mandal"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">ALL</option>-->
<%
					session.setAttribute("mandalCode", rMandal);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT m.mcode, m.mname FROM RWS_mandal_TBL m, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= m.DCODE and SUBSTR(HD.HAB_CODE,6,2)= m.mCODE and SUBSTR(HD.HAB_CODE,1,2)='"+rDistrict+"' order by m.mname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rMandal != null && rMandal.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						session.setAttribute("mandalName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("mandalCode", rMandal);
						}
				}			
					rs.close();			
					stmt.close();

if(rDistrict == null || rDistrict.equals("-1"))
	{
	
%>

	<tr>
		<td class=rptLabel>Panchayat&nbsp;&nbsp;</td>
		<td class=btext>
			<select name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!--<option value="00">All</option>-->
<%
				session.setAttribute("panchayatCode", null);
				session.setAttribute("panchayatName", null);
	}
		
	else 
			if(!rDistrict.equals("-1"))  
			{
%>      <tr>
		<td class=rptLabel>Panchayat&nbsp;&nbsp;</td>
		<td class=btext>
			<SELECT name="panchayat"  class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
					session.setAttribute("panchayatCode", rPanch);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT p.pcode, p.pname FROM RWS_PANCHAYAT_TBL p, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= p.DCODE and SUBSTR(HD.HAB_CODE,6,2)= p.mCODE and SUBSTR(HD.HAB_CODE,13,2)= p.PCODE and SUBSTR(HD.HAB_CODE,1,2)='"+rDistrict+"' and SUBSTR(HD.HAB_CODE,6,2)='"+rMandal+"'  order by p.pname";
				// System.out.println("query for panch:"+query);
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rPanch != null && rPanch.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("panchayatCode", rPanch);
						session.setAttribute("panchayatlName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("panchayatCode", rPanch);
						}
				}			
					rs.close();			
					stmt.close();
	%>
	<tr>
		<td class = btext> 
				<font color=navy><b>Village</b> </font>
		<td class=btext>
			<select name="village"  style="width:150px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				//query = "SELECT distinct h.panch_code, h.panch_name from rws_panchayat_raj_tbl h  where substr(panch_code,1,2)='"+rDist+"' and substr(panch_code,6,2)='"+rMandal+"' substr(panch_code,13,2)='"+rPanchayat+"' substr(panch_code,8,3)='"+rVillage+"'";
				query = "SELECT distinct v.vcode, v.vname from rws_village_tbl v  where v.dcode='"+rDistrict+"' and v.mcode='"+rMandal+"' and v.pcode='"+rPanch+"' order by v.vname";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rVillage != null && rVillage.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%                 session.setAttribute("villageCode", rVillage);
				   session.setAttribute("villageName",rs.getString(2));
					}
					else
					{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
				
<%                 session.setAttribute("villageCode", rVillage);
					}
				}	
 %></select></td></tr>
 <tr>
		<td class = btext> 
				<font color=navy><b>Habitation</b> </font>
		<td class=btext>
			<select name="hab"  style="width:150px" class="mycombo"  onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query = "SELECT distinct h.panch_code, h.panch_name from rws_panchayat_raj_tbl h  where substr(panch_code,1,2)='"+rDistrict+"' and substr(panch_code,6,2)='"+rMandal+"' and substr(panch_code,13,2)='"+rPanch+"' and substr(panch_code,8,3)='"+rVillage+"' order by h.panch_name";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(rHab != null && rHab.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
					//	session.setAttribute("villCode", rVillage);
					//	session.setAttribute("villName",rs.getString(2));
					   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						//session.setAttribute("villCode", rVillage);
						}
				}	
 %></select></td></tr>
	<tr> 
		<td class = btext nowrap>
		<font color=navy><b>Status Date</b> </font>
		<font color=red><b>*</b> </font>
			</td>
			<td class = btext >
				<SELECT name="FDate" id="combo" style="width:125px" class="mycombo" onChange="this.form.submit()">
				<!--<option value="0">SELECT...</option>-->	
			<%
					fromDate = request.getParameter("FDate");
	// //// System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs1=stmt1.executeQuery("select distinct to_char(h.status_date,'dd-MON-yyyy'), to_date(h.status_date,'dd-mm-yyyy')from rws_habitation_dir_his_tbl h where h.status_date is not null Union select distinct to_char(h1.status_date,'dd-MON-yyyy'),to_date(h1.status_date,'dd-mm-yyyy') from rws_habitation_directory_tbl h1 where h1.status_date is not null order by 2 desc");
	while(rs1.next()) 
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 String FDATE=rs1.getString(1);


	session.setAttribute("FDate",FDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%	
		} 
	}
				rs1.beforeFirst(); %>
			</td>
			
		</tr>
			</SELECT>
			</td></tr>
			 <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
</table>
</div>
	
<div id="search" style="display:block">

<table border = 1 align =center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
<%
 if(rDistrict == null || rDistrict.equals("00"))
	{
%>
<td class=rptLabel>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district1" style="width:150px" class="mycombo">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", null);
	}
		
	else 
			if(!rDistrict.equals("00"))  
			{
%>     
		<td class=rptLabel>District&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district1"  class="mycombo" style="width:150px" >
				<option value="-1">SELECT...</option>
		<%
					session.setAttribute("districtCode", rDistrict);
			}
				stmt = conn.createStatement();
				query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2)= D.DCODE order by d.dname";
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
			</select>
		</td>
	</tr>

		<tr>
           <td class="rptLabel" colspan=2 align="left">Enter&nbsp;Your&nbsp;Search&nbsp;String:<font color="red">*</font><input type="text" name="searchstring" maxlength=3 /><br></td>
  	        </tr>
  	         <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit1()" class=btext value="View Report">
		</td>
	</tr>
	</table>	
		</div>	</td></tr>

	</table>
	
								
<%
} catch(Exception e)
{
 	// System.out.println("Exception in Hab Wise report:" +e);
 }
%>
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
