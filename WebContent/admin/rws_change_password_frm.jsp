<%@ include file="/commons/rws_header1.jsp"%>
<html:javascript formName="ChangePasswordForm" />
<%@ include file="/commons/rws_header2.jsp"%>

<html>
<head>
<script language="javascript" src="/pred/resources/javascript/js/sha256.js"></script>
<script language="javascript">

function validatePassword()
	{
		
		//alert("function");
	
		var pass=document.forms[0].newPassword.value;
		var confirmpass=document.forms[0].confirmPassword.value;
	
		if(pass.length<8){
	
			alert("Password should be minimum 8 digit With Combination of Characters and Numbers,Special Symbols");
			return false;
		}
		else if(pass!=confirmpass)
		{
	  		alert("New Password and Confirm Passwod should be Same");
	  		return false;
		}
		else
		{
			var lower= false;
			var upper= false;
			var numeric= false;
			var x=0;
			var specialCharsAll =false;
			for(x=0;x<pass.length;x++)
			{
				var c=pass.charAt(x);
				if ((c >= 'a') && (c <= 'z')) lower=true;
				if ((c >= 'A') && (c <= 'Z')) upper=true;
				if ((c >= '0') && (c <= '9')) numeric=true;
				if((c=='@' || c=='#' ||c=='$' || c=='%' || c=='(' ||c==')' || c=='*' || c=='&' || c=='_' || c=='^' || c=='!')) specialCharsAll = true;		
						
			}
		
			//alert("lower: "+lower);
			//alert("upper: "+upper);
			//alert("numeric: "+numeric);
			//alert("specialCharsAll: "+specialCharsAll);
			
			if(lower == false || upper == false || numeric == false || specialCharsAll == false)
			{
				//alert("inside if");
				alert("Password should be the combination of Special Characters,Numbers, lowercase and uppercase...");
				return false;
			}
			else
			{
				//alert("inside else");
				var uriEncNewPwd = encodeURI(pass);		//URL encoding
				var hashNewPwd = CryptoJS.SHA256(uriEncNewPwd);		//SHA-256 Hash
				var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64;}else if(isNaN(i)){a=64;}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a);}return t;},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r);}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t;},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128);}}return t;},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2;}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
				var baseEncNewHash = Base64.encode(hashNewPwd.toString());	//base64 encoding
				//alert("base64 hash: "+baseEncNewHash);
				document.forms[0].newPassword.value = baseEncNewHash;
				document.forms[0].confirmPassword.value = "";
				return true;
			}
		}
		return false;
	}
</script>

</head>
<body>
<html:form action="/ChangePasswordAction" onsubmit="return validatePassword(this)">
<table align="center" cellpadding="0" cellspacing="0">

<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader3.jsp">
			<jsp:param name="TableName" value="Change Password" />
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
	<table bgcolor="#DEE3E0" cellpadding="5" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
	<tbody class="formTBody">
	<tr>
		<td><bean:message key="app.userid" /><span class="mandatory">*</span></td>
		<td><html:text property="userId" readonly="true" styleClass="thin-text-box"  /></td>
	</tr>
	<tr>
		<td><bean:message key="app.newpassword" /><span class="mandatory">*</span></td>
		<td><html:password property="newPassword" redisplay="false" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td><bean:message key="app.confirmpassword" /><span class="mandatory">*</span></td>
		<td><html:password property="confirmPassword" redisplay="false" styleClass="thin-text-box" /></td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<html:submit styleClass="btext"><bean:message key="app.save"/></html:submit>
			<html:reset styleClass="btext"><bean:message key="app.clear"/></html:reset>
		</td>
	</tr>
	</tbody>
	</table>	
</td>
</tr>
</tbody>
</table>
</html:form>
</body>
</html>
<p><font color="red"><b>Note:</b></font><font color="green">1.Password Should be minimum 8 and maximum 15 characters Can contain alphabets, numbers and special characters( ! @ # $ % ^ & * ( ) _ are accepted ).<br>2.Should not contain space</font></p>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />
<%@ include file="/commons/rws_alert.jsp"%>