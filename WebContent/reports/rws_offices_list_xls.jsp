<% 
	if(request.getParameter("type") != null && request.getParameter("type").equals("excel")) 
	{
		response.setContentType("application/vnd.ms-excel"); 
	}
%>
<% java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); %>

<%@ include file = "conn.jsp" %>
<html>
<head>
<title> WaterSoft </title>
<link rel="stylesheet" type="text/css" href="../resources/style/rwsstyle.css">
<style>
</style>
</head>
<body bgcolor="#ffffff">

<table border = 0 cellspacing = 0 cellpadding = 0 align = center width=100% style="border-collapse:collapse">
	<tr>
		<td align=center class=reportMainHeading>Offices List Report</td>
	</tr>
	<tr>
		<td align=center class=reportSubHeading>Panchayat Raj Engneering Department</td>
	</tr>
	<tr>
		<td align=center class=reportHeading>Rural Water Supply</td>
	</tr>		
	<tr>
		<td	class=datefont align="right" colspan=4>Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
<%
	String headname = request.getParameter("headname");
	String headcode = request.getParameter("headoffice");
	String circlename = request.getParameter("circlename");
	String circlecode = request.getParameter("circleoffice");
	String divisionname = request.getParameter("divisionname");
	String divisioncode = request.getParameter("divisionoffice");
	String subdivisionname = request.getParameter("subdivisionname");	
	String subdivisioncode = request.getParameter("subdivisionoffice");
	int slno=0;	
	
	//out.println(headcode);
	//out.println(circlecode);
	//out.println(divisioncode);
	//out.println(subdivisioncode);

	if(headcode == null || headcode.equals(""))
		 headcode = "0";
	if(circlecode == null || circlecode.equals(""))
		circlecode = "00";
	if(divisioncode == null || divisioncode.equals(""))
		divisioncode = "0";
	if(subdivisioncode == null || subdivisioncode.equals(""))
		subdivisioncode = "0";

	String officeCode = headcode + circlecode + divisioncode + subdivisioncode;

	//out.println("officeCode in sad: " + officeCode);
	//System.out.println("circleCode = "+circlecode);
	//System.out.println("divisioncode = "+divisioncode);
	//System.out.println("subdivisioncode = "+subdivisioncode);
%>


<table width="21%" border=0 rules=none style="border-collapse:collapse" align = right>
	<tr>
		<td colspan=2 align=right><a href="./rws_offices_list.jsp">Back |</a></td>
		<td colspan=2 align=right><a href="../home.jsp">Home |</a></td>
		<td colspan=2 align=right><a href="rws_offices_list_xls.jsp?type=excel&headname=<%=headname%>&headoffice=<%=headcode%>&circlename=<%=circlename%>&circleoffice=<%=circlecode%>&divisionname=<%=divisionname%>&divisionoffice=<%=divisioncode%>&subdivisionname=<%=subdivisionname%>&subdivisionoffice=<%=subdivisioncode%>">Excel |</a></td>
		<td colspan=2 align=right><a href="./rws_offices_list_print_rep.jsp?headname=<%=headname%>&headoffice=<%=headcode%>&circlename=<%=circlename%>&circleoffice=<%=circlecode%>&divisionname=<%=divisionname%>&divisionoffice=<%=divisioncode%>&subdivisionname=<%=subdivisionname%>&subdivisionoffice=<%=subdivisioncode%>" target="_new">Print</a></td>		
	</tr>
</table>
<br>
<table width="100%" border=0 cellpadding=0 cellspacing=0 rules="none" align=center bgcolor="lavander" style="border-collapse:collapse">
	<tr>
		<% if(headname != null && !headname.equals("")) { %>
			<td	class=myfontclr align=center><font color="#ffffff">Head Office : <%= headname%></td>
		<% } %>
		<% if(circlename != null && !circlename.equals("")) {	%>
			<td	class=myfontclr align=center><font color="#ffffff">Circle Office : <%= circlename%></td>
		<% } %>
		<% if(divisionname != null && !divisionname.equals("")) {	%>
			<td	class=myfontclr align=center><font color="#ffffff">Division Office : <%= divisionname%></td>
		<% } %>
		<% if(subdivisionname != null && !subdivisionname.equals("")) { %>
			<td	class=myfontclr align=center><font color="#ffffff">Sub Division Office : <%= subdivisionname%></td>
		<%	} %>				
	</tr>
</table>
<%
if(!headcode.equals("0") && circlecode.equals("00")) 
{	
	//System.out.println("First");
%>

<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{

			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);
			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' AND "
			+ " substr(office_code,2,2)='"+circlecode+"' and "
			+ " substr(office_code,3,1)='"+divisioncode+"' and "
			+ " substr(office_code,4,1)='"+subdivisioncode+"' and "
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");			
			
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming First");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
	
<%
		}
	}
	catch(Exception e)
	{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
	}
	finally
	{
		conn.close();
	}
}

		else 
		if(!headcode.equals("0") && circlecode.equals("-1")) 
		{
			//System.out.println("Second");
%>
<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{
			slno = 0;
			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' and "
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming Second");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
<%
		}
	}
	catch(Exception e)
		{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
		}
		finally
		{
		conn.close();
		}
		}
	else 
		if(!circlecode.equals("0") && divisioncode.equals("-1")) 
		{
			//System.out.println("Secondgggggggggggggggggggggg");
%>
<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{
			slno = 0;
			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' and "
			+ " substr(office_code,2,2) = '" + circlecode + "' and " 
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming Secondggggggggggggggggggggggggggggggggg");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
<%
		}
	}
	catch(Exception e)
		{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
		}
		finally
		{
		conn.close();
		}
		}
	else 
		if(!divisioncode.equals("0") && subdivisioncode.equals("-1")) 
		{
			//System.out.println("Secondhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
%>
<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{
			slno = 0;
			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' and "
			+ " substr(office_code,2,2) = '" + circlecode + "' and "
			+ " substr(office_code,4,1) = '" + divisioncode + "' and " 
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming Secondhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
<%
		}
	}
	catch(Exception e)
		{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
		}
		finally
		{
		conn.close();
		}
		}
	else 
		if(!circlecode.equals("00") && divisioncode.equals("0") && subdivisioncode.equals("0")) 
		{
			//System.out.println("Third");
%>
<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{
			slno = 0;
			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' and "
			+ " substr(OFFICE_CODE,2,2)='" +circlecode + "' and "
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming Third");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
<%
		}
	}
	catch(Exception e)
		{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
		}
		finally
		{
		conn.close();
		}
		}
	else 
		if(!divisioncode.equals("0") && subdivisioncode.equals("0")) 
		{
			//System.out.println("Fourth");
%>
<table bgcolor="#ffffff" bordercolor= "#8A9FCD" width="100%" border=1 style="border-collapse:collapse" align = center>
	<tr>
		<td align = center class = clrborder>Sl.No</font></td>
		<td align = center class = clrborder>Office</font></td>
		<td align = center class = clrborder colspan=5>Address</font></td>		
		<td align = center class = clrborder>Phone<br>Fax</td>
		<!-- <td align = center class = clrborder>Fax</td> -->
		<td align = center class = clrborder>E-Mail</td>
		<td align = center class = clrborder>Building</td>
		<td align = center class = clrborder>Office Head</td>
		<td align = center class = clrborder>Project</td>
	</tr>
<%
		try
		{
			slno = 0;
			Statement stat = conn.createStatement();
			//System.out.println(headcode +" "+circlecode +" "+divisioncode +" "+subdivisioncode);			
			rs=stat.executeQuery("SELECT "
			+ " OFFICE_CODE, ADDRESS1, ADDRESS2, ADDRESS3, CITY, PINCODE, NVL(PHONE, '---'),"
			+ " NVL(FAX, '---') , NVL(EMAIL, '---') , DECODE(BUILDING, 'O', 'Own', 'R', 'Rented'),"
			+ " HEAD_OF_OFFICE, DECODE(PROJECT, 'P', 'Project', 'R', 'Regular')," 
			+ " RWS_DESIGNATION_TBL.DESIGNATION_NAME, sysdate "
			+ " FROM RWS_OFFICE_TBL, "
			+ " RWS_DESIGNATION_TBL "
			+ " WHERE substr(OFFICE_CODE,1,1)='" + headcode + "' and "
			+ " substr(OFFICE_CODE,2,2)='" +circlecode + "' and "
			+ " substr(office_code,4,1)='" +divisioncode+ "' and " 
			+ " RWS_OFFICE_TBL.HEAD_OF_OFFICE=RWS_DESIGNATION_TBL.DESIGNATION_CODE");
			
		while(rs.next())
			{
			slno++;	
			//System.out.println("Coming Fourth");
%>
	<tr>		
		<td align = center class = reportValue><%=slno%></td>
<%		if(headcode!=null && circlecode.equals("00")){%>
		<td align = center class = reportValue><%=headname%></td>
		<%}else if(circlecode!=null && divisioncode.equals("0")){%>
		<td align = center class = reportValue><%=circlename%></td>
		<%}else if(divisioncode!=null && subdivisioncode.equals("0")){%>
		<td align = center class = reportValue><%=divisionname%></td>
		<%}else{%>
		<td align = center class = reportValue><%=subdivisionname%></td>
		<%}%>
		<td align = left class = reportValue colspan=5><%=rs.getString(2)%><br><%=rs.getString(3)%><br><%=rs.getString(4)%><br><%=rs.getString(5)%><br><%=rs.getString(6)%></td>		
		<td align = center class = reportValue><%=rs.getString(7)%><br><%=rs.getString(8)%></td>		
		<td align = center class = reportValue><%=rs.getString(9)%></td>
		<td align = center class = reportValue><%=rs.getString(10)%></td>
		<td align = center class = reportValue><%=rs.getString(13)%></td>
		<td align = center class = reportValue><%=rs.getString(12)%></td>		
	</tr>
<%
		}
	}
	catch(Exception e)
		{
		//System.out.println("the error is in rws_offices_list_rep.jsp "+e);
		}
		finally
		{
		conn.close();
		}
		}
	
%>	


</table>
