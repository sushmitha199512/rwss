<%@ include file="/commons/rws_header1.jsp" %>

<%@ page contentType="application/vnd.ms-excel" %>
<%
 //int start;
 //System.out.println("1111111111111111111");
/*   ArrayList myList = (ArrayList)session.getAttribute("v");
    Iterator iterator = myList.iterator();
   int mylists1=myList.size();
 
   if(request.getParameter("start") !=  null) 
	{
		start = Integer.parseInt(request.getParameter("start"));
	} */
 
 
 %>
 <table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
<tr>	  
		 <td  class= "btext">S.No</td>
		   <td class="btext">Plan Name</td>
   		   <td class="btext">Work Type</td>
		   <td class="btext">Category Name</td>
		   <td class="btext">Programme Name</td>
		  </tr>
	<%int cnt=0; %>
	<logic:iterate id="rep" name="viewsum">
	
		<tr align="left" >
		
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><%=++cnt%></FONT>
		</td>
		<td  class=mycborder1 nowrap>
			<FONT class=myfontclr1><bean:write name="rep" property="plan" /></FONT>
		</td>
		<td  class=mycborder1 >
		<FONT class=myfontclr1><bean:write name="rep" property="wrktype" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="rep" property="category" /></FONT>
		</td>
		<td  class=mycborder1 nowrap>
		<FONT class=myfontclr1><bean:write name="rep" property="program" /></FONT>
		</td>
		</tr>
		
	</logic:iterate>
	 <%if(cnt==0)
	  {%>
	  <tr>
	  <td colspan=5 align=center>No Record Match With This Selection Criteria</td>
	  </tr>
       
     <%}%>
	</table>
	