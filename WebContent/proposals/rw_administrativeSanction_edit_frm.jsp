<%@taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ include file="/commons/rws_header1.jsp" %>
<%
String habitationss = request.getParameter("habs");
String[] habsarray={};
int lengthHab = 0;
String toa = request.getParameter("proposalId").substring(6,8);
if(habitationss!=null)
{
////System.out.println("habs length:"+habitationss);
habsarray=habitationss.split(",");
//System.out.println("habs array length:"+habsarray.length);
String[] habCodesarray=new String[habsarray.length];
 lengthHab = habsarray.length;
for(int arr = 0;arr<habsarray.length;arr++)
{
	if(request.getParameter("typeOfAsset").equals("12") )
	{
		habCodesarray[arr] = habsarray[arr].substring(0,2);
	}
	else if(request.getParameter("typeOfAsset").equals("11") )
	{
		habCodesarray[arr] = habsarray[arr].substring(0,20);
	}
	else
	{
		habCodesarray[arr] = habsarray[arr].substring(0,16);
		
	}
}
session.setAttribute("proposalsHabs",habCodesarray);
}
java.util.ArrayList habss = (java.util.ArrayList)session.getAttribute("habs");
//System.out.println("hhhhh:::::::::"+habss.size());

int habssSize = 0;
if(habss!=null) habssSize = habss.size();
 %>
<script language="JavaScript">
<!--

function showDivs()
{

	if (document.forms[0].plan[0].checked)
	{
	document.forms[0].wrktype[0].disabled=false;
	document.forms[0].wrktype[1].disabled=false;
	document.forms[0].wrktype[2].disabled=true;
   	
	}
	if (document.forms[0].plan[1].checked)
	{
	document.forms[0].wrktype[0].disabled=true;
	document.forms[0].wrktype[1].disabled=true;
	document.forms[0].wrktype[2].disabled=false;
	document.forms[0].wrktype[2].checked=true;
	}
}

function setEndoresement(that)
{
	var frm = that.form;
	var fieldValue = that.value;
	if(fieldValue == "OTHERS")
		frm.others.disabled = false;	
	else
	{	
		frm.others.value = "";
		frm.others.disabled = true;	
	}
	
}
function addRemoveHabs()
{	
	var proposalId = document.getElementById("WORK[0].proposalId").value;
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	// alert("add remove habs ");
	var officeCode = hoc+coc ;
	var url = "switch.do?prefix=/proposals&page=/AddRemoveAdminHabs.do&mode=addRemoveHabs"
		    + "&proposalId="+proposalId+"&officeCode="+officeCode+"&coc="+coc+"&All=yes&view=Mandal-view";
	var properties = "width=900,height=300,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes,location=1";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}
function fnSubmit()
{
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
	//return false;
}

function fnAddWork()
{
	var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=Add";
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}

function fnRemove(that)
{
	var frm = that.form;
	var removeIds = frm.elements("remove");
	
	if(removeIds)
	{
		var len = removeIds.length;
		var count = 0;
		if(typeof len != "number")
			removeIds = [removeIds];
		for(var i=0; i<len; i++)
		{
			if(removeIds[i].checked)
		 		count++;
		}
		if(count == 0)
			alert("Please select atleast one work to remove!");
		else
		if(count == len)
			alert("You cannot remove all works!\nPlease de-select one work.");
		else		
		{
			var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
				+ "&mode=Remove";
			frm.action = url;
			frm.submit();		  
		}
	}
}
function fnGetOffices(that)
{ 
	var field = that.name;
	
	var frm = that.form;
	var url;
	if(field == 'headOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=circles";
	else
	if(field == 'circleOfficeCode')
	 	url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=divisions";
	else
	if(field == 'divisionOfficeCode')	
		url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do"
			+ "&mode=subdivisions";		
	frm.action = url;
	frm.submit();

}
 
function fnGetSubprogrammes(elem)
{
	var index = elem.name.substr(5,1);
//	alert(elem.name + "   "+index);
	
	var url = "switch.do?prefix=/proposals&page=/EditAdminSanction.do&mode=subprogrammes"
			+ "&index="+index;
	var frm = document.forms["AdminstrativeSanctionForm"];
	frm.action = url;
	frm.submit();
}
var newWindow;
function fnPickHabitations(index)
{
   
	var hoc = document.getElementById("headOfficeCode").value;
	var coc = document.getElementById("circleOfficeCode").value;
	 

	if(coc == '')
		alert("Please select circle.");
	 	
	else
	{			
		var proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var width = 648;
		var height = 332;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
	
		var url = "switch.do?prefix=/proposals&page=/PickAdminHabitation.do&mode=pickhab"
				+ "&hoc="+hoc+"&coc="+coc+"&proposalId="+proposalId
				+ "&index="+index;
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
}
function fnShowAugmentationWork(index)
{
	var checkField = document.getElementById("WORK["+index+"].augmentation");
	if(checkField.checked)
	{
		var proposalId = proposalId = document.getElementById("WORK["+index+"].proposalId").value;
		var url = "switch.do?prefix=/proposals&page=/PickAugmentationWork.do";
		var properties = "width=450,height=135,toolbar=no,status=no,menubar=no,location=no,directories=no,"
					   + "scrollbars=yes,copyhistory=no,resizable=yes";
		newWindow = window.open(url, "", properties);
	}
}
function validateWorks()
{
	var workCount = document.getElementById("workCount").value;
	var workName;
	var noOfHabs;
	var estimateCostElem;
	var message ="";
	for(var i=0; i<workCount; i++)
	{
		workName = document.getElementById("WORK["+i+"].proposalName").value;
		noOfHabs = document.getElementById("WORK["+i+"].noOfHabs").value;
		estimateCostElem = document.getElementById("WORK["+i+"].estimateCost");
		
		if(workName.length == 0 || workName == '')
			message+="Work Name " + (i+1) + " is required\n"; 
		if(noOfHabs.length == 0 || noOfHabs == '' || noOfHabs == 0)
			message+="Habitation(s) for work " + (i+1) + " is required\n";  
		if(!isPositiveDecimal(estimateCostElem))
			message+="Estimate Cost for work " + (i+1) + " is invalid\n";  
	}
	if(message.length >0)
	{
		//alert(message);
		return false;
	}
	return true;
}


function fnCancel()
{
	window.close();
}
function lead()
{
	var toa = '<%=toa%>';
	if(toa!='11' || toa!='12')
	{
		var checkLead = "false";
		var lengthHabs = <%=habssSize%>;
		if(lengthHabs!="1")
		{
			for(var v=0;v<document.forms[0].leads.length;v++)
				{
					if(document.forms[0].leads[v].checked)
					{
						leadradio = document.forms[0].leads[v].value;
						checkLead  ="true";
					}
				}
				if(checkLead=="false")
				{
					alert("Select One of the Habitation as a Lead Habitation");
				}
				else
				{
						for(var v=0;v<document.forms[0].leads.length;v++)
						{
							if(document.forms[0].leads[v].checked)
							{
								document.forms[0].leadhab.value = document.forms[0].leads[v].value;
							}
						}
				}
		}
		else
		{
			document.forms[0].leadhab.value = document.forms[0].leads.value;
		}
		if(document.forms[0].leadhab.value!="")
			return true;
		else
			return false;
	}
	else
	{
		return true;
	}
}
function showWorks()
{
	 var url = "switch.do?prefix=/proposals&page=/EditAdminSanction.do?mode=getWorks1";
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 		
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}	
//-->
</script>
<html:javascript formName="AdminstrativeSanctionForm" htmlComment="true" />
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="selLead()">
<html:form action="AdminstrativeSanctionSaveForm" onsubmit="return lead()">
<table cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>

<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Administrative Sanction Form" />
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
				<html:select property="headOfficeCode" onchange="javascript: fnGetOffices(this)"
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="headOffices" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="headOfficeCode" value="0">
				<html:text property="headOfficeName" styleClass="thin-text-box" 
						   name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</logic:notEqual>
		<input type="hidden" name="count" value="1">
		<%
		String plan="";
		if(request.getParameter("plan") != null)
		{plan=request.getParameter("plan");}
		if(request.getAttribute("plan")!=null)
		{plan=""+request.getAttribute("plan");}
		
		if(plan.equals("PLAN"))
		{
			%>
		<td class="column3"><input type="radio" name="plan" value="1" checked onclick="JavaScript:showDivs()" disabled>Plan</td>
		<td class="column3"><input type="radio" name="plan" value="2" onclick="JavaScript:showDivs()" disabled>Non-Plan</td>
		<%} else {%>
		<td class="column3"><input type="radio" name="plan" value="1" onclick="JavaScript:showDivs()" disabled>Plan</td>
		<td class="column3"><input type="radio" name="plan" value="2" checked onclick="JavaScript:showDivs()" disabled>Non-Plan</td>
		<%}%>

		</tr>
		<tr>
		<td class="column1">Work Category<span class="mandatory">*</span></td>
		<td class="column2"><html:text property="workCat" readonly="true"/></td>
			
		<td class="column3">
		Scheme
		<span class="mandatory">*</span></td>
		<td class="column4"><html:text  property="typeOfAsset" readonly="true"/></td>
		</tr>
<c:set var="sName" value="${AdminstrativeSanctionForm.typeOfAsset}" scope="request"/>
			<%String statss = (String)request.getAttribute("sName");
		
			%>
		<tr>
		<td colspan="2" nowrap>
		<%
		  String aug="";
		  if(request.getParameter("wrkType") != null)
		  {aug=request.getParameter("wrkType");}
		  else if(request.getAttribute("wrkType") != null)
		  {aug=""+request.getAttribute("wrkType");}
		  
		  if(aug.equalsIgnoreCase("MAIN SCHEME") || aug.equalsIgnoreCase("AUGUMENTATION")){
            
            if(aug.equals("MAIN SCHEME") || aug.equals("MAIN SCHEME")){
            		             %>
            <input type="radio" value="1" name="wrktype" checked disabled>MainScheme
           	<input type="radio" value="2" name="wrktype" disabled>Augmentation
           	<input type="radio" value="3" name="wrktype" disabled>Maintenance	
			<%} else { %>
     	    <input type="radio" value="1" name="wrktype" disabled>MainScheme
           	<input type="radio" value="2" name="wrktype" checked disabled>Augmentation
           	<input type="radio" value="3" name="wrktype" disabled>Maintenance
			<%}}
		else if(aug.equalsIgnoreCase("MAINTENANCE")){%>
            <input type="radio" value="1" name="wrktype" disabled>MainScheme
            <input type="radio" value="2" name="wrktype" disabled>Augmentation
     		<input type="radio" value="3" name="wrktype" checked disabled>Maintenance    		
        <%}
        %>
		</td>
		<td colspan="2">
<%		   if(aug.equalsIgnoreCase("AUGUMENTATION")){%>
			Augmentation Link<span class="mandatory">*</span>&nbsp;

				<html:text  property="augsch" readonly="true" />
				<html:button property="mode" value="..." style="width:25px" styleClass="btext" title="Click Here"
								 onclick='<%= "javascript: showWorks()"%>' /></td>
							<%}%> 
		</td>
		</tr>
		<tr>
 		<td class="column1">Programme
		<span class="mandatory">*</span>
		</td>
		<td class="column2"><html:text  property="programs" readonly="true" /></td>
		
		<td class="column3">Sub Programme
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		    <html:text  property="subPrograms" readonly="true" />
		</td>
		
		</tr>
		<tr>
	    <td class="column1">
			Circle
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		             <html:text  property="circleOfficeName" readonly="true" />
	 	</td>
	 
		<td class="column3">Division
			<span class="mandatory">*</span>
		</td>
		<td class="column4">
		    <html:text  property="divisionOfficeName" readonly="true" />
		    <html:hidden  property="divisionOfficeCode"  /> 
	 	</td>
	 	</tr>
	 	<tr>
	 	<td class="column1">SubDivision
			<span class="mandatory">*</span>
		</td>
		<td class="column2">
		    <html:text  property="subdivisionOfficeName" readonly="true" />
		    <html:hidden  property="subdivisionOfficeCode"  /> 
	 	</td>
	 	<td class="column3">Approved Under<span class="mandatory">*</span></td>
        <td class="column4">
	
	    <html:text  property="prooved" readonly="true" />
		 </td>
		 </tr><tr>
		<td class="column3">State Approved Under<span class="mandatory">*</span></td>
        <td class="column4"><html:text  property="approoved" readonly="true" /></td>
	    <td class="column3">CM-SEC Dashboard<span class="mandatory">*</span></td>
        <td class="column4">
        	<html:select property="coreDashboardStatus" styleClass="combo" >
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
		 	</html:select>
         </td>
	</tr>
	<!--END -->
	 
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
			<table width="740" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			
			<tr>
				 
				<th><bean:message key="app.workName" /></th>
				<th>Work Id</th>
				
			<% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
			<th><bean:message key="app.selectHabs" /></th>
			<%}else if(statss.equals("LAB")){%>
			<th>Selected Labs</th>
			<%}else if(statss.equals("SCHOOLS")){%>
			<th>Selected Schools</th>
			<%}%>

			 	<th>Sanctioned &nbsp;<br>Amount</br>(Lakhs)</th>
			 	<th>Adminstrative Number</th>
		 		<th>Adminsanction Date</th>
				<th><bean:message key="app.remarks" /></th>
			</tr>
			</thead>
			<tbody>
			<% int workCount = 0; int count=0;%>
			<nested:iterate id="WORK" property="proposals" indexId="ndx">
			<% workCount++; %>
			<tr bgcolor="#ffffff">
				
				<td>
					<nested:text name="WORK" property="proposalName" indexed="true" maxlength="100"
							     style="width: 120px" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()" />
				</td>
				<td>
					<nested:text name="WORK" property="proposalId" indexed="true" readonly="true"
							     style="width:85px;text-align: center" styleClass="noborder-text-box"/>
				</td>
				<td>
					<nested:text name="WORK" property="noOfHabs" indexed="true" readonly="true" 
							     styleClass="noborder-text-box" style="width: 20px"  />
					 </td>
			 	 
				<td>
					<nested:text name="WORK" property="sanctionAmout" indexed="true" maxlength="9"
							     style="width: 55px;text-align: right" styleClass="noborder-text-box" 
							     onkeypress="return decimalsOnly(event)"/>
				</td>
				<td>
					<nested:text name="WORK" property="adminiStrativeNum" indexed="true" maxlength="50"
							     style="width:100px;text-align: left" styleClass="noborder-text-box" 
							      />
				</td>
				<td>
					<nested:text name="WORK" property="adminiStrativeDate" indexed="true" maxlength="9" readonly="true" style="width:75px;text-align: right"/>
					<a href="javascript:showCalendar(document.getElementById('WORK[<%=count++%>].adminiStrativeDate'));">
		       <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
			 
				</td>
							 	 
				<td>
					<nested:text name="WORK" property="remarks" indexed="true" 
							     style="width: 60px;" styleClass="noborder-text-box" 
								 onkeypress="return textOnly()"/>
				</td>
			</tr>
			</nested:iterate>
			<input type="hidden" name="workCount" value="<%= workCount %>">
			</tbody>
			</table>
			<table width="100%">
			<tr>
			 
			</tr>
			</table>
		</label>
		</fieldset>
	</td>
</tr>
<html:hidden property="circleOfficeCode"  />
<html:hidden property="leadHabitation" />
   
<tr id="id">
<td>
<fieldset>
 <% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
<legend>Selected Habitations</legend>
<%} if(statss.equals("LAB")) {%>
<legend>Selected Labs</legend>
<%} if(statss.equals("SCHOOLS")) {%>
<legend>Selected Schools</legend>
<%}%>
<label>
	<table id="proTable" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse:collapse">
	<thead class="gridLabel">
	 <% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.leadHabitation" /></th>
			<th><bean:message key="app.habitationCode" /></th>
			<th><bean:message key="app.habitationName" /></th>
		</tr>
		<%}%>
		<% if(statss.equals("LAB")) {%>
		<tr bgcolor="#8A9FCD">
				<th>Lab Code</th>
				<th>Lab Name-Location</th>
		</tr>
		<%}%>
		<% if(statss.equals("SCHOOLS")) {%>
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.habitationCode" /></th>
			<th>School Code-Hab Name-School Name</th>
		</tr>
		<%}%>
	</thead>
	
	<tbody class="gridText"><% String tempProposalId =""; %>
	<%int ii = -1;%>
	<%
			String[] aa = (String[])session.getAttribute("habs1");
			int len = aa.length;
			//System.out.println("Len:"+len);
			String ll = (String)session.getAttribute("leads");
		//	System.out.println("LL:"+statss);
			%>
	<c:forEach items="${sessionScope.habs}" var="item" varStatus="status">
	<%System.out.println("inside");%>
		<c:set var="index" value="${status.index}" />
				<% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
		<tr class="<c:out value='row${index%2}'/>">
			<td align="center">
				<input type="radio" name="leads" value="<c:out value="${item.habCode}"/>">
			<%}%>
			<input type="hidden" name="habCodes" value="<c:out value="${item.habCode}"/>">	   
			</td>
			 <% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
			<td><c:out value="${item.habCode}"/></td>
			<td><c:out value="${item.habName}"/></td>
			<input type="hidden" name="<c:out value='H_${WORK.proposalId}'/>" 
					   value="<c:out value='${item.habCode}'/>"></td>
		<%}%>
		<% if(statss.equals("SCHOOLS")) {%>
		<td><c:out value="${item.habMatch}"/></td>
			<td><c:out value="${item.schoolCode}"/>-<c:out value="${item.panchayatName}"/>-<c:out value="${item.schoolName}"/></td>
			<input type="hidden" name="<c:out value='H_${WORK.proposalId}'/>" 
					   value="<c:out value='${item.habitationCode}'/>"></td>
			<%}%>
			<% if(statss.equals("LAB")) {%>
		<td><c:out value="${item.labCode}"/></td>
			<td><c:out value="${item.labName}"/>-<c:out value="${item.location}"/></td>
			<input type="hidden" name="<c:out value='H_${WORK.proposalId}'/>" 
					   value="<c:out value='${item.labCode}'/>"></td>
			<%}%>
			
		</tr>
	</c:forEach>
	</tbody>
	<tfoot>
	 <% if(!(statss.equals("LAB")|| statss.equals("SCHOOLS"))) {%>
		<tr>
			<td align="left" colspan="5">
				<html:button property="mode" style="width: 150px" styleClass="btext" 
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveHabs" />
				</html:button>
			</td>
		</tr>
		<%}%>
		<% if(statss.equals("SCHOOLS")) {%>
			<tr>
			<td align="left" colspan="5">
				<html:button property="mode" style="width: 150px" styleClass="btext" 
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveSchools" />
				</html:button>
			</td>
		</tr>
		<%}%>
			<% if(statss.equals("LAB")) {%>
	<tr>
			<td align="left" colspan="5">
				<html:button property="mode" style="width: 150px" styleClass="btext" 
							 onclick="javascript: addRemoveHabs()">
					<bean:message key="button.addRemoveLabs" />
				</html:button>
			</td>
		</tr>
		<%}%>
	</tfoot>
	</table>
</label>
</fieldset>
 
</td>
</tr>

<tr>
	<td align="center">
		<html:submit property="mode" styleClass="btext"  >Update</html:submit>
		<html:reset property="reset" styleClass="btext">Clear</html:reset>
		<html:button property="mode" styleClass="btext" onclick="javascript: fnCancel()">Close</html:button>
	</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
<input type="hidden" name="leadhab">
<html:hidden property="init" />
<input type="hidden" name="type" value="<%= request.getAttribute("type")%>">
<script>
function selLead()
{
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
</script>
</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />