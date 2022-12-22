<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">

</script>
<html:form action="/broDetails.do">

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD" ><td class=myfontclr colspan="20"><B><font color="#FFFFFF">Bro Program Details List</font></B></td></tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center >Programme</td>
	<td  class="clrborder" align=center >Sub Programme</td>
	<td  class="clrborder" align=center >Head Of Account</td>
	<td  class="clrborder" align=center >Budget Estimate</td>
	<td  class="clrborder" align=center >Budget Estimate Year</td>
	<td  class="clrborder" align=center >Amount Already Authorised</td>
	<td  class="clrborder" align=center >Amount Now Authorised</td>
	<td  class="clrborder" align=center >Procedure for Drawl</td>
	<td  class="clrborder" align=center >Drawing Officer</td>
	<td  class="clrborder" align=center >Remarks</td>
	
</tr>

<% int count=0;%>
<logic:iterate id="broProgDetails" name="broProgDetailsList">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>


<td  class="bwborder" align=left nowrap><bean:write name="broProgDetails" property="programmeName" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="broProgDetails" property="subprogrammeName" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="broProgDetails" property="headOfAccountName" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="budgetEstimate" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="broProgDetails" property="budgetEstimateYear" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="amountAlreadyAuthorised" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="amountNowAuthorised" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="procedureForDrawl" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="drawingOfficer" /></td>
<td  class="bwborder" align=left><bean:write name="broProgDetails" property="remarks" /></td>
</tr>
</logic:iterate>
<%if(count==0){ %>
<tr><td  colspan=20 class="bwborder" align=center>No Records</td></tr>
<%} %>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

