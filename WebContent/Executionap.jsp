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
	<li><a href="Reportsblueap.html" title="Reports">Reports</a></li>
     <li><a href="./downloads/MediaGallery.pptx"  target="_blank" title="MediaGallery"> Media Gallery</a></li>  -->
	
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
                       
             
              
            </table>
			
			 <!--  <a href="http://ddws.gov.in/" target="_blank">  <img src="images/ddwswater1.jpg" onMouseOver="this.src='images/ddwswater1.jpg'" onMouseOut="this.src='images/ddwswater1.jpg'" width="200" height="38" /></a>
    <a href="https://webmail.ap.gov.in/" target="_blank"><img src="images/web.jpg" onMouseOver="this.src='images/web.jpg'" onMouseOut="this.src='images/web.jpg'" width="200" height="38"/></a> 
  
			 <a href="http://india_gov_in.png" target="_blank"> <img src="./images/india_gov_in.png" width="200" height="37"></a>
  
   <a href="https://mail.nic.in/mail/mauth" target="_blank"><img src="images/nnic.jpg" onMouseOver="this.src='images/nnic.jpg'" onMouseOut="this.src='images/nnic.jpg'" width="200" height="38" /></a> -->

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
                <td align="center" valign="top"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td ><!-- InstanceBeginEditable name="EditRegion1" -->
                      <table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                         <td valign="top"><font color=#4A8AC7><b>Execution</b></font>&nbsp;</td>
                        </tr>
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                        
                              <tr>
                <td align="center" valign="top"><table width="90%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td class="header"><span class="h1"><strong>Works Execution Process</strong></span></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>The government formulated a procedure for development of any infrastructure facility in the rural areas of Andhra Pradesh. The procedure for execution of any work and the details of which are given below:</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><table width="0%"  border="0" align="left" cellpadding="4" cellspacing="0">
                        <tr>
                          <td width="10"><img src="images/arrow.gif" width="9" height="13"></td>
                          <td> Representation/Proposal for works</td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td> Line Estimation</td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td> Administrative Sanction </td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td> Detailed Estimation </td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td>Technical Sanction </td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td> Tender Process </td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td>Agreement </td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td> Work Progress and Quality Assurance</td>
                        </tr>
                        <tr>
                          <td><img src="./images/arrow.gif" width="9" height="13"></td>
                          <td>Work completion &amp; Commissioning</td>
                        </tr>
                    </table></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td> The Procedure to be followed for execution of any work in the department is as follows: </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong>Representation/Proposal for works</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>Individuals or Group of people or Department will raise the proposal for development of Infrastructure facilities (works) in rural areas. Based on the request, the department will verify the proposal with the available information in works Register. If the proposed work is useful to the public, then the department will consider the proposal.</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong>Line Estimate</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>The AEE/AE prepares the line estimate with approximate items/measurements for construction of proposed work. The probable work measurement for the items, item specifications and probable rate per unit for the items will be considered while preparing the line estimate. This estimate provides an approximate amount required for execution of proposed work.</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong> Administrative Sanction</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td> The administrative sanction is the pre-requisite for any proposed work to execute or to take up further processing. The department will submit the feasible proposed works to the Government for according Administrative Sanction. Duly verifying the program guidelines and funds availability under that program the Government will accord the administrative sanction to the proposed works. After obtaining administrative sanction from the 
                      
                      
                      Government, Department will prepare the detailed estimate for further processing.</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
               <!--   <tr>
                    <td><span class="h1"><strong><input type=Button value="Click to View Admin Sanction Powers" class="btext" onclick="document.getElementById('OptionsDiv').style.display='block'">
					 <Div id="OptionsDiv" class="SplashScreen" style="display=none">
						 <A style="cursor:hand; top: 0; right: +1; position: absolute;" onclick="document.getElementById('OptionsDiv').style.display='none'" align=right></A><BR><BR>  
						<table width="100%"  border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td>&nbsp;</td>
                        </tr>
                        <tr>
                          <td align="center"><table width="90%" border="1" cellpadding="6" cellspacing="0" bordercolor="#A2C9F9" bgcolor="#5197EF">
                            <col width="36" />
                            <col width="229" />
                            <col width="345" />
                            <tr height="23">
                              <td colspan="3" class="style1"><strong>I.Administration Sanction Powers Of Gram Panchayats</strong></td>
                            </tr>
                            <tr height="35">
                              <td class="style1"><strong>S.No</strong></td>
                              <td class="style1"><strong>Description</strong></td>
                              <td class="style1"><strong>Existing (as per G.O.91, Dt:4.3.99)</strong></td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">1</td>
                              <td bgcolor="#E8F3FF">Minor GP</td>
                              <td bgcolor="#E8F3FF">upto 1.00 lakh</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">2</td>
                              <td bgcolor="#E8F3FF">Major GP</td>
                              <td bgcolor="#E8F3FF">upto 2.00 lakhs</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">3</td>
                              <td bgcolor="#E8F3FF">Divisional Panchayat Officer</td>
                              <td bgcolor="#E8F3FF">upto 3.00 lakhs</td>
                            </tr>
                            <tr height="23">
                              <td height="20" align="right" bgcolor="#E8F3FF">4</td>
                              <td bgcolor="#E8F3FF">District Collector</td>
                              <td bgcolor="#E8F3FF">Above 3.00 lakhs</td>
                            </tr>
                            <tr height="15">
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                            </tr>
                            <tr height="23">
                              <td height="23" colspan="3" bgcolor="#5197EF" class="style1"><strong>II.Administration    Sanction Powers Of Mandal Parishads</strong></td>
                            </tr>
                            <tr height="39">
                              <td bgcolor="#5197EF" class="style1"><strong>S.No</strong></td>
                              <td bgcolor="#5197EF" class="style1"><strong>Description</strong></td>
                              <td width="345" bgcolor="#5197EF" class="style1"><strong>Existing (as per G.O.399, Dt:25.6.87)</strong></td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">1</td>
                              <td bgcolor="#E8F3FF">MDO</td>
                              <td bgcolor="#E8F3FF">upto Rs. 500/-</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">2</td>
                              <td bgcolor="#E8F3FF">Mandal Parishads</td>
                              <td bgcolor="#E8F3FF">Above Rs.500 to Rs.75,000</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">3</td>
                              <td bgcolor="#E8F3FF">Standing Committee of ZP</td>
                              <td bgcolor="#E8F3FF">Above Rs.75,000 to Rs.1,50,000</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">4</td>
                              <td bgcolor="#E8F3FF">Government</td>
                              <td bgcolor="#E8F3FF">Above 1.50 lakhs</td>
                            </tr>
                            <tr height="15">
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                              <td bgcolor="#E8F3FF">&nbsp;</td>
                            </tr>
                            <tr height="28">
                              <td colspan="3" bgcolor="#5197EF" class="style1"><strong>III.Administration    Sanction Powers Of Zilla Parishads</strong></td>
                            </tr>
                            <tr height="35">
                              <td bgcolor="#5197EF" class="style1"><strong>S.No</strong></td>
                              <td bgcolor="#5197EF" class="style1"><strong>Description</strong></td>
                              <td width="345" bgcolor="#5197EF" class="style1"><strong>Existing (as per G.O.400, Dt:25.6.87)</strong></td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">1</td>
                              <td bgcolor="#E8F3FF">CEO</td>
                              <td bgcolor="#E8F3FF">upto Rs. 1000/-</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">2</td>
                              <td bgcolor="#E8F3FF">Standing Committee of ZP</td>
                              <td bgcolor="#E8F3FF">Above Rs.1000 to Rs.5,00,000</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">3</td>
                              <td bgcolor="#E8F3FF">Zilla Parishad</td>
                              <td bgcolor="#E8F3FF">Above Rs.5,00,000 to Rs.10,00,000</td>
                            </tr>
                            <tr height="23">
                              <td align="right" bgcolor="#E8F3FF">4</td>
                              <td bgcolor="#E8F3FF">Government</td>
                              <td bgcolor="#E8F3FF">Above 10.00 lakhs</td>
                            </tr>
                          </table></td>
                        </tr>
                      </table>
					 <Div>
					 </td>
                  </tr>-->
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong>Detailed Estimate</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td> After obtaining the Administrative sanction, the department officer conducts a feasibility study of the proposed work site and prepares the drawing, identifies the items, draws up the specifications for the items and obtains the rate per unit item of the proposed work. Then the detailed estimate will be prepared with the above parameters. </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong> Technical Sanction</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>The detailed estimate will be verified about the technical viability of taking up the work. If the work is technically viable then only the competent authority in the department will accord the technical sanction. Based on the estimate cost of the work, powers have been delegated at various levels in the organization to accord technical sanction to the work and the details of which are given below: </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>
					<!--<span class="h1"><strong><input type=Button value="Click to View Technical Sanction Powers" class="btext" onclick="document.getElementById('OptionsDiv1').style.display='block'">-->
					 <Div id="OptionsDiv1" class="SplashScreen" style="display=none">
						 <A style="cursor:hand; top: 0; right: +1; position: absolute;" onclick="document.getElementById('OptionsDiv1').style.display='none'" align=right>Close</A><BR><BR>  
						 <table border="1" align="center" cellpadding="4" cellspacing="0" bordercolor="#A2C9F9" bgcolor="#5197EF">
                            <tr bgcolor="#E8F3FF">
                              <td width="548" colspan="3" bgcolor="#5197EF" class="style1"><strong>Technical Sanction Powers as per G.O.MS.No.234, Dt : 11.12.2018</strong></td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" bgcolor="#5197EF" class="style1"><strong>SNo. </strong></td>
                              <td width="277" bgcolor="#5197EF" class="style1"><strong>Est. Value of Work put to tender (in Rs Lacs)</strong></td>
                              <td width="231" bgcolor="#5197EF" class="style1"><strong>Designation</strong></td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl24">1 </td>
                              <td width="277" class="xl23">Upto Rs.25000</td>
                              <td width="231" class="xl23">Section Officers (AEE/AE)</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl24">2 </td>
                              <td width="277" class="xl23">Above Rs 25000 to Rs. 5.00 lakhs</td>
                              <td width="231" class="xl23">Dy.Executive Engineer</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl24">3 </td>
                              <td width="277" class="xl23">Above Rs. 5.00 to Rs. 40.00 lakhs</td>
                              <td width="231" class="xl23">Executive Engineer</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl24">4 </td>
                              <td width="277" class="xl23">Above Rs.40.00 to Rs.200.00 Lakhs</td>
                              <td width="231" class="xl23">Superintending Engineer</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl24">5 </td>
                              <td width="277" class="xl23">Above Rs.200.00 lakhs</td>
                              <td width="231" class="xl23">Chief Engineer/ Engineer-in-Chief</td>
                            </tr>
                          </table>
						  </div>
					</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong> Tender Process </strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>After according the technical sanction, the concerned officer will prepare the tender notice/schedule and releases the tender notice for the proposed work. The contractors/agencies will purchase the tender schedules from the department and submit their quote to the department along the security deposit (EMD) proposed in the tender schedule. The department opens all the tenders submitted by contractors and finalizes the lowest quoted tender duly adopting the tender finalization rules and regulations. <br>
                        <br>
                      This conventional tender process is applicable to works costing less than Rs.10.00 lakhs. In case of works, costing Rs.10.00 lakhs and above e-procurement process shall be adopted. </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>
					<!--<span class="h1"><strong><input type=Button value="Click to View Tender Process Powers" class="btext" onclick="document.getElementById('OptionsDiv2').style.display='block'">-->
					 <Div id="OptionsDiv2" class="SplashScreen" style="display=none">
						 <A style="cursor:hand; top: 0; right: +1; position: absolute;" onclick="document.getElementById('OptionsDiv2').style.display='none'" align=right>Close</A><BR><BR>
						 <table border="1" cellpadding="4" cellspacing="0" bordercolor="#A2C9F9" bgcolor="#5197ED">
                            <tr bgcolor="#E8F3FF">
                              <td width="621" colspan="4" bgcolor="#5197ED" class="style1"><strong>Tender Acceptance Powers as per G.O.MS.No.234, Dt : 11.12.2018</strong></td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" bgcolor="#5197ED" class="style1"><strong>SNo. </strong></td>
                              <td width="204" bgcolor="#5197ED" class="style1"><strong>Est. Value of Work put to tender (in Rs Lacs)</strong></td>
                              <td width="186" bgcolor="#5197ED" class="style1"><strong>Designation</strong></td>
                              <td width="191" bgcolor="#5197ED" class="style1"><strong>Powers of Acceptance of tenders</strong></td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl25">1 </td>
                              <td width="204" class="xl24">Upto Rs. 5.00 </td>
                              <td width="186" class="xl24">Dy.Executive Engineer </td>
                              <td width="191" class="xl24">Upto 5% excess over Estimate rates </td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl25">2 </td>
                              <td width="204" class="xl24">Above Rs. 5.00 to Rs. 40.00 </td>
                              <td width="186" class="xl24">Executive Engineer </td>
                              <td width="191" class="xl24">Upto 5% excess over estimate rates </td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl25">3 </td>
                              <td width="204" class="xl24">Above Rs.40.00 to Rs.200.00 </td>
                              <td width="186" class="xl24">Superintending Engineer </td>
                              <td width="191" class="xl24">Upto 5% excess over estimate rates </td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl25">4 </td>
                              <td width="204" class="xl24">Above Rs.200.00 to Rs. 1000.00 Lakhs </td>
                              <td width="186" class="xl24">Chief Engineer/ Engineer-in-Chief </td>
                              <td width="191" class="xl24">Upto 5% excess over estimate rates </td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td width="40" class="xl25">5 </td>
                              <td width="204" class="xl24">Above Rs. 1000.00 lakhs </td>
                              <td width="186" class="xl24">Tender Committee </td>
                              <td width="191" class="xl24">Upto 5% excess over estimate rates </td>
                            </tr>
                          </table>
					</div>
					</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong>Agreement to the work</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>The work will be awarded to the lowest responsive quoted contractor/agency. The contractor has to enter into an agreement with the department for execution of the awarded work duly accepting the departmental terms and conditions. Then the contractor submits the time schedule for execution of work.</td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td>
					<!--<span class="h1"><strong><input type=Button value="Click to View EOAT Process Powers" class="btext" onclick="document.getElementById('OptionsDiv3').style.display='block'">-->
					 <Div id="OptionsDiv3" class="SplashScreen" style="display=none">
						 <A style="cursor:hand; top: 0; right: +1; position: absolute;" onclick="document.getElementById('OptionsDiv3').style.display='none'" align=right>Close</A><BR><BR>
						 <table border="1" cellpadding="4" cellspacing="0" bordercolor="#A2C9F9" bgcolor="#5197EF">
                            <tr bgcolor="#E8F3FF">
                              <td width="916" colspan="3" bgcolor="#5299F3" class="style1"><strong>Delegation of Powers for EOAT (G.O Ms.No: 8, Dated: 30.01.2017 of PR&RD)</strong></td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td bgcolor="#5299F3" class="style1"><strong>S.No </strong></td>
                              <td bgcolor="#5299F3" class="style1"><strong>Description</strong></td>
                              <td width="345" bgcolor="#5299F3" class="style1"><strong>Powers</strong></td>
                              </tr>
                            <tr bgcolor="#E8F3FF">
                              <td class="xl24">A </td>
                              <td colspan="2" class="xl28">Sanction of Extension of Agreement Time</td>
                              </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">1 </td>
                              <td width="229" class="xl26">Authority who approved the tender</td>
                              <td class="xl30">1st 3 (three) months with LDs of 10% of the balance contract value </td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">2 </td>
                              <td width="229" class="xl26">Next higher Authority who approved the tender</td>
                              <td class="xl30">beyond 3 months and up to 6 months with LDs of 10% of the balance contract value</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">3 </td>
                              <td width="229" class="xl26">Government</td>
                              <td class="xl30">Beyond 6 months and / or without LDs</td>
                            </tr>
                            <!--<tr bgcolor="#E8F3FF">
                              <td class="xl24">B </td>
                              <td colspan="2" class="xl28">Works sanctioned at State Level (Governemnt)</td>
                              </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">1 </td>
                              <td width="229" class="xl26">The agreement concluding authority</td>
                              <td class="xl30">upto 25% of original agreement period where LD clause is not invokable</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">2 </td>
                              <td width="229" class="xl26">Chief Engineer concerned</td>
                              <td class="xl30">upto a maximum of further 50% where LD clause is not invokable</td>
                            </tr>
                            <tr bgcolor="#E8F3FF">
                              <td align="right" class="xl27">3 </td>
                              <td width="229" class="xl26">Engineer-in-Chief</td>
                              <td class="xl30">Beyond 75% of original agreement period</td>
                            </tr>-->
                          </table>
				  </div>
				  </td>
                  </tr>
                  <tr>
                    <td class="text">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong>Work Progress and Quality Assurance </strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td> The department issues work order to the contractor/agency duly informing the concerned officers to start the work. The departmental officers continuously monitor each and every item of the work specified in the tender estimate. As per the agreement conditions, the work progress could be monitored and accordingly payments will be released to the contractor/agency., The officer in charge of the work will inform the work progress to the higher office. Departmental officers will inspect the work periodically in order to ensure the qualitative and qualitative aspect of the work. If there are any deviations related to qualitative and quantitative aspects, the officers will suggest the rectifications and accordingly contractor has to execute the work. </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="text"><strong> Completion and Commissioning of Work</strong></td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td> The contractor/agency has to execute the work as per the agreement conditions. When the work is completed as per the agreement conditions, departmental officers will certify about the commissioning of the work. The officer in charge of the work will inform about the commissioning of the work to the higher office. The details of the completed works would be entered into Works Assets Register and work completion report will be submitted to the higher office. </td>
                  </tr>
                  <tr>
                    <td bgcolor="#f7f7f7">&nbsp;</td>
                  </tr>
                </table></td>
              </tr>
          
                       
                        
                        
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





															<!-- sairam 6-9-2022 <div class="news_container_main">
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
				  
				 
				  
                </table>
				</td>
				
            </table></td>
			
			
			
          </tr>
        </table></td>
      </tr>
	  
	  


	  
	  
	 
     <!--#0068A2-->
      <tr>
	  
	   
        <td  colspan="4" height="25"  bgcolor="#42A5FF"><table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
		  
            <td colspan="4"><span class="style1">&copy; 2014-15 Rural Water Supply &amp; Sanitation.</span><span class="style1">Designed, 
      Developed &amp; Hosted and Maintained by National Informatics Centre, Andhra Pradesh 
      State Centre	</span></td>
	  
		<!--   
	  <a href="Related Links" target="_blank"> <img src="./images/imagesyyy.jpg" width="210" height="60" ></a>
	  
	   <a href=" FeedBack" target="_blank" title="Feedback"> <img src="./images/feedback.jpg" width="110" height="59"></a>
	  <a href="Visitor" target="_blank" title="Visitors"> <img src="./images/visitors.jpg" width="110" height="59"></a>
	   
	  
	 </tr><td align="center"><span class="style1"><a href="#"><font color="#9933FF"><b> FeedBack</b></font></a></span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><font color="#9933FF"><b>Visitor</b></font><span class="style2"></span></a></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#"><font color="#9933FF"><b>Related Links</b></font></a></span></td>-->
    </table></td>
	
	
	
	
    <td width="1" valign="top" ></td>
  </tr>
</table>
</form>
</center>
</body>
</html>
