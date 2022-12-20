
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>


<table width=832>
<tr><td align=right>
<A HREF="javascript:history.go(-1)">Back&nbsp;|&nbsp;</A>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>

</td>
</tr>
</table>
<html:form action="Complaintattended.do">
<table    width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Grievance Attended List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>

        <td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Sl.No</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Source Code</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Source Name</FONT></td>
		<td  class=mycborder align=center>
		
		<FONT class=myfontclr><font color="#993366">Complaint No</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Date</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Category</FONT></td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Description</FONT></td>
		
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Attended By</FONT></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Attended Date</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Complaint Status</FONT>	</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Remarks</FONT>	</td>
		
</tr>

<%
try
{
java.util.Collection b = (java.util.ArrayList)request.getAttribute("complaintsalist"); 
System.out.println("B size"+b.size());
if(b.size() > 0)
{

 int count=0; %>
<%System.out.println("Complaints"); %>
<logic:iterate id="COMPLAINTSALIST" name="complaintsalist">
<%System.out.println("Complaints2"); %>
<% count=count+1;%>

<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="sourceCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="assetName" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntno" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntdt" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="categoryName" /></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="complntdesc" /></FONT>
</td>


<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="attenby" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="attendt" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="status" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="COMPLAINTSALIST" property="remarksby" /></FONT>
</td>


</tr>
</logic:iterate>
<%}
else
{
%>
<tr>
<td colspan=11 align=center>No Records</td>
</tr>
<%
}}
catch(Exception e)
{
System.out.println("Exception"+e);
}

%>

</table>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


<script  language="javascript">

function fnDelete(sourceCode)
{

if(confirm("Do You Want To Delete The Selected Record"))
	{
	
		document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintattended.do?mode=cdelete&sourceCode="+sourceCode;
		document.forms[0].submit();
	}
	
}

</script>
<script language="javascript">
<%
if(request.getAttribute("dmessage")!=null)
{
%>
alert('<%=request.getAttribute("dmessage")%>');
<%}%>


</script>



