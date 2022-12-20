<%@page import="nic.watersoft.admin.AdminDAO"%>
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
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
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
	color: #316A95;
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
<%
AdminDAO dao= new AdminDAO();
String slt=dao.randomNumber(16);
session.setAttribute("slt", slt);
%>
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
	function submitFn() {
		
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
			
			var salt='<%=slt%>';
					
			var pwd=document.forms[0].password1.value;
			/* var uriEncPwd = encodeURI(pwd);		//URL encoding
			var hashPwd = CryptoJS.SHA256(uriEncPwd);		//SHA-256 Hash
			var firstHash = hashPwd.toString(); */
			
			var nextHashPwd = CryptoJS.SHA256(pwd+salt);		//next SHA-256 hash with salt
			//alert("pwd :"+pwd);
			//alert("salt :"+salt);
			var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
			var baseEncHash = Base64.encode(nextHashPwd.toString());	//base64 encoding
				
			document.forms[0].password.value = baseEncHash;
			document.forms[0].password1.value="";
			return true;
		}

		return false;
	}
	
	function encryptPassword(){
		
		//var strongRegex = new RegExp("^(?=.*[a-z]{2})(?=.*[A-Z]{2})(?=.*[0-9]{2})(?=.*[!@#\$%\^&\*\-\+_\=]{2})(?=.{8,})");
		//var strongRegex = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*\-\+_\=])(?=.{8,})");
		var strongRegex = new RegExp("^(?=(.*[a-z]){2,})(?=(.*[A-Z]){2,})(?=(.*[0-9]){2,})(?=(.*[!@#\$%\^&\*\-\+_\=]){2,})(?=.{8,})");
	    var validPassword = strongRegex.test(document.forms[0].password1.value);
	    //alert(validPassword);
	    //validPassword = true;
	    if(document.forms[0].password1.value.length>0)
	    {
		    if(validPassword==true)
		       {
					var pwd=document.forms[0].password1.value;
					var uriEncPwd = encodeURI(pwd);		
					var hashPwd = CryptoJS.SHA256(uriEncPwd);
					var firstHash = hashPwd.toString();
					document.forms[0].password1.value=firstHash;
		       }
		    else
		       {
			    	document.forms[0].password1.value="";
			    	//alert("The password must have atleast 8 chars with two uppercase letter, two lower case letter, two digit and two of !@#$%^&*-_+= this Special Character");
			    	alert("The password does not meet the below password policy requirements :\n\n  * Minimum password length 8 characters\n  * Two upper case letters\n  * Two lower case letters\n  * Two numbers\n  * Two Special Character ( !@#$*_ )");
			    	document.forms[0].password1.focus();
		       }
	    }
	}
</script>
<script type="text/javascript">
 function autocompletion()
{
    
for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
 </script>
 <%

if(request.getHeader("User-Agent").indexOf("Firefox")>=0){
	
%>
<script type = "text/javascript" >
function changeHashOnLoad() {
	  window.location.href += "#";
     setTimeout("changeHashAgain()", "50"); 
}

function changeHashAgain() {
  window.location.href += "1";
}

var storedHash = window.location.hash;
window.setInterval(function () {
    if (window.location.hash != storedHash) {
         window.location.hash = storedHash;
    }
}, 50);
</script>
<%} %>

<title>W A T E R S O F T - Official Website of RWSS</title>

</head>
<!-- <script type="text/javascript" src="https://www.mygov.in/overlay/overlay.js"></script> -->
<body onload="changeHashOnLoad();autocompletion();" >
<%
	//Boolean AGENCY=false;
	//HttpSession ses=;
	session.setAttribute("AGENCY", false);
%>
	<center>

		<table width="952" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<!-- <td width="10" valign="top" width="1" height="1"></td> -->
				<td bgcolor="white"><table width="100%" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top"><table width="96%" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<!--<td valign="top"><img src="images/logo-1.jpg" width="950" height="129"></td>-->
										<td valign="top"><img src="images/logo1.png" width="1100"
											height="134"></td>
									<tr>
										<td valign="top"><TABLE WIDTH=1100 BORDER=0 CELLPADDING=0
												CELLSPACING=0 height="6">
												<tr>
													<Td>
														<div id='cssmenu'>
															<ul>
																<li><a href='#'><span>Home</span></a></li>
																<li class='has-sub'><a href='aboutap.html'><span>About
																			Us</span></a> <span class="style3"></span></li>
																<li class='has-sub'><a href='programmeap.html'><span>Programmes</span></a>
																<li class='has-sub'><a href='OandMap.html'><span>O
																			& M</span></a></li>
																<li class='last'><a href='contactusap.html'><span>Contact
																			Us</span></a></li>
																<!--<li class='last'><a href="rws_grievance_frm.jsp"><FONT
																		class="style10">&nbsp;&nbsp;Grievance
																			Monitoring System</FONT></a></li>
																 <li class='last'><a href="rws_grievence_login_frm.jsp"><FONT
																		class="style10">&nbsp;&nbsp;GMS Login</FONT></a></li> -->
																		<!-- <li class='last'><a href="switch.do?prefix=/admin&page=/LoginGrievance.do&mode=login"><FONT
																		class="style10">&nbsp;&nbsp;GMS Login</FONT></a></li> -->
															</ul>
														</div>
													</Td>
												</tr>

											</table></td>
									</tr>
									<tr>
										<td valign="top"><table width="100%" border="0"
												cellspacing="0" cellpadding="0">
												<tr>
													<td width="215" valign="top" bgcolor="white">
														<table width="215" border="0" cellspacing="0"
															cellpadding="0">

															<tr>
																<td><TABLE WIDTH=215 BORDER=0 CELLPADDING=0
																		CELLSPACING=0>

																		<tr>
																			<td>
																				<div id="menu6">
																					<ul>
																						<li><a
																							href="./reports/rws_hab_status_resource_out_rpt.jsp"
																							target="_self" class="h4"
																							title="Citizen Services"></a></li>
																					</ul>
																				</div>
																			</td>
																		</tr>
																		<TR>
																			<TD>
																				<div id="menu5">
																					<ul>
																						<!--<li><a href="./downloads/RWS.pdf"
																							target="_blank" title="RWS&S At a Glance">
																								RWS&S At a Glance</a></li>
																						<li><a href="budgetap.html" title="AP Budget">Budget</a></li>
																						<li><a href="orgchrtap.html"
																							title="Org Chart"> Org. Chart</a></li>
																						 <li><a href="IECHRDap.html" title="IEC & HRD Callender">IEC & HRD Calender</a></li> 
																						<li><a href="./downloads/Success_Stories.pdf"
																							target="_blank" title="Success Stories">
																								Success Stories</a></li>
																						<li><a href="./downloads/initiatives.pdf"
																							target="_blank" title="New Intiatives">New
																								Initiatives</a></li>
																						<li><a href="Functionaryap.html"
																							title="Functionary">Functionary</a></li>
																						<li><a href="Executionap.html"
																							title="Execution">Execution</a></li>
																						<li><a href="Reportsblueap.html"
																							title="Reports">Reports</a></li>
																						<li><a href="MediaGallery.html"
																							title="MediaGallery">Media Gallery</a></li>-->
																							
																							<li><a href="./downloads/RWSS _At_A_Glance.pdf"
																							target="_blank" title="RWS&S At a Glance">
																								RWS&S At a Glance</a></li>
																						<li><a href="budgetap.jsp" title="AP Budget">Budget</a></li>
																						<li><a href="orgchrtap.jsp"
																							title="Org Chart"> Org. Chart</a></li>
																							<li><a href="sucessap.jsp"  title="Success Stories">
																								Success Stories</a></li>
																						
																								
																								<li><a href="./downloads/Innovative_Technologies.pdf"
																							target="_blank" title="New Intiatives">New
																								Initiatives</a></li>
																						<li><a href="Functionaryap.jsp"
																							title="Functionary">Functionary</a></li>
																						<li><a href="Executionap.jsp"
																							title="Execution">Execution</a></li>
																						<li><a href="Reportsblueap.jsp"
																							title="Reports">Reports</a></li>
																						<!--<li><a href="MediaGallery.jsp"
																							title="MediaGallery">Media Gallery</a></li>-->
																						<li><a href="./help/mobile_privacy_policy.html"
																							title="PrivacyPolicy">Privacy Policy</a></li>
	
																					</ul>
																				</div>

																			</TD>
																		</TR>




																	</TABLE></td>
															</tr>



														</table> <a href="http://www.smart.ap.gov.in/" target="_blank">
															<img src="images/smart.png"
															onMouseOver="this.src='images/smart.png'"
															onMouseOut="this.src='images/smart.png'" width="200"
															height="48" />
													</a> <a href="https://webmail.ap.gov.in/" target="_blank"><img
															src="images/web.jpg"
															onMouseOver="this.src='images/web.jpg'"
															onMouseOut="this.src='images/web.jpg'" width="200"
															height="48" /></a> <a href="http://india.gov.in/"
														target="_blank"> <img src="./images/india_gov_in.png"
															width="200" height="48"></a> <a href="bluefrog.html"
														target="_blank"> <img src="images/wams_andhra.bmp"
															onMouseOver="this.src='images/wams_andhra.bmp'"
															onMouseOut="this.src='images/wams_andhra.bmp'"
															width="200" height="48" /></a> <!-- 			 <a href="http://ddws.gov.in/" target="_blank">  <img src="images/ddwswater1.jpg" onMouseOver="this.src='images/ddwswater1.jpg'" onMouseOut="this.src='images/ddwswater1.jpg'" width="200" height="38" /></a> -->



														<a href="https://mail.nic.in/mail/mauth" target="_blank"><img
															src="images/nnic.jpg"
															onMouseOver="this.src='images/nnic.jpg'"
															onMouseOut="this.src='images/nnic.jpg'" width="200"
															height="50" /></a>

													</td>


													<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="0">
															<tr>
																<td valign="top" background="images/bg-logo.jpg"><table
																		width="95%" border="0" align="center" cellpadding="0"
																		cellspacing="0">


																		<tr>
																			<td align="center"><table width="97%" border="0"
																					cellspacing="0" cellpadding="0">
																					<tr>
																						<td valign="top" colspan="2"><div
																								align="justify">
																								The Drinking Water Supply is very important
																								issue in the present times in the light of the
																								increasing health awareness among the rural
																								public. One of the most important objective of
																								the State Government is to provide safe drinking
																								water to the rural population. <br> <br>
																								The Rural Water Supply and Sanitation Department
																								is nodal agency in the State for providing
																								drinking water and Sanitation facilities in
																								rural areas under RWS sector. The drinking water
																								facilities are being provided by various types
																								such as
																							</div></td>
																					</tr>


																					<tr>
																						<td valign="top">&nbsp;</td>
																					</tr>
																					<tr>
																						<td valign="top"><table width="100%"
																								border="0" cellspacing="0" cellpadding="0">
																								<tr>
																									<td width="106" valign="top"><img
																										src="images/wel-im.jpg" width="96"
																										height="100"></td>
																									<td><table width="95%" border="0"
																											align="center" cellpadding="5"
																											cellspacing="0">
																											<tr>
																												<td width="10" valign="top"><img
																													src="images/arrow.gif" width="9"
																													height="13"></td>
																												<td>Spot sources (Bore Wells fitted
																													with Hand Pumps)</td>
																											</tr>
																											<tr>
																												<td valign="top"><img
																													src="images/arrow.gif" width="9"
																													height="13"></td>
																												<td>Protected Water Supply Schemes (for
																													one habitation/village)</td>
																											</tr>
																											<tr>
																												<td valign="top"><img
																													src="images/arrow.gif" width="9"
																													height="13"></td>
																												<td>Comprehensive Protected Water
																													Supply Schemes (for a group of habitations/
																													villages)</td>
																											</tr>



																										</table></td>
																								</tr>
																								<tr>
																									<td height="20"></td>
																								</tr>
																							</table>
																						<!--	<marquee><font color =red><h3>"Please Complete  Yearly data updation(YDU) and Habitation Directory Corrections by 10-06-2019. Habitation Directory will be freezed by 10 am on 11-6-2019 "</h3></font></marquee>   -->
																																														<div id="tabs">

																								<ul>
																									<li><a href="#gos">GOs</a></li>
																									<li><a href="#noti">Notifications</a></li>
																									<li><a href="#circlular">Circular's</a></li>
																									<li><a href="#ssr">SSR</a></li>
																									<li><a href="#guide">Guidelines</a></li>

																								</ul>
																								<div id="gos">
																									<table>
																										<tr>
																											<td>1.<a
																												href="./downloads/04012013PR_MS4.PDF"
																												target="_blank">GO MS NO 4 - SWAP Mode</a></td>
																										</tr>
																										<tr>
																											<td>2.<a
																												href="./downloads/GOMsNo195.pdf"
																												target="_blank">GO. Ms. No. 195 -
																													Entrustment procudure for PR and RWS</a></td>
																										</tr>
																										<tr>
																											<td>3.<a href="./downloads/GO Ms 94.pdf"
																												target="_blank">GO Ms. No. 94 - For
																													Registration of Contractors</a></td>
																										</tr>
																										<tr>
																											<td>4.<a
																												href="./downloads/Go.RT.No. 569.pdf"
																												target="_blank">Go.RT.No. 569 - O & M of
																													RWS Assets</a></td>
																										</tr>
																										<tr>
																											<td>5.<a
																												href="./downloads/O & M -2290.pdf"
																												target="_blank">GO MS NO-2290 - O & M
																													Protocol</a></td>
																										</tr>
																										<tr>
																											<td>6.<a
																												href="./downloads/O & M Modifications -RT1292.PDF"
																												target="_blank">GO RT NO 1292 -
																													Modifications to GO NO 2290</a></td>
																										</tr>
																										<tr>
																											<td>7.<a
																												href="./downloads/GO.MS.No 8.pdf"
																												target="_blank">G.O.MS.NO.8  -
																													 Entrustment and Contract Management of works Execution</a></td>
																										</tr>
																										<tr>
																											<td>8.<a
																												href="./downloads/G.O RT No 266.pdf"
																												target="_blank">G.O.Rt.No.266 Finance department Dt.15-02-2021.-EMD and FSD -Relaxation of certain contractual obligations in view of COVID-19 pandemic</a></td>
																										</tr>

																									</table>

																								</div>



																								<div id="noti">
																									<table border="0" align="center"
																										cellpadding="8" cellspacing="1"
																										bgcolor="lightblue">
																										<tr bgcolor="lightblue">
																											<td width="50" align="left" valign="top"><h3>
																													<strong>Slno</strong>
																												</h3></td>
																											<td width="100" align="left" valign="top"><h3>
																													<strong>Catgegory</strong>
																												</h3></td>
																											<td width="350" align="left" valign="top"><h3>
																													<strong>Act</strong>
																												</h3></td>
																											<td width="100" align="left" valign="top"><h3>
																													<strong>Number</strong>
																												</h3></td>
																											<td width="100" align="left" valign="top"><h3>
																													<strong>Year</strong>
																												</h3></td>
																										</tr>
																										<tr bgcolor="white">
																											<td align="left" valign="top">1</td>
																											<td align="left" valign="top">General</td>
																											<td align="left" valign="top"><a
																												href="./downloads/notifications/rti-act-english.pdf"
																												target="_blank">Right to Information
																													Act(English)</a></td>
																											<td align="left" valign="top">22</td>
																											<td align="left" valign="top">2005.</td>
																										</tr>



																										<tr bgcolor="white">
																											<td align="left" valign="top">2</td>
																											<td align="left" valign="top">General</td>
																											<td align="left" valign="top"><a
																												href="./downloads/notifications/TELUGU-RighttoInformationAct.pdf"
																												target="_blank">Right to Information
																													Act(Telugu)</a></td>
																											<td align="left" valign="top">22</td>
																											<td align="left" valign="top">2005.</td>
																										</tr>


																										<tr bgcolor="white">
																											<td align="left" valign="top">3</td>
																											<td align="left" valign="top">General</td>
																											<td align="left" valign="top"><a
																												href="./downloads/notifications/scstsubplan_act.pdf"
																												target="_blank">SC ST Subplan</a></td>
																											<td align="left" valign="top">1</td>
																											<td align="left" valign="top">2013.</td>
																										</tr>
																										
																										<tr bgcolor="white">
																											<td align="left" valign="top">4</td>
																											<td align="left" valign="top">General</td>
																											<td align="left" valign="top"><a
																												href="./downloads/notifications/Draft EOI HAM 20-3-20 10AM R4.pdf"
																												target="_blank">EoI proposals for DWPP on HAM</a></td>
																											<td align="left" valign="top"></td>
																											<td align="left" valign="top">2020.</td>
																										</tr>
																										<tr bgcolor="white">
<td align="left" valign="top">5</td>
<td align="left" valign="top">General</td>
<td align="left" valign="top"><a
href="./downloads/notifications/Uddanamtenderdocumentsreg.zip"
target="_blank">Tender documents relating to the project-Providing drinking water
Supply Scheme to Uddanam area of Srikakulam district, inviting
objections/suggestions</a></td>
<td align="left" valign="top"></td>
<td align="left" valign="top">2020.</td>
</tr>

<tr bgcolor="white">
<td align="left" valign="top">6</td>
<td align="left" valign="top">JJM</td>
<td align="left" valign="top"><a
href="./downloads/notifications/AP-Villages upto 20 FHTCs remaining.xlsx"
target="_blank">It is to note that there are around 1027 Villages with upto 10 FHTCs  remaining  and  in another 954 Villages  11-20 FHTCs are to be provided. It is suggested to kindly take up these Villages at the earliest on priority basis and convert these 1981 Villages to "Har Ghar Jal Village with 100% FHTCs. An Analysis carried out  for each district is presented below for your kind perusal and necessary action. A complete list of villages with up to 20 FHTCs remaining is enclosed herewith as mentioned above.</a></td>
<td align="left" valign="top"></td>
<td align="left" valign="top"></td>
</tr>
																									</table>
																								</div>







																								<div id="circlular">
																									<table>
																										<tr>
																											<td height="50"><a
																												href="./downloads/O & M Circular -Memo-15-5-15.pdf"
																												target="_blank">O & M Circular</a></td>
																										</tr>
																									</table>
																								</div>

																								<div id="ssr">
																									<table border="0" align="center"
																										cellpadding="8" cellspacing="1"
																										bgcolor="lightblue">
																										<tr bgcolor="lightblue">
																											<td width="150" align="left" valign="top"><h3>
																													<strong>Slno</strong>
																												</h3></td>
																											<td width="150" align="left" valign="top"><h3>
																													<strong>Subject</strong>
																												</h3></td>
																											<td width="300" align="left" valign="top"><h3>
																													<strong>Year</strong>
																												</h3></td>
																										</tr>
																										<!--  <tr bgcolor="white">
          <td align="left" valign="top">1</td>
            <td align="left" valign="top"><a href="./downloads/SSR/minutes SSR meeting.rar" target="_blank">Minutes SoR</a></td>
            <td align="left" valign="top">01.07.2014.</td>
          </tr> -->

																										<!--<tr bgcolor="white">
																											<td align="left" valign="top">1</td>
																											<td align="left" valign="top"><a
																												href="./downloads/SSR 2015-16.pdf"
																												target="_blank">Schedule of Rates.</a></td>
																											<td align="left" valign="top">2015-16.</td>
																										</tr>-->
																										<tr bgcolor="white">
																											<td align="left" valign="top">1</td>
																											<td align="left" valign="top"><a
																												href="./downloads/SOR 2016-17.pdf"
																												target="_blank">Schedule of Rates.</a></td>
																											<td align="left" valign="top">2016-17.</td>
																										</tr>

																										<tr bgcolor="white">
																											<td align="left" valign="top">2</td>
																											<td align="left" valign="top"><a
																												href="./downloads/STANDARD DATA 2016-17.pdf"
																												target="_blank">Standard Data.</a></td>
																											<td align="left" valign="top">2016-17.</td>
																										</tr>
<tr bgcolor="white">
																											<td align="left" valign="top">3</td>
																											<td align="left" valign="top"><a
																												href="./downloads/StandardData-2019-20.pdf"
																												target="_blank">Standard Data.</a></td>
																											<td align="left" valign="top">2019-2020.</td>
																										
</tr>
<tr bgcolor="white">
																											<td align="left" valign="top">3</td>
																											<td align="left" valign="top"><a
																												href="./downloads/DeptDesigns.zip"
																												target="_blank">Designs </a></td>
																											<td align="left" valign="top">2020-21.</td>
																										</tr>

																										<tr bgcolor="white">
																											<td align="left" valign="top">4</td>
																											<td align="left" valign="top"><a
																												href="./downloads/Sor_and_Standard_data_Part-I_for_the_year_2020-21.zip"
																												target="_blank">Schedule of Rates </a></td>
																											<td align="left" valign="top">2020-21.</td>
																										</tr>

																									</table>
																								</div>
																								<div id="guide">
																									<table border="0" align="center"
																										cellpadding="8" cellspacing="1"
																										bgcolor="lightblue">
																										<tr bgcolor="lightblue">
																											<td width="150" align="left" valign="top"><h3>
																													<strong>Slno</strong>
																												</h3></td>
																											<td width="200" align="left" valign="top"><h3>
																													<strong>Catgegory</strong>
																												</h3></td>
																											<td width="150" align="left" valign="top"><h3>
																													<strong>Subject</strong>
																												</h3></td>
																											<td width="300" align="left" valign="top"><h3>
																													<strong>Year</strong>
																												</h3></td>
																										</tr>
																										<tr bgcolor="white">
																											<td align="left" valign="top">1</td>
																											<td align="left" valign="top">Water</td>
																											<td align="left" valign="top"><a
																												href="./downloads/Guidelines/NRDWP_Guidelines_2013.pdf"
																												target="_blank">NRDWP GUIDELINES</a></td>
																											<td align="left" valign="top">2013</td>

																										</tr>

																										<!--   <tr bgcolor="white">
          <td align="left" valign="top">2</td>
            <td align="left" valign="top">Sanitation</td>
            <td align="left" valign="top"><a href="./downloads/Guidelines/NBAFinal Guidelines (English).pdf" target="_blank">NBA GUIDELINES</a></td>
            <td align="left" valign="top">2012</td>
            
          </tr> -->

																											<tr bgcolor="white">
																											<td align="left" valign="top">2</td>
																											<td align="left" valign="top">Jal Jeevan Mission</td>
																											<td align="left" valign="top"><a
																												href="./downloads/JJM_Operational_Guidelines.pdf"
																												target="_blank">JJM GUIDELINES</a></td>
																											<td align="left" valign="top">2020</td>

																										</tr>

																										
																										
																										<tr bgcolor="white">
																											<td align="left" valign="top">3</td>
																											<td align="left" valign="top">Sanitation</td>
																											<td align="left" valign="top"><a
																												href="./downloads/guidelines_Swachh_Bharat_Mission_Gramin-mod.pdf"
																												target="_blank">SBM GUIDELINES</a></td>
																											<td align="left" valign="top">Dec-2014</td>

																										</tr>



																									</table>
																								</div>



																							</div>
																				</table></td>







																		</tr>






																	</table></td>

															</tr>

														</table>
													</td>



													<td width="244" valign="top"><table width="100%"
															border="0" cellspacing="0" cellpadding="2">
															<!--srinu-->





															<div class="news_container_main">
																<div class="news_tab_heading_bg1">
																	<div class="tab_heading">What's New</div>
																	<div class="view_all_main"></div>
																</div>


																<div class="BlockContent">
																	<div class="BlockContent-body">
																		<marquee direction="up" scrolldelay="25"
																			scrollamount="2" onMouseOver="this.stop()"
																			onMouseOut="this.start()" height="175">
																																						<a href="./downloads/EOINotice_swsm_2952020.pdf" target=_new>
<img src="images/arrow1.gif" /> Expression of Interest(EOI)-Conducting survey and preparation of DPRs for Construction of Decentralised Waste water TreatmentPlants<img src="images/new.gif" />
</a> <br>
</br>
																			<a href="./advt/rwsssujalapathakamrepairsoperationsandmaintenanceo.zip"
																				target="_blank"> <img src="images/arrow1.gif" />Expression of Interest is invited for Repairs, Operations and Maintenance of existing Individual Water Treatment Plants under YSR Sujala Pathakam Dt.05-11-2019<img src="images/new.gif"></a> <br></br>
																		
																		<a
																				href="./downloads/notifications/Draft EOI HAM 20-3-20 10AM R4.pdf"
																				target="_blank"><img src="images/arrow1.gif" />EoI proposals for DWPP on HAM
												 <img src="images/new.gif" /></a> <br></br>
												 <a
																				href="./downloads/notifications/addendum.pdf"
																				target="_blank"><img src="images/arrow1.gif" />EoI proposals for DWPP on HAM date extended(Addendum)
												 <img src="images/new.gif" /></a> <br></br>
												 <a href="./downloads/notifications/Uddanamtenderdocumentsreg.zip" target=_new>
<img src="images/arrow1.gif" /> Tender documents relating to the project-Providing drinking water
Supply Scheme to Uddanam area of Srikakulam district, inviting
objections/suggestions <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/Opening_up_of_Water_Quality_Testing_facilities_to_general_Public.pdf" target=_new>
<img src="images/arrow1.gif" /> Opening up of Water· Quality Testing facilities to general Public <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/ISA_EOI_.pdf" target=_new>
<img src="images/arrow1.gif" /> Empanelment  of Implementation Support Agencies (ISAs) for Implementation of JJM in Rural Water Supply and Sanitation Department of Government of Andhra Pradesh <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/corrigendum for ISAs.pdf" target=_new>
<img src="images/arrow1.gif" /> Corrigendum extending the due date for submission of EoIs for the work Empanelment of Implementation Support Agencies (ISAs) for Implementation of JJM in RWS&SD of GoAP <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/NOTICE ISA PREBID.pdf" target=_new>
<img src="images/arrow1.gif" /> Link to participate in pre-bid meeting proposed on 4-6-21 by RWS&SD for the work Empanelment of Implementation supporting agencies for the monitoring of Jal-Jeevan Mission in AP state <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/replies to queries.pdf" target=_new>
<img src="images/arrow1.gif" /> Replies to the queries raised by the agencies on the work ''Implementation of Supporting agencies '' for monoitoring of JJM work in AP State. <img src="images/new.gif" />
</a> <br><br>
<a href="./downloads/notifications/Seniority.pdf" target=_new>
<img src="images/arrow1.gif" /> Establishment - RWS&S Department - Provisional State Wide Integrated Seniority List of Deputy Executive Engineers, RWS&S Graduates and Non Graduates in the AP State as on 01.04.2008 - Communicated -Objections called for - Regarding. <img src="images/new.gif" />
</a> <br><br>
																		
																		
																		<!--	<a href="./advt/EnquiryNotice23-11-2018NTRSujalaPathakam-QuotationsCalledfor.zip"
																				target="_blank"> <img src="images/arrow1.gif" />Enquiry Notice 23-11-2018  Sujala Pathakam- Quotations Called for<img src="images/new.gif"></a> <br></br>
																			
																		<!--	<a href="./advt/RFPUGDRWS.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />Preparation of DPRs for certain underground drainages in RWS&S Department<img src="images/new.gif"></a> <br></br>
																			
																			<a href="./advt/EOI27082018.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />Supply, Delievery abd installation of HSC and VT pump to O&M of SSS CPWS Scheme in West Godavati District<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/scan0361.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />Corrigendum to the work Conducting survey and preparation of DPRs to UGDs<img src="images/new.gif"></a> <br></br> -->

																		<!--	<a href="./advt/TORUGDRWS.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />RFP for preparation of DPRs by conducting survey for Under ground drainages<img src="images/new.gif"></a> <br></br>
																			-->
																		<!--	<a href="./advt/PACKAGE 10 - Nellore Second call.rar"
																				target="_blank"> <img src="images/arrow1.gif" />NTR SUJALA- Package No 10-Nellore Second Call-Reg<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE 06 - Prakasam Second call.zip"
																				target="_blank"> <img src="images/arrow1.gif" />NTR SUJALA- Prakasam- 2nd call-Package No 6<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE17_Anantapur Second call.zip"
																				target="_blank"> <img src="images/arrow1.gif" />NTR SUJALA- Anantapur- 2nd Call for Pacakage No.17<img src="images/new.gif"></a> <br></br>			-->			
																			<!--	<a href="./advt/AmendmentEOISudedrains.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />Amendment - open side drains - EOI<img src="images/new.gif"></a> <br></br>
																 	<a href="./advt/EOIforSurvey.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />EoI for engagement of consultancy services for preparation of DPRs for construction of drains<img src="images/new.gif"></a> <br></br> 
																				<a href="./advt/EOIfinal09072018.PDF" target="_blank">
																			 <img src="images/arrow1.gif" />Expression of Interest(EOI) for Supply, Laying of Pre-casted Side Drains<img src="images/new.gif"></a> <br></br>		-->																	
																			<!--
																			<a href="./advt/PACKAGE01_Srikakulam.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Srikakulam- Request For Proposal No.1<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE02_Visakhapatnam.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- VISAKHAPATNAM- Request For Proposal No.2<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE03_EastGodavari.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- East Godavari- Request For Proposal No.3<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE04_Krishna.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- KRISHNA- Request For Proposal No.4<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE05_Guntur.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- GUNTUR- Request For Proposal No.5<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE06_Prakasam.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Prakasam-1 - Request For Proposal No.6<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE07_Prakasam.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Prakasam-2 - Request For Proposal No.7<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE08_Prakasam.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Prakasam-3 - Request For Proposal No.8<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE09_Nellore.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Nellore-1 Request For Proposal No.9<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE10_Nellore.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Nellore-2 Request For Proposal No.10<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE11_Chittoor.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Chittoor- Request For Proposal No.11<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE12_Chittoor.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- Chittoor-2 - Request For Proposal No.12<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE13_Kadapa.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- KADAPA- Request For Proposal No.13<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE14_Kurnool.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- KURNOOL- Request For Proposal No.14<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE15_Anantapur.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- ANANTHAPUR-1 - Request For Proposal No.15<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE16_Anantapur.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- ANANTHAPUR-2 - Request For Proposal No.16<img src="images/new.gif"></a> <br></br>
																			<a href="./advt/PACKAGE17_Anantapur.zip"
																				target="_blank"> <img src="images/arrow1.gif" />SUJALA- ANANTHAPUR-3 - Request For Proposal No.17<img src="images/new.gif"></a> <br></br>

																		
																		<a href="./advt/TenderDocumentforEEPs.pdf" target="_blank">
																			<img src="images/arrow1.gif" />Tender for replacement of old pumpsets with energy efficient pumpsets<img src="images/new.gif"></a> <br></br>
																		<a href="./advt/App.pdf" target="_blank">
																			 <img src="images/arrow1.gif" />Tender notice released in paper add<img src="images/new.gif"></a> <br></br>

			<!--	<a href="./advt/EoIToRFINAL17042018.pdf" target="_blank">
<img src="images/arrow1.gif" />SUJALA - EXPRESSION OF INTEREST<img src="images/new.gif"></a> <br></br> -->
<!--
<a href="./advt/APDWSCEPCRFPFinal.pdf" target="_blank">
<img src="images/arrow1.gif" />RFP for Consulatancy services of bid process management in APDWSC <img src="images/new.gif"></a> <br></br>	-->											<!--<div class="news_scroll_txt"><img src="images/bullet_g.GIF" class="list_icon" alt="" height="7" width="7"></div>-->
																			<!--<a href="./advt/apdwscham-responsetoapplicantqueries.pdf" target="_blank"><img
																				src="images/arrow1.gif" />Response To Applicant Queries<img src="images/new.gif"></a> <br></br>
																			
																			<a href="./advt/Corrigendum.pdf" target="_blank"><img
																				src="images/arrow1.gif" />CORRIGENDUM<img src="images/new.gif"></a> <br></br>
																																					
																			<a href="./advt/NOTE.pdf" target="_blank"><img
																				src="images/arrow1.gif" />Note pertaining to EoI of RWS <img src="images/new.gif"></a> <br></br>
																			
																			<!--<a href="./advt/apdwschameoi.pdf" target="_blank"><img
																				src="images/arrow1.gif" />APDWSC-UPLOAD RFP of EoI <img src="images/new.gif"></a> <br></br>
																			
																			<a href="./advt/disinfection EOI.pdf" target="_blank"><img
																				src="images/arrow1.gif" />EOI  notice regarding the work  Implementation of Disinfection technology with various techniques for SVS and MVS Schemes in rural Area of A.P<img src="images/new.gif"></a> <br></br>
																				
																			<a href="./advt/scan0219.pdf" target="_blank"><img
																				src="images/arrow1.gif" />EOI effective implementation of disinfection technology with various techniques fro SVS and MVS Schemes in Rural areas in AP<img src="images/new.gif"></a> <br></br>
																			
                                                                       <!--  <a href="./advt/EOI.pdf" target="_blank"><img
																				src="images/arrow1.gif" />EoI notice for engagement of consultancy services for preparation of Detailed Project for RWS Schemes<img src="images/new.gif"></a> <br></br>
																		
																			

																			<a href="./advt/advt_new.pdf" target="_blank"><img
																				src="images/arrow1.gif" />Advertisement No. RWS&S/Consultant/Workplan/2015-16</a> <br></br>

																			<a
																				href="./downloads/EoI_for_Implementation_of_Swacch_Bharat__Government_of_Andhra_Pradesh_NS_14_May_15.pdf"
																				target="_blank"><img src="images/arrow1.gif" />EOI,TOR
																				NGO's Participation. <img src="images/new.gif" /></a> <br></br>
																			<a href="http://www.smart.ap.gov.in/" target=_new>
																				<img src="images/arrow1.gif" /> Smart Andhra
																				Pradesh <img src="images/new.gif" />
																			</a> <br>
																			<br>
<!--																			<a href="NtrSujalaHomePage.html"
																				target="_New"><img src="images/arrow1.gif" />
																				Sujala Patakam <img src="images/new.gif"></a> 
																			<br></br>


																			 <a href="./unicef_onlineapplication.jsp" target="_blank"><img src="images/arrow1.gif" />Notification of SBM(G) By UNICEF.</a>
<br></br> 
																			<a href="./Enquiry_Notices_For_Lab_Materials.jsp"
																				target="_blank"><img src="images/arrow1.gif" />Enquiry
																				Notices For Water Quality Laboratory Materials . <img
																				src="images/new.gif" /> </a> <br></br>
																			<!-- <a href="./downloads/Tasks___Qualifications_of_WSSO_consultants.pdf" target="_blank"><img src="images/arrow1.gif" />  Tasks Qualifications Of WSSO Consultants. </a>
<br></br>
<a href="./downloads/Application_form_-_08-10-2013.pdf" target="_blank"><img src="images/arrow1.gif" />&nbsp;&nbsp; Application Form. </a>

<br></br> -->

																		</marquee>
																	</div>
																</div>
															</div>
															</div>



															<td align="left">
																<form method="post" action="Login.do"
																	onSubmit="return submitFn()" focus="userId">

																	<table style="BORDER-COLLAPSE: collapse;" height="202"
																		cellspacing="0" cellpadding="0" width="100%"
																		border="1" bordercolor="#0068A2">
																		<tbody>
																			<tr>
																				<td width="100%" height="18" bgcolor="#4A8AC7"
																					align="left"><b><font face="Verdana"
																						color="#ffffff" size="1">&nbsp;</font></b><font
																					face="Verdana" color="White" size="2"><b>Authorized
																							RWSS Users</b></font></td>
																			</tr>
																			<tr>
																				<td width="100%" height="19"><div
																						align="center">
																						<center>
																							<table id="AutoNumber14"
																								style="BORDER-COLLAPSE: collapse"
																								bordercolor="#111111" height="69"
																								cellspacing="0" cellpadding="0" width="96%"
																								border="0">
																								<tbody>
																									<tr>
																										<td width="32%" bgcolor="#ffffff" height="32"><font
																											face="Verdana" color="#856933"><b>&nbsp;User
																													Id</b></font></td>
																										<td width="68%" bgcolor="#ffffff" height="32"><p
																												align="center">
																												<input type="text" name="userId"
																													styleclass="thin-text-box" autocomplete=off
																													onFocus="return hideDefaultText(this, 'Enter User ID')"
																													onBlur="return showDefaultText(this, 'Enter User ID')"
																													value="Enter User ID" />
																											</p></td>
																									</tr>
																									<tr>
																										<td width="32%" bgcolor="#ffffff" height="32"><font
																											face="Verdana" color="#856933"><b>&nbsp;Password
																											</b></font></td>
																										<td width="68%" bgcolor="#ffffff" height="32"><p
																												align="center">
																												 <input
																													type="hidden" name="password" autocomplete=off /> <input
																													type="password" name="password1" autocomplete=off
																													styleclass="thin-text-box"
																													onFocus="return hideDefaultText(this, 'Password')"
																													onBlur="return encryptPassword();" 
																													 value="Password" />
																											</p></td>
																									</tr>
<!-- <tr><td colspan="2"  style="text-align: right !important;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot password? </a></td></tr> -->
																									  <tr ><td width="100%" bgcolor="#ffffff" colspan="2" height="10" >Security Code

	                   <%@include file="./Captcha/form.jsp"%>
	                              </td></tr> 


																									<tr>
																										<td width="100%" bgcolor="#ffffff" colspan="2"
																											height="10"><p align="center">
																												<input name="submit2" type="submit"
																													value="Login" /> <input name="reset2"
																													type="reset" value="Reset" />
																											</p></td>
																									</tr>
																									<!-- 
                                    <tr><td colspan="2"  align="center"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot your password? </a></td></tr>
                                    
                                     -->
																								</tbody>
																							</table>
																						</center></td>
																	</table>
																	<!--    <a href="bluefrog.html" target="_blank">  <img src="images/wams_andhra.bmp" onMouseOver="this.src='images/wams_andhra.bmp'" onMouseOut="this.src='images/wams_andhra.bmp'" width="250" height="48" /></a> -->

																	<a href="http://ddws.gov.in/" target="_blank"> <img
																		src="images/ddwswater1.jpg"
																		onMouseOver="this.src='images/ddwswater1.jpg'"
																		onMouseOut="this.src='images/ddwswater1.jpg'"
																		width="250" height="48" /></a> <br>
	<%-- <%
         Integer hitsCount = (Integer)application.getAttribute("hitCounter");
         if( hitsCount ==null || hitsCount == 0 ) 
	         {
	            hitsCount = 1;
	         } 
         else 
	         {
	            hitsCount += 1;
	         }
         application.setAttribute("hitCounter", hitsCount);
      %>
      <center>
         <div class="visirots">Total number of visits<br><font size="5"> <%= hitsCount%></font></div>
      </center> --%><br>
       <%@include file="./admin/rws_Web_Page_Hits.jsp"%>
																	<tr>
																		<td><img src="images/spacer.gif" width="1"
																			height="10"></td>
																	</tr>
														</table></td>
												</tr>



											</table></td>
								</table></td>



						</tr>
					</table></td>
			</tr>







			<tr>


				<td colspan="4" height="25" bgcolor="#4A8AC7"><table
						width="95%" border="0" align="center" cellpadding="0"
						cellspacing="0">
						<tr>

							<td colspan="4" align="center"><div align="center"><span class="style1">Content Owned by
									Rural Water Supply &amp; Sanitation Department, Govt of A.P.</span></div></td></tr>
									
									<tr><td>
									<div align="center">
									<span class="style1">Designed,
									Developed and Technically Maintained by National Informatics
									Centre. </span></div></td></tr>
							</table></td>




				<td width="1" valign="top"></td>
			</tr>
		</table>
		<input type="hidden" name="as_sfid" value="AAAAAAVVB8zI43tE-lZL6aP42wlMZkj4lj_Y5sLIQq5giRadWf3eSMWFlkyDF9wMdM-GuOX4wReqJyKll7jjrO1PVtrTYfqHegUFglOX-UlioDUEIgbkeCARdP-jL900EUnmbiE=" /><input type="hidden" name="as_fid" value="748c954e4f7b7f88c1955fda6b5feca20641334d" /></form>
</body>
</center>
</html>
<%@ include file="/commons/rws_alert.jsp"%>
