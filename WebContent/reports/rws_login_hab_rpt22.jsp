<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<% String dt=request.getParameter("dt"); 
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy");
java.util.Date currentDate1 = new java.util.Date();

String currentYear=null,prevYear=null;
currentYear=dateFormat.format(currentDate1).substring(0,4);
prevYear="01-APR-"+(Integer.parseInt(currentYear)-1);
%>
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

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">

	<tr bgcolor="lavander">
		<td class="textborder" align="center" >

			<font color="ffffff">Habitation Coverage Status  Report <%=dt%> </font></td>
	</tr>
<tr><td valign=top>
<table border = 1 cellspacing = 0 cellpadding = 0 width=50%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align="center">	

<tr>
	
	<td class="btext">District</td>	
	<td class="btext">FC</td>	
	<td class="btext">PC1</td>	
	<td class="btext">PC2</td>	
	<td class="btext">PC3</td>
	<td class="btext">PC4</td>
	<td class="btext">NC</td>
	<td class="btext">NSS</td>
	
	</tr>
<%
try
{
	
	int totalHab = 0,totalHab1 = 0,totalHab2 = 0,totalHab3 = 0,totalHab4 = 0,totalHab5 = 0,totalHab6 = 0,totalHab7 = 0, totalAssets= 0, repNo = 0, propNo = 0, newEstNo =0, omEstNo = 0;
	PreparedStatement ps1 = null, ps2 = null, ps3=null, ps4 = null, ps5 = null;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
	
	String query = null, query1 = null, query2=null, query3=null, query4 = null, query5=null;
	String[] cstatus = {"FC","PC1", "PC2", "PC3", "PC4", "NC","NSS"};
	String[] assetType = {"01","02","03","04","05"};
	
    
////System.out.println("dddddd");
          if(dt.substring(7,11).equals(currentYear))
	{
	   
        query="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_directory_tbl HD,rws_panchayat_raj_tbl pr where hd.hab_code=pr.panch_code and d.dcode=substr(HD.hab_code,1,2) and hd.coverage_status is not null and coverage_status <> 'UI' and status_date ='"+dt+"'  group by d.dcode,d.dname";
	}
	else
	{
		
		 query="SELECT DISTINCT d.dcode,d.dname,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) as PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) as PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) AS NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) AS NSS from rws_district_tbl d,rws_habitation_dir_his_tbl HD,rws_panchayat_raj_tbl pr where  hd.hab_code=pr.panch_code and d.dcode=substr(HD.hab_code,1,2) and  hd.coverage_status is not null and coverage_status <> 'UI' and status_date ='"+prevYear+"'  group by d.dcode,d.dname";
	}
		//query1="SELECT count(*) as cnt from RWS_HABITATION_DIR_HIS_TBL  h where  coverage_status=? and status_date='01-APR-06'" ;
		////System.out.println(query);
		ps = conn.prepareStatement(query);
		
	
		rs = ps.executeQuery();
       // rs1 = ps1.executeQuery();
		////System.out.println(query);

		while(rs.next())
		{
	   //System.out.println("haihello");
%>
		<tr>
		<td class="mystyle1" ><%=rs.getString(2)%></td>
		<td class="mystyle1" ><%=rs.getInt(3)%></td>
		
		<td class="mystyle1" ><%=rs.getInt(4)%></td>
		<td class="mystyle1" ><%=rs.getInt(5)%></td>
		<td class="mystyle1" ><%=rs.getInt(6)%></td>
		<td class="mystyle1" ><%=rs.getInt(7)%></td>
		<td class="mystyle1" ><%=rs.getInt(8)%></td>
		<td class="mystyle1" ><%=rs.getInt(9)%></td>
		
		<%
			totalHab = totalHab + rs.getInt(3);
		    totalHab1 = totalHab1 + rs.getInt(4);
			totalHab2 = totalHab2 + rs.getInt(5);
			totalHab3 = totalHab3 + rs.getInt(6);
			totalHab4 = totalHab4 + rs.getInt(7);
			totalHab5 = totalHab5 + rs.getInt(8);
			totalHab6 = totalHab6 + rs.getInt(9);
			
			
		%>
		</tr>
<%
		}
	
%>
		<tr><td class="mystyle">Total Habitations</td>
		<td class="mystyle" ><%=totalHab%></td>
		<td class="mystyle" ><%=totalHab1%></td>
		<td class="mystyle" ><%=totalHab2%></td>
		<td class="mystyle" ><%=totalHab3%></td>
		<td class="mystyle" ><%=totalHab4%></td>
		<td class="mystyle" ><%=totalHab5%></td>
		<td class="mystyle" ><%=totalHab6%></td>
		
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

<%
try
{

     session.getAttributeNames();
     session.invalidate();
}
catch (java.lang.Exception isse)
{
    //nic.watersoft.commons.Debug.println("session already invalidated");
}

 %>
