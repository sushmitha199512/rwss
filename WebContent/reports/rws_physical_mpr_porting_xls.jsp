
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>

<form>

<p align="center" colspan="30"><font class="rptvalue" size=3><b>Physical MPR Details</b></font><BR><br></p>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >


<tr align="center">
<td class=btext ><b>SLNO   </b></td>
<td class=btext ><b>SCHEME ID   </b></td>
<td class=btext ><b>HABITATION ID </b></td>    
<td class=btext ><b>MONTH ID   </b></td>  
<td class=btext ><b>YEAR ID</b></td>  
<td class=btext ><b>SCPOPCOVERED   </b></td>  
<td class=btext ><b>STPOPCOVERED   </b></td>    
<td class=btext ><b>GENERAL POPCOVERED  </b></td>  
<td class=btext ><b>HOUSE CONNECTIONS </b></td>   
<td class=btext ><b>COVERAGE STATUS  </b></td>   
</tr>

	<%try
      { int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       qry="select * from physicalmpr";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       while(rs1.next())
       {
		%>
				<tr align="center">
                <td class=rptValue>&nbsp;<%=count++%> </td>
				<td class=rptValue>&nbsp;<%=rs1.getString(1)%> </td>
				<td class=rptValue >&nbsp;<%=rs1.getString(2)%> </td>    
				<td class=rptValue ><%=rs1.getString(3)%>   </td>  
				<td class=rptValue ><%=rs1.getString(4)%>   </td>  
				<td class=rptValue ><%=rs1.getString(5)%>  </td>  
				<td class=rptValue ><%=rs1.getString(6)%>  </td>    
				<td class=rptValue ><%=rs1.getString(7)%> </td>  
				<td class=rptValue ><%=rs1.getString(8)%> </td>   
				<td class=rptValue ><%=rs1.getString(9)%> </td>  
</tr>
		<% 
       }
      }
     catch(Exception e)
     {
     e.printStackTrace();
     } 
	%>
		
</table>
