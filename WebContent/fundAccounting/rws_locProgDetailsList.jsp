<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">

</script>
<html:form action="/broDetails.do">

<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >
<tr bgcolor="#8A9FCD" ><td class=myfontclr colspan="20"><B><font color="#FFFFFF">LOC Program Details List</font></B></td></tr>
<tr>
    <td  class="clrborder" align=left>Sl.No
	
	<td  class="clrborder" align=center >District</td>
	<td  class="clrborder" align=center >Programme</td>
	<td  class="clrborder" align=center >Sub Programme</td>
	<td  class="clrborder" align=center >Head Of Account</td>
	<td  class="clrborder" align=center >Loc Date</td>
	<td  class="clrborder" align=center >Loc Amount</td>
	<td  class="clrborder" align=center >Office</td>
	<td  class="clrborder" align=center >Place</td>
	<td  class="clrborder" align=center >PAO/APAO</td>
	<td  class="clrborder" align=center >Remarks</td>
	
</tr>

<% int count=0;%>
<logic:iterate id="locProgDetails" name="locProgDetailsList1">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><%=count %></td>


<td  class="bwborder" align=left nowrap><bean:write name="locProgDetails" property="districtName" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locProgDetails" property="programName" /></td>
<td  class="bwborder" align=left><bean:write name="locProgDetails" property="subprogramName" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locProgDetails" property="headOfAccountName" /></td>
<td  class="bwborder" align=left><bean:write name="locProgDetails" property="locDate" /></td>
<td  class="bwborder" align=left><bean:write name="locProgDetails" property="locAmount" /></td>
<td  class="bwborder" align=left><bean:write name="locProgDetails" property="office" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locProgDetails" property="place" /></td>
<td  class="bwborder" align=left nowrap><bean:write name="locProgDetails" property="paoName" /></td>
<td  class="bwborder" align=left><bean:write name="locProgDetails" property="remarks" /></td>
</tr>
</logic:iterate>
<%if(count==0){ %>
<tr><td  colspan=20 class="bwborder" align=center>No Records</td></tr>
<%} %>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

