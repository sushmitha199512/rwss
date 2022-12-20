<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<body topmargin="0">

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">

<tr><td colspan=16 class="textborder">School Details List</td></tr>
<%		java.util.ArrayList ss = (java.util.ArrayList)session.getAttribute("collection1");
        nic.watersoft.masters.SchoolForm frm=null;
		for(int i = 0;i<ss.size();i++)
		{
		frm=(nic.watersoft.masters.SchoolForm)ss.get(i); 
		//System.out.println("dist "+frm.getDistName());
		}

if(!request.getParameter("dFlag").equals("true")) {%>
<tr>
<td colspan="16">
<FONT class=myfontclr><font color="#993366">District:</font><%=frm.getDistName()%> &nbsp;&nbsp;</font> 
<%} if(!request.getParameter("mFlag").equals("true")){%>
<FONT class=myfontclr><font color="#993366">Mandal:</font> <%=frm.getMandName()%> &nbsp;&nbsp;</font>
<%}if(!request.getParameter("pFlag").equals("true")){ %>
<FONT class=myfontclr><font color="#993366">Panchayat:</font> <%=frm.getPanchName()%> &nbsp;&nbsp;</font>
<%}if(!request.getParameter("vFlag").equals("true")){%>
<FONT class=myfontclr><font color="#993366">Village:</font> <%=frm.getVillName()%>  &nbsp;&nbsp;</font>
<%}%>
</td>
</tr>

<%if(session.getAttribute("message")!=null){%>
<tr> 
<td colspan="16"><FONT class=myfontclr><%=request.getParameter("message") %></font></td>
</tr>
<%}%>
<tr>
		<td align=center>
		<FONT class=myfontclr><font color="#993366">S.NO.</FONT></FONT>
		</td>
		<%if(request.getParameter("dFlag").equals("true")){ %>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">District Name</FONT>
		</td>
		<%} if(request.getParameter("mFlag").equals("true")){ %>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Mandal Name</FONT>
		</td>
		<%} if(request.getParameter("pFlag").equals("true")){ %>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Panchayat Name</FONT>
		</td>
		<%} if(request.getParameter("vFlag").equals("true")){ %>
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Village Name</FONT>
		</td>
		<%}%> 
		<td  align=center>
		<FONT class=myfontclr><font color="#993366">Habitation Name</FONT>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School_Code</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">school_Name</FONT></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">No_Of_Students</FONT></FONT>
		</td>
			
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">No_Of_Boys</FONT></FONT></td>

		<td nowrap>
		<FONT class=myfontclr><font color="#993366">No_Of_Girls</FONT></FONT>
		</td>
	
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School_Category</FONT></FONT>
		</td>
						
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">School Classification</FONT></FONT><br>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Facilities Available</FONT></FONT>
		</td>
		
		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Separate for Boys_Girls<br>Toilet</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Urinal</FONT></FONT><br>
		</td>

		<td nowrap>
		<FONT class=myfontclr><font color="#993366">Reasons Non_Availibility<br>Drinking Water Facility</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Sanitation Facility</FONT></FONT><br>
		</td>
	
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Target Drinking water<br>Month</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Year</FONT></FONT><br>
		</td>
		
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Target Sanitation<br>Month</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Year</FONT></FONT><br>
		</td>
		
		<td  nowrap>
		<FONT class=myfontclr><font color="#993366">Source of funding<br>Drinking water facility</FONT>/</FONT><br>
		<FONT class=myfontclr><font color="#993366">Sanitation facility</FONT></FONT><br>
		</td>
		
		
	</tr>

<%int a=1; %>
<logic:iterate id="details" name="collection1">
<tr>
<td class=myfontclr align="center"><font class="bwborder"><%=a++ %></font></td>
<%if(request.getParameter("dFlag").equals("true")){ %>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="distName"/></FONT><BR>
</td>
<%} if(request.getParameter("mFlag").equals("true")) {%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="mandName"/></FONT><BR>
</td>
<%} if(request.getParameter("pFlag").equals("true")) {%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="panchName"/></FONT><BR>
</td>
<%} if(request.getParameter("vFlag").equals("true")) {%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="villName"/></FONT><BR>
</td>
<%}%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="habName"/></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="schoolCode" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="details" property="schoolName" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="noStudents" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="details" property="noBoys" /></FONT>
</td>

<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="details" property="noGirls" /></FONT>
</td>

<td class=mycborder1>
<FONT class=myfontclr1><bean:write name="details" property="category" />&nbsp;</FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="classify" /></FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="facilities" />&nbsp;</FONT><BR>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="toilets" />&nbsp;</FONT><BR>
<FONT class=myfontclr1><bean:write name="details" property="urinals" />&nbsp;</FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="nonDrink" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="nonSani" /></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="drkMonth" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="drkYear" /></FONT>
</td>

<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="saniMonth" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="saniYear" /></FONT>
</td>

<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="sourceDrkFund" /></FONT><br>
<FONT class=myfontclr1><bean:write name="details" property="sourceSaniFund" /></FONT>
</td>

</tr>
</logic:iterate>
<%if(a==1)
{
%>
<tr>
<td colspan="10">No Records</td>
</tr>
<% 
}
 %>
</table>

</body>
