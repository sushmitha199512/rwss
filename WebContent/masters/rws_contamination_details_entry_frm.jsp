<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%@ include file="/commons/rws_header2.jsp" %>

<head>
<script language="javascript">
function funcInit()
{
		
}
function nssHabitationChanged()
{
	document.forms[0].action="/pred/masters/ContaminationDetails.do?mode=data";
	document.forms[0].submit();
}

function funcDistrictChanged()
{
	document.forms[0].action="/pred/masters/ContaminationDetails.do?mode=nssHabs";
	document.forms[0].submit();
}

function fnSave()
{
	var statusDate=document.forms[0].contTypes1.value;
	if(statusDate==null || statusDate==''){
		alert("Please select Status Date");
		return false;
	}		
	var submitval = "true";
	if(document.forms[0].contTypes1.value=="Y" && submitval == "true")
	{
		if(document.forms[0].flouride.value=="" || parseFloat(document.forms[0].flouride.value)==0)
		{
			document.forms[0].flouride.value='';
			document.forms[0].flouride.focus();
			alert("Enter Flouride Value");
			submitval = "false";
		}
		else if(parseFloat(document.forms[0].flouride.value)<1.5)
		{
			alert("Flouride Value Should be greater than or equal 1.5(ppm)");
			submitval = "false";
		}
		else 
		{
			submitval = "true";
		}
	}
	if(document.forms[0].contTypes2.value=="Y" && submitval == "true")
	{
		if(document.forms[0].brakish.value=="" || parseFloat(document.forms[0].brakish.value)==0)
		{
			document.forms[0].brakish.value='';
			document.forms[0].brakish.focus();
			alert("Enter Brakish Value");
			submitval = "false";
		}
		else if(parseFloat(document.forms[0].brakish.value)<2000)
		{
			alert("Brakish Value Should be greater than or equal 2000(ppm)");
			submitval = "false";
		}
		else 
		{
			submitval = "true";
		}
	}
	if(document.forms[0].contTypes3.value=="Y" && submitval == "true")
	{
		if(document.forms[0].iron.value=="" || parseFloat(document.forms[0].iron.value)==0)
		{
			document.forms[0].iron.value='';
			document.forms[0].iron.focus();
			alert("Enter Iron Value");
			submitval = "false";
		}
		else 
		{
			submitval = "true";
		}
	}
	if(document.forms[0].contTypes4.value=="Y" && submitval == "true")
	{
		if(document.forms[0].aresenic.value=="" || parseFloat(document.forms[0].aresenic.value)==0)
		{
			document.forms[0].aresenic.value='';
			document.forms[0].aresenic.focus();
			alert("Enter Aresenic Value");
			submitval = "false";
		}
		else 
		{
			submitval = "true";
		}
	}
	if(document.forms[0].contTypes5.value=="Y" && submitval == "true")
	{
		if(document.forms[0].nitrate.value=="" || parseFloat(document.forms[0].nitrate.value)==0)
		{
			document.forms[0].nitrate.value='';
			document.forms[0].nitrate.focus();
			alert("Enter Nitrate Value");
			submitval = "false";
		}
		else 
		{
			submitval = "true";
		}
	}
	if(submitval == "true")
	{
		document.forms[0].action="/pred/masters/ContaminationDetails.do?mode=save";
		document.forms[0].submit();
		document.forms[0].save.disabled=true;
	}
}

function fnSaveNew()
{
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		return;
	}
	else if(document.forms[0].pcode.value=="")
	{
		alert("Please Enter Panchayat Code");
		return;
	}
	else if(document.forms[0].pname.value=="")
	{
		alert("Please Enter Panchayat Name");
		return;
	}
	else if(document.forms[0].pcode.value.length!=2)
	{
		alert("Panchayat Code Should be Of Length 2");
		return;
	}
	else{
		document.forms[0].save.disabled=true;
		document.forms[0].action="/pred/masters/contaminationDetails.do?mode=saveNew";
		document.forms[0].submit();
	}
}
function viewfun()
{
	if(document.forms[0].district.value!="")
	{
		document.forms[0].action="/pred/masters/ContaminationDetails.do?mode=view";
		document.forms[0].submit();
	}
	else
	{
		alert("Please Select District");
	
	}

}
function fnAddNew()
{
document.forms[0].action="/pred/masters/contaminationDetails.do?mode=addNew";
document.forms[0].submit();

}

</script>

</head>
<body onload="funcInit()"></body>
<html:form  action="HabStatus.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Quality Effected Habs Entry" />
		<jsp:param name="TWidth" value="100%" />
		<jsp:param name="contextHelpUrl" value="/pred/help/Help For PRED.htm" />
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

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="350" >
<tr>
<td>
	
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table  border=0  width="100%">
		
		<tr>
			<td class="textborder" nowrap>District
			<span class="mandatory">*</span> &nbsp;&nbsp;
		</td>
		<td class="textborder" colspan=5>
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="district" style="width:350px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="districtName" styleClass="mytext" style="width:350px"
						    readonly="true"   />
				
				<html:hidden property="district" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
			<td class="textborder" nowrap>NSS Habs<span class="mandatory">*&nbsp;&nbsp;</span></td>
		<td class="textborder"  colspan=5>
				<html:hidden property="contaminationDetailsEntryFrmInit" />
				<html:select property="habitation" style="width:350px" styleClass="mycombo" onchange="nssHabitationChanged()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="nssHabs" name="labelValueBean" 
								  property="value" labelProperty="labelValue" />
				</html:select>
			
			
			
		</td>
		</tr>
		<tr>
		<td class="textborder" >Status Date</td>
		<TD class="bwborder">
				    	<html:text property="statusDate"   
				    			   styleClass="mytext" style="width:80px" readonly="true"  />
						<a href="javascript: showCalendar(document.forms[0].statusDate);"  ><IMG SRC="<rws:context page='/images/calendar.gif'/>" 
						   width="20" border="0" height="17" align="absmiddle"></a>
					</TD>
		</tr>
		<tr><td colspan=10 align="center">
		
		<table border=0 align="center"><tr>
		<c:if test="${habStatusForm.contTypes1 =='Y'}"> 
		<td class="textborder" >Flouride(PPM)</td>
		<td class="textborder">
		<html:text property="flouride" styleClass="mytext" style="width:50px"
					onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"/>
		</c:if>
		</td>
		<c:if test="${habStatusForm.contTypes1 =='N'}"> 
		<!-- <html:text property="flouride" styleClass="mytext" style="width:50px"
					onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" readonly="true"/> -->
		</c:if>
		<c:if test="${habStatusForm.contTypes2 =='Y'}"> 
		<td class="textborder" >Brakish(PPM)</td>
		<td class="textborder">
		<html:text property="brakish" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"  />
		</td>
		</c:if>
		<c:if test="${habStatusForm.contTypes2 =='N'}"> 
		<!-- <html:text property="brakish" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"  readonly="true"/> -->
		</c:if>
		<c:if test="${habStatusForm.contTypes3 =='Y'}"> 
		<td class="textborder" >Iron(PPM)</td>
		<td class="textborder">
		<html:text property="iron" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" />
		</td>
		</c:if>
		<c:if test="${habStatusForm.contTypes3 =='N'}"> 
		<!-- <html:text property="iron" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" readonly="true"/> -->
		</c:if>
		<c:if test="${habStatusForm.contTypes4 =='Y'}"> 
		<td class="textborder" >Aresenic(PPM)</td>
		<td class="textborder">		
		<html:text property="aresenic" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" />
		</td>
		</c:if>
		<c:if test="${habStatusForm.contTypes4 =='N'}"> 
		<!-- <html:text property="aresenic" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" readonly="true"/> -->
		</c:if>
		<c:if test="${habStatusForm.contTypes5 =='Y'}"> 
		<td class="textborder" >Nitrate(PPM)</td>
		<td class="textborder">
				<html:text property="nitrate" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)" />
		</td>
		</c:if>
		<c:if test="${habStatusForm.contTypes5 =='N'}"> 
		<!-- <html:text property="nitrate" styleClass="mytext" style="width:50px"
				onkeyup="extractNumber2(this,7,2,false)" onkeypress="return blockNonNumbers(this, event, true, false)"  readonly="true"/> -->
		</c:if>
		</tr>
		</table>
		
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
		<tr>
	<td>
		<table width="100%">
	
			<td class="textborder" align=center>
			 <% if(request.getParameter("mode")!=null && request.getParameter("mode").equals("edit")){
				 %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
			<%}else { %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
			<html:button property="mode" title="View Contamination Details" styleClass="btext" value="View"   onclick="return viewfun()"/>
			<%} %>
			
			<% if(request.getParameter("mode")!=null && request.getParameter("mode").equals("edit")){ %>
			<html:button property="mode" title="Close The Form" styleClass="btext" value="Close"  onclick="javascript:self.close();"/>
			<%} %>
			
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
		<html:hidden property="contTypes1"/>
		<html:hidden property="contTypes2"/>
		<html:hidden property="contTypes3"/>
		<html:hidden property="contTypes4"/>
		<html:hidden property="contTypes5"/>
		</html:form>
<%@ include file="/commons/rws_alert.jsp"%>		 
	