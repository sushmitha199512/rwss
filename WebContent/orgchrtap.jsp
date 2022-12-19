<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
.dropbtn {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
}

.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-content {
    display: none;
    position: absolute;
    right: 0;
    background-color: #f9f9f9;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {background-color: #f1f1f1}

.dropdown:hover .dropdown-content {
    display: block;
}

.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
</style>
<style type="text/css">
#navmenu{
margin-top:3%;
margin-bottom:6%;
}
ul#menu li{
position:static;
float:left;
text-align:center;
list-style-type:none;
}
#menu a{
text-decoration:none;
}





#menu a{
    text-decoration:none;
    border:2px solid black;
    width:240px;
    display:inline-block;
    line-height:25px;
    text-shadow: 0 -1px 3px #99ccff;
    box-shadow: 0 3px 4px #99ccff;
    border-radius:3px;
    -moz-border-radius:3px;
    -webkit-border-radius:3px;
    -moz-box-shadow: 0px 3px 3px #99ccff;
    -webkit-box-shadow:0px 3px 3px #99ccff;
    /*background-color:#3399ff;
    color:white;*/
    margin-right:6%;
}
.sub{
display:none;
position:absolute;
z-index:9;
text-align:left;

}
ul#menu li:hover .sub{
display:block;
}



</style>
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
<script>
	$(function() {
		$( "#tabs" ).tabs({
    
			event: "mouseover"
		});

	});
	
	</script>
	
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
			alert("Salt String: "+salt);
			document.forms[0].slt.value = salt;
			var pwd=document.forms[0].password1.value;
			var uriEncPwd = encodeURI(pwd);		//URL encoding
			var hashPwd = CryptoJS.SHA256(uriEncPwd);		//SHA-256 Hash
			var firstHash = hashPwd.toString();
			
			var nextHashPwd = CryptoJS.SHA256(firstHash+salt);		
			
			var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
			var baseEncHash = Base64.encode(nextHashPwd.toString());	//base64 encoding
			
			
			document.forms[0].password.value = baseEncHash;
			document.forms[0].password1.value="";
			return true;
		}

		return false;
	}
</script>

<title>W A T E R S O F T - Official Website of RWSS</title>

</head>
<body>
	<center>

		<table width="952" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="10" valign="top" width="1" height="1"></td>
				<td bgcolor="white"><table width="100%" border="0"
						cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top"><table width="96%" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<!--<td valign="top"><img src="images/logo-1.jpg" width="950" height="129"></td>-->
										<td valign="top"><img src="images/logo.jpg" width="1100"
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
																		class="style10">&nbsp;&nbsp;GMS Login</FONT></a></li>--> 
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


																						<!-- <li><a href="./downloads/RWS.pdf"
																							target="_blank" title="RWS&S At a Glance">
																								RWS&S At a Glance</a></li> -->
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
																						<li><a href="MediaGallery.jsp"
																							title="MediaGallery">Media Gallery</a></li>




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
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td valign="top" background=" "><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                         
                      
                          
                          <tr>
                <td align="center" valign="top"><table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td ><!-- InstanceBeginEditable name="EditRegion1" -->
                      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                         <td valign="top"><font color=#4A8AC7><b>Org.Chart</b></font>&nbsp;</td>
                        </tr>
                        
                       
                        <td>
                        <!-- <p><img src="images/ap-watersoft-links-page-001.jpg" width="569" height="479" /></p> -->
                    <!--  <p><img src="images/RWS-Organisation Chart-001.jpg" width="569" height="479" /></p>  -->
                    <p><img src="images/RWSSOrganisation.png" width="569" height="479" /></p>
                   
                           </td>
                           
                          <tr>
                          <td>&nbsp;</td>
                        </tr><tr>
                          <td>&nbsp;</td>
                        </tr>      
                        
                   <tr>
                         <td valign="top"><font color=#4A8AC7><b>AP-Staff Allocation</b></font>&nbsp;</td>
                        </tr>
                        
                        <tr>
                          <td>&nbsp;</td>
                        </tr><tr>
                          <td>&nbsp;</td>
                        </tr>      
                        
                      
                    

<table border="0" align="center" cellpadding="4" cellspacing="1" bgcolor="lightblue" width="400">

 <tr><td align="left" cellspacing="1"><b>AP-Staff Allocation</b></td>
</tr>

             
  <tr bgcolor="lightblue">
          <td align="left" valign="top" ><b>Post</b></td>
            <td align="right" valign="top"><b>Sanctioned Strength</b></td>
   </tr>

          <tr bgcolor="white">
          <td align="left" valign="top" >Engineer-in-Chief</td>
            <td align="right" valign="top">1</td>
          
          </tr>

		  <tr bgcolor="white">
          <td align="left" valign="top">Chief Engineers</td>
            <td align="right" valign="top">4</td>
            
            
            
          </tr>
		  <tr bgcolor="white">
          <td align="left" valign="top">Superintending Engineers</td>
            <td align="right" valign="top">14</td>
            
            
            
          </tr>
		    
		  <tr bgcolor="white">
          <td align="left" valign="top">Executive Engineers</td>
            <td align="right" valign="top">35</td>
         
            
            
          </tr>
           <tr bgcolor="white">
          <td align="left" valign="top">Dy.Executive Engineers</td>
            <td align="right" valign="top">213</td>
           
            
            
          </tr>

		  <tr bgcolor="white">
          <td align="left" valign="top">Section Officers (AEE/AE)</td>
            <td align="right" valign="top">1231</td>
            
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Supporting(Technical) Staff </td>
            <td align="right" valign="top">1606</td>
           
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Executive Director</td>
            <td align="right" valign="top"></td>
           
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Joint Director</td>
            <td align="right" valign="top">1</td>
           
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Geological Staff</td>
            <td align="right" valign="top">26</td>
          
            
            
          </tr>
		  
		 <tr bgcolor="white">
          <td align="left" valign="top">Chemist</td>
            <td align="right" valign="top"></td>
            
            
            
          </tr>

		   <tr bgcolor="white">
          <td align="left" valign="top">WQ Lab Staff</td>
            <td align="right" valign="top">26</td>
            
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">NTPA</td>
            <td align="right" valign="top">1</td>
            
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Ministerial Staff</td>
            <td align="right" valign="top">689</td>
          
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Others</td>
            <td align="right" valign="top">574</td>
            
            
            
          </tr>
         
		 <tr bgcolor="white">
          <td align="left" valign="top">Total</td>
            <td align="right" valign="top">4421</td>
        
        
         
        </table>  
                            
                             
                        
                        
                        
                          </tr>
                          
                          
                          
                        </table></td>      
                        
                          
                          
                     
						
						
						
						
						
						
						
                      </tr>
                      
					 
					 
					  
					
                      
                      </table></td>
						
                      </tr>
                     
                    </table></td>
				

                   					
                    <td width="244" valign="top"><table width="100%"
															border="0" cellspacing="0" cellpadding="2">
															<!--srinu-->




<!-- saira 6-9-2022
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
																			<div class="news_scroll_txt"><img src="images/bullet_g.GIF" class="list_icon" alt="" height="7" width="7"></div>

																			<a href="./advt/advt_new.pdf" target="_blank"><img
																				src="images/arrow1.gif" />Advertisement No. RWS&S/Consultant/Workplan/2015-16<img src="images/new.gif"></a> <br></br>

																			<a
																				href="./downloads/EoI_for_Implementation_of_Swacch_Bharat__Government_of_Andhra_Pradesh_NS_14_May_15.pdf"
																				target="_blank"><img src="images/arrow1.gif" />EOI,TOR
																				NGO's Participation. <img src="images/new.gif" /></a> <br></br>
																			<a href="http://www.smart.ap.gov.in/" target=_new>
																				<img src="images/arrow1.gif" /> Smart Andhra
																				Pradesh <img src="images/new.gif" />
																			</a> <br>
																			<br> <a href="NtrSujalaHomePage.html"
																				target="_New"><img src="images/arrow1.gif" />
																				NTR Sujala Patakam <img src="images/new.gif"></a>
																			<br></br>


																			<a href="./unicef_onlineapplication.jsp" target="_blank"><img src="images/arrow1.gif" />Notification of SBM(G) By UNICEF.</a>
<br></br>
																			<a href="./Enquiry_Notices_For_Lab_Materials.jsp"
																				target="_blank"><img src="images/arrow1.gif" />Enquiry
																				Notices For Water Quality Laboratory Materials . <img
																				src="images/new.gif" /> </a> <br></br>
																			<a href="./downloads/Tasks___Qualifications_of_WSSO_consultants.pdf" target="_blank"><img src="images/arrow1.gif" />  Tasks Qualifications Of WSSO Consultants. </a>
<br></br>
<a href="./downloads/Application_form_-_08-10-2013.pdf" target="_blank"><img src="images/arrow1.gif" />&nbsp;&nbsp; Application Form. </a>

<br></br>

																		</marquee>
																	</div>
																</div>
															</div>
															</div> -->



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
																													styleclass="thin-text-box"
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
																												<input type="hidden" name="slt" /> <input
																													type="hidden" name="password" /> <input
																													type="password" name="password1"
																													styleclass="thin-text-box"
																													onFocus="return hideDefaultText(this, 'Password')"
																													onBlur="return showDefaultText(this, 'Password')"
																													value="Password" />
																											</p></td>
																									</tr>
<!-- <tr><td colspan="2"  style="text-align: right !important;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot password? </a></td></tr> -->
																									  <tr ><td width="100%" bgcolor="#ffffff" colspan="2" height="10">Security Code

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




																	


																	<tr>
																		<td><img src="images/spacer.gif" width="1"
																			height="10"></td>
																	</tr>
														</table></td>
														<!--Ending  -->
					
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

							<td colspan="4"><span class="style1">&copy; 2014-15
									Rural Water Supply &amp; Sanitation.</span><span class="style1">Designed,
									Developed &amp; Hosted and Maintained by National Informatics
									Centre, Andhra Pradesh State Centre </span></td>
					</table></td>




				<td width="1" valign="top"></td>
			</tr>
		</table>
		</form>
</body>
</center>
</html>
<%@ include file="/commons/rws_alert.jsp"%>