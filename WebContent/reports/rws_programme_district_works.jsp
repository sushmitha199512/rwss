<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="/commons/rws_header1.jsp"%>
    <%@ include file="/commons/rws_header2.jsp"%>
    <%@ include file ="/reports/conn.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%String pcode=request.getParameter("pcode");
String pname = request.getParameter("pname");
session.setAttribute("pcode",pcode);
session.setAttribute("pcode",pname);
%>
<table id='tbl' border = 1 align=center cellspacing = 0 cellpadding = 0 rules="rows" width="47%"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=1 rules=none style="border-collapse:collapse" width=100% align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="../home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder" colspan="6">
				                <font color="#FFFFFF">RWSS Grants - Works  Report-- &nbsp;&nbsp;<%=pname%> </font>
			</td>	
		</tr>
		
		<tr align="center" class="gridhdbg">
		    <td class="gridhdbg" align="center"  nowrap> Sl. No &nbsp;&nbsp;</font></td>
			<td class="gridhdbg" align="center"  nowrap> District &nbsp;&nbsp;  </font></td>
			<td class="gridhdbg" align="center"  nowrap> No of Ongoing Works</font></td>
			<td class="gridhdbg" align="center"  nowrap> No of Completed works&nbsp;&nbsp;</font></td>
		</tr>
			

<% try {
  int mtotal=0;
  int mtotcomplete=0;
  ResultSet rs1,rs2,rs3=null;
  Statement stmt1=null,stmt2,stmt3=null;
  String qr1,qr2,qr3;
  String mdcode,mdname=null;
 
  //String pcode = String.valueOf(session.getAttribute("pcode"));
  
  Integer mslno=0;
    
  stmt1=conn.createStatement();
  qr1="select dcode,dname from rws_district_tbl";
  rs1=stmt1.executeQuery(qr1);
  
  
  while(rs1.next())
  {	  
	  mdcode=rs1.getString(1);
	  mdname=rs1.getString(2);
	 
	  Integer mprogcnt=0;
	  
  stmt2=conn.createStatement();
  qr2="select count(*) from rws_work_admn_tbl where  work_id not in (select work_id from  rws_work_completion_tbl) and substr(work_id,1,2)='"+pcode+"' and substr(work_id,7,2)='"+mdcode+"'";
  
  rs2=stmt2.executeQuery(qr2);
  while (rs2.next())
  {
	  mslno=mslno+1; 
	  mprogcnt=rs2.getInt(1);
	  mtotal=mtotal+mprogcnt;
	  %>
	  <tr><td class="btext"><%=mslno %></td>
	      <td class="btext" align="left" ><a href="rws_division_prog_works.jsp?dcode=<%=mdcode%>&mdname=<%=mdname%>"><%=mdname%></a></td>
	      <td class="btext" align=center><%=mprogcnt %></td>
	      
	  
		  <%
  }
  Integer mcompcnt=0;
  stmt3=conn.createStatement();
  qr3="select count(*) from rws_work_admn_tbl where  work_id  in (select work_id from  rws_work_completion_tbl) and substr(work_id,1,2)='"+pcode+"' and substr(work_id,7,2)='"+mdcode+"'";
  rs3=stmt3.executeQuery(qr3);
  while (rs3.next())
  {
	  mslno=mslno+1; 
	  mcompcnt=rs3.getInt(1);
	  mtotcomplete=mtotcomplete+mcompcnt;
	  %>
	      
	      <td class="btext" align=center><%=mcompcnt %></td>
	      	  
	  </tr>
	  <%
  }
  
  
  }
  %>
  <tr>
	<td class="gridhdbg" style="text-align: left;" colspan=2>Total:</td>
	<td class="gridhdbg" style="text-align: Center;"><%=mtotal%></td>
	<td class="gridhdbg" style="text-align: Center;"><%=mtotcomplete%></td>
	
</tr>
<%		  
  }
  catch	(Exception e)
  {
	  e.printStackTrace();
  }
  finally
  {
	  conn.close();  
  }
  
  %>
</body>
</html>