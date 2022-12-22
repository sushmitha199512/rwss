
<%@ page import ="java.util.ArrayList" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<Script language="javascript">
function main()
{
	window.location="/pred/home.do";
}
</script>
<body bgcolor="#edf2f8">
<html:form action="ContractorWork.do">
<table border = 1 cellspacing = 0 cellpadding = 0 width=100%   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption><tr><td>
<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			<tr align="right">
			<td class="bwborder">
				<a href="<rws:context page='/switch.do?prefix=/reports&page=/ContractorWork.do?mode=init'/>">Back|</a>
				 <a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a>
			</td>
		</tr>
	</table>
</caption>
<tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="7">
		<font color="ffffff">Contractor Wise - No of Works Report </font></td>
</tr>
</table>
<table  align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0"  style="border-collapse:collapse;" width="100%" >
<tr>
		<td class="textborder" align="center">
		<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status As On :<%=request.getParameter("myear")%> </font><font color=#F2A80D> </font></td>
</tr>
<tr>        
        <td class="textborder" align="center">
		<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;District :<%=request.getParameter("mdistrict")%> </font><font color=#F2A80D> </font></td>
</tr>
        <td class="textborder" align="center">
		<font size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Contractor :<%=request.getParameter("mcontractor")%> </font><font color=#F2A80D> </font></td>
</tr>
</tr>
</table>

<table border = 1 cellspacing = 0 cellpadding = 0 width=100%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">	
	<tr>
		<td class="btext" >S.NO.</td>
		<td class="btext" >Contractor Name</td> 
		<td class="btext">No of Works </td>	
</tr>
<%
String  count=null;
int newcount=0;
String[][] condata = new String[30][2];
condata=(String[][])session.getAttribute("condata");
count=(String)(session.getAttribute("count"));
newcount=Integer.parseInt(count);
System.out.println("New Count"+newcount);
int k=1,i=0,j=0;
for(i=0;i<newcount;i++)
{%>
<tr>
<td class="text"><%=k%></td>
<td class="text"><%=condata[i][0]%></td>
<td class="text"><a href ="rws_contractor_work_form_rep.jsp?condata=<%=condata[i][1]%>"><%=condata[i][1]%></a></td>
</tr>
<%k++;}
%>
<tr>


</tr>
<tr> 
</tr>  
</table>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>

