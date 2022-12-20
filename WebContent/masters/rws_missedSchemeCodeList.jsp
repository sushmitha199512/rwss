<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<% int count=0;%>
<script language="javascript">


function missingCodeSelected(missedCode)
{

//var missingCode=document.getElementById("MISSINGCODES_LIST["+index+"]").value;

opener.document.forms[0].pumpCode.value=missedCode;
//opener.document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=selectSource&sourceTypeCode="+sourceTypeCode+"&sourceCode="+sourceCode;
//opener.document.forms[0].submit();
self.close();
}









</script>
<html:form action="/Asset.do">

<html:hidden property="init" value="false"/>


<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="55%" border=1 style="border-collapse:collapse" >

<tr><td class=myfontclr bgcolor="#8A9FCD" colspan=9><B><font color="#FFFFFF">Missing Codes List</font></B></td>
<tr>
    <td  class="clrborder" align=left>Select</td>
	
	
	<td  class="clrborder" align=center>Scheme Code </td>
	
</tr>


<nested:iterate id="MISSINGCODES_LIST" name="missingCodes" indexId="ndx">

<% count=count+1;%>
<tr align="left" id='tr<%=count%>' onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'" >
<td  class="bwborder" ><!-- <%=count %> -->
<input type="radio" name="radio1" onclick="missingCodeSelected('<nested:write name="MISSINGCODES_LIST" />')" >
</td>
<td  class="bwborder" align=left nowrap>
<nested:write name="MISSINGCODES_LIST"   />

</td>
</tr>

<!-- </div> -->
</nested:iterate>
<%if(count==0){ %>
<tr><td colspan=4 align="center">No Records</td></tr>
<%} %>

</table>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

