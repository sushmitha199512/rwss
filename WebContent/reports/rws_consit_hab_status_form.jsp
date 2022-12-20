
<%@ include file = "conn.jsp" %>
<%		try{
	Statement stmt1 = null,s1=null;
	Statement stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null,r1;

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
//<!--
function fnSubmit()
{
	if(document.f1.cons.selectedIndex=="")
			{
			alert("SELECT Constituency....");		
			return false;
			}
	if(document.f1.FDate.selectedIndex!="")
	{		
		document.f1.action="./rws_consit_hab_status_rpt.jsp";
		document.f1.submit();
	}
	
}
	function valSubmit()
	{ 
		alert("Please SELECT District");
	}
//-->
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
<%@ include file = "header_rpt.jsp" %>
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="60%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		<tr>
			<td align="right" class="bwborder">
				Date:<%=fmt.format(new java.util.Date())%>
			</td>
		</tr>
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">Constituency Wise Habitation Status Report</font>
			</td>	
		</tr>

<%
	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String distName=null;
	String mandalName=null;
	String panchName=null;
	String Const=null,consCode=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;	
	
%>
<TR> 
	<TD   valign=top  align="center" height="40%" width="30%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<td class = btext><font color=navy><b>District</b> </font>
		<font color=red><b>*</b> </font></td>
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">

		<option value="0">SELECT...</option>		
<%
	rDist = request.getParameter("district");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt = conn.createStatement();
	rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code order by d.dname");
	
	while(rs.next())
	{
		
		if(rDist != null && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
			

<% 			

		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%		
		} 
	}// END OF While

%>
		</td></tr>
		<tr>
		<td class = btext><font color="navy"><b>Mandal</b></font></td>
		<td class = btext>
		<SELECT name="mandal" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>

<%
	rMand = request.getParameter("mandal");
	// //System.out.println("mandal name   "   +rMand);
		if(rDist != null && !rDist.equals("0"))
		{
		stmt1 = conn.createStatement();
		String st="SELECT distinct m.mcode, m.mname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and d.dcode="+rDist + " order by m.mname";
		rs1 =stmt1.executeQuery(st);
		while(rs1.next())
		{
			if(rMand != null && rMand.equals(rs1.getString(1)))
			{
%>
		<option value="<%= rs1.getString(1)%>" SELECTed><%= rs1.getString(2) %>
		<%
			}// END OF IF
			else
			{
%>
		<option value="<%= rs1.getString(1)%>"><%= rs1.getString(2) %>
		
		
<%	
			}
		}// END OF IF 
		}// END OF While

%>
		</td></tr>
		<tr>
		<td class = btext><font color="navy"><b>Panchayat</b></font></td>
		<td class = btext>
		<SELECT name="panchayat" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>	
<%
	rPanch = request.getParameter("panchayat");

	if(rMand != null && !rMand.equals("0"))
	{
	stmt2 = conn.createStatement();
	String St2="SELECT distinct p.pcode, p.pname from rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_habitation_directory_tbl h where d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code  and m.mcode="+rMand+" and d.dcode="+rDist+" order by p.pname";
	rs2 =stmt2.executeQuery(St2);
		while(rs2.next())
		{
			if(rPanch != null && rPanch.equals(rs2.getString(1))) 
			{

%>
	<option value="<%= rs2.getString(1)%>" SELECTed><%= rs2.getString(2) %>

<%
			}// END OF IF
			else
			{
%>
<option value="<%= rs2.getString(1)%>"><%= rs2.getString(2) %>
<%	
			}
		}// END OF FOR
	}// END OF IF
%>
</SELECT></td>
</tr>
	<tr>
	<td class = btext nowrap><font color="navy"><b>Constituency</b></font>
	<font color=red><b>*</b> </font></td>
		<td class = btext>
		<SELECT name="cons" style="width:150px" class="mycombo" onchange="this.form.submit()" >
		<option value="0">SELECT...</option>

<%
	String	Consti = request.getParameter("cons");
	// //System.out.println("Constituency name   "   +Consti);

		if(rDist != null ){		
		s1 = conn.createStatement();
		String st="SELECT distinct c.CONSTITUENCY_CODE, c.CONSTITUENCY_NAME from rws_CONSTITUENCY_TBL c,rws_habitation_directory_tbl h,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr  where substr(h.hab_code,3,3)=c.CONSTITUENCY_CODE and d.dcode=substr(h.hab_code,1,2) and m.mcode=substr(h.hab_code,6,2) and d.dcode=m.dcode and p.pcode=substr(h.hab_code,13,2) and d.dcode=p.dcode and m.mcode=p.mcode and pr.panch_code=h.hab_code and substr(h.hab_code,1,2)="+rDist+"  order by c.CONSTITUENCY_NAME";

		r1 =s1.executeQuery(st);
		while(r1.next())
		{
			if(Consti != null && Consti.equals(r1.getString(1)))
			{
%>
		<option value="<%= r1.getString(1)%>" SELECTed><%= r1.getString(2) %>

		<%	Const=r1.getString(2);
			consCode=r1.getString(1);	
			session.setAttribute("constiCode",consCode);
			session.setAttribute("constiName",Const);

				// //System.out.println("Constituency name112   "   +Const);
			} // END OF IF
			else
			{
%>
		<option value="<%= r1.getString(1)%>"><%= r1.getString(2) %>
<%		
		}
			
		}// END OF while 
		}
		if(rDist!=null && (Consti.equals("0") || Consti == null)) {
		session.setAttribute("constiCode",null);
		session.setAttribute("constiName",null);
		// //System.out.println("Constituency name222   " );
		}
	
%>
<tr>
			<td class = btext nowrap >
				<font color=navy><b>Status As On</b> </font>
			</td>
			<td class = btext >
				<SELECT name="FDate"  class="mycombo" style="width:150px"onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	//rs1=stmt1.executeQuery("select distinct to_char(status_date,'dd/mm/yyyy') from rws_habitation_directory_tbl "); 
	rs1=stmt1.executeQuery("select distinct to_char(status_date,'dd/mm/yyyy') as status_date1, status_date from rws_habitation_directory_tbl order by status_date"); 
	
	while(rs1.next())
	{
		
		if(fromDate != null && fromDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 FDATE=rs1.getString(1);


	session.setAttribute("FDATE",FDATE);		
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
</TD>
<TD  valign=top height=40% align="center" width="70%">
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
		<tr>
			<td width="100%"  align="center" class = btext nowrap>
				<font color="blue">Habitation Details</font>
			</td>
			</tr>	
		</table>
<div  style="position:relative;overflow-y:auto;left:0;height:220;width:100%;top:0;">
		<%@ include file="./rws_hab_details_form.jsp"%>
		</div>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>
					<td width="100%" colspan="2" align="center" class = btext nowrap>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<A HREF="javascript:clearAll('ch','ck')">clearAll Fields</A>
				</td>
			</tr>	
		</table>
		

</TD>
<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">

<TR>	
<TD colspan=2 align=center valign=top>	

<% if(rDist!=null) {
	String qq1="SELECT dname,dcode FROM RWS_DISTRICT_tbl where dcode="+rDist ;
	st4=conn.createStatement();
	rs4=st4.executeQuery(qq1);
	while(rs4.next())
		distName=rs4.getString(1);

	session.setAttribute("dName",distName);
	session.setAttribute("dCode",rDist);

	
	if(rMand!=null)
		{
	String qq2="SELECT mname FROM RWS_MANDAL_tbl where dcode="+rDist +"and mcode=" +rMand;
	st5=conn.createStatement();
	rs5=st5.executeQuery(qq2);
	while(rs5.next())
		mandalName=rs5.getString(1);
	//out.println("DDDDDDDDDDDDDDDDDDDD"+mandalName);

	session.setAttribute("mCode",rMand);

	session.setAttribute("mName",mandalName);
		}

		if(rPanch!=null)
		{
	String qq3="SELECT pname FROM RWS_panchayat_tbl where mcode="+rMand+" and dcode="+rDist+" and pcode="+rPanch;
	Statement st6=conn.createStatement();
	ResultSet rs6=st5.executeQuery(qq3);
	while(rs6.next())
		panchName=rs6.getString(1);
	//out.println("DDDDpppppppppppppDDDDDD"+panchName);
	session.setAttribute("pName",panchName);
	session.setAttribute("pCode",rPanch);
		}
	%>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<%} else{ %>
<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="valSubmit()" value="View Report" class = btext></td>
	</tr>
</table>
<% } %>
</TD></TR>
</TABLE>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}%>