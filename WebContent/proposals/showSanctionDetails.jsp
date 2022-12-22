<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<c:set var="item" value="${requestScope.proposalDTO}" />
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF"
		style="border-collapse:collapse">
<c:if test="${requestScope.type == 'om'}" >
	<thead>
	<tr bgcolor="#8A9FCD">
		<td colspan="3"><font size="2" color="#111111" face="verdana"><b>Other Details</b></font></td>
	</tr>
	</thead>
	<tbody>
	<tr class="row0">
		<td class="staticLabel" nowrap style="width:40%">
			<bean:message key="app.proposalId" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:59%">
			<c:out value='${item.proposalId}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap style="width:40%">
			<bean:message key="app.assetCode" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:59%">
			<c:out value='${item.assetCode}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.financialYear"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.financialYear}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.estimateCost"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			Rs. <fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.estimateCost}" />&nbsp;(in lakhs)
		</td>
	</tr> 
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.sanctioningAuthority" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.sanctioningAuthority}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.sanctionedAt" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.sanctionedAt}' escapeXml="false"/>
		</td>
	</tr>
</tbody>
</c:if>	

<c:if test="${requestScope.type == 'new'}" >
	<thead>
	<tr bgcolor="#8A9FCD">
		<td colspan="6"><font size="2" color="#111111" face="verdana"><b>Oter Details</b></font></td>
	</tr>
	</thead>
	<tbody>
	<tr class="row0">
		<td class="staticLabel" nowrap style="width:20%">
			<bean:message key="app.proposalId" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:29%">
			<c:out value='${item.proposalId}' escapeXml="false"/>
		</td>
		<td class="staticLabel" nowrap style="width:20%">
			No. of Habs
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:29%">
			<c:out value='${item.noOfHabs}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap style="width:20%">
			<bean:message key="app.assemblyConstituency" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:29%">
			<c:out value='${item.constituencyName}' escapeXml="false"/>
		</td>
		<td class="staticLabel" nowrap style="width:20%">
			<bean:message key="app.repCode" />
		</td>
		<td style="width:1%">:</td>
		<td class="staticLabelBold" nowrap style="width:29%">
			<c:out value='${item.repCode}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.repName"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.repName}' escapeXml="false"/>
		</td>
		<td class="staticLabel" nowrap>
			<bean:message key="app.address"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.repAddress}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.endorsedBy"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.ministerFor}' escapeXml="false"/>&nbsp;
			<c:out value='${item.endorsedBy}' escapeXml="false"/>&nbsp;
			<c:out value='${item.others}' escapeXml="false"/>
		</td>
		<td class="staticLabel" nowrap>
			<c:if test="${item.endorsedBy == 'CMP'}">
				<bean:message key="app.cmpNo"/>
			</c:if>
			<c:if test="${item.endorsedBy != 'CMP'}">
				<bean:message key="app.endorsementNo"/>
			</c:if>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.endorsementNo}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.recommendations"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.recommendations}' escapeXml="false"/>&nbsp;
		</td>
		<td class="staticLabel" nowrap>
			<bean:message key="app.priority"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold" nowrap>
			<c:out value='${item.priorityCode}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row1">
		<td class="staticLabel" nowrap>
			<bean:message key="app.sanctionedAt" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.sanctionedAt}' escapeXml="false"/>
		</td>
		<td class="staticLabel" nowrap>
			<bean:message key="app.sanctioningAuthority" />
		</td>
		<td>:</td>
		<td nowrap class="staticLabelBold">
			<c:out value='${item.sanctioningAuthority}' escapeXml="false"/>
		</td>
	</tr>
	<tr class="row0">
		<td class="staticLabel" nowrap>
			<bean:message key="app.estimateCost"/>
		</td>
		<td>:</td>
		<td class="staticLabelBold">
			Rs. <fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
						  	  value="${item.estimateCost}" />&nbsp;(in lakhs)
		</td>
		<td></td>
		<td></td>
		<td></td>
	</tr> 
	</tbody>
</c:if>
</table>

<c:if test="${not empty requestScope.selectedHabitationss}">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<caption align="left" class="staticLabelBold" style="color: #344A7A">Selected Habitations</caption>	   
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">
	<c:forEach items="${requestScope.selectedHabitationss}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center"><c:out value='${item.habCode}'/></td>
		<td><c:out value='${item.habName}'/></td>
		<td align="right"><c:out value='${item.population}'/></td>
		<td><c:out value='${item.status}'/></td>
	</tr>
	</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of Selected Habitations:&nbsp;<c:out value="${index+1}" />
	</th>
</tr>
</tfoot>
</table>
</c:if>

<center><br>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
