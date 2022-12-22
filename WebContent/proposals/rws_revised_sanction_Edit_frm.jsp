<%@ include file="/commons/rws_header1.jsp" %>
<%int hCount = 0;%>
<script language="JavaScript">
function fnSubmit()
{
	var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
	//return false;
}


function fnGetOffices(that)
{
	var field = that.name;
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/RevisedSanction.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/RevisedSanction.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/RevisedSanction.do"
			+ "&mode=subdivisions";		
	frm.action = url;
	frm.submit();

}
 
 
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
	var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}
function fnGetWorkDetails(elem)
{
	var workId = document.getElementById('proposalName').value;
	var combo1 = document.getElementById('proposalName');
    var workName = combo1.options[combo1.selectedIndex].text
 	var url = "switch.do?prefix=/proposals&page=/RevisedSanction.do&mode=workDetails"
			+ "&workId="+workId+"&workName="+workName;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}
var newWindow;
function fnPickHabitations(index)
{
     
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	 
  
	 		
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var assetcode=proposalId.substring(6,8);
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/proposals&page=/PickRevisedEditHabitation.do&mode=pickRevhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId+"&assetcode="+assetcode
				+ "&index="+index+"&flag="+false;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}
	 
}
function  fnView()
{
	var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
	//alert(proposalId);
document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=RevisedView"
+"&proposalId="+proposalId;
 	 document.forms[0].submit();
}
function fnUpdate()
{
    
	 
		if(validateWorks());
 }
//-->
</script>

<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />
<%@ include file="/commons/rws_header2.jsp" %>
<body onunload="rm();" onload="selLead();" >
<html:form action="RevisedSanctionSaveForm" >
<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>

<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Revised Sanction Form" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
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
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" 
		   style="border-collapse:collapse">
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
			Plan Type
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		 		<html:text property="plan" readonly="true" />
		</td>
   </tr>

   <tr>
	    <td class="column3">WorkCategory
		<span class="mandatory">*</span>
		</td>
		<td class="column4">
		 		<html:text property="workCat" readonly="true" />
		</td>
	     <td class="column3">
			Scheme<span class="mandatory">*</span>
		</td>
		<td class="column4">
	 			<html:text property="typeOfAsset" readonly="true" />
	 	</td>
		<c:set var="sName" value="${AdminstrativeSanctionForm.typeOfAsset}" scope="request"/>
			<%String statss = (String)request.getAttribute("sName");
		
			%>
	</tr>
	<!--END -->
	<tr>
		<td class="column1">Augmnt. Type
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
			<html:text property="wrktype"   readonly="true" />
	 	</td>
	    <td class="column1">Programme
			<span class="mandatory">*</span>
		 </td>
		 <td class="column2">
	 		<html:text property="programs"   readonly="true" />
		</td>
	</tr>
	<tr>
	 	<td class="column1">Sub Programme
		  <span class="mandatory">*</span>
		</td>
		<td class="column2">
	 	  <html:text property="subPrograms"  readonly="true" />
		</td>
	 	<td class="column3">
		 <bean:message key="app.circle" /><span class="mandatory">*</span>
		</td>
		<td class="column4">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName"  readonly="true" />
				<html:hidden property="circleOfficeCode"  />
							 
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
	</tr>
	<tr>
	<td class="column1"><bean:message key="app.division" />
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName"   readonly="true" />
						  
		 
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
		
		<td class="column1">SubDivision
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
			<html:text property="subdivisionOfficeName"   readonly="true" />
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
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"  style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr>
				
				<TH colspan="1"> </TH>
				<th colspan="3">Original Administrative Sanction Ref
				<th colspan="3">Revised Sanction Ref </th>
		 		<TH colspan="2"></TH>
			</tr>
			
			<thead class="gridHeader">
			    
			   <th width="20%"><bean:message key="app.workName" /></th>
			   <th  width="15%">Ref. Number</th>
			   <th>Ref. Date</th>
			   <th>Amount </th>
			   <th width="15%">Ref. Number</th>
			   <th width="15%" >Ref. Date</th>
			   <th width="15%">Amount</th>
			   
			   <%//System.out.println("in above value:::"+statss);%>
					<% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
			   <th>Add/Remove Habitations </th>
			   <%} else if(statss.equals("LAB")){%>
			   <th>Add/Remove Labs </th>
			    <%} else if(statss.equals("SCHOOLS")){%>
			   <th>Add/Remove Schools </th>
<%}%>
			
	 		</thead>
			<tbody>
			<% int workCount = 0; int count=0;%>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				 
				<td>
			 			<nested:text name="WORK" property="proposalName"  readonly="true" indexed="true" style="width:150px " styleClass="noborder-text-box" 
							    />
					
				</td>
			 
				<td>
					<nested:text name="WORK" property="adminiStrativeNum"  readonly="true" indexed="true" maxlength="9"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" 
							    />
				</td>
				<td>
					<nested:text name="WORK" property="adminiStrativeDate"  readonly="true" indexed="true" maxlength="9"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" />
				</td>
			 	<td>
					<nested:text name="WORK" property="sanctionAmout"  readonly="true" indexed="true" maxlength="9"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" />
				</td>
				<td>
					<nested:text name="WORK" property="revisedAdminiStrativeNum" indexed="true" maxlength="50"
							     style="width: 100px;text-align: left" styleClass="noborder-text-box"/>
				</td>
				
				<td>
					<nested:text name="WORK" property="revisedAdminiStrativeDate" indexed="true" maxlength="11" style="width: 70px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count++%>].revisedAdminiStrativeDate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			 
				</td>
				<td>
					<nested:text name="WORK" property="revisedSanctionAmout" indexed="true" maxlength="20"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" 
							     onkeypress="return decimalsOnly(event)"/>
				</td>
				
			 	<td> 
					<nested:hidden name="WORK" property="proposalId" indexed="true"  />
				 
					<nested:text name="WORK" property="revNoOfHabs" indexed="true" readonly="true" 
							     styleClass="noborder-text-box" style="width: 12px"/>
					<html:button property="addHab" value="..." styleClass="btext"
								 onclick='<%= "javascript: fnPickHabitations(\" + ndx +\")"%>' />
				</td>
				
				 
			</tr>
			</nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			</tbody>
			</table>
			<table width="100%">
			<tr>
			<td align="left">
			<!-- <a href="#1" onclick="chkAll(<%=workCount%>)">Check All</a>&nbsp;&nbsp;
			<a href="#2" onclick="clrAll(<%=workCount%>)">Clear All</a>-->
			</td>
			<!-- <td align="right">
				<html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnAddWork()">
					<bean:message key="button.addNewWork" />
				</html:button>
				<% if(workCount <= 1) { %>
				
				<html:button property="mode" styleClass="btext" style="width:120px"
					onclick="return fnRemove(this)" disabled="true">
					<bean:message key="button.removeWorks" />
				</html:button>
				<% } else {%>
				<html:button property="mode" styleClass="btext"
						style="width:120px" onclick="return fnRemove(this)">
					<bean:message key="button.removeWorks" />
				</html:button>
				<% } %>

			</td>-->
			</tr>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
		
	

  <% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
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
					<%hCount++;
					if(tempProposalId.equals(""))
					   {  tempProposalId = "RW"; 
					%>
						<input type="radio" name="leads" value="<c:out value='${item.habCode}'/>" checked="checked">
					<% }
						else{ %>
						<input type="radio" name="leads" value="<c:out value='${item.habCode}'/>" >
					<% }%>
				</td>
				<td align="center"><c:out value="${item.habCode}" /></td>
				<td>&nbsp;<c:out value="${item.habName}" /></td>
				<td align="right"><c:out value="${item.population}" />&nbsp;</td>
				<td>&nbsp;<c:out value="${item.status}" />
				<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" 
					   value="<c:out value='${item.habCode}'/>"></td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>

		   <%} else if(statss.equals("SCHOOLS")){%>
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
			<% tempProposalId = ""; %> 
			<tr bgcolor="lightyellow">
				<td colspan="6" align="left">
					<font size="-1" face="verdana">
					Schools selected for Work <c:out value="${item.proposalId}" />
					</font>
				</td>
			</tr>	
			</c:if>
			
			
				<td align="center"><c:out value="${item.habCode}" /></td>
				<td>&nbsp;<c:out value="${item.habName}" /></td>
				<td align="right"><c:out value="${item.schoolCode}" />&nbsp;</td>
				<td>&nbsp;<c:out value="${item.schoolName}" />
				<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" 
					   value="<c:out value='${item.proposalId}'/><c:out value='${item.schoolCode}'/>"></td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
	  <%} else if(statss.equals("LAB")){%>
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
			<% String tempProposalId =""; %>
			<c:forEach items="${selectedHabs}" var="item" varStatus="status">
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
			
				
				<td align="right"><c:out value="${item.labCode}" />&nbsp;</td>
				<td>&nbsp;<c:out value="${item.labName}" />
				<td>&nbsp;<c:out value="${item.location}" />
				<input type="hidden" name="<c:out value='H_${item.proposalId}'/>" 
					   value="<c:out value='${item.labCode}'/>"></td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
		</label>
		</fieldset>
	</td>
	</tr>
		<%}%>
	
	<tr>
	<td>
		<table width="100%">
		<tr>
			<td align="center">
				<html:button property="mode" styleClass="btext" onclick="return fnUpdate()" >
					Update
				</html:button>
				<html:reset property="mode" styleClass="btext">
					<bean:message key="button.clear" />
				</html:reset>
				<html:button property="mode" styleClass="btext" onclick="return fnView()">
					Cancel
				</html:button>
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
</body>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
<%
	if(request.getAttribute("message") != null)
	{
%>	
		<script>
		<!--
			alert("Processing...\nPlease wait...")
			document.location.reload();
				</script>
		
<%	}
String ll = (String)session.getAttribute("leads");
System.out.println("ll:"+ll);
%>
<script>
function validateWorks()
{ 
    
	var revAmout = document.getElementById('WORK[0].revisedSanctionAmout').value;
 	var revDate = document.getElementById('WORK[0].revisedAdminiStrativeDate').value;
	var revNum = document.getElementById('WORK[0].revisedAdminiStrativeNum').value;
	 message='';
	 
	if(revAmout=='' )
	{
	 message="Revised amount -";
 	}
 	if(revDate=='' )
	{
	 message=message+"Revised date -";
 	}
 	if(revNum=='' )
	{
	 message=message+"Revised ref.Number-  ";
 	}
 	if(message!='')
 	{
 	alert(message+"is required");
 	}
 	else
 	{
		var hCount = '<%=hCount%>';
		//alert(hCount);
		if(hCount!="1" && (document.forms[0].typeOfAsset.value!="11" && document.forms[0].typeOfAsset.value!="12"))
		{
		//	alert("inside:"+document.forms[0].leads.length);
			for(var v=0;v<document.forms[0].leads.length;v++)
				{
			//	alert(document.forms[0].leads[v].checked);
					if(document.forms[0].leads[v].checked)
					{
						leadradio = document.forms[0].leads[v].value;
						checkLead="true";
					}
				}
				if(checkLead=="false")
				{
					alert("Select One of the Habitation as a Lead Habitation");
				}
				else
				{
					var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=RevisedUpdate&leadlab="+leadradio;
					//alert(url);
					document.forms[0].action=url;
					document.forms[0].submit();
				}
		}
		else
		{
			leadradio = document.forms[0].leads.value;
		//	alert(leadradio);
			var url = "switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=RevisedUpdate&leadlab="+leadradio;
			document.forms[0].action=url;
			document.forms[0].submit();
		}
  	// document.forms[0].action="switch.do?prefix=/proposals&page=/RevisedSanctionSaveForm.do&mode=RevisedUpdate";
 	// document.forms[0].submit();
 	}
	 
}
function selLead()
{
	var hCount = '<%=hCount%>';
	if(hCount!=0){
		if(document.forms[0].typeOfAsset.value!="SCHOOLS" && document.forms[0].typeOfAsset.value!="LAB")
		{
			var lead = "<%=ll%>"
			alert(lead);
			for(var i=0;i<document.forms[0].leads.length;i++)
			{
				if(document.forms[0].leads[i].value==lead)
				{
					document.forms[0].leads[i].checked=true;
				}
			}
		}
	}
}
function selLead()
{
	var hCount = '<%=hCount%>';
	if(hCount!=0){
		if(document.forms[0].typeOfAsset.value!="SCHOOLS" && document.forms[0].typeOfAsset.value!="LAB")
		{
			var lead = "<%=ll%>"
			for(var i=0;i<document.forms[0].leads.length;i++)
			{
				if(document.forms[0].leads[i].value==lead)
				{
					document.forms[0].leads[i].checked=true;
				}
			}
		}
	}
}
</script>