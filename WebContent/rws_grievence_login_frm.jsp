<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	window.onload = function() {
	 window.history.forward();
	}
</script>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"  integrity="sha384-MBO5IDfYaE6c6Aao94oZrIOiC6CGiSN2n4QUbHNPhzk5Xhm0djZLQqTpL0HzTUxk" crossorigin="anonymous"></script>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1,' />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="keywords" content="RURAL WATER SUPPLY, AP" />
<meta name="keywords" content="RURAL WATER SUPPLY, AP" />

<link rel="stylesheet" type="text/css"
	href="resources/style/dropdown.css" />
<link rel="stylesheet" type="text/css"
	href="resources/style/static_style.css" />
<link rel='stylesheet' type='text/css' href="resources/style/styles.css" />

<LINK rel=stylesheet type=text/css href="imagess/style.css">

<link rel="stylesheet" href="resources/style/demos.css">
<link rel="stylesheet" href="resources/style/example.css"
	type="text/css">

<link href="" rel="stylesheet" id="theme_css">

<link rel="stylesheet" type="text/css"
	href="resources/style/dropdown.css" />

<link rel="stylesheet" type="text/css"
	href="resources/style/rws-styles.css" />

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link rel="stylesheet" href="/pred/resources/style/jquery.ui.all.css"/>
<script language="JavaScript"
	src="/pred/resources/javascript/jquery-1.4.2.js"></script>



<script language="JavaScript" src="/pred/imagess/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/pred/imagess/jquery.jqDock.min.js"></script>
<link href="/pred/resources/style/dockstyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="/pred/resources/javascript/jscharts.js"></script>
<link rel="stylesheet" href="/pred/resources/style/example.css"
	type="text/css">
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/jquery.ui.all.css">
<script src="/pred/resources/javascript/jquery-3.6.0.js"></script>
<script src="/pred/resources/javascript/jquery.ui.core.js"></script>
<script src="/pred/resources/javascript/jquery.ui.widget.js"></script>
<script src="/pred/resources/javascript/jquery.ui.tabs.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css">
<link rel="stylesheet" href="/pred/resources/style/example.css"
	type="text/css">


<script src="/pred/resources/javascript/jquery.ui.mouse.js"></script>
<script src="/pred/resources/javascript/jquery.ui.resizable.js"></script>
<script src="/pred/resources/javascript/jquery.ui.accordion.js"></script>

<style>
a:link {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: none;
	color: #316A95
}

a:visited {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: none;
	color: #316A95
}

a:hover {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: underline;
	color: #316A95
}

body {
	margin: 0px;
	background-color: #87CEFF;
}
</style>

<style type="text/css">
<!--
body, td, th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #333333;
}

.style3 {
	color: #99CC66
}
-->
</style>

<script>

	$(function() {
		$("#accordion").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion1").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion2").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion3").accordion({
			event : "click hoverintent"
		});
	});
	$(function() {
		$("#accordion4").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion5").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion15").accordion({
			event : "click hoverintent"
		});
	});

	$(function() {
		$("#accordion6").accordion({
			event : "click hoverintent"
		});
	});

	var cfg = ($.hoverintent = {
		sensitivity : 7,
		interval : 100
	});

	$.event.special.hoverintent = {
		setup : function() {
			$(this).bind("mouseover", jQuery.event.special.hoverintent.handler);
		},
		teardown : function() {
			$(this).unbind("mouseover",
					jQuery.event.special.hoverintent.handler);
		},
		handler : function(event) {
			var self = this, args = arguments, target = $(event.target), cX, cY, pX, pY;

			function track(event) {
				cX = event.pageX;
				cY = event.pageY;
			}
			;
			pX = event.pageX;
			pY = event.pageY;
			function clear() {
				target.unbind("mousemove", track).unbind("mouseout",
						arguments.callee);
				clearTimeout(timeout);
			}
			function handler() {
				if ((Math.abs(pX - cX) + Math.abs(pY - cY)) < cfg.sensitivity) {
					clear();
					event.type = "hoverintent";
					// prevent accessing the original event since the new event
					// is fired asynchronously and the old event is no longer
					// usable (#6028)
					event.originalEvent = {};
					jQuery.event.handle.apply(self, args);
				} else {
					pX = cX;
					pY = cY;
					timeout = setTimeout(handler, cfg.interval);
				}
			}
			var timeout = setTimeout(handler, cfg.interval);
			target.mousemove(track).mouseout(clear);
			return true;
		}
	};
</script>
<script>
	$(function() {
		$("#tabs").tabs({

			event : "mouseover"
		});

	});
</script>


<script src="/pred/resources/javascript/js/sha256.js"></script>
<script type=text/javascript>
function randomString(length) {
	var chars = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    var result = '';
    for (var i = length; i > 0; --i) result += chars.charAt(Math.floor(Math.random() * chars.length));
    return result;
}
	
	function hideDefaultText(element, defaultVal) {
		if (element.value == defaultVal) {
			element.value = '';
		}
	}

	function showDefaultText(element, defaultVal) {
		if (element.value == '') {
			element.value = defaultVal;
		}
	}

	function IsEmpty(aTextField) {

		var regexp = /^(\s)*$/;

		if (regexp.test(aTextField.value)) {
			return true;

		} else {
			return false;
		}

	}

	/*  function otp(str) {
					alert("hi");
			 if(str == "ENC" || str == "EE-Budget"){
				document.forms[0].action="./rws_generate_otp.jsp";
					document.forms[0].submit();
			} 
			 
	}  */
	
	function submitFn() {
		//var uriEncodedPwd = encodeURI(document.forms[0].password1.value);
		//alert(uriEncodedPwd);

		if (document.forms[0].userId.value == ""
				|| document.forms[0].userId.value == "Enter User ID") {
			alert("UserId is required");
			return false;
		} else if (document.forms[0].password1.value == ""
				|| document.forms[0].password1.value == "Password") {
			alert("Password is required");
			return false;
		}
		else if(document.forms[0].number.value==""){
			alert("Please Enter Captch code");
			return false;
			}

		else if (document.forms[0].userId.value != ""
				&& document.forms[0].password1.value != ""
				&& document.forms[0].number.value!="") {
			
			var salt = randomString(16);
			//alert("Salt String: "+salt);
			document.forms[0].slt.value = salt;
			var pwd=document.forms[0].password1.value;
			 var uriEncPwd = encodeURI(pwd);		//URL encoding
			var hashPwd = CryptoJS.SHA256(uriEncPwd);		//SHA-256 Hash
			var firstHash = hashPwd.toString();
			//alert("first hash: "+firstHash);
			var nextHashPwd = CryptoJS.SHA256(firstHash+salt);		//next SHA-256 hash with salt
			//alert("second hash with salt: "+nextHashPwd);
			var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
			var baseEncHash = Base64.encode(nextHashPwd.toString());	//base64 encoding
			//alert("Base 64 hash: "+baseEncHash);
			
			document.forms[0].password.value = baseEncHash; 
			document.forms[0].password1.value="";
			//alert("welcome to greivance");
			document.forms[0].action="switch.do?prefix=/admin&page=/LoginGrievance.do";
			document.forms[0].submit();
			return true;
			
		}

		return false;
	}
</script>
<script >
/*  $(document).ready(function(){
	$('#myDiv').hide();
$('#userId').change('input',function(){
	
    if( $(this).val() != 'ENC' )
        $('#myDiv').hide();
    else
        $('#myDiv').show();
});
}); */ 
</script>
<title>W A T E R S O F T - Official Website of RWSS</title>

</head>
<body >
<%
	//Boolean AGENCY=false;
	//HttpSession ses=;
	session.setAttribute("AGENCY", true);
%>
	<center>
		<table width="952" border="0" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td width="10" valign="top" width="1" height="1"></td>
				<td bgcolor="white">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="96%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<!--<td valign="top"><img src="images/logo-1.jpg" width="950" height="129"></td>-->
										<td valign="top"><img src="images/logo.jpg" width="1100" height="134"></td>
									</tr>
									<tr>
										<td valign="center">
											
														<!-- <table width="100%" border="0" cellspacing="0" cellpadding="2">
															<td align="CENTER">
																<form method="post" action="Login.do" onSubmit="return submitFn()" focus="userId">
																	<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
																				<tr>
																					<td align="right" class="bwborder"><a href="/pred/home.jsp">Home</td> 
																				</tr>
																	</table>

																	<table style="BORDER-COLLAPSE: collapse;" height="202"
																		cellspacing="0" cellpadding="0" width="100%"
																		border="1" bordercolor="#0068A2">
													 -->
													 </br></br></br>
													 <table border = 0 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=400>		
														<caption>
															<table  border=0 rules=none style="border-collapse:collapse" width=100% bgcolor="#edf2f8">		
																<tr>
																	<td align="right" class="bwborder"><a href="/pred/rws_login_frm.jsp">Home</td> 
																</tr>
															</table>
														</caption>
														<form method="post"  onSubmit="return submitFn()" focus="userId">
													<TABLE style="BORDER-COLLAPSE: collapse" borderColor="#0068A2"  height=50 cellSpacing=0 cellPadding=0 
												                  width="400" border=3 align="center">
																							
																		<tbody>
																			<tr>
																				<td width="100%" height="18" bgcolor="#4A8AC7"
																					align="left"><b><font face="Verdana"
																						color="#ffffff" size="1">&nbsp;</font></b><font
																					face="Verdana" color="White" size="2"><b>Grievance Agency Registered Users</b></font></td>
																			</tr>
																			<tr>
																				<td width="100%" height="19">
																				<div align="center">
																	<center>
																	
																		<table id="AutoNumber14"
																			style="BORDER-COLLAPSE: collapse"
																			bordercolor="#111111" height="69"
																			cellspacing="0" cellpadding="0" width="96%"
																			border="0">
																			<tbody>
																				<tr>
																					<td width="32%" bgcolor="#ffffff" height="32"><font
																						face="Verdana" color="#856933"><b>&nbsp;Agency User	Id</b></font></td>
																					<td width="68%" bgcolor="#ffffff" height="32">
																						<p align="center">
																							<input type="text" name="userId" id="userId" styleclass="thin-text-box"
																								onFocus="return hideDefaultText(this, 'Enter User ID')"
																								onBlur="return showDefaultText(this, 'Enter User ID')"
																								value="Enter User ID" />
																						</p>
																					</td>
																				</tr>
																				<tr>
																					<td width="32%" bgcolor="#ffffff" height="32"><font
																						face="Verdana" color="#856933"><b>&nbsp;Password
																						</b></font>
																					</td>
																					<td width="68%" bgcolor="#ffffff" height="32"><p
																							align="center">
																							<input type="hidden" name="slt" /> <input
																								type="hidden" name="password" /> <input
																								type="password" name="password1"
																								styleclass="thin-text-box"
																								onFocus="return hideDefaultText(this, 'Password')"
																								onBlur="return showDefaultText(this, 'Password')"
																								value="Password" />
																						</p>
																					</td>
																				</tr>
																				<!-- <tr id="myDiv">
																				<td width="32%" bgcolor="#ffffff" height="32"><font
																						face="Verdana" color="#856933"><b>&nbsp;Enter OTP</b></font></td>
																				<td width="68%" bgcolor="#ffffff" height="32"><p
																							align="center"><input type="text" name='enterOtp'/></p></td>
																				</tr> --> 
<!-- <tr><td colspan="2"  style="text-align: right !important;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot password? </a></td></tr> -->
																				  <tr >
																				  	<td width="100%" bgcolor="#ffffff" colspan="2" height="10">Security Code
              																	 		<%@include file="./Captcha/form.jsp"%>
                         															 </td>
                         														  </tr> 																		  
																				  <tr>
																					<td width="100%" bgcolor="#ffffff" colspan="2" height="10">
																						<p align="center">
																							<input name="submit2" type="submit"	value="Login" /> 
																							<input name="reset2" type="reset" value="Reset" />
																						</p>
																					</td>
																				  </tr>
																				<!-- 
                               <tr><td colspan="2"  align="center"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot your password? </a></td></tr>
                               
                                -->
																			</tbody>
																		</table>
																	</center></td>
																	</tr>
																	</tbody>
																	
																	</table>
																	</form>
																	<!--    <a href="bluefrog.html" target="_blank">  <img src="images/wams_andhra.bmp" onMouseOver="this.src='images/wams_andhra.bmp'" onMouseOut="this.src='images/wams_andhra.bmp'" width="250" height="48" /></a> -->

																	<!-- <a href="http://ddws.gov.in/" target="_blank"> 
																	<img src="images/ddwswater1.jpg" onMouseOver="this.src='images/ddwswater1.jpg'"	onMouseOut="this.src='images/ddwswater1.jpg'"
																		width="400" height="48" />
																	</a>  -->
																	<br>
																	
																	<tr>
																		<td><img src="images/spacer.gif" width="1"
																			height="10"></td>
																	</tr>
														</table></td>
												</tr>
											</table></td>
								</table></td>
						</tr>
					
				<tr>


				<td colspan="4" height="25" bgcolor="#4A8AC7">
				<table	width="75%" border="0" align="center" cellpadding="0" cellspacing="0">
						<tr>

							<td colspan="4" align="center"><div align="center"><span class="style1">Content Owned by
									Rural Water Supply &amp; Sanitation Department, Govt of A.P.</span></div></td></tr>
									
									<tr><td>
									<div align="center">
									<span class="style1">Designed,
									Developed and Technically Maintained by National Informatics
									Centre, Andhra Pradesh State Centre. </span></div></td></tr>
							
				</table></td>




				<td width="1" valign="top"></td>
			</tr>
			</table>
			
		</table>
		</form>
</body>
</center>
</html>
<%@ include file="/commons/rws_alert.jsp"%>