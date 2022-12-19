<%@ include file="/commons/rws_header1.jsp"%>
	<script language="JavaScript">
		function fnEdit(workId){	
			var url="switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do?mode=RevisedEdit&showHabs=true&initial=true&proposalId="+workId;
			var properties = "width=848,height=632,toolbar=no,status=no,menubar=no,location=no,directories=no,"
						   + "scrollbars=yes,copyhistory=no,resizable=yes";
			var newWindow = window.open(url, "", properties);
		}
		
		function fnDeleteRev(workId){
			if(confirm("Are you sure to want to delete the revised work details")) {
				var url="switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do?mode=DeleteRev&proposalId="+workId;
				var properties = "width=10,height=10,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				    + "scrollbars=yes,copyhistory=no,resizable=yes";
				var newWindow = window.open(url, "", properties);
			}
		}
		
		function fnShowHabs(proposalId){
			var proposalId = proposalId.name;
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=showHabs&proposalId="+proposalId;
			var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
						   + "scrollbars=yes,copyhistory=no,resizable=yes";
			var newWindow = window.open(url, "", properties);
			newWindow.moveTo(10,10);
		}
		
		function fnShowRevHabs(proposalId){
			var proposalId = proposalId.name;
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanctionSaveForm.do?mode=showRevHabs&proposalId="+proposalId;
			var properties = "width=548,height=235,toolbar=no,left=100,right=200,status=no,menubar=no,location=no,directories=no,"
						   + "scrollbars=yes,copyhistory=no,resizable=yes";
			var newWindow = window.open(url, "", properties);
			newWindow.moveTo(10,10);
		}
	</script>
<%@ include file="/commons/rws_header2.jsp"%>
<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
	<thead>
		<tr>
			<td align="right">
				<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
				<a href="switch.do?prefix=/proposals&page=/RevisedSanction.do">Back</a> 
			</td>
		</tr>	
	</thead>
	<tbody>
		<tr>
			<td class="reportTitle">Revised Sanction List</td>
		</tr>
	</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
	<thead class="reportHead">
		<tr>
			<th colspan="4"> </th>
			<th colspan="3">Administrative Sanction 
			<th colspan="3">Revised Sanction </th>				
			<%if(request.getParameter("typeOfAsset")!=null && (request.getParameter("typeOfAsset").equals("03") ||request.getParameter("typeOfAsset").equals("01") ||request.getParameter("typeOfAsset").equals("10"))){%>
			<th colspan="2">Habitations </th>
			<%}if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")){%>
			<th colspan="2">Schools </th>
			<%}if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")){%>
			<th colspan="2">Labs </th>
			<%}%>			   
		    <th colspan="5"></th>
		</tr>
		<tr>	
		   <th>S.No</th>
		   <th><bean:message key="app.workName" /></th>
		   <th>Work Id</th>
		   <th>Office Code</th>
		   <th>Ref. Number</th>
		   <th>Ref. Date</th>
		   <th>Amount</th>
		   <th>Ref. Number</th>
		   <th >Ref. Date</th>
		   <th>Amount</th>
		    <th>AdminStrative   </th>
		   <th>Revised   </th>
		   <th>Programme</th>
		   <th>Select</th>
		</tr>
	</thead>
	<tbody class="reportBody">
		<c:set var="recordexists" value="false" />
		<c:forEach items="${RevisedSanctionList}" var="item" varStatus="status">
		<c:set var="index" value="${status.index}" />
		<tr onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
			<c:set var="recordexists" value="true" />
			<td><c:out value="${index+1}"/></td>
			<td width="135"><c:out value="${item.proposalName}" /></td>
			<td align="center"><c:out value="${item.proposalId}" /></td>
			<td align="center"><c:out value="${item.officeCode}" /></td>
		    <td><c:out value="${item.adminNo}" /></td>
		    <td><c:out value="${item.adminDate}" /></td>	 
			<td align="right" nowrap><fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1" value="${item.sanctionedAmount}" /></td>
		    <td><c:out value="${item.revAdminNo}" /></td>
		    <td><c:out value="${item.revAdminDate}" /></td>	 
			<td align="right" nowrap><fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1" value="${item.revSanctionedAmount}" /></td>
			<td align="center" nowrap><c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowHabs(this)"></td>
			<td align="center" nowrap><c:out value="${item.revNoOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowRevHabs(this)"></td>
			<td><c:out value="${item.programmeName}" /><input type="button" value="..." title="Show Added Programme Details" align="right" class="btext" onclick="showAddedProg('<c:out value='${item.proposalId}'/>')"></td>
			<input type="hidden" value="<c:out value='${item.proposalName}'/>" id="P<c:out value='${item.proposalId}'/>"/>
	 		<script>
	 			function showAddedProg(workId){
	 				var workName=document.getElementById('P'+workId).value;	   
	  				var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=UpdateRevPrograms&revisedList=revisedList&revstat=revstat";
					var properties = "width=648,height=380,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=no";
					newWindow = window.open(url, "", properties);
	 			}
	 		</script>
 			<td align="center" nowrap>
				<a href="#1" onclick="fnEdit('<c:out value='${item.proposalId}'/>')">Edit</a>&nbsp;|
				<a href="#1" onclick="fnDeleteRev('<c:out value='${item.proposalId}'/>')">Delete</a>&nbsp;
			</td>
		</tr>
		</c:forEach>
		<c:if test="${recordexists == 'false'}" > 
			<tr >
				<td colspan=18 align="center" class="rptValue">No Records Matched Your Selection</td>
			</tr>
		</c:if>
	</tbody>
</table>
<br/>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />
<%@ include file="/commons/rws_alert.jsp"%>