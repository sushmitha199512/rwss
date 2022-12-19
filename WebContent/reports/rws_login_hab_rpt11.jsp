
<%@ include file = "conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
<title> WaterSoft </title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}
</style>
</head>
<body bgcolor="#edf2f8">
<% 
try
{
	
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate1 = new java.util.Date();

String currentYear=null,prevYear=null;
currentYear=dateFormat.format(currentDate1).substring(0,4);
prevYear="01-APR-"+(Integer.parseInt(currentYear)-1);%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" >
			<font color="ffffff">Habitation Coverage Status  Report</font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">	

<tr>
	<td class="btext">Coverage Status</td>
	<td class="btext" >No. of Habitations<br><%="01-APR-"+currentYear%></td>	
	<td class="btext" >No. of Habitations<br><%=prevYear%></td>
	</tr>
<%



	int totalHab = 0, totalAssets= 0, repNo = 0, propNo = 0, newEstNo =0, omEstNo = 0;
	PreparedStatement ps1 = null, ps2 = null, ps3=null, ps4 = null, ps5 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	
	String query = null, query1 = null, query2=null, query3=null, query4 = null, query5=null;
	String[] cstatus = {"FC","PC1", "PC2", "PC3", "PC4", "NC","NSS"};
	String[] assetType = {"01","02","03","04","05"};
////System.out.println("dddddd");

		query="SELECT count(*) as cnt from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl pr where  h.hab_code=pr.panch_code and coverage_status is not null and coverage_status=? and status_date='01-APR-"+currentYear+"'" ;
		query1="SELECT count(*) as cnt from RWS_HABITATION_DIR_HIS_TBL h,rws_panchayat_raj_tbl pr where h.hab_code=pr.panch_code and coverage_status is not null and coverage_status=? and status_date='"+prevYear+"'" ;
		////System.out.println(query);
		ps = conn.prepareStatement(query);
		ps1 = conn.prepareStatement(query1);
	   // System.out.println(query1);
	for (int i =0; i <cstatus.length; i++)
	{
		
			ps.setString(1,cstatus[i]);	
			ps1.setString(1,cstatus[i]);	

		rs = ps.executeQuery();
        rs1 = ps1.executeQuery();
		////System.out.println(query);

		if (rs.next()&& rs1.next())
		{
	  // System.out.println("haihello");
%>
		<tr>
		<%	if(cstatus[i].equals("UI"))
				{ String stus="No Data";	 %>
		<td class="mystyle1"><%= "UI"%></td>
		<%} else { %>
			<td class="mystyle1" ><%=cstatus[i]%></td>
		<%} %>
		<td class="mystyle1"><%=rs.getInt(1)%></td>
		<td class="mystyle1"><%=rs1.getInt(1)%></td>
		<%
			totalHab = totalHab + rs.getInt(1);
			repNo = repNo + rs1.getInt(1);
		%>
		</tr>
<%
		}
	}
	
%>
		<tr><td class="mystyle">Total Habitations</td>
		<td class="mystyle" ><a href="./rws_login_hab_rpt22.jsp?dt=01-APR-<%=currentYear%>"><%=totalHab%></a></td>
		<td class="mystyle" ><a href="./rws_login_hab_rpt22.jsp?dt=<%=prevYear%>"><%=repNo%></a></td>
		</tr>
		</table>
</td>
</tr>

<%
}
catch(Exception e)
{
	//System.out.println(e);
}
	finally
	{
	conn.close();
	}


%>
</table>

<%@ include file = "footer.jsp" %>

