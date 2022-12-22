<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
<%
String  code=(String)request.getAttribute("proposalId");
if(code==null)
	code=request.getParameter("proposalId");
//System.out.println("code in revised dispaly"+code);
String subcode=code.substring(6,8);
//System.out.println("code in revised dispaly"+subcode);
%>
function searchHab()
{

}

function fnAdd(frm)
{
	var selectedHabs = 	frm.elements("habCodes");
	var len;
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations?"))
			{
				var index = document.getElementById("index").value;
				var totalHabitations = document.forms[0].elements("habCodes");
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
							noOfSelectedHabs++;  
					}
				}
				var openerDoc = opener.document;
				openerDoc.getElementById("WORK["+index+"].revNoOfHabs").value = noOfSelectedHabs;
				document.forms[0].noOfSelectedHabs.value = noOfSelectedHabs;
				return true;
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
}

function fnOpenerSubmit()
{
	
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="SaveRevisedEditHabitation" onsubmit="return fnAdd(this)">

<logic:notEmpty name="habitations">

<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
		<%if(! (subcode.equals("11")|| subcode.equals("12")))
	{%>
		<th>Mandals</th>	
		<TH>Panchayat</TH>
		<th>Village</th>
		<th><bean:message key="app.habitationCode" /></th>
		<th><bean:message key="app.habitationName" /></th>
		<th><bean:message key="app.population" /></th>
		<th><bean:message key="app.status" /></th>
	<%} else if(subcode.equals("11")){%>
		
		<th><bean:message key="app.habitationCode" /></th>
		<th><bean:message key="app.habitationName" /></th>
		<th>School Code</th>
		<th>School Name</th>
	<%}else if(subcode.equals("12")){%>
		<th>Location</th>	
		<th>Lab Code</th>
		<th>Lab Name</th>
	<%}%>
</tr>
</thead>
<tbody class="gridText">
<c:forEach items="${habitations}" var="item" varStatus="status">
<tr>
		<%if(! (subcode.equals("11")|| subcode.equals("12")))
	{%>
<td align="center">
		<input type="checkbox" name="habCodes" value="<c:out value='${item.habCode}'/>"/>
	</td>
	<td align="center"><c:out value='${item.mandalName}'/></td>
	<td align="center"><c:out value='${item.panchayatName}'/></td>
	<td align="center"><c:out value='${item.villageName}'/></td>
	<td align="center"><c:out value='${item.habCode}'/></td>
	<td><c:out value='${item.habName}'/></td>
	<td align="right"><c:out value='${item.population}'/></td>
	<td align="center"><c:out value='${item.status}'/></td>
	<%} else if(subcode.equals("11")){%>
	<td align="center">
		<input type="checkbox" name="habCodes" value="<c:out value='${item.schoolCode}'/>"/>
	</td>
	
	<td align="center"><c:out value='${item.habCode}'/></td>
	<td><c:out value='${item.habName}'/></td>
	<td align="right"><c:out value='${item.schoolLocation}'/></td>
	<td align="center"><c:out value='${item.schoolName}'/></td>
	<%} else if(subcode.equals("12")){%>
	<td align="center">
		<input type="checkbox" name="habCodes" value="<c:out value='${item.labCode}'/>"/>
	</td>
		<td align="center"><c:out value='${item.location}'/></td>
	<td align="right"><c:out value='${item.labCode}'/></td>
	<td align="center"><c:out value='${item.labName}'/></td>
	<%}%>
</tr>
</c:forEach>
</tbody>
</table>
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:submit property="mode" value="Add" styleClass="btext"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="habitations">
<center><b class="gridLabel">
There are no habitations in the selected office.
<br>Please select different office</b><br> 
<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:empty>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">

<script>
<!-- 

var frm = document.forms[0];
var habs = frm.elements("habCodes");
if(habs)
{
	if(typeof habs.length != 'number')
		habs = [habs];
		var workId = document.forms[0].proposalId.value;
	//alert(workId);
	var subcode = workId.substr(6,2);
//	alert(subcode);
	for(var i=0; i<habs.length; i++)
	{
		 if(subcode=="12")
		{
			<c:forEach items="${selectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.labCode}" />')
				habs[i].checked = true;
		</c:forEach>	
		}else  if(subcode=="11"){
		<c:forEach items="${selectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.schoolCode}" />')
				habs[i].checked = true;
		</c:forEach>	
		}
		else {
			<c:forEach items="${selectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.habCode}" />')
				habs[i].checked = true;
		</c:forEach>	
		}	
	}
}
//-->
</script>
<input type="hidden" name="noOfSelectedHabs">
</html:form>
</body>
</html>

<%
	String message = (String)request.getAttribute("insert-success");
	if(message != null && message.equals("inserted"))
	{
%>
	<script>
	<!--
		var index = document.getElementById("index").value;
		var openerDoc = opener.document;
		//var proposalId='<%=(String)request.getParameter("proposalId")%>';
		var proposalId = document.getElementById("proposalId").value;
var  code=proposalId.substring(6,8);
//alert(code);
	if (code=="12")
	{
	alert("Labs added successfully.\n Press OK to continue...");
	}
	else if  (code=="11")
	{
	alert("Schools added successfully.\n Press OK to continue...");
	}
	else{
	alert("Habitations added successfully.\n Press OK to continue...");
	}
		var noOfSelectedHabs = '<%=request.getParameter("noOfSelectedHabs")%>';
		var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do?mode=RevisedEdit&showHabs=false&proposalId="+proposalId+"&noOfSelectedHabs="+noOfSelectedHabs;
		openerDoc.getElementById("WORK["+index+"].revNoOfHabs").value = noOfSelectedHabs;
		openerDoc.forms[0].action = url;
		openerDoc.forms[0].submit();
		window.close();
	//-->
	</script>
<%
	}
	
	if(message != null && message.equals("not-inserted"))
	{
%>
	<script>
	<!--
		alert("Cannot add habitations.\n Please try again.");
		openerDoc.getElementById("WORK["+index+"].noOfHabs").value = "";
	//-->
	</script>
<% 
	}
%> 