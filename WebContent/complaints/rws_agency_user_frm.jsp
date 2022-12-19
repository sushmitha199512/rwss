<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp" %>
<script src="/pred/resources/javascript/js/sha256.js"></script>
<script src="/pred/resources/js/epvalidations.js"></script>
<script>
function submitValidation(){
	if(selectvalid(document.all("agencycode"), " Agency Name")
	 && selectvalid(document.all("districtCode"), " District")	
	// && selectvalid(document.all("area"), " Area")	
	// && selectvalid(document.all("area"), " Area")	
	 &&check_address_mustWithAnd(document.all("userId"), " UserID")
	 &&passConfPass()
	 &&comparePwd(document.all("password"), document.all("confirmPassword"))
	 &&check_alphanumeric(document.all("name"), " Name")
	 &&check_number(document.all("aadhaar"), " Aadhaar Number")
	 &&checkminlen(document.all("aadhaar"), " Aadhaar Number", 12)
	 &&EmailValidation(document.all("email"))
	 &&check_number(document.all("mobile"), " Mobile")
	 &&checkminlen(document.all("mobile"), " Mobile", 10)
	 &&check_remarks_null(document.all("remarks"), " Remarks")
	 &&passEncription()
	 //
	){
		//return true;
		//alert(true);
		document.forms[0].action="switch.do?prefix=/complaints&page=/UserAgencyAct.do&mode=save";
		document.forms[0].submit(); 
	}
	else
		return false;
	
}
function passConfPass(){
	var password= document.all("password").value;
	var confirmPassword= document.all("confirmPassword").value;	
	if(trim(password)===''){
		document.all("password").focus();
		alert('Enter Password');
		return false;
	}
	else if (trim(confirmPassword)===''){
		document.all("confirmPassword").focus();
		alert('Confirm Enter Password');
		return false;
	}else
		return true;
		
}
function EmailValidation(Element) {
    var x = Element.value;
    var atpos = x.indexOf("@");
    var dotpos = x.lastIndexOf(".");
    if (atpos<1 || dotpos<atpos+2 || dotpos+2>=x.length) {
        alert("Not a valid e-mail address");
        return false;
    }
    else{
    	 return true;
    }
}
function passEncription(){
	var pwd= document.all("password").value;
	document.all("password").value='';
	document.all("confirmPassword").value='';
	var uriEncPwd = encodeURI(pwd);		//URL encoding
	var hashPwd = CryptoJS.SHA256(uriEncPwd);		//SHA-256 Hash
	var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
	var baseEncHash = Base64.encode(hashPwd.toString());	//base64 encoding
	//alert("Base 64 hash: "+baseEncHash);
	document.forms[0].password1.value = baseEncHash;	
	//alert(document.forms[0].password1.value);
	return true;
}

/* if('${message}'!=null||trim('${message}')!='') */
	
<%
	String message =(String)request.getAttribute("message");
	if(message!=null){
%>	
	alert('${message}');
<%}%>
</script>
<%@ include file="/commons/rws_header2.jsp" %>
<%-- <html:javascript formName="UserAgencyForm" />   --%>
<%-- <html:form method="post" action="/UserAgencyAct.do?mode=save" onsubmit="return validateUserAgencyForm(this)"> --%>
<html:form method="post" action="UserAgencyAct.do">
<table align="center" cellpadding="0" cellspacing="0">

<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Agency User Management" />
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
	<legend><bean:message key="legend.Agency"/></legend>
	<label>
	<table width="100%" class="formTbody">
	<tr>
		<td><bean:message key="app.agencyname" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="agencycode" styleClass="combo" onkeydown="javascript: fnGetOffices(this)">
				<html:option value="">SELECT...</html:option>
				<logic:present name="agencys">	
					<html:options collection="agencys" property="value" labelProperty="label" />
				</logic:present>
			</html:select>
		</td>
		
	</tr>
	<tr>	
		<td><bean:message key="app.district" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="districtCode" styleClass="combo" onkeydown="javascript: fnGetOffices(this)">
				<html:option value="0">SELECT...</html:option>
				<logic:present name="dists">
					<html:options collection="dists" property="value" labelProperty="label" />
			</logic:present>					
			</html:select>
		</td>		
	</tr>
	<tr>	
		<td>Area</td>
		<td>
			<html:select property="area" styleClass="combo" onchange="return check();"><span class="mandatory">*</span>
				<html:option value="R">Rural</html:option>
				<html:option value="U">Urban</html:option>				
			</html:select>
		</td>
	</tr>
	<tr>	
		<td><bean:message key="app.module" /></td>
		<td><html:text property="module" styleClass="thin-text-box" maxlength="25" value="Grievance" readonly="true" /></td>
		
		
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
		<td><bean:message key="app.userid" /><span class="mandatory">*</span></td>
		<td><html:text property="userId" styleClass="thin-text-box" maxlength="25"  /></td>
	</tr>
	<html:hidden property="password1"/>
	<tr>
		<td><bean:message key="app.password" /><span class="mandatory">*</span></td>
		<td><html:password property="password" styleClass="thin-text-box" maxlength="12"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.confirmpassword" /><span class="mandatory">*</span></td>
		<td><html:password property="confirmPassword" styleClass="thin-text-box" maxlength="12" onchange="javascript:fnSave()"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.name" /><span class="mandatory">*</span></td>
		<td><html:text property="name" styleClass="thin-text-box" maxlength="25" onchange="return check();"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.aadhaar" /><span class="mandatory">*</span></td>
		<td><html:text property="aadhaar" styleClass="thin-text-box" maxlength="12" onchange="return check();"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.email" /><span class="mandatory">*</span></td>
		<td><html:text property="email" styleClass="thin-text-box" maxlength="25" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.mobile" /><span class="mandatory">*</span></td>
		<td><html:text property="mobile" styleClass="thin-text-box" maxlength="10" onchange="return check();"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.hint" /></td>
		<td><html:textarea property="hint" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.remarks" /><span class="mandatory"></span></td>
		<td><html:textarea property="remarks" cols="15" rows="3" />
        </td>
		<%-- <td><html:text property="remarks"   styleClass="thin-text-box" maxlength="25"/></td> --%>
	</tr>
	
	</table>
	</label>
	</fieldset>
</td>
</tr>


<tr>
	<td colspan="2" align="center">
	<input type="submit" value="save" title="Save the Fields" class="btext" onclick="return submitValidation()"> 		
		<html:reset title="Clear all the Fields" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
		
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