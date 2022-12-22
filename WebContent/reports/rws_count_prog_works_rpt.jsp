<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<style>
.mystyle
{
  margin: 0;
  padding: 0;
  height: 100%;
    background-color: #434343;
    background-image:linear-gradient(#434343, #282828);
}
#content{
    background-color: transparent;
    background-image:       linear-gradient(0deg, transparent 24%, rgba(255, 255, 255, .05) 25%, rgba(255, 255, 255, .05) 26%, transparent 27%, transparent 74%, rgba(255, 255, 255, .05) 75%, rgba(255, 255, 255, .05) 76%, transparent 77%, transparent), linear-gradient(90deg, transparent 24%, rgba(255, 255, 255, .05) 25%, rgba(255, 255, 255, .05) 26%, transparent 27%, transparent 74%, rgba(255, 255, 255, .05) 75%, rgba(255, 255, 255, .05) 76%, transparent 77%, transparent);
  height:100%;
  background-size:50px 50px;
}

.follow-me {
  position:absolute;
  bottom:10px;
  right:10px;
  text-decoration: none;
  color: #FFFFFF;
}
</style>
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
				                <font color="#FFFFFF">RWSS Grants - Works  Report </font>
			</td>	
		</tr>
		
		<tr align="center" class="gridhdbg">
		    <td class="gridhdbg" align="center"  nowrap> Sl. No &nbsp;&nbsp;</font></td>
			<td class="gridhdbg" align="center"  nowrap> Programme Code &nbsp;&nbsp;  </font></td>
			<td class="gridhdbg" align="center"  nowrap> Programme Name&nbsp;&nbsp; </font></td>
			<td class="gridhdbg" align="center"  nowrap> NRDWP Related &nbsp;&nbsp;</font></td>
			<td class="gridhdbg" align="center"  nowrap> No of Completed works&nbsp;&nbsp;</font></td>
			<td class="gridhdbg" align="center"  nowrap> No of Ongoing Works</font></td>
		</tr>
			
		
		
<%
try {
String pcode;
String pname;
String nrdwp;
Integer slno =0;
Integer ongoingcount =0;
Integer completedcount=0;
Statement stmt1,stmt2,stmt3 = null;
ResultSet rs1,rs2,rs3 = null;
String query1,query2,query3;

stmt1 = conn.createStatement();
query1="select * from rws_programme_tbl order by programme_code";

rs1=stmt1.executeQuery(query1);
while(rs1.next())
{
		pcode=rs1.getString(1);
		pname=rs1.getString(2);
		nrdwp=rs1.getString("nrdwp_related");
		slno=++slno;
		
		if (nrdwp.equals("Y"))
		{
			nrdwp="YES";
		}
		else
		{
			nrdwp="--";	
		}
		
		
		%>
		<tr>
		     	    
		<td class="gridhdbg2" ><%=slno%></td>
		<td class="gridhdbg2" ><%=pcode%></td>		
	    <td class="gridhdbg2" align="left" ><a href="rws_programme_district_works.jsp?pcode=<%=pcode%>&pname=<%=pname%>"><%=pname%></a></td>
	    <td class="gridhdbg2" ><%=nrdwp%></td>
	
<%	
stmt2=conn.createStatement();
query2="select count(*) from rws_work_admn_tbl a , rws_work_completion_tbl b where a.work_id=b.work_id and substr(a.work_id,1,2)='"+pcode+"'";
System.out.println("Query2"+query2);
rs2=stmt2.executeQuery(query2);
while(rs2.next())
{
	completedcount=rs2.getInt(1);
	
}
%>
       <td class="btext"><%=completedcount%></td>
 <%
 stmt3=conn.createStatement();
 query3="select count(*) from rws_work_admn_tbl a where a.work_id not in(select work_id from rws_work_completion_tbl) and substr(a.work_id,1,2)='"+pcode+"'";
 rs3=stmt3.executeQuery(query3);
 while(rs3.next())
 {
	 ongoingcount=rs3.getInt(1);
 }
 %>
 <td  class="btext"><%=ongoingcount%></td>
<%
}
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
</tr></table>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
</html>


		


</html>