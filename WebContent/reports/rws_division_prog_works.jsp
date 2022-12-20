<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ include file= "/commons/rws_header1.jsp" %>
<%@ include file= "/commons/rws_header2.jsp" %>
<%@ include file= "/reports/conn.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
try{
String qr1,qr2,qr3;
String mdcode,mdname,pcode,pname=null; 
ResultSet rs1=null,rs2=null,rs3=null;
Statement stmt1=null,stmt2,stmt3=null;
mdcode=request.getParameter("mdcode");
mdname=request.getParameter("mdname");
session.setAttribute("pcode",pcode);
session.setAttribute("pname",pname);
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
<%stmt1=conn.createStatement();
qr1="select circle_office_code,division_office_code,division_office_name from rws_division_office_tbl  where circle_office_code||division_office_code=(select distinct susbtr(office_code,2,3) from rws_work_admn_tbl) and substr(work_id,7,2)='"+mdcode+"'"; 
rs1=stmt1.executeQuery(qr1);
while(rs1.next()){
	
}
          


}
catch(Exception e){
	
}
finally{
	
	conn.close();
}


%>
</body>
</html>