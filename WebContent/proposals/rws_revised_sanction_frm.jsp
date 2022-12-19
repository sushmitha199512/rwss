<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%int hCount = 0;%>
<script language="JavaScript">
	function showFields(){
		<%if(request.getAttribute("resetForm") == null){%>
			if(document.forms[0].typeOfAsset.value==""){
				document.forms[0].workCat.value="";
				document.forms[0].circleOfficeCode.value="";
				document.forms[0].divisionOfficeCode.value="";
				document.forms[0].subdivisionOfficeCode.value="";
			}
		<%}%>
		if (document.forms[0].plan[0].checked){
			document.forms[0].wrktype[0].disabled=false;
			document.forms[0].wrktype[1].disabled=false;
			document.forms[0].wrktype[2].disabled=true;	   	
		}
		else if (document.forms[0].plan[1].checked)	{
			document.forms[0].wrktype[0].disabled=true;
			document.forms[0].wrktype[1].disabled=true;
			document.forms[0].wrktype[2].disabled=false;
			document.forms[0].wrktype[2].checked=true;
		}
		else{
		    document.forms[0].wrktype[0].disabled=false;
			document.forms[0].wrktype[1].disabled=false;
			document.forms[0].wrktype[2].disabled=true;
		}
	}
	
	function checkMe(type){
		if(type==0)	{
			document.forms[0].wrktype[0].checked=true;
		}
		else if(type==1){
			document.forms[0].wrktype[1].checked=true;
		}
	}
	
	function fnSubmit(){
		var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do";
		var frm = document.forms["AdminstrativeSanctionForm"];
		frm.action = url;
		frm.submit();
	}
	
	function getWorks(){
		document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=getWorks";
		document.forms[0].submit();
	}
	function getScheme(){
		document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=scheme"
		document.forms[0].submit();
	}
	function fnGetOffices(that){
		var field = that.name;	
		var frm = that.form;
		var url;
		if(field == 'headOfficeCode')
		 	url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=circles";
		else if(field == 'circleOfficeCode')
		 	url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=divisions";
		else if(field == 'divisionOfficeCode')	
			url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=subdivisions";		
		frm.action = url;
		frm.submit();
	}
	
	function getProgrammes(){
		document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=programmes";
		document.forms[0].submit();
	}
	  
	function fnGetSubprogrammes(elem){
		var index = elem.name.substr(5,1);	
		var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=subprogrammes&index="+index;
		var frm = document.forms["AdminstrativeSanctionForm"];
		frm.action = url;
		frm.submit();
	}
	
	function fnGetWorkDetails(elem){
		var workId = document.getElementById('proposalName').value;
		var combo1 = document.getElementById('proposalName');
	    var workName = combo1.options[combo1.selectedIndex].text
	 	var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=workDetails&workId="+workId+"&workName="+workName;
		var frm = document.forms["AdminstrativeSanctionForm"];
		frm.action = url;
		frm.submit();
	}
	
	var newWindow;
	function fnPickHabitations(index){    
		var hoc = document.getElementById("headOfficeCode").value;
		var coc = document.getElementById("circleOfficeCode").value;
		var workId = document.getElementById('proposalName').value; 
		if(coc == '')
			alert("Please select circle.");
		if(workId=='')
		     alert("Select WorkName");	
		else{			
			var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
			var width = 648;
			var height = 332;
			var left = parseInt((screen.availWidth/2)-(width/2));
			var top = parseInt((screen.availHeight/2)-(height/2));	
			var url = "switch.do?prefix=/proposals&page=/PickRevisedHabitation.do&mode=pickRevhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId+"&index="+index+"&All=yes&assetcode="+document.forms[0].typeOfAsset.value+"&flag="+false;
		    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				+ "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,resizable=yes";
			if( !newWindow || newWindow.closed)	{
				newWindow = window.open(url, "", properties);
			}
			else{
				newWindow.focus();
			}
		}
	}
	
	function  fnView(){	
		document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=RevisedView";
		document.forms[0].submit();
	}
	
	function fnSave(){	 
		if(validateWorks());
	}  
	
	function showAddedProg(index) {
	 	var x=document.getElementById("proposalName");
		var y=x.options[x.selectedIndex].text;
	    var workId=  document.getElementById("WORK["+index+"].proposalId").value;
	    var workName=y;    
	    if(workId!='') {
		 	var url = "switch.do?prefix=/proposals&page=/AddMoreProgramsForOneWork.do?workId="+workId+"&workName="+workName+"&mode=UpdatePrograms&AddrevisedProgs=YES";
			var properties = "width=750,height=380,toolbar=no,status=yes,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,resizable=no";
			var newWindow = window.open(url, "", properties);
		}	 
		else{
			alert("Select  Work Name");
			document.getElementById("WORK["+index+"].augmentation").checked=false;
			return;
		}
	}
</script>
<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />

<body onunload="rm()" onload="showFields();selLead()" >
	<html:form action="RevisedSanctionSaveForm" >
		<table cellpadding="0" cellspacing="0">
			<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
			<thead>
				<tr>
					<th>
						<jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName" value="Revised Sanction Form" />
							<jsp:param name="TWidth" value="100%" />
						</jsp:include>
					</th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td>
						<jsp:include page="/commons/TableFotter.jsp">
							<jsp:param name="TWidth" value="100%"/>
						</jsp:include>
					</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td>
						<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
							<tr>
								<td>
									<fieldset>
										<legend><bean:message key="legend.rwsOffices"/></legend>
										<label>
											<table>
												<tbody class="formTBody">
													<tr>
														<td class="column1"><bean:message key="app.headoffice" />
															<span class="mandatory">*</span>
														</td>
														<td class="column2">
															<logic:equal name="RWS_USER" property="headOfficeCode" value="0">
																<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)" styleClass="combo">
																	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																	<html:options collection="headOffices" name="labelValueBean" property="value" labelProperty="label" />
																</html:select>
															</logic:equal>
															<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
																<html:text property="headOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
																<html:hidden property="headOfficeCode" name="RWS_USER"/>
															</logic:notEqual>
														</td>
														 <td class="column3">
												         	<html:radio value="1" property="plan" onclick="showFields();checkMe(0);getProgrammes();"/>Plan
												         </td>
												         <td class="class4">
												         	<html:radio value="2" property="plan" onclick="showFields();getProgrammes();"/>Non-Plan
												    	 </td> 														
													</tr>
													<tr>
														<td class="column1">Work Category<span class="mandatory">*</span></td>
											        	<td class="class2">
													        <html:select property="workCat" onchange="javascript:getScheme();" styleClass="combo">
													    		<html:option value="">SELECT...</html:option>
													    	    <logic:present name="workcategory" >
														            <html:options collection="workcategory"  name="labelValueBean" property="value" labelProperty="label" />
														        </logic:present>
														 	</html:select>
														</td> 
														<td class="column3">Scheme<span class="mandatory">*</span></td>
														<td class="column4">
													 		<html:select property="typeOfAsset" styleClass="combo" onchange="getProgrammes();">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
														 		<logic:present name="assetTypes">
														 			<html:options collection="assetTypes" name="labelValueBean" property="value" labelProperty="label" />
														 		</logic:present>
														 	</html:select>
											 		  	</td>
												  	</tr>
												    <tr>
											 		   	<td colspan="2" nowrap>
															<html:radio value="1" property="wrktype" onclick="getProgrammes();"/>MainScheme
											           		<html:radio value="2" property="wrktype" onclick="checkMe(1);getProgrammes();"/>Augmentation
															<html:radio value="3" property="wrktype" onclick="getProgrammes();"/>Maintenance
											            </td>
											   	      	<td class="column3">Programme <span class="mandatory">*</span></td>
													   <logic:present name="programmes" >
													 		<td class="column4">
																<html:select property="programs" style="width:150px" styleClass="mycombo" onchange="javascript: fnGetSubprogrammes(this)" >
														            <html:option value=""><font class="myfontclr1">SELECT...</html:option>
														            <html:options collection="programmes"  name="labelValueBean" property="value" labelProperty="label" />
													            </html:select>
															</td>
													   </logic:present>
													   <logic:notPresent name="programmes">
														    <td class="column4">
														        <html:select property="programs" style="width:150px" styleClass="mycombo">
													            	<html:option value=""><font class="myfontclr1">SELECT...</html:option>
													            </html:select>
															</td>
													  </logic:notPresent>
												  </tr>
											 	  <tr>
													  <td class="column1">Sub Programme<span class="mandatory">*</span></td>
													  <td class="column2">
												 		<html:select property="subPrograms"  styleClass="combo"> <!-- onchange="getWorks();" -->
															<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
															<logic:present name="SubPrograms">
														 		<html:options collection="SubPrograms" name="SubPrograms" property="value" labelProperty="label" />
															</logic:present>			  
												 		</html:select>
												 	  </td>		 
												      <td class="column3"><bean:message key="app.circle" /><span class="mandatory">*</span></td>
													  <td class="column4">
													  <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
														  <html:select property="circleOfficeCode" onchange="javascript: fnGetOffices(this)" styleClass="combo">
															  <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
															  <logic:notEmpty name="circles">
																  <html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
															  </logic:notEmpty>			  
														  </html:select>
													  </logic:equal>
													  <logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
														  <html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
														  <html:hidden property="circleOfficeCode" name="RWS_USER" />
													  </logic:notEqual>
												 	  </td>
												  </tr>
												  <tr>
													  <td class="column1"><bean:message key="app.division" /><span class="mandatory">*</span></td>
													  <td class="column2">
															<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
																<html:select property="divisionOfficeCode"  onchange="javascript: fnGetOffices(this);getWorks();" styleClass="combo">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<logic:present name="divisions">
																	<html:options collection="divisions" name="labelValueBean" property="value" labelProperty="label" />
																</logic:present>			  
																</html:select>
															</logic:equal>
															<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
																<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
																<html:hidden property="divisionOfficeCode" name="RWS_USER" />
															</logic:notEqual>
													  </td>
													  <td class="column1">SubDivision</td>
											          <td class="column2">
											    		  <logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
															  <html:select property="subdivisionOfficeCode" styleClass="combo" onchange="JavaScript:getWorks();">
															    	<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
															  		<logic:notEmpty name="subdivisions">
																  		<html:options collection="subdivisions" name="labelValueBean" property="value" labelProperty="label" />
															  		</logic:notEmpty>
															  </html:select>
														  </logic:equal>
														  <logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
															  <html:text property="subdivisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
															  <html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
														  </logic:notEqual>
													  </td> 		 
												  </tr>
											  </tbody>
										  </table>
									   </label>
									</fieldset>
								</td>
							</tr>	
							<tr>
								<td>
									<fieldset>
										<legend><bean:message key="legend.workDetails" /></legend>
										<label>
											<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>							
														<Th colspan="1"> </Th>
														<th colspan="3">Original Administrative Sanction Ref
														<th colspan="3">Revised Sanction Ref </th>
												 		<Th colspan="2"></Th>
													</tr>
													<tr>									
													    <th><bean:message key="app.workName" /></th>
													    <th width="20%">Ref. Number</th>
													    <th>Ref. Date</th>
													    <th width="20%">Amount </th>
													    <th width="15%" >Ref. Number</th>
													    <th width="22%" >Ref. Date</th>
													    <th  width="15%">Amount</th>
													    <%if(request.getParameter("typeOfAsset")!=null && (request.getParameter("typeOfAsset").equals("03") ||request.getParameter("typeOfAsset").equals("01") ||request.getParameter("typeOfAsset").equals("10"))){%>
													    <th rowspan=2>Add/Remove Habitations</th>
													    <%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")){%>
													    <th rowspan=2 >Add/Remove  Schools</th>
													    <%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")){%>
													    <th rowspan=2 >Add/Remove Labs</th> 
													    <%}else if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("13")){%>
													    <th rowspan=2 >Select Offices</th> 
													    <%} else{%>
													    <th>Add/Remove  </th>
													    <%}%>			  
													    <th>More Than One Programme</th>	
													</tr>		 
							 					</thead>
												<tbody>
													<% int workCount = 0; int count=0;%>
													<nested:iterate id="WORK" property="proposals" indexId="ndx">
													<% workCount++; %>
													<tr bgcolor="#ffffff">				 
														<td>					
															<nested:select name="WORK" property="proposalName" style="width: 150px" styleClass="noborder-text-box" onchange="javascript: fnGetWorkDetails(this)">
																<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
																<logic:present name="WorkIds">
																	<nested:options collection="WorkIds" name="labelValueBean" property="value" labelProperty="label" />
																</logic:present>
															</nested:select>					
														</td>			 
														<td>
															<nested:text name="WORK" property="adminiStrativeNum" readonly="true" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
														</td>
														<td>
															<nested:text name="WORK" property="adminiStrativeDate" readonly="true" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box"  onkeypress="return decimalsOnly(event);"/>
														</td>
													 	<td>
															<nested:text name="WORK" property="sanctionAmout"  readonly="true" indexed="true" maxlength="9" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
														</td>
														<td>
															<nested:text name="WORK" property="revisedAdminiStrativeNum" indexed="true" maxlength="50" style="width: 100px;text-align: left" styleClass="noborder-text-box"/>
														</td>				
														<td NOWRAP>
															<nested:text name="WORK" property="revisedAdminiStrativeDate" indexed="true" readonly="true" maxlength="9" style="width: 69px;text-align: right"/>
															<a href="javascript:showCalendar(document.getElementById('WORK[<%=count++%>].revisedAdminiStrativeDate'));"><img src="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>	 
														</td>
														<td>
															<nested:text name="WORK" property="revisedSanctionAmout" indexed="true" maxlength="20" style="width: 55px;text-align: right" styleClass="noborder-text-box" onkeypress="return decimalsOnly(event)"/>
														</td>				
													 	<td> 
															<nested:hidden name="WORK" property="proposalId" indexed="true"  />				 
															<nested:text name="WORK" property="noOfHabs" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 25px"/>
															<html:button property="addHab" value="..." styleClass="btext" onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
														</td>
														 <td align="center">
															<nested:checkbox name="WORK" property="augmentation" value="Y" indexed="true" onclick='<%= "javascript: showAddedProg(\" + ndx +\")"%>'/>
											 			</td>				 
													</tr>
													</nested:iterate>
													<input type="hidden" name="workCount" value="<%= workCount %>">
												</tbody>
											</table>
											<table width="100%">
												<tr>
													<td align="left">
														<% if(workCount <= 1) { %>				
															<html:button property="mode" styleClass="btext" style="width:120px" onclick="return fnRemove(this)" disabled="true"><bean:message key="button.removeWorks" /></html:button>
														<% } else {%>
															<html:button property="mode" styleClass="btext" style="width:120px" onclick="return fnRemove(this)"><bean:message key="button.removeWorks" /></html:button>
														<% } %>
							
													</td>
												</tr>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<c:if test="${not empty selectedHabs}">
							<%if(request.getParameter("typeOfAsset")!=null && !(request.getParameter("typeOfAsset").equals("11")  || request.getParameter("typeOfAsset").equals("12"))){%>
							<tr>
								<td>
									<fieldset>
										<legend><bean:message key="legend.habitationDetails" /></legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>
														<th><bean:message key="app.leadHabitation" /></th>
														<th><bean:message key="app.habitationCode" /></th>
														<th><bean:message key="app.habitationName" /></th>
														<th><bean:message key="app.population" /></th>
														<th><bean:message key="app.status" /></th>
													</tr>
												</thead>
												<tbody class="gridText">
													<c:set var="proposalId" value="" />
													<% String tempProposalId =""; %>
													<c:forEach items="${selectedHabs}" var="item" varStatus="status">
													<c:set var="index" value="${status.index}" />
													<c:if test="${proposalId != item.proposalId}">
													<c:set var="proposalId" value="${item.proposalId}" />
													<% tempProposalId = ""; %> 
													<tr bgcolor="lightyellow">
														<td colspan="6" align="left">
															<font size="-1" face="verdana">
															Habitations selected for Work <c:out value="${item.proposalId}" />
															</font>
														</td>
													</tr>	
													</c:if>			
													<tr class="<c:out value='row${index%2}' />">
														<td align="center">
															<%	hCount++;
																if(tempProposalId.equals("")){  
																	tempProposalId = "RW"; 
															%>
																<input type="radio" name="leads" value="<c:out value='${item.habCode}'/>">
															<% } else { %>
																<input type="radio" name="leads" value="<c:out value='${item.habCode}'/>" >
															<% }%>
														</td>
														<td align="center"><c:out value="${item.habCode}" /></td>
														<td>&nbsp;<c:out value="${item.habName}" /></td>
														<td align="right"><c:out value="${item.population}" />&nbsp;</td>
														<td>&nbsp;<c:out value="${item.status}" />
														<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" value="<c:out value='${item.habCode}'/>"></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<%} if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("11")) { %>
							<tr>
								<td>
									<fieldset>
										<legend>School Details</legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>
														<th><bean:message key="app.habitationCode" /></th>
														<th><bean:message key="app.habitationName" /></th>
														<th>School Code</th>
														<th>School Name</th>
													</tr>
												</thead>
												<tbody class="gridText">
													<c:set var="proposalId" value="" />
													<% String tempProposalId =""; %>
													<c:forEach items="${selectedHabs}" var="item" varStatus="status">
													<c:set var="index" value="${status.index}" />
													<c:if test="${proposalId != item.proposalId}">
													<c:set var="proposalId" value="${item.proposalId}" />
													<% tempProposalId = "";%> 
													<tr bgcolor="lightyellow">
														<td colspan="6" align="left">
															<font size="-1" face="verdana">
															Schools selected for Work <c:out value="${item.proposalId}" />
															</font>
														</td>
													</tr>	
													</c:if>
													<%hCount++;%>
													<tr>
														<td align="center"><c:out value="${item.habCode}" /></td>
														<td>&nbsp;<c:out value="${item.habName}" /></td>
														<td align="right"><c:out value="${item.schoolCode}" />&nbsp;</td>
														<td>&nbsp;<c:out value="${item.schoolName}" />
														<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" value="<c:out value='${item.habCode}'/><c:out value='${item.schoolCode}'/>"></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<%} if(request.getParameter("typeOfAsset")!=null && request.getParameter("typeOfAsset").equals("12")) { %>
							<tr>
								<td>
									<fieldset>
										<legend>Lab Details</legend>
										<label>
											<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
												<thead class="gridHeader">
													<tr>
														<th>Lab Code</th>
														<th>Lab Name</th>
														<th>Location</th>
													</tr>
												</thead>
												<tbody class="gridText">
													<c:set var="proposalId" value="" />
													<% String tempProposalId ="";%>
													<c:forEach items="${selectedHabs}" var="item" varStatus="status">
													<%hCount++; %>
													<c:set var="index" value="${status.index}" />
													<c:if test="${proposalId != item.proposalId}">
													<c:set var="proposalId" value="${item.proposalId}" />
													<% tempProposalId = ""; %> 
													<tr bgcolor="lightyellow">
														<td colspan="6" align="left">
															<font size="-1" face="verdana">
															Labs selected for Work <c:out value="${item.proposalId}" />
															</font>
														</td>
													</tr>	
													</c:if>
													<tr>			
														<td align="right"><c:out value="${item.labCode}" />&nbsp;</td>
														<td>&nbsp;<c:out value="${item.labName}" />
														<td>&nbsp;<c:out value="${item.location}" />
														<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" value="<c:out value='${item.labCode}'/>"></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<%}%>
							</c:if>	
							<tr>
								<td>
									<table width="100%">
										<tr>
											<td align="center">
												<html:button property="mode" styleClass="btext" onclick="return fnSave();" ><bean:message key="button.save" /></html:button>
												<html:reset property="mode" styleClass="btext"><bean:message key="button.clear" /></html:reset>
												<html:button property="mode" styleClass="btext" onclick="return fnView()"><bean:message key="button.view" /></html:button>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
 		<html:hidden property="init" />
		<html:hidden property="userId" name="RWS_USER" />
		<html:hidden property="officeCode" name="RWS_USER" />
	</html:form>
	<p align="left"><font face="verdana" size="2" color="red">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Note********: Already revised Works not Displayed in Works List - If you want edit already revised work Click on View Button</font></p>
</body>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
<%	if(request.getAttribute("message") != null){}
	String ll = (String)session.getAttribute("leads");
%>
<script>
	function selLead(){
		var hCount = '<%=hCount%>';
		if(hCount!="0" || hCount!=0){
			if(document.forms[0].typeOfAsset.value!="SCHOOLS" && document.forms[0].typeOfAsset.value!="LAB"){
				var lead = "<%=ll%>"
				for(var i=0;i<document.forms[0].leads.length;i++){
					if(document.forms[0].leads[i].value==lead){
						document.forms[0].leads[i].checked=true;
					}
				}
			}
		}
	}
	function validateWorks(){ 
	    var work = document.getElementById('proposalName').value;
		var revAmout = document.getElementById('WORK[0].revisedSanctionAmout').value;
	 	var revDate = document.getElementById('WORK[0].revisedAdminiStrativeDate').value;
		var revNum = document.getElementById('WORK[0].revisedAdminiStrativeNum').value;
		message='';	
		var save=true;
		var dt=revDate.split('/');
	    var rdt=dt[1]+'/'+dt[0]+'/'+dt[2];
		var revdt = new Date(rdt);
		var sysdt = new Date();
		if(work==''){
		  message=message+"Work Name";
		}
		if(revAmout=='' ){
		   if(message!=''){
			   message=message+',';
			}
		 	message=message+"Revised amount";
	 	}
	 	if(revDate=='' ){
			if(message!='') {
				message=message+',';
			}
			message=message+"Revised date";
	 	}
	 	if(revNum=='' ){
			if(message!=''){
				message=message+',';
			}
			message=message+"Revised ref.Number";
	 	}
	 	if(message!=''){
		 	alert(message+" is required");
			return false;
	 	}	
	 	if (revdt.getTime() > sysdt.getTime()){
		 	alert("Ref. Date Cannot be greater than Current Date");
		 	save=false;
	 	}
		var hCount = '<%=hCount%>';
		if(message==''){
			if(hCount!="0" || hCount!=0) {
				if(document.forms[0].typeOfAsset.value!="11" && document.forms[0].typeOfAsset.value!="12"){
					if(hCount!="1"){
						for(var v=0;v<document.forms[0].leads.length;v++){
							if(document.forms[0].leads[v].checked){
								leadradio = document.forms[0].leads[v].value;
								checkLead="true";
							}
						}
						if(checkLead=="false"){
							alert("Select One of the Habitation as a Lead Habitation");
						}
						else{
							var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=Revised&leadlab="+leadradio;
							document.forms[0].action=url;
							document.forms[0].submit();
						}
					}
					else{
						leadradio = document.forms[0].leads.value;
						document.forms[0].leads.checked=true;
						var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=Revised&leadlab="+leadradio;
						document.forms[0].action=url;
						document.forms[0].submit();				
					}
				}
				else{
					var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=Revised";
					document.forms[0].action=url;
					document.forms[0].submit();
				}
			}
			else{
				return false;
			}
		} 	
	}
</script>