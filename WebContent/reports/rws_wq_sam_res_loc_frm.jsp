<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
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
		if(document.f1.fromdate.selectedIndex == "00")
		{
			alert("SELECT From Date to VIEW REPORT");
			return false;
		}
		if(document.f1.todate.selectedIndex == "00")
		{
			alert("SELECT To Date to VIEW REPORT");
			return false;
		}
		document.f1.action="./rws_wq_sam_res_rpt.jsp";
		document.f1.submit();		
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
		<td align="center" class="mystyle" colspan="4"><font color="navy">Water Quality Status Report</font></td>	
	</tr>
<%	
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
	String fromDate = request.getParameter("fromdate");
	String toDate = request.getParameter("todate");	
	//System.out.println("rDist = "+ rDist);
	//System.out.println("rMand = "+ rMand);
	//System.out.println("rPanch = "+ rPanch);
	//System.out.println("rVillage = "+ rVillage);
	//System.out.println("rHab = "+ rHab);


	if(rDist==null || rDist.equals("00"))
	{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>District</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				
           <!--   <option value="40">ALL</option> -->
<%
	session.setAttribute("dName", null);
	session.setAttribute("dCode", rDist);
	}
	else
	if(rDist != null || rDist.equals("40"))
	{	
%>
		<td class=btext colspan=3 align=center><font color=navy><b>District</b></font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<option value="40" SELECTED>ALL</option>
<%
		session.setAttribute("dCode",rDist);	
	}
		stmt = conn.createStatement();
		rs =stmt.executeQuery("select distinct d.dcode, d.dname from rws_district_tbl d,RWS_WATER_SAMPLE_COLLECT_TBL s where d.dcode=substr(s.hab_code,1,2) order by  d.dname");
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
				String st="select distinct m.mcode,m.mname  from rws_mandal_tbl m, RWS_WATER_SAMPLE_COLLECT_TBL s where m.dcode=substr(s.hab_code,1,2) and m.mcode=substr(s.hab_code,6,2) and substr(s.hab_code,1,2)= '"+rDist+"' order by m.mname";
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
				String st1="select distinct pcode,pname from rws_panchayat_tbl p,rws_water_sample_collect_tbl s where  substr(s.hab_code,1,2)=p.dcode and substr(s.hab_code,6,2)=p.mcode and substr(s.hab_code,1,2)='"+rDist+"' and substr(s.hab_code,6,2)='"+rMand+"' order by pname";
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
				if(rVillage != null && rVillage.equals("777777"))
				{
%>
					<option value="777777" SELECTED>ALL</option>
<%
					session.setAttribute("vName",null);
					session.setAttribute("vCode",rVillage);
				}
				else
					{					
%>
						<option value="777777">ALL</option>
<%
					}

				stmt3 = conn.createStatement();
				String st2="select distinct vcode,vname from rws_village_tbl p,rws_water_sample_collect_tbl s where  substr(s.hab_code,1,2)=p.dcode and substr(s.hab_code,6,2)=p.mcode and  substr(s.hab_code,13,2)=p.pcode and  substr(s.hab_code,1,2)='"+rDist+"' and substr(s.hab_code,6,2)='"+rMand+"'  and  substr(s.hab_code,13,2)='"+rPanch+"' order by vname";
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
					<td class=btext colspan=3 align=center><font color=navy><b>Village</b></font></td>
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
<%
	try 
	{
		if(rDist == null || rDist.equals("00"))
		{	
%>
	<tr>
		<td class=btext colspan=3 align=center><font color=navy><b>Habitation</b> </font></td>
		<td class=btext colspan=3 align=center>
			<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
				<!-- <option value="8888888">ALL</option> -->
<%
		session.setAttribute("hName",null);
		session.setAttribute("hCode","00");
		}
		else
			if(rDist != null && !rDist.equals("00") && !rDist.equals("40"))
			{
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
%>
			<td class=btext colspan=3 align=center><font color=navy><b>Habitation</b> </font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()">
					<option value="00">SELECT...</option>
<%
				if(rHab != null && rHab.equals("8888888"))
				{
%>
				<option value="8888888" SELECTED>ALL</option>
<%
					session.setAttribute("hName",null);
					session.setAttribute("hCode",rHab);
				}
				else
				{
%>
				<option value="8888888">ALL</option>

<%
				}
				stmt4 = conn.createStatement();
				String st3="SELECT DISTINCT pr.panch_code, pr.panch_name FROM RWS_PANCHAYAT_RAJ_TBL pr, RWS_WATER_SAMPLE_COLLECT_TBL sam WHERE sam.hab_code = pr.panch_code AND SUBSTR(sam.hab_code,1,2) = '"+rDist+"' AND SUBSTR(sam.hab_code,6,2) = '"+rMand+"' AND SUBSTR(sam.hab_code,13,2) = '"+rPanch+"' and SUBSTR(sam.hab_code,8,3) = '"+rVillage+"'  ORDER BY pr.panch_code";
				rs4 =stmt4.executeQuery(st3);

				session.setAttribute("hName",null);
				session.setAttribute("hCode",rHab);

					while(rs4.next())
					{
						if(rHab != null && rHab.equals(rs4.getString(1)))
						{
%>
						<option value="<%=rs4.getString(1)%>" SELECTED><%=rs4.getString(2)%></option>
<%
						session.setAttribute("hName",rs4.getString(2));
						session.setAttribute("hCode",rs4.getString(1));
						}
						else
						{
%>
						<option value="<%=rs4.getString(1)%>"><%=rs4.getString(2)%></option>			
<%
						}

					}
				rs4.close();
				stmt4.close();
				
			}
			else
				if(rMand==null || rPanch==null || rVillage==null || rHab==null)
		        {
				%>
				<td class=btext colspan=3 align=center><font color=navy><b>Habitation</b> </font></td>
				<td class=btext colspan=3 align=center>
				<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="00">SELECT...</option>	
			<%
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
				}
				else
				if(rDist.equals("40") || rMand.equals("5555") || rPanch.equals("66666") || rVillage.equals("777777"))
				{
%>
			<td class=btext colspan=3 align=center><font color=navy><b>Habitation</b> </font></td>
			<td class=btext colspan=3 align=center>
				<SELECT name="habitation" style="width:150px" class="mycombo" onChange="this.form.submit()" DISABLED>
					<option value="00">SELECT...</option>	
<%
				session.setAttribute("hName",null);
				session.setAttribute("hCode",null);
				}
	}
	catch(Exception e)
	{
		//System.out.println("THE ERROR IN HABITATION:"+e);
	}
%>
			</select>
		</td>
	</tr>
	
	<tr bgcolor="#8A9FCD" align= center>
		<td class=btext colspan = 4><font color=navy><b>Select Dates</b></font></td>		
	</tr>
	<tr>
		<td class=btext><font color=navy><b>From</b> </font></td>
		<td class=btext>
			<SELECT name="fromdate" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>
<% if (rDist!=null && !rDist.equals("") )
        {
		stmt5 = conn.createStatement();
		//select distinct to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') as samp_date,samp_collect_date from RWS_WATER_SAMPLE_COLLECT_TBL
		String st4="select distinct to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') as samp_date,samp_collect_date from RWS_WATER_SAMPLE_COLLECT_TBL ";
		        if(rDist!=null && !rDist.equals("") && !rDist.equals("-1") && !rDist.equals("00") && !rDist.equals("40"))
                 {
                  st4+=" where substr(source_code,1,2)='"+rDist+"'"; 
				 }
			    if(rMand!=null && !rMand.equals("") && !rMand.equals("-1") && !rMand.equals("00") && !rMand.equals("5555"))
				 {
				   st4+=" and substr(source_code,6,2)='"+rMand+"'";
				 }
			    if(rPanch!=null && !rPanch.equals("") && !rPanch.equals("-1") && !rPanch.equals("00") && !rPanch.equals("66666") )
				 {
				  st4+=" and substr(source_code,13,2)='"+rPanch+"'";
				  }
				  if(rVillage!=null && !rVillage.equals("") && !rVillage.equals("-1") && !rVillage.equals("000") && !rVillage.equals("777777"))
				 {
				  st4+=" and substr(source_code,8,3)='"+rVillage+"'";
				  }
				 if(rHab!=null && !rHab.equals("") && !rHab.equals("-1") && !rHab.equals("00") && !rHab.equals("8888888"))
				 {
				  st4+=" and substr(source_code,0,16)='"+rHab+"'";
				  }
				  st4+=" order by SAMP_COLLECT_DATE desc";
				  //System.out.println("fromdate:"+st4);
		rs5 =stmt5.executeQuery(st4);
		
		while(rs5.next())
		{			
		if(fromDate != null && fromDate.equals(rs5.getString(1)))
			{
%>
			<option value="<%=rs5.getString(1)%>" SELECTED><%=rs5.getString(1)%></option>
<%
			}
			else
			{
%>
			<option value="<%=rs5.getString(1)%>"><%=rs5.getString(1)%></option>
<%
			}
		}
		}
%>
			</select>
		</td>	
		<td class=btext><font color=navy><b>To</b></font></td>
		<td class=btext>
			<SELECT name="todate" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="00">SELECT...</option>

<%
	if(fromDate != null && !fromDate.equals("00"))
	{		
		try
		{			
		stmt6 = conn.createStatement();
		String query1="select distinct to_char(SAMP_COLLECT_DATE, 'dd/MM/yyyy') as samp_date,samp_collect_date from RWS_WATER_SAMPLE_COLLECT_TBL where SAMP_COLLECT_DATE >= to_date('"+fromDate+"', 'dd/MM/yyyy')";	
				  if(rDist!=null && !rDist.equals("") && !rDist.equals("-1") && !rDist.equals("00") && !rDist.equals("40"))
                  {
                  query1+=" and substr(source_code,1,2)='"+rDist+"'"; 
				  }
			      if(rMand!=null && !rMand.equals("") && !rMand.equals("-1") && !rMand.equals("00") && !rMand.equals("5555"))
				  {
				   query1+=" and substr(source_code,6,2)='"+rMand+"'";
				  }
			      if(rPanch!=null && !rPanch.equals("") && !rPanch.equals("-1") && !rPanch.equals("00") && !rPanch.equals("66666") )
				  {
				  query1+=" and substr(source_code,13,2)='"+rPanch+"'";
				  }
				  if(rVillage!=null && !rVillage.equals("") && !rVillage.equals("-1") && !rVillage.equals("000") && !rVillage.equals("777777"))
				  {
				  query1+=" and substr(source_code,8,3)='"+rVillage+"'";
				  }
				  if(rHab!=null && !rHab.equals("") && !rHab.equals("-1") && !rHab.equals("00") && !rHab.equals("8888888"))
				  {
				  query1+=" and substr(source_code,0,16)='"+rHab+"'";
				  }
				  query1+=" order by SAMP_COLLECT_DATE desc";
		//System.out.println("todate:"+query1);
		  rs6 = stmt6.executeQuery(query1);
			while(rs6.next())
			{		
				if(toDate != null && toDate.equals(rs6.getString(1)))
				{
%>
				<option value="<%=rs6.getString(1)%>" SELECTED><%=rs6.getString(1)%></option>
<%
				}
				else
				{
%>
				<option value="<%=rs6.getString(1)%>"><%=rs6.getString(1)%></option>
<%		

				}
			}		
		}	
		catch(Exception e)
		{
			//System.out.println("sri"+e);
		}	
	}
%>
			</select>
		</td>
	</tr>
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