<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%		try{
	Statement stmt1 = null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;

	Statement st3 = null;
	ResultSet rs3 = null;
	Statement st4 = null;
	ResultSet rs4 = null;
	Statement st5=null;
	 ResultSet rs5=null;
	
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">

function unview()
{
    var a=document.getElementById('date').value;
	alert(a);
	if(a!="0")
	{
       document.getElementById('dist').disabled=true;
	}
	 
}
function fnSubmit()

{	
	if(document.f1.district.selectedIndex=="")
	{
	
		alert("SELECT DISTRICT...");		
		return false;
	}
	/*if(document.f1.FDate.selectedIndex=="")
	{
	
		alert("SELECT Status Date...");		
		return false;
	}*/
	
}
function fnDistSubmit()
	{ 
		document.f1.action="./rws_dist_status_rpt1.jsp";
		document.f1.submit();
		
	}
	function fnMandSubmit()
	{ 
		document.f1.action="./rws_mandal_status_rpt12.jsp";
		document.f1.submit();
		
	}
		function fnPanchSubmit()
	{ 
		document.f1.action="./rws_panch_status_rpt1.jsp";
		document.f1.submit();
		
	}
		function fnPanchOnlySubmit()
	{ 
		document.f1.action="./rws_panch_only_status_rpt.jsp";
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

<form name=f1 method="post" onLoad="unview()">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="32%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Coverage Status Report</font>
			</td>	
		</tr>


<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String Tchart = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String dCode=null;
	String mCode=null;
	String pCode=null;
	String fromDate=null;
	String Fdate=null;
	String toDate=null;
	String TDATE=null;	
	
%>
<TR> 
	<TD   valign=top  align="center" height="30%" width="100%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<% 
	rDist = request.getParameter("district");
	//System.out.println("Rdist   "   +rDist);
	if(rDist==null || rDist.equals("0"))
	{
	%>
		<td class = btext nowrap><font color=navy><b>District</b> </font>
		<font color=red><b>*</b> </font></td></td>
		<td class = btext colspan=3><SELECT name="district"  style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option>
		
<%		session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);
		}
	

	else if(rDist != null && rDist.equals("51"))
	{%>
	<td class = btext><font color=navy><b>District</b> </font>
	<font color=red><b>*</b> </font></td>
	<td class = btext colspan=3><SELECT name="district" id="date" style="width:150px" class="mycombo" onChange="this.form.submit()">
	<option value="0">SELECT...</option>
	<option value="51" SELECTed> ALL</option>
	<% 
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",rDist);

		
	} 
	else if(!rDist.equals("0"))  
	{
	%>
	 <td class = btext><font color=navy><b>District</b> </font>
	 <font color=red><b>*</b> </font></td>
		<td class = btext colspan=3><SELECT name="district" id="date" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>
		<option value="51"> ALL		</option> 
	
	<%	//session.setAttribute("dName",distName);
		session.setAttribute("dCode",rDist);

		
	}
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_hab_static_dir_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  order by  d.dname");

	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
	<% 			
			session.setAttribute("dName",rs.getString(2));
			session.setAttribute("dCode",rDist);


		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%			
		//session.setAttribute("dName",null);
		session.setAttribute("dCode",rDist);

		} 
	}// END OF While
	%>
		
	</SELECT></td>
	</tr>
	<tr>
	<%	try
		{
		rMand = request.getParameter("mandal");
		//System.out.println("mandal name   "   +rMand);
		
			stmt1 = conn.createStatement();
			String st="SELECT  distinct m.mcode,m.mname  from rws_district_tbl d, rws_mandal_tbl m, rws_hab_static_dir_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and substr(h.hab_code,1,2)="+rDist + " order by m.mname";
			rs1 =stmt1.executeQuery(st);
		
		if(rDist == null || rDist.equals("0") ){%>
		<td class = btext><font color="navy"><b>Mandal</b></font></td>
		<td class = btext colspan=3>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
	
	<%
		session.setAttribute("mName",null);
		session.setAttribute("mCode","0");
		}				
		
		else if(rDist != null && !rDist.equals("0") && !rDist.equals("51") && rMand.equals("0") && !rMand.equals("5200"))
		{%>
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	 <option value="5200"> ALL</option> 
			<%
			 while(rs1.next())
			{%> 
				<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	%>

				
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode","0");

				}

		if(rDist != null && !rDist.equals("0") && !rDist.equals("51") && !rMand.equals("0") && !rMand.equals("5200"))
		{%>
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	
		 <option value="5200"> ALL</option> 

		<%	
				//System.out.println("heellllloooo");
				while(rs1.next())
				{
					if(rMand != null && rMand.equals(rs1.getString(1)))
					{
					%>
						<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
						<%
							session.setAttribute("mName",rs1.getString(2));
							session.setAttribute("mCode",rs1.getString(1));

					}// END OF IF
					else
					{
						%>
						<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
						<%	
					}
				}// END OF while
			}// END OF if
			else if(rMand != null && rMand.equals("5200") && !rDist.equals("51") && !rDist.equals("0"))
			{%>

			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		<option value="5200" SELECTed> ALL	</option> 

			<%
				 while(rs1.next())
					{%> 
					<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
				 <% }	%>

				
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode","0");

				}
			
		
			else if(rDist.equals("51"))
			{%>
			
			<td class = btext><font color="navy"><b>Mandal</b></font></td>
			<td class = btext colspan=3>
	<SELECT name="mandal" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
	<option value="0">SELECT...</option>
	<INPUT TYPE="hidden" name="mandal" value="0"> 
						
			<%	session.setAttribute("mName",null);
				session.setAttribute("mCode","0");

				}
			}catch(Exception e){}
			//System.out.println("out of if");
				%>
		
	</SELECT></td>		
		</tr>
	<tr>
<%
		try {
		rPanch = request.getParameter("panchayat");
		
		stmt2 = conn.createStatement();
		String St2=	"select distinct p.pcode,p.pname  from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_hab_static_dir_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode  and substr(h.hab_code,1,2)='"+rDist+ "' and substr(h.hab_code,6,2)='"+rMand+"' order by p.pcode";
		rs2 =stmt2.executeQuery(St2);


		if(rDist == null || rDist.equals("0") ){%>
		<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
	else if((!rDist.equals("51") && !rDist.equals("0")) && (rMand==null || rMand.equals("0"))){%>
		<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
<%	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");

	}
		else if(!rDist.equals("0") && !rDist.equals("51") && !rMand.equals("5200") && rPanch.equals("0")){%>
				<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
<%	
			 while(rs2.next())
					{%> 
					<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				 <% }	

		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");
	
		}

	else if(rMand != null &&  !rMand.equals("5200") && !rMand.equals("0") && !rDist.equals("0") && !rDist.equals("51")  && rPanch.equals("5300") )
	{
		%>
	<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" SELECTed> ALL</option> 
		<% 
			 while(rs2.next())
					{%> 
					<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				 <% }	
		session.setAttribute("pName",null);
		session.setAttribute("pCode","0");
	
		}
		else if(!rDist.equals("0") &&!rDist.equals("51") && !rMand.equals("5200") && !rMand.equals("0")  && !rPanch.equals("5300") && !rPanch.equals("0"))
			{			%>
		<td class = btext><font color="navy"><b>Panchayat</b></font></td>
	<td class = btext colspan=3>
	<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>
		 <option value="5300" > ALL</option> 
			
			<%
				//System.out.println("heellllloooo");
			while(rs2.next())
			{
				if(rPanch != null && rPanch.equals(rs2.getString(1))) 
				{
				%>
				<option value="<%= rs2.getString(1)%>" selected><%= rs2.getString(2) %>
				<%
					session.setAttribute("pName",rs2.getString(2));
					session.setAttribute("pCode",rs2.getString(1));
				}// END OF IF
				else
				{
				%>
				<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
				<%	
				}
			}// END while
			}
	  else if( rMand.equals("5200") || rDist.equals("51"))
		{%>

			<td class = btext nowrap><font color="navy"><b>Panchayat</b></font></td>
			<td class = btext colspan=3>
				<SELECT name="panchayat" disabled style="width:150px" class="mycombo" onchange="this.form.submit()" >
				<option value="0">SELECT...</option>
				<INPUT TYPE="hidden" name="panchayat" value="0"> 
				

<%			session.setAttribute("pName",null);
			session.setAttribute("pCode","0");

	
	}
	
	}catch(Exception e) {
	//System.out.println("Error is  "+e); 
	} 
		
%>
</SELECT></td>

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
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	/*
	select distinct  to_char(status_date,'dd-MON-yyyy') from rws_habitation_dir_his_tbl where to_char(status_date,'yyyy')< to_char(sysDate,'YYYY') and status_date is not null Union select distinct to_char(status_date,'dd-MON-yyyy') from rws_hab_static_dir_tbl where status_date is not null*/
	rs1=stmt1.executeQuery("select distinct to_char(h.status_date,'dd-MON-yyyy'), to_date(h.status_date,'dd-mm-yyyy')from rws_habitation_dir_his_tbl h where h.status_date is not null Union select distinct to_char(h1.status_date,'dd-MON-yyyy'),to_date(h1.status_date,'dd-mm-yyyy') from rws_hab_static_dir_tbl h1 where h1.status_date is not null order by 2 desc");
    
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
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			
		</tr>
	
	</table>
</TD></TR>
<TR>	
<TD colspan=2 align=center valign=top>	

<% 
	if(rDist!=null && !rDist.equals("0") && rDist.equals("51"))

		{
			
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnDistSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<%}else if(rDist!=null && !rDist.equals("0") && !rDist.equals("51") && (rMand.equals("0") || rMand.equals("5200")))
	{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnMandSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%}else if(rDist!=null && !rDist.equals("0") && !rDist.equals("51") && rMand!=null && !rMand.equals("5200") && (rPanch.equals("0") || rPanch.equals("5300")))
	{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnPanchSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
	<% } else if(rDist!=null && !rDist.equals("0") && !rDist.equals("51") && rMand!=null && !rMand.equals("5200") && !rPanch.equals("0") && !rPanch.equals("5300"))
	{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button id="dist" onclick="fnPanchOnlySubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%	} else 
	{
			%>
			<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button  onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%	} 
		
		conn.close();
		} catch(Exception e){	
			e.printStackTrace();
			}
	

		%>
</TD></TR>
</TABLE>
<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td><td class=rptValue nowrap>For <font color=red>District:All</font> option NSS Habitations Details Drilldown is given.</td></tr>
</table>

</form>
</body>
</html>
<%@ include file = "footer.jsp" %>


