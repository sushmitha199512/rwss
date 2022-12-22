<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp" %>
<form>
<%

Statement stmt8="";

	
	%>
	
   <table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
   <tr align=center>
	<td class=btext colspan=24>District:<font color="red"><%=dname%></font> </td>
	</tr>
	
	
	
	
<%
try
{
	
	
	String qry="select * from";
	
   
	
    
	
		
    // ////System.out.println("query1111**********"+gqry);
	
	Statement	stmt8=conn.createStatement();
	Statement	stmt2=conn.createStatement();
    
	ResultSet rs8=stmt8.executeQuery(gqry.toString());
	StringBuffer q2=new StringBuffer();
		while (rs8.next())
		{
			
			q2.delete(0,q2.length());
			q2.append("select SCARCITY_NAME  from RWS_DROUGHT_SCAR_REASONS_TBL where SCARCITY_CODE='"+rs8.getString(1)+"'");

	 
	   ResultSet rs2=stmt2.executeQuery(q2.toString());




		j++;
	%>
	<tr>
	
	
	
	
  

	<td class="rptValue"><%=sno++%></td>
    <td class="rptValue"><%=rs8.getString(24)%></td>
	<td class="rptValue"><%=rs8.getString(22)%>/<br><%=rs8.getString(23)%></td>
<% if(rs2.next()){ %>
	<td class="rptValue"><%=rs2.getString(1)%></td>
<%} else{ %>
<td class="rptValue">-</td>
<%} %>
	<td class="rptValue"><%=rs8.getString(2)%></td>
    <td class="rptValue"><%=rs8.getString(3) %></td>
	<td class="rptValue"><%=rs8.getString(4)%></td>
	<td class="rptValue"><%=rs8.getString(5)%></td>
	<td class="rptValue"><%=rs8.getString(6)%></td>
	<td class="rptValue"><%=rs8.getString(7)%></td>
	<td class="rptValue"><%=rs8.getString(8)%></td>
	<td class="rptValue"><%=rs8.getString(9)%></td>
		<td class="rptValue"><%=rs8.getString(12)%></td>
	<td class="rptValue"><%=rs8.getString(13)%></td>
	<td class="rptValue"><%=rs8.getString(10)%></td>
	<td class="rptValue"><%=rs8.getString(11)%></td>
	
	<td class="rptValue"><%=rs8.getString(14)%></td>
	<td class="rptValue"><%=rs8.getString(15)%></td>
	<td class="rptValue"><%=rs8.getString(16)%></td>
<td class="rptValue"><%=rs8.getString(17)%></td>
	<td class="rptValue"><%=rs8.getString(18)%></td>


	<td class="rptValue"><%=rs8.getString(19)%></td>
	<td class="rptValue"><%=rs8.getString(20)%></td>
	<td class="rptValue"><%=rs8.getString(21)%></td>
	
	
	</tr>
	
	
<%
	}
	
	if(j==0)
	{%>
	<tr>
	<td colspan=7 align="center">No Records</td>
	</tr>
	
	<%}
	

}catch(Exception e)
		{
		////System.out.println("error::"+e);
		}
		%>
</table>
<p align=center>
<%@ include file="/commons/rws_footer.jsp" %>

</p>

  
