<%@ page import="java.util.*"%>
<%@ include file = "conn3.jsp" %>

<script language="JavaScript">
<!--
	function fnSubmit()
	{
	 if(document.f1.repname.selectedIndex=="")
	{
		alert("SELECT Represented By....");		
		return false;
	}
	else
		{
		document.f1.action="rws_proposal_pendency_rep_rpt.jsp";
		document.f1.submit();
		}
	}
	function valSubmit()
	{ 
		alert("Please SELECT Asset Type");
	}
//-->
</script>
<%@ include file = "header_rpt.jsp" %>
<%	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String rDist = null;
	String mandalName=null,RepName=null,Const=null;
	String repName=null;
	String fromDate=null;
	String FDATE=null;
	String toDate=null;
	String TDATE=null;

	
	ResultSet r1=null;
	
	Statement s1=null,s2=null,s3;
	Statement stmt2 = null;
	Statement st3 = null;
	Statement st4 = null;
	Statement st5=null;

	 rs1 = null;
	ResultSet rs2 = null;
	ResultSet rs3 = null,r2=null,r3;
	ResultSet rs4 = null;
	ResultSet rs5=null;
	%>


<form name=f1 >
	<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width=40%  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right">
		<tr>
			<td  align="right" class="bwborder">
				Date:<%=sdf.format(new java.util.Date())%>
			</td>
		</tr>
			<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td algin="center" class="textborder" colspan="4"><font color="#FFFFFF">Pendency Details Report
			</font></td>	
		</tr>
		
		<tr>
			<td class = btext nowrap >
				<font color=navy><b>Represented By</b> </font>
				<font color=red><b>*</b> </font>
			</td>
			<td class = btext colspan=4>
				<SELECT name="repname" style="width:150px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
				
<%			
			 repName = request.getParameter("repname");
			// //System.out.println("Representative code   "   +repName);
	if(repName!=null && !repName.equals("0"))
	{%>
	<option value="00" SELECTed>ALL </option>	
	<%
	session.setAttribute("repname","ALL");
	session.setAttribute("repcode","00");
	}
	else
	{%>
		<option value="00">ALL</option>	
	<%
	
	}
try
{

	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs =stmt.executeQuery("SELECT distinct r.REP_CODE,r.REP_NAME  from rws_publiC_rep_tbl r, rws_rep_proposal_tbl a where a.rep_code=r.rep_code  order by rep_code ");
	
	while(rs.next())
	{
		
		if(repName != null && repName.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
			

<% 	 RepName=rs.getString(2);
	session.setAttribute("repcode",rs.getString(1));
	session.setAttribute("repname",RepName);
	
		}// END OF IF
		else 
		{
%>		<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%	
		} 

		
	}// END OF While
	/*if(repName.equals("0")|| repName==null)
		{
			session.setAttribute("repname",null);		}*/

	
	%>
</td>
		</tr>
		<tr>
			<td class = btext nowrap >
				<font color=navy><b>From Date</b> </font>
			</td>
			<td class = btext >
				<SELECT name="FDate" style="width:100px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
			<%
					fromDate = request.getParameter("FDate");
	// //System.out.println("Rdist   "   +rDist);


	
	stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	rs1=stmt1.executeQuery("select distinct to_char(PREPARED_ON,'dd/mm/yyyy') as rep_date1 from rws_rep_proposal_tbl order by rep_date1"); 
	
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
			<td class = btext nowrap >
				<font color=navy><b>To Date</b> </font>
			</td>
			<td class = btext >
				<SELECT name="TDate" style="width:100px" class="mycombo" onChange="this.form.submit()">
				<option value="0">SELECT...</option>	
<%
					toDate = request.getParameter("TDate");
	// //System.out.println("Rdist   "   +rDist);

	while(rs1.next())
	{
		
		if(toDate != null && toDate.equals(rs1.getString(1)) )
		{
%>
		<option value="<%= rs1.getString(1) %>" SELECTed><%= rs1.getString(1) %>
			

<% 			
	 TDATE=rs1.getString(1);


	session.setAttribute("TDATE",TDATE);		
		}// END OF IF
		else 
		{
%>		<option value="<%= rs1.getString(1) %>" ><%= rs1.getString(1) %>
<%		//session.setAttribute("dName",null);		
		} 
	}// END OF While
	}
catch(Exception e){}					%>
		</tr>

		<TR>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="01">PWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="02">MPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="03">CPWS</TD>
			<TD class="clrborder"><INPUT TYPE="radio" NAME="assetType" value="04">HANDPUMPS</TD>
		</TR>
	
		<tr>
			<td colspan=4 align=center>
			<input type=button onclick="fnSubmit()" value="View Report" class = btext>
			</td>
		</tr>
	</table>
</form>
<%@ include file = "footer.jsp" %>