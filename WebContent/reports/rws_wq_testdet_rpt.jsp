<%@ include file="conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@	page import="java.sql.*" %>
<html>

<head>
<title>Report</title>
<link rel="stylesheet" type="text/css" href="style.css"> 

</head>
<body>
<p align=right>
<%
          ResultSet rs1=null;
String circlecode=null,divisioncode=null,subdivisioncode=null, sourcecode=null,circlename=null,divisionname=null,subdivisionname=null,sourcename=null,fromdate=null,
todate=null,ccode=null,sourcetype=null,dcode=null,sdcode=null;
int slno=0;
	  
	 // subdivisioncode=(String)session.getAttribute("subdivCode");
	  //  sourcecode=(String)session.getAttribute("sCode");

		ccode=request.getParameter("ccode");
		circlecode=request.getParameter("circlecode");
		dcode=request.getParameter("dcode");
		divisioncode=request.getParameter("divisioncode");
		sdcode=request.getParameter("sdcode");
		subdivisioncode=request.getParameter("subdivisioncode");
        sourcetype=request.getParameter("sourcetype");
		fromdate=request.getParameter("fromdate");
		//todate=request.getParameter("todate");
		sourcename=request.getParameter("sourcename");
		%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./rws_water_frm.jsp">Back</td> 
				</tr>
			</table>
		</caption>
		
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=11>Water Quality Report&nbsp;During &nbsp;<%=fromdate%>&nbsp;&nbsp;SourceName:<%=sourcename%></td>	
	</tr>
	

		<tr align=center>
		<td class=btext >Sl.No</td>
		<td class=btext >Source Id</td>
		<td class=btext >Habitation</td>
		<td class=btext >Name of Test Conducted</td>
		<td class=btext >Nature Of Test</td>
		<td class=btext >Sample Collect<br> Date</td>
		<td class=btext >Lab Name</td>
		<td class=btext >Lab Location</td>
		<td class=btext >Test Periodicity</td>
	    <td class=btext >Assigned On</td>
		
	</tr>
		
	
<%
        try
		{
		//rws_wq_geologist_test_tbl a,and sc.test_id=a.test_id
	   String str=" ";
	   
         if(ccode!=null && sourcetype!=null && circlecode.equals("00"))
			{
			
	  str="select DISTINCT sc.Source_code,PR.PANCH_NAME,t.test_name, decode(sc.Nature_of_test,'1','Routine','2','Seasonal','3','Quaterly','4','OutBreak'),nvl(to_char(sc.SAMP_COLLECT_DATE,'dd-MON-yyyy'),'-'),l.lab_name,l.location,decode(t.TEST_PERIODCITY,'Y','YEARLY','H','HLFYEARLY','Q','QUARTERLY'), nvl(to_char(sc.assigned_on,'dd-MON-yyyy'),'-'),t.test_code,sc.TEST_ID from rws_water_sample_collect_tbl sc,RWS_CIRCLE_OFFICE_TBL c,rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t,RWS_PANCHAYAT_RAJ_TBL PR where sc.circle_office_code=c.CIRCLE_OFFICE_CODE  and sc.lab_code=l.lab_code and sc.test_code=t.test_code and sc.HAB_CODE = PR.PANCH_CODE and c.circle_office_code='"+ccode+"' and sc.source_type='"+sourcetype+"' AND  to_char(sc.assigned_on,'YYYY')='"+fromdate+"'";
	   
	  
	     ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><a href="./rws_test_history.jsp?testid=<%=rs.getString(11)%>&testCode=<%=rs.getString(10)%>">
			<%=rs.getString(1)%></a></td>
  			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(7)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(9)%></td>
			<%
           
	   }
		   
		rs.close();   
	   }
	else if(dcode!=null && sourcetype!=null && !circlecode.equals("00"))
			{
	   
	   str="select DISTINCT sc.Source_code,PR.PANCH_NAME,t.test_name, decode(sc.Nature_of_test,'1','Routine','2','Seasonal','3','Quaterly','4','OutBreak'),nvl(to_char(sc.SAMP_COLLECT_DATE,'dd-MON-yyyy'),'-'),l.lab_name,l.location,decode(t.TEST_PERIODCITY,'Y','YEARLY','H','HLFYEARLY','Q','QUARTERLY'), nvl(to_char(sc.assigned_on,'dd-MON-yyyy'),'-'),t.test_code,sc.TEST_ID from rws_water_sample_collect_tbl sc,RWS_division_OFFICE_TBL d, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t,RWS_PANCHAYAT_RAJ_TBL PR where d.circle_office_code=sc.CIRCLE_OFFICE_CODE and d.division_office_code=sc.division_OFFICE_CODE and  sc.lab_code=l.lab_code and sc.test_code=t.test_code  and sc.HAB_CODE = PR.PANCH_CODE AND  to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_office_code='"+dcode+"' and sc.source_type='"+sourcetype+"'"; 
    
	    ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><a href="./rws_test_history.jsp?testid=<%=rs.getString(11)%>&testCode=<%=rs.getString(10)%>"><%=rs.getString(1)%></a></td>
  			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(7)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(9)%></td>
			
			</tr>
			<%
	   }
		   
		rs.close();   
	   }
	  else  if(sdcode!=null && sourcetype!=null && !circlecode.equals("00") && !divisioncode.equals("00"))
			{
	          str="select DISTINCT sc.source_code,PR.PANCH_NAME,t.test_name, decode(sc.Nature_of_test,'1','Routine','2','Seasonal','3','Quaterly','4','OutBreak'),nvl(to_char(sc.SAMP_COLLECT_DATE,'dd-MON-yyyy'),'-'),l.lab_name,l.location,decode(t.TEST_PERIODCITY,'Y','YEARLY','H','HLFYEARLY','Q','QUARTERLY'), nvl(to_char(sc.assigned_on,'dd-MON-yyyy'),'-'),t.test_code,sc.TEST_ID from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t,RWS_PANCHAYAT_RAJ_TBL PR where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE and  sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and sc.lab_code=l.lab_code and sc.test_code=t.test_code  and sc.HAB_CODE = PR.PANCH_CODE and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and   sc.subdivision_office_code='"+sdcode+"' and to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  and sc.source_type='"+sourcetype+"'";

            
                ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><a href="./rws_test_history.jsp?testid=<%=rs.getString(11)%>&testCode=<%=rs.getString(10)%>"><%=rs.getString(1)%></a></td>
  			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(7)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(9)%></td>
			
			</tr>
			<%
	   }
		   
		rs.close();   
	   }
	  else  if(sourcetype!=null && !circlecode.equals("00") && !divisioncode.equals("00") && !subdivisioncode.equals("00"))
			{
	          str="select DISTINCT sc.source_code,PR.PANCH_NAME,t.test_name, decode(sc.Nature_of_test,'1','Routine','2','Seasonal','3','Quaterly','4','OutBreak'),nvl(to_char(sc.SAMP_COLLECT_DATE,'dd-MON-yyyy'),'-'),l.lab_name,l.location,decode(t.TEST_PERIODCITY,'Y','YEARLY','H','HLFYEARLY','Q','QUARTERLY'), nvl(to_char(sc.assigned_on,'dd-MON-yyyy'),'-'),t.test_code,sc.TEST_ID from rws_water_sample_collect_tbl sc,RWS_subdivision_OFFICE_TBL sd, rws_water_quality_lab_tbl l, rws_water_quality_test_tbl t,RWS_PANCHAYAT_RAJ_TBL PR where sd.circle_office_code=sc.CIRCLE_OFFICE_CODE and sd.division_office_code=sc.division_OFFICE_CODE and  sd.subdivision_office_code=sc.subdivision_OFFICE_CODE and sc.lab_code=l.lab_code and sc.test_code=t.test_code  and sc.HAB_CODE = PR.PANCH_CODE and sc.CIRCLE_OFFICE_CODE='"+circlecode+"' and sc.division_OFFICE_CODE='"+divisioncode+"' and   sc.subdivision_office_code='"+subdivisioncode+"' and to_char(sc.assigned_on,'YYYY')='"+fromdate+"'  and sc.source_type='"+sourcetype+"'";

			 // and sc.test_id=a.test_id ,rws_wq_geologist_test_tbl a,
                ps=conn.prepareStatement(str);
		 rs=ps.executeQuery();
		 while(rs.next())
	   {
		   %>
		   <tr>     
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue><a href="./rws_test_history.jsp?testid=<%=rs.getString(11)%>&testCode=<%=rs.getString(10)%>"><%=rs.getString(1)%></a></td>
  			<td class=rptValue><%=rs.getString(2)%></td>
			<td class=rptValue><%=rs.getString(3)%></td>
			<td class=rptValue><%=rs.getString(4)%></td>
			<td class=rptValue><%=rs.getString(5)%></td>
			<td class=rptValue><%=rs.getString(6)%></td>
			<td class=rptValue><%=rs.getString(7)%></td>
			<td class=rptValue><%=rs.getString(8)%></td>
			<td class=rptValue><%=rs.getString(9)%></td>
			
			</tr>
			<%
	   }
		   
		rs.close();   
	   }
		if(slno==0)
		{%> <tr align="center">
           <td class=rptHeading colspan=12 ><a href="javascript:window.history.back()"><%="No Records For this Query"%></a></td></tr>
		<% } 
 }
   catch(Exception e)
   {
	    e.printStackTrace();
   }
    finally
	{
	conn.close();
	}
	%>
	</table>

	</body>
	</html>
	<%@ include file = "footer.jsp" %>
