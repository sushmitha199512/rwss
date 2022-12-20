<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF"
		style="border-collapse:collapse">
<thead>
<b>
<tr bgcolor="#8A9FCD">
	<td colspan="3"><font size="2" color="#111111" face="verdana"><b>Other Details</b></font></td>
</tr>
</thead>
<tbody>
<c:set var="item" value="${requestScope.proposalDTO}" />
	<tr class="row0">
		<td class="staticLabel" nowrap style="width:40%">
			<bean:message key="app.assemblyConstituency" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:59%">
			<c:out value='${item.constituencyName}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap style="width:40%">
			<bean:message key="app.representativeCode" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:59%">
			<c:out value='${item.repCode}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.representativeName"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.repName}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.representativeAddress"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			<c:out value='${item.repAddress}' escapeXml="false"/>
		</td>
	</tr> 
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.repDate" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.repDate}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.endorsedBy" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.endorsedBy}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.endorsementNo" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.endorsementNo}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.endorsementDate" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.endorsementDate}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.recommendations" />
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			<c:out value='${item.recommendations}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.priority" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.priorityCode}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.description" />
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			<c:out value='${item.description}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.remarks" />
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			<c:out value='${item.remarks}' escapeXml="false"/>
		</td>
	</tr>
</tbody>
</table>
<center><br>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
