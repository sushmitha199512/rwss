 

<%@page import="java.util.Date"%>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
System.out.println(users);
String userid = users.getUserId();
String isEmailRegistered=users.getIsEmailRegistered();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ include file="/reports/conn.jsp" %>
<%@ include file="rws_alerts.jsp" %>
<%@ include file="/commons/rws_header1.jsp" %>


<title>WATERSOFT-Official Website</title>
<script type="text/javascript">
    <jsp:include page="../dashboards/Includes/rws_dashboard.js" />
<jsp:include page="../FusionCharts/FusionCharts.js" />
</script>
<% response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
 response.setHeader("Pragma","no-cache"); //HTTP 1.0 
 response.setDateHeader ("Expires", 0); //prevents caching at the proxy server  
%>
<%




ResultSet rs1 = null;
Statement st1 = null;
try
{
String fyear="";
if(request.getParameter("finyear")!=null){

    fyear=request.getParameter("finyear");
    Debug.println("FinYear:"+fyear);
    session.setAttribute("financialyr",fyear);
    } else{
    fyear=(String)session.getAttribute("financialyr");
    }
      

    java.util.Date currentDate=new java.util.Date();
             int f1=currentDate.getYear();
 			f1+=1900;
            int f2=f1+1;
          String finYear1=f1+"-"+f2;
          //System.out.println("finYear1:"+finYear1);
 	st1 = conn.createStatement();
	String q1 = "select * from rws_secretary_details_tbl";
	//rs1 = st1.executeQuery(q1);
	//rs1.next();
%>


<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>Welcome to Watersoft</TITLE>
<META content="text/html; charset=iso-8859-15" http-equiv=Content-Type>

<style media="all" type="text/css">

A:link{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:visited{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:hover{font-family:verdana;font-size:8pt;text-decoration:underline;color:#316A95}
.noborder-text-box
{
	border: 0;
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	LETTER-SPACING: 1px;
	FONT-SIZE: 12x;
	FONT-WEIGHT: bold;	
	width:85px;
	text-align:right;
}

</STYLE>


<script language="JavaScript" src="/pred/resources/javascript/jquery-1.4.2.js"></script>
<LINK rel=stylesheet type=text/css href="imagess/style.css">

<style type="text/css">
<!--
.style1 {
	color: white;
	font-size: 12;
}



.modeltextbox {
	width: 221px;
	background: transparent url('images/bgtext.jpg') no-repeat;
	color : green;
	height:20px;
	border:0;
	padding:4px 8px;
	margin-bottom:0px;
}
.text2{
font-weight :bold;
color : green;
text-align:right;
}
.green{
color : #F58F00;
text-align:left;
<!--font-weight :bold;-->
}

.fb5 {
	background-color: #db6600;
	padding-left:6px;
	padding-right:6px;
	padding-top:3px;
	padding-bottom:3px;	
	color: #ffffff;
	border:1px solid #db6600;
	background-image: url(images/button_bg.jpg);
}
.fb5:hover {
	background-color: #000000;	
	border:1px solid #000000;
	background-image: url(images/button_bg_over.jpg);
}

.ta5 {
border: 3px double #CCCCCC;
	width: 450px;
	height: 80px;

}
.h4:hover { text-transform:uppercase; color:orange;font-weight :bold}

.ta225 {
	background: url(images/roundtext.gif) no-repeat top left;

border: 0;
	width: 220px;
	height:55px;

border: 3px double #CCCCCC;
	width: 230px;
	height: 60px;

}
.ta5a{
	border: 0;
	width: 220px;
	height:55px;
	margin-top: 3px;
}

.modeltextbox1 {
	width: 150px;
	background: transparent url('images/bgtext.jpg') no-repeat;
	color : blue;
	height:20px;
	border:0;
	padding:4px 8px;
	margin-bottom:0px;
}

.checkbox, .radio {
	width: 19px;
	height: 25px;
	padding: 0 5px 0 0;
	background: url(checkbox.png) no-repeat;
	display: block;
	clear: left;
	float: left;
}
.radio {
	background: url(radio.png) no-repeat;
}

select {
    padding:3px;
    margin: 0;
    -webkit-border-radius:4px;
    -moz-border-radius:4px;
    border-radius:4px;
    -webkit-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    -moz-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
    background: #f8f8f8;
    color:#888;
    border:none;
    outline:none;
    display: inline-block;
    -webkit-appearance:none;
    -moz-appearance:none;
    appearance:none;
    cursor:pointer;
}

label {position:relative}
label:after {
    content:'<>';
    font:11px "Consolas", monospace;
    color:#aaa;
    -webkit-transform:rotate(90deg);
    -moz-transform:rotate(90deg);
    -ms-transform:rotate(90deg);
    transform:rotate(90deg);
    right:8px; top:2px;
    padding:0 0 2px;
    border-bottom:1px solid #ddd;
    position:absolute;
    pointer-events:none;
}
label:before {
    content:'';
    right:6px; top:0px;
    width:20px; height:20px;
    background:#f8f8f8;
    position:absolute;
    pointer-events:none;
    display:block;
}?

#Layer1 {
	position:absolute;
	width:664px;
	height:115px;
	z-index:1;
	visibility: visible;
}
#Layer2 {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
	left: 375px;
	top: 125px;
}
#content {
	position:absolute;
	width:200px;
	height:115px;
	z-index:1;
	left: 300px;
	top: 350px;
}

-->
</style>



<link href="/pred/resources/style/dockstyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/pred/resources/javascript/jscharts.js"></script>
<link rel="stylesheet" href="/pred/resources/style/example.css" type="text/css">





<style>
	#resizable, #resizable2 { width: 200px; height: 150px; padding: 0.5em; }
#resizable3 { width: 260px; height: 150px; padding: 0.5em; }
#resizable4 { width: 300px; height: 150px; padding: 0.5em; }
#resizable5 { width: 200px; height: 320px; padding: 0.5em; }
#resizable6 { width: 500px; height: 250px; padding: 0.5em; }
#resizable8 { width: 500px; height: 350px; padding: 0.5em; }
#resizable9 { width: 600px; height: 320px; padding: 0.5em; }
#resizable10 { width: 600px; height: 150px; padding: 0.5em; }
#habcoverage { width: 200px; height: 320px; padding: 0.5em; }
	#resizable h3, #resizable2 h3 { text-align: center; margin: 0; }
	#resizable3 h3, #resizable4 h3 { text-align: center; margin: 0; color:"lightgreen" }
#resizable5 h3, #resizable4 h3 { text-align: center; margin: 0; }
#resizable6 h3, #resizable6 h3 { text-align: center; margin: 0; }
#graph { width: 500px; height: 320px; padding: 0.5em; }
#assets { width: 240px; height: 150px; padding: 0.5em; }
#wq { width: 240px; height: 150px; padding: 0.5em; }
	</style>
	<script>
	$(function() {

$("#set1 a").tooltip({
	bodyHandler: function() {
		return $($(this).attr("href")).html();
	},
	showURL: false
});

$( "#resizable3" ).resizable({
			delay: 1000
		});
		
		$( "#resizable2" ).resizable({
			distance: 40
		});
	});
	</script>

<link rel="stylesheet" href="/pred/resources/style/jquery.ui.all.css">
	<script src="/pred/resources/javascript/jquery-3.6.0.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.core.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.widget.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.tabs.js"></script>
	<link rel="stylesheet" href="/pred/resources/style/demos.css">
	<link rel="stylesheet" href="/pred/resources/style/example.css" type="text/css">


	<link href="" rel="stylesheet" id="theme_css"> 


<script src="/pred/resources/javascript/jquery.ui.mouse.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.resizable.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.accordion.js"></script>
	<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
	
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


			// Dialog Link
				$('#dialog_link').click(function(){
					$('#dialog').dialog('open');
					return false;
				});
	});
	</script>






<script language ="javascript" type="text/javascript" >


function openUserForm(){

	var emailReg='<%=isEmailRegistered %>';
	
	if(emailReg!="true"){
	TINY.box.show({iframe:'switch.do?prefix=/admin&page=/users.do&mode=data',boxid:'frameless',width:600,height:400,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
	}
}
function openJS(){}
function closeJS(){}

var finyear="";

var userid="";
var chart1XML="";
var chart2XML="";
var chart3XML="";


function change(type){
	//alert("ss:"+type);
	 var userid = '<%=userid%>';
if(type=="1"){
	//setCookie(userid,'1',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/admin/css/page/jquery-ui-1.10.2.custom.css';
  } else if(type=="2"){
	  
	  //setCookie(userid,'2',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/ee/css/start/jquery-ui-1.8.23.custom.css';

}else if(type=="3"){
	//setCookie(userid,'3',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/user/css/trontastic/jquery-ui-1.10.2.custom.css';
} else if(type=="4"){
	//setCookie(userid,'4',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/custom/css/start/jquery-ui-1.8.23.custom.css';

}


}

function refreshData(){
	document.getElementById('content').style.display='none';
	//document.forms[0].elements["content"].style.display='none';
	//alert("yes");
	var URL="FinancialYearWorks.jsp?finyear="+finyear+"&reqMode=update";
  	ajaxFunction_Works(URL);

}

function releasesChart(){
	var obj1,obj2,obj3;
 
 if(chart1XML==""){
 var URL1="./dashboards/rws_dashboard_charts.jsp?type=relDiv&finyear="+finyear+"&userid="+userid;
 ajaxFunction_Charts(URL1,1);
 }else {
 //updateChartXML('1',chart1XML);
	 createChart('./FusionCharts/FCF_Column3D.swf',1,500,280,0,0,chart1XML,'ChartDiv2',obj1);
}
 
 
	setTimeout('expChart();','10000');
	
	
   //document.getElementById('ChartDiv1').style.display='none';	
//document.getElementById('ChartDiv2').style.display='none';	

//document.getElementById('ChartDiv').style.display='block';

}

function assetChart(){
	var obj1,obj2,obj3;

if(chart3XML==""){
var URL1="./dashboards/rws_dashboard_charts.jsp?type=asset&finyear="+finyear+"&userid="+userid;
ajaxFunction_Charts(URL1,3);
}else {
//updateChartXML('3',chart3XML);
	createChart('./FusionCharts/FCF_Column3D.swf',3,500,280,0,0,chart3XML,'ChartDiv2',obj3);
}


setTimeout('releasesChart();','10000');
//document.getElementById('ChartDiv').style.display='none';
// document.getElementById('ChartDiv1').style.display='none';
// document.getElementById('ChartDiv2').style.display='block';
}
function expChart(){
	var obj1,obj2,obj3;

if(chart2XML==""){
var URL1="./dashboards/rws_dashboard_charts.jsp?type=expDiv&finyear="+finyear+"&userid="+userid;
ajaxFunction_Charts(URL1,2);
}else {
//updateChartXML('2',chart2XML);
	createChart('./FusionCharts/FCF_Pie3D.swf',2,500,280,0,0,chart2XML,'ChartDiv2',obj2);
}

setTimeout('assetChart();','10000');
//document.getElementById('ChartDiv').style.display='none';
// document.getElementById('ChartDiv2').style.display='none';
// document.getElementById('ChartDiv1').style.display='block';
}

function creategraph(){

	//var obj1,obj2,obj3;
	//createChart('./FusionCharts/FCF_Column3D.swf',1,500,280,0,0,'','ChartDiv2',obj1);
	//createChart('./FusionCharts/FCF_Pie3D.swf',2,500,280,0,0,'','ChartDiv2',obj2);
	//createChart('./FusionCharts/FCF_Column3D.swf',3,500,280,0,0,'','ChartDiv2',obj3);
	releasesChart();
	
	}



function getCheckedValue(radioObj) {
	if(!radioObj)
		return "";
	var radioLength = radioObj.length;
	if(radioLength == undefined)
		if(radioObj.checked)
			return radioObj.value;
		else
			return "";
	for(var i = 0; i < radioLength; i++) {
		if(radioObj[i].checked) {
			return radioObj[i].value;
		}
	}
	return "";
}


             //Sending message to  all users  

function messageSend(){
  var message=document.getElementById("message").value;
  if(message==""){
    alert("Please Enter Message");
return;
		}
  var priority=getCheckedValue(document.forms['master'].elements['priority']);
var chks = document.getElementsByName('to');
var to="";
for (var i = 0; i < chks.length; i++)
{
if (chks[i].checked)
{

  to+=chks[i].value;
	to+=",";
}
}
 if(to.length<1){
   alert("Please Select To List");
}

  

 var URL="Secretary/rws_sec_message_process.jsp?userid=<%=userid %>&message="+message+"&to="+to+"&priority="+priority;

       ajaxFunction_Messaging(URL);
}


function getWorks()
{
chart1XML="";
chart2XML="";
chart3XML="";
 finyear=document.getElementById("finyear").value;
 userid = '<%=userid%>';
	

if(finyear==null){
finyear="2014-2015";}
//document.getElementById("hh").innerHTML="("+finyear+")";
//document.getElementById("wq").innerHTML="("+finyear+")";

var URL="FinancialYearWorks.jsp?finyear="+finyear+"&reqMode=view";
  	ajaxFunction_Works(URL);

}
	


function ajaxFunction_Messaging(URL)
{ 
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;
		resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{}
		else
		{
        alert(resp);
document.getElementById("message").value="";
      
		}
	  	
     // document.getElementById('content').style.display='none';
	  }
	  else{
  
		  //document.getElementById('content').style.display='block';
	

//alert("failed");
		// document.getElementById('content').style.display='block';
	  }
	};

	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}

function fnReset(){

document.getElementById("message").value="";
}

function ajaxFunction_Charts(URL,type)
{ 
  // alert(type);
  var obj1,obj2,obj3;
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;
     	resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{}
		else
		{             

        if(type==1){
        	
		         chart1XML=resp; 
		         createChart('./FusionCharts/FCF_Column3D.swf',1,500,280,0,0,chart1XML,'ChartDiv2',obj1);
		//updateChartXML('1',resp);
          }else if(type==2){
          // alert(resp);
           	chart2XML=resp;
           	createChart('./FusionCharts/FCF_Pie3D.swf',2,500,280,0,0,chart2XML,'ChartDiv2',obj2);
                 
		}else if(type==3){
           //alert(resp);
			chart3XML=resp;
			createChart('./FusionCharts/FCF_Column3D.swf',3,500,280,0,0,chart3XML,'ChartDiv2',obj3);
                 }
		}
	
      
	  }
	  else{
  
		
	  }
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}

function resetData(){

	document.getElementById('mandals').innerHTML="0";
	document.getElementById('panchayats').innerHTML="0";
	document.getElementById('villages').innerHTML="0";
	document.getElementById('habs').innerHTML="0";
	document.getElementById('pws').innerHTML="0";
	document.getElementById('mpws').innerHTML="0";
	document.getElementById('cpws').innerHTML="0";
	document.getElementById('borewells').innerHTML="0";
	document.getElementById('ongoing').innerHTML="0";
	document.getElementById('notground').innerHTML="0";
	document.getElementById('completed').innerHTML="0";
	document.getElementById('commissioned').innerHTML="0";
	document.getElementById('fc').innerHTML="0";
	document.getElementById('pc4').innerHTML="0";
	document.getElementById('pc3').innerHTML="0";
	document.getElementById('pc2').innerHTML="0";
	document.getElementById('pc1').innerHTML="0";
	document.getElementById('nss').innerHTML="0";
	document.getElementById('nc').innerHTML="0";
	document.getElementById('phys').innerHTML="0";
	document.getElementById('bact').innerHTML="0";
	document.getElementById('ongoing1').innerHTML="0";
	
	document.getElementById('notground1').innerHTML="0";
	document.getElementById('completed1').innerHTML="0";
	document.getElementById('commissioned1').innerHTML="0";
	document.getElementById('labvalue').innerHTML="0";
	document.getElementById('totsources').innerHTML="0";
	document.getElementById('flouride').innerHTML="0";
	document.getElementById('brakish').innerHTML="0";
	document.getElementById('iron').innerHTML="0";
	document.getElementById('nitrate').innerHTML="0";
}
function ajaxFunction_Works(URL)
{ 
	
	resetData();
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {

  
		var resp = xmlHttp.responseText;
     	resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{

		}
		else
		{
   
			var mytool_array=resp.split("/");

			
			document.getElementById('mandals').innerHTML=mytool_array[0];
			
			document.getElementById('panchayats').innerHTML=mytool_array[1];
			document.getElementById('villages').innerHTML=mytool_array[2];
			document.getElementById('habs').innerHTML=mytool_array[3];
			document.getElementById('pws').innerHTML=mytool_array[4];
			document.getElementById('mpws').innerHTML=mytool_array[5];
			document.getElementById('cpws').innerHTML=mytool_array[6];
			document.getElementById('borewells').innerHTML=mytool_array[7];
			document.getElementById('ongoing').innerHTML=mytool_array[8];
			document.getElementById('notground').innerHTML=mytool_array[9];
			document.getElementById('completed').innerHTML=mytool_array[10];
			document.getElementById('commissioned').innerHTML=mytool_array[11];
			document.getElementById('fc').innerHTML=mytool_array[12];
			document.getElementById('pc4').innerHTML=mytool_array[13];
			document.getElementById('pc3').innerHTML=mytool_array[14];
			document.getElementById('pc2').innerHTML=mytool_array[15];
			document.getElementById('pc1').innerHTML=mytool_array[16];
			document.getElementById('nss').innerHTML=mytool_array[17];
			document.getElementById('nc').innerHTML=mytool_array[18];
			document.getElementById('phys').innerHTML=mytool_array[19];
			document.getElementById('bact').innerHTML=mytool_array[20];
			document.getElementById('ongoing1').innerHTML=mytool_array[21];
			
			document.getElementById('notground1').innerHTML=mytool_array[22];
			document.getElementById('completed1').innerHTML=mytool_array[23];
			document.getElementById('commissioned1').innerHTML=mytool_array[24];
			document.getElementById('labvalue').innerHTML=mytool_array[25];
			document.getElementById('totsources').innerHTML=mytool_array[26];
			document.getElementById('flouride').innerHTML=mytool_array[27];
			document.getElementById('brakish').innerHTML=mytool_array[28];
			document.getElementById('iron').innerHTML=mytool_array[29];
			document.getElementById('nitrate').innerHTML=mytool_array[30];
			
			
			
			
			////
			/*document.forms[0].mandals.value = mytool_array[0];
			document.forms[0].panchayats.value = mytool_array[1];
			document.forms[0].villages.value = mytool_array[2];
			document.forms[0].habs.value = mytool_array[3];
			document.forms[0].pws.value = mytool_array[4];
			document.forms[0].mpws.value = mytool_array[5];
			document.forms[0].cpws.value = mytool_array[6];
			document.forms[0].borewells.value = mytool_array[7];
			document.forms[0].ongoing.value = mytool_array[8];
			document.forms[0].notground.value = mytool_array[9];
			document.forms[0].completed.value = mytool_array[10];
			document.forms[0].commissioned.value = mytool_array[11];
			document.forms[0].fc.value = mytool_array[12];
			document.forms[0].pc4.value = mytool_array[13];
			document.forms[0].pc3.value = mytool_array[14];
			document.forms[0].pc2.value = mytool_array[15];
			document.forms[0].pc1.value = mytool_array[16];
			document.forms[0].nss.value = mytool_array[17];
			document.forms[0].nc.value = mytool_array[18];
			document.forms[0].phys.value = mytool_array[19];	
			document.forms[0].bact.value = mytool_array[20];
			document.getElementById('ongoing1').innerHTML=mytool_array[21];
			//document.forms[0].elements["ongoingD"].value=mytool_array[21];
			document.forms[0].ongoing1.value = mytool_array[21];
			document.forms[0].notground1.value = mytool_array[22];
			document.forms[0].completed1.value = mytool_array[23];
			document.forms[0].commissioned1.value = mytool_array[24];
			document.forms[0].labvalue.value = mytool_array[25];
 */
			
			
			}
	
      document.getElementById('content').style.display='none';
	  }
	  else{
  
		  document.getElementById('content').style.display='block';
	  }
	}
	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}



function ajaxFunction(URL)
{ 
	if (URL.indexOf("?") != -1) { URL = URL + "&date=" + new Date(); } else { URL = URL + "?date=" + new Date(); }
	var xmlHttp;
	try{
		xmlHttp=new XMLHttpRequest();    
	}
	catch (e){    
		try{
			xmlHttp=new ActiveXObject("Msxml2.XMLHTTP");      
		}
		catch (e){
		  try{
			  xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");        
		  }
		  catch (e){
			  alert("Your browser does not support AJAX!");        
			  return false;        
		  }      
		}    
	}
	if (xmlHttp==null)
	{
	  alert ("Your browser does not support AJAX!");
	  return;
	} 
	xmlHttp.onreadystatechange=function()
	{
	  if(xmlHttp.readyState==4)
	  {
		var resp = xmlHttp.responseText;
		resp = resp.replace(/^\s*|\s*$/g,'');
		if(resp==null || resp=="" || resp.length==0)
		{}
		else
		{
   
			/*var mytool_array=resp.split("/");
			document.forms[0].mandals.value = mytool_array[0];
			document.forms[0].panchayats.value = mytool_array[1];
			document.forms[0].villages.value = mytool_array[2];
			document.forms[0].habs.value = mytool_array[3];
			document.forms[0].pws.value = mytool_array[4];
			document.forms[0].mpws.value = mytool_array[5];
			document.forms[0].cpws.value = mytool_array[6];
			document.forms[0].borewells.value = mytool_array[7];
			document.forms[0].bro.value = mytool_array[8];
			document.forms[0].loc.value = mytool_array[9];
			document.forms[0].exp.value = mytool_array[10];
			*/
		}
		document.getElementById('content').style.display='none';
      init();
	  }
	  else{
                   init();
		  document.getElementById('content').style.display='block';
	  }
	}

	xmlHttp.open("POST",URL,true);
	xmlHttp.send(null);  
}
function openJS(){}
function closeJS(){}


function viewReport(URL){
	
	var finyear=document.forms[0].elements["finyear"].value;
	//var finyear=document.getElementById("finyear").value;
		if(finyear==null){
	finyear="2014-2015";}
	 	URL+="&finYear="+finyear;
	// alert(URL);
	 TINY.box.show({iframe:URL,boxid:'frameless',width:1000,height:600,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});

}
function viewWorks(URL)
{
	
	//var finyear=document.getElementById("finyear").value;
	 //	if(finyear==null){
	//finyear="2014-2015";}
	 	
	 	//URL+="&finYear="+finyear;
	 //	alert(URL);
	 	
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function changePasswordWindow(URL)
{

	TINY.box.show({iframe:URL,boxid:'frameless',width:600,height:400,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
	
}
function fnCall(reportVal)
{
	var URL = "";
	if(reportVal=="1")


         URL = "./reports/rws_Financial_rpt.jsp";
 
		//URL = "./reports/rws_const_coverage_status_frm.jsp";
	else if(reportVal=="2")
    URL="./reports/rws_Releases_Exp_frm.jsp";
	else if(reportVal=="3")
		URL="./reports/rws_Exp_Rel_Pro_frm.jsp";
		//URL = "./reports/rws_hab_status_resource_rpt.jsp";
	else if(reportVal=="4")

   URL="./reports/rws_BankPao_Payment_det_frm.jsp";
		
	else if(reportVal=="5")

      URL="switch.do?prefix=/masters&page=/Contractor.do&mode=getContractorlist&special=reset";
		
	else if(reportVal=="6")

         URL="./reports/rws_const_coverage_status_frm.jsp";
		//
	else if(reportVal=="7")
        URL="./reports/rws_hab_status_resource_rpt.jsp";
		
	else if(reportVal=="8")
        URL="./reports/rws_district_wise_gps_frm.jsp";
		//URL = "./reports/rws_coverage_status_graph_rpt.jsp?chart=b&district=51&mandal=0&panchayat=0&FDate=01-APR-2010";
else if(reportVal=="9")
        URL="./reports/rws_district_wise_gps_status_frm.jsp";
	else if(reportVal=="10")
        URL="./reports/rws_slippagetable_hab_frm.jsp";
	else if(reportVal=="11")

		URL = "./reports/rws_school_abstract_rpt1_secy.jsp?rDistrict=00&drill=null&rDistrictName=ALL";
else if(reportVal=="12")
URL = "./reports/rws_dist_asst.jsp?district=-1&mandal=0&panchayat=0&habitation=0";
else if(reportVal=="13")
URL = "./reports/rws_AssetAbstract_report1.jsp?yrcreation=00&drill=&rDistrictName=";
else if(reportVal=="14")
URL = "./reports/rws_work_gen.jsp?district=00&finyear=<%= finYear1%>&planNonplan=1&drill=null&distname=ALL";
else if(reportVal=="15")
URL="./reports/rws_drought_habitations_frm.jsp";
else if(reportVal=="16")
URL="./reports/rws_drought_deepen_frm.jsp";
else if(reportVal=="17")
URL="./reports/rws_drought_deepen_abst_frm.jsp";
else if(reportVal=="18")
URL="./reports/rws_drought_daily_rpt.jsp";
else if(reportVal=="19")
URL="./reports/rws_drought_distwise_sstank_rpt.jsp";
else if(reportVal=="20")
URL="./reports/rws_water_nsshabs_frm_rpt.jsp";
else if(reportVal=="21")
URL="./reports/rws_water_sample_abstract_frm.jsp";
else if(reportVal=="22")
URL="./reports/rws_dist_popcate_rpt1.jsp";
else if(reportVal=="23")
URL="./reports/Contractor/rws_contractor_frm.jsp";
else if(reportVal=="24")
URL="./reports/rws_WQ_lab_frm_rpt.jsp";
else if(reportVal=="25")
URL="./reports/rws_WQ_Habs_Coverage_Frm.jsp";
else if(reportVal=="26")
URL="./reports/rws_works_exception_frm.jsp";
else if(reportVal=="27")
URL="./reports/rws_work_general_abstract_rpt_p.jsp";

else if(reportVal=="28")
URL="./reports/rws_HabPop_rpt.jsp";

else if(reportVal=="29")
URL="./Secretary/rws_dist_pop_frm1.jsp";
else if(reportVal=="30")
URL="./reports/rws_waterqtly_sources_tests_frm.jsp";



var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function toggleDisplay(val)
{
	if(val==1)
	{
		var zURL="./reports/rws_bill_tobe_release_rpt_secy.jsp";
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		myWin = window.open(zURL,'expenditure',popFeatures);
		myWin.focus();
	}
	else if(val==2)
	{
		var zURL="./reports/rws_biil_release_program_rpt.jsp";
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		myWin1 = window.open(zURL,'expenditure1',popFeatures);
		myWin1.focus();
	}
	
}
</script>
 

<script type="text/javascript">
    //<![CDATA[
 
    var tabLinks = new Array();
    var contentDivs = new Array();
 
    function init() {

    	
    	document.forms[0].elements["finyear"].selectedIndex=0;
		getWorks();
      
    }
 
    function showTab() {}
 
    function getFirstChildWithTagName( element, tagName ) {
      for ( var i = 0; i < element.childNodes.length; i++ ) {
        if ( element.childNodes[i].nodeName == tagName ) return element.childNodes[i];
      }
    }
 
    function getHash( url ) {
      var hashPos = url.lastIndexOf ( '#' );
      return url.substring( hashPos + 1 );
    }
 
    //]]>
    </script>




</HEAD>
 

<body onload="checkCookie('<%=userid %>');init();releasesChart();openUserForm();" >
<center>
<form name="master">


 <div id="content" style="display:none" ><img src="images/loading1.gif" alt="Loading Wait..." title="Loading Wait..."></div>
 
<TABLE border=0 cellSpacing=0 cellPadding=0 width=1000 align=center>
  <TBODY>
  
  <TR>
    <TD>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=1100 align=center>
        <TBODY>
        <TR>
          <TD vAlign=top align=middle>
            <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
              <TBODY>
              <TR>
                <TD vAlign=top colSpan=2>
                  <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                    <TBODY>
					
                <TR bgcolor="white">
                     
						<td align="right" ><img src="<rws:context page='/images/rwss.gif' />" ></img> </td>
					<td width="580" valign="top" align="center" bordercolor="#FFFFFF">
					
					<iframe src="imagess/rural.swf " 
         frameborder="0" scrolling="no" name="myiframe"       width="550px" height="130px" >
  </iframe>
					</td>
					
           <td align="left" ><%-- <img src="<rws:context page='/images/JAWAHAR.jpg' />" width="150" height="130" > --%> 
           <img src="dashboards/image.jsp?imgID=SECRWSS" width="150" height="130">
           </td><td align="center">
           	
				<font   class="title1" align="left">Welcome&nbsp;to<br></font>
				<font color="#9400d3" size="1" face="verdana" align="left"><b>Shri. Jawahar  Reddy,IAS   <br/> Principal&nbsp;Secretary,&nbsp;RWS&S   </b> </font>
<br/><img src="<rws:context page='/images/aplogo.gif' />" ></img> </td>
</tr>
<tr bgcolor="white">
<td  colspan="4"  align="right"><A href="#" onclick="changePasswordWindow('Secretary/rws_sec_changepass_frm.jsp?special=N&userId=<%=userid %>')">[Change&nbsp;Password]&nbsp;</A><A href="/pred/Logout.do">[Logout]</A></td>

				</tr></table></td>


</TR>
</TBODY>
</TABLE>
</TD>
</TR>
</TBODY>
</TABLE>

                                
                               
<div id="tabs">
<ul>
      <li><a href="#home1">Home</a></li>
     <!--  <li><a href="#rfd">RFD</a></li> -->
     <li><a href="#alerts1">Alerts</a></li>
      <li><a href="#reports1">Data Sheet</a></li>
      <!-- <li><a href="#visulization1">Visulization</a></li> -->
       <li><a href="#mobileApp">SMS Mobile</a></li>
 <li><a href="#messaging1">Messaging</a></li>
 <li><a href="#review">Review</a></li>
 <li><a href="#theme">Themes</a></li>
    </ul>
 <div  id="home1">
  <table width="800" border="0" align="center">
                                           

<tr><td><a href="#" onclick="refreshData()"> Refresh Dashboard</a></td><td align="right" colspan="11"><span class="indigo10pixel">&nbsp;&nbsp;&nbsp;Financial Year</span>&nbsp;&nbsp;<span class="indigo10pixel"><select class="select" id="finyear" onchange="getWorks()"> 
<%                     

try{
Date sysdate = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy");
SimpleDateFormat format1 = new SimpleDateFormat("M");
String Year=format.format(sysdate);
String month=format1.format(sysdate);
//System.out.println("Current Year"+Year+"Month"+month);
String finYear="";
String temp="";
conn=nic.watersoft.commons.RwsOffices.getConn();
Statement stmt11=conn.createStatement();
int fy=0;int mm=0,cy=0,cy1=0;
int fy1=0;
		//String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4),substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
	 if(Integer.parseInt(month)>=04)
	{
		 cy=Integer.parseInt(Year);
		 cy1=cy+1;
		 while(cy>=2011)
		 {						
			 //System.out.println("cy-cy1"+cy+"-"+cy1);
	/* else if(Integer.parseInt(month)<4)
	{
		cy=Integer.parseInt(Year);
		cy1=cy-1;
	} */
		
		//String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)>=03 and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		//System.out.println("Fin"+ finquery);
		//ResultSet rs11 = stmt11.executeQuery( finquery);
		//while(rs11.next())
		//{
			
			//mm=Integer.parseInt(rs11.getString(2));
			// fy=Integer.parseInt(rs11.getString(1));
			// fy1=fy+1;
			//System.out.println("fy"+fy+"fy1"+fy1);
		/*  if(mm<4){
			  
				 fy=fy-1;
				 fy1=fy1-1;
			 } 
		 */
		 
//if(finYear!=null && !finYear.equals(""))
			//{
		 //temp=finYear.substring(0,4);
			//}
			//if(temp.equals(rs11.getString(1))){
%>
				 <option value="<%=cy+"-"+cy1%>" selected><%=cy+"-"+cy1%></option> 
<% 
cy=cy-1;
 cy1=cy+1; }//}else{%>
		<%-- <option value="<%=fy+"-"+fy1%>"><%=fy+"-"+fy1%></option>  --%>
<% }
	else if(Integer.parseInt(month)<4)
	{
		 cy=Integer.parseInt(Year)-1;//2016
		 cy1=cy+1;//2017
		 while(cy>=2011)
		 {
			
			
			 //System.out.println("cy-cy1"+cy+"-"+cy1);				 
%>				 
 <option value="<%=cy+"-"+cy1%>" selected><%=cy+"-"+cy1%></option> 
 <%	cy=cy-1;
 cy1=cy+1;  }%>
 <%}
		//}
		//}
					//if(rs11!=null)rs11.close();
					//if(stmt11!=null)stmt11.close();
	
}catch(Exception e){e.printStackTrace();}
%>



</select>


</span></td>



</tr>
   <tr >
                                              <td colspan="3"><div id="draggable" class="ui-widget-content">
<div id="resizable" class="ui-widget-content" style="width: 150px !important; height: 190px !important;">
	<h3 class="ui-widget-header">Habitations</h3>
<table style="width: 150px !important;">
<tr>
<td width="75" height=20 class=green>Mandals </td>
                                              <td width="75" class=text2>
                                                
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Mandals&type=01')">
                                                <div id="mandals" class="text2"></div></a></td>
</tr>
<tr>
 <td height=20 class=green>Panchayats</td>
                                              <td class=text2 id="div2">
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Panchayats&type=02')">
                                                <div id="panchayats" class="text2"></div></a>
                                             </td>
</tr>
<tr>
  <td height=20 class=green>Villages</td>
                                              <td class=text2 id="div3">
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Villages&type=03')"> 
                                                <div id="villages" class="text2"></div></a></td>
</tr>
<tr>
 <td height=20 class=green>Habitations</td>
                                              <td class=text2 id="div4">
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Habitations&type=04')">
                                                <div id="habs"  class="text2"></div></a>
                                              </td>
</tr>
</table>

</div>

</td>



<td colspan="3">

<div id="habcoverage" class="ui-widget-content" style="width: 180px !important; height: 190px !important;">
	<h3 class="ui-widget-header">Habitation Coverage</h3>
<table>
<tr>
<td  width="89" height=20  class=green >FC</td>
                                              <td width="101" class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationFC&type=05')"><div id="fc"  class="text2"></div></a>
                                              </td>
</tr>
<tr>
 <td height=20 class=green>PC4</td>
                                              <td class=text2 id="div3" >
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC4&type=06')">
                                                <div id="pc4" class="text2"></div></a>
                                              </td>
</tr>
<tr>
<td height=20 class=green>PC3</td>
                                              <td class=text2 id="div3">
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC3&type=07')">  <div id="pc3"  class="text2"></div></a>
                                              </td>
</tr>
<tr>
<td height=20 class=green>PC2</td>
                                              <td class=text2 id="div3">
 <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC2&type=08')">
                                                <div id="pc2" class="text2"></div>                   </a>                           </td>
</tr>
<tr>
  <td height=20 class=green>PC1</td>
                                              <td class=text2 id="div3">
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationPC1&type=09')">
                                                <div id="pc1" class="text2" ></div></a>
                                             </td>
</tr>
<tr>
  <td height=20 class=green>NSS</td>
                                              <td class=text2 id="div3">
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationNSS&type=10')">
                                                <div id="nss" class="text2" ></div></a>
                                              </td>
</tr>
<tr>    <td height=20 class=green>NC</td>
                                              <td class=text2 id="div3">
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HabitationNC&type=11')">   <div class="text2" id="nc" ></div></a>
                                             </td></tr>
</table>
</div></td>








<td colspan="3">

<div id="assets" class="ui-widget-content" style="width: 160px !important; height: 190px !important;">
	<h3 class="ui-widget-header">Assets</h3>
<table>
<tr> <td width="90" height=20 class=green>PWS</td>
                                              <td width="70" class=text2>
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=PWS&type=12')">
                                                <div id="pws" class="text2"></div></a>
                                            </td>
</tr>
<tr>
 <td height=20 class=green>MPWS</td>
                                              <td class=text2>
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=MPWS&type=13')">
                                                <div id="mpws"  class="text2"></div></a>
                                              </td>
</tr>
<tr>
 <td height=20 class=green>CPWS</td>
                                              <td class=text2>
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=CPWS&type=14')">
                                                <div id="cpws" class="text2" ></div></a>
                                              </td>
</tr>
<tr>
  <td height=20 class=green>Handpumps</td>
                                              <td class=text2>
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=HandPumps&type=15')">
                                                <div id="borewells"  class="text2"></div></a>
                                              </td>
</tr>

</table>
</div>


</td>
<td colspan="1">
<div id="resizable3" class="ui-widget-content" style="width: 200px !important; height: 190px !important;">
	<h3 class="ui-widget-header">Works</h3>
<table>
<tr><td></td><td><span class="indigo10pixel">&nbsp;&nbsp;PWS</span></td><td><span class="indigo10pixel">&nbsp;&nbsp;&nbsp;&nbsp;CPWS</span></td></tr>
<tr>
<td  width="80" height="20" class="green" onmouseover="Tip('Details',TITLE,'Information')" onmouseout="UnTip()" >Ongoing</td>
                                              <td width="60" class=text2>
                                                <a title="Click here view details" href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=OnGoing&type=01')"><div class=text2  id="ongoing"></div></a>
                                              </td>
 <td width="60" class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=OnGoing&type=03')"><div class=text2   id="ongoing1"></div></a>
                                              </td>
</tr>

<tr>
 <td height=20 class=green>Not Grounded</td>
                                              <td class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=NotGrounded&type=01')"><div class=text2   id="notground" ></div></a>
                                              </td>
  <td class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=NotGrounded&type=03')"><div class=text2  id="notground1" ></div></a>
                                              </td>

</tr>
<tr>
 <td height=20 class=green>Completed</td>
                                              <td class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Completed&type=01')"><div class=text2   id="completed" ></div></a>
</td>
<td class=text2>
                                                <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Completed&type=03')"><div class=text2  id="completed1" ></div></a></td>

</tr>
<tr>
<td height=20 class=green>Commissioned</td>
                                              <td class=text2>
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Commissioned&type=01')"> <div class=text2  id="commissioned" ></div></a>
                                              </td>
<td class=text2>
                                           <a href="#" onclick="viewReport('Secretary/rws_dashboard_works_abstract.jsp?name=Commissioned&type=03')">     <div class=text2  id="commissioned1" ></div> </a>
                                              </td>
 
</tr>
</table>
</div>
</td>
</tr>
<tr>
<td colspan="5">
<div id="wq" class="ui-widget-content" style="width: 200px !important; height: 190px !important;">
	<h3 class="ui-widget-header">Water Quality</h3>
<table>
											<tr><td width="110"  height=20 class=green>Total&nbsp;Labs </td>
                                              <td width="90" class=text2>
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Labs&type=16')"><div class=text2  id="labvalue" ></div></a>
                                              </td></tr>
                                              	<tr>
															<td width="110" height=20 class=green>Tot&nbsp;Sources&nbsp;Tested
															</td>
															<td width="90" class=text2> <a href="#"
																onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=TotSources&type=19')"><div class=text2 id="totsources"></div></a></td> 
														</tr>
										<tr><td width="110"  height=20 class=green>Physico&nbsp;Chemical </td>
                                              <td width="90" class=text2>
                                              <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=PhysicoChemical&type=17')"><div  class=text2  id="phys" ></div></a>
                                              </td></tr>
											<tr> <td height=20 class=green>Bacteriological</td>
                                              <td class=text2 >
                                               <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Bacteriological&type=18')"><div class=text2  id="bact" ></div></a>
                                              </td></tr>
                                              <tr>
															<td height=20 class=green>Flouride&nbsp;Contaminated</td>
															<td class=text2>
																 <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Flouride&type=20')"><div class=text2  id="flouride" ></div></a> 
															</td>
														</tr>
														<tr>
															<td height=20 class=green>Brakish&nbsp;Contaminated</td>
															<td class=text2>
															 <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Brakish&type=21')"><div class=text2  id="brakish" ></div></a>
															</td>
														</tr>
														<tr>
															<td height=20 class=green>Iron&nbsp;Contaminated</td>
															<td class=text2>
															 <a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Iron&type=22')"><div class=text2  id="iron" ></div></a>
																
															</td>
														</tr>
														<tr>
															<td height=20 class=green>Nitrate&nbsp;Contaminated</td>
															<td class=text2>
															<a href="#" onclick="viewReport('Secretary/rws_dashboard_habitationdirectory_abstract.jsp?name=Nitrate&type=23')"><div class=text2  id="nitrate" ></div></a>
																
															</td>															
														</tr>
</table>
</div>
</td>

</tr>   
                                         

<!-- <tr>
<td colspan=11>


<iframe src="./reports/works/rws_work_progress_abstract_list1.jsp?mode=initial" width="1050" height="600"></iframe>

</td>

</tr> -->
</table>

</div>


 <div  id="alerts1">
<table class="green" >
<tr>
<td>
<div id="resizable" class="ui-widget-content">
	<h3 class="ui-widget-header">Fund Accounting</h3>

<table class="green" >
<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_financial_bank_mpr_rpt.jsp')">Financial MPR -Bank  </a></td></tr>

<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_financial_pao_mpr_rpt.jsp')">Financial MPR -PAO  </a></td></tr>


</table>

</td>
<td>

<div id="resizable8" class="ui-widget-content">
	<h3 class="ui-widget-header">Works Monitoring</h3>
<table class="green" >
<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_compl_notcommenced_rpt.jsp')">Projects(MVS) Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcommisioned_rpt.jsp')">Projects(MVS) Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </a></td></tr>
<tr>
<td>3.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcompl_wrks_rpt.jsp')">Projects(MVS) Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>

<tr>
<td>4.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_compl_notcommenced_rpt.jsp')">SVS Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
<tr>
<td>5.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcommisioned_rpt.jsp')">SVS Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </a></td></tr>
<tr>
<td>6.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcompl_wrks_rpt.jsp')">SVS Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>
<tr>
<td>7.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works_not_comp.jsp?mode=san4')"> Work(s) Not completed - sanctioned > 4 year(s)/3 years/2 years ago  </a></td></tr>
<tr>
<td>8.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works_not_comp_ground.jsp?mode=ground4')"> Work(s) Not completed - Grounded > 4 year(s)/3 years/2 years ago  </a></td></tr>
<tr>
<td>9.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works__comp_not_comm.jsp')"> Work(s) completed - Not Commissioned  </a></td></tr>



</table>
</div>
</td>
</div>


<td>

<div id="resizable8" class="ui-widget-content" >
	<h3 class="ui-widget-header">Works Monitoring</h3>
<table class="green" >
<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_compl_notcommenced_rpt.jsp')">Projects(MVS) Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcommisioned_rpt.jsp')">Projects(MVS) Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </a></td></tr>
<tr>
<td>3.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcompl_wrks_rpt.jsp')">Projects(MVS) Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>

<tr>
<td>4.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_compl_notcommenced_rpt.jsp')">SVS Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
<tr>
<td>5.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcommisioned_rpt.jsp')">SVS Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </a></td></tr>
<tr>
<td>6.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcompl_wrks_rpt.jsp')">SVS Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>
<tr>
<td>7.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works_not_comp.jsp?mode=san4')"> Work(s) Not completed - sanctioned > 4 year(s)/3 years/2 years ago  </a></td></tr>
<tr>
<td>8.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works_not_comp_ground.jsp?mode=ground4')"> Work(s) Not completed - Grounded > 4 year(s)/3 years/2 years ago  </a></td></tr>
<tr>
<td>9.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works__comp_not_comm.jsp')"> Work(s) completed - Not Commissioned  </a></td></tr>


</table>
</div>
</td>
</tr>


</table>
</div>


<!-- <div  id="rfd">
<table class="green" >
<tr>
<td>

<div id="resizable6" class="ui-widget-content">
	<h3 class="ui-widget-header">RFD<img src="images/new.gif"> </h3>
<table class="green" >
<tr>

<td><b class="green">1.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_works_program_details_frm.jsp')">Abstract Works Spill Over/ New </a></td></tr>
<tr>
<td><b class="green">2.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_dpr_sec_StatusP_drill_frm.jsp')">Permission Pending Status </a></td></tr>

<tr>
<td><b class="green">3.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_dpr_fin_secpro_frm.jsp')">DPR Status Progress Report</a></td></tr>

<tr>
<td><b class="green">4.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_rfd_schools_rpt.jsp')">Coverage of Schools/Anganwadis with Drinking Water Facilities </a></td></tr>

<tr>
<td><b class="green">5.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_program_fin_notcompl_frm.jsp')">Physically completed and Financially not completed</a></td></tr>


<tr>
<td><b class="green">6.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_WQ_RFD_lab_frm.jsp')">Water Quality-Lab Abstract </a></td></tr>




<tr>
<td><b class="green">7.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_ftk_test_ftkuptomonth_sec_frm.jsp')">Water Quality-FTK Abstract </a></td></tr>

<tr>
<td><b class="green">8.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_rpt.jsp')">Scheme(MVS)-Hab Status </a></td></tr>

<tr>
<td><b class="green">9.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp')">Scheme(SVS)-Hab Status </a></td></tr>

<tr>
<td><b class="green">10.</b></td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Drought Works Status</a></td></tr>


<tr>
<td><b class="green">11.</b></td><td><a href="#" class="h4" onclick="viewWorks('./public_domain/rws_rfd_svs_target_ach_rpt.jsp')">SVS-CS Portal</a></td></tr>
<tr>
<td><b class="green">12.</b></td><td><a href="#" class="h4" onclick="viewWorks('./public_domain/rws_rfd_mvs_target_ach_rpt.jsp')">MVS-CS Portal</a></td></tr>

<tr>
<td><b class="green">15.</b></td><td><a href="#" class="h4" onclick="viewWorks('./public_domain/rws_rfd_sch_target_ach_rpt.jsp')">Schools-CS Portal</a></td></tr>
<tr>
<td><b class="green">16.</b></td><td><a href="#" class="h4" onclick="viewWorks('./public_domain/rws_rfd_anganavadi_target_ach_rpt.jsp')">Anganwadi-CS Portal</a></td></tr>


</table>
</div>
</td>

---------
<td>

<div id="accordion5">

     	<h3><a href="#">RFD-Weightage Reports <img src="images/new.gif"></a> </h3>
	<div>
	
	<table class="green">
	
	<tr>
	
	<div id="resizable6" class="ui-widget-content">
	<h3 class="ui-widget-header">RFD -Weightage Reports<img src="images/new.gif"> </h3>
<table class="green" >
<tr>	
<td><b class="green">&nbsp;&nbsp;1.</b></td><td>
<a href="./public_domain/rws_rfd_phy_fin_weihtage_Frm.jsp" target="_self">Schemes - (Physical & Financial) </a></td></tr>

<tr>	
<td><b class="green">&nbsp;&nbsp;2.</b></td><td>
<a href="./public_domain/rws_rfd_dpr_preparation_weihtage_rpt.jsp" target="_self">Preparation of DPRs</a></td></tr>
	<tr>
	<td><b class="green">&nbsp;&nbsp;3.</b></td><td><a href="./public_domain/rws_rfd_dpr_permissions_pending_weightage_rpt.jsp" target="_self">Permissions Pending </a></td>
	</tr>
	<tr>
	<td><b class="green">&nbsp;&nbsp;4.</b></td><td><a href="./public_domain/rws_rfd_sustainbility_works_weihtage_rpt.jsp" target="_self">Sustainability Structures</a></td>
	</tr>
	<tr>
	<td><b class="green">&nbsp;&nbsp;5.</b></td><td><a href="./public_domain/rws_rfd_sch_anganwadi_weihtage_rpt.jsp" target="_self">Drinking Water Facilities to Schools & Anganwadies</a></td>
		</tr>
		<tr>
	<td><b class="green">&nbsp;&nbsp;6.</b></td><td><a href="./public_domain/rws_rfd_WQ_lab_ftk_weightage_rpt.jsp" target="_self">WQ Lab & FTK</a>
	</td></tr>
	
		<tr>
	<td><b class="green">&nbsp;&nbsp;7.</b></td><td><a href="./reports/rws_dpr_work_duration_frm.jsp" target="_self">DPR Works Duration</a>
	</td></tr>
	
	<tr>
	<td><b class="green">&nbsp;&nbsp;8.</b></td><td><a href="./public_domain/rws_rfd_dpr_schemeshanding_to_gps_rpt.jsp" target="_self">Scheme Handing Over to Gp's</a>
	</td></tr>
	
	<tr>
	<td><b class="green">&nbsp;&nbsp;9.</b></td><td><a href="./public_domain/Rws_Rfd_Trainings_rpt.jsp" target="_self">WQ Training</a>
	</td></tr>
	
	
			</table>
	</div>

</td>

---------
</tr>


</table>
</div> -->




<div  id="reports1">
     <table border=0 cellSpacing=0 cellPadding=0   width="100%" >

<td>

<div id="resizable8" class="ui-widget-content">
	<h3 class="ui-widget-header">Reports</h3>



<div id="accordion2">

     	<h3><a href="#">Habitations</a></h3>
	<div>
<table class="green" >

<tr>
<td><b class="green">1.</b></td><td><a href="./reports/rws_habitation_abstract_rpt.jsp" target="_self" class="h4">Status - Abstract Report  </a></td></tr>


<tr>
<td><b class="green">2.</b></td><td><a href="./reports/rws_hab_status_resource_rpt.jsp" target="_self" class="h4">Resources At a Glance </a></td>
</tr>
	<!-- <tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('28')">LPCD range wise Habitations </a></span></td>
</tr>


<tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('29')">Coverage Status of SC & ST Habitations </a></span></td>
</tr>


<tr><td><b class="green">3.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('6')">Constituency Status</a></span></td>
</tr>
<tr><td><b class="green">4.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('7')">Resources At a Glance</a></span></td>
</tr>
<tr><td><b class="green">5.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('10')">Slipped back details</a></span></td>
</tr>
<tr><td><b class="green">6.</b></td>
 
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('8')">Gram Panchayat Asset Coverage</a></span></td>
</tr>
<tr>
 <td><b class="green">7.</b></td>
      <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('9')">Gram Panchayat Coverage Status</a></span></td>
</tr>
<tr><td><b class="green">8.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('22')">Population-Category</a></span></td>
</tr>	 -->
		
		</table>
	</div>
	<h3><a href="#">Works</a></h3>
	<div>
	<table class="green" >
	
	<!-- <tr>	
<td><b class="green">1.</b></td><td>
<a href="./reports/rws_sc_st_subplan_frm.jsp" target="_self">SC/ST Sub Plan </a><img src="images/new.gif"> </td></tr>

<tr>	
<td><b class="green">2.</b></td><td>
<a href="./reports/rws_sc_st_subplan_abstract_frm.jsp" target="_self">SC/ST Sub Plan -Abstract </a><img src="images/new.gif"> </td></tr>
	
	<tr><td><b class="green">3.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('14')">Works Abstract</a></span></td>
</tr>
<tr><td><b class="green">4.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('26')">Status Work Progress Report(Gap Report)</a></span></td>
</tr> -->
<tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('27')">General Abstract Report-Revised </a></span></td>
</tr>

  <!--    <tr>
<td><b class="green">6.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/rws_programe_milestone_district-frm.jsp')">Works-Milestones Details</a></td></tr>

<tr>
<td><b class="green">7.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/rws_not_forward_bill_rpt.jsp')">Pending Bills</a></td></tr>
<tr>
<td><b class="green">8.</b></td><td>
       <a href="switch.do?prefix=/works&page=/workDetails.do?mode=initReport"  ><b class="green"></b>Work History </a> <img src="images/new.gif"> </td>
</tr>
<tr>
<td><b class="green">9.</b></td><td>
		<a href="./reports/rws_Pending_works_rpt.jsp" target="_self"><br>Pending WorksMonitoring Report </a>
	    </td></tr> -->

<tr>	
		<td><b class="green">2.</b></td><td><a href="./reports/rws_ongoing_works_abs_frm.jsp" target="_self">Ongoing Works Progress(Abstract)</a> 
		</td>
		</tr>
		
		<tr>
	<td><b class="green">3.</b></td><td><a href="./public_domain/rws_rfd_WQ_lab_ftk_weightage_rpt.jsp" target="_self">WQ Lab & FTK</a>
	</td></tr>
	
	<tr>	
<td><b class="green">4.</b></td><td>
<a href="./public_domain/rws_rfd_phy_fin_target_Frm.jsp" target="_self">Schemes -(Physical & Financial) New(02/09/2015)</a></td></tr>

<tr>
	<td>
		<b class="green">5.</b></td><td><a href="./reports/rws_Pending_works_rpt.jsp" target="_self">Pending WorksMonitoring Report </a>
	</td>
</tr> 

</table>	
		<br>
	
	</p>
	</div>
	
	
	
	
	
	<h3><a href="#">Assets</a></h3>
	<div>
	<table class="green" >
	
	<tr>
	<td><b class="green">1.</b></td><td><a href="./reports/rws_cpws_pws_cov_ass_frm.jsp" target="_self" class="h4">Assets Priority Report  </a></td>
	</tr>
	
	<tr>
	<td><b class="green">2.</b></td><td><a href="./reports/rws_AssetAbstract_report.jsp" target="_self" class="h4">Abstract Report</a></td>
	</tr>
	
	<!-- <tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('12')">Assets-Sources</a></span></td>
</tr>
<tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('13')">Assets Abstract</a></span></td>
</tr>
<tr>
<td><b class="green">3.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_rpt.jsp')">Assets(MVS)-Hab Status</a></td></tr>

<tr>
<td><b class="green">4.</b></td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp')">Assets(SVS)-Hab Status</a></td></tr>
 -->
		</table>
	</div>
	
	<h3><a href="#">Water Quality</a></h3>
	<div>
	<table class="green" >
	<!-- <tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('20')">Habitation VS Water Quality(Flouride,Salinity)</a></span></td>
</tr>
    <tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('21')">Entry Status</a></span></td>
</tr>
    <tr><td><b class="green">3.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"   class="h4" onClick="fnCall('24')">District Profile For Quality Parameters</a></span></td>
 -->
<tr>
	      
<td><b class="green">1.</b></td><td>
	
	<a href="./reports/rws_lab_test_frm.jsp" target="_self" class="h4">Lab Test Results</a>
	</td></tr>
	<tr>
	      
<td><b class="green">2.</b></td><td>
	<a href="./reports/rws_ftk_test_result_frm.jsp" target="_self" class="h4">Ftk Test Results</a>
	</td></tr><tr>
 <tr><td><b class="green">3.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4"  onClick="fnCall('30')">Abstract- Sources Vs All Tests</a></span></td>
</tr> 
 <!-- <tr><td><b class="green">5.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4"  onClick="fnCall('25')">Habitation Coverage By Test Results(Priority Based)</a></span></td>
</tr>  -->



  <tr>


       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick=""></a></span></td>
</tr>

		</table>
	</div>
	

<td >
<div id="resizable8" class="ui-widget-content">
	<h3 class="ui-widget-header">Master Reports</h3>
<div id="accordion1">


<h3><a href="#">Fund Accounting</a></h3>
	<div>
	<table class="green" >
	   <!--  <tr ><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onClick="fnCall('1')">Financial Achievement</a></span></td>
</tr> -->
<tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onClick="fnCall('2')">Division wise Releases Vs Expenditure</a></span></td>
</tr>
<tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onClick="fnCall('3')">Programme wise Releases Vs Expenditure</a></span></td>
</tr>

<!-- <tr><td><b class="green">4.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onclick="viewWorks('reports/rws_Exp_Rel_Pro_groupsec_frm.jsp')">ProgrammeWise(NRDWP) Rel VS Exp</a></span></td>
</tr>

<tr><td><b class="green">5.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onClick="fnCall('4')">Bank-PAO Releases</a></span></td>
</tr>
<tr><td><b class="green">6.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="#"  class="h4" onClick="fnCall('4')">Central/State Bills Audit</a></span></td>
</tr> -->


</div>

</td>






</table></div>


<h3><a href="#">Schools</a></h3>
	<div>
	<table class="green" >
	<tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##" class="h4"  onClick="fnCall('11')">Schools Abstract</a></span></td>
</tr>

<tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="./public_domain/rws_rfd_sch_anganwadi_weihtage_rpt.jsp" target="_self">Drinking Water Facilities to Schools & Anganwadies</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>

		</table>
	</div>


<h3><a href="#">Drought</a></h3>
	<div>
	<table class="green" >
	
	<tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('16')">Abstract Flushing/Deepnening</a></span></td>
</tr>
	
	<tr>
	      
<td><b class="green">2.</b></td><td>
	<a href="./reports/rws_news_paper_clippings_frm.jsp" target="_self" class="h4">News Paper Clippings</a>
	</td></tr>
	
	
	<tr>
	      
<td><b class="green">3.</b></td><td>
<a href="./reports/rws_sstank_consolidated_rpt.jsp" target="_self" class="h4">SS Tank- Consolidated</a>
		
		</td></tr>
		
		<tr>
	      
<td><b class="green">4.</b></td><td>
<a href="./reports/rws_drought_drinking_water_situation_frm.jsp" target="_self" class="h4">Abstract of Daily Report on Drinking Water Situation ( Drought )</a>
			</td></tr><tr>
			
			
			<tr>
	      
<td><b class="green">5.</b></td><td>
<a href="./reports/rws_drought_contigencyplan_habs_frm.jsp" target="_self" class="h4">Contigency Plan Abstract Report(NEW)</a>
		
		</td></tr>	
		
		
	
	<!--  <tr><td><b class="green">1.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('15')">Contingency Abstract</a></span></td>
</tr>


<tr><td><b class="green">2.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('16')">Abstract Flushing/Deepnening</a></span></td>
</tr>
<tr><td><b class="green">3.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('17')">Abstract Hiring/Trans/Power</a></span></td>
</tr>
<tr><td><b class="green">4.</b></td>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('18')">Daily Report</a></span></td>
</tr>
 -->

		</table>
</div>
</td>
</tr>


</table>
</div>


<div  id="mobileApp">
	<table class="green" >
		<tr>
			<td>
				<div id="resizable" class="ui-widget-content">
					<h3 class="ui-widget-header">SMS Related Reports</h3>
					<table class="green" >
						<tr>
							<td><b class="green">&nbsp;&nbsp;1.</b></td><td><a href="./reports/smsmobile/rws_residual_act_tkn_status_report.jsp?mode=initial" target="_self" class="h4">SMS Based - Report</a></td>
						</tr>
						 <tr>
							<td><b class="green">&nbsp;&nbsp;2.</b></td><td><a href="./reports/smsmobile/rws_pull_push_report.jsp?mode=initial" target="_self" class="h4">PULL & PUSH Details Report</a></td>
						 </tr>
						 <tr>
					     <td><b class="green">&nbsp;&nbsp;3.</b></td><td><a	href="./reports/smsmobile/rws_tanker_movement_rpt.jsp?mode=initial"	target="_self" class="h4">Tanker Movement - Detailed Report</a></td>
					     </tr>

						<tr>
							<td><b class="green">&nbsp;&nbsp;4.</b></td><td><a href="./downloads/mobile/WaterTankerMovement.apk" class="h4" >Download Tanker Movement Mobile App</a><img src="images/new.gif"></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
</div>

<div  id="review">
	<table class="green" >
		<tr>
			<td>
				<div id="resizable8" class="ui-widget-content">
					<h3 class="ui-widget-header">Reports</h3>
					<table class="green" >
						<tr>
							<td><b class="green">&nbsp;&nbsp;1.</b></td><td><a href="./reports/rws_dist_status_cm_rpt1.jsp" target="_blank" class="h4">Habitation Coverage Status</a></td>
						</tr>
						 <tr>
							<td><b class="green">&nbsp;&nbsp;2.</b></td><td><a href="./reports/rws_AssetAbstract_cm_report1.jsp" target="_blank" class="h4">Asset Abstract</a></td>
						 </tr>
						 <tr>
							<td><b class="green">&nbsp;&nbsp;3.</b></td><td><a	href="./reports/rws_ongoing_works_abs_cm_rpt.jsp"	target="_blank" class="h4">Work Progress - District Wise</a></td>
						 </tr>
						 <!--tr>
							<td><b class="green">&nbsp;&nbsp;4.</b></td><td><a	href="./reports/works/rws_work_progress_abstract_rpt1.jsp"	target="_self" class="h4">Program Wise Work Progress</a></td>
						 </tr-->
						  <tr>
							<td><b class="green">&nbsp;&nbsp;4.</b></td><td><a	href="./reports/works/rws_work_progress_abstract_list1.jsp?mode=initial"	target="_blank" class="h4">Program Wise Work Progress</a></td>
						 </tr>
						 <tr>
							<td><b class="green">&nbsp;&nbsp;5.</b></td><td><a	href="./reports/rws_habs_covered_cm_rpt.jsp"	target="_blank" class="h4">Program Wise Physical Cov. of Habs and Financial Achievements</a></td>
						 </tr> 


					</table>
				</div>
			</td>
		</tr>
	</table>
</div>




            
 <div  id="theme">
<table class="green" >
<tr>
<td>
<div id="resizable3" class="ui-widget-content">
	<h3 class="ui-widget-header">Themes</h3>
<br><br>
<br>
    <table class="green" >
<tr></tr>
<tr><td><img src="images/admin2.jpg" width="100" height="60" onclick="change(1)"></td>
<td><img src="images/eebg1.jpg"  width="100" height="60" onclick="change(2)" ></td>
<td><img src="images/custom.jpg" width="100" height="60" onclick="change(4)"></td></tr>
</table>

</td>
</div>
 
</tr>


</table>
</div>

    










<div  id="messaging1">
<table cellpadding="5" border="0"  rules="none" style="border-collapse:collapse" align="center" >
	<tbody  >
	<tr>
		<td><font face=Verdana  color="#F58F00" size="2"><b>From:</b><font color="red">*</font></td>
		<td align="left"><font face=Verdana  size="3"><input class="modeltextbox" type="text"  name="userId"  value=<%=userid %>   readonly="true"/></font></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana color="#F58F00"  size="2"><b>To:</b></font><font color="red">*</font></td>
		<td><input type="checkbox" name="to" value="HO"  />Head Office
<input type="checkbox" name="to" value="CO" checked /> Circle Office <input type="checkbox" name="to" value="DO" />Division Office 
<input type="checkbox" name="to" value="SO"  /> Sub Division Office </td>
	</tr>
	<tr>
		<td nowrap  ><font face=Verdana color="#F58F00"  size="2" ><b>Message:</b></font><font color="red">*</font></td>
		<td><textarea id="message" class="ta5" rows="6" cols="56"></textarea></td>
	</tr>
	<tr>
		<td nowrap><font face=Verdana  color="#F58F00"  size="2"><b>Priority:</b><font color="red">*</font></td>
		<td><input type="radio" name="priority" id="priority1" value="1" checked> High
<input type="radio" name="priority" value="2" id="priority2"> Medium
<input type="radio" name="priority" value="3" id="priority3"> Low</td>
	</tr>
	<tr>
		<td align="center" colspan="2">
			<input type="button" class="fb5" name="Save" value="Send" onclick="messageSend()">  
			<input type="button" class="fb5" name="Reset" value="Reset" onclick="fnReset()">
		</td>
	</tr>
	</tbody>
	
	
	
	</table>	


</div>

</div>
    
                    

</TD></TR>

<TR class="footerrow">
      <TD  vAlign=top  align=middle><div align="center">
                                    <p>&nbsp;</p>
                                    <p><b><font class="footer">Designed &amp; Developed by National Informatics Centre, AP State Centre</font></b></p>
                                  </div></TD>
                                </TR>


</TBODY></TABLE>

</form>
</center>
</body></HTML>
<%}
catch(Exception e)
{
                            System.out.println("error:"+e.getMessage());}
finally
{
 try{
	if(rs1!=null)rs1.close();
	if(st1!=null)st1.close();
	if(conn!=null)conn.close();
}catch(Exception e)
{
        e.printStackTrace();
}
}
%>

