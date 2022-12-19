<%@ include file="/commons/rws_header1.jsp" %>

</head>

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<c:set var="sourceDTO" value="${requestScope.sourceDTO}" />

<table width="100%" cellpadding="1" cellspacing="0" border="1" bordercolor="#ffffff" style="border-collapse:collapse">
<caption align="left" class="staticLabelBold">Source Details</caption>
<tbody>
<colgroup class="staticLabel"></colgroup>
<colgroup class="staticLabelBold"></colgroup>
<colgroup class="staticLabel"></colgroup>
<colgroup class="staticLabelBold"></colgroup>
<tr class="row0">
	<td>Source Code</td>
	<td><c:out value="${sourceDTO.sourceCode}" /></td>
	<td>Source Name</td>
	<td><c:out value="${sourceDTO.sourceName}" /></td> 
</tr>

<tr class="row1">
	<td>Source Type</td>
	<td><c:out value="${sourceDTO.sourceTypeCode}" /></td>
	<td>Sub Source Type</td>
	<td><c:out value="${sourceDTO.subSourceTypeCode}" /></td> 
</tr>

<tr class="row0">
	<td>No. of Habitations</td>
	<td><c:out value="${sourceDTO.noOfHab}" /></td>
	<td>Lead Habitation</td>
	<td><c:out value="${sourceDTO.habCode}" /></td> 
</tr>

<tr class="row1">
	<td>Population Benefited</td>
	<td><c:out value="${sourceDTO.popbenefited}" /></td>
	<td>Seasonal</td>
	<td><c:out value="${sourceDTO.seasonal}" /></td> 
</tr>

<tr class="row0">
	<td>Present Condition</td>
	<td><c:out value="${sourceDTO.presentCondition}" /></td>
	<td>Water Quality</td>
	<td><c:out value="${sourceDTO.waterQuality}" /></td> 
</tr>

<tr class="row1">
	<td>Static Water Level</td>
	<td><c:out value="${sourceDTO.staticWaterLevel}" /> (lpcd)</td>
	<td>Summer Water Level</td>
	<td><c:out value="${sourceDTO.summerWaterLevel}" /> (lpcd)</td> 
</tr>
<tr class="row0">
	<td>Yield</td>
	<td><c:out value="${sourceDTO.yield}" /> (lpm)</td>
	<td>Distance From Source</td>
	<td><c:out value="${sourceDTO.distFromSource}" /> (kms)</td> 
</tr>

<tr class="row1">
	<td>Location</td>
	<td><c:out value="${sourceDTO.location}" /></td>
	<td></td>
	<td></td> 
</tr>
<tr>
	<td colspan="4" align="center">
		<input type="button" value="Close" class="btext" 
			   onclick="javascript: fnClose()">
	</td>
</tr>
</tbody>
</table>
</body>
</html>