<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file ="conn.jsp"%>

<%		try{
	
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	ResultSet rs1 = null;
	Statement stmt3 = null;
	ResultSet rs3 = null;
	//Statement st4 = null;
	//ResultSet rs4 = null;
	//Statement st5=null;
	//ResultSet rs5=null;	
    String query=null;
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
	    if(document.f1.district.value!="" && document.f1.district.value!="-1")
		{
			document.f1.circleName.value = document.f1.district.options[document.f1.district.selectedIndex].text;
		}
		if(document.f1.division.value!="" && document.f1.division.value!="00")
		{
			document.f1.divisionName.value = document.f1.division.options[document.f1.division.selectedIndex].text;
		}
		if(document.f1.subdivision.value!="" && document.f1.subdivision.value!="00")
		{
			document.f1.subdivisionName.value = document.f1.subdivision.options[document.f1.subdivision.selectedIndex].text;
		}
		if(document.f1.mandal.value!="" && document.f1.mandal.value!="00")
		{
			document.f1.mandalName.value = document.f1.mandal.options[document.f1.mandal.selectedIndex].text;
		}
		if(document.f1.district.selectedIndex=="")
		{
	    alert("Please Select Circle...");
		return false;
		}
		else if(document.f1.division.selectedIndex=="")
		{
	    alert("Please Select Division...");
		return false;
		}
		else if(document.f1.mandal.selectedIndex=="")
		{
	    alert("Please Select Mandal...");
		return false;
		}
		else if(document.f1.lab.selectedIndex=="")
		{
	    alert("Please Select Lab...");
		return false;
		}
		else if(document.f1.assetType.selectedIndex=="")
		{
		alert("Please Select SourceType...");		
		return false;
		}
	    else if(document.f1.year.selectedIndex=="")
		{
		alert("Please Select Date...");		
		return false;
		}
		else
		{
			document.f1.action="./rws_wq_test_status.jsp";
			document.f1.submit();
		}
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
				<font color="#FFFFFF">Lab Status Report</font>
			</td>	
		</tr>
<%
	String rDist = null;
	String rDiv = null;
	String rSubdiv = null;
	String aType = null;
	String lab = null;
	String year = null;
	String distName=null;
	String rMand=null;
	
	String aCode = null;
	
	rDist = request.getParameter("district");
	//out.println("district"+rDist);
	rDiv = request.getParameter("division");
	//out.println("mandal"+rDiv);
	rSubdiv = request.getParameter("subdivision");
	//out.println("panchayat"+rSubdiv);
	lab = request.getParameter("lab");
	aType = request.getParameter("assetType");
	////System.out..println("asset"+aType);
	year = request.getParameter("year");
	//out.println("yearrrrr"+year);
	rMand=request.getParameter("mandal");
//	System.out.println("mcode:"+rDiv);
%>

<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">
		<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center  bgcolor="#ffffff">
		
<%
	
	if(rDist == null || rDist.equals("-1"))
	{
		//////System.out..println("IN Circle STARTING...");

%>

	<tr>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
					<!-- <option value="00" SELECTED>All</option>-->
<%
				session.setAttribute("circleCode", null);
				session.setAttribute("circleName", null);
				
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			//////System.out..println("IN DISTRICT ALL...");
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<select name="district" id="circ1" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<!-- <option value="00" SELECTED>All</option>-->
<% 
				session.setAttribute("circleCode",rDist);
                session.setAttribute("circleName","ALL");
				
		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class = btext> 
				<font color=navy><b>Circle</b> </font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="district" id="circ1" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
					<!-- <option value="00" SELECTED>All</option>-->
<%
					session.setAttribute("circleCode",rDist);
			}
				stmt = conn.createStatement();
				
				 query = "SELECT distinct sc.circle_office_code, c.circle_office_name from rws_circle_office_tbl c, rws_water_sample_collect_tbl sc  where c.circle_OFFICE_CODE = sc.circle_OFFICE_CODE  order by sc.circle_OFFICE_code";
              
				 rs = stmt.executeQuery(query);
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
					if(rs!=null){
					rs.close();	}
					if(stmt!=null)
					{stmt.close();}

%>
			</select>
		</td>
	</tr>

<%

	
		if(rDist == null || rDist.equals("-1") || rDist.equals("00"))
		{	
			//////System.out..println("IN division STARTING...");
%>
	<tr>
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
				<font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="division" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled>
				<option value="00">SELECT...</option>
<%
				session.setAttribute("divCode", null);
				session.setAttribute("divName", null);
		}
		else
			if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//////System.out..println("IN division ALL...");
%>			
		<td class = btext nowrap>
				<font color="navy"><b>Division</b></font>
				 <font color=red><b>*</b> </font>
		<td class=btext>
			<SELECT name="division" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!--<option value="-1">SELECT...</option>-->	
				<option value="00">SELECT...</option>
	
<%              
	         session.setAttribute("divName","ALL");
				//if(rDiv != null && rDiv.equals("00"))
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
					 query ="SELECT distinct sc.division_office_code,d.division_OFFICE_NAME FROM RWS_division_OFFICE_TBL d, rws_water_sample_collect_tbl sc  where d.circle_OFFICE_CODE = sc.circle_office_code and sc.division_office_code=d.division_office_code and d.STATUS<>'UI'and d.CIRCLE_OFFICE_CODE= '"+ rDist + "' order by sc.division_OFFICE_code ";

					rs1 = stmt1.executeQuery(query);
					while(rs1.next())
					{
						if(rDiv != null && rDiv.equals(rs1.getString(1)))
						{
%>
				<option value = "<%=rs1.getString(1)%>" SELECTED><%=rs1.getString(2)%></option>
<%
						session.setAttribute("divName",rs1.getString(2));
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
					if(rs1!=null){
					rs1.close();	}
					if(stmt1!=null)
					{stmt1.close();}
			}			
								


%>
			</select>
		</td>
	</tr>
	<tr>
<%

		if(rDist == null || rDist.equals("-1") || rDist.equals("00") || rDiv == null || rDiv.equals("-1") || rDiv.equals("00"))
		{
			//////System.out..println("IN subdivision STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()" disabled >
				<option value="00">SELECT...</option>
<%
				session.setAttribute("subdivName",null);
				session.setAttribute("subdivCode",null);
		}
		
		else if(rDist != null || !rDist.equals("-1") || rDiv != null)
			{
				//////System.out..println("IN subdivision ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Sub Division</b></font></td>
		<td class=btext>
			<SELECT name="subdivision" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<!--<option value="-1">SELECT...</option>-->
				<option value="-1">ALL</option>
<%
					session.setAttribute("subdivName","ALL");
				//if(rSubdiv != null && rSubdiv.equals("00"))
				//{					
%>
				<!--<option value="00" SELECTED>ALL</option>-->

<%
					//session.setAttribute("subdivisionName", null);
					//session.setAttribute("subdivisionCode", rSubdiv);		
				//}
				//else
				//{					
%>
				<!--<option value="00">ALL</option>-->
<%
				//}
				stmt2 = conn.createStatement();
				query = "SELECT distinct sc.subdivision_office_code,sd.subdivision_OFFICE_NAME FROM  rws_water_sample_collect_tbl sc,  RWS_subdivision_OFFICE_TBL sd where sd.circle_office_code=sc.circle_office_code and sd.division_office_code= sc.division_office_code and sd.subdivision_office_code=sc.subdivision_office_code and sd.circle_office_code='"+rDist+"' and sd.division_office_code='"+rDiv+"' order by sc.subdivision_OFFICE_code";
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(rSubdiv != null && rSubdiv.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("subdivName", rs2.getString(2));
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
				if(rs2!=null){
					rs2.close();	}
					if(stmt2!=null)
					{stmt2.close();}
			}

      

%>
			</select>
		</td>
	</tr>

<tr><td nowrap class = btext>
				<font color="navy"><b>Mandal</b></font>
				<font color=red><b>*</b> </font></td>
		<td class=btext>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
			<option value="00">SELECT...</option>
			
<%//System.out.println("rDiv:"+rDiv);

		  if( rDiv!= null  && (!rDiv.equals("00") || !rDiv.equals("-1")))
		{
			  if(rMand!=null && rMand.equals("-1")){%>
			<option value="-1" SELECTED>ALL</option>
		<% 
			  }
			  else
			{
				  %>
			<option value="-1">ALL</option>
				  <%
			}

	stmt3 = conn.createStatement();
       query = "SELECT  M.MCODE ,M.MNAME FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MM WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE  " ;
			if(rDist!=null && !rDist.equals("") && !rDist.equals("-1") && !rDist.equals("00") )
			{
			  query+= " and MM.CIRCLE_OFFICE_CODE='"+ rDist+ "'" ;
			}  
			if(rDiv!=null &&  !rDiv.equals("") && !rDiv.equals("-1") && !rDiv.equals("00"))
			{
			 query+=" AND MM.DIVISION_OFFICE_CODE='"+ rDiv+ "'"; 
			}
			if(rSubdiv!=null &&  !rSubdiv.equals("") && !rSubdiv.equals("-1"))
			{
			  query+= "AND MM.SUBDIVISION_OFFICE_CODE='"+ rSubdiv+ "'"; 
			}
			query+=" ORDER BY M.MNAME";
     //System.out.println("query mandal"+query);
	  rs3=stmt3.executeQuery(query);
	 // System.out.println("www");
	 while(rs3.next())
		 {
		   // System.out.println("rMand:"+rMand);
		 if(rMand != null && rMand.equals(rs3.getString(1)))
					{
           
 //System.out.println("333333333");
		%>
				<option value ="<%=rs3.getString(1)%>" SELECTED><%=rs3.getString(2)%></option>
<%
					session.setAttribute("mandalName", rs3.getString(2));
					session.setAttribute("mandalCode", rMand);
					}
					else
					{
						//System.out.println("1111:"+rs3.getString(1));
					//System.out.println("2222:"+rs3.getString(2));
%>
				<option value = <%=rs3.getString(1)%> ><%=rs3.getString(2)%></option>
<%
					session.setAttribute("mandalCode",rMand);
					}
				}
				if(rs3!=null){
					rs3.close();	}
					if(stmt3!=null)
					{stmt3.close();};
			}

      

%>
			</select>
		</td>
	</tr>
<tr>
<%
	
		if(rDist == null || rDist.equals("-1"))
		{
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Lab</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" id="circ1" style="width:150px" class="mycombo">
				<option value="-1">SELECT...</option>
<%
				session.setAttribute("lbName",null);
				session.setAttribute("lbCode",null);
		}
	
		else if(rDist != null && !rDist.equals("-1") && rDist.equals("00"))
			{
				//out.println("IN dist ALL...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Lab</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(lab!= null && lab.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("lbName","ALL");
					session.setAttribute("lbCode",lab);
					
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct p.lab_code,p.lab_name from rws_water_quality_lab_tbl p,rws_water_sample_collect_tbl sc where p.status <> 'UI' AND sc.lab_code=p.lab_code order by lab_code";
				/* query = " select distinct f.programme_code,p.programme_name wfrom rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(lab != null && lab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("lbName", rs2.getString(2));
					session.setAttribute("lbCode", lab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("lbCode",lab);
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
				<font color="navy"><b>Lab</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="lab" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(lab != null && lab.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("lbName","ALL");
					session.setAttribute("lbCode",lab);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct p.lab_code,p.lab_name from rws_water_quality_lab_tbl p,rws_water_sample_collect_tbl sc where substr(office_code,2,2)='"+rDist+"' and p.status <> 'UI' and  sc.lab_code=p.lab_code order by lab_code";
				/* query = " select distinct f.programme_code,p.programme_name from rws_financial_progress_tbl f,rws_programme_tbl p where p.programme_code=f.programme_code  order by f.programme_code";*/
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					if(lab!= null && lab.equals(rs2.getString(1)))
					{
%>
				<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("lbName", rs2.getString(2));
					session.setAttribute("lbCode", lab);
					}
					else
					{
%>
				<option value = <%=rs2.getString(1)%> ><%=rs2.getString(2)%></option>
<%
					session.setAttribute("lbCode",lab);
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
			//ystem.out.println("IN program STARTING...");
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
				if(aType!= null && aType.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("sName","ALL");
					session.setAttribute("sCode",aType);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 query = "select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc where sc.source_type is not null";
				
				//,rws_source_tbl s where sc.source_code=s.source_code";
				//System.out.println("query"+query);
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{					
					
					
					if(rs2.getString(2)!=null){
						//System.out.println("source type"+rs2.getString(1)+"@"+rs2.getString(2));
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
				<font color="navy"><b>SourceType</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="assetType" style="width:150px" id="circ1" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				
<%
				if(aType != null && aType.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					session.setAttribute("sName","ALL");
					session.setAttribute("sCode",aType);		
				}
				else 
				{					
%>
				<option value="00">ALL</option>
<%
				}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				 /*query = " select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc,rws_source_tbl s where sc.source_code=s.source_code and  sc.circle_office_code='"+rDist+"' AND sc. LAB_CODE='"+lab+"' order by sc.source_type";*/
                 query = " select distinct sc.source_type,decode(sc.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE','0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002','MPWSSURFACE','0301003','MPWSPUMPSETS','0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS','0701001','PONDS','0801001','OTHERS')from rws_water_sample_collect_tbl sc where sc.source_type is not null";
                 // where sc.circle_office_code='"+rDist+"'  
				
				 if(rDist!=null && !rDist.equals("") && !rDist.equals("-1"))
                {
                 query+=" and substr(source_code,1,2)='"+rDist+"'"; 
				}
				 if(rDiv!=null && !rDiv.equals("") && !rDiv.equals("-1") )
				 {
				   query+= " and  division_office_code='"+rDiv+"'";
				  }
				 
				 if(rSubdiv!=null && !rSubdiv.equals("") && !rSubdiv.equals("-1"))
				 {
				   query+=" and subdivision_office_code='"+rSubdiv+"'";
				  }
				  if(rMand!=null && !rMand.equals("") && !rMand.equals("-1"))
				 {
				   query+=" and substr(source_code,6,2)='"+rMand+"'";
				  }
				query+=" order by sc.source_type";
				 // ,rws_source_tbl s where sc.source_code=s.source_code and 
				// System.out.println("query"+query);
				rs2 = stmt2.executeQuery(query);		
				while(rs2.next())
				{				
				
				if(rs2.getString(2)!=null){
					//System.out.println("source type"+rs2.getString(1)+"@"+rs2.getString(2));
				
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
			//ystem.out.println("IN program STARTING...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Financial Year</b></font>
				<font color="red"><b>*</b></font>
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
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="year" style="width:150px" id="circ1" class="mycombo">
				<option value="-1">SELECT...</option>
				<!-- <option value="00">ALL</option> -->
				<!-- <option value="01-Apr-14/31-Mar-15/2014-2015">2014-2015</option>
			<option value="01-Apr-13/31-Mar-14/2013-2014">2013-2014</option>
			<option value="01-Apr-12/31-Mar-13/2012-2013">2012-2013</option>
			<option value="01-Apr-11/31-Mar-12/2011-2012">2011-2012</option>
			<option value="01-Apr-10/31-Mar-11/2010-2011" >2010-2011</option> -->
				
<%--  <%
				if(year!= null && year.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					//session.setAttribute("yrName","ALL");
					session.setAttribute("yrCode",year);		
				}
				else 
				{					
%>
				<option value="00">ALL</option> --%>
<%
				//}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				// query = "select distinct to_char(p.assigned_on,'dd-MON-yyyy') from rws_water_sample_collect_tbl p  order by to_char(p.assigned_on,'dd-MON-yyyy')";
			  query="select distinct to_date(p.assigned_on,'yyyy') from rws_water_sample_collect_tbl p ";
			  if(aType!=null && !aType.equals("") && !aType.equals("00"))
				{
				query+=" where p.source_type='"+ aType +"'";
				}
			  query+=" order by to_char(p.assigned_on,'yyyy') desc"; 
			   //System.out.println("sssss:"+query);
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
					//session.setAttribute("sName", rs2.getString(2));
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
				stmt2.close(); %>
		<%	}
			//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
		else if(rDist != null && !rDist.equals("-1") && !rDist.equals("00"))
			{
				//out.println("IN dist sel...");
%>
		<td nowrap class = btext>
				<font color="navy"><b>Financial Year</b></font>
				<font color="red"><b>*</b></font>
				</td>
		<td class=btext>
			<SELECT name="year" style="width:150px" id="circ1" class="mycombo">
				<option value="-1">SELECT...</option>
				<!-- <option value="00">ALL</option> -->
				<!-- <option value="01-Apr-14/31-Mar-15/2014-2015">2014-2015</option>
			<option value="01-Apr-13/31-Mar-14/2013-2014">2013-2014</option>
			<option value="01-Apr-12/31-Mar-13/2012-2013">2012-2013</option>
			<option value="01-Apr-11/31-Mar-12/2011-2012">2011-2012</option>
			<option value="01-Apr-10/31-Mar-11/2010-2011" >2010-2011</option> -->
 <%-- <%
				if(year != null && year.equals("00"))
				{					
%>
				<option value="00" SELECTED>ALL</option>

<%
					//session.setAttribute("yrName","ALL");
					session.setAttribute("yrCode", year);		
				}
				else 
				{					
%>
				<option value="00">ALL</option> --%>
<%
			//	}
			
               /* ****************************************/
			   
			
				stmt2 = conn.createStatement();
				/* query = " select distinct to_char(p.assigned_on,'dd-MON-yyyy') from rws_water_sample_collect_tbl p where p.circle_office_code='" + rDist +"' AND p. LAB_CODE='"+lab+"' order by to_char(p.assigned_on,'dd-MON-yyyy')";*/

				query = " select distinct to_char(p.assigned_on,'yyyy') from rws_water_sample_collect_tbl p ";
				
				 if(rDist!=null && !rDist.equals("") && !rDist.equals("-1"))
                {
                 query+=" where substr(source_code,1,2)='"+rDist+"'"; 
				}
				 if(rDiv!=null && !rDiv.equals("") && !rDiv.equals("-1") )
				 {
				   query+= " and  division_office_code='"+rDiv+"'";
				  }
				 
				 if(rSubdiv!=null && !rSubdiv.equals("") && !rSubdiv.equals("-1"))
				 {
				   query+=" and subdivision_office_code='"+rSubdiv+"'";
				  }
				  if(rMand!=null && !rMand.equals("") && !rMand.equals("-1"))
				 {
				   query+=" and substr(source_code,6,2)='"+rMand+"'";
				  }
				if(aType!=null && !aType.equals("") && !aType.equals("00"))
				{
				query+=" and p.source_type='"+ aType +"'";
				}
				 query+=" order by to_char(p.assigned_on,'yyyy') desc"; 
				   System.out.println("achuta:"+query); 
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

<!--*********************************************************************************************-->


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
<input type="hidden" name="circleName"/>
<input type="hidden" name="divisionName"/>
<input type="hidden" name="subdivisionName"/>
<input type="hidden" name="mandalName"/>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>

