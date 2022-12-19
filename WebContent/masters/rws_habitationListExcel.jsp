<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html:form action="/Habitation.do">
<html:hidden property="init" value="false"/>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
<td bgcolor="#8A9FCD" colspan="7"><B><font color="#FFFFFF">Habitation List</font></B></td>
</tr>
<tr>
<td colspan="7" class="clrborder">
<%if(request.getAttribute("selectedDistrict")!=null)%>
District Code: <%= request.getAttribute("selectedDistrictCode") %>&nbsp;&nbsp;&nbsp;
District Name: <%= request.getAttribute("selectedDistrictName") %>&nbsp;&nbsp;&nbsp;

Mandal Code: <%= request.
getAttribute("selectedMandalCode") %>&nbsp;&nbsp;&nbsp;
Mandal Name: <%= request.getAttribute("selectedMandalName") %>&nbsp;&nbsp;&nbsp;
<%if(!request.getAttribute("selectedPanchayatCode").equals(""))
{%>
Panchayat Code: <%= request.getAttribute("selectedPanchayatCode") %>&nbsp;&nbsp;&nbsp;
Panchayat Name: <%= request.getAttribute("selectedPanchayatName") %>&nbsp;&nbsp;&nbsp;
<%} %>
<%if(!request.getAttribute("selectedVillageCode").equals(""))
{%>
Village Code: <%= request.getAttribute("selectedVillageCode") %>&nbsp;&nbsp;&nbsp;
Village Name: <%= request.getAttribute("selectedVillageName") %>&nbsp;&nbsp;&nbsp;
<%} %>

</td>
</tr>

<tr>
    <td  class="clrborder" align=left>Sl.No
	<%if(request.getAttribute("selectedPanchayatCode").equals(""))
	{%>
	<td  class="clrborder" align=center>Panchayat Code</td>
	<td  class="clrborder" align=center>Panchayat Name</td>
	<%}%>
	<%if(request.getAttribute("selectedVillageCode").equals(""))
	{%>
	<td  class="clrborder" align=center>Village Code</td>
	<td  class="clrborder" align=center>Village Name</td>
	<%} %>
	<td  class="clrborder" align=center>Habitation Code</td>
	<td  class="clrborder" align=center>Habitation Name</td>
	
	
</tr>

<% int count=0;%>
<logic:iterate id="habitationList" name="habitationDetails">

<% count=count+1;%>
<tr align="left" >
<td  class="bwborder" ><%=count %></td>
<%if(request.getAttribute("selectedPanchayatCode").equals(""))
{%>
<td>&nbsp;<bean:write name="habitationList" property="pcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="pname" /></td>
<%} %>
<%if(request.getAttribute("selectedVillageCode").equals(""))
	{%>
<td>&nbsp;<bean:write name="habitationList" property="vcode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="vname" /></td>
<%} %>
<td>&nbsp;<bean:write name="habitationList" property="habCode" /></td>
<td  class="bwborder" align=left><bean:write name="habitationList" property="habName" /></td>


</tr>
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

