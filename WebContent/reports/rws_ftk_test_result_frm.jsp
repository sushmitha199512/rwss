<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%		try{
	
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	ResultSet rs1 = null;
	String div="";
    String subdiv=""; 	
%>
<html>
<head>

<title>WaterSoft</title>
<script language="JavaScript">

/*function unview()
{
    var a=document.getElementById('circ1').value;
	
	if(a=="-1")
	{
       document.getElementById('circ').disabled=true;
	}
	 
}*/

function fnSubmit()
	{   
	    if(document.f1.district.selectedIndex=="")
		{
	    alert("Please Select Circle...");
		return false;
		}
		if(document.f1.assetType.selectedIndex=="")
		{
		alert("Please Select SourceType...");		
		return false;
		}
		/*if(document.f1.year.selectedIndex=="")
		{
		alert("Please Select Test Date...");		
		return false;
		}*/
		
	document.f1.action="./rws_ftk_test_status.jsp";
	document.f1.submit();
	}
</script>
<style>
.mystyle
{
	border-width:1;
	color:#000000;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}

.btext
{
	border-width:1;
	color:#336600;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
	background-color:#ffffff
}
</style>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post" action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Ftk  Sample Status Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rDiv = null;
	String rSubdiv = null;
	String rMand = null;
	String rPanch = null;
	String rHab=null;
	String aType=null;
	String year = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
    String query="";
	rDist = request.getParameter("district");
	rDiv = request.getParameter("division");
	rSubdiv = request.getParameter("subdivision");  
	rMand = request.getParameter("mandal");
	rPanch = request.getParameter("panchayat");
	rHab = request.getParameter("habitation");
	aType = request.getParameter("assetType");
	year =request.getParameter("year");
	
	if(rDist==null)
   {	
 		session.removeAttribute("divName");
		session.removeAttribute("subdivName");
		session.removeAttribute("mandalName");
		session.removeAttribute("panchayatName");
		session.removeAttribute("habName");
		session.removeAttribute("assetType");
		session.removeAttribute("year");
		}
	
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	
	if(rDist == null || rDist.equals("-1"))
	{
		//// System.out.println("IN Circle STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
			
<%
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct c.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_ftk_testing_tbl f where c.circle_office_code=substr(f.source_code,1,2) order by c.circle_office_code";
				rs = stmt.executeQuery(query);
				// System.out.println("distquery: "+query);
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						session.setAttribute("circleName",rs.getString(2));
					   
					}
					else
						{					
%>
						<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("circleCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();

%>
			</select>
		</td>
	</tr>

<%

if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{	
			// System.out.println("IN division STARTING...");
%>
	<tr>
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled>
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("divCode", null);
				session.setAttribute("divName", null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//// System.out.println("IN MANDAL ALL...");
%>			
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
		<td class=btext>
			<SELECT name="division" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
	
<%              
	         session.setAttribute("divCode",rDiv);
				//if(rMand != null && rMand.equals("00"))
				//{
%>
				<!--<option value="00" SELECTED>ALL</option>-->
<%
				//}
				//else
					//{
%>
				<!--<option value="00">ALL</option>-->
<%
					//}
					stmt1 = conn.createStatement();
					query ="select distinct d.division_office_code,d.division_office_name from rws_division_office_tbl d, rws_ftk_testing_tbl f where substr(f.source_code,1,2) =d.circle_office_code   and d.division_office_code=f.division_office_code and d.STATUS<>'UI' and substr(f.source_code,1,2)='"+rDist+"' order by d.division_office_code";
					// System.out.println("div:"+query);
					rs1 = stmt1.executeQuery(query);
					while(rs1.next())
					{
					   //// System.out.println("rMand"+rMand);
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
	  
<%  
		
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{
			// System.out.println("IN subdivision STARTING...");
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
		
		else if(rDist != null || !rDist.equals("-1"))
			{
				//// System.out.println("IN PANCHAYAT ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
                // // System.out.println("111111111111");
					session.setAttribute("subdivCode",rSubdiv);
				//if(rPanch != null && rPanch.equals("00"))
				//{					
%>
				<!--<option value="00" SELECTED>ALL</option>-->

<%
					//session.setAttribute("panchayatName", null);
					//session.setAttribute("panchayatCode", rPanch);		
				//}
				//else
				//{					
%>
				<!--<option value="00">ALL</option>-->
<%
				//}
                 //div=(String)session.getAttribute("divcode");
				//  // System.out.println("division"+div);
				stmt2 = conn.createStatement();
				query = "select distinct sd.subdivision_office_code,sd.subdivision_office_name from rws_subdivision_office_tbl sd, rws_ftk_testing_tbl f where sd.subdivision_office_code=f.subdivision_office_code and substr(f.source_code,1,2)=sd.circle_office_code and f.division_office_code=sd.division_office_code and  substr(f.source_code,1,2)='"+rDist+"' and" 
							+" f.division_office_code='"+div+"' order by sd.subdivision_office_code";
				// System.out.println("subdiv:"+query);
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
<%
    
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{
			//// System.out.println("IN subdivision STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Mandal</b></font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("mandalName",null);
				session.setAttribute("mandalCode",null);
		}
		
		else if(rDist != null || !rDist.equals("-1"))
			{
				
%>
		<td nowrap class = btext>
				<font color="navy"><b>Mandal</b></font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
					session.setAttribute("mandalName","SELECT");
				//if(rPanch != null && rPanch.equals("00"))
				//{					
%>
				<!--<option value="00" SELECTED>ALL</option>-->

<%
					//session.setAttribute("panchayatName", null);
					//session.setAttribute("panchayatCode", rPanch);		
				//}
				//else
				//{					
%>
				<!--<option value="00">ALL</option>-->
<%
				//}
				stmt2 = conn.createStatement();
				//query = "select distinct r.mcode,r.mname from rws_mandal_tbl r, rws_ftk_testing_tbl f where  r.dcode=substr (f.source_code,1,2) and  r.mcode=substr (f.source_code,6,2) and substr(f.source_code,1,2)='"+rDist+"' and f.division_office_code='"+div+"'  and f.subdivision_office_code='"+subdiv+"'";
				query="select distinct  r.mcode,r.mname from rws_mandal_tbl r, rws_ftk_testing_tbl f ,rws_mandal_subdivision_tbl md where  r.dcode=substr (f.source_code,1,2) and  r.mcode=substr (f.source_code,6,2) and r.mcode=md.mcode and r.dcode=md.circle_office_code and md.circle_office_code=substr (f.source_code,1,2) and md.division_office_code= f.division_office_code and md.subdivision_office_code=f.subdivision_office_code and   substr(f.source_code,1,2)='"+rDist+"' and f.division_office_code='"+div+"'   and f.subdivision_office_code='"+subdiv+"'";
				
				 // System.out.println("mandal query:"+query); 
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rMand != null && rMand.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("mandalName", rs2.getString(2));
					session.setAttribute("mandalCode", rMand);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("mandalCode",rMand);
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
<%
   
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{
			//// System.out.println("IN subdivision STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Panchayat</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("panchayatName",null);
				session.setAttribute("panchayatCode",null);
		}
		
		else if(rDist != null || !rDist.equals("-1"))
			{
				//// System.out.println("IN PANCHAYAT ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Panchayat</b></font></td>
		<td class=btext>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
			
<%
					session.setAttribute("panchayatName","SELECT");
				//if(rPanch != null && rPanch.equals("00"))
				//{					
%>
				<!--<option value="00" SELECTED>ALL</option>-->

<%
					//session.setAttribute("panchayatName", null);
					//session.setAttribute("panchayatCode", rPanch);		
				//}
				//else
				//{					
%>
				<!--<option value="00">ALL</option>-->
<%
				//}
				stmt2 = conn.createStatement();
				query = "select distinct p.pcode,pname from rws_panchayat_tbl p,rws_ftk_testing_tbl f where p.dcode=substr(f.source_code,1,2) and p.mcode=substr(f.source_code,6,2) and p.pcode=substr(f.source_code,13,2) and  substr(f.source_code,1,2)='"+rDist+"' and f.division_office_code='"+div+"' and f.subdivision_office_code='"+subdiv+"' and  substr(f.source_code,6,2)='"+rMand+"'";
				rs2 = stmt2.executeQuery(query);
				// System.out.println("qyery in Panch:"+query);		
				while(rs2.next())
				{					
					if(rPanch != null && rPanch.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("panchayatName", rs2.getString(2));
					session.setAttribute("panchayatCode", rPanch);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("panchayatCode",rPanch);
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
<%
   
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{
			
%>
		<td nowrap class = btext>
				<font color="navy"><b>Habitation</b></font></td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("habtName",null);
				session.setAttribute("habCode",null);
		}
		
		else if(rDist != null || !rDist.equals("-1"))
			{
			
%>
		<td nowrap class = btext>
				<font color="navy"><b>Habitation</b></font></td>
		<td class=btext>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
			
<%
					session.setAttribute("habName","SELECT");
	
				stmt2 = conn.createStatement();
				query = "select distinct p.panch_code,p.panch_name from rws_panchayat_raj_tbl p, rws_ftk_testing_tbl f where p.panch_code=substr(f.source_code,0,16) and  substr(f.source_code,1,2)='"+rDist+"' and f.division_office_code='"+div+"' and f.subdivision_office_code='"+subdiv+"' and  substr(f.source_code,6,2)='"+rMand+"' and substr(f.source_code,13,2)='"+rPanch+"'";
				rs2 = stmt2.executeQuery(query);
				// System.out.println("qyery in Hab:"+query);		
				while(rs2.next())
				{					
					if(rHab != null && rHab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("habName", rs2.getString(2));
					session.setAttribute("habCode", rHab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("habCode",rHab);
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
	<%
	if(rDist == null || rDist.equals("-1"))
		{
			
%>
		<td nowrap class = btext>
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("sName",null);
				session.setAttribute("sCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("00"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
			   
			
				stmt2 = conn.createStatement();
				query = "select distinct f.source_type,decode(f.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS') from rws_ftk_testing_tbl f where decode(f.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS') is not null";
				//System.out.println("src:"+query);
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(aType!= null && aType.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sName", rs2.getString(2));
					session.setAttribute("sCode", aType);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sCode",aType);
					}
				}
				rs2.close();
				stmt2.close();
			}
			
		else if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//out.println("IN dist sel...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
			
				stmt2 = conn.createStatement();
				 
                 query = "select distinct f.source_type,decode(f.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS') from rws_ftk_testing_tbl f where decode(f.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS') is not null"; 
                 
                 if(rDist!=null && !rDist.equals("") && !rDist.equals("-1"))
                {
                 query+=" and substr(source_code,1,2)='"+rDist+"'"; 
				}
				if(div!=null && !div.equals("") && !div.equals("-1"))
				{	
				 query+= " and  division_office_code='"+div+"'";
				  }
			    if(subdiv!=null && !subdiv.equals("") && !subdiv.equals("-1") )
			  	 {
				  query+=" and subdivision_office_code='"+subdiv+"'";
				 } 
				 if(rMand!=null && !rMand.equals("") && !rMand.equals("-1") )
				 {
				   query+=" and substr(source_code,6,2)='"+rMand+"'";
				 }
				 if(rPanch!=null && !rPanch.equals("") && !rPanch.equals("-1"))
				 {
				  query+=" and substr(source_code,13,2)='"+rPanch+"'";
				  }
				 if(rHab!=null && !rHab.equals("") && !rHab.equals("-1"))
				 {
				  query+="and substr(source_code,0,16)='"+rHab+"'";
				  }
                 
                 query+=" order by f.source_type";
				//System.out.println("src1:"+query);
				 // ,rws_source_tbl s where sc.source_code=s.source_code and 
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(aType != null && aType.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sName", rs2.getString(2));
					session.setAttribute("sCode", aType);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("sCode",aType);
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
	
	
		<tr>
<%
		
	
		if(rDist == null || rDist.equals("-1"))
		{
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Financial Year</b></font>
				
				</td>
		<td class=btext>
			<SELECT name="year" id="circ1" style="width:150px" class="mycombo">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("yrName",null);
				session.setAttribute("yrCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("00"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Financial Year</b></font>
				
				</td>
		<td class=btext>
			<SELECT name="year" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%	
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				query = "select distinct to_char(f.test_date,'yyyy') from rws_ftk_testing_tbl f  order by to_char(f.test_date,'yyyy') desc";
				// System.out.println("Date qry"+query);
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{		int year1=Integer.parseInt(rs2.getString(1));
				
				   int year2=year1+1;
				   int y1=Integer.parseInt(rs2.getString(1).substring(2,4));
				   int y2=y1+1;
				   //System.out.println(y1+"@"+y2);
				if(year!= null && year.equals(rs2.getString(1)))
				{
%>
			<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>" SELECTED><%= year1 %>-<%= year2 %> 
			
<%
					session.setAttribute("yrName", rs2.getString(1));
					session.setAttribute("yrCode", year);
					}
					else
					{
%>
				<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>"><%= year1 %>-<%= year2 %>
<%
					session.setAttribute("yrCode",year);
					}
				}
				rs2.close();
				stmt2.close();
			}
			//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		else if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//out.println("IN dist sel...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Financial Year</b></font>
				
				</td>
		<td class=btext>
			<SELECT name="year" style="width:150px" id="circ1" class="mycombo">
				<option value="-1">SELECT...</option>
				
<%			stmt2 = conn.createStatement();
				/* query = " select distinct to_char(p.assigned_on,'dd-MON-yyyy') from rws_water_sample_collect_tbl p where p.circle_office_code='" + rDist +"' AND p. LAB_CODE='"+lab+"' order by to_char(p.assigned_on,'dd-MON-yyyy')";*/

				//query = " select distinct to_char(f.test_date,'dd-MON-yyyy') from rws_ftk_testing_tbl f where substr(f.source_code,1,2)='" + rDist +"' order by to_char(f.test_date,'dd-MON-yyyy')";
                
                query="select distinct to_char(test_date,'yyyy') as a1 from rws_ftk_testing_tbl" ;
               
                if(rDist!=null && !rDist.equals("") && !rDist.equals("-1"))
                {
                 query+= " where substr(source_code,1,2)='"+rDist+"' and source_type='"+aType+"'"; 
				}
				if(div!=null && !div.equals("") && !div.equals("-1"))
				{	
				 query+= " and  division_office_code='"+div+"'";
				  }
			    if(subdiv!=null && !subdiv.equals("") && !subdiv.equals("-1") )
			  	 {
				  query+=" and subdivision_office_code='"+subdiv+"'";
				 } 
				 if(rMand!=null && !rMand.equals("") && !rMand.equals("-1") )
				 {
				   query+=" and substr(source_code,6,2)='"+rMand+"'";
				 }
				 if(rPanch!=null && !rPanch.equals("") && !rPanch.equals("-1"))
				 {
				  query+=" and substr(source_code,13,2)='"+rPanch+"'";
				  }
				 if(rHab!=null && !rHab.equals("") && !rHab.equals("-1"))
				 {
				  query+="and substr(source_code,0,16)='"+rHab+"'";
				  }
				  if(aType!=null && !aType.equals("") && !aType.equals("-1") && year!=null && !year.equals("")&& !year.equals("-1"))
				  {
				   query+=" and source_type='"+aType+"' and test_date is not null ";
				  }
				  query+=" order by to_char(test_date,'yyyy') desc";
				// System.out.println("date1" +query); 
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{			
					int year1=Integer.parseInt(rs2.getString(1));
					
					
					   int year2=year1+1;
					   int y1=Integer.parseInt(rs2.getString(1).substring(2,4));
					   int y2=y1+1;
					   //System.out.println(y1+"@"+y2);
					if(year!= null && year.equals(rs2.getString(1)))
					{
	%>
				<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>" SELECTED><%= year1 %>-<%= year2 %> 
				
<%
					session.setAttribute("yrName", rs2.getString(1));
					session.setAttribute("yrCode", year);
					}
					else
					{
%>
				<option value="01-Apr-<%= y1%>/31-Mar-<%= y2%>/<%= year1 %>-<%= year2 %>"><%= year1 %>-<%= year2 %>
<%
					session.setAttribute("yrCode",year);
					}
				}
				rs2.close();
				stmt2.close();
			}
    
%>
			</select>
		</td>
	</tr>
	
	

	</table>
</TD>
	<TR>
<TD colspan=2 align=center valign=top>
	<% /*if(rDist!=null && rDist.equals("00")) {*/
//if(rDist!=null && !rDist.equals("-1") && rDist.equals("00"))
	//{
	
%>

	<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>
		<td colspan=2 align=center>
			<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
	

</table>
<%//}
//if(rDist!=null && !rDist.equals("-1") && rProg!=null && rProg.equals("-1") && rsProg!=null && //rsProg.equals("-1")) {*/
	
	 %>
	<!--<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = 	center>
		<tr>
			<td colspan=2 align=center>
				<input type=button id="circ" onclick="fnSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>-->
<% //} 

 } catch(Exception e){ 
	 e.printStackTrace();
	 }
 finally
	{
 conn.close(); 
	}
 %>
</TD>
</TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>



