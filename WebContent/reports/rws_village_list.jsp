<%@ include file="/commons/rws_head.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<html:html>
<HEAD>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 
	
<TITLE>DistrictList</TITLE>
<head>
</HEAD>
<p>
<BODY>

<p align="center">
<html:form action="DistrictListAction.do" >
<table border = 1 cellspacing = 0 cellpadding = 0 width="100%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				
				 <td align="right"><a href="rws_village_list_excel.jsp" target="_new">Excel</a></td>
</tr>
		</table>
	</caption>
	</table>

<table  width="100%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Villages List</font></B></td></tr></table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#ffffff">
<td align="center" class=btext>District Name:<%=session.getAttribute("distname")%></td>
</tr>

</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="100%">
	<tr bgcolor="#ffffff">
	<td class=clrborder>Sl.No</td>
	<td class=clrborder>Mandal Code</td>
	<td class=clrborder>Mandal Name</td>
	<td class=clrborder>Panchayat Code</td>
	<td class=clrborder>Panchayat Name</td>
	<td align="center" class=clrborder>Village Code</td>
	<td align="center" class=clrborder>Village Name</td>
	
	<% int count=0; %>
	
	<logic:iterate id="employee" name="villagedisplay">
			<TR align="center">
				
				</tr>
				<tr bgcolor="#ffffff">
				<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  align="center" class="bwborder" ><%=count %></td>
				
				<td align="center" class=bwborder><bean:write name="employee" property="mcode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="mname" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="pcode" /></td>
				<td align="left" class=bwborder><bean:write name="employee" property="pname" /></td>
				<td align="center" class=bwborder><bean:write name="employee" property="vcode" /></td>
				
				<td align="left" class=bwborder><bean:write name="employee" property="vname" /></td>
				
				
					
			</logic:iterate>
			
				</TABLE>
<table>
<tr>
</tr>
</table>
<center>
<%@ include file="/commons/rws_footer.jsp"%></center>
</html:form>
</BODY>
</p>
</html:html>
<script  language="javascript">

function fnDelete(empno)
{

if(confirm("Do You Want To Delete The Selected Record"))
	{
		document.forms[0].action="/EmpApp/Delete.do?empno="+empno;
		document.forms[0].submit();
	}
}

</script>
<script language="javascript">
<%
if(request.getAttribute("message")!=null)
{
%>
alert('<%=request.getAttribute("message")%>');
<%}%>


</script>


