<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%		
	PreparedStatement stmt1 = null,stmt2 = null;
	ResultSet rs1 = null;
	ResultSet rs2 = null;
%>
<html>
<head>
<title>WaterSoft</title>

<script language="JavaScript">


	

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

<form name=f1 action="<%= request.getRequestURI()%>">

<table border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="30%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</a>|<a href="rws_pao_excel.jsp?district=<%=request.getParameter("district")%>" target="_new">Excel</a></td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="2">
				<font color="#FFFFFF">PAO Details </font>
			</td>	
		</tr>
		<%

	String rDist = null;
	String rMand = null;
	String rPanch = null;
	String rVill = null;
     String rHab = null;
	//String distName=null;
	//String mandalName=null;
	//String panchName=null;
	
	
	try
	{
	%>
<TR> 
	<TD   valign=top  align="center" height="40%" width="10%">

<table  bordercolor= navy width="100%" height="100%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr>
		<td class = btext><font color=navy><b>District</b> </font>
		<font color="red">*</font></td>
		
		<td class = btext><SELECT name="district" style="width:150px" class="mycombo" onChange="this.form.submit()">
		<option value="0">SELECT...</option>	
	
<%
			rDist = request.getParameter("district");

			System.out.println("Rdist"+rDist);
			
			

		if (rDist == null || !rDist.equals("-1"))
		{
%>	
		<option value="-1">ALL</option>
<%
		}
	
	 ps=conn.prepareStatement("SELECT distinct d.dcode,d.dname from rws_district_tbl d, RWS_ASSET_MAST_TBL M where d.dCODE = substr(M.hab_code,1,2) order by d.dcode");
	
	 rs=ps.executeQuery();

	
	if (rDist != null && rDist.equals("-1"))
	{
		session.setAttribute("dName","ALL");
		session.setAttribute("dCode",null);	
%>
		<option value="-1" selected>ALL</option>
<%
	}
	while(rs.next())
	{
		
		if(rDist != null && !rDist.equals("-1") && rDist.equals(rs.getString(1)) )
		{
%>
		<option value="<%= rs.getString(1) %>" SELECTed><%= rs.getString(2) %>
<% 			
	session.setAttribute("dName", rs.getString(2));
	session.setAttribute("dCode",rDist);	
	}// END OF IF
	
		else
		{
%>
				<option value="<%= rs.getString(1) %>" ><%= rs.getString(2) %>
<%
		}
		
	}// END OF While
	
	
	%>
		</td></tr>
</table>

</TD></TR>
</TABLE>
<p>&nbsp;</p>
<%if(rDist != null && !rDist.equals("0")){ %>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
	    <td class="btext" >S.NO.</td>
		<td class="btext" >District</td>
		<td class="btext" >PAO/APAO</td>
		<td class="btext" >PAO Code</td>
		<td class="btext" >PAO Name</td>
		<td class="btext" >Address</td>
		<td class="btext" >City</td>
		<td class="btext" >Pin Code</td>
		<td class="btext" >Phone</td>
		<td class="btext" >E-Mail</td>
		<td class="btext" >Fax</td>		
	</tr>
		
	
<%
int slno = 0;
String qry = "";
	if(rDist != null && !rDist.equals("-1"))
	{
		qry  = "select d.dname,decode(p.pao_apao,'P','PAO','A','APAO') as pflag,p.pao_code,nvl(p.pao_name,'-') as pao_name,nvl (p.pao_address1,'-') as pao_address1,nvl (p.pao_city,'-') as pao_city,nvl(p.pao_pin,'-') as pao_pin,nvl(p.pao_phone,'- ') as pao_phone,nvl(p.pao_email,'-') as pao_email,nvl(p.pao_fax,'-') as pao_fax from rws_pao_tbl p, rws_district_tbl d where d.dcode=p.dcode  and p.dcode='"+rDist+"'";
	}
	else
	{
		qry  = "select d.dname,decode(p.pao_apao,'P','PAO','A','APAO') as pflag,p.pao_code,nvl(p.pao_name,'-') as pao_name,nvl (p.pao_address1,'-') as pao_address1,nvl (p.pao_city,'-') as pao_city,nvl(p.pao_pin,'-') as pao_pin,nvl(p.pao_phone,'- ') as pao_phone,nvl(p.pao_email,'-') as pao_email,nvl(p.pao_fax,'-') as pao_fax from rws_pao_tbl p, rws_district_tbl d where d.dcode=p.dcode ";
	}
	//System.out.println("Query:"+qry);
		Statement stt = conn.createStatement();
		ResultSet rep = stt.executeQuery(qry);
		while(rep.next())
		{
			++ slno;
%><tr>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rep.getString("dname")%></td>
		<td class=rptValue><%=rep.getString("pflag")%></td>		
		<td class=rptValue><%=rep.getString("pao_code")%></td>		
		<td class=rptValue><%=rep.getString("pao_name")%></td>				
		<td class=rptValue><%=rep.getString("pao_address1")%></td>				
		<td class=rptValue><%=rep.getString("pao_city")%></td>		
		<td class=rptValue><%=rep.getString("pao_pin")%></td>				
		<td class=rptValue><%=rep.getString("pao_phone")%></td>		
		<td class=rptValue><%=rep.getString("pao_email")%></td>		
		<td class=rptValue><%=rep.getString("pao_fax")%></td>								
		</tr>
		<%}if(slno == 0){
		%>
		<tr>
		<td colspan="11" align="center"><font face="verdana" size="2" color="red">No Records</font></td>
		</tr>
		<%}}%>
</table>
</form>
</body>
</html>
<%@ include file = "footer.jsp" %>
<%} catch(Exception e){ e.printStackTrace();}
	finally
	{
		conn.close();
	}%>