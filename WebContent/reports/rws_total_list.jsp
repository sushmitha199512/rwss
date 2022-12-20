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
<!-- <table border = 0 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				
				<td><a href="/pred/reports/rws_district_list_excel.jsp" target="_new">Excel</a></td>
				</tr>
		</table>
	</caption>
	</table>
				

<table border = 1 cellspacing = 0 cellpadding = 0 width=80% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="8">
			<font color="ffffff">DistrictWise - Habitation Directory</font></td>
	</tr>
<tr><td valign=top>

	<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<tr bgcolor="#ffffff"> -->
	<table border = 1 cellspacing = 0 cellpadding = 0 width="65%"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
		
			<tr align="right">
				<td class="bwborder"><a href="javascript:history.go(-1)">Back |</a></td>
				
				<td><a href="/pred/reports/rws_district_list_excel.jsp" target="_new">Excel</a></td>
				</tr>
		</table>
	</caption>
	</table>
				

<table    width="65%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Districts List</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="65%" border=1 style="border-collapse:collapse" >
</table>

	<TABLE border="1" cellspacing="0" cellpadding="0" width="65%">
	<tr bgcolor="#ffffff">
	<td class=clrborder>Sl.No</td>
	<td align="center" class=clrborder>District Code</td>
	<td align="center" class=clrborder>District Name</td>
	<td align="center" class=clrborder>Total Mandals</td>
	<td align="center" class=clrborder>Total Panchayats</td>
	<td align="center" class=clrborder>Total Villages</td>
	<td align="center" class=clrborder>Total Habitations</td>
	</tr>
	<% int count=0; %>
		<logic:iterate id="employee" name="panchayatdisplays">
	<TR align="center">
				</tr>
				<tr bgcolor="#ffffff">
				<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>
				
				
				
			<td align="center" class=bwborder><bean:write name="employee" property="dcode" /></td>
				
				<td align="left" class=bwborder><bean:write name="employee" property="dname" /></td>
				<td align="center" class=bwborder><a href="/pred/reports/DistrictListAction.do?dcode=<bean:write name="employee" property="dcode" />&mode=mandal"><bean:write name="employee" property="mcount" /></a></td>
		        <td align="center" class=bwborder><a href="/pred/reports/DistrictListAction.do?dcode=<bean:write name="employee" property="dcode" />&mode=panchayat"><bean:write name="employee" property="pcount" /></a></td>
		        <td align="center" class=bwborder><a href="/pred/reports/DistrictListAction.do?dcode=<bean:write name="employee" property="dcode" />&mode=village"><bean:write name="employee" property="vcount" /></a></td>
		        <td align="center" class=bwborder><a href="/pred/reports/DistrictListAction.do?dcode=<bean:write name="employee" property="dcode" />&mode=habitation"><bean:write name="employee" property="panchcount" /></a></td>
				
											
			</tr>
				
				<%if(count==22){%>	
			
			<tr>
			<td colspan="3">Total:</td>
			
			
			<td align="center" class=bwborder><bean:write name="employee" property="totalMcount" /></td>
			<td align="center" class=bwborder><bean:write name="employee" property="totalPcount" /></td>
			<td align="center" class=bwborder><bean:write name="employee" property="totalVcount" /></td>
			<td align="center" class=bwborder><bean:write name="employee" property="totalHabcount" /></td>
			</tr>
			<%}%>
			</logic:iterate>
		</TABLE>
<table>
<tr>
<td>				
</td>
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


