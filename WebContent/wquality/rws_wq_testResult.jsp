
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ include file="/commons/rws_header1.jsp" %>
<html>
<HEAD>
<script>
function update()
{
alert(document.forms[0].tpv0.value);
}
</script>
</HEAD>

<BODY>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
			<tr bgcolor="#8A9FCD">
				<td colspan="9" class="bwborder">
					<font color='000000'>Test Results</font>
				</td>
			</tr>
			<tr >
				<td class=clrborder align=center>Testing ParameterCode</td>
				<td class=clrborder align=center>Testing ParameterName</td>
				<td class=clrborder align=center>Min. Permissible Value</td>
				<td class=clrborder align=center>Max. Permissible Value</td>
				<td class=clrborder align=center>Undesirable Effect</td>
				
				<td class=clrborder align=center>Testing Paramater Value</td>
				
			</tr>
			<nested:iterate id="TESTRESULTS_LIST" name="testResults" 
									           offset="offset">
				<tr>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="testingParameterCode" ignore="true"/></TD>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="testingParameterName" ignore="true"/></TD>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="minPermissibleValue" ignore="true"/></TD>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="maxPermissibleValue" ignore="true"/></TD>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="undesirableEffect" ignore="true"/></TD>
					<TD class="mystyle1"><bean:write name="TESTRESULTS_LIST" property="testingParameterValue" ignore="true"/></TD>
			</tr>
			</nested:iterate>
			<tr>
				<td align="center" colspan="6">
					<html:button property="close" value="close" onclick="javascript:self.close()" />
				</td>
			</tr>
</BODY>
</html>
