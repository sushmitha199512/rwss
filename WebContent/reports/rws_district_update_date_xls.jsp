<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%

    //System.out.println("*****REPORT BEGINING*****");
	String rDistrict = String.valueOf(session.getAttribute("districtCode"));
	//String dcode=String.valueOf(session.getAttribute("dcode"));
	//String dName = String.valueOf(session.getAttribute("dName"));
	//String updateDate=String.valueOf(session.getAttribute("updateDate"));
	////System.out.println(rDistrict);
	String distname=String.valueOf(session.getAttribute("districtName"));
	//String dcode=null;
	//dcode=  String.valueOf(session.getAttribute("districtCode"));
	//dcode=  request.getParameter("dcode");
	////System.out.println(dcode);
	//int pass=0;
	//String dName = request.getParameter("dName");
	//String updateDate=request.getParameter("updateDate");
	////System.out.println(dName);
	////System.out.println(updateDate);
	
	//String rDistrict, rMandal, rPanchayat, rVillage, rHabitation = null;
	//rDistrict = request.getParameter("rDistrict");
	//rMandal = request.getParameter("rMandal");	
	//String districtName = String.valueOf(session.getAttribute("districtName"));
	//String mandalName = String.valueOf(session.getAttribute("mandalName"));	
	////System.out.println("rDistrict = " +rDistrict);		
	////System.out.println("rMandal = " +rMandal);	
	String query=null,query1=null,query2=null,query3=null,query4=null,query5=null,query6=null,query7=null,query8=null,query9=null,query10=null,query11=null;
	ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null;
	Statement stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null;
	int slno=0, lnno=0, pageno=1, total=0;	
%>
<html>
<head>
<%
try
{
%>
<title>WaterSoft</title>
</head>
<link rel="stylesheet" type="text/css" href="./rwsstyle.css">
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>
	<p align="right" class=dateFont>Page No: <%=pageno%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr align="center">
<td align="center" class="rptHeading" colspan="5">Habitation-UpdateDate-Report</font></td>	
	</tr>
<% 
	if(rDistrict!= null && rDistrict.equals("00"))
		{
			//System.out.println("IN DISTRICT ALL SELECTION LABEL...");
%>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan="5">District: All</font></td>	
	</tr>	
<%
		}
		

	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && distname!=null)
		{
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr  align="center">
		<td align="center" class="rptValue" colspan="5">District: <%=distname%></font></td>	
	</tr>	

	<%
		}
%>
	<tr align=center align=center>
		<td class=btext>Slno</td>
		<td class=btext>District</td>	
		<td class=btext>Habitation Name</td>	
		<td class=btext>Habitation Status</td>
		<td class=btext>Update Date</td>
	 </tr>
<%	
	 if( rDistrict.equals("00"))
	{
       //System.out.println("IN DISTRICT ALL SELECTION...");
		
		query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),nvl(TO_char(hd.update_date,'DD-MON-YYYY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and hd.update_date is null ORDER BY D.DCODE,D.DNAME";
	}
    /*if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate==null)
	{
		//System.out.println("IN DISTRICT ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		

		query="SELECT DISTINCT D.DCODE, D.DNAME, PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and update_date is not null ORDER BY D.DCODE,TO_DATE(update_date,'DD-MON-YYYY')";

		
	}*/
	/*if(dcode != null && dName!=null && rDistrict.equals("00") && updateDate!=null)
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
        query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+dcode+"' and d.dname='"+dName+"' and substr(to_date(hd.update_date,'dd-mon-yyyy'),4,11)='"+updateDate+"' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
	}*/

	if(!rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT SELECTION...");
		query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),nvl(TO_CHAR(update_date,'DD-MON-YYYY'),'-') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' order by d.dcode";
		
	}
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs = stmt.executeQuery(query);
while(rs.next())
	{%>
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%></td>
        <td class=rptValue><%=rs.getString(4)+'-'%><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
	  </tr>
	<% 
	lnno++;
	if(lnno > 45)
		{
		lnno = 1; pageno++;
    %>
</table>
	
	<p style="page-break-before:always"></p>

	
	<p align="center"><b><font face="Verdana" size="2">Habitation-UpdateDate-Report</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>
	<p align="right" class=dateFont>Page No: <%=pageno%></p>
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center  align=center>
		<td class=btext>Slno</td>
		<td class=btext>District</td>	
		<td class=btext>Habitation Name</td>	
		<td class=btext>Habitation Status</td>
		<td class=btext>Update Date</td>
	 </tr>
<%      
		}
		}
	/* rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close();*/
}
catch(Exception e)
{
	//System.out.println("The Error in Planing Format II " + e);
}
%>
</table>
<%
	conn.close();
%>
</form>
</body>
</html>