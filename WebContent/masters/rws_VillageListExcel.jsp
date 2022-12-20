<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html:form action="/Village.do">
<html:hidden property="init" value="false"/>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr><td class=myfontclr colspan="3" bgcolor="#8A9FCD"><B><font color="#FFFFFF" >Village List</font></B></td></tr>
<tr>
<td colspan="3" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Name: <%= request.getAttribute("selectedDistrict") %>&nbsp;&nbsp;&nbsp;
<%if(request.getAttribute("selectedMandal")!=null)%>
Mandal Name: <%= request.getAttribute("selectedMandal") %>
<br>
<%if(request.getAttribute("selectedPanchayat")!=null)%>
Panchayat Name: <%= request.getAttribute("selectedPanchayat") %>
</td>
</tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center>Village Code</td>
	<td  class="clrborder" align=center>Village Name</td>
	
	
</tr>

<% int count=0;%>
<logic:iterate id="villageList" name="villageDetails">

<% count=count+1;%>
<tr align="left" >
<td  class="bwborder" ><%=count %></td>
<td>&nbsp;<bean:write name="villageList" property="vcode" /></td>
<td  class="bwborder" align=left>
<bean:write name="villageList" property="vname" /></td>


</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

