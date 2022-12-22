<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">

function toggleColor(that)
{
if(that.style.color=="blue")
that.style.color="red";
else if(that.style.color=="red")
that.style.color="blue"

}



</script>
<html:form action="/dlpo.do">
<html:hidden property="init" value="false"/>
<table width="10%">

<tr><td align=right style="wi" ><a href="<rws:context page='/home.jsp'/>">Home|</a>
 </td><td align=right><a href="javascript:history.go(-1)">Back</a>
 </td>
</tr>
</table>
<table    width="75%"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">DLPO Division Mandal Mapping View</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="75%" border=1 style="border-collapse:collapse" >

<tr>
    <td  class="btext" align=left>Sl.No</td>
	<td  class="btext" align=center>District</td>
	<td  class="btext" align=center>Division</td>
	<td  class="btext" align=center>Mandal</td>
	<td  class="btext" align=center>Edit</td>
	<td  class="btext" align=center>Delete</td>
</tr>

<% int count=0;%>
<logic:iterate id="dlpoMandalDetails" name="dlpoMandalDetails">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td   class="bwborder" align=left><%=count %></td>
<html:hidden name="dlpoMandalDetails" property="district"/>
<html:hidden name="dlpoMandalDetails" property="division"/>
<html:hidden name="dlpoMandalDetails" property="divmandals"/>
<td   class="bwborder" align=left>
<bean:write name="dlpoMandalDetails" property="districtName" /></td>

<td   class="bwborder" align=left>
<bean:write name="dlpoMandalDetails" property="divisionName" /></td>

<td   class="bwborder" align=left>
<bean:write name="dlpoMandalDetails" property="mandal" /></td>

<td   class="bwborder" align=left>
<a href="./divisionMandal.do?mode=Edit&dcode=<bean:write name='dlpoMandalDetails' property='district' />&mcode=<bean:write name='dlpoMandalDetails' property='divmandals' />&divcode=<bean:write name='dlpoMandalDetails' property='division' />&divisionName=<bean:write name="dlpoMandalDetails" property="divisionName" />"  style="color:blue">Edit&nbsp;</a>
</td>
<td   class="bwborder" align=left>
<a href="./divisionMandal.do?mode=Delete&dcode=<bean:write name='dlpoMandalDetails' property='district' />&mcode=<bean:write name='dlpoMandalDetails' property='divmandals' />&divcode=<bean:write name='dlpoMandalDetails' property='division' />"  style="color:blue" onclick="return deleteFun()">Delete&nbsp;</a>
</td>

</tr>
</logic:iterate>

<%
  if(count==0){
%>

<tr align="left"  onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  colspan="9" align="center" class="btext" > No Records</td>
</tr>
<%  } %>



</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

