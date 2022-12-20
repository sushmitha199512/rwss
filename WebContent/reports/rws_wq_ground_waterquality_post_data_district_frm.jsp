<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@page import="nic.watersoft.works.WorksData1" %>
<%
	Statement stmt1 = null;
	ResultSet rs1 = null;
	Statement stmt2 = null;
	ResultSet rs2 = null;
	Statement stmt3 = null;
	ResultSet rs3 = null;
	Statement stmt4 = null;
	ResultSet rs4 = null;
	Statement stmt5 = null;
	ResultSet rs5 = null;
	Statement stmt6 = null;
	ResultSet rs6 = null;
%>

<html>
<head>

<title>WaterSoft</title>
<link rel="stylesheet" type="text/css" href="rwsstyle.css">
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>

<script language="JavaScript">
<!--
	function fnSubmit()
	{
		if(document.f1.district.selectedIndex == "00")
		{
			alert("SELECT District to VIEW REPORT");
			return false;
		}
/*
		if(document.f1.mandal.selectedIndex == "00")
		{
			alert("SELECT Mandal to VIEW REPORT");
			return false;
		}
		if(document.f1.panchayat.selectedIndex == "00")
		{
			alert("SELECT Panchayat to VIEW REPORT");
			return false;
		}


		if(document.f1.village.selectedIndex == "00")
		{
			alert("SELECT Village to VIEW REPORT");
			return false;
		}

		if(document.f1.habitation.selectedIndex == "00")
		{
			alert("SELECT Habitation to VIEW REPORT");
			return false;
		}

		*/
		if(document.f1.year.selectedIndex == "00")
		{
			alert("SELECT Year to VIEW REPORT");
			return false;
		}



		if(document.f1.scheme[1].checked)
		{
			// alert(" water quality");
		document.f1.action="./rws_wq_ground_waterquality_data_district_rpt.jsp";
		document.f1.submit(); 
		}else 
		{
			
			 
			 document.f1.action="./rws_wq_ground_waterquality_post_data_district_rpt.jsp";
			 document.f1.submit(); 
		}
			
	}
//-->
</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows" bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="<rws:context page='/home.jsp'/>">Home</a></td>
				</tr>
			</table>
		</caption>
		
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="mystyle" colspan="4"><font color="navy">Water Quality Pre/Post MonSoon Report</font></td>	
	</tr>
<%	

String q1="",y="",ye="", month="",pmonth="",nmonth="",year="";



java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentDate = new java.util.Date();
String currentMonth = dateFormat.format(currentDate).substring(5,7);
//System.out.println("The Current Month::"+currentMonth);
String premonth=""+(Integer.parseInt(currentMonth)-1);
// System.out.println("The previous Month::"+premonth);
WorksData1 wd = new WorksData1();
int year1 = Integer.parseInt(wd.getServerDate().substring(6,10));

	String rDist = null;
	String distName = null;
	rDist = request.getParameter("district");
	String rMand = null;
	String mandName = null;
	rMand = request.getParameter("mandal");
	String rPanch = null;
	String panchName = null;
	rPanch = request.getParameter("panchayat");
	String rVillage = null;
	String villageName = null;
	rVillage = request.getParameter("village");
	String rHab = null;
	String habName = null;
	rHab = request.getParameter("habitation");
	//String fromDate = request.getParameter("fromdate");
	//String toDate = request.getParameter("todate");	
	//System.out.println("rDist = "+ rDist);
	//System.out.println("rMand = "+ rMand);
	//System.out.println("rPanch = "+ rPanch);
	//System.out.println("rVillage = "+ rVillage);
	//System.out.println("rHab = "+ rHab);

//year= request.getParameter("year");
     year = request.getParameter("year");
		System.out.println("year##@#@#@"+year);
		if(year!=null)
	{
		session.setAttribute("year",year);
		
	}
	


	if(rDist==null || rDist.equals("00"))
	{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<font color="red"><b>*</b></font>
           <!--   <option value="40">ALL</option> -->
<%
	session.setAttribute("dName", null);
	session.setAttribute("dCode", rDist);
	}
	else
	if(rDist != null || rDist.equals("40"))
	{	
%>
		<td class=btext colspan=3 align=center><font color=navy><b>District</b></font><font color="red"><b>*</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<!-- <option value="40" SELECTED>ALL</option> -->
<%
		session.setAttribute("dCode",rDist);	
	}
		stmt = conn.createStatement();
	//	rs =stmt.executeQuery("select distinct d.dcode, d.dname from rws_district_tbl d,RWS_WATER_SAMPLE_COLLECT_TBL s where d.dcode=substr(s.hab_code,1,2) order by  d.dname");
		rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname from rws_district_tbl d where d.dcode<>16  order by d.dname");
	while(rs.next())
			{
				if(rDist != null && rDist.equals(rs.getString(1)))
				{
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>

<%	
				session.setAttribute("dName",rs.getString(2));
				session.setAttribute("dCode",rDist);			
				}
				else
				{
%>
				<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %></option>		
<%
				session.setAttribute("dCode",rDist);

				}
			}
			rs.close();
			stmt.close();
%>
			</select>
		</td>
	</tr>
<%
	try 
	{
		if(rDist == null || rDist.equals("00"))
		{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Mandal</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
<%
			session.setAttribute("mName",null);
			session.setAttribute("mCode",rMand);
		}
		else
			if(rDist != null && !rDist.equals("00") && !rDist.equals("40"))
			{	
%>		
				<td class=btext colspan=3 align=center><font color=navy><b>Mandal</b></font></td>
				<td class=btext colspan=3 align=center>
					<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()">
						<option value="00">SELECT...</option>
<%				
					if(rMand != null && rMand.equals("5555"))
					{
%>
					<option value="5555" SELECTED>ALL</option>
<%
					}
					else
					{
%>
					<option value="5555">ALL</option>
<%
					}
				stmt1 = conn.createStatement();
			//	String st="select distinct m.mcode,m.mname  from rws_mandal_tbl m, RWS_WATER_SAMPLE_COLLECT_TBL s where m.dcode=substr(s.hab_code,1,2) and m.mcode=substr(s.hab_code,6,2) and substr(s.hab_code,1,2)= '"+rDist+"' order by m.mname";
				String st="select mcode,mname from rws_mandal_tbl where dcode='"+rDist+"' order by mname ";
			
			rs1 =stmt1.executeQuery(st);

				while(rs1.next())
				{
					if(rMand != null && rMand.equals(rs1.getString(1)))
					{
%>				
			<option value = <%=rs1.getString(1)%> SELECTED><%=rs1.getString(2)%></option>
<%
				session.setAttribute("mName",rs1.getString(2));
				session.setAttribute("mCode",rMand);
					}
					else
					{
%>

			<option value = <%=rs1.getString(1)%>><%=rs1.getString(2)%></option>

<%	
					}
				}	
				session.setAttribute("mCode",rMand);
				rs1.close();
				stmt1.close();
				
				
			}		
			else
				if(rDist.equals("40") || rMand==null)
				{	
%>
			<td class=btext colspan=3 align=center><font color=navy><b>Mandal</b></font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="mandal" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="00">SELECT...</option>
<%
				}
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN MANDAL:"+e);
	}
%>
			</select>
		</td>
	</tr>
	
<%
	try 
	{
		if(rDist == null || rDist.equals("00"))
		{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Panchayat</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<!-- <option value="66666">ALL</option> -->
<%
		session.setAttribute("pName",null);
		session.setAttribute("pCode","00");
		}
		else
			if(rDist != null && !rDist.equals("00") && rDist.equals("40") || rMand.equals("00"))
			{
			    if(rMand==null || rPanch==null)
				{ %>
					<td class=btext colspan=3 align=center><font color=navy><b>Panchayat</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="00">SELECT...</option>
           <%
				session.setAttribute("pName",null);
				session.setAttribute("pCode",null);
			  }
	         else
           		if(rDist.equals("40") || rMand.equals("5555") || !rDist.equals("00") )
				{		
              %>
					<td class=btext colspan=3 align=center><font color=navy><b>Panchayat</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="00">SELECT...</option>
<%
				session.setAttribute("pName",null);
				session.setAttribute("pCode",null);
				}
			
			}
			else
				if(rDist != null && !rDist.equals("00") && !rDist.equals("40"))
			{
			 
			session.setAttribute("pName",null);
			session.setAttribute("pCode",null);
%>
				<td class=btext colspan=3 align=center><font color=navy><b>Panchayat</b></font></td>
				<td class=btext colspan=3 align=center>
					<SELECT name="panchayat" style="width:150px" class="mycombo" onChange="this.form.submit()">
						<option value="00">SELECT...</option>
<%
						if(rPanch != null && rPanch.equals("66666"))
						{	
%>
						<option value="66666" SELECTED>ALL</option>
<%
					session.setAttribute("pName",null);
					session.setAttribute("pCode",rPanch);	
						}
						else
						{	
%>
						<option value="66666">ALL</option>		
<%
						}

				stmt2 = conn.createStatement();
				//String st1="select distinct pcode,pname from rws_panchayat_tbl p,rws_water_sample_collect_tbl s where  substr(s.hab_code,1,2)=p.dcode and substr(s.hab_code,6,2)=p.mcode and substr(s.hab_code,1,2)='"+rDist+"' and substr(s.hab_code,6,2)='"+rMand+"' order by pname";
			
				String st1=" select pcode,pname from rws_panchayat_tbl where dcode='"+rDist+"' and mcode='"+rMand+"' order by pname ";
				rs2 =stmt2.executeQuery(st1);

				session.setAttribute("pName",null);
				session.setAttribute("pCode",rPanch);

				while(rs2.next())
				{
					if(rPanch != null && rPanch.equals(rs2.getString(1)))
					{
%>				
			<option value ="<%=rs2.getString(1)%>" SELECTED><%=rs2.getString(2)%></option>
<%
					session.setAttribute("pName",rs2.getString(2));
					session.setAttribute("pCode",rs2.getString(1));
					}
					else
					{
%>

			<option value = <%=rs2.getString(1)%>><%=rs2.getString(2)%></option>

<%	
					}
				}			
				rs2.close();
				stmt2.close();
			}
             
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN PANCHAYAT:"+e);
	}
%>
			</select>
		</td>
	</tr>
<%
	try 
	{
		if(rDist == null || rDist.equals("00"))
		{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Village</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="000">SELECT...</option>
<%
		session.setAttribute("vName",null);
		session.setAttribute("vCode","000");
		}		
		else
			if(rDist != null && !rDist.equals("00") && !rDist.equals("40")  )
			{	

			session.setAttribute("vName",null);
			session.setAttribute("vCode",null);
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Village</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="000">SELECT...</option>
<%
			//	if(rVillage != null && rVillage.equals("777777"))
			//	{
%>
					<!-- <option value="777777" SELECTED>ALL</option>-->
<%
				//	session.setAttribute("vName",null);
			//		session.setAttribute("vCode",rVillage);
			//	}
				//else
				//	{					
%>
			<!-- 		<option value="777777">ALL</option>-->
<%
				//	}

				stmt3 = conn.createStatement();
				//String st2="select distinct vcode,vname from rws_village_tbl p,rws_water_sample_collect_tbl s where  substr(s.hab_code,1,2)=p.dcode and substr(s.hab_code,6,2)=p.mcode and  substr(s.hab_code,13,2)=p.pcode and  substr(s.hab_code,1,2)='"+rDist+"' and substr(s.hab_code,6,2)='"+rMand+"'  and  substr(s.hab_code,13,2)='"+rPanch+"' order by vname";
				 String st2="select vcode,vname from rws_village_tbl where dcode='"+rDist+"' and mcode='"+rMand+"' and pcode='"+rPanch+"' order by vname ";
				rs3 =stmt3.executeQuery(st2);

				session.setAttribute("vName",null);
				session.setAttribute("vCode",rVillage);
				
				while(rs3.next())
				{
					if(rVillage != null && rVillage.equals(rs3.getString(1)))
					{
%>

				<option value ="<%=rs3.getString(1)%>" SELECTED><%=rs3.getString(2)%></option>

<%
					session.setAttribute("vName",rs3.getString(2));
					session.setAttribute("vCode",rs3.getString(1));
					
					}
					else
					{
%>
				<option value ="<%=rs3.getString(1)%>" ><%=rs3.getString(2)%></option>
<%
					}
				}
				rs3.close();
				stmt3.close();
			}
			else
				if(rMand==null || rPanch==null || rVillage==null)
		        {
				%>
					<td class=btext colspan=3 align=center><font color=navy><b>Village</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="000">SELECT...</option>
               <%
				session.setAttribute("vName",null);
				session.setAttribute("vCode",null);
				}
                else
 					if(rDist.equals("40") || rMand.equals("5555") || rPanch.equals("66666"))
					{
				%>
					<td class=btext colspan=3 align=center><font color=navy><b>Village</b></font><font color="red"><b>*</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="village" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="000">SELECT...</option>
<%
				session.setAttribute("vName",null);
				session.setAttribute("vCode",null);
				}
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN VILLAGE:"+e);
	}
%>
			</select>
		</td>
	</tr>
	
	
	<!-- ////////////////////////////////////////////////////////////--->
	
	
	<%
	try 
	{
		if(rDist == null || rDist.equals("00"))
		{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Habitations</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="000">SELECT...</option>
<%
		session.setAttribute("hName",null);
		session.setAttribute("hCode","000");
		}		
		else
			if(rDist != null && !rDist.equals("00") && !rDist.equals("40")  )
			{	

			session.setAttribute("hName",null);
			session.setAttribute("hCode",null);
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Habitations</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="000">SELECT...</option>
<%
			//	if(rVillage != null && rVillage.equals("777777"))
			//	{
%>
					<!-- <option value="777777" SELECTED>ALL</option>-->
<%
				//	session.setAttribute("vName",null);
			//		session.setAttribute("vCode",rVillage);
			//	}
				//else
				//	{					
%>
			<!-- 		<option value="777777">ALL</option>-->
<%
				//	}

				stmt3 = conn.createStatement();
				//String st2="SELECT DISTINCT pr.panch_code, pr.panch_name FROM RWS_PANCHAYAT_RAJ_TBL pr, RWS_WATER_SAMPLE_COLLECT_TBL sam WHERE sam.hab_code = pr.panch_code AND SUBSTR(sam.hab_code,1,2) = '"+rDist+"' AND SUBSTR(sam.hab_code,6,2) = '"+rMand+"' AND SUBSTR(sam.hab_code,13,2) = '"+rPanch+"' and SUBSTR(sam.hab_code,8,3) = '"+rVillage+"'  ORDER BY pr.panch_code";
			
				String st2=" select panch_code,panch_name from rws_panchayat_raj_tbl where substr(panch_code,1,2)='"+rDist+"' and substr(panch_code,6,2)='"+rMand+"' and substr(panch_code,13,2)='"+rPanch+"'and substr(panch_code,8,3)='"+rVillage+"' order by panch_name";
				rs3 =stmt3.executeQuery(st2);
                System.out.println("st2*****"+st2);
				session.setAttribute("hName",null);
				session.setAttribute("hCode",rHab);
				
				while(rs3.next())
				{
					if(rHab != null && rHab.equals(rs3.getString(1)))
					{
%>

				<option value ="<%=rs3.getString(1)%>" SELECTED><%=rs3.getString(2)%>-<%=rs3.getString(1)%></option>

<%
					session.setAttribute("hName",rs3.getString(2));
					session.setAttribute("hCode",rs3.getString(1));
					
					}
					else
					{
%>
				<option value ="<%=rs3.getString(1)%>" ><%=rs3.getString(2)%>-<%=rs3.getString(1)%></option>
<%
					}
				}
				rs3.close();
				stmt3.close();
			}
			else
				if(rMand==null || rPanch==null || rVillage==null || rHab==null)
		        {
				%>
					<td class=btext colspan=3 align=center><font color=navy><b>Habitions</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="000">SELECT...</option>
               <%
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
				}
                else
 					if(rDist.equals("40") || rMand.equals("5555") || rPanch.equals("66666"))
					{
				%>
					<td class=btext colspan=3 align=center><font color=navy><b>Habitations</b></font></td>
					<td class=btext colspan=3 align=center>
						<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
							<option value="000">SELECT...</option>
<%
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
				}
				
%>
		<tr>
		<td class=rptLabel>Year&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
		<SELECT name="year" id="combo" class="mycombo" style="width:150px"  >
		<option value="">-Select-</option>
		<%
		
		for(int i=2009;i<=year1;i++)
		{
			String ii =""+i;
			if(request.getParameter("year")!=null && request.getParameter("year").equals(ii)) {
			
				
			%>
		<option value='<%=i%>' selected><%=i%></option>
		<%
		}
		else
		{%>
		<option value='<%=i%>'><%=i%></option>
		<%
		
		}
			
			//session.setAttribute("i",year);
		//	System.out.println("year*********"+i);
			
			//System.out.println("sssss******"+y);
			
			
		
		}	////System.out.println("user22:::"+loggedUser);
		
		
		
		
	
		%>


<td class=rptLabel colspan="2" >
<input type="radio" value="1" name="scheme" checked  onclick="View Report">Post Monsoon
<input type="radio" value="2" name="scheme"  onclick="View Report">Pre Monsoon
 
</td>




		</select>
		</td>
		</tr>
		
		
		
		

		
		<%

		
	}
	

	catch(Exception e)
	{
		//System.out.println("THE ERROR IN VILLAGE:"+e);
	}
%>
			</select>
		</td>
	</tr>
	
	
	
	
	
	
	
	
		<!-- ////////////////////////////////////////////////////////////--->
	
	
	<tr bgcolor="#8A9FCD" align="center">
		<td colspan=4 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext>
		</td>
	</tr>
</table>
<%	
	conn.close();
%>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>