<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
<%
String  code=(String)request.getAttribute("proposalId");
//System.out.println("code in dispaly"+code);
String subcode=code.substring(6,8);
//System.out.println("code in dispaly"+subcode);
%>
function fnSaveHabitations(frm)
{
	var habCodes = 	frm.elements("habCodes");
	var len;
	var isAllowed = false;
	if(habCodes)
	{
		if(typeof habCodes.length != 'number')
			habCodes = [habCodes];
		
		len = habCodes.length;
		for(var i=0; i<len; i++)
		{
			if(habCodes[i].checked)
				isAllowed = true;
		}
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations/Schools/Labs"))
			{
				var totalHabitations = frm.elements("habCodes");
				var noOfSelectedHabs = 0;
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
				var elem = openerDoc.getElementById("WORK[0].noOfHabs");
				elem.value = noOfSelectedHabs;
				return true;
			}
			else
			return false;
		}
		else
		{
			alert("Please select atleast one habitation.");
			return false;
		}
	}
}

function fnOpenerSubmit()
{
	
		var totalHabitations = document.forms[0].elements("habCodes");
		var noOfSelectedHabs = 0;
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
		var frm = openerDoc.forms[0];
		var url = "switch.do?prefix=/proposals&page=/EditAdminSanction.do&mode=kk";
		frm.action = url;
		frm.submit();
		window.close();
} 
//-->
</script>
</head>

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<html:form action="AddRemoveAdminHabs" onsubmit="return fnSaveHabitations(this)">
<table width="100%" cellspacing="0" cellpadding="1" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;">
<thead class="gridHeader">
<tr>
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
<c:forEach items="${newhabitations}" var="item" varStatus="status">
<c:set var="index" value="${status.index}"/>
<tr class="<c:out value='row${index%2}'/>">
	
	
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
	<td align="right"><c:out value='${item.schoolCode}'/></td>
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
<br>
<center>
	<html:submit property="mode" styleClass="btext">
		<bean:message key="button.save" />
	</html:submit>
	<html:button property="mode" styleClass="btext" onclick="javascript: fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
<input type="hidden" name="proposalId" value="<%= (String)request.getAttribute("proposalId")%>">
<input type="hidden" name="from" value="<%=  (String)request.getAttribute("from") %>">
</html:form>
<script language="JavaScript">
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
</body>
</html>

<%
	String message = (String)request.getAttribute("insert-success");
	if(message != null && message.equals("inserted"))
	{
%>
	<script>
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
		var openerDoc = opener.document;
		var frm = openerDoc.forms[0];
		//var proposalId = document.getElementById("proposalId").value;
		var url;
		if(document.getElementById("from").value == 'cons')
			url = "switch.do?prefix=/proposals&page=/NewProposalEditData.do&mode=showHabs&proposalId="+proposalId;
		else
		if(document.getElementById("from").value == 'admin')
			url = "switch.do?prefix=/proposals&page=/EditAdminProposal.do&mode=showHabs&proposalId="+proposalId;
		else	
			url = "switch.do?prefix=/proposals&page=/EditAdminSanction.do&mode=showHabs&proposalId="+proposalId;
	//	alert(url);
		frm.action = url;
		frm.submit();
		window.close();

	</script>
<%
	}
	if(message != null && message.equals("not-inserted"))
	{
%>	
	<script>
	<!--
		alert("Cannot add habitations.\nPlease try again...");
	//-->
	</script>
<%
	}
%>
