<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%
	String uId = null;
	if(session.getAttribute("userId")==null){
		response.sendRedirect(request.getContextPath()+"/rws_login_frm.jsp");
	}
	else{
		uId=(String)session.getAttribute("userId"); System.out.println("uId :"+uId);
	}
	String special=request.getParameter("special");System.out.println("special :"+special);
%>
<html>
<head>
	<script language="javascript" src="/pred/resources/javascript/js/sha256.js"></script>
	<script type="text/javascript">
		function randomString(length) {
			var charStr = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		    var result = '';
		    for (var i = length; i > 0; --i){
		    	result += charStr.charAt(Math.floor(Math.random() * charStr.length));
		    }
		    return result;
		}
		
		function isStrongPwd1(password) {	 
			//var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-\+_\=])(?=.{8,})");
			//var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$%\^&\*\-\+_\=]){2,})(?=.{8,})");
			var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$\*\_\]){2,})(?=.{8,})");
		    var validPassword = strongRegex.test(password);
		    return validPassword;
		}
		
		function fnSave(){
				document.forms[0].userId.value='<%=uId%>';
				if(document.forms[0].userId.value==""){
					alert("User Id  Is Required");
					return false;
				}
				else if(document.forms[0].oldPassword.value==""){
					alert("Old Password  Is Required");
					document.forms[0].oldPassword.focus();
					document.forms[0].userId.value='<%=uId%>';
					return false;
				}
				else if(document.forms[0].newPassword.value==""){
					alert("New  Password  Is Required");
					document.forms[0].newPassword.focus();
					document.forms[0].userId.value='<%=uId%>';
					return false;
				}
				else if(document.forms[0].confirmPassword.value==""){
					alert("Confirm Password  Is Required");
					document.forms[0].confirmPassword.focus();
					document.forms[0].userId.value='<%=uId%>';
					return false;
				}			
				else if(document.forms[0].newPassword.value!=document.forms[0].confirmPassword.value){
					alert("New Password and Confirm Password does not match");
					document.forms[0].newPassword.value="";
					document.forms[0].confirmPassword.value="";
					document.forms[0].newPassword.focus();
					document.forms[0].userId.value='<%=uId%>';
					return false;
				}
				else if(!isStrongPwd1(document.forms[0].newPassword.value)){	
					//alert("The password must have atleast 8 chars with two uppercase letter, two lower case letter, two digit and two of !@#$*_ this Special Character");
					alert("The password does not meet the below password policy requirements :\n\n  * Minimum password length 8 characters\n  * Two upper case letters\n  * Two lower case letters\n  * Two numbers\n  * Two Special Character ( !@#$*_ )");
					document.forms[0].newPassword.value="";
					document.forms[0].confirmPassword.value="";
					document.forms[0].newPassword.focus();
					document.forms[0].userId.value='<%=uId%>';
					return false;
				}
				else{
					var user='<%=uId%>';			
					var oldPwd = document.forms[0].oldPassword.value;
					var salt = randomString(16);
				
					document.forms[0].slt.value = salt; 
					var uriEncOldPwd = encodeURI(oldPwd);		//URL encoding
					var hashOldPwd = CryptoJS.SHA256(uriEncOldPwd);		//SHA-256 Hash
					var firstHash = hashOldPwd.toString();
					var nextHashPwd = CryptoJS.SHA256(firstHash+salt);	//next SHA-256 hash with salt
					var Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64;}else if(isNaN(i)){a=64;}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a);}return t;},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r);}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t;},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128);}}return t;},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2;}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
					var baseEncOldHash = Base64.encode(nextHashPwd.toString());	//base64 encoding			
					var newPwd = document.forms[0].newPassword.value;
					var uriEncNewPwd = encodeURI(newPwd);		//URL encoding
					var hashNewPwd = CryptoJS.SHA256(uriEncNewPwd);		//SHA-256 Hash
					var baseEncNewHash = Base64.encode(hashNewPwd.toString());	//base64 encoding			
					document.forms[0].oldPassword.value = baseEncOldHash;
					document.forms[0].newPassword.value = baseEncNewHash;
					document.forms[0].confirmPassword.value="";
					document.forms[0].action="./rws_sec_changepass_process.jsp?user="+user;
					document.forms[0].submit();
				}
			} 
		
		function fnReset(){
		  document.forms[0].oldPassword.value="";
		  document.forms[0].newPassword.value="";
		  document.forms[0].confirmPassword.value="";
		}
	</script>
</head>
<body>
	<form method="post"><br/><br/>
		<div align="right" style="width: 80%; height: 322">
			<table style="border-collapse: collapse" borderColor="#4B72B1"  height="45" cellSpacing="0" cellPadding="0" width="236" border=4 align="center">
				<tbody>
					<tr>
				         <td width="100%" height=26 bgcolor="#fafad2" align="center">
				         	<b><font face="Verdana" color="#ffffff" size="1" >&nbsp;</font></b><font face="Verdana" color="#000000" size=2><b> Password Change Form</b></font>
				         </td>
				    </tr>
					 <tr>
						 <td>
							<table bgcolor="" cellpadding="5" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse" align="center">
								<tbody class="formTBody" >
									<tr>
										<td><font face=Verdana  size="2">User Id:<span class="mandatory">*</span></td>
										<td><font face=Verdana  size="2"><input type="text"  name="userId" value="<%=uId%>" styleClass="text-box"  readonly="true"/></td>
									</tr>
									<tr>
										<td nowrap><font face=Verdana  size="2">Old Password:</font><span class="mandatory">*</span></td>
										<td><input  type="password"  name="oldPassword" redisplay="false" styleClass="text-box" />
										<input type="hidden" name="slt"></td>
									</tr>
									<tr>
										<td nowrap><font face=Verdana  size="2" >New Password:</font><span class="mandatory">*</span></td>
										<td><input  type="password"  name="newPassword" redisplay="false" styleClass="text-box" /></td>
									</tr>
									<tr>
										<td nowrap><font face=Verdana  size="2">Confirm Password:<span class="mandatory">*</span></td>
										<td><input  type="password"  name="confirmPassword" redisplay="false" styleClass="text-box" /></td>
									</tr>
									<tr>
										<td align="center" colspan="2">
											<input type="button" class="btext" name="Save" value="Save" onclick="fnSave()">
											<input type="button" class="btext" name="Reset" value="Reset" onclick="fnReset()">
										</td>
									</tr>
								</tbody>
							</table>	
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" name="special" value="<%=special%>">
		</div>
<!-- <script>
document.getElementById("slt").type="password";
</script> -->
</form>
</body>
</html>