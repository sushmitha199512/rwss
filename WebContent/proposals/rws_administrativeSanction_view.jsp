<%@ include file="/commons/rws_header1.jsp"%>

<%
RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
String userid=user.getUserId();

%>
<script language="JavaScript">
function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=showHabs&proposalId="+proposalId;
	var properties = "width=748,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}

function fnDelete(index)
{
var proposalId=document.getElementById("proposalId["+index+"]").value;
var url="switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=Delete&proposalId="+proposalId+"&circleOfficeCode="+document.forms[0].circleOfficeCode.value;
if(confirm("Do you want to delete selected record?"))
{
document.forms[0].action=url;
document.forms[0].submit();
}
}
function fnEdit(workId,plan,workType)
{
	var url="switch.do?prefix=/proposals&page=/EditAdminSanction.do?mode=Edit&proposalId="+workId+"&plan="+plan+"&wrkType="+workType;
//	alert(url);
	var properties = "width=848,height=632,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="AdminstrativeSanctionSaveForm.do">
<html:hidden property="circleOfficeCode"/>
</html:form>
<c:set var="form"
value="${sessionScope['org.apache.struts.action.mapping.instance.name']}"
/>
<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=null">Back</a> 
	</td>
</tr>	
</thead>
<tbody>
<tr>
	<td class="reportTitle">AdminiStrativeSanction List</td>
</tr>
</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.workname" /></th>
	<th>Work Id</th>
	<%if(request.getParameter("typeOfAsset")!=null && !(request.getParameter("typeOfAsset").equals("11") ||request.getParameter("typeOfAsset").equals("12")))
				{%>
	<th>No. Of Habs</th>
	<%}%>
	 <% if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11"))
				{%>
				<th>No. Of Schools</th>
				<%}%>
				<%if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12"))
				{%>
				<th>No. Of Labs</th>
				<%}%>
 	<th>Sanctioned Amount</th>
	<th>Admin No.</th>
	<th>Admin Date</th>
	<th>Work Category</th>
 	<th>Scheme</th>
 	<th>Plan Type</th>
 	<th>Augmnt. Type</th>
	<th width="15%" colspan="2">Programme</th>
 	<th>Sub Programme</th>
	<th>Prepared By</th>
	<th>Prepared On</th>
	<th>Office Code</th>
	<th>CM-SEC Dashboard</th>
	<th>Select</th>
</tr>
</thead>
<tbody class="reportBody">
<c:set var="recordexists" value="false" />
<c:forEach items="${AdministrativeSanctionList}" var="item" varStatus="status" >
<c:set var="index" value="${status.index}" />
<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
<c:set var="recordexists" value="true" />
	<td><c:out value="${index+1}"/></td>
	<td width="135"><c:out value="${item.proposalName}" /></td>
	<td align="center"><c:out value="${item.proposalId}" /></td>
	<%if(request.getParameter("typeOfAsset")!=null && !(request.getParameter("typeOfAsset").equals("11") ||request.getParameter("typeOfAsset").equals("12")))
		{%>
         <td align="center" nowrap>
		<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs"  class="btext" 
			name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowHabs(this)">
	    </td>
	<%}%>
	 <% if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11"))
		{%>
		 <td align="center" nowrap>
		<c:out value="${item.noOfSchools}" />&nbsp;<input type="button" value="..." title="Show Selected Schools"  class="btext" 
			name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowHabs(this)">
	     </td>
	<%}%>
	<%if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12"))
		{%>
		<td align="center" nowrap>
		<c:out value="${item.noOfLabs}" />&nbsp;<input type="button" value="..." title="Show Selected Labs"  class="btext" 
			name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowHabs(this)">
	   </td>
	<%}%>
	<td align="right" nowrap>
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
					  	  value="${item.sanctionedAmount}" />
	</td>
 	<td align="center"><c:out value="${item.adminNo}" /></td>
	<td align="center"><c:out value="${item.adminDate}" /></td>
	<td align="center"><c:out value="${item.workCat}" /></td>
 	<td><c:out value="${item.typeOfAsset}" /></td>
 	<td><c:out value="${item.plan}" /></td>
 	<td><c:out value="${item.wrkType}" /></td>
	<td><c:out value="${item.programmeName}" /></td>
	<td><input type="button" value="..." title="Show Added Programme Details" align="right" class="btext"  
			  onclick="showAddedProg('<c:out value='${item.proposalId}'/>')">
	</td>
	<input type="hidden" value="<c:out value='${item.proposalName}'/>" id="P<c:out value='${item.proposalId}'/>"/>
	<input type="hidden" value="<c:out value='${item.proposalId}'/>" id="proposalId[<c:out value='${status.index}'/>]"/>
	 <script>
	 function showAddedProg(workId)
	 {
	 var workName=document.getElementById('P'+workId).value;
	  
	  var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=UpdatePrograms";
		var properties = "width=648,height=380,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=no";
		newWindow = window.open(url, "", properties);
	 }
	 </script>
	<td><c:out value="${item.subprogrammeName}" /></td>
	<td><c:out value="${item.preparedBy}" /></td>
	<td><c:out value="${item.preparedOn}" /></td>
	<td><c:out value="${item.officeCode}" /></td>
	<td><c:out value="${item.coreDashboardStatus}" /></td>
	<%-- <td align="center" nowrap>
		<!--<a href="switch.do?prefix=/proposals&page=/EditAdminSanction.do?mode=Edit&proposalId=<c:out value='${item.proposalId}'/>&plan=<c:out value='${item.plan}'/>&wrkType=<c:out value='${item.wrkType}'/>" id="edit">Edit</a>&nbsp;|&nbsp; -->
		
		<a href="#2" onclick="fnEdit('<c:out value='${item.proposalId}'/>','<c:out value='${item.plan}'/>','<c:out value='${item.wrkType}'/>')">Edit</a>&nbsp;
		
		<!--<a href="#1" onclick="return fnDelete(<c:out value='${status.index}'/>)" id="delete">Delete</a>-->
	</td> --%>
	<td align="center" nowrap>
	<c:choose>
		<c:when test="${item.physicalSatus=='AdminSanctioned'}">
			<a href="#2" onclick="fnEdit('<c:out value='${item.proposalId}'/>','<c:out value='${item.plan}'/>','<c:out value='${item.wrkType}'/>')">Edit</a>&nbsp;
		</c:when>
		<c:otherwise>
			<c:out value="${item.physicalSatus}" />
		</c:otherwise>
	</c:choose>	
	</td>
</tr>
</c:forEach>
<c:if test="${recordexists == 'false'}" > 
	<tr >
<td colspan=18 align="center" class="rptValue">No Records Matched Your Selection
</td>
	</tr>
	</c:if>
</tbody>
</table>

<br>

<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />

<%@ include file="/commons/rws_alert.jsp"%>