<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

<html:form action="/ContaminationDetails.do">
<html:hidden property="init" value="false"/>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"   border=1 style="border-collapse:collapse" >
<tr><td bgcolor="#8A9FCD" colspan=9 class=myfontclr><B><font color="#FFFFFF">ContaminationDetails List</font></B></td>
<tr>
<td colspan="3" class="clrborder">
<%if(request.getAttribute("districtName")!=null)%>
District Name: <%= request.getAttribute("districtName") %>&nbsp;&nbsp;&nbsp;

</td>



</tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center>Hab Code</td>
	<td  class="clrborder" align=center>Hab Name</td>
	<td  class="clrborder" align=center>Floride Contamination</td>
	<td  class="clrborder" align=center>Brakish Contamination</td>
	<td  class="clrborder" align=center>Iron Contamination</td>
	<td  class="clrborder" align=center>Aresenic Contamination(PPM)</td>
	<td  class="clrborder" align=center>Nitrate Contamination(PPM)</td>
	<td  class="clrborder" align=center>Status Date</td>
	
	
	
</tr>


<% int count=0;%>
<logic:iterate id="contaminationDetailsList" name="contaminationDetails">

<% count=count+1;%>

<tr align="left" >
<td  class="bwborder" ><%=count %></td>
<td>&nbsp;<bean:write name="contaminationDetailsList" property="habCode" /></td>
<td  class="bwborder" align=left>
<bean:write name="contaminationDetailsList" property="habName" /></td>
<td  class="bwborder" align=left>
<bean:write name="contaminationDetailsList" property="flourideContamination" /></td>
<td  class="bwborder" align=left>
<bean:write name="contaminationDetailsList" property="brakishContamination" /></td>
<td  class="bwborder" align=left>
<bean:write name="contaminationDetailsList" property="ironContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="aresenicContamination" /></td>
<td  class="bwborder" align=left><bean:write name="contaminationDetailsList" property="nitrateContamination" /></td>
<td  class="bwborder" align=left>
<bean:write name="contaminationDetailsList" property="statusDate" /></td>



</tr>
<!-- </div> -->
</logic:iterate>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

