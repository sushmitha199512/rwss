<%@ include file="/commons/rws_header1.jsp" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<style>
.label
{
	font-family: verdana;
	font-size: .9em;
	font-weight: bold;
}
</style>
<script language="JavaScript">
<!--
function fnClose()
{
	window.close();
}
//-->
</script>
</head>
<body bgcolor="" topmargin="0" leftmargin="0">
<c:set var="item" value="${requestScope.proposalVO}" />
<table cellpadding="2" cellspacing="0">
<tr bgcolor="#8A9FCD">
	<td colspan="6"><font size="2" color="#FFFFFF" face="verdana"><b>Work Details</b></font></td>
</tr>

<tbody>
<tr>
	<td class="myfontclr" nowrap>Work Id</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.workId}" /></td>
	<td class="myfontclr" nowrap>Work Name</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.proposalName}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>No. of Habs</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.noOfHabs}" /></td>
	<td class="myfontclr" nowrap>Asset Type</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.assetName}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Programme</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.programmeName}" /></td>
	<td class="myfontclr" nowrap>Sub Programme</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.subprogrammeName}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Sanctioned At</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.sanctionedAt}" /></td>
	<td class="myfontclr" nowrap>Sanctioning Authority</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.sanctioningAuthority}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Admin No.</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.adminNo}" /></td>
	<td class="myfontclr" nowrap>Admin Date</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.adminDate}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Go No.</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.goNo}" /></td>
	<td class="myfontclr" nowrap>Estimate Cost</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.estimateCost}" />&nbsp; <FONT SIZE="" COLOR="red">lakhs</FONT></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Sanctioned Amount</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.sanctionedAmount}" />&nbsp; <FONT SIZE="" COLOR="red">lakhs</FONT></td>
	<td class="myfontclr" nowrap>Phased</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.phased}" /></td>
</tr>
<tr>
	<td class="myfontclr" nowrap>Phase No.</td>
	<td>:</td>
	<td class="staticLabel" nowrap><c:out value="${item.phaseNo}" /></td>
	
	
</tr>
<tr>
	<td colspan="6" align="center">
		<input type="button" value="Close" class="btext" 
			   onclick="javascript: fnClose()">
	</td>
</tr>
</tbody>
</table>
</body>
</html>