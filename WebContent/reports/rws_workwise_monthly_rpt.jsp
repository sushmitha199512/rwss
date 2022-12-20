<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
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
window.history.forward(1);
function unview()
{
    var a=document.getElementById('combo').value;
	
	if(a=="-1")
	{
       document.getElementById('butview').disabled=true;
	}
	 
}

	function fnSubmit()
{       
	    if(document.f1.FDate.selectedIndex == "0")
		{
			alert("Select Financial Year...");
			return false;
		} 
	    if(document.f1.monthss.selectedIndex == "0")
		{
			alert("Select Month..");
			return false;
		} 
		
			
			document.f1.action="./rws_work_district_status_rpt.jsp";
			document.f1.submit();
	
}
/*function fnMandSubmit()
{
	        
			document.f1.action="./rws_work_district_status_rpt.jsp";
			document.f1.submit();
	
}*/

	

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
<body bgcolor="#edf2f8" onLoad="unview()">

<form name=f1 method="post">
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
				<font color="#FFFFFF">Work Wise Status Report</font>
			</td>	
		</tr>

<%

	String rDist = null;
	String Const=null,consCode=null;
	String fromDate=null;
	
	String FDATE=null;
	String month=null;
	String Month=null;

     try
{%>
<TR> 
	<TD   valign=top  align="center" height="40%" width="30%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>

	<%
	rDist = request.getParameter("district");
	System.out.println("distrrrrrict"+rDist);
	if(rDist == null || rDist.equals("-1"))
	{
		//System.out.println("IN DISTRICT STARTING...");

%>
	<tr>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">All</option>
<%
				session.setAttribute("dCode", null);
				session.setAttribute("dName", rDist);
	}
		
	
	else
		if(rDist != null || rDist.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL...");
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<select name="district" id="combo" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00" SELECTED>All</option>
<% 
				session.setAttribute("dCode",rDist);
				session.setAttribute("dName","ALL");

		
		} 
		else 
			if(!rDist.equals("-1"))  
			{
%>
		<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
		<td class=btext>
			<SELECT name="district" id="combo" class="mycombo" style="width:150px" onChange="this.form.submit()">
				<option value="-1">SELECT...</option>
				<option value="00">ALL</option>
<%
					session.setAttribute("dCode", rDist);
			}
				stmt = conn.createStatement();
				/*query = "SELECT DISTINCT D.DCODE, D.DNAME FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE";*/
				
				rs =stmt.executeQuery("SELECT distinct d.dcode,d.dname from rws_district_tbl d, rws_mon_fin_phy_progress_tbl h where d.dcode=h.dcode order by d.dcode");
				//
				while(rs.next())
				{
					if(rDist != null && rDist.equals(rs.getString(1)))
					{					
%>
				<option value="<%=rs.getString(1)%>" SELECTED><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						session.setAttribute("dName", rs.getString(2));
					}
					else
						{					
%>
				<option value=<%=rs.getString(1)%> ><%=rs.getString(2)%></option>
<%
						session.setAttribute("dCode", rDist);
						}
				}			
					rs.close();			
					stmt.close();

%>
			</select>
		</td>
	</tr>

	<tr>

			<td class = btext nowrap>
				<font color=navy><b>Year</b> </font>
				<font color="red">*</font></td>
			</td>
			<td class = btext >
				<SELECT name="FDate"  class="mycombo" style="width:150px"onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
			<%
					fromDate = request.getParameter("FDate");
			
	// //System.out.println("Rdist   "   +rDist);
    stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	String Query=null;
	if(fromDate!=null && !rDist.equals("00"))
	Query="select distinct FIN_YEAR from rws_mon_fin_phy_progress_tbl where dcode='"+rDist+"'";
	else
    Query="select distinct FIN_YEAR from rws_mon_fin_phy_progress_tbl";
	rs1=stmt1.executeQuery(Query); 
	System.out.println(Query);
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
%>		<option value="<%=rs1.getString(1) %>"><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);	
        session.setAttribute("FDATE",FDATE);
		} 
		System.out.println("fromDate"+FDATE);
	}// END OF While
				rs1.beforeFirst(); %>
			</td>
			</TR>
			
		<tr>

			<td class = btext nowrap>
				<font color=navy><b>Month</b> </font>
				<font color="red">*</font></td>
			</td>
			<td class = btext >
				<SELECT name="monthss"  class="mycombo" style="width:150px"onChange="this.form.submit()">
				<option value="0">SELECT...</option>
			<%
					Month = request.getParameter("monthss");

	         //System.out.println("MONTHHHHHHH  "+ Month);
     stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	
	if(Month!=null && !rDist.equals("00") && !fromDate.equals("0"))
	{
    rs2=stmt2.executeQuery("SELECT distinct month,decode(month,01,'JANUARY',02, 'FEBRUARY',03,'MARCH',04,'APRIL',05,'MAY',06,'JUNE',07,'JULY',08,'AUGUST',09,'SEPTEMBER',10,'OCTOBER',11,'NOVEMBER',12,'DECEMBER') FROM RWS_MON_FIN_PHY_PROGRESS_TBL where dcode='"+rDist+"' and fin_year='"+FDATE+"'");
	}
	else
	{
	rs2=stmt2.executeQuery("SELECT distinct month,decode(month,01,'JANUARY',02, 'FEBRUARY',03,'MARCH',04,'APRIL',05,'MAY',06,'JUNE',07,'JULY',08,'AUGUST',09,'SEPTEMBER',10,'OCTOBER',11,'NOVEMBER',12,'DECEMBER') FROM RWS_MON_FIN_PHY_PROGRESS_TBL where fin_year='"+FDATE+"'");
	}

	while(rs2.next()) 
	{
		//System.out.println("in nex()");
		if(Month != null && Month.equals(rs2.getString(1)) )
		{
%>
		<option value="<%= rs2.getString(1) %>" SELECTed><%= rs2.getString(2) %>
			

<% 			
	 String MONTH=rs2.getString(1);


	session.setAttribute("MONTH",MONTH);
	session.setAttribute("monName", rs2.getString(2));
		}// END OF IF
		else 
		{
%>		<option value="<%= rs2.getString(1) %>" ><%= rs2.getString(2) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
				rs2.beforeFirst(); %>
			</td>
			</TR>
</table>
</TD>
<TD  valign=top height=40% align="center" width="70%">
	
<div  style="position:relative;overflow-y:auto;left:0;height:350;width:100%;top:0;">

		<%@ include file="./rws_workprogress_details.jsp"%>
</div>
<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="100%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#8A9FCD">
			<tr>
					<td width="100%" colspan="2" align="center" class = btext nowrap>
					<A HREF="javascript:checkAll('ch','ck')">checkAll Fields</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

					<A HREF="javascript:clearAll('ch','ck')">clearAll Fields</A>
				</td>
			</tr>	
		</table>
</TD>
<INPUT TYPE="hidden" name="Cons" value="<%=Const%>">

<TR>	
<TD colspan=2 align=center valign=top>	

<% if(rDist!=null && rDist.equals("00") || rDist!=null && !rDist.equals("00") && !rDist.equals("-1")) {%>

<table bordercolor=navy width="40%" border=0 rules=none style="border-collapse:collapse" align = center>
	<tr>

		<td colspan=2 align=center>
		<input type=button onclick="fnSubmit()" id="butview" value="View Report" class = btext></td>
	</tr>
</table>
<%}%>
</TD></TR>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ 
			//e.printStackTrace();
			}
	finally
	{
		conn.close();
	}%>

	