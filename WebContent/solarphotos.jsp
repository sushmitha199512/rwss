<html>
<head>
	<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
	<meta http-equiv='X-UA-Compatible' content='IE=edge,chrome=1' />
	
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="keywords" content="RURAL WATER SUPPLY, TELANGANA"  />
<meta name="keywords" content="RURAL WATER SUPPLY, TELANGANA"  />
<link rel="stylesheet" type="text/css" href="resources/style/rws-styles.css"  />	
<link rel="stylesheet" type="text/css" href="resources/style/dropdown.css"  />
<link rel="stylesheet" type="text/css" href="resources/style/static_style.css"  />
<link rel='stylesheet' type='text/css' href="resources/style/styles.css" />


    <link rel="stylesheet" href="/pred/resources/style/common_new.css">

<LINK rel=stylesheet type=text/css href="imagess/style.css">


	<link rel="stylesheet" href="resources/style/demos.css">
	<link rel="stylesheet" href="resources/style/example.css" type="text/css">


	<link href="" rel="stylesheet" id="theme_css"> 


<link rel="stylesheet" type="text/css" href="resources/style/dropdown.css"/>








<title> W A T E R S O F T - Official Website of RWSS</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<style type="text/css">
<!--
body,td,th {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	color: #333333;
}
.style3 {color: #99CC66}




-->
</style>
</head>
<link rel="stylesheet" href="./aprwss/resources/style/jquery.ui.all.css">
<script language="JavaScript" src="./aprwss/resources/javascript/jquery-1.4.2.js"></script>


	<script language="JavaScript" src="./aprwss/imagess/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="./aprwss/imagess/jquery.jqDock.min.js"></script>
<link href="./aprwss/resources/style/dockstyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="./aprwss/resources/javascript/jscharts.js"></script>
<link rel="stylesheet" href="./aprwss/resources/style/example.css" type="text/css">
<script type="text/javascript" src="./aprwss/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="./aprwss/resources/style/jquery.ui.all.css">
	<script src="./aprwss/resources/javascript/jquery-3.6.0.js"></script>
	<script src="./aprwss/resources/javascript/jquery.ui.core.js"></script>
	<script src="./aprwss/resources/javascript/jquery.ui.widget.js"></script>
	<script src="./aprwss/resources/javascript/jquery.ui.tabs.js"></script>
	<link rel="stylesheet" href="./aprwss/resources/style/demos.css">
	<link rel="stylesheet" href="./aprwss/resources/style/example.css" type="text/css">


<script src="./aprwss/resources/javascript/jquery.ui.mouse.js"></script>
	<script src="./aprwss/resources/javascript/jquery.ui.resizable.js"></script>
	<script src="./aprwss/resources/javascript/jquery.ui.accordion.js"></script>

 <!-- <script src="./sujala/jquery-1.10.2.min.js" type="text/javascript"></script> --><!-- Commented on 22-04-2022 for Security Audit-->
 <script src="./sujala/jquery-3.6.0.min.js" type="text/javascript"></script>
    <script src="./sujala/jquery.flexslider.js" type="text/javascript"></script>
    <script src="./sujala/jquery.masonry.min.js" type="text/javascript"></script>
    <script src="./sujala/common_new.js" type="text/javascript"></script>

            <script type="text/javascript">
                dw_Event.add(window, 'load', dw_fontSizerDX.init);
            </script>
            
			<script type="text/javascript">
                $(window).load(function(){
                  $('.flexslider').flexslider({
                    animation: "slide",
                    start: function(slider){
                      $('body').removeClass('loading');
                    }
                  });
                });
            </script>
            
			<script type="text/javascript">
                 $(function(){
               
                   var $container = $('#newsCont1');
                 
                   $container.imagesLoaded( function(){
                     $container.masonry({
                       itemSelector : '.news-data'
                     });
                   });
                 
                 });
            </script>
<script>


	
	$(function() {
		$("#accordion").accordion({
			event: "click hoverintent"
		});
	});

	$(function() {
		$("#accordion1").accordion({
			event: "click hoverintent"
		});
	});



	$(function() {
		$("#accordion2").accordion({
			event: "click hoverintent"
		});
	});
	
	$(function() {
		$("#accordion3").accordion({
			event: "click hoverintent"
		});
	});
	$(function() {
		$("#accordion4").accordion({
			event: "click hoverintent"
		});
	});


	$(function() {
		$("#accordion5").accordion({
			event: "click hoverintent"
		});
	});

	$(function() {
		$("#accordion15").accordion({
			event: "click hoverintent"
		});
	});
	
	$(function() {
		$("#accordion6").accordion({
			event: "click hoverintent"
		});
	});
	
	var cfg = ($.hoverintent = {
		sensitivity: 7,
		interval: 100
	});

	$.event.special.hoverintent = {
		setup: function() {
			$( this ).bind( "mouseover", jQuery.event.special.hoverintent.handler );
		},
		teardown: function() {
			$( this ).unbind( "mouseover", jQuery.event.special.hoverintent.handler );
		},
		handler: function( event ) {
			var self = this,
				args = arguments,
				target = $( event.target ),
				cX, cY, pX, pY;
			
			function track( event ) {
				cX = event.pageX;
				cY = event.pageY;
			};
			pX = event.pageX;
			pY = event.pageY;
			function clear() {
				target
					.unbind( "mousemove", track )
					.unbind( "mouseout", arguments.callee );
				clearTimeout( timeout );
			}
			function handler() {
				if ( ( Math.abs( pX - cX ) + Math.abs( pY - cY ) ) < cfg.sensitivity ) {
					clear();
					event.type = "hoverintent";
					// prevent accessing the original event since the new event
					// is fired asynchronously and the old event is no longer
					// usable (#6028)
					event.originalEvent = {};
					jQuery.event.handle.apply( self, args );
				} else {
					pX = cX;
					pY = cY;
					timeout = setTimeout( handler, cfg.interval );
				}
			}
			var timeout = setTimeout( handler, cfg.interval );
			target.mousemove( track ).mouseout( clear );
			return true;
		}
	};
	</script>	
<script>
	$(function() {
		$( "#tabs" ).tabs({
    
			event: "mouseover"
		});

	});
	</script>	













	


<script type=text/javascript>

function hideDefaultText(element, defaultVal)
{
	if(element.value == defaultVal){
		element.value =	'';
	}
}

function showDefaultText(element, defaultVal)
{
	if(element.value == ''){
		element.value =	defaultVal;
	}
}

function IsEmpty(aTextField) {

	var regexp = /^(\s)*$/

	if(regexp.test(aTextField.value)){
		return true;

	}else{
		return false;
	}

}
function submitFn()
{
	document.forms[0].password.value=document.forms[0].password1.value;
	if(document.forms[0].userId.value=="" || document.forms[0].userId.value=="Enter User ID")
	{
		alert("UserId is required");
		return false;
	}
	else if(document.forms[0].password1.value=="" || document.forms[0].password1.value=="Password")
	{
		alert("Password is required");
		return false;
	}
	else if(document.forms[0].userId.value!="" && document.forms[0].password1.value!="")
	{
		document.forms[0].password1.value="";
		return true;
	}
		
	return false;
}

</script>

<body >
<center>
<table width="952" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="10" valign="top" width="1" height="1"></td>
    <td bgcolor="white"><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><table width="96%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <!--<td valign="top"><img src="images/logo-1.jpg" width="950" height="129"></td>-->
			<td valign="top"><img src="images/logo.jpg" width="1100" height="134"></td>
			
			
			
			
		  
		<!--  <td>Welcome Rwss</td>-->
		 
          <tr >
            <td valign="top"><TABLE WIDTH=1100 BORDER=0 CELLPADDING=0 CELLSPACING=0 height="6">
            
			  
			  
              
			  <!-- 
			   
			    <tr>
                    <td><span class="style4">SEARCH</span></td>
                    <td>:</td>
		              <td><input type="text" name=q class="input-box"></td>
                    <td>&nbsp;</td>
					<td><input type=image  name=btnG value='Search'  src="images/go.gif" width="21" height="17" border="0">
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                  </tr>
                </table></TD>-->
				
				<tr><Td>
				<div id='cssmenu'>
<ul>
   <li><a href='./rws_login_frm.jsp'><span>Home</span></a></li>
   <li class='has-sub'><a href='./aboutap.html'><span>About Us</span></a>
    
      <span class="style3"></span></li>
    <li class='has-sub'><a href='./programmeap.html'><span>Programmes</span></a>
   <li class='has-sub'><a href='./OandMap.html'><span>O & M</span></a>
     
   </li>
   <li class='last'><a href='./contactusap.html'><span>Contact Us</span></a></li>
</ul>
</div>




</Td>
</tr>

        </table></td>
      </tr>
      <tr>
        <td valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="215" valign="top" bgcolor="white">
			<table width="215" border="0" cellspacing="0" cellpadding="0" >
              
              <tr>
                <td><TABLE WIDTH=215 BORDER=0 CELLPADDING=0 CELLSPACING=0  >
                   
		<tr><td>
		<div id="menu6">
  <ul>
    <li><a href="citizencornerap.html" title="Citizen Services"> Citizen Corner</a></li>
</ul></div>
	</td></tr>	
				
			
<TR>
                    <TD>
<div id="menu5">
  <ul>
  	
	
	
	<!-- <li><a href="./downloads/RWS.pdf" target="_blank" title="RWS&S At a Glance"> RWS&S At a Glance</a></li>
	<li><a href="budgetap.html" title="AP Budget">Budget</a></li>
	<li><a href="orgchrtap.html" title="Org Chart">  Org. Chart</a></li>
    <li><a href="IECHRDap.html" title="IEC & HRD Callender">IEC & HRD Calender</a></li>
    <li><a href="./downloads/Success_Stories.pdf" target="_blank" title="Success Stories"> Success Stories</a></li>
    <li><a href="./downloads/initiatives.pdf"  target="_blank" title="New Intiatives">New Initiatives</a></li>
    <li><a href="Functionaryap.html" title="Functionary">Functionary</a></li>
    <li><a href="Executionap.html" title="Execution">Execution</a></li>
	<li><a href="Reportsblueap.html" title="Reports">Reports</a></li> -->
	
	
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
 <!--    <li><a href="mediagalleryap.html" title="MediaGallery"> Media Gallery</a></li> -->
	
	
	
	
	
	
  </ul>
</div>

					</TD>
                  </TR>
				  
				 
				  

                </TABLE></td>
              </tr>
                       
             
              
            </table>
			
		<a href="http://www.smart.ap.gov.in/" target="_blank">
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
                    <td valign="top" background="images/bg-logo.jpg"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
                                         
                      
                          
                          <tr>
                <td align="center" valign="top"><table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <!-- InstanceBeginEditable name="EditRegion1" -->
                      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                <td align="center" valign="top"><table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                   
                      <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        
                        <tr>
                        
                         




<tr>
                          <td><section class="wrapper banner-wrapper">
        <div class="banner-container">
          <div class="right-ops"></div>
            <div class="flexslider">
                
            <div class="flex-viewport" style="overflow: hidden; position: relative;">
            <ul class="slides" style="width: 500%; -webkit-transition: 0.6s; transition: 0.6s; -webkit-transform: translate3d(-6745px, 0, 0);">
            <!-- <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg1.jpg" alt="" draggable="false">
                  </a></li>
                  
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg6.jpg" alt="" draggable="false">
                  </a></li>
                  
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg2.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg3.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg4.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg5.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg7.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/mg8.JPG" alt="" draggable="false">
                  </a></li>
                    
                  N.T.R SUJALA STARTS
                  
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/NTR SUJALAS.JPG" alt="" draggable="false">
                  </a></li>
            
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/1.jpg" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Antp.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Egd-1.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Egd-2.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Egd-3.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Egd-4.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Gntr-2.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Gntr.JPG" alt="" draggable="false">
                  </a></li>
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Krsn.jpg" alt="" draggable="false">
                  </a></li>
                
                
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Nlr.jpg" alt="" draggable="false">
                  </a></li>
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Pkm.JPG" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Vskp-2.JPG" alt="" draggable="false">
                  </a></li>
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Vskp1.JPG" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/NTRSujala/Vznm.JPG" alt="" draggable="false">
                  </a></li>
                  
                  
                  CPWS SCHMES STARTS
                  
                  
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/CPWSSCHEMES.JPG" alt="" draggable="false">
                  </a></li>
            
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/1.JPG" alt="" draggable="false">
                  </a></li>
                     <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/2.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/3.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/4.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/5.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/6.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/7.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/8.png" alt="" draggable="false">
                  </a></li>
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/9.png" alt="" draggable="false">
                  </a></li>
                
                
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/10.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/11.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/12.png" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/CPWSSchemes/13.png" alt="" draggable="false">
                  </a></li>
                   SBM TARTS
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/NSC.JPG" alt="" draggable="false">
                  </a></li>
                
                
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/Nlr - SBM.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/Nlr SBM-2.JPG" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/Pkm-SBM.JPG" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/Sklm - SBM.jpg" alt="" draggable="false">
                  </a></li>
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SBM/Vznm-SBM.JPG" alt="" draggable="false">
                  </a></li> -->
                  
                  <!-- Solar STARTS -->
                   <!-- <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/SOLAR PHOTOS.png" alt="" draggable="false">
                  </a></li> -->
                
                
                 <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/1.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/2.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/3.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/DSC_0100.jpg" alt="" draggable="false">
                  </a></li>
                  <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/DSC_0106.jpg" alt="" draggable="false">
                  </a></li>
                   <li class="clone" aria-hidden="true" style="width: 450px; float: left; display: block;"><a href="javascript:void(0);" id="openPop1_clone">
            
                    <img src="./MediaGallery/SolarPhotos/DSC_0111.jpg" alt="" draggable="false">
                  </a></li>
                </ul>
                
                </div>
                
                <ul class="flex-direction-nav">
                <li><a class="flex-prev" href="">  </a></li>
                <li></li>
                </ul>
                
                </div>
                
        </div>
    </section></TD>



















                             
                        
                        
                        
                          </tr>
                          
                          
                          
                        </table></td>      
                        
                          
                          
                          
                        </table></td>
						
						
						
						
						
						
						
                      </tr>
                      
					 
					 
					  
					
                      
                      </table></td>
						
                      </tr>
                     
                    </table></td>
				

                   					
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
																			<!--<div class="news_scroll_txt"><img src="images/bullet_g.GIF" class="list_icon" alt="" height="7" width="7"></div>-->

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


																			<!-- <a href="./unicef_onlineapplication.jsp" target="_blank"><img src="images/arrow1.gif" />Notification of SBM(G) By UNICEF.</a>
<br></br> -->
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
																									  <tr ><td width="100%" bgcolor="#ffffff" colspan="2" height="10"><!-- Security Code -->

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
									Centre, Andhra Pradesh State Centre. </span></td>
					</table></td>




				<td width="1" valign="top"></td>
			</tr>
		</table>
		</form>
</body>
</center>
</html>
<%@ include file="/commons/rws_alert.jsp"%>