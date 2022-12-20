
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%
String Type=(String)session.getAttribute("Type");
 %>
<form>

<p align="center" colspan="30"><font class="rptvalue" size=3><b>Financial Expenditure Details of <%=Type %></b></font><BR><br></p>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="90%" border=1 style="border-collapse:collapse" >


<tr align="center">
<td class=btext ><b>SLNO  </b></td>
<td class=btext ><b>SCHEMEID   </b></td>
<td class=btext ><b>SCHEMENAME </b></td>    
<td class=btext ><b>YEARID   </b></td>  
<td class=btext ><b>MONTHID   </b></td>  
<td class=btext ><b>DISTRICTID  </b></td>  
<td class=btext ><b>PROGRAMMEID  </b></td>   
<td class=btext ><b>PROGRAMMENAME  </b></td>    
<td class=btext ><b>GOISCEXPENDITURE </b></td>   
<td class=btext ><b>GOISTEXPENDITURE  </b></td>  
<td class=btext ><b>GOIGENEXPENDITURE </b></td>   
<td class=btext ><b>GOISCHOOLSCEXPENDITURE </b></td>     
<td class=btext ><b>GOISCHOOLSTEXPENDITURE </b></td>  
<td class=btext ><b>GOISCHOOLGENEXPENDITURE</b></td>    
<td class=btext ><b>STATESCEXPENDITURE  </b></td>    
<td class=btext ><b>STATESTEXPENDITURE   </b></td>  
<td class=btext ><b>STATEGENEXPENDITURE  </b></td>    
<td class=btext ><b>STATESCHOOLSCEXPENDITURE </b></td>     
<td class=btext ><b>STATESCHOOLSTEXPENDITURE</b></td>   
<td class=btext ><b>STATESCHOOLGENEXPENDITURE </b></td>     
<td class=btext ><b>DDPSCEXPENDITURE    </b></td>  
<td class=btext ><b>DDPSTEXPENDITURE   </b></td>  
<td class=btext ><b>DDPGENEXPENDITURE   </b></td>     
<td class=btext ><b>DDPSCHOOLSCEXPENDITURE  </b></td>  
<td class=btext ><b>DDPSCHOOLSTEXPENDITURE      </b></td>
<td class=btext ><b>DDPSCHOOLGENEXPENDITURE  </b></td> 
<td class=btext ><b>COMMUNITYSCEXPENDITURE       </b></td>
<td class=btext ><b>COMMUNITYSTEXPENDITURE       </b></td>
<td class=btext ><b>COMMUNITYGENEXPENDITURE    </b></td>
<td class=btext ><b>COMMUNITYSCHOOLSCEXPENDITURE     </b></td>
<td class=btext ><b>COMMUNITYSCHOOLSTEXPENDITURE  </b></td>
<td class=btext ><b>COMMUNITYSCHOOLGENEXPENDITURE      </b></td>
</tr>

	<%try
      {int count=1;
       Statement stmt1=null;
       ResultSet rs1=null;
       String qry="";
       stmt1=conn.createStatement();
       qry="select * from SchemeExpenditure";
       //System.out.println("qry***********"+qry);
       rs1=stmt1.executeQuery(qry);
       while(rs1.next())
       {
		%>
				<tr align="center">
                <td class=rptValue>&nbsp;<%=count++%> </td>
				<td class=rptValue>&nbsp;<%=rs1.getString(1)%> </td>
				<td class=rptValue ><%=rs1.getString(2)%> </td>    
				<td class=rptValue ><%=rs1.getString(3)%>   </td>  
				<td class=rptValue ><%=rs1.getString(4)%>   </td>  
				<td class=rptValue >&nbsp;<%=rs1.getString(5)%>  </td>  
				<td class=rptValue ><%=rs1.getString(6)%>  </td>    
				<td class=rptValue ><%=rs1.getString(7)%> </td>  
				<td class=rptValue ><%=rs1.getString(8)%> </td>   
				<td class=rptValue ><%=rs1.getString(9)%>  </td>   
				<td class=rptValue ><%=rs1.getString(10)%></td>     
				<td class=rptValue ><%=rs1.getString(11)%> </td>     
				<td class=rptValue > <%=rs1.getString(12)%></td>   
				<td class=rptValue ><%=rs1.getString(13)%>  </td>    
				<td class=rptValue ><%=rs1.getString(14)%>  </td>    
				<td class=rptValue ><%=rs1.getString(15)%>   </td>   
				<td class=rptValue ><%=rs1.getString(16)%> </td>   
				<td class=rptValue ><%=rs1.getString(17)%> </td>     
				<td class=rptValue ><%=rs1.getString(18)%></td>      
				<td class=rptValue ><%=rs1.getString(19)%>   </td>    
				<td class=rptValue ><%=rs1.getString(20)%>    </td>  
				<td class=rptValue ><%=rs1.getString(21)%>   </td>  
				<td class=rptValue ><%=rs1.getString(22)%>  </td>     
				<td class=rptValue ><%=rs1.getString(23)%>  </td>  
				<td class=rptValue ><%=rs1.getString(24)%>      </td>
				<td class=rptValue ><%=rs1.getString(25)%>    </td>
				<td class=rptValue ><%=rs1.getString(26)%>       </td>
				<td class=rptValue ><%=rs1.getString(27)%>       </td>
				<td class=rptValue ><%=rs1.getString(28)%>      </td>
				<td class=rptValue ><%=rs1.getString(29)%>     </td>
				<td class=rptValue ><%=rs1.getString(30)%>  </td>
				<td class=rptValue ><%=rs1.getString(31)%>  </td>
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
