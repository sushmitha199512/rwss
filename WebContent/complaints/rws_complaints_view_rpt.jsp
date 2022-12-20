<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%
		java.util.ArrayList ss = (java.util.ArrayList)request.getAttribute("collection1");
        nic.watersoft.complaints.CompForm frm=null;
		for(int i = 0;i<ss.size();i++)
		{
		frm=(nic.watersoft.complaints.CompForm)ss.get(i); 
		//System.out.println("dist "+frm.getDistName());
		}
%> 	    
<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="99%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right"><a href="switch.do?prefix=/complaints&page=/freeFormatComplaint.do&mode=get2">Back</a>|</td>
		<td	class="bwborder" align="right"><a href="../rws_login_frm.jsp">Home</a></td>
	    <!--<td class="bwborder" align="right"><a href="./rws_school_details_view" target="_new">Excel</a></td>-->
	</tr>
</table>
</caption>
<tr><td colspan=17 class="textborder">Complaints Details List</td></tr>
<%if(request.getAttribute("dFlag")==null){%>
<tr>
<td colspan="17">
<FONT class=myfontclr><font color="#993366">District:</font><%=frm.getDistrictName()%> &nbsp;&nbsp;</font> 
<%}
  if(request.getAttribute("mFlag")==null){%>
<FONT class=myfontclr><font color="#993366">Mandal:</font> <%=frm.getMandalName()%> &nbsp;&nbsp;</font>
<%}
  if(request.getAttribute("pFlag")==null){ %>
<FONT class=myfontclr><font color="#993366">Panchayat:</font> <%=frm.getPanchayatName()%> &nbsp;&nbsp;</font>
<%}
  if(request.getAttribute("vFlag")==null){%>
<FONT class=myfontclr><font color="#993366">Village:</font> <%=frm.getVillageName()%>  &nbsp;&nbsp;</font>
<%}%>
</td>
</tr>
<%if(request.getAttribute("message")!=null){%>
<tr> 
	<td colspan="17"><FONT class=myfontclr><%=request.getAttribute("message") %></font></td>
	</tr>
	<%}%>
	<tr>
	<td align=center>
	<FONT class=myfontclr><font color="#993366">S.NO.</FONT></FONT>
	</td>
	<%if(request.getAttribute("dFlag")!=null || request.getAttribute("dFlag")=="true"){ %>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">District Name</FONT>
	</td>
	<%}
	if(request.getAttribute("mFlag")!=null || request.getAttribute("mFlag")=="true")
	{%>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Mandal Name</FONT>
	</td>
	<%}
	if(request.getAttribute("pFlag")!=null || request.getAttribute("pFlag")=="true")
	{  %>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Panchayat Name</FONT>
	</td>
	<%}
	if(request.getAttribute("vFlag")!=null || request.getAttribute("vFlag")=="true")
	{ %>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Village Name</FONT>
	</td>
	<%}%>

	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Habitation Name</FONT>
	</td>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Source Code</FONT>
	</td>
	<td  align=center>
	<FONT class=myfontclr><font color="#993366">Source Name</FONT>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Complaint No</FONT></FONT>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Complaint Date</FONT></FONT>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Attended Date</FONT></FONT>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Complaint Category</FONT></FONT><br>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Complaint Description</FONT></FONT><br>
	</td>
	<td nowrap>
	<FONT class=myfontclr><font color="#993366">Complaint Status</FONT></FONT><br>
	</td>

	</tr>
	<%int a=1; %>
<logic:iterate id="details" name="collection1">
<tr>
<td class=myfontclr align="center"><font class="bwborder"><%=a++ %></font></td>
<%if(request.getAttribute("dFlag")!=null || request.getAttribute("dFlag")=="true"){ %>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="districtName"/></FONT><BR>
</td>
<%}
 if(request.getAttribute("mFlag")!=null || request.getAttribute("mFlag")=="true")
{%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="mandalName"/></FONT><BR>
</td>
<%}
 if(request.getAttribute("pFlag")!=null || request.getAttribute("pFlag")=="true")
{%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="panchayatName"/></FONT><BR>
</td>
<%}
 if(request.getAttribute("vFlag")!=null || request.getAttribute("vFlag")=="true")
{%>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="villageName"/></FONT><BR>
</td>
<%}%>
 <td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="habName"/></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="sourceCode" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="assetName" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complntno" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complntdt" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="attendt" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="categoryName" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complntdesc" /></FONT><BR>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="details" property="complntstatus" /></FONT><BR>
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
