<%@page import="nic.watersoft.admin.AdminDAO"%>
<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <script type="text/javascript">
	window.onload = function() 
	{
	 window.history.forward();
	}
</script>
<%
AdminDAO dao= new AdminDAO();
String slt=dao.randomNumber(16);
session.setAttribute("slt", slt);
System.out.println("in index..."+session.getAttribute("slt"));
%>
<script src="/pred/resources/javascript/js/sha256.js"></script>
<script type=text/javascript>

	
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
			
			var Base64 = {_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(e){var t="";var n,r,i,s,o,u,a;var f=0;e=Base64._utf8_encode(e);while(f<e.length){n=e.charCodeAt(f++);r=e.charCodeAt(f++);i=e.charCodeAt(f++);s=n>>2;o=(n&3)<<4|r>>4;u=(r&15)<<2|i>>6;a=i&63;if(isNaN(r)){u=a=64}else if(isNaN(i)){a=64}t=t+this._keyStr.charAt(s)+this._keyStr.charAt(o)+this._keyStr.charAt(u)+this._keyStr.charAt(a)}return t},decode:function(e){var t="";var n,r,i;var s,o,u,a;var f=0;e=e.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(f<e.length){s=this._keyStr.indexOf(e.charAt(f++));o=this._keyStr.indexOf(e.charAt(f++));u=this._keyStr.indexOf(e.charAt(f++));a=this._keyStr.indexOf(e.charAt(f++));n=s<<2|o>>4;r=(o&15)<<4|u>>2;i=(u&3)<<6|a;t=t+String.fromCharCode(n);if(u!=64){t=t+String.fromCharCode(r)}if(a!=64){t=t+String.fromCharCode(i)}}t=Base64._utf8_decode(t);return t},_utf8_encode:function(e){e=e.replace(/\r\n/g,"\n");var t="";for(var n=0;n<e.length;n++){var r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r)}else if(r>127&&r<2048){t+=String.fromCharCode(r>>6|192);t+=String.fromCharCode(r&63|128)}else{t+=String.fromCharCode(r>>12|224);t+=String.fromCharCode(r>>6&63|128);t+=String.fromCharCode(r&63|128)}}return t},_utf8_decode:function(e){var t="";var n=0;var r=c1=c2=0;while(n<e.length){r=e.charCodeAt(n);if(r<128){t+=String.fromCharCode(r);n++}else if(r>191&&r<224){c2=e.charCodeAt(n+1);t+=String.fromCharCode((r&31)<<6|c2&63);n+=2}else{c2=e.charCodeAt(n+1);c3=e.charCodeAt(n+2);t+=String.fromCharCode((r&15)<<12|(c2&63)<<6|c3&63);n+=3;}}return t;}};
			var baseEncHash = Base64.encode(nextHashPwd.toString());	//base64 encoding
				
			document.forms[0].password.value = baseEncHash;
			document.forms[0].password1.value="";
			return true;
		}

		return false;
	}
	
	function encryptPassword(){		
		
		var pwd=document.forms[0].password1.value;
		var uriEncPwd = encodeURI(pwd);		
		var hashPwd = CryptoJS.SHA256(uriEncPwd);
		var firstHash = hashPwd.toString();
		document.forms[0].password1.value=firstHash;
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

<!-- <title>W A T E R S O F T - Official Website of RWSS</title> -->

    

    <!-- Meta Tags -->
    <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="ThemeMascot" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Page Title -->
   <title>W A T E R S O F T - Official Website of RWSS</title>

    <!-- Favicon and Touch Icons -->
    <link href="img/aplogo.png" rel="shortcut icon" type="image/png">
    <link href="img/aplogo.png" rel="apple-touch-icon">
    <link href="img/aplogo.png" rel="apple-touch-icon" sizes="72x72">
    <link href="img/aplogo.png" rel="apple-touch-icon" sizes="114x114">
    <link href="img/aplogo.png" rel="apple-touch-icon" sizes="144x144">

    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="css/jquery-ui.min.css" rel="stylesheet" type="text/css">
    <link href="css/animate.css" rel="stylesheet" type="text/css">
    <link href="css/css-plugin-collections.css" rel="stylesheet" />
    <!-- CSS | menuzord megamenu skins -->
    <link href="css/menuzord-megamenu.css" rel="stylesheet" />
    <link id="menuzord-menu-skins" href="css/menuzord-skins/menuzord-boxed.css" rel="stylesheet" />
    <!-- CSS | Main style file -->
    <link href="css/style-main.css" rel="stylesheet" type="text/css">
    <!-- CSS | Preloader Styles -->
    <link href="css/preloader.css" rel="stylesheet" type="text/css">
    <!-- CSS | Custom Margin Padding Collection -->
    <link href="css/custom-bootstrap-margin-padding.css" rel="stylesheet" type="text/css">
    <!-- CSS | Responsive media queries -->
    <link href="css/responsive.css" rel="stylesheet" type="text/css">
    <!-- CSS | Style css. This is the file where you can place your own custom css code. Just uncomment it and use it. -->
    <!-- <link href="css/style.css" rel="stylesheet" type="text/css"> -->


<!------ Include the above in your HEAD tag ---------->
    <!-- CSS | Theme Color -->
    <link href="css/colors/theme-skin-color-set1.css" rel="stylesheet" type="text/css">

    <!-- external javascripts -->
    <script src="js/jquery-2.2.4.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- JS | jquery plugin collection for this theme -->
    <script src="js/jquery-plugin-collection.js"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
 <style>
.vertical-menu {
  height:  400px;
}

.vertical-menu a {
  background-color: #eee;
  color: black;
  display: block;
  padding: 15px;
  text-decoration: none;
  
}

.vertical-menu a:hover {
  background-color:#8e8cf0 ;
}


.login {
  width: 400px;
  margin: 16px auto;
  font-size: 16px;
}

/* Reset top and bottom margins from certain elements */
.login-header,
.login p {
  margin-top: 0;
  margin-bottom: 0;
}

/* The triangle form is achieved by a CSS hack */
.login-triangle {
  width: 0;
  margin-right: auto;
  margin-left: auto;
  border: 12px solid transparent;
  border-bottom-color: #28d;
}

.login-header {
  background: #28d;
  padding: 20px;
  font-size: 1.4em;
  font-weight: normal;
  text-align: center;
  text-transform: uppercase;
  color: #fff;
}

.login-container {
  background: #ebebeb;
  padding: 12px;
}

/* Every row inside .login-container is defined with p tags */
.login p {
  padding: 12px;
}

.login input {
  box-sizing: border-box;
  display: block;
  width: 100%;
  border-width: 1px;
  border-style: solid;
  padding: 16px;
  outline: 0;
  font-family: inherit;
  font-size: 0.95em;
}

.login input[type="email"],
.login input[type="password"] {
  background: #fff;
  border-color: #bbb;
  color: #555;
}

/* Text fields' focus effect */
.login input[type="email"]:focus,
.login input[type="password"]:focus {
  border-color: #888;
}

.login input[type="submit"] {
  background: #28d;
  border-color: transparent;
  color: #fff;
  cursor: pointer;
}

.login input[type="submit"]:hover {
  background: #17c;
}

/* Buttons' focus effect */
.login input[type="submit"]:focus {
  border-color: #05a;
}
h3 {
    color:#17c;
}

</style>
</head>

<body class="">
    <div id="wrapper" class="clearfix">
        <!-- preloader 
        <div id="preloader">
    <div id="spinner">
      <img alt="" src="img/pre1.gif">
    </div>
    <div id="disable-preloader" class="btn btn-default btn-sm">Disable Preloader</div>
  </div>-->
        <!-- Header -->
          <header id="header" class="header" style="background-color: #fff">
            <div class="header-top bg-theme-colored2 sm-text-center">
     
            <!--mantop head-->
            <div class="header-top bg-theme-colored2 sm-text-center">
                <div class="container">
                    <div class="row" >
                        <div class="col-md-2 col-xs-2">
                            <img src="img/aplogo.jpg" alt="" height="100" width="100" class="pb-10 pt-15">
                        </div>
                        <div class="col-md-8 col-xs-8">
                            <h1 class="text-center" style="color:black;font-size:26px;margin-bottom:0px; color:#003991;"><b>Rural Water Supply & Sanitation</b></h1>
                            <h4 class=" text-center my-4 mt-5" style="margin-top: -30px;color:rgb(15, 15, 15); font-size: 16px">Government Of Andhra Pradesh</h4>

               
                        </div>
                        <div class="col-md-2 col-xs-2">
                            <img src="img/logo.png" alt="" height="90" width="90" class="pb-10 pt-15" >
                        </div>

                    </div>
                </div>
            </div>

            <!---mantohead-->
            <!-- <div class="header-nav pb-lg-0" style="border-bottom: 10px solid blue">-->
      <div class="header-nav-wrapper navbar-scrolltofixed pb-lg-0"style="background-color: #1c273d; height:-50px">
          <div class="container"style="background-color: #1c273d; height:-50px;">
              <nav id="menuzord-right" class="menuzord default" style="background-color: #1c273d; height:50px; 
              left: 0px;
              top: 0px;
              z-index: 150;">
                            <a class="menuzord-brand pull-left flip mt-sm-10 mb-sm-20" ></a>
                            <ul class="menuzord-menu "id="myTab" style="margin-top: -10px">
                                <li class=""><a href="index.jsp"   style="color:#ffffff">Home</a>|</li>
                               
                                <li><a href="#aboutus" data-toggle="tab" style="color:#ffffff">About Us</a>|
                                    
                                </li>
                                <li><a href="#programmes" data-toggle="tab " style="color:#ffffff">Programmes</a>|
                                 
                                </li>
                                <li><a href="#OM" data-toggle="tab" style="color:#ffffff">O & M</a>|
                                  
                                </li>
                                <li><a href="#Citize"  data-toggle="tab" style="color:#ffffff" >Citizen corner</a>|
								</li>
                                <li><a href="#Exe" data-toggle="tab" style="color:#ffffff">Execution </a>|</li>
                                <li><a href="#reports"  data-toggle="tab" style="color:#ffffff">Reports</a>|<li>
                             
                                <li><a href="#orgchart"  data-toggle="tab" style="color:#ffffff">Org.Chart</a>|</li>
                                                <li><a href="#contact" data-toggle="tab"  style="color:#ffffff">Contat Us</a>|</li>
                              
                       <li id='loginId'><a href="#login-modal"  style="color:#ffffff" class="role"  data-toggle="modal" data-target="#login-modal">Login</a></li>
                                <!--<li><a href="#"style="color:#fff">Login</a>
                                    <ul class="dropdown list-unstyled list-dashed">
                           <li><a href="#" class="role="button data-toggle="modal" data-target="#login-modal" href="#login-modal">Login</a></li>
                                       
                                    </ul>
                                </li>
								
								 <li id='loginId'><a href="#login-modal" onclick="#" data-toggle="modal" data-target="#login-modal">Login</a></li>-->
            </ul>
          </nav>
        </div>
      </div>
    </div>
     </header>
  </div>
 

        <!-- Start main-content -->
        <div class="main-content">
            <!-- Section: home -->
          <section id="home">
      <div class="container-fluid p-0">
          <div class="owl-carousel-1col" data-nav="true">
          <div class="item">
                  <img src="img/ss1.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/ss2.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/ss3.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/ss4.jpg" alt="" height="450px">
              </div>
             <!--  <div class="item">
                  <img src="img/imm.jpg" alt="" height="450px">
              </div> -->
              <div class="item">
                  <img src="img/s2.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/rwss1.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/rwss2.jpg" alt="" height="450px">
              </div>
              <div class="item">
                  <img src="img/rwss3.jpg" alt="" height="450px">
              </div>
              
            <!--   <div class="item">
                  <img src="img/s1.jpg" alt="" height="450px">
              </div> --> 
          </div>
      </div>
  </section>
            <!-- Section: Welcome -->

        </div>
        <!-- end main-content -->
        <section>
            <div class="container pt-20 pb-20">
                <div class="esc-heading lr-line left-heading">

                </div>
                
                <div class="row">
                    <div class="col-md-3 col-sm-12 mt-50">
                     <div class="vertical-menu">
    
  <a href="img/RWSS _At_A_Glance.pdf"  target="_blank" title="RWS&S At a Glance" class="active">RWS&S at a glance</a>
  <a href="#sst">Success Stories</a>
  <a href="img/Innovative technologies.pdf" target="_blank" title="New Initiatives" class="active">New Initiatives</a>
   <a href="#budget">Budget</a>
  <a href="#functionary">Functionary</a>
   <a a href="#mgallery">Media Gallery</a>

</div>
</div>
                    <div class="col-md-6 col-sm-12">
                            <h3 class="text-uppercase  mb-15">RWSS</h3>
                            <div class="double-line-bottom-theme-colored-2"></div>
                                   <ul id="myTab" class="nav nav-tabs boot-tabs">
                                       
  <li><a href="#gos" data-toggle="tab">GOs</a></li>
  <li><a href="#profile" data-toggle="tab">Notifications</a></li>
  <li><a href="#cir" data-toggle="tab">Circalar's</a></li>
  <li><a href="#ssr" data-toggle="tab">SSR</a></li>
  <li><a href="#guidelines" data-toggle="tab">Guidelines</a></li>
  <!--<li class="dropdown"> <a href="#guidelines" id="myTabDrop2" class="dropdown-toggle" data-toggle="dropdown">Guidelines
  </li>-->
</ul>
<div id="myTabContent" class="tab-content">
  <div class="tab-pane fade in active" id="gos">
    <ul>
      <li href="#"><a href="img/Innovative technologies.pdf" target="_blank" >1.GO MS NO 4 - SWAP Mode</a></li>
      <li href="#">2.GO. Ms. No. 195 - Entrustment procudure for PR and RWS</li>
      <li href="#">3.GO Ms. No. 94 - For Registration of Contractors</li>
      <li href="#">4.Go.RT.No. 569 - O & M of RWS Assets</li>
      <li href="#">5.GO MS NO-2290 - O & M Protocol</li>
      <li href="#">6.GO RT NO 1292 - Modifications to GO NO 2290</li>
      <li href="#">7.G.O.MS.NO.8 - Entrustment and Contract Management of works Execution
</li>
    </ul>
  </div>
  
   <div class="tab-pane fade " id="cir">
    <ul>
      <li href="img/04012013PR_MS4.pdf">O & M Circular
</li>
</li>
    </ul>
  </div>
  
  
  <div class="tab-pane fade" id="profile"> <div data-example-id="contextual-table" class="bs-example">
                        <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <colgroup>
                                        <col class="col-xs-1">
                                            <col class="col-xs-7">
                                    </colgroup>
                                    <thead>
                                        <tr class="info">
                                            <th>Sl No:</th>
                                            <th>Catgegrory</th>
                                            <th>Act</th>
                                            <th>Number</th>
                                            <th>Year</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row"> 1 </th>
                                            <td>General</td>
                                            <td>Right to Information Act(English)</td>
                                            <td>22</td>
                                            <td>2005</td>
                                        </tr>

                                              <th scope="row"> 2 </th>
                                            <td>General</td>
                                            <td>Right to Information Act(English)</td>
                                            <td>22</td>
                                            <td>2005</td>
                                        </tr>
                                         </tr>

                                              <th scope="row"> 3 </th>
                                            <td>General</td>
                                            <td>SC ST Subplan </td>
                                            <td>1</td>
                                            <td>2013</td>
                                        </tr>
                                        
                                        
                                    </tbody>
                                </table>
                            </div>
                </div>
  </div>
  
  
  
  
  
  
  
  <div class="tab-pane fade" id="ssr"> <div data-example-id="contextual-table" class="bs-example">
                        <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <colgroup>
                                        <col class="col-xs-1">
                                            <col class="col-xs-7">
                                    </colgroup>
                                    <thead>
                                        <tr class="info">
                                            <th>Sl No:</th>
                                            <th>Subject</th>
                                            <th>Year</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row"> 1 </th>
                                            <td>Subject of rates</td>
                                            
                                            <td>2016-17</td>
                                        </tr>
                                               <tr>
                                              <th scope="row"> 2 </th>
                                            <td>Standard data</td>
                                            
                                            <td>2016-17</td>
                                        </tr>
                                        
                                        
                                        
                                    </tbody>
                                </table>
                            </div>
                </div>
  </div>
  
  
  
  
  <div class="tab-pane fade" id="guidelines"> <div data-example-id="contextual-table" class="bs-example">
                        <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <colgroup>
                                        <col class="col-xs-1">
                                            <col class="col-xs-7">
                                    </colgroup>
                                    <thead>
                                        <tr class="info">
                                            <th>Sl No:</th>
                                            <th>Catgegrory</th>
                                            <th>Subject</th>
                                            
                                            <th>Year</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row"> 1 </th>
                                            <td>Water</td>
                                            <td>NRDWP Guidelines</td>
                                            
                                            <td>2013</td>
                                        </tr>

                                              <th scope="row"> 2 </th>
                                            <td>Sanitation</td>
                                            <td>SBM Guidelines</td>
                                           
                                            <td>Dec-2014</td>
                                        </tr>
                                        
                                        
                                        
                                    </tbody>
                                </table>
                            </div>
                </div>
  </div>
  
  
  
  
  
  
  
  
  
  
  
  
  
</div> 

                    </div>
                   <div class="col-md-3 col-sm-12">
                        <h3 class=" mt-0 mt-sm-30 mt-20">What's New</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <article>
                            <marquee direction="up" onmouseover="this.stop();" onmouseout="this.start();">
               <a href="img/advt_new.pdf" target="_blank" ><i class="fa fa-angle-double-right"></i>Enquiry Notice 23-11-2018  Sujala Pathakam- Quotations Called for</a><br>
                       <a href="img/advt_new.pdf" target="_blank" >Supply, Delievery abd installation of HSC and VT pump to O&M of SSS CPWS Scheme in West Godavati District</a><br>
                      <a href="img/advt_new.pdf" target="_blank" ><i class="fa fa-angle-double-right"></i>SUJALA- Srikakulam- Request For Proposal No.1</a><br>
                       <a href="#">SUJALA- VISAKHAPATNAM- Request For Proposal No.2</a><br>
                         <a href="#"><i class="fa fa-angle-double-right"></i>SUJALA- East Godavari- Request For Proposal No.3</a><br>
                          <a href="#"><i class="fa fa-angle-double-right"></i>SUJALA- East Godavari- Request For Proposal No.4</a><br>
                          
                    </div>
                    </marquee>
            </div>
        </section>




      

        <!-- Section About -->
     <!--<section id="about">
            <div class="container pt-50 pb-40">
                <div class="section-title">
                    <div class="row">
                        <div class="col-md-4">
                            <h3 class="text-uppercase font-weight-600 mt-0">About <span class="text-theme-colored2">Learnpro</span></h3>
                            <div class="double-line-bottom-theme-colored-2"></div>
                            <p class="font-16 mt-20">Lorem ipsum dolor sit amet, consecte turadipie sicing elit. Quas voluptatem maiores eaques Quasvolu ptatem maiores</p>
                                <li> <i class="fa fa-arrow-right" aria-hidden="true"></i>We achieved most leading universtiy award 2017</li>
                                <li> <i class="fa fa-arrow-right" aria-hidden="true"></i>We always try to provide our best quality education</li>
                                <li> <i class="fa fa-arrow-right" aria-hidden="true"></i>Over 2000+ students has completed graduation</li>
                                <li> <i class="fa fa-arrow-right" aria-hidden="true"></i>Best online course provide university this year</li>
                            <a href="#" class="btn btn-colored btn-theme-colored2 text-white btn-lg pl-40 pr-40 mt-10">Read More</a>
                    </div>
                    <div class="col-md-4">
                        <h3 class="text-uppercase font-weight-600 mt-0 mt-sm-30">Video <span class="text-theme-colored2">Tour</span></h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="box-hover-effect about-video">
                            <div class="effect-wrapper">
                                <div class="thumb">
                                    <img class="img-fullwidth" src="images/about/video-thumb.jpg" alt="project">
                                </div>
                                <div class="video-button"></div>
                                <a class="hover-link" data-lightbox-gallery="youtube-video" href="https://www.youtube.com/watch?v=F3QpgXBtDeo" title="Youtube Video">Youtube Video</a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <h3 class="text-uppercase font-weight-600 mt-0 mt-sm-30">Upcoming <span class="text-theme-colored2">Events</span></h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <article>
                            <marquee direction="up" onmouseover="this.stop(01);" onmouseout="this.start();">
                                <div class="event-small media sm-maxwidth400 mt-0 mb-0 pt-0 pb-15">
                                    <div class="event-date text-center">
                                        <ul class="text-white">
                                            <li class="font-18 font-weight-700 border-bottom">28</li>
                                            <li class="font-14 text-center text-uppercase mt-5">Feb</li>
                                        </ul>
                                    </div>

                                    <div class="event-content pt-5">
                                        <h5 class="media-heading font-16 font-weight-600 mb-5"><a href="#">Admission Fair Spring 2017</a></h5>
                                        <span class="mr-10"><i class="fa fa-clock-o text-theme-colored2"></i> 5.00 pm - 7.30 pm</span>
                                        <span> <i class="fa fa-map-marker text-theme-colored2"></i> 25 Newyork City.</span>
                                    </div>
                                </div>
                        </article>
                        <article>
                            <div class="event-small media sm-maxwidth400 mt-5 mb-0 pt-10 pb-15">
                                <div class="event-date text-center">
                                    <ul class="text-white">
                                        <li class="font-18 font-weight-700 border-bottom">28</li>
                                        <li class="font-14 text-center text-uppercase mt-5">Feb</li>
                                    </ul>
                                </div>
                                <div class="event-content pt-5">
                                    <h5 class="media-heading font-16 font-weight-600 mb-5"><a href="#">Learning Spoken English</a></h5>
                                    <span class="mr-10"><i class="fa fa-clock-o text-theme-colored2"></i> 5.00 pm - 7.30 pm</span>
                                    <span> <i class="fa fa-map-marker text-theme-colored2"></i> 25 Newyork City.</span>
                                </div>
                            </div>
                        </article>
                        <article>
                            <div class="event-small media sm-maxwidth400 mt-5 mb-0 pt-10 pb-15">
                                <div class="event-date text-center">
                                    <ul class="text-white">
                                        <li class="font-18 font-weight-700 border-bottom">28</li>
                                        <li class="font-14 text-center text-uppercase mt-5">Feb</li>
                                    </ul>
                                </div>
                                <div class="event-content pt-5">
                                    <h5 class="media-heading font-16 font-weight-600 mb-5"><a href="#">Workshop Online Marketing</a></h5>
                                    <span class="mr-10"><i class="fa fa-clock-o text-theme-colored2"></i> 5.00 pm - 7.30 pm</span>
                                    <span> <i class="fa fa-map-marker text-theme-colored2"></i> 25 Newyork City.</span>
                                </div>
                            </div>
                        </article>
                    </div>
                    </marquee>
                </div>
            </div>
    </div>
    </section>--->
    
    
    
  <!-- <!--About-->
          <section id="aboutus"style="margin-top: -100px" class="d-none d-print-block">
                <div class="container">
                        <h3 class="text-uppercase mb-5">About Us:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <p>
                      Rural Water Supply Department was formulated during the year 1997 by the Government of Andhra Pradesh creating separate divisions of Rural Water Supply since a number of villages are still to be provided with quality drinking water <p>
                        <p>
                            In exercise of powers conferred by article 309 of the Constitution of India, Government further decided to bifurcate PR & RD Department into Panchayati Raj and Rural Water Supply Departments. Accordingly Panchayat Raj Rural development Engineering service gets bifurcated into Panchayat Raj Engineering service and Rural water Supply Engineering Service during the Year 2007 and deemed to have been created with effect from 1.4.2008 . </p>
                            <p>
                                It functions directly under the Ministry of Rural water Supply with Principal Secretary to Government (RWS) as its administrative head and Engineer-in-Chief as its technical head.  </p>
                                <p>
                                    The Drinking Water Supply is a very important issue as over 80% of health problems are due to consumption of unsafe water and increasing health awareness among the rural public, underlines the additional attention to be paid to the subject. Hence, one of the most important programs of the Government is the provision of safe drinking water to the rural population.</p>
                                    <p>Administrative Setup<p>
                                      <p>
                                          The organization has established the following offices across the State in order to accomplish the organizational objectives.</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">	Head office @ State Level (Engineer-in-Chief/Chief Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true"> Circle office @ District Level(Superintending Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">	Division Office @ Division Level (Executive Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">
                                              Sub-Division Office @ Mandal Level (3 to 4) (Deputy Executive Engineer)</p>
                                                <p class="fa fa-arrow-right" aria-hidden="true">	Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer)</p>p>
                                                  <p class="fa fa-arrow-right" aria-hidden="true">
                                                      RWS&S has head office @ State level headed by Engineer-in-Chief (RWS&S). Chief Engineer is the in-charge of one Program at State level who reports to Engineer-in-Chief</p>
                                                      <p class="fa fa-arrow-right pb-30" aria-hidden="true">Based on the above lines, offices were established at various levels in the organization for execution and maintenance of works and its details are as follows:</p>
                                                      
                         <table width="90%"  border="0" align="center" cellpadding="4" cellspacing="0">
                                                          <tr>
                                                            <td width="10" class="text"><img src="images/arrow.gif" width="9" height="13"></td>
                                                            <td>Head office @ State Level (Engineer-in-Chief/Chief Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Circle office @ District Level(Superintending Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Division Office @ Division Level (Executive Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Sub-Division Office @ Mandal Level (3 to 4) (Deputy Executive Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer)</td>
                                                          </tr>
                                                        </table></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify"><strong>RWS&amp;S </strong> has head office @ State level headed by Engineer-in-Chief (RWS&amp;S). Chief Engineer is the in-charge of one Program at State level who reports to Engineer-in-Chief<br>                            
                                                              <br>
                                                          Based on the above lines, offices were established at various levels in the organization for execution and maintenance of works and its details are as follows:</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                      
                                      <div class="row">
                                          <div class="col-md-12 mt-40">
                              
                                              <div data-example-id="contextual-table" class="bs-example">
                                                      <div class="table-responsive">
                                                              <table class="table table-bordered table-striped">
                                                                  <colgroup>
                                                                      <col class="col-xs-1">
                                                                          <col class="col-xs-7">
                                                                  </colgroup>
                                                                  <thead>
                                                                      <tr class="info">
                                                                          <th>SNO:</th>
                                                                          <th>Head office/Chief Engineer offices @ Sate level</th>
                                                                          <th>-</th>
                                                                          <th>-</th>
                                                                      </tr>
                                                                  </thead>
                                                                  <tbody>
                                                                      <tr>
                                                                          <th scope="row"> 1 </th>
                                                                          <td>	Chief Engineer office @ Sate level.</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row">2</th>
                                                                          <td>	Division Office @ Division Level (Executive Engineer).</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row"> 3</th>
                                                                          <td>	Sub-Division Office @ Mandal Level (3 to 4) </td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row"> 4</th>
                                                                          <td>Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer).</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                     
                                                                  </tbody>
                                                              </table>
                                                          </div>
                                              </div>
                                          </div>
                                      </div>
                                
                              
                                      
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td ><strong>Geological Wing</strong></td>
                                                      </tr>
                                                      
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Executive Director</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td><div align="justify">He is overall in charge of Geological Wing of the Department which mainly covers Ground Water Survey and selection of points / sources for RWS works. </div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Joint Director (Geology)</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">He is overall in charge of Geological Wing of the Department which mainly covers Ground Water Survey and selection of points / sources for RWS works.</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Senior Geologists</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">There are (6) Senior Geologists working at a rate of one for each zone to over see the selection of sources and are attached to circle offices.</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Junior Geologists</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td align="justify">There are (41) Junior Geologists in the department for Ground Water Survey and selection of sources for Water Supply Schemes.</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td> <strong >Water Testing Laboratories</strong></td><br>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">In order to test water samples both chemically and bacteria logically, water testing laboratories (51 Nos) are established in each division office.</div></td>
                                                      </tr>
                                                     <tr>      
                                                  <td width="244" valign="top" ><table width="100%" border="0" cellspacing="0" cellpadding="2">
                                                   
                      </table>
                        
                        
                        
                        
                        
                        </div>
                       
                        </section>
      <!--   <section id="aboutus" style="margin-top: -130px">
            <div class="container">
                <h3 class="text-uppercase  mb-15">About Us:</h3>
                <div class="double-line-bottom-theme-colored-2"></div>
                  <p>
                      Rural Water Supply Department was formulated during the year 1997 by the Government of Andhra Pradesh creating separate divisions of Rural Water Supply since a number of villages are still to be provided with quality drinking water <p>
                        <p>
                            In exercise of powers conferred by article 309 of the Constitution of India, Government further decided to bifurcate PR & RD Department into Panchayati Raj and Rural Water Supply Departments. Accordingly Panchayat Raj Rural development Engineering service gets bifurcated into Panchayat Raj Engineering service and Rural water Supply Engineering Service during the Year 2007 and deemed to have been created with effect from 1.4.2008 . </p>
                            <p>
                                It functions directly under the Ministry of Rural water Supply with Principal Secretary to Government (RWS) as its administrative head and Engineer-in-Chief as its technical head.  </p>
                                <p>
                                    The Drinking Water Supply is a very important issue as over 80% of health problems are due to consumption of unsafe water and increasing health awareness among the rural public, underlines the additional attention to be paid to the subject. Hence, one of the most important programs of the Government is the provision of safe drinking water to the rural population.</p>
                                    <p>Administrative Setup<p>
                                      <p>
                                          The organization has established the following offices across the State in order to accomplish the organizational objectives.</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">	Head office @ State Level (Engineer-in-Chief/Chief Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true"> Circle office @ District Level(Superintending Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">	Division Office @ Division Level (Executive Engineer)</p>
                                          <p class="fa fa-arrow-right" aria-hidden="true">
                                              Sub-Division Office @ Mandal Level (3 to 4) (Deputy Executive Engineer)</p>
                                                <p class="fa fa-arrow-right" aria-hidden="true">	Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer)</p>p>
                                                  <p class="fa fa-arrow-right" aria-hidden="true">
                                                      RWS&S has head office @ State level headed by Engineer-in-Chief (RWS&S). Chief Engineer is the in-charge of one Program at State level who reports to Engineer-in-Chief</p>
                                                      <p class="fa fa-arrow-right pb-30" aria-hidden="true">Based on the above lines, offices were established at various levels in the organization for execution and maintenance of works and its details are as follows:</p>
                                                      <table width="90%"  border="0" align="center" cellpadding="4" cellspacing="0">
                                                          <tr>
                                                            <td width="10" class="text"><img src="images/arrow.gif" width="9" height="13"></td>
                                                            <td>Head office @ State Level (Engineer-in-Chief/Chief Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Circle office @ District Level(Superintending Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Division Office @ Division Level (Executive Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Sub-Division Office @ Mandal Level (3 to 4) (Deputy Executive Engineer)</td>
                                                          </tr>
                                                          <tr>
                                                            <td><span class="text"><img src="images/arrow.gif" width="9" height="13"></span></td>
                                                            <td> Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer)</td>
                                                          </tr>
                                                        </table></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify"><strong>RWS&amp;S </strong> has head office @ State level headed by Engineer-in-Chief (RWS&amp;S). Chief Engineer is the in-charge of one Program at State level who reports to Engineer-in-Chief<br>                            
                                                              <br>
                                                          Based on the above lines, offices were established at various levels in the organization for execution and maintenance of works and its details are as follows:</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                      
                                      <div class="row">
                                          <div class="col-md-12 mt-40">
                              
                                              <div data-example-id="contextual-table" class="bs-example">
                                                      <div class="table-responsive">
                                                              <table class="table table-bordered table-striped">
                                                                  <colgroup>
                                                                      <col class="col-xs-1">
                                                                          <col class="col-xs-7">
                                                                  </colgroup>
                                                                  <thead>
                                                                      <tr class="info">
                                                                          <th>SNO:</th>
                                                                          <th>Head office/Chief Engineer offices @ Sate level</th>
                                                                          <th>-</th>
                                                                          <th>-</th>
                                                                      </tr>
                                                                  </thead>
                                                                  <tbody>
                                                                      <tr>
                                                                          <th scope="row"> 1 </th>
                                                                          <td>	Chief Engineer office @ Sate level.</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row">2</th>
                                                                          <td>	Division Office @ Division Level (Executive Engineer).</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row"> 3</th>
                                                                          <td>	Sub-Division Office @ Mandal Level (3 to 4) </td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                      <tr>
                                                                          <th scope="row"> 4</th>
                                                                          <td>Section Office @ Mandal Level (Assistant Executive Engineer/Asst. Engineer).</td>
                                                                          <td>-</td>
                                                                          <td>-</td>
                                                                      </tr>
                                                                     
                                                                  </tbody>
                                                              </table>
                                                          </div>
                                              </div>
                                          </div>
                                      </div>
                                
                              
                                      
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td ><strong>Geological Wing</strong></td>
                                                      </tr>
                                                      
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Executive Director</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td><div align="justify">He is overall in charge of Geological Wing of the Department which mainly covers Ground Water Survey and selection of points / sources for RWS works. </div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Joint Director (Geology)</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">He is overall in charge of Geological Wing of the Department which mainly covers Ground Water Survey and selection of points / sources for RWS works.</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Senior Geologists</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">There are (6) Senior Geologists working at a rate of one for each zone to over see the selection of sources and are attached to circle offices.</div></td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td><strong >Junior Geologists</strong></td>
                                                      </tr>
                                                      <tr>
                                                        <td align="justify">There are (41) Junior Geologists in the department for Ground Water Survey and selection of sources for Water Supply Schemes.</td>
                                                      </tr>
                                                      <tr>
                                                        <td>&nbsp;</td>
                                                      </tr>
                                                      <tr>
                                                        <td> <strong >Water Testing Laboratories</strong></td><br>
                                                      </tr>
                                                      <tr>
                                                        <td> <div align="justify">In order to test water samples both chemically and bacteria logically, water testing laboratories (51 Nos) are established in each division office.</div></td>
                                                      </tr>
                                                     <tr>      
                                                  <td width="244" valign="top" ><table width="100%" border="0" cellspacing="0" cellpadding="2">
                                                   
                      </table>
                      </div>
        </section>  -->
            <section id="programmes"style="margin-top: -100px">
                <div class="container">
                        <h3 class="text-uppercase mb-5">Programmes:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12 mt-40">
                                <div data-example-id="contextual-table" class="bs-example">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th>SNO:</th>
                                                            <th>Programme Name</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <th scope="row"> 1 </th>
                                                            <td>NRDWP</td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row">2</th>
                                                            <td>NABARD</td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"> 3</th>
                                                            <td>	State Plan</td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"> 4</th>
                                                            <td>Finance Commission</td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"> 5</th>
                                                            <td>	EAP (World Bank)</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
        </section>
		
		
		
		
		
        <section id="OM" style="margin-top: -100px">
                <div class="container">

                        <h3 class="text-uppercase mb-15">O and M: </h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                   
                    
                        <p>Rural Water Supply is being implemented through various types of infrastructure created from time to time, i.e., hand pumps to bore wells, PWS Schemes, CPWS Schemes. As per the 73rd Constitutional amendment, the Government of Andhra Pradesh has
                            devolved the following functions to the Panchayat Raj Institutions(PRIs) in respect of Rural Water Supply Department vide G.O.Rt. No 569 Dt. 22-12-2007, of P.R& R.D (RWS-I) as noted below with the technical assistance of RWS&S Department.</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">	The Operation and Maintenance of Multi village schemes (ie:CPWS Schemes) is to be looked after by the Zilla Parishads</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">The Operation and Maintenance of all the individual PWS Schemes (single village schemes) is to be looked after by the concerned Gram Panchayats</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">The Operation and Maintenance of Hand pumps in a Mandal is to be looked after by the Mandal Parishads</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">
                                The funds required for the Operation and Maintenance of the above Schemes are being directly released to the concerned Zilla Parishads, Gram panchayats and Mandal Parishads by the Commissioner, PR &RE under 13th Finance Commission Grant .</p>
                                <p class="fa fa-arrow-right" aria-hidden="true">
                                    The Operation and Maintenance of Hand pumps in a Mandal is to be looked after by the Mandal Parishads
                                  </p>
                    </div>
        </section>
        <section id="Citize" style="margin-top: -100px">
                <div class="container">

                        <h3 class="text-uppercase mb-15">Citizen Corner:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                    
                    <div class="row">
                            <div class="col-md-12 mt-40">
                            
                
                                <div data-example-id="contextual-table" class="bs-example">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th>SNO:</th>
                                                            <th>Services</th>
                                                            <th>	Duration (Days)</th>
                                                            <th>Responsible Officer</th>
                                                            <th>Remarks</th>
                                                            <th>If not satisfied, the officer to be contacted</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <th>General</th>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"> 1 </th>
                                                            <td>Public Grievances</td>
                                                            <td>7</td>
                                                            <td>Concerned Officer</td>
                                                            <td>DEE/EE/SE/CE</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"> 2 </th>
                                                            <td>Public Grievances</td>
                                                            <td>2</td>
                                                            <td>Concerned Officer</td>
                                                            <td>DEE/EE/SE/CE</td>
                                                            <td></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Technical</th>
                                                        </tr>
                                                        <tr>
                                                            <td>1</td>
                                                        <td>Technical Sanction for Works</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>	a) Normal Program</td>
                                                        <td>15</td>
                                                        <td>DEE/EE/SE/CE</td>
                                                        <td>Survey, Investigation, Estimate Preparation & Technical Sanction</td>
                                                        <td>EE/SE/ENC /Govt.</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>b) Special Projects</td>
                                                        <td>45</td>
                                                        <td>SE/CE</td>
                                                        <td>Survey, Investigation, Estimate Preparation & Technical Sanction.</td>
                                                        <td>CE/ENC/GOVT.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>2</td>
                                                        <td>ender processing, Agreements & Grounding of Works</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>a) Normal Program</td>
                                                        <td>15</td>
                                                        <td>EE/SE</td>
                                                        <td>Tender Notification, Tender Evaluation and Concluding Agreement</td>
                                                        <td>SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>	a) Normal Program	</td>
                                                        <td>15</td>
                                                        <td>SE/CE</td>
                                                        <td>	Tender Notification, Tender Evaluation and Concluding Agreement</td>
                                                        <td>CE/ENC/GOVT.</td>
                                                    </tr>
                                                    <tr>
                                                        <td>3</td>
                                                        <td>Recording the Measurements of Completed Works (Bill Recording)</td>
                                                        <td>2</td>
                                                        <td>AEE/AE</td>
                                                        <td></td>
                                                        <td>DEE/EE/SE</td>
                                                    </tr>
                                                    <tr>
                                                        <td>4</td>
                                                        <td>Check Measurement of Completed Works</td>
                                                        <td>2</td>
                                                        <td>DEE</td>
                                                        <td></td>
                                                        <td>EE/SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td>5</td>
                                                        <td>Super Check Measurement if needed</td>
                                                        <td>2</td>
                                                        <td>EE/SE</td>
                                                        <td></td>
                                                        <td>SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td>6</td>
                                                        <td>Quality Control Check</td>
                                                        <td>3</td>
                                                        <td>DEE/EE/CE</td>
                                                        <td></td>
                                                        <td>CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td>7</td>
                                                        <td>Submission of Bills to the Division Office</td>
                                                        <td>2</td>
                                                        <td>DEE</td>
                                                        <td></td>
                                                        <td>EE/SE</td>
                                                    </tr>
                                                    <tr>
                                                        <td>8</td>
                                                        <td>Scrutiny of Bills at Division Office</td>
                                                        <td>1</td>
                                                        <td>EE</td>
                                                        <td></td>
                                                        <td>SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td>9</td>
                                                        <td>Submission of Bills to the PAO</td>
                                                        <td>1</td>
                                                        <td>EE</td>
                                                        <td></td>
                                                        <td>	SE/CE/ENCC</td>
                                                    </tr>
                                                    <tr>
                                                      <td>10</td>
                                                      <td>	Preparation of Final Bill</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                      <td>	a) Normal Program</td>
                                                      <td>15</td>
                                                      <td>	AEE/DEE/EE/SE/CE</td>
                                                      <td></td>
                                                      <td>	EE/SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                      <td>b) Special Projects</td>
                                                      <td>30</td>
                                                      <td>	AEE/DEE/EE/SE/CE</td>
                                                      <td></td>
                                                      <td>	EE/SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                      <td>11</td>
                                                 
                                                      <td>	Extension of Agreement Time (EOAT)</td>
                                                      <td>7-28</td>
                                                      <td>	AEE/DEE/EE/SE/CE</td>
                                                      <td>	AEE/AE/DEE/EE/SE/CE</td>
                                                      <td>From the date of receipt of proposal</td>
                                                      <td>DEE/EE/SE/CE/ENC /GOVT</td>
                                                    </tr>
                                                    <tr>
                                                      <td>12</td>
                                                      <td>Return of EMD/FSD</td>
                                                      <td>7</td>
                                                      <td>DEE/EE/SE</td>
                                                      <td></td>
                                                      <td>EE/SE/CE/ENC</td>
                                                      <td>	AEE/DEE/EE/SE/CE</td>
                                                     
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                      <td>b) Special Projects</td>
                                                      <td>30</td>
                                                      <td>	AEE/DEE/EE/SE/CE</td>
                                                      <td></td>
                                                      <td>	EE/SE/CE/ENC</td>
                                                    </tr>
                                                    <tr>
                                                        <th>NOTE:</th>
                                                        <th>	In case of any Problems, Inform the concerned District Superintending Engineer or District Collector by person or through E mail.</th>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
        </section>
        <section id="Exe"style="margin-top: -130px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Execution: </h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12">
                <h4 classs="danger">Works Execution Process</h4>
                <h5>The government formulated a procedure for development of any infrastructure facility in the rural areas of Andhra Pradesh. The procedure for execution of any work and the details of which are given below:</h5>
                <ul>
                    <li><i class="fa fa-angle-double-right"></i>Representation/Proposal for works</li>
                    <li>  <i class="fa fa-angle-double-right"></i>  Line Estimation</li>
                    <li><i class="fa fa-angle-double-right"></i>Administrative Sanction</li>
                    <li>  <i class="fa fa-angle-double-right"></i>  Detailed Estimation</li>
                    <li><i class="fa fa-angle-double-right"></i>Technical Sanction</li>
                    <li><i class="fa fa-angle-double-right"></i>Tender Process</li>
                    <li> <i class="fa fa-angle-double-right"></i>   Agreement</li>
                    <li><i class="fa fa-angle-double-right"></i>Work Progress and Quality Assurance<li>
                        <li><i class="fa fa-angle-double-right"></i>Work completion & Commissioning</li>
                <p>The Procedure to be followed for execution of any work in the department is as follows:</p>
                <p><b>Representation/Proposal for works</b></p>
                <p>
                Individuals or Group of people or Department will raise the proposal for development of Infrastructure facilities (works) in rural areas. Based on the request, the department will verify the proposal with the available information in works Register. If the proposed work is useful to the public, then the department will consider the proposal.</p>
                <p>
                The AEE/AE prepares the line estimate with approximate items/measurements for construction of proposed work. The probable work measurement for the items, item specifications and probable rate per unit for the items will be considered while preparing the line estimate. This estimate provides an approximate amount required for execution of proposed work.</p>
                <p><b>Line Estimate
                </b></p>
                <p>
                The AEE/AE prepares the line estimate with approximate items/measurements for construction of proposed work. The probable work measurement for the items, item specifications and probable rate per unit for the items will be considered while preparing the line estimate. This estimate provides an approximate amount required for execution of proposed work.</p>
                <p><b>Administrative Sanction</b></p>
                <p>
                The administrative sanction is the pre-requisite for any proposed work to execute or to take up further processing. The department will submit the feasible proposed works to the Government for according Administrative Sanction. Duly verifying the program guidelines and funds availability under that program the Government will accord the administrative sanction to the proposed works. After obtaining administrative sanction from the Government, Department will prepare the detailed estimate for further processing.</p>
                </ul>
                                <div data-example-id="contextual-table" class="bs-example">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th></th>
                                                            <th>I.Administration Sanction Powers Of Gram Panchayats </th>
                                                           <th></th>
                                                        </tr>
                                                        <tr>
                                                            <th>SNO:</th>
                                                            <th>Description</th>
                                                            <th>Existing (as per G.O.91, Dt:4.3.99)</th>
                                                        </tr>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>Minor GP</td>
                                                            <td>upto 1.00 lakh</td>
                                                        </tr>
                                                        <tr>
                                                            <td>2</td>
                                                            <td>Major GP</td>
                                                            <td>upto 2.00 lakhs</td>
                                                        </tr>
                                                        <tr>
                                                            <td>3</td>
                                                            <td>Divisional Panchayat Officer</td>
                                                            <td>upto 3.00 lakhs</td>
                                                        </tr>
                <tr>
                    <td>4</td>
                    <td>District Collector</td>
                    <td>Above 3.00 lakhs</td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                                                    </thead>
                                                    <tbody>
                                                      
                                                    
                                                    <tr class="info">
                                                            <th></th>
                                                            <th>II.Administration Sanction Powers Of Mandal Parishads </th>
                                                           <th></th>
                                                        </tr>
                                                        <tr>
                                                            <th>SNO:</th>
                                                            <th>Description</th>
                                                            <th>Existing (as per G.O.399, Dt:25.6.87)</th>
                                                        </tr>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>MDO</td>
                                                            <td>upto Rs. 500/-</td>
                                                        </tr>
                                                        <tr>
                                                            <td>2</td>
                                                            <td>Mandal Parishads</td>
                                                            <td>Above Rs.500 to Rs.75,000</td>
                                                        </tr>
                                                        <tr>
                                                            <td>3</td>
                                                            <td>Standing Committee of ZPr</td>
                                                            <td>    Above Rs.75,000 to Rs.1,50,000</td>
                                                        </tr>
                <tr>
                    <td>4</td>
                    <td>Government</td>
                    <td>Above 1.50 lakhs</td>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tr>
                                                    </thead>
                                                    <tbody>
                                                       
                                                    </tbody>
                
                
                
                
                
                                                     <tbody>
                                                      
                                                    
                                                    <tr class="info">
                                                            <th></th>
                                                            <th>III.Administration Sanction Powers Of Zilla Parishads</th>
                                                           <th></th>
                                                        </tr>
                                                        <tr>
                                                            <th>SNO:</th>
                                                            <th>Description</th>
                                                            <th>Existing (as per G.O.399, Dt:25.6.87)</th>
                                                        </tr>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>MDO</td>
                                                            <td>upto Rs. 500/-</td>
                                                        </tr>
                                                        <tr>
                                                            <td>2</td>
                                                            <td>Mandal Parishads</td>
                                                            <td>Above Rs.500 to Rs.75,000</td>
                                                        </tr>
                                                        <tr>
                                                            <td>3</td>
                                                            <td>Standing Committee of ZPr</td>
                                                            <td>    Above Rs.75,000 to Rs.1,50,000</td>
                                                        </tr>
                <tr>
                    <td>4</td>
                    <td>Government</td>
                    <td>Above 1.50 lakhs</td>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                </tr>
                                                    </thead>
                                                    <tbody>
                                                       
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                
                
                
                        <p><b>Tender Process</b></p>
                        <p>
                 
                After obtaining the Administrative sanction, the department officer conducts a feasibility study of the proposed work site and prepares the drawing, identifies the items, draws up the specifications for the items and obtains the rate per unit item of the proposed work. Then the detailed estimate will be prepared with the above parameters. </p>
                <p>
                The detailed estimate will be verified about the technical viability of taking up the work. If the work is technically viable then only the competent authority in the department will accord the technical sanction. Based on the estimate cost of the work, powers have been delegated at various levels in the organization to accord technical sanction to the work and the details of which are given below:
                 
                    </div>
        </section>
		
		
		<section id="budget"style="margin-top: -130px">
		  <div class="container">
        <h3 class="text-uppercase mb-15">Budget:</h3>
        <div class="double-line-bottom-theme-colored-2"></div>
        <div class="row">
            <div class="col-md-12 mt-40">

                <div data-example-id="contextual-table" class="bs-example"style="margin-top: -30px">
                        <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <colgroup>
                                        <col class="col-xs-1">
                                            <col class="col-xs-7">
                                    </colgroup>
                                    <thead>
                                        <tr class="info">
                                            <th></th>
                                          
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
  <th scope="row"><a href="img/RWSS-budget2014-15.pdf" target="_blank" > 
    1.Budget For Financial Year 2014-15 </a></th>
                                            
                                        </tr>
                                        <tr>
                                            <th scope="row"><a href="img/RWSS-budget2015-16.pdf" target="_blank" >
                                                2.Budget For Financial Year 2015-16</a></th>
                                        
                                        </tr>
                                        <tr>
          <th scope="row"><a href="img/RWSS-budget2016-17.pdf" target="_blank" >
            3.Budget For Financial Year 2016-17
          
            
          </a>
                                            
                                        </tr>
                                        <tr>
                                            
                                            <th scope="row"><a href="img/RWSS-budget2017-18.pdf" target="_blank" >
                                              4.Budget For Financial Year 2017-18
                                  
                                            
                                              
                                            </a></th>
                                        </tr>
                                       
                                    </tbody>
                                </table>
                            </div>
                </div>
            </div>
        </div>
    </div>
		</section>
		
		
		
		
		
		
		
		
        <section id="reports"style="margin-top: -130px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Reports:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12 mt-40">
                
                                <div data-example-id="contextual-table" class="bs-example"style="margin-top: -30px">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th></th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                         <td>   <p>
                1.Habitation Information Report  </p>
                <p>
                2.Grievance Status Abstract Report</p>
                <p>3.Know Your Habitation</p>
                <p>4.Habitation Coverage Status</p></td>
                                                        </tr>
                                                    
                                                  
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                    
        </section>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		 <section id="functionary"style="margin-top: -130px">
                <div class="container">

                        <h3 class="text-uppercase mb-15">Functionary: </h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                   
                    
                        <p><b>ROLL OF EACH CATEGORY OF FUNCTIONARY</b>
 
                              <br> Engineer-in-Chief, RWS&S </br></p>
                            <p class="fa fa-arrow-right" aria-hidden="true">	He is the head of the organization and accountable to the Government in all matters relating to RWS&S Department. He is a responsible advisor to State Government on all matters relating to RWS&S Engineering Department.</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">Overall control on both administration and technical matters.</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">Overall incharge of the organization for effective formulation, implementation and monitoring of the programmes and schemes entrusted to the organization with budgetary control.</p>
                            <p class="fa fa-arrow-right" aria-hidden="true">
                                Overall accountability in matters relating to LF Audit, AG Audit and Public Accounts Committee (PAC).</p>
                                <p class="fa fa-arrow-right" aria-hidden="true">
                                   	To recommend to the State Government removal, transfers & Postings of S.Es. & E.Es.
                                  </p>
								   <p class="fa fa-arrow-right" aria-hidden="true">	He is empowered to transfer Dy. E.Es. with in their zones.</p>
								    <p class="fa fa-arrow-right" aria-hidden="true">To see that budget allotments of the year under various schemes and programmes are fully expended.</p>
                    </div>
        </section>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<section id="orgchart"style="margin-top: -130px">
		 <div class="container">
        <h3 class="text-uppercase mb-15">Org.Chart :</h3>
        <div class="double-line-bottom-theme-colored-2"></div>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-12 mt-40">
 
    <img src="img/org.png" alt="" width="650px" height="650px" style="
    margin-top:-50px">
	<!-- <img src="img/org.png" alt="" width="100%" height="100%">-->

                <div data-example-id="contextual-table" class="bs-example">
                        <div class="table-responsive">
                                <table class="table table-bordered table-striped">
                                    <colgroup>
                                        <col class="col-xs-1">
                                            <col class="col-xs-7">
                                    </colgroup>
                                    <thead>
                                        <tr class="info">
                                            <th><h4>AP-Staff Allocation
                                                Post</h4></th>
                                            <th><h4>Sanctioned Strength</h4></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <th scope="row"> Engineer-in-Chief </th>
                                            <td>1</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Engineer-in-Chief</th>
                                            <td>4</td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> Superintending Engineers</th>
                                            <td>14</td>
                                        </tr>
                                        <tr>
                                            <th scope="row">Executive Engineers</th>
                                            <td>35</td>
                                        </tr>
                                        <tr>
                                            <th scope="row"> Executive Engineers</th>
                                            <td>213</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                </div>
            </div>
        </div>
    </div>
		 </section>
		 
		 
		 <section id="mgallery"style="margin-top: -130px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Media Gallery:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12 mt-40">
                
                                <div data-example-id="contextual-table" class="bs-example"style="margin-top: -30px">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th></th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                         <td>   <p>
                1.Sujala Patakam  </p>
                <p>
                2.Solar Photos</p>
                <p>3.National Sanitation Campaign</p>
                <p>4.Community Water Public System Schemes</p></td>
                                                        </tr>
                                                    
                                                  
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                  
        </section>
		 
		  <section id="sst"style="margin-top: -130px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Success Stories:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12 mt-40">
                
                                <div data-example-id="contextual-table" class="bs-example"style="margin-top: -30px">
                                        <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                    <colgroup>
                                                        <col class="col-xs-1">
                                                            <col class="col-xs-7">
                                                    </colgroup>
                                                    <thead>
                                                        <tr class="info">
                                                            <th></th>
                                                           
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                         <td>   <p>
                1.Innovative Technologies  </p>
                <p>
                2.Kuppam-Sujala</p>
                <p>3.Note on SUJALA AND COMMUNITY</p>
                </td>
                                                        </tr>
                                                    
                                                  
                                                    </tbody>
                                                </table>
                                            </div>
                                </div>
                            </div>
                        </div>
                    </div>
                
                  
        </section>
		 
	<!-- 	 <section id="mgallery"style="margin-top: -130px">
		 <div class="container">
        <h3 class="text-uppercase mb-15">Media Gallery:</h3>
        <div class="double-line-bottom-theme-colored-2"></div>
       <div class="row">
            <div class="heading-line-bottom">
                    <h4 class="heading-title">Media Gallery</h4>
                 </div>
     
                 Portfolio Gallery Grid
                 <div class="gallery-isotope default-animation-effect grid-5 gutter-small clearfix" data-lightbox="gallery">
                   Portfolio Item Start
                   <div class="gallery-item">
     <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 1"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
<a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 2"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
 <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 3"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
  <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 4"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
 <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 5"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
 <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 6"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
  <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 2"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
                     <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 3"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
                     <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 4"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                   
                   Portfolio Item Start
                   <div class="gallery-item">
                     <a href="http://placehold.it/400x300" data-lightbox="gallery-item" title="Title Here 5"><img src="http://placehold.it/400x300" alt=""></a>
                   </div>
                   Portfolio Item End
                 </div>
                 End Portfolio Gallery Grid
     
                 <div class="separator separator-rouned">
                   <i class="fa fa-cog"></i>
                 </div>
     
       </div>
    </div>
		 
		 </section> -->
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
        <section id="contact"style="margin-top: -150px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Contact Us :</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                        <div class="row">
                            <div class="col-md-12 mt-40">
                
                                <div data-example-id="contextual-table" class="bs-example">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <colgroup>
                                                <col class="col-xs-1">
                                                    <col class="col-xs-7">
                                            </colgroup>
                                            <thead>
                                                <tr class="info">
                                                    <th>SNO:</th>
                                                    <th>AP Secretariat 
                                                    </th>
                                                    <th>AP Secretariat Sno Name
                                                    </th>
                                                    <th>Office Address
                                                    </th>
                                                    <th>Tel. No</th>
                                                    <th> FAX</th>
                                                    <th> E - Mail ID</th>
                
                                                </tr>
                                               
                                                   <tr>
                                                    <td>1</td>
                                                    <td>    Peddireddy Ramachandra Reddy</td>
                                                    <td>Minister for PR & Rural Water Supply</td>
                                                    <td>5th Block</td>
                                                    <td>0863-2443768</td>
                                                    <td></td>
                                                    <td>peshi-it-pr@ap.gov.in</td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>Gopal Krishna Dwivedi</td>
                                                    <td>Principal Secretary, RWSS</td>
                                                    <td>5th Block</td>
                                                    <td>0863-2445509
                </td>
                <td></td>
                <td>prlsecy_pr@ap.gov.in</td>
                                                </tr>
                                               
                                            </thead>
                                            <tbody>
                                              
                                        </table>
                                    </div>
                                </div>
                
                
                
                                <div data-example-id="contextual-table" class="bs-example">
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped">
                                            <colgroup>
                                                <col class="col-xs-1">
                                                    <col class="col-xs-7">
                                            </colgroup>
                                            <h5>Engineer in Chief & other Officers</h5>
                                            <thead>
                                                <tr class="info">
                                                    <th>SNO:</th>
                                                    <th>Name of the Officer
                                                    </th>
                                                    <th>Designation of the Officer
                                                    </th>
                                                    <th>    Present Email ID
                                                    </th>
                                                    <th>    Mobile Number</th>
                                                    <th> Office Number</th>
                                                    <th> Residence Number</th>
                
                                                </tr>
                                               
                                                   <tr>
                                                    <td>1</td>
                                                    <td>    R.V.Krishna Reddy (FAC)</td>
                                                    <td>    Engineer In Chief</td>
                                                    <td>    eicrwss@ap.gov.in</td>
                                                    <td>    9100120500</td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>-</td>
                                                    <td>    Chief Engineer-I (Admn.,)</td>
                                                    <td>ce_rws1@ap.gov.in</td>
                                                    <td>    9100120504
                </td>
                <td></td>
                <td></td>
                                                </tr>
                                                <tr>
                                                    <td>3</td>
                                                    <td>M.Rajeswara Rao (FAC)</td>
                                                    <td>Chief Engineer-II</td>
                                                    <td>    ce2rwss@gmail.com</td>
                                                    <td>    9100120502</td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                  <tr>
                                                    <td>4</td>
                                                    <td>R.V.Krishna Reddy(FAC)  </td>
                                                    <td>Chief Engineer-III, Project Director, SWSM</td>
                                                    <td>ce_rws3@ap.gov.in</td>
                                                    <td>9100120503</td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                  <tr>
                                                    <td>5</td>
                                                    <td>Sri.R.Kondal Rao</td>
                                                    <td>Technical AdvisorI</td>
                                                    <td>ntpa_rws_bdg@ap.gov.in</td>
                                                    <td> 9848883457</td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                     
                                            </thead>
                                            <tbody>
                                              
                                        </table>
                                    </div>
                                </div>



                                <div data-example-id="contextual-table" class="bs-example">
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-striped">
                                                <colgroup>
                                                    <col class="col-xs-1">
                                                        <col class="col-xs-7">
                                                </colgroup>
                                                <h5>Engineer in Chief & other Officers</h5>
                                                <thead>
                                                    <tr class="info">
                                                        <th>SNO:</th>
                                                        <th>	District
                                                        </th>
                                                        <th>	Circle/Division	
                                                        </th>
                                                        <th>Designation of the Officer
                                                        </th>
                                                        <th>Name of the Officer</th>
                                                        <th> Present Email ID</th>
                                                        <th>	Mobile Number</th>
                    
                                                    </tr>
                                                   
                                                       <tr>
                                                        <td>1</td>
                                                        <td> Srikakulam</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>	T.Srinivasa Rao(I/C)</td>
                                                        <td>se_rws_sklm@ap.gov.in</td>
                                                        <td>	9100120600</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Srikakulam</td>
                                                        <td>Executive Engineer</td>
                                                        <td>P.Ravi(I/C)</td>
                                                        <td>ee_rws_sklm@ap.gov.in</td>
                                                       <td>9100120666</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Palasa</td>
                                                            <td>Executive Engineer</td>
                                                            <td>V.V.Eswara Rao(I/C)</td>
                                                            <td>	ee_rws_pla@ap.gov.in</td>
                                                           <td>	9100120650</td>
                                                        </tr>
                                                        
                                                        
                                                         <tr>
                                                        <td>2</td>
                                                        <td> Vizianagaram</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>Er.N.V.Rama Murthy(I/C)</td>
                                                        <td>se_rws_vznm@ap.gov.in</td>
                                                        <td>9100120700</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Vizianagaram</td>
                                                        <td>Executive Engineer</td>
                                                        <td>G.T. Gayatri Devi</td>
                                                        <td>ee_rws_vznm@ap.gov.in</td>
                                                       <td>9100120712</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Vizianagaram(P)</td>
                                                            <td>Executive Engineer</td>
                                                            <td>G.T. Gayatri Devi(FAC)</td>
                                                            <td>ee_rws_vznmp@ap.gov.in</td>
                                                           <td>9100120772</td>
                                                        </tr>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <tr>
                                                        <td>3</td>
                                                        <td> Visakhapatnam</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>Er.V.Ravi Kumar(I/C)</td>
                                                        <td>se_rws_vspm@ap.gov.in</td>
                                                        <td>9100120800</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Visakhapatnam</td>
                                                        <td>Executive Engineer</td>
                                                        <td>N. Mehar Prasad</td>
                                                        <td>ee_rws_vspm@ap.gov.in</td>
                                                       <td>9100120812</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Paderu(P)</td>
                                                            <td>Executive Engineer</td>
                                                            <td>K.Ram Prasad(I/C)</td>
                                                            <td>ee_rws_pdr@ap.gov.in</td>
                                                           <td>9100120847</td>
                                                        </tr>
                                                        
                                                        
                                                        
                                                        
                                                        <tr>
                                                        <td>4</td>
                                                        <td>East Godavari</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>M.Rajewasra Rao(I/C)</td>
                                                        <td>se_rws_egd@ap.gov.in</td>
                                                        <td>9100121100</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Kakinada</td>
                                                        <td>Executive Engineer</td>
                                                        <td>CH.Apparao(I/C)</td>
                                                        <td>ee_rws_kkd@ap.gov.in</td>
                                                       <td>9100121101</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Rajahmundry</td>
                                                            <td>Executive Engineer</td>
                                                            <td>N.Lakshmipati Rao</td>
                                                            <td>ee_rws_rjm@ap.gov.in</td>
                                                           <td>	9100121102</td>
                                                        </tr>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <tr>
                                                        <td>5</td>
                                                        <td> West Godavari</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>Ch.Amareswara Rao(I/C)</td>
                                                        <td>se_rws_wgd@ap.gov.in</td>
                                                        <td>9100121200</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Eluru(P)</td>
                                                        <td>Executive Engineer</td>
                                                        <td>J.V.Raghavalu</td>
                                                        <td>ee_rws_elur@ap.gov.in</td>
                                                       <td>9100121211</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Kovvuru</td>
                                                            <td>Executive Engineer</td>
                                                            <td>G.Srinivasa Prasad(I/C)</td>
                                                            <td>ee_rws_kvr@ap.gov.in</td>
                                                           <td>	9100121217</td>
                                                        </tr>
                                                        
                                                        
                                                        
                                                        
                                                        
                                                       <tr>
                                                        <td>6</td>
                                                        <td>Krishna</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>D.Sainadh(FAC)</td>
                                                        <td>se_rws_krsn@ap.gov.in</td>
                                                        <td>	9100120600</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Vijayawada</td>
                                                        <td>Executive Engineer</td>
                                                        <td>D.Sainadha(FAC)</td>
                                                        <td>ee_rws_vja@ap.gov.in</td>
                                                       <td>9100121346</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Gudiwada</td>
                                                            <td>Executive Engineer</td>
                                                            <td>V.Tulsi Ramgopal</td>
                                                            <td>ee_rws_gdv@ap.gov.in</td>
                                                           <td>	9100121315</td>
                                                        </tr> 
                                                        
                                                        
                                                        
                                                        
                                                        
                                                        <tr>
                                                        <td>7</td>
                                                        <td> Guntur</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>N.V.V.Satyanarayana(FAC)</td>
                                                        <td>se_rws_gntr@ap.gov.in</td>
                                                        <td>9100121400</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Guntur</td>
                                                        <td>Executive Engineer</td>
                                                        <td>K.Venkateswara Rao (I/C)</td>
                                                        <td>ee_rws_gntr@ap.gov.in</td>
                                                       <td>9100121401</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Narasaraopet</td>
                                                            <td>Executive Engineer</td>
                                                            <td>R.S.R.Suresh (I/C)</td>
                                                            <td>ee_rws_nrpt@ap.gov.in</td>
                                                           <td>	9100121402</td>
                                                        </tr>
                                                        
                                                        <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Tenali(P)</td>
                                                        <td>Executive Engineer</td>
                                                        <td>N.V.V.Satyanarayana</td>
                                                        <td>ee_rws_tnl@ap.gov.in</td>
                                                       <td>9100121403</td>
                                                    </tr>
                                                        
                                                        
                                                     
                                                     
                                                     
                                                     <tr>
                                                        <td>8</td>
                                                        <td> Prakasam</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>P.Sanjeeva Reddy(I/C)</td>
                                                        <td>se_rws_pkm@ap.gov.in</td>
                                                        <td>9100121600</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Ongole</td>
                                                        <td>Executive Engineer</td>
                                                        <td>Shaik Mardhan Ali(I/C)</td>
                                                        <td>ee_rws_pkm@ap.gov.in</td>
                                                       <td>9100121610</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Podili(P)</td>
                                                            <td>Executive Engineer</td>
                                                            <td>B. Mallikarjuna Rao(I/C)</td>
                                                            <td>ee_rws_pdl@ap.gov.in</td>
                                                           <td>	9100121651</td>
                                                        </tr>
                                                     
                                                     
                                                     
                                                     
                                                     <tr>
                                                        <td>9</td>
                                                        <td> Nellore</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>R.V.Krishna Reddy(I/C)</td>
                                                        <td>se_rws_nlr@ap.gov.in</td>
                                                        <td>	9100121700</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Nellore</td>
                                                        <td>Executive Engineer</td>
                                                        <td>	M.Srinivasa Kumar(I/C)</td>
                                                        <td>ee_rws_nlr@ap.gov.in</td>
                                                       <td>9100121746</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Gudur</td>
                                                            <td>Executive Engineer</td>
                                                            <td>K.V.Naga Jyothi</td>
                                                            <td>ee_rws_gdr@ap.gov.in</td>
                                                           <td>	9100121707</td>
                                                        </tr>
                                                        
                                                        
                                                        
                                                        
                                                        <tr>
                                                        <td>10</td>
                                                        <td> Chittoor</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>	G.Venu(I/C)</td>
                                                        <td>se_rws_cttr@ap.gov.in</td>
                                                        <td>	9100121800</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Chittoor</td>
                                                        <td>Executive Engineer</td>
                                                        <td>P.Siddaiah(I/C)</td>
                                                        <td>	ee_rws_cttr@ap.gov.in</td>
                                                       <td>9100121808</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Tirupathi</td>
                                                            <td>Executive Engineer</td>
                                                            <td>K. Vijaya Kumar</td>
                                                            <td>	ee_rws_tpti@ap.gov.in</td>
                                                           <td>	9100121845</td>
                                                        </tr>
                                                     
                                                        
                                                        
                                                        
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Madanapalli</td>
                                                        <td>Executive Engineer</td>
                                                        <td>A.Omkaram(I/C)</td>
                                                        <td>	ee_rws_mdp@ap.gov.in</td>
                                                       <td>9100121882</td>
                                                    </tr>
                                                    
                                                    
                                                    
                                                    
                                                    <tr>
                                                        <td>11</td>
                                                        <td> Kadapa</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>P.Sanjeeva Rao(I/C)</td>
                                                        <td>se_rws_kdp@ap.gov.in</td>
                                                        <td>	9100122300</td>
                                                    </tr>
                                               
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Kadapa</td>
                                                        <td>Executive Engineer</td>
                                                        <td>N. Parvata Reddy(I/C)</td>
                                                        <td>ee_rws_kdp@ap.gov.in</td>
                                                       <td>9100122307</td>
                                                    </tr>

                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Rajampet</td>
                                                            <td>Executive Engineer</td>
                                                            <td>T.Malikarjuna Prasad</td>
                                                            <td>ee_rws_rjp@ap.gov.in</td>
                                                           <td>	9100122348</td>
                                                        </tr>
                                                    
                                                    
                                                    
                                                     <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Pulivendula(P)</td>
                                                            <td>Executive Engineer</td>
                                                            <td>M.C.Veeranna(I/C)</td>
                                                            <td>ee_rws_pvd@ap.gov.in</td>
                                                           <td>	9100122369</td>
                                                        </tr>
                                                    
                                                        
                                                      
                                                       <tr>
                                                        <td>12</td>
                                                        <td> Anathapur</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>B.Hari Ram Naik(I/C)</td>
                                                        <td>	se_rws_antp@ap.gov.in</td>
                                                        <td>	9014212899</td>
                                                    </tr>
                                               
                                               
                                               				
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Anathapur(N)</td>
                                                        <td>Executive Engineer</td>
                                                        <td>Eshan Basha (I/C)</td>
                                                        <td>ee_rws_antp@ap.gov.in</td>
                                                       <td>7569300273</td>
                                                    </tr>


			
                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Kalyanadurg</td>
                                                            <td>Executive Engineer</td>
                                                            <td>M.Sambasiva Rao</td>
                                                            <td>ee_rws_kldgm@ap.gov.in</td>
                                                           <td>	7569300355</td>
                                                        </tr>
                                                    
                                                    
                                                    
                                                    				
                                                    
                                                     <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Penukonda</td>
                                                            <td>Executive Engineer</td>
                                                            <td>M.S.Srinivasa Rao(I/C)</td>
                                                            <td>ee_rws_pnk@ap.gov.in</td>
                                                           <td>	7569300318</td>
                                                        </tr>
                                                      
                                                      
                                                      
                                                      
                                                   			   
                                                      <tr>
                                                        <td>13</td>
                                                        <td> Kurnool</td>
                                                        <td>Circle</td>
                                                        <td>Superintending Engineer</td>
                                                        <td>J.Haribabu(I/C)</td>
                                                        <td>	se_rws_krnl@ap.gov.in</td>
                                                        <td>	9100122400</td>
                                                    </tr>
                                               
                                               			
                                               				
                                                          <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td>Kurnool(P)</td>
                                                        <td>Executive Engineer</td>
                                                        <td>D.Venkata Ramana</td>
                                                        <td>ee_rws_krnl@ap.gov.in</td>
                                                       <td>9100122409</td>
                                                    </tr>


					
                                                    <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Nandyal(P)</td>
                                                            <td>Executive Engineer</td>
                                                            <td>S.Veera Bhadra Rao(I/C)	</td>
                                                            <td>ee_rws_ndl@ap.gov.in</td>
                                                           <td>	9100122459</td>
                                                        </tr>
                                                    
                                                    
                                                    
                                                    				
                                                    
                                                     <tr>
                                                            <td></td>
                                                            <td></td>
                                                            <td>Adoni</td>
                                                            <td>Executive Engineer</td>
                                                            <td>A.S.A.Rama Swamy(I/C)</td>
                                                            <td>ee_rws_adni@ap.gov.in</td>
                                                           <td>	9100122497</td>
                                                        </tr>
                                                      
                                                      
                                                     					
                                                      
                                                      
                                     
                                                     <tr>
                                                        <td>14</td>
                                                        <td>  ENC Office</td>
                                                        <td>O/O ENC</td>
                                                        <td>Superintending Engineer-Admin</td>
                                                        <td>V.Alla Baksh</td>
                                                        <td>	</td>
                                                        <td>	9100120555</td>
                                                    </tr>               
                                                        
                                                      
                                                     
                                                      
                                                      
                                                      
                                                      
                                                      
                                                      
                                                        
                                                </thead>
                                                <tbody>
                                                  
                                            </table>
                                        </div>
                                    </div>
                            </div>
                        </div>
                    </div>
        </section>
    <!--end tab manu-->
    
             <!--About end-->
      
        <!--start Funfacts Section-->
        
  <!--       <div style="background-color:#b7dbed" > <h6 align="center" style="font-size: 25px;font-family: 'Noto Sans KR'; padding:10px;
 font-weight:100; margin-top: -20px; margin-bottom: -20px;"  > <strong> Quick Links</strong></h6>
				
				<div align="center">
				
<table style="margin-top: 0px;padding-bottom: 0px">
 <tr>
 <td>
 <img style="margin: 5px;" width="150px" height="50px"  src="images/ddwswater1.jpg" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/india_gov_in.png" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/nnic.jpg" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/smart.png" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/web.jpg" alt="logo">
 </td>
 </tr>
</table> 
</div>
</div> -->



<section id="quicklinks"style="margin-top: -130px">
                <div class="container">
                        <h3 class="text-uppercase mb-15">Quick Links:</h3>
                        <div class="double-line-bottom-theme-colored-2"></div>
                                <div class="table-responsive">
                                                <table class="table table-bordered table-striped">
                                                  <tr>
 <td>
 <img style="margin: 5px;" width="150px" height="50px"  src="images/ddwswater1.jpg" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/india_gov_in.png" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/nnic.jpg" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/smart.png" alt="logo">
 <img style="margin: 5px;" width="150px" height="50px" src="images/web.jpg" alt="logo">
 </td>
 </tr>
                                                </table>
                                            </div>
                           
                    </div>
                
                    
        </section>

















        
        <!-- <section class="parallax layer-overlay overlay-theme-colored-9" data-bg-img="img/imm.png" data-parallax-ratio="0.4"style="margin-top: -50px">
            <div class="container pt-10 pb-10">
                <div class="section-content">
                    <div class="row">
                            <div class="container">
                                    <div class="row">
                                        <section class="section_0">
                                      <div class="col-sm-3">
                                        <div class="circle circle1">
     <a href="https://www.smart.ap.gov.in/"><h2><small><img src="img/smartvillege3.png" style="margin-top: -20px"></small></h2></a>
                                        </div>
                                      </div>
                                      <div class="col-sm-3">
                                        <div class="circle circle2">
                                          <a href="https://webmail.ap.gov.in/"><h2><small><img src="img/gov3.png"style="margin-top: -20px"></small><p></p></h2></a>
                                        </div>
                                      </div>
                                      <div class="col-sm-3">
                                        <div class="circle circle3">
                                          <a href="https://www.india.gov.in/"><h2><small><img src="img/webmail3.png"style="margin-top: -20px"></small><p></p></h2></a>
                                        </div>
                                      </div>
                                      <div class="col-sm-3">
                                        <div class="circle">
                                          <a href="https://mail.nic.in/mail/mauth"><h2><small><img src="img/nic3.png"style="margin-top: -20px" ></small><p></p></h2></a>
                                        </div>
                                      </div>
                                    </section>
                                    </div>
                                </div>
                    </div>
                </div>
            </div>
        </section> -->
      


    <!-- Footer -->
    <footer id="footer" class="footer" data-bg-color="#212331" style="background: #212331">
      
        <div class="footer-bottom" data-bg-color="#28d">
            <div class="container pt-0 pb-0">
                <div class="row">
                    <div class="col-md-12">
                        <p class="font-16 text-white m-0 sm-text-center">Content Owned by Rural Water Supply & Sanitation Department, Govt of A.P.
Designed, Developed and Technically Maintained by National Informatics Centre.</p>
                    </div>
                    
                </div>
            </div>
        </div>







<!-- BEGIN # BOOTSNIP INFO -->

<!-- END # BOOTSNIP INFO -->

<!-- BEGIN # MODAL LOGIN -->

      
      
      
      <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
      <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header" align="center">
         <!--  <img class="img-circle" id="img_logo"    src="img/logo.png" alt="" height="90" width="90" class="pb-10 pt-15" >  -->
         <!-- <h3 align="center">login</h3>-->
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
          </button>
        </div>
                
                <!-- Begin # DIV Form -->
                <div id="div-forms">
                
                    <!-- Begin # Login Form -->
                    
                    
                    <!--  
                    <form id="login-form"   >
                    <div class="modal-body">
                <div id="div-login-msg">
                                
                <input id="login_username" class="form-control" type="text" placeholder="Username** " required>
                <input id="login_password" class="form-control" type="password" placeholder="Password##" required>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
                  </div>
                <div class="modal-footer">
                            <div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Login</button>
                            </div>
                  <div>
                              
                </div>
                    </form>
                    
                    
                    -->
                    
                    <table align="center" width="100%">
<td>
<center>
<table align="center">
<tdata>
	<td align="center" >
																<form method="post" action="Login.do"
																	onSubmit="return submitFn()" focus="userId">

																	<table>
																		<tbody>
																			<tr>
																				<!-- <td width="100%" height="18" bgcolor="#4A8AC7"
																					align="left"><b><font face="Verdana"
																						color="#ffffff" size="1">&nbsp;</font></b><font
																					face="Verdana" color="White" size="2"><b>Authorized
																							RWSS Users</b></font></td>-->
																			</tr>
																			<tr>
																				<td width="100%" height="19">
																			<div
							align="center">
																						<center>
																							<table id="AutoNumber14"
																								style="BORDER-COLLAPSE: collapse"
																								bordercolor="#111111" height="69"
																								cellspacing="0" cellpadding="0" width="96%"
																								border="0">
																								<tbody>
																									<tr>
																									
																									
										<td style="font-family: sans-serif; font-size: small;">&nbsp; User Id</font></td>
										<td ><p
												align="center">
												&nbsp;&nbsp;&nbsp;<input style="height: 25px" type="text" name="userId"
													class="form-control"  autocomplete=off
													onFocus="return hideDefaultText(this, 'Enter User ID')"
													onBlur="return showDefaultText(this, 'Enter User ID')"
													value="Enter User ID" />
											</p></td>
									</tr>
									
									
									<tr>
										<td style="font-family: sans-serif; font-size: small;">&nbsp;Password&nbsp;&nbsp;&nbsp;&nbsp; 
											</td>
										<td ><p
												align="center">
												&nbsp;&nbsp;&nbsp;
												 <input
													type="hidden" name="password" autocomplete=off /> 
													<input style="height: 25px"
													type="password" name="password1" autocomplete=off
													style="height: 25px" class="form-control"
													onFocus="return hideDefaultText(this, 'Password')"
													onBlur="return encryptPassword();"
													 value="Password" />
											</p></td>
									</tr>
									
									
									
									
<!-- <tr><td colspan="2"  style="text-align: right !important;"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="switch.do?prefix=/admin&page=/forgotPassword.do&mode=forgot" class="style10" style="cursor:hand">Forgot password? </a></td></tr> -->
																									  <tr ><td width="100%" bgcolor="#ffffff" colspan="2" height="10" >Security Code

	                   <%@include file="./Captcha/form.jsp"%>
	                              </td></tr> 


											<tr style="height: 5px" >
												<td width="100%" bgcolor="#ffffff" colspan="2" 
													><p align="center">
														<input name="submit2" type="submit" class="btn btn-primary"
															value="Login" /> 
															<input name="reset2" class="btn btn-primary"
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
      
      
      
      
      
                    
                    
                    
                    
                    <!-- End # Login Form -->
                    
                    
                    
                    
                    
                    
                 
                    
                </div>
                <!-- End # DIV Form -->
                
      </div>
      
      
      
      
      
      
      
    </div>
  </div>
    <!-- END # MODAL LOGIN -->

    </footer>
    <a class="scrollToTop" href="#"><i class="fa fa-angle-up"></i></a>
    </div>
    <!-- end wrapper -->

    <!-- Footer Scripts -->
    <!-- JS | Custom script for all pages -->
    <script src="js/custom.js"></script>

</body>

</html>