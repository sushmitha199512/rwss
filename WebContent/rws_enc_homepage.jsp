 

<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
System.out.println(users);
String userid = users.getUserId();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/Secretary/rws_cov_hab_status_graph.jsp" %>
<%@ include file="/Secretary/rws_asset_types_graph.jsp" %>
<%@ include file="/Secretary/rws_hab_coverage_status_grph.jsp" %>


<%




ResultSet rs1 = null;
Statement st1 = null;
try
{
String fyear="";
if(request.getParameter("finyear")!=null){

    fyear=request.getParameter("finyear");
    session.setAttribute("financialyr",fyear);
    } else{
    fyear=(String)session.getAttribute("financialyr");
    }
      

    java.util.Date currentDate=new java.util.Date();
             int f1=currentDate.getYear();
 			f1+=1900;
            int f2=f1+1;
          String finYear1=f1+"-"+f2;
 	st1 = conn.createStatement();
	String q1 = "select * from rws_secretary_details_tbl";
	//rs1 = st1.executeQuery(q1);
	//rs1.next();
%>


<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>Welcome to Watersoft</TITLE>
<META content="text/html; charset=iso-8859-15" http-equiv=Content-Type>

<style media="all" type="text/css">
#div1 { position: absolute; bottom: 0; right: 0; z-index: 1; }
.cornerBox {  border: 2px solid #999; padding: 5px 10px; color: #333;}
.cornerBox p { margin: 0; }
A:link{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:visited{font-family:verdana;font-size:8pt;text-decoration:none;color:#316A95}
A:hover{font-family:verdana;font-size:8pt;text-decoration:underline;color:#316A95}
.noborder-text-box
{
	border: 0;
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	LETTER-SPACING: 1px;
	COLOR: #0000ff;
	FONT-SIZE: 11px;
	FONT-WEIGHT: bold;	
	width:95px;
}


fieldset {position:relative;
height:50; 
}
legend { /* Text and background colour, blue on light gray */
color:#00f;

}


</STYLE>


<script language="JavaScript" src="/pred/resources/javascript/jquery-1.4.2.js"></script>
<LINK rel=stylesheet type=text/css href="imagess/style.css">

<style type="text/css">
<!--
.style1 {
	color: #0000FF;
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
.green{
color : #F58F00;
font-weight :bold;
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
	left: 500px;
	top: 350px;
}
-->
</style>
<style>
/*position and hide the menu initially - leave room for the menu to expand...*/
#description {margin-left:150px; width:510px;}
#page {padding:20px 0; width:100%;}
#menu {position:absolute; top:490px; left:8px; display:none;}
/*dock styling...*/
/*...set the cursor...*/
#menu div.jqDock {cursor:pointer;}
/*label styling...*/
div.jqDockLabel {padding-bottom:8px; font-size:12px; font-family:verdana; font-weight:bold; white-space:nowrap; color:blue; cursor:pointer;}
</style>
<script language="JavaScript" src="/pred/imagess/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/pred/imagess/jquery.jqDock.min.js"></script>
<link href="/pred/resources/style/dockstyle.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/pred/resources/javascript/jscharts.js"></script>


<style>
	#resizable, #resizable2 { width: 200px; height: 150px; padding: 0.5em; }
#resizable3 { width: 500px; height: 150px; padding: 0.5em; }
#resizable4 { width: 300px; height: 150px; padding: 0.5em; }
#resizable5 { width: 200px; height: 200px; padding: 0.5em; }
#resizable6 { width: 500px; height: 250px; padding: 0.5em; }

	#resizable h3, #resizable2 h3 { text-align: center; margin: 0; }
	#resizable3 h3, #resizable4 h3 { text-align: center; margin: 0; color:"lightgreen" }
#resizable5 h3, #resizable4 h3 { text-align: center; margin: 0; }
#resizable6 h3, #resizable6 h3 { text-align: center; margin: 0; }
	</style>
	<script>
	$(function() {

$("#set1 a").tooltip({
	bodyHandler: function() {
		return $($(this).attr("href")).html();
	},
	showURL: false
});
$('#set1 *').tooltip();
		$( "#resizable" ).resizable({
			delay: 1000
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
	<link rel="stylesheet" href="/pred/resources/style/jquery.ui.resizable.css">
<link rel="stylesheet" href="/pred/resources/style/example.css" type="text/css">
<link rel="stylesheet" href="/pred/resources/style/dropkick.css" type="text/css">




<script src="/pred/resources/javascript/jquery.ui.mouse.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.resizable.js"></script>
		
<script>
	$(function() {
		$( "#tabs" ).tabs({
    
			event: "mouseover"
		});




// Dialog
				$('#dialog').dialog({
					autoOpen: false,
					width: 600,
					buttons: {
						"Ok": function() {
							$(this).dialog("close");
						},
						"Cancel": function() {
							$(this).dialog("close");
						}
					}
				});

				// Dialog Link
				$('#dialog_link').click(function(){
					$('#dialog').dialog('open');
					return false;
				});
	});
	</script>






<script language="javascript">

function date_time(id)
{
        date = new Date;
        year = date.getFullYear();
        month = date.getMonth();
        months = new Array('January', 'February', 'March', 'April', 'May', 'June', 'Jully', 'August', 'September', 'October', 'November', 'December');
        d = date.getDate();
        day = date.getDay();
        days = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
        h = date.getHours();
        if(h<10)
        {
                h = "0"+h;
        }
        m = date.getMinutes();
        if(m<10)
        {
                m = "0"+m;
        }
        s = date.getSeconds();
        if(s<10)
        {
                s = "0"+s;
        }
        result = ''+days[day]+' '+months[month]+' '+d+' '+year+' '+h+':'+m+':'+s;
        document.getElementById(id).innerHTML = result;
        setTimeout('date_time("'+id+'");','1000');
        return true;
}
function pieChartExample(){   
//Create pie chart   
var chartType=document.getElementById('chartType').value;
var graphBetween=document.getElementById('graphName').value;

if(chartType!=""){
//var colors = ['#6b8e23', '#d2b48c', '#f5f5dc', '#0000cd', '#8b8878'];
var myChart = new JSChart('chartid', chartType);


if(graphBetween=="1")
{
	myChart.setTitle('Borewell Status Graph  -  <%= finYear1%>');
	myChart.setTitleColor('#9acd32');
    myChart.setAxisNameX('Working Status');
	myChart.setAxisNameY('Total');
myChart.setSize(700, 340);

var colors = ['#FA5E1F', '#FDCB3F', '#71D743', '#D23333', '#BAE73F'];
var myData = new Array(['<%=dist[0] %>', <%=data[0] %>], ['<%=dist[1] %>', <%=data[1] %>],['<%=dist[2] %>', <%=data[2] %>],['<%=dist[3] %>', <%=data[3] %>],['<%=dist[4] %>', <%=data[4] %>] );
}else if(graphBetween=="2"){
var myData = new Array(['<%=assetNames[0] %>', <%=assetCount[0] %>], ['<%=assetNames[1] %>', <%=assetCount[1] %>],['<%=assetNames[2] %>', <%=assetCount[2] %>],['<%=assetNames[3] %>', <%=assetCount[3] %>],['<%=assetNames[4] %>', <%=assetCount[4] %>],['<%=assetNames[5] %>', <%=assetCount[5] %>],['<%=assetNames[6] %>', <%=assetCount[6] %>],['<%=assetNames[7] %>', <%=assetCount[7] %>] );
var colors = ['#FA5E1F', '#FDCB3F', '#71D743', '#D23333', '#BAE73F','#FDCB3F','#00ffff', '#71D743'];
myChart.setTitle('As on Assets');
	myChart.setTitleColor('#9acd32');
    myChart.setAxisNameX('Asset Names');
	myChart.setAxisNameY('Total');
myChart.setSize(750, 340);
}else if(graphBetween=="3"){
var myData = new Array(['<%=covNames[0] %>', <%=habCount[0] %>], ['<%=covNames[1] %>', <%=habCount[1] %>],['<%=covNames[2] %>', <%=habCount[2] %>],['<%=covNames[3] %>', <%=habCount[3] %>],['<%=covNames[4] %>', <%=habCount[4] %>],['<%=covNames[5] %>', <%=habCount[5] %>],['<%=covNames[6] %>', <%=habCount[6] %>] );
var colors = ['#FA5E1F', '#FDCB3F', '#71D743', '#D23333', '#BAE73F','#FDCB3F','#00ffff'];
myChart.setTitle('Habitation Coverage Status -  <%= finYear1%>');
	myChart.setTitleColor('#9acd32');
    myChart.setAxisNameX('Coverage');
	myChart.setAxisNameY('Hab Count');
myChart.setSize(850, 340);
}


myChart.setDataArray(myData);
  if(chartType=="pie"){
	myChart.colorizePie(colors);
    myChart.setPiePosition(308, 170);
	myChart.setPiePosition(350, 170);
	myChart.setPieRadius(95);
	myChart.setPieUnitsFontSize(10);
	myChart.setPieUnitsColor('#0000ff');
	myChart.setPieValuesColor('#0000ff');
	myChart.setPieValuesOffset(-15);
}
else if(chartType=="Line")
{

//	myChart.setAxisValuesNumberX(5);
	//myChart.setAxisValuesNumberY(5);
//	myChart.setAxisValuesColor('#38a4d9');
	myChart.setAxisColor('#38a4d9');
	myChart.setLineColor('#C71112');
	myChart.setGraphExtend(true);
	myChart.setGridColor('#38a4d9');

myChart.setTitleFontSize(11);
	myChart.setAxisNameX('');
	myChart.setAxisNameY('');
	myChart.setAxisColor('#8420CA');
	myChart.setAxisValuesColor('#949494');
	myChart.setAxisPaddingLeft(100);
	myChart.setAxisPaddingRight(120);
	myChart.setAxisPaddingTop(50);
	myChart.setAxisPaddingBottom(40);
	myChart.setAxisValuesDecimals(3);
	myChart.setAxisValuesNumberX(10);
	myChart.setShowXValues(false);
	
	myChart.setFlagColor('#9D12FD');
	myChart.setFlagRadius(4);
if(graphBetween=="2"){
myChart.setTooltip(['<%=assetNames[0] %>', 'Total:<%=assetCount[0]%>']);
myChart.setTooltip(['<%=assetNames[1] %>', 'Total:<%=assetCount[1]%>']);
myChart.setTooltip(['<%=assetNames[2] %>', 'Total:<%=assetCount[2]%>']);
myChart.setTooltip(['<%=assetNames[3] %>', 'Total:<%=assetCount[3]%>']);
myChart.setTooltip(['<%=assetNames[4] %>', 'Total:<%=assetCount[4]%>']);
myChart.setTooltip(['<%=assetNames[5] %>', 'Total:<%=assetCount[5]%>']);
myChart.setTooltip(['<%=assetNames[6] %>', 'Total:<%=assetCount[6]%>']);
myChart.setTooltip(['<%=assetNames[7] %>', 'Total:<%=assetCount[7]%>']);

myChart.setLabelY(['<%=assetNames[0] %>',  '<%=assetNames[0]%>']);
myChart.setLabelY(['<%=assetNames[1] %>',  '<%=assetNames[1]%>']);
myChart.setLabelY(['<%=assetNames[2] %>',  '<%=assetNames[2]%>']);
myChart.setLabelY(['<%=assetNames[3] %>',  '<%=assetNames[3]%>']);
myChart.setLabelY(['<%=assetNames[4] %>',  '<%=assetNames[4]%>']);
myChart.setLabelY(['<%=assetNames[5] %>',  '<%=assetNames[5]%>']);
myChart.setLabelY(['<%=assetNames[6] %>',  '<%=assetNames[6]%>']);
myChart.setLabelY(['<%=assetNames[7] %>',  '<%=assetNames[7]%>']);

}else if(graphBetween=="1")
{
  myChart.setTooltip(['<%=dist[0] %>', 'Total:<%=data[0]%>']);
myChart.setTooltip(['<%=dist[1] %>', 'Total:<%=data[1]%>']);
myChart.setTooltip(['<%=dist[2] %>', 'Total:<%=data[2]%>']);
myChart.setTooltip(['<%=dist[3] %>', 'Total:<%=data[3]%>']);
myChart.setTooltip(['<%=dist[4] %>', 'Total:<%=data[4]%>']);

myChart.setLabelY(['<%=dist[0] %>',  '<%=dist[0]%>']);
myChart.setLabelY(['<%=dist[1]%>',  '<%=dist[1]%>']);
myChart.setLabelY(['<%=dist[2]%>',  '<%=dist[2]%>']);
myChart.setLabelY(['<%=dist[3]%>',  '<%=dist[3]%>']);
myChart.setLabelY(['<%=dist[4]%>',  '<%=dist[4]%>']);
}else if(graphBetween=="3")
{
  myChart.setTooltip(['<%=covNames[0] %>', 'Total:<%=habCount[0]%>']);
myChart.setTooltip(['<%=covNames[1] %>', 'Total:<%=habCount[1]%>']);
myChart.setTooltip(['<%=covNames[2] %>', 'Total:<%=habCount[2]%>']);
myChart.setTooltip(['<%=covNames[3] %>', 'Total:<%=habCount[3]%>']);
myChart.setTooltip(['<%=covNames[4] %>', 'Total:<%=habCount[4]%>']);
myChart.setTooltip(['<%=covNames[5] %>', 'Total:<%=habCount[5]%>']);
myChart.setTooltip(['<%=covNames[6] %>', 'Total:<%=habCount[6]%>']);


myChart.setLabelY(['<%=habCount[0] %>',  '<%=habCount[0]%>']);
myChart.setLabelY(['<%=habCount[1]%>',  '<%=habCount[1]%>']);
myChart.setLabelY(['<%=habCount[2]%>',  '<%=habCount[2]%>']);
myChart.setLabelY(['<%=habCount[3]%>',  '<%=habCount[3]%>']);
myChart.setLabelY(['<%=habCount[4]%>',  '<%=habCount[4]%>']);
}


	myChart.setSize(616, 321);

}else if(chartType=="bar")
{
	myChart.setBarSpacingRatio(50);
	myChart.setTitleFontSize(11);
	myChart.setBarBorderWidth(0);
	myChart.setAxisPaddingTop(50);
	myChart.setAxisPaddingBottom(40);
	myChart.setAxisPaddingLeft(75);
	myChart.setTitleFontSize(11);
	myChart.setBarBorderWidth(0);
	myChart.colorizeBars(colors);
}
	myChart.setAxisNameFontSize(16);

	//myChart.setBackgroundImage('path/background.jpg');
	myChart.draw();
}else{
 alert("Select Chart Type");
}

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
	var finyear=document.getElementById("finyear").value;
	

if(finyear==null){
finyear="2012-2013";}
//document.getElementById("hh").innerHTML="("+finyear+")";
//document.getElementById("wq").innerHTML="("+finyear+")";

var URL="FinancialYearWorks.jsp?finyear="+finyear;
  	ajaxFunction_Works(URL);

}
	function submitComplaint()
	{
		var userid = '<%=userid%>';
		var urlnew = "works/feedbackSecy.jsp?userid="+userid;
		//alert(urlnew);
		window.open(urlnew,"feedBackPage","width=500,height=400,scrollbars=yes,copyhistory=no,resizable=yes,status=yes");
	}

jQuery(document).ready(function($){
  // set up the options to be used for jqDock...
  var dockOptions =
    { align: 'center' // vertical menu, with expansion LEFT/RIGHT from the center
    , labels: 'br'  // add labels (override the 'tl' default)
    , inactivity: 4000 // set inactivity timeout to 4 seconds
    };
  // ...and apply...
  $('#menu').jqDock(dockOptions);
});
$(document).ready(function(){
$("#btnLoad").click(function(event){
//alert("Get Data","Alert Dialog");
var url = "SecyHomeUpdated.jsp";
ajaxFunction(url);
});
});



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
      
               //TODO
		}
	
     // document.getElementById('content').style.display='none';
	  }
	  else{
  
		  //document.getElementById('content').style.display='block';
	

//alert("failed");
		// document.getElementById('content').style.display='block';
	  }
	}

	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}
function fnReset(){

document.getElementById("message").value="";
}

function ajaxFunction_Works(URL)
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
   
			var mytool_array=resp.split("/");
			document.forms[0].ongoing.value = mytool_array[0];
			document.forms[0].ongoing1.value = mytool_array[1];
			
			document.forms[0].notground.value = mytool_array[2];
			document.forms[0].notground1.value = mytool_array[3];

			document.forms[0].completed.value = mytool_array[4];
			document.forms[0].completed1.value = mytool_array[5];
			
			document.forms[0].commissioned.value = mytool_array[6];
			document.forms[0].commissioned1.value = mytool_array[7];
			document.forms[0].phys.value = mytool_array[8];	
			document.forms[0].bact.value = mytool_array[9];
			document.forms[0].mandals.value = mytool_array[10];
			document.forms[0].panchayats.value = mytool_array[11];
			document.forms[0].villages.value = mytool_array[12];
			document.forms[0].habs.value = mytool_array[13];
			document.forms[0].pws.value = mytool_array[14];
			document.forms[0].mpws.value = mytool_array[15];
			document.forms[0].cpws.value = mytool_array[16];
			document.forms[0].borewells.value = mytool_array[17];



			
			document.forms[0].fc.value = mytool_array[18];
			document.forms[0].pc4.value = mytool_array[19];
			document.forms[0].pc3.value = mytool_array[20];
			document.forms[0].pc2.value = mytool_array[21];
			document.forms[0].pc1.value = mytool_array[22];
			document.forms[0].nss.value = mytool_array[23];
			document.forms[0].nc.value = mytool_array[24];
		}
	
      document.getElementById('content').style.display='none';
	  }
	  else{
  
		  document.getElementById('content').style.display='block';
	

//alert("failed");
		  //document.getElementById('content').style.display='block';
	  }
	}

	xmlHttp.open("GET",URL,true);
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
   
			var mytool_array=resp.split("/");
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
			
		}
		document.getElementById('content').style.display='none';
      init();
	  }
	  else{
                   init();
		  document.getElementById('content').style.display='block';
	  }
	}
	xmlHttp.open("GET",URL,true);
	xmlHttp.send(null);  
}

function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function changePasswordWindow(URL)
{

var width = 400;
	var height = 280;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
					   + "resizable=no,status=yes,left=380,top=250";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',properties);
		myNewWin.focus();	
	}	
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
 
<div id='page'>
  <div id='menu'>
	<a href="/pred/Logout.do"><img src="imagess/home.png" title="Logout" alt="Logout" border="0"/></a>
	<a href="http://ddws.gov.in" target="_NEW"><img src="imagess/ddws-logo.gif" title="DDWS" alt="DDWS" border="0"/></a>
	<a href="https://webmail.ap.gov.in" target="_NEW"><img src="imagess/email.png" title="AP WebMail" alt="AP WebMail" border="0" /></a>
  </div>

<div id="div1" class="cornerBox"><p><a href="#" onClick="submitComplaint()"><img src="imagess/wian-feedback-icon.png"  height="40" title="Feed Back" alt="Feed Back" border="0" /></a></p></div>

<body  style="background-image:url('images/enc_bg1.jpg');" onload="init();" >

<form name="master">


 
<div id="content" style="display:none" ><img src="images/loading1.gif" alt="Loading Wait..." title="Loading Wait..."></div> 
<TABLE border=0 cellSpacing=0 cellPadding=0 width=1000 align=center>
  <TBODY>
<tr>
<td align=right">
<font color="orange" face="verdana" size="3" > 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span id="date_time"></span></font>
            <script type="text/javascript">window.onload = date_time('date_time');</script></td>
</tr>
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
					
                <TR>
                     
						
					<td width="750" valign="top" align="center" bordercolor="#FFFFFF"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="750" height="140">
                          <param name="movie" value="imagess/rural.swf">
                          <param name="quality" value="high">
                          <param name="menu" value="false">
                          <param name="wmode" value="transparent">
                          <embed src="images/rural.swf" width="750" height="90" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed>
                        </object></td>
					
           <td>	
				<font face="verdana" size="3" color=lightyellow><br>Welcome to<br>
				</font><font color=lightyellow size="2" face="verdana">&nbsp;Engineer-In-Cheif , <br>  Rural&nbsp;Water&nbsp;Supply&nbsp;&&nbsp;Sanitation </font></td>


				</tr></table></td>
<td width="57" valign="bottom"><A href="#" onclick="changePasswordWindow('Secretary/rws_sec_changepass_frm.jsp?special=N&userid=<%=userid %>')">[Change Password]</A></td>
<td width="57" valign="bottom"><A href="/pred/Logout.do">[Logout]</A></td>




				<td>
                      <TD vAlign=top align=right>
					  </TD>
					</TR>					
                    <TR>
                      <TD vAlign=top colSpan=2 align=left>
                        <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                          <TBODY>
                          
              
              <TR>
                <TD vAlign=top colSpan=2>
                  <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                    <TBODY>
                    
                    <TR>
                      <TD vAlign=top colSpan=3>
                        <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                          <TBODY>
                          <TR>
                            <TD vAlign=top width=4>&nbsp;</TD>
                            <TD width=10>&nbsp;</TD>
                            <TD vAlign=top width=881><table border=0 cellspacing=0 cellpadding=0 
                              width="100%">
                              <tbody>
                          <!--      <tr>
                                  <td colspan="3" align="right"><div id="content" style="display:none"><img src="/pred/images/loading4.gif"></div>                                    
                                    <font face="verdana" size="2" color=blue><img src="images/refresh.JPG" width="35" height="35" alt="Click to get Updated Data" title="Click to get Updated Data" style="cursor:hand"  id="btnLoad"></font></td>
                                </tr> --> 

</tbody></table></TD></TR></TBODY></TABLE></TABLE></TABLE></TABLE></TABLE>


                                
<div id="tabs">
<ul>
      <li><a href="#home1">Home</a></li>
      <li><a href="#rfd">RFD</a></li>
     <li><a href="#alerts1">Alerts</a></li>
      <li><a href="#reports1">Data Sheet</a></li>
      <li><a href="#visulization1">Visulization</a></li>
    </ul>
 <div  id="home1">
  <table width="868" border="0" align="center">
                                           

<tr><td align="right" colspan="8"><span class="indigo10pixel">&nbsp;&nbsp;&nbsp;Financial Year</span>&nbsp;&nbsp;<span class="indigo10pixel"><select class="select" id="finyear" onchange="getWorks()"> 
<% 

	try{
String finYear="";
String temp="";
 conn=nic.watersoft.commons.RwsOffices.getConn();
Statement stmt11=conn.createStatement();
String fy="";
int fy1=0;
			String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2009 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		//System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			while(rs11.next())
			{
				 fy=rs11.getString(1);
				 fy1=Integer.parseInt(fy)+1;
if(finYear!=null && !finYear.equals(""))
				{
			 temp=finYear.substring(0,4);
				}
				if(temp.equals(rs11.getString(1))){
	%>
					 <option value="<%=fy+"-"+fy1%>" selected><%=fy+"-"+fy1%></option> 
	<%}else{%>
			<option value="<%=fy+"-"+fy1%>"><%=fy+"-"+fy1%></option> 
	<%}
			}
						if(rs11!=null)rs11.close();
						if(stmt11!=null)stmt11.close();
		
}catch(Exception e){e.printStackTrace();}
%>


</select>


</span></td>



</tr>

                                            <tr >
                                              <td colspan="3"><div id="draggable" class="ui-widget-content">
<div id="resizable" class="ui-widget-content">
	<h3 class="ui-widget-header">Habitation Directory</h3>
<table>
<tr>
<td width="89" height=20 class=green>Mandals </td>
                                              <td width="101" class=text2>
                                                <input type="text" class="noborder-text-box" readonly="true" name="mandals"></td>
</tr>
<tr>
 <td height=20 class=green>Panchayats</td>
                                              <td class=text2 id="div2">
                                                <input type="text" class="noborder-text-box" readonly="true" name="panchayats" >
                                             </td>
</tr>
<tr>
  <td height=20 class=green>Villages</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="villages" ></td>
</tr>
<tr>
 <td height=20 class=green>Habitations</td>
                                              <td class=text2 id="div4">
                                                <input type="text" class="noborder-text-box" readonly="true" name="habs" >
                                              </td>
</tr>
</table>

</div>

</td>
                                              <td colspan="3">

<div id="resizable" class="ui-widget-content">
	<h3 class="ui-widget-header">Assets</h3>
<table>
<tr> <td width="117" height=20 class=green>PWS</td>
                                              <td width="100" class=text2>
                                                <input type="text" class="noborder-text-box" readonly="true" name="pws">
                                            </td>
</tr>
<tr>
 <td height=20 class=green>MPWS</td>
                                              <td class=text2>
                                                <input type="text" class="noborder-text-box" readonly="true" name="mpws" >
                                              </td>
</tr>
<tr>
 <td height=20 class=green>CPWS</td>
                                              <td class=text2>
                                                <input type="text" class="noborder-text-box" readonly="true" name="cpws" >
                                              </td>
</tr>
<tr>
  <td height=20 class=green>Handpumps</td>
                                              <td class=text2>
                                                <input type="text" class="noborder-text-box" readonly="true" name="borewells" >
                                              </td>
</tr>

</table>
</div>


</td>
<td colspan="2">
<div id="resizable3" class="ui-widget-content">
	<h3 class="ui-widget-header">Works</h3>
<table>
<tr><td></td><td><span class="indigo10pixel">PWS</span></td><td><span class="indigo10pixel">CPWS</span></td></tr>
<tr>
<td  width="114" height="20" class="green" onmouseover="Tip('Details',TITLE,'Information')" onmouseout="UnTip()" >Ongoing</td>
                                              <td width="95" class=text2>
                                                <a   id="set1" title="Click here view details" href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=On Going&type=01')"><input  type="text" class="noborder-text-box" readonly="true" name="ongoing"></a>
                                              </td>
 <td width="95" class=text2>
                                                <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=On Going&type=03')"><input type="text" class="noborder-text-box" readonly="true" name="ongoing1"></a>
                                              </td>
</tr>

<tr>
 <td height=20 class=green>Not Grounded</td>
                                              <td class=text2>
                                                <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Not Grounded&type=01')"><input type="text" class="noborder-text-box" readonly="true" name="notground" ></a>
                                              </td>
  <td class=text2>
                                                <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Not Grounded&type=03')"><input type="text" class="noborder-text-box" readonly="true" name="notground1" ></a>
                                              </td>

</tr>
<tr>
 <td height=20 class=green>Completed</td>
                                              <td class=text2>
                                                <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Completed&type=01')"><input type="text" class="noborder-text-box" readonly="true" name="completed" ></a>
</td>
<td class=text2>
                                                <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Completed&type=03')"><input type="text" class="noborder-text-box" readonly="true" name="completed1" ></a></td>

</tr>
<tr>
<td height=20 class=green>Commissioned</td>
                                              <td class=text2>
                                               <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Commissioned&type=01')"> <input type="text" class="noborder-text-box" readonly="true" name="commissioned" ></a>
                                              </td>
<td class=text2>
                                           <a href="#" onclick="viewWorks('Secretary/rws_dashboard_works_list.jsp?name=Commissioned&type=03')">     <input type="text" class="noborder-text-box" readonly="true" name="commissioned1" > </a>
                                              </td>
 
</tr>
</table>
</div>
</td>

                                            <tr>
                                              <td colspan="3">

<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Habitation Coverage</h3>
<table>
<tr>
<td  width="89" height=20  class=green >FC</td>
                                              <td width="101" class=text2>
                                                <input type="text" class="noborder-text-box" readonly name="fc" >
                                              </td>
</tr>
<tr>
 <td height=20 class=green>PC4</td>
                                              <td class=text2 id="div3" >
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc4" value="">
                                              </td>
</tr>
<tr>
<td height=20 class=green>PC3</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc3" value="">
                                              </td>
</tr>
<tr>
<td height=20 class=green>PC2</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc2" value="">
                                              </td>
</tr>
<tr>
  <td height=20 class=green>PC1</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc1" value="">
                                             </td>
</tr>
<tr>
  <td height=20 class=green>NSS</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="nss" value="">
                                              </td>
</tr>
<tr>    <td height=20 class=green>NC</td>
                                              <td class=text2 id="div3">
                                                <input type="text" class="noborder-text-box" readonly="true" name="nc" value="">
                                             </td></tr>
</table>
</div></td>





       <td colspan="3">
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Water Quality</h3>
<table>
<tr><td width="89"  height=20 class=green>Physico Chemical(Tests) </td>
                                              <td width="100" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="phys" value="">
                                              </td></tr>
<tr> <td height=20 class=green>Bacterological (Tests)</td>
                                              <td class=text2 >
                                                <input type="text" class="noborder-text-box" readonly="true" name="bact" value="">
                                              </td></tr>
</table>
</div>
</td>
                                              
             </tr>
                                          </table>
</div>
 <div  id="alerts1">
<table >
<tr>
<td>
<div id="resizable" class="ui-widget-content">
	<h3 class="ui-widget-header">Fund Accounting</h3>

<table >
<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_financial_bank_mpr_rpt.jsp')">Financial MPR -Bank  </a></td></tr>

<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_financial_pao_mpr_rpt.jsp')">Financial MPR -PAO  </a></td></tr>


</table>

</td>
</div>


<td>

<div id="resizable3" class="ui-widget-content">
	<h3 class="ui-widget-header">Works Monitoring</h3>
<table >
<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_compl_notcommenced_rpt.jsp')">CPWS Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcommisioned_rpt.jsp')">CPWS Works(s) Admin Sanctioned - Not Commenced with >1 year(s) of Time Period </a></td></tr>
<tr>
<td>3.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcompl_wrks_rpt.jsp')">CPWS Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>


</table>
</div>
</td>
</tr>


</table>
</div>


<div  id="rfd">
<table >
<tr>
<td>

<div id="resizable6" class="ui-widget-content">
	<h3 class="ui-widget-header">RFD<img src="images/new.gif"> </h3>
<table >
<tr>

<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_works_program_details_frm.jsp')">Abstract Works Spill Over/ New </a></td></tr>
<tr>
<td>2.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_dpr_sec_StatusP_drill_frm.jsp')">Permission Pending Status </a></td></tr>

<tr>
<td>3.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_dpr_fin_secpro_frm.jsp')">DPR Status Progress Report</a></td></tr>

<tr>
<td>4.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_rfd_schools_rpt.jsp')">Coverage of Schools/Anganwadis with Drinking Water Facilities </a></td></tr>

<tr>
<td>5.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_svs_mvs_prevcomp_curr_update_rpt.jsp')">Work Completion Date Updation </a></td></tr>

<tr>
<td>6.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_work_program_fin_notcompl_frm.jsp')">Physically completed and Financially not completed</a></td></tr>


<tr>
<td>7.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_WQ_RFD_lab_frm.jsp')">Water Quality-Lab Abstract </a></td></tr>




<tr>
<td>8.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_ftk_test_ftkuptomonth_sec_frm.jsp')">Water Quality-FTK Abstract </a></td></tr>

<tr>
<td>9.</td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_rpt.jsp')">Scheme(MVS)-Hab Status </a></td></tr>

<tr>
<td>10.</td><td><a href="#" class="h4" onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp')">Scheme(SVS)-Hab Status </a></td></tr>

<tr>
<td>11.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Drought Works Status</a></td></tr>

</table>
</div>
</td>
</tr>


</table>
</div>
 <div  id="reports1">
     <table border=0 cellSpacing=0 cellPadding=0   width="100%" >
<tr>
<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Habitations</h3>

			
<!--   <marquee  behavior="scroll" direction="up"><p>  -->

          <table>



<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('28')">LPCD range wise Habitations </a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('29')">Coverage Status of SC & ST Habitations </a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('6')">Constituency Status</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('7')">Resources At a Glance</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('10')">Slipped back details</a></span></td>
</tr>
<tr>
 
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('8')">Gram Panchayat Asset Coverage</a></span></td>
</tr>
<tr>
 
      <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('9')">Gram Panchayat Coverage Status</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('22')">Population-Category</a></span></td>
</tr>
			</table></p>

<!--  </marquee> -->
</div>
</td>


<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Works</h3>
			
       <table><tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('14')">Works Abstract</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('26')">Status Work Progress Report(Gap Report)</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('27')">General Abstract Report-Revised </a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
			</table>

  </div>
</td>
<td>
		<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Assets</h3>
	
  
       <table><tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('12')">Assets-Sources</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('13')">Assets Abstract</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
			</table>

  </div>
</td>

<td>

		<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Water Quality</h3>
	  			
    <table>
    <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('20')">Habitation VS Water Quality(Flouride,Salinity)</a></span></td>
</tr>
    <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('21')">Entry Status</a></span></td>
</tr>
    <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"   class="h4" onClick="fnCall('24')">District Profile For Quality Parameters</a></span></td>
<!--   
  <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4"  onClick="fnCall('25')">Habitation Coverage By Test Results(Priority Based)</a></span></td>
</tr> -->

 <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4"  onClick="fnCall('30')">Abstract- Sources Vs All Tests</a></span></td>
</tr> 
 <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4"  onClick="fnCall('25')">Habitation Coverage By Test Results(Priority Based)</a></span></td>
</tr> 



  <tr>


       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick=""></a></span></td>
</tr>
    
</table>
  </div>
</td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="##"  class="h4" onClick=""></a></span></td>
</tr>
<tr>
<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Fund Accounting</h3>
		
<table>
    <tr >
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('1')">Financial Achievement</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('2')">Division wise Releases Vs Expenditure</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('3')">Programme wise Releases Vs Expenditure</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('4')">Bank-PAO Releases</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('4')">Central/State Bills Audit</a></span></td>
</tr>
</table>


  </div>
</td>


<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Schools</h3>

       <table><tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##" class="h4"  onClick="fnCall('11')">Schools Abstract</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
			</table>

  </div>
</td>
<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Contractors</h3>
		
       <table><tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('5')">Contractor Performance Report</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('23')">Contractor Status Report</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  onClick=""></a></span></td>
</tr>
			</table>

  </div>
</td>

<td>
<div id="resizable5" class="ui-widget-content">
	<h3 class="ui-widget-header">Drought</h3>
			
    <table>
    <tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('15')">Contingency Abstract</a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('16')">Abstract Flushing/Deepnening</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('17')">Abstract Hiring/Trans/Power</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href=##"  class="h4" onClick="fnCall('18')">Daily Report</a></span></td>
</tr>

</table>
  </div>
</td>
</tr>


<!-- 
                               
 		<tr><td></td><td></td><td height=20 colspan="2" class=green><span class="text2"><a href="#"  onClick="fnCall('4')">Assets Abstract</a></span></td></tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
 <td height="20" colspan="2" class="green" ><span class="text2"><a href="#" onClick="fnCall('1')">Habitation Coverage Status </a></span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
 <td height=20 colspan="2" class=green><span class="text2"><a href="#" onClick="fnCall('7')">Works Abstract </a></span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>

 <td height=20 colspan="2" class=green><span class="text2"><a href="#"  onClick="fnCall('8')">Habitation Coverage Graph </a></span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 colspan="2" class=green><span class="text2"><a href="#"  onClick="fnCall('3')">Resources in a Habitation </a></span></td>
                                              <td height=20 colspan="2" class=green><span class="text2"><a href="#"  onClick="fnCall('6')">Schools Abstract </a></span></td>
                                              <td height=20 colspan="2" class=green><span class="text2"><a href="#" onClick="fnCall('2')">Population-Category</a></span></td>
<tr> <td height=20 colspan="2" class=green><span class="text2"><a href="#" onClick="fnCall('5')">Assets-Sources </a></span></td></tr>
 -->
</table>
</div>
<div  id="visulization1">

<table>
<tr><td class="green"> Select Graph:</td><td ><select class="select" id="graphName"  ><option value="1">Borewell Status</option><option value="2">Asset Types</option><option value="3">Hab Coverage Status</option></select> </td></tr>
<tr><td class="green">Select Chart Type:</td><td><select class="select" id="chartType"  onchange="pieChartExample();"><option value="">Select</option><option value="bar">Bar</option><option value="Line">Line</option></select> </td></tr>
<tr><td ></td><td><div id="chartid"></div></td></tr>

<tr></tr>

</table>

</div>


</div>

                      
                           

</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<table width="100%" >

<TR>
      <TD class=grey10pixel vAlign=top  align=middle><div align="center" class="style1">
                                    <p>&nbsp;</p>
                                    <p><b><font color="lightyellow">Designed &amp; Developed by National Informatics Centre, AP State Centre</font></b></p>
                                  </div></TD>
                                </TR>
</table>




</form>
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

