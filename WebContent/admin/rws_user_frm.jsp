<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html>
<head>
<script src="/pred/resources/javascript/js/sha256.js"></script>
<script>
function fnGetOffices(elem){
	var elemName = elem.name;
	//alert("elemName :"+elemName);
	var url;
	if(elemName == 'headOfficeCode')
		url = "switch.do?prefix=/admin&page=/UserManagementData.do&mode=headOffice";
	else
	if(elemName == 'circleOfficeCode')
		url = "switch.do?prefix=/admin&page=/UserManagementData.do&mode=circle";
 	else
	if(elemName == 'divisionOfficeCode')
		url = "switch.do?prefix=/admin&page=/UserManagementData.do&mode=division";
	else
	if(elemName == 'subdivisionOfficeCode')
		url = "switch.do?prefix=/admin&page=/UserManagementData.do&mode=subdivision";
	else
	if(elemName == 'mandal')
		url = "switch.do?prefix=/admin&page=/UserManagementData.do&mode=mandal";
				
	var frm = elem.form;
	frm.action = url;
	frm.submit();
}

function isStrongPwd1(password) {	 
	//var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-\+_\=])(?=.{8,})");
	//var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$%\^&\*\-\+_\=]){2,})(?=.{8,})");
	var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$\*\_\]){2,})(?=.{8,})");
    var validPassword = strongRegex.test(password);
    return validPassword;
}

function fnSave(frm){
	if(document.forms[0].number.value!=""){
		var pwd = document.forms[0].password.value;
		var cnfmPwd = document.forms[0].confirmPassword.value;
		if(pwd!=""||pwd!=null){
			if(pwd==cnfmPwd) {
				if(isStrongPwd1(pwd)) {				           
					var uriEncPwd = encodeURI(pwd);		//URL encoding
					var hashPwd = CryptoJS.SHA256(uriEncPwd);		//SHA-256 Hash
					var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
					var baseEncHash = Base64.encode(hashPwd.toString());	//base64 encoding
					document.forms[0].password1.value = baseEncHash;
					document.forms[0].password.value = "";
					document.forms[0].confirmPassword.value = "";
					if(validateUserManagementForm(frm))
						return true;
				}
				else{
					//alert("The password must have atleast 8 chars with two uppercase letters, two lower case letters, two digits and two of !@#$*_ this Special Character");
					alert("The password does not meet the below password policy requirements :\n\n  * Minimum password length 8 characters\n  * Two upper case letters\n  * Two lower case letters\n  * Two numbers\n  * Two Special Character ( !@#$*_ )");
				}
			}else{
				alert("Password and Confirm Password does not match");
			}
		}else{
			alert("Password field is required");
		}
	}else{
		alert("Please Enter Security Code");
	}
	return false;	
}
function fnView(frm){
	if(document.forms[0].headOfficeCode.value==""){
		alert("Please Select Head Office");
		return;
	}
	else if(document.forms[0].circleOfficeCode.value=="00"){
		alert("Please Select Circle to View the Users");
	}
	else{
		frm.action = "switch.do?prefix=/admin&page=/UserManagementAction.do&mode=View";
		frm.submit();
	}
}
function getAjaxRequest(){
	var openRequest;
	try {
			openRequest = new XMLHttpRequest();
			return openRequest;
	    }
	catch (error) {
		try {
			openRequest = new ActiveXObject("Microsoft.XMLHTTP");
			return openRequest;
		}catch (error){
			if(isDebugOn)
			displayDebugError("Error crea");
		}	
	}
}

function autocompletion(){
    for (i=0; i<document.forms.length; i++) {
      	document.forms[i].setAttribute("AutoComplete","off");
     }
}
</script>
<html:javascript formName="UserManagementForm" />
</head>
<body onload="autocompletion()">
<html:form action="UserManagementAction">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table align="center" cellpadding="0" cellspacing="0">
<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="User Management" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</thead>
<tfoot>
<tr>
	<td>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="100%" />
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
	<table width="100%" class="formTbody">
	<tr>
		<td><bean:message key="app.headOffice" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="headOfficeCode" styleClass="combo" 
						 onchange="javascript: fnGetOffices(this)">
				<html:option value="">SELECT...</html:option>
				<logic:present name="headOffices">	
					<html:options collection="headOffices" property="value" labelProperty="label" />
				</logic:present>
			</html:select>
		</td>
		<td><bean:message key="app.circleOffice" /></td>
		<td>
			<html:select property="circleOfficeCode" styleClass="combo" 
						 onchange="javascript: fnGetOffices(this)">
				<html:option value="00">SELECT...</html:option>
				<logic:present name="circles">	
					<html:options collection="circles" property="value" labelProperty="label" />
				</logic:present>
			</html:select>
		</td>
	</tr>
	<tr>	
		<td><bean:message key="app.division" /></td>
		<td>
			<html:select property="divisionOfficeCode" styleClass="combo" 
						 onchange="javascript: fnGetOffices(this)">
				<html:option value="0">SELECT...</html:option>
				<logic:present name="divisions">
					<html:options collection="divisions" property="value" labelProperty="label" />
			</logic:present>					
			</html:select>
		</td>
		<td><bean:message key="app.subdivision" /></td>
		<td>
			<html:select property="subdivisionOfficeCode" styleClass="combo"
						 onchange="javascript: fnGetOffices(this)">
				<html:option value="00">SELECT...</html:option>
				<logic:present name="subdivisions">
					<html:options collection="subdivisions" property="value" labelProperty="label" />
				</logic:present>	
			</html:select>
		</td>
	</tr>
	<tr>	
		<td><bean:message key="app.mandal" /></td>
		<td>
			<html:select property="mandal" styleClass="combo" onchange="javascript: fnGetOffices(this)">
				<html:option value="00">SELECT...</html:option>
				<logic:present name="mandals">
					<html:options collection="mandals" property="value" labelProperty="label" />
			</logic:present>					
			</html:select>
		</td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.personalInformation" /></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><bean:message key="app.designation" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="designationCode" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<logic:present name="designations">
					<html:options collection="designations" property="value" labelProperty="label" />
				</logic:present>	
			</html:select>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.userid" /><span class="mandatory">*</span></td>
		<td><html:text property="userId" styleClass="thin-text-box" maxlength="25" readonly="true"/></td>
		<td><html:hidden property="userId" styleClass="thin-text-box"/></td>
	</tr>
	<html:hidden property="password1"/>
	<tr>
		<td><bean:message key="app.password" /><span class="mandatory">*</span></td>
		<td><html:password property="password" styleClass="thin-text-box" maxlength="12"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.confirmpassword" /><span class="mandatory">*</span></td>
		<td><html:password property="confirmPassword" styleClass="thin-text-box" maxlength="12"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.hint" /></td>
		<td><html:textarea property="hint" styleClass="thin-text-box"/></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.modules"/></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><html:checkbox property="proposals" /></td>
		<td nowrap><bean:message key="app.module.proposals" /></td>
		<td><html:checkbox property="estimates"  /></td>
		<td nowrap><bean:message key="app.module.estimates" /></td>
		<td><html:checkbox property="waterquality" /></td>
		<td nowrap><bean:message key="app.module.waterquality" /></td>
	</tr>
	<tr>
		<td><html:checkbox property="contractor" /></td>
		<td nowrap><bean:message key="app.module.contractor" /></td>
		<td><html:checkbox property="works" /></td>
		<td nowrap><bean:message key="app.module.works" /></td>
		<td><html:checkbox property="assets" /></td>
		<td nowrap><bean:message key="app.module.assets" /></td>
	</tr>
	<tr>
		<td><html:checkbox property="funds" /></td>
		<td nowrap><bean:message key="app.module.funds" /></td>
		<td><html:checkbox property="masters" /></td>
		<td nowrap><bean:message key="app.module.masters" /></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.permissions" /></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><html:checkbox property="read" /></td>
		<td nowrap><bean:message key="app.read" /></td>
		<td><html:checkbox property="write" /></td>
		<td nowrap><bean:message key="app.write" /></td>
		<td><html:checkbox property="del" /></td>
		<td nowrap><bean:message key="app.delete" /></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr><td>
<fieldset>
	<legend>Security Code</legend>
	<label>
	<div  id="captcha"><%@include file="./Captcha/form.jsp"%></div>
	</label>
	</fieldset></td></tr>
<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset title="Clear all the Fields" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
		<html:button property="mode" styleClass="btext" onclick="fnView(this.form)">
			<bean:message key="button.view"/>
		</html:button>
	</td>
</tr>
</table>

</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />
</body>
</html>