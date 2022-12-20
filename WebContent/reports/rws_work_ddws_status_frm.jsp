<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp" %>
<%@ include file = "conn.jsp" %>
<%
try {
	nic.watersoft.commons.RwsUser user1=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
   String loggedUser = user1.getUserId();
   String rDistrict = null,rDistrict1 = null,rMandal = null,rPanch = null,rVillage=null,rHab=null,aType=null,rDiv=null,rSubdiv=null;
   String query="";
   String div="",subdiv="",fType="";    
	Statement stmt1=null,stmt2=null;
	ResultSet rs1=null,rs2=null;
	rDistrict = request.getParameter("district");
	rDistrict1 = request.getParameter("district1"); 
	rDiv=request.getParameter("division");
	rSubdiv=request.getParameter("subdivision");
	rMandal = request.getParameter("mandal");
	rPanch = request.getParameter("panchayat");
	rVillage=request.getParameter("village");
	rHab = request.getParameter("hab");
	aType=request.getParameter("atype");
	fType=request.getParameter("year");
   %>

<html>
<head>
<script language="JavaScript">
function fnSubmit()
{
	//alert("in submit");
	var dist=document.forms[0].district.value;
	var div=document.forms[0].division.value;
	var subdiv=document.forms[0].subdivision.value;
	var ftype=document.forms[0].year.value;
	
	var ast;
	if(document.forms[0].scheme[0].checked)
	{
		ast=1;
	}else	 if(document.forms[0].scheme[1].checked)
	{
		ast=2;
	}
	 if(document.forms[0].district.value!="" && document.forms[0].district.value!="-1")
		{
			document.forms[0].districtName.value = document.forms[0].district.options[document.forms[0].district.selectedIndex].text;
		}
		if(document.forms[0].division.value!="" && document.forms[0].division.value!="-1")
		{
			document.forms[0].divisionName.value = document.forms[0].division.options[document.forms[0].division.selectedIndex].text;
		}
		if(document.forms[0].subdivision.value!="" && document.forms[0].subdivision.value!="-1")
		{
			document.forms[0].subdivisionName.value = document.forms[0].subdivision.options[document.forms[0].subdivision.selectedIndex].text;
		}
	if(document.forms[0].scheme[0].checked || document.forms[0].scheme[1].checked)
	{
		 //alert(" work or asset");
	document.forms[0].action="./rws_work_ddws_status.rpt.jsp?dist="+dist+"&div="+div+"&subdiv="+subdiv+"&ast="+ast+"&ftype="+ftype;
	document.forms[0].submit(); 
	}else if(document.forms[0].scheme[2].checked)
	{
		var ftype=document.forms[0].year.value;
		// alert("in  project shelf repaeted hab works:"+ftype);
		 
		 document.forms[0].action="./rws_habs_repeated_rpt.jsp?ftype="+ftype;
		 document.forms[0].submit(); 
	}

}
function fninit()
{
 	if(document.forms[0].scheme[0].checked || document.forms[0].scheme[1].checked )
	{
		document.forms[0].district.disabled=false;	
		document.forms[0].division.disabled=false;	
		document.forms[0].subdivision.disabled=false;	

	} else if(document.forms[0].scheme[2].checked)
	{
		document.forms[0].district.disabled=true;	
		document.forms[0].division.disabled=true;	
		document.forms[0].subdivision.disabled=true;
	}

}

function diasable()
{
  document.forms[0].district.disabled=true;	
  document.forms[0].division.disabled=true;	
  document.forms[0].subdivision.disabled=true;
}


function show()
	{
		document.forms[0].district.disabled=false;	
		document.forms[0].division.disabled=false;	
		document.forms[0].subdivision.disabled=false;	
    }
	function show1()
	{
		document.forms[0].district.disabled=false;	
		document.forms[0].division.disabled=false;	
		document.forms[0].subdivision.disabled=false;	
	}

</script>
</head>


 <body bgcolor="#edf2f8"  onload="fninit()">
<form method=post >
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=200>
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder">	<a href="javascript:history.back(-1)">Back|</a> 
					<a href="../home.jsp">Home</a>
                   			
				</tr>
			</table>
		</caption>
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=3>Project Shelf  Vs Habitations Report</td>	
</tr>
<tr><td class=rptLabel colspan="2" >
<input type="radio" value="1" name="scheme" checked  onclick="show()">Asset
<input type="radio" value="2" name="scheme"  onclick="show1()">Work
<input type="radio" value="3" name="scheme"  onclick="diasable()">Project Shelf Works(repeated  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;habs) 
</td>
</tr>
<td colspan=2>
	
	<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>	
<%	
  
	if(rDistrict == null || rDistrict.equals("00"))
	{
%>
	
	<%if(loggedUser.equals("admin") || loggedUser.equals("10000")) {%>	
	<td class=rptLabel>Circle<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">All</option>
				<%} else { %>
				<td class=rptLabel>Circle<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT</option>
				<%}%>
				
<%
				session.setAttribute("districtCode", null);
				session.setAttribute("districtName", null);
	}
		
	else 
			if(!rDistrict.equals("00"))  
			{
%>     
		<%if(loggedUser.equals("admin") || loggedUser.equals("10000")) {%>	
	<td class=rptLabel>Circle<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">All</option>
				<%} else { %>
				<td class=rptLabel>Circle<font color="red">*</font></td>
		<td class=btext>
			<select name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT</option>
				<%}%>
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
if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00"))
		{	
			//// System.out.println("IN division STARTING...");
%>
	<tr>
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="division" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled>
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("divCode", null);
				session.setAttribute("divName", null);
		}
		else
			if(rDistrict != null && !rDistrict.equals("-1") && !rDistrict.equals("00"))
			{
				%>			
		<td class = btext nowrap>
		<font color="navy"><b>Division</b></font>
		<td class=btext>
		<SELECT name="division" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="-1">SELECT...</option>
		
<%          
	         session.setAttribute("divCode",rDiv);
				stmt1 = conn.createStatement();
					query ="select distinct d.division_office_code,d.division_office_name from rws_division_office_tbl d where  d.circle_office_code='"+rDistrict+"' order by d.division_office_code";
					//// System.out.println("div:"+query);
					rs1 = stmt1.executeQuery(query);
					while(rs1.next())
					{
					   
						if(rDiv != null && rDiv.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("divName",rs1.getString(2));
						div=rs1.getString(1);
						session.setAttribute("divCode",rDiv);
						}
						else
						{
%>
					<option value = <%=rs1.getString(1)%> ><%=rs1.getString(2)%></option>
<%
						}
					}
					session.setAttribute("divCode",rDiv);
					rs1.close();
					stmt1.close();
			}			
								


%>
			</select>
		</td>
	</tr>
	  
<% // // System.out.println("div:"+rDiv);
		
		if(rDistrict == null || rDistrict.equals("-1") || rDistrict.equals("00") )
		{
			
%>
<tr>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("subdivName",null);
				session.setAttribute("subdivCode",null);
		}
		
		else if(rDistrict != null || !rDistrict.equals("-1"))
			{
				%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%   
				session.setAttribute("subdivCode",rSubdiv);
	 			stmt2 = conn.createStatement();
	             
				query = "select distinct sd.subdivision_office_code,sd.subdivision_office_name from rws_subdivision_office_tbl sd where sd.circle_office_code='"+rDistrict+"' and" 
							+" sd.division_office_code='"+div+"' order by sd.subdivision_office_code";
				//// System.out.println("subdiv:"+query);
				rs2 = stmt2.executeQuery(query);	
					
				while(rs2.next())
				{					
					if(rSubdiv!= null && rSubdiv.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("subdivName", rs2.getString(2));
                     subdiv=rs2.getString(1);
					session.setAttribute("subdivCode", rSubdiv);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("subdivCode",rSubdiv);
					}
				}
				rs2.close();
				stmt2.close();
			}
			

%>
			</select>
		</td>
	</tr>
	<tr>
		<td class = btext> 
				<font color=navy><b>Financial Year</b> </font>
		<td class=btext>
			<select name="year"  style="width:150px" class="mycombo"  >
				<option value="-1">SELECT...</option>
<%
				if(rs!=null)rs.close();
				if(stmt!=null)stmt.close();
				stmt = conn.createStatement();
				query = "select distinct fin_year from rws_ddws_scheme_data_port ";
				rs = stmt.executeQuery(query);
				while(rs.next())
				{
					if(fType != null && fType.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(1)%></option>
<%			   
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(1)%></option>
<%
					}
				}	
 %></select></td></tr>
	 <tr bgcolor="#8A9FCD" align="center">
		<td colspan=3 align=center>
			<input type=button  onclick="fnSubmit()" class=btext value="View Report">
		</td>
	</tr>
</table>

</table>


<%}catch(Exception e)  {
      // System.out.println("Exception occured in :"+e);	
}%>

<input type="hidden" name="districtName"/>
<input type="hidden" name="divisionName"/>
<input type="hidden" name="subdivisionName"/>
<!--<input type="hidden" name="panchayatName"/>
<input type="hidden" name="villageName"/>
<input type="hidden" name="habName"/> -->
</body>
</html>