

<%
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	//System.out.println(users);
	String userid = users.getUserId();
	String isEmailRegistered = users.getIsEmailRegistered();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ include file="/reports/conn.jsp"%>
<%@ include file="rws_alerts.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ page import="java.util.Date"%>


<script type="text/javascript">
<jsp:include page="../dashboards/Includes/rws_dashboard.js" />
<jsp:include page="../FusionCharts/FusionCharts.js" />
</script>
<%
	ResultSet rs1 = null;
	Statement st1 = null;
	try {
		String fyear = "";
%>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>Welcome to Watersoft</TITLE>
<META content="text/html; charset=iso-8859-15" http-equiv=Content-Type>
<style media="all" type="text/css">
#div1 {
	position: absolute;
	bottom: 0;
	right: 0;
	z-index: 1;
}

.cornerBox {
	border: 2px solid #999;
	padding: 5px 10px;
	color: #333;
}

.cornerBox p {
	margin: 0;
}

A:link {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: none;
	color: #316A95
}

A:visited {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: none;
	color: #316A95
}

A:hover {
	font-family: verdana;
	font-size: 8pt;
	text-decoration: underline;
	color: #316A95
}

.noborder-text-box {
	border: 0;
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	LETTER-SPACING: 1px;
	COLOR: #0000ff;
	FONT-SIZE: 11px;
	FONT-WEIGHT: bold;
	width: 95px;
}

fieldset {
	position: relative;
	height: 50;
}

legend { /* Text and background colour, blue on light gray */
	color: #00f;
}
</STYLE>


<script language="JavaScript"
	src="/pred/resources/javascript/jquery-1.4.2.js"></script>
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
	color: green;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}

.green {
	color: #F58F00;
	text-align: left;
}

.fb5 {
	background-color: #db6600;
	padding-left: 6px;
	padding-right: 6px;
	padding-top: 3px;
	padding-bottom: 3px;
	color: #ffffff;
	border: 1px solid #db6600;
	background-image: url(images/button_bg.jpg);
}

.fb5:hover {
	background-color: #000000;
	border: 1px solid #000000;
	background-image: url(images/button_bg_over.jpg);
}

.ta5 {
	border: 3px double #CCCCCC;
	width: 450px;
	height: 80px;
}

.h4:hover {
	text-transform: uppercase;
	color: orange;
	font-weight: bold
}

.ta225 {
	background: url(images/roundtext.gif) no-repeat top left;
	border: 0;
	width: 220px;
	height: 55px;
	border: 3px double #CCCCCC;
	width: 230px;
	height: 60px;
}

.ta5a {
	border: 0;
	width: 220px;
	height: 55px;
	margin-top: 3px;
}

.modeltextbox1 {
	width: 150px;
	background: transparent url('images/bgtext.jpg') no-repeat;
	color: blue;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
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
	padding: 3px;
	margin: 0;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
	-moz-box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
	box-shadow: 0 3px 0 #ccc, 0 -1px #fff inset;
	background: #f8f8f8;
	color: #888;
	border: none;
	outline: none;
	display: inline-block;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	cursor: pointer;
}

label {
	position: relative
}

label:after {
	content: '<>';
	font: 11px "Consolas", monospace;
	color: #aaa;
	-webkit-transform: rotate(90deg);
	-moz-transform: rotate(90deg);
	-ms-transform: rotate(90deg);
	transform: rotate(90deg);
	right: 8px;
	top: 2px;
	padding: 0 0 2px;
	border-bottom: 1px solid #ddd;
	position: absolute;
	pointer-events: none;
}

label:before {
	content: '';
	right: 6px;
	top: 0px;
	width: 20px;
	height: 20px;
	background: #f8f8f8;
	position: absolute;
	pointer-events: none;
	display: block;
}

?
#Layer1 {
	position: absolute;
	width: 664px;
	height: 115px;
	z-index: 1;
	visibility: visible;
}

#Layer2 {
	position: absolute;
	width: 200px;
	height: 115px;
	z-index: 1;
	left: 375px;
	top: 125px;
}

#content {
	position: absolute;
	width: 200px;
	height: 115px;
	z-index: 1;
	left: 300px;
	top: 350px;
}
-->
</style>

<script language="JavaScript" src="/pred/imagess/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/pred/imagess/jquery.jqDock.min.js"></script>
<link href="/pred/resources/style/dockstyle.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript"
	src="/pred/resources/javascript/jscharts.js"></script>
<script type="text/javascript"
	src="/pred/resources/javascript/tinybox.js"></script>


<style>
#resizable, #resizable2 {
	width: 200px;
	height: 150px;
	padding: 0.5em;
}

#resizable3 {
	width: 500px;
	height: 150px;
	padding: 0.5em;
}

#resizable4 {
	width: 300px;
	height: 150px;
	padding: 0.5em;
}

#resizable5 {
	width: 240px;
	height: 230px;
	padding: 0.5em;
}

#resizable6 {
	width: 500px;
	height: 450px;
	padding: 0.5em;
}

#resizable7 {
	width: 250px;
	height: 420px;
	padding: 0.5em;
}

#resizable8 {
	width: 500px;
	height: 440px;
	padding: 0.5em;
}

#resizable12 {
	width: 760px;
	height: 380px;
	padding: 0.5em;
}

#resizable13 {
	width: 750px;
	height: 380px;
	padding: 0.5em;
}

#resizable15 {
	width: 750px;
	height: 230px;
	padding: 0.5em;
}

#resizable14 {
	width: 800px;
	height: 380px;
	padding: 0.5em;
}

#resizable16 {
	width: 290px;
	height: 230px;
	padding: 0.5em;
}

#habcoverage {
	width: 290px;
	height: 230px;
	padding: 0.5em;
}

#resizable h3, #resizable2 h3 {
	text-align: center;
	margin: 0;
}

#resizable3 h3, #resizable4 h3 {
	text-align: center;
	margin: 0;
	color: "lightgreen"
}

#resizable5 h3, #resizable4 h3 {
	text-align: center;
	margin: 0;
}

#resizable6 h3, #resizable6 h3 {
	text-align: center;
	margin: 0;
}
</style>
<script>
	$(function() {

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
<link rel="stylesheet"
	href="/pred/resources/style/jquery.ui.resizable.css">
<link rel="stylesheet" href="/pred/resources/style/example.css"
	type="text/css">
<link rel="stylesheet" href="/pred/resources/style/dropkick.css"
	type="text/css">



<link href="" rel="stylesheet" id="theme_css">



<script src="/pred/resources/javascript/jquery.ui.mouse.js"></script>
<script src="/pred/resources/javascript/jquery.ui.resizable.js"></script>
<script src="/pred/resources/javascript/jquery.ui.accordion.js"></script>
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
		$("#accordion44").accordion({
			event: "click hoverintent"
		});
	});

	$(function() {
		$("#accordion5").accordion({
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

<script language="JavaScript">

function embedHide() {
    document.getElementById("banner").style.visibility = "hidden";
    document.getElementById("ChartDiv").style.visibility = "hidden";
    document.getElementById("ChartDiv1").style.visibility = "hidden";
}
function embedVisible() {
    document.getElementById("banner").style.visibility = "visible";
    document.getElementById("ChartDiv").style.visibility = "visible";
    document.getElementById("ChartDiv1").style.visibility = "visible";
}

function openUserForm(){

	var emailReg='<%=isEmailRegistered%>';
	
	if(emailReg!="true"){
		 newwindow=window.open('switch.do?prefix=/admin&page=/users.do&mode=data','frameless','width=560,height=340,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=0,screenX=300,screenY=300,left=350,top=200');  
		 if (window.focus) {newwindow.focus()}
		//TINY.box.show({url:'switch.do?prefix=/admin&page=/users.do&mode=data',boxid:'frameless',width:600,height:400,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){embedVisible();closeJS()}});
	}
}
function openJS(){}
function closeJS(){}


function change(type){
	//alert("ss:"+type);
	 var userid = '<%=userid%>';
if(type=="1"){
	
document.getElementById('theme_css').href = '/pred/resources/style/admin/css/page/jquery-ui-1.10.2.custom.css';
//setCookie(userid,'1',365, {samesite:'strict', secure:true, sameparty:true});
  } else if(type=="2"){
	  
	  
document.getElementById('theme_css').href = '/pred/resources/style/ee/css/start/jquery-ui-1.8.23.custom.css';
//setCookie(userid,'2',365, {samesite:'strict', secure:true, sameparty:true});

}else if(type=="3"){
	//setCookie(userid,'3',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/user/css/trontastic/jquery-ui-1.10.2.custom.css';
} else if(type=="4"){
	//setCookie(userid,'4',365, {samesite:'strict', secure:true, sameparty:true});
document.getElementById('theme_css').href = '/pred/resources/style/custom/css/start/jquery-ui-1.8.23.custom.css';

}


}

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


  
var finyear="";

var userid="";
var chart1XML="";
var chart2XML="";



function releasesChart(){
if(chart1XML==""){
var URL1="./dashboards/rws_dashboard_charts.jsp?type=relDiv&finyear="+finyear+"&userid="+userid;
ajaxFunction_Charts(URL1,1);
}else {
updateChartXML('1',chart1XML);
}
	setTimeout('expChart();','10000');
  document.getElementById('ChartDiv1').style.display='none';
document.getElementById('ChartDiv').style.display='block';
 	


}
function expChart(){
  
if(chart2XML==""){
var URL1="./dashboards/rws_dashboard_charts.jsp?type=expDiv&finyear="+finyear+"&userid="+userid;
ajaxFunction_Charts(URL1,2);
}else {
updateChartXML('2',chart2XML);

}
setTimeout('releasesChart();','10000');
document.getElementById('ChartDiv').style.display='none';
 document.getElementById('ChartDiv1').style.display='block';

}

function creategraph(){
var obj1,obj2;
createChart('./FusionCharts/FCF_Column3D.swf',1,400,230,0,0,'','ChartDiv',obj1);
createChart('./FusionCharts/FCF_Pie3D.swf',2,400,230,0,0,'','ChartDiv1',obj2);
releasesChart();
}


function getWorks()
{

chart1XML="";
chart2XML="";

	 finyear=document.getElementById("finyear").value;
 userid = '<%=userid%>';

//var URL1="./dashboards/rws_dashboard_charts.jsp?type=expDiv&finyear="+finyear+"&userid="+userid;
//ajaxFunction_Charts(URL1);
				
if(finyear==null){
finyear="2012-2013";}
var URL="./dashboards/rws_ee_dashborad_works.jsp?finyear="+finyear+"&userid="+userid;
  	ajaxFunction_Works(URL);

}
	function submitComplaint()
	{
		var userid = '<%=userid%>';
		var urlnew = "works/feedbackSecy.jsp?userid=" + userid;
		//alert(urlnew);
		window
				.open(urlnew, "feedBackPage",
						"width=500,height=400,scrollbars=yes,copyhistory=no,resizable=yes,status=yes");
	}

	function ajaxFunction_Charts(URL, type) {
		if (URL.indexOf("?") != -1) {
			URL = URL + "&date=" + new Date();
		} else {
			URL = URL + "?date=" + new Date();
		}
		var xmlHttp;
		try {
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {

				var resp = xmlHttp.responseText;
				resp = resp.replace(/^\s*|\s*$/g, '');
				if (resp == null || resp == "" || resp.length == 0) {
				} else {
					// alert(resp);  
					if (type == 1) {
						chart1XML = resp;
						updateChartXML('1', resp);
					} else if (type == 2) {
						chart2XML = resp;
						updateChartXML('2', resp);
					}
				}

			} else {

			}
		}
		xmlHttp.open("POST", URL, true);
		xmlHttp.send(null);
	}

	function ajaxFunction_Works(URL) {
		if (URL.indexOf("?") != -1) {
			URL = URL + "&date=" + new Date();
		} else {
			URL = URL + "?date=" + new Date();
		}
		var xmlHttp;
		try {
			xmlHttp = new XMLHttpRequest();
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e) {
					alert("Your browser does not support AJAX!");
					return false;
				}
			}
		}
		if (xmlHttp == null) {
			alert("Your browser does not support AJAX!");
			return;
		}
		xmlHttp.onreadystatechange = function() {
			if (xmlHttp.readyState == 4) {

				var resp = xmlHttp.responseText;
				resp = resp.replace(/^\s*|\s*$/g, '');
				if (resp == null || resp == "" || resp.length == 0) {
				} else {

					var mytool_array = resp.split("/");

					document.forms[0].ongoing.value = mytool_array[0];
				//	document.forms[0].ongoing1.value = mytool_array[1];

					document.forms[0].ground.value = mytool_array[2];
				//	document.forms[0].ground1.value = mytool_array[3];

					document.forms[0].underprogress.value = mytool_array[4];
					//document.forms[0].underprogress1.value = mytool_array[5];

					document.forms[0].notground.value = mytool_array[6];
				//	document.forms[0].notground1.value = mytool_array[7];

					document.forms[0].completed.value = mytool_array[8];
					//document.forms[0].completed1.value = mytool_array[9];

					//	document.forms[0].commissioned.value = mytool_array[6];
					//document.forms[0].commissioned1.value = mytool_array[7];
				}

				document.getElementById('content').style.display = 'none';
			} else {

				document.getElementById('content').style.display = 'block';
			}
		}
		xmlHttp.open("POST", URL, true);
		xmlHttp.send(null);
	}
	
		function viewReport(URL) {
		embedHide();
		TINY.box.show({
			url : URL,
			boxid : 'frameless',
			width : 1000,
			height : 600,
			fixed : true,
			maskid : 'bluemask',
			maskopacity : 40,
			closejs : function() {
				embedVisible();
				closeJS()
			}
		});
	}

	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}

	function viewWorks1(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, '_self', popFeatures);
			myNewWin.focus();
		}
	}
	function changePasswordWindow(URL) {
		var width = 320;
		var height = 250;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
						   + "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
						   + "resizable=no,status=yes,left=400,top=250";
		if(URL!=""){
			newwindow = window.open(URL,'newWinddow',properties);
			if (window.focus) {newwindow.focus()}			
		}
	}
	function fnCall(reportVal) {
		var URL = "";
		if (reportVal == "1")

			URL = "./reports/rws_Financial_rpt.jsp";

		//URL = "./reports/rws_const_coverage_status_frm.jsp";
		else if (reportVal == "2")
			URL = "./reports/rws_Releases_Exp_frm.jsp";
		else if (reportVal == "3")
			URL = "./reports/rws_Exp_Rel_Pro_frm.jsp";
		//URL = "./reports/rws_hab_status_resource_rpt.jsp";
		else if (reportVal == "4")

			URL = "./reports/rws_BankPao_Payment_det_frm.jsp";

		else if (reportVal == "5")

			URL = "switch.do?prefix=/masters&page=/Contractor.do&mode=getContractorlist&special=reset";

		else if (reportVal == "6")

			URL = "./reports/rws_const_coverage_status_frm.jsp";
		//
		else if (reportVal == "7")
			URL = "./reports/rws_hab_status_resource_rpt.jsp";

		else if (reportVal == "8")
			URL = "./reports/rws_district_wise_gps_frm.jsp";
		//URL = "./reports/rws_coverage_status_graph_rpt.jsp?chart=b&district=51&mandal=0&panchayat=0&FDate=01-APR-2010";
		else if (reportVal == "9")
			URL = "./reports/rws_district_wise_gps_status_frm.jsp";
		else if (reportVal == "10")
			URL = "./reports/rws_slippagetable_hab_frm.jsp";
		else if (reportVal == "11")

			URL = "./reports/rws_school_abstract_rpt1_secy.jsp?rDistrict=00&drill=null&rDistrictName=ALL";
		else if (reportVal == "12")
			URL = "./reports/rws_dist_asst.jsp?district=-1&mandal=0&panchayat=0&habitation=0";
		else if (reportVal == "13")
			URL = "./reports/rws_AssetAbstract_report1.jsp?yrcreation=00&drill=&rDistrictName=";
		else if (reportVal == "14")
			URL = "./reports/rws_work_gen.jsp?district=00&finyear=2012-2013&planNonplan=1&drill=null&distname=ALL";
		else if (reportVal == "15")
			URL = "./reports/rws_drought_habitations_frm.jsp";
		else if (reportVal == "16")
			URL = "./reports/rws_drought_deepen_frm.jsp";
		else if (reportVal == "17")
			URL = "./reports/rws_drought_deepen_abst_frm.jsp";
		else if (reportVal == "18")
			URL = "./reports/rws_drought_daily_rpt.jsp";
		else if (reportVal == "19")
			URL = "./reports/rws_drought_distwise_sstank_rpt.jsp";
		else if (reportVal == "20")
			URL = "./reports/rws_water_nsshabs_frm_rpt.jsp";
		else if (reportVal == "21")
			URL = "./reports/rws_water_sample_abstract_frm.jsp";
		else if (reportVal == "22")
			URL = "./reports/rws_dist_popcate_rpt1.jsp";
		else if (reportVal == "23")
			URL = "./reports/Contractor/rws_contractor_frm.jsp";
		else if (reportVal == "24")
			URL = "./reports/rws_WQ_lab_frm_rpt.jsp";
		else if (reportVal == "25")
			URL = "./reports/rws_WQ_Habs_Coverage_Frm.jsp";
		else if (reportVal == "26")
			URL = "./reports/rws_works_exception_frm.jsp";
		else if (reportVal == "27")
			URL = "./reports/rws_work_general_abstract_rpt_p.jsp";

		else if (reportVal == "28")
			URL = "./reports/rws_HabPop_rpt.jsp";

		else if (reportVal == "29")
			URL = "./Secretary/rws_dist_pop_frm1.jsp";
		else if (reportVal == "30")
			URL = "./reports/rws_waterqtly_sources_tests_frm.jsp";
		else if (reportVal == "31")
			URL = "./reports/rws_works_frm.jsp";

		else if (reportVal == "32")
			URL = "./reports/rws_qa_habs_covered_31032010.jsp";
		else if (reportVal == "33")
			URL = "switch.do?prefix=/fundAccounting&page=/broDetails.do&mode=data";

		else if (reportVal == "34")
			URL = "switch.do?prefix=/fundAccounting&page=/locDetails.do&mode=data";
		else if (reportVal == "35")
			URL = "./fundAccounting/rws_op_cl_bal_frm.jsp";
		else if (reportVal == "36")
			URL = "./works/rws_work_parta_bill_frm.jsp";

		else if (reportVal == "37")
			URL = "./works/rws_work_bill_frm.jsp";

		else if (reportVal == "38")
			URL = "./works/rws_work_exp_voucher_frm.jsp";
		else if (reportVal == "39")
			URL = "./works/rws_work_voucher_frm.jsp";

		else if (reportVal == "40")
			URL = "switch.do?prefix=/drought&page=/PowerTransport.do&mode=get2&special=reset";

		else if (reportVal == "41")
			URL = "switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=get2";

		else if (reportVal == "42")
			URL = "switch.do?prefix=/drought&page=/FlushDeep.do&mode=data&special=reset";

		else if (reportVal == "43")
			URL = "switch.do?prefix=/drought&page=/sstank.do&mode=data&special=reset";
		else if (reportVal == "44")
			URL = "switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=null";
		else if (reportVal == "45")
			URL = "switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data";
		else if (reportVal == "46")
			URL = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";

		else if (reportVal == "47")
			URL = "./Secretary/rws_works_program_details_frm.jsp";

		else if (reportVal == "48")
			URL = "./Secretary/rws_work_dpr_sec_StatusP_drill_frm.jsp";

		else if (reportVal == "49")
			URL = "./Secretary/rws_work_dpr_fin_secpro_frm.jsp";

		else if (reportVal == "50")
			URL = "./Secretary/rws_rfd_schools_rpt.jsp";

		else if (reportVal == "51")
			URL = "./Secretary/rws_svs_mvs_prevcomp_curr_update_rpt.jsp";

		else if (reportVal == "52")
			URL = "./Secretary/rws_work_program_fin_notcompl_frm.jsp";

		else if (reportVal == "53")
			URL = "./Secretary/rws_WQ_RFD_lab_frm.jsp";
		else if (reportVal == "54")
			URL = "./Secretary/rws_ftk_test_ftkuptomonth_sec_frm.jsp";
		else if (reportVal == "55")
			URL = "./reports/RFDReports/rws_asset_habs_status_rpt.jsp";

		else if (reportVal == "56")
			URL = "./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp";
		else if (reportVal == "58")
			URL = "./Secretary/rws_drought_works_abstract_rpt.jsp";

		//water quality reports

		else if (reportVal == "59")
			URL = "./reports/rws_waterqtly_sources_tests_frm.jsp";

		else if (reportVal == "60")
			URL = "./reports/rws_wq_samples_frm.jsp";

		else if (reportVal == "61")
			URL = "./reports/rws_wq_sam_res_loc_frm.jsp";

		else if (reportVal == "62")
			URL = "./reports/rws_water_nsshabs_frm_rpt.jsp";
		else if (reportVal == "63")
			URL = "./reports/rws_water_parameters_frm.jsp";
		else if (reportVal == "64")
			URL = "./reports/rws_Wq_Lab_rpt.jsp";

		else if (reportVal == "65")
			URL = "./reports/rws_WQ_lab_frm_rpt.jsp";
		else if (reportVal == "66")
			URL = "./reports/rws_WQ_Habs_Coverage_Frm.jsp";

		else if (reportVal == "67")
			URL = "./reports/WaterQuality/rws_list_odf_gps_frm.jsp";
		else if (reportVal == "68")
			URL = "./reports/rws_lab_test_frm.jsp";

		else if (reportVal == "69")
			URL = "./reports/rws_ftk_test_result_frm.jsp";
		else if (reportVal == "70")
			URL = "./reports/rws_water_sample_abstract_frm.jsp";
		else if (reportVal == "71")
			URL = "./reports/rws_works_program_details_frm.jsp";

		else if (reportVal == "72")
			URL = "./reports/rws_work_status_new_frm.jsp";
		else if (reportVal == "73")
			URL = "./reports/rws_WQ_Habs_Coverage_Frm.jsp";

		else if (reportVal == "74")
			URL = "./reports/rws_work_program_fin_notcompl_frm.jsp";
		else if (reportVal == "75")
			URL = "./reports/rws_schools_monitoring_rpt.jsp";

		else if (reportVal == "76")
			URL = "./reports/rws_totalnolabs_frm.jsp";
		else if (reportVal == "77")
			URL = "./reports/rws_totalnowatersample_frm.jsp";

		else if (reportVal == "78")
			URL = "./reports/rws_drought_habitations_frm.jsp";

		else if (reportVal == "79")
			URL = "./reports/rws_drought_frm.jsp";
		else if (reportVal == "80")
			URL = "switch.do?prefix=/drought&page=/DroughtReport.do&mode=get2";

		else if (reportVal == "81")
			URL = "./reports/rws_drought_deepen_frm.jsp";
		else if (reportVal == "82")
			URL = "./reports/rws_drought_deepen_abst_frm.jsp";

		else if (reportVal == "83")
			URL = "./reports/rws_drought_daily_rpt.jsp";
		else if (reportVal == "84")
			URL = "./reports/rws_drought_daily_comparision_consolidate_rpt.jsp";

		else if (reportVal == "85")
			URL = "./reports/rws_drought_ongoing_works_rpt.jsp";

		else if (reportVal == "86")
			URL = "./reports/rws_drought_distwise_sstank_rpt.jsp";
		else if (reportVal == "87")
			URL = "./reports/rws_sstank_consolidated_rpt.jsp";

		else if (reportVal == "88")
			URL = "./reports/rws_drought_contigencyplan_habs_frm.jsp";
		else if (reportVal == "89")
			URL = "./reports/rws_drought_drinking_water_situation_frm.jsp";

		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
	function toggleDisplay(val) {
		if (val == 1) {
			var zURL = "./reports/rws_bill_tobe_release_rpt_secy.jsp";
			var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
			myWin = window.open(zURL, 'expenditure', popFeatures);
			myWin.focus();
		} else if (val == 2) {
			var zURL = "./reports/rws_biil_release_program_rpt.jsp";
			var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
			myWin1 = window.open(zURL, 'expenditure1', popFeatures);
			myWin1.focus();
		}

	}
</script>


<script type="text/javascript">
	//<![CDATA[

	var tabLinks = new Array();
	var contentDivs = new Array();

	function init() {

		document.forms[0].elements["finyear"].selectedIndex = 1;
		getWorks();

	}

	function showTab() {
	}

	function getFirstChildWithTagName(element, tagName) {
		for (var i = 0; i < element.childNodes.length; i++) {
			if (element.childNodes[i].nodeName == tagName)
				return element.childNodes[i];
		}
	}

	function getHash(url) {
		var hashPos = url.lastIndexOf('#');
		return url.substring(hashPos + 1);
	}

	//]]>
</script>




</HEAD>

<body
	onload="checkCookie('<%=userid%>');init();openUserForm();"><!-- creategraph(); -->
	<center>
		<form name="master">

			<div id="content" style="display: none">
				<img src="images/loading1.gif" alt="Loading Wait..."
					title="Loading Wait...">
			</div>
			<TABLE border=0 cellSpacing=0 cellPadding=0 width="80%" align=center>
				<TBODY>

					<TR>
						<TD>
							<TABLE border=0 cellSpacing=0 cellPadding=0 width=1100
								align=center>
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

																		<td align="right"><img
																			src="<rws:context page='/images/rwss.gif' />"></img>
																		</td>
																		<td width="580" valign="top" align="center"
																			bordercolor="#FFFFFF"><!-- <embed src="imagess/rural.swf"  width="550px"
																				height="130px" id="banner" ></embed > --></td>



																		<td class="title1"><b><%--  Welcome, <bean:write name="RWS_USER" property="userId" />  --%>
																		  Welcome, <bean:write name="RWS_USER" property="userId" />  
																		<br> <logic:notEqual
																					name="RWS_USER" property="circleOfficeCode"
																					value="00">
																					<bean:write name="RWS_USER"
																						property="circleOfficeName" />
																				</logic:notEqual> <logic:notEqual name="RWS_USER"
																					property="divisionOfficeCode" value="00"> -- <bean:write
																						name="RWS_USER" property="divisionOfficeName" />
																				</logic:notEqual> <br>
																			<logic:notEqual name="RWS_USER"
																					property="subdivisionOfficeCode" value="00"> -- <bean:write
																						name="RWS_USER" property="subdivisionOfficeName" />
																				</logic:notEqual> <br>[ <c:out value="${sessionScope.RWS_USER.officeName} User" /> ]
																		</b> 
																		<br><br>
																		Last Login :&nbsp;<bean:write name="RWS_USER" property="lastLoginTime" />
																		
																		
																		<br> <font class="title2"><br>
																				Rural&nbsp;Water&nbsp;Supply&nbsp;&&nbsp;Sanitation
																		</font></td>
																		<td align="right" valign="top"><img
																			src="<rws:context page='/images/aplogo.gif' />"></img>
																		</td>
																		<td width="57" valign="bottom"><A href="#"
																			onclick="changePasswordWindow('Secretary/rws_sec_changepass_frm.jsp?special=N&userId=<%=userid%>')">[Change&nbsp;Password]</A></td>
																		<td width="57" valign="bottom"><A
																			href="/pred/Logout.do">[Logout]</A></td>




																		<td>
																		<TD vAlign=top align=right></TD>
																	</TR>
																	<TR>
																		<TD vAlign=top colSpan=2 align=left>
																			<TABLE border=0 cellSpacing=0 cellPadding=0
																				width="100%">
																				<TBODY>


																					<TR>
																						<TD vAlign=top colSpan=2>
																							<TABLE border=0 cellSpacing=0 cellPadding=0
																								width="100%">
																								<TBODY>

																									<TR>
																										<TD vAlign=top colSpan=3>
																											<TABLE border=0 cellSpacing=0 cellPadding=0
																												width="100%">
																												<TBODY>
																												</TBODY>
																											</TABLE>
																							</TABLE>
																			</TABLE>
															</TABLE>
											</TABLE>



											<div id="tabs">
												<ul>
													<li><a href="#home1">Home</a></li>
													<li><a href="#master">Masters</a></li>
													<li><a href="#worksmon">Works</a></li>
													<li><a href="#fundacc">Fund</a></li>
													<li><a href="#water">W.Qty</a></li>
													<li><a href="#drought">Drought</a></li>
													<!-- SAIRAM 7-9-2022 <li><a href="#rfd">RFD</a></li> -->
													<!-- <li><a href="#alerts1">Alerts</a></li> -->
													<!-- <li><a href="#help">Help</a></li>-->
													<li><a href="#pushkar">Pushkar</a></li>

													<li><a href="#smsmobile">Mobile</a></li>
										<!-- 	sairam 7-9-2022		<li><a href="#download">Download</a></li> -->
													<!--  <li><a href="#helpdesk">Grievances</a></li>-->

													<li><a href="#theme">Theme</a></li>
												</ul>
												<div id="home1">
													<table width="868" border="0" align="center">


														<tr>
															<td align="right" colspan="8"><span
																class="indigo10pixel">&nbsp;&nbsp;&nbsp;Financial
																	Year</span>&nbsp;&nbsp;<span class="indigo10pixel"><select
																	class="select" id="finyear" onchange="getWorks()">
																		<%-- <% 

	try{
String finYear="";
String temp="";
 conn=nic.watersoft.commons.RwsOffices.getConn();
Statement stmt11=conn.createStatement();
int fy=0;int mm=0;
int fy1=0;
			String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4),substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
		//System.out.println("Fin"+ finquery);
			ResultSet rs11 = stmt11.executeQuery( finquery);
			while(rs11.next())
			{
				
				mm=Integer.parseInt(rs11.getString(2));
				 fy=Integer.parseInt(rs11.getString(1));
				 fy1=fy+1;
				 if(mm<4){
					 fy=fy-1;
					 fy1=fy1-1;
				 }
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
<-- new code start -->
 --%> 

																		<%
 	try {
 			Date sysdate = new Date();
 			SimpleDateFormat format = new SimpleDateFormat("yyyy");
 			SimpleDateFormat format1 = new SimpleDateFormat("M");
 			String Year = format.format(sysdate);
 			String month = format1.format(sysdate);
 			//System.out.println("Current Year" + Year + "Month" + month);
 			String finYear = "";
 			String temp = "";
 			conn = nic.watersoft.commons.RwsOffices.getConn();
 			Statement stmt11 = conn.createStatement();
 			int fy = 0;
 			int mm = 0, cy = 0, cy1 = 0;
 			int fy1 = 0;
 			int count = 0, counts = 0;
 			;
 			//substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4),substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
 			String finquery = "select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4),substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
 			if (Integer.parseInt(month) >= 04) {
 				fy = Integer.parseInt(Year);
 				fy1 = fy + 1;
 				while (fy >= 2011) {

 					//System.out.println("cy-cy1" + count);

 					if (count == 0) {

 						//System.out.println(fy + "," + fy1 + "count" 								+ count);
 %>

																		<option style="display: none"></option>
																		<option value="<%=fy + "-" + fy1%>" selected><%=fy + "-" + fy1%></option>
																		<%
																			} else {
																								fy = fy - 1;
																								fy1 = fy + 1;
																								//System.out.println(fy + "," + fy1);
																		%>
																		<option value="<%=fy + "-" + fy1%>"><%=fy + "-" + fy1%></option>
																		<%
																			}
																							count++;

																						}
																		%>
																		<%
																			
																		%>
																		<%
																			} else if (Integer.parseInt(month) < 04) {
																						fy = Integer.parseInt(Year) - 1;//2016
																						fy1 = fy + 1;//2017
																						while (fy >= 2011) {

																							if (counts == 0) {
																		%>

																		<option style="display: none"></option>

																		<option value="<%=fy + "-" + fy1%>" selected><%=fy + "-" + fy1%></option>
																		<%
																			} else {
																								fy = fy - 1;
																								fy1 = fy + 1;
																		%>
																		<option value="<%=fy + "-" + fy1%>"><%=fy + "-" + fy1%></option>
																		<%
																			}
																							counts++;

																						}
																					}
																		%>
																		<%
																			} catch (Exception e) {
																					e.printStackTrace();
																				}
																		%> <!-- <--new code end --> -->

																</select> </span></td>



														</tr>


														<td colspan="2">
															<div id="resizable16" class="ui-widget-content">
																<h3 class="ui-widget-header">Works</h3>
																<table>
																	<!-- <tr>
																		<td></td>
																		<td align="right"><span class="indigo10pixel">PWS</span></td>
																		<td align="right"><span class="indigo10pixel">CPWS</span></td>
																	</tr> -->
																	<tr>
																		<td width="114" height="20" class="green">Ongoing</td>
																		<td width="95" class=text2><a id="set1"
																			title="Click here view details" href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=OnGoing&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ongoing" style="text-align: right !important;"></a></td>
																		<%-- <td width="95" class=text2><a href="#"
																			onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=OnGoing&type=03&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ongoing1" style="text-align: right !important;"></a></td> --%>
																	</tr>

																	<tr>
																		<td height=20 class=green>Not Grounded</td>
																		<td class=text2><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=NotGrounded&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="notground" style="text-align: right !important;"></a></td>
																		<%-- <td class=text2><a href="#"
																			onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=NotGrounded&type=03&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="notground1" style="text-align: right !important;"></a></td> --%>

																	</tr>
																	<tr>
																		<td height=20 class=green>Grounded</td>
																		<td class=text2><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=Grounded&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ground" style="text-align: right !important;"></a></td>
																		<%-- <td class=text2><a href="#"
																			onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Grounded&type=03&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ground1" style="text-align: right !important;"></a></td> --%>

																	</tr>

																	<tr>
																		<td height=20 class=green>Completed</td>
																		<td class=text2><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=Completed&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="completed" style="text-align: right !important;"></a></td>
																		<%-- <td class=text2><a href="#"
																			onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Completed&type=03&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="completed1" style="text-align: right !important;"></a></td> --%>

																	</tr>
																	<tr>
																		<td height=20 class=green>Under Progress</td>
																		<td class=text2><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=UnderProgress&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="underprogress" style="text-align: right !important;"></a></td>
																		<%-- <td class=text2><a href="#"
																			onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=UnderProgress&type=03&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="underprogress1" style="text-align: right !important;"></a></td> --%>

																	</tr>
																	<!-- <tr>
<td height=20 class=green>Commissioned</td>
                                              <td class=text2>
                                               <a href="#" onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Commissioned&type=0')""> <input type="text" class="noborder-text-box" readonly="true" name="commissioned" ></a>
                                              </td>
<td class=text2>
                                           <a href="#" onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Commissioned&type=0')"">     <input type="text" class="noborder-text-box" readonly="true" name="commissioned1" > </a>
                                              </td>
 
</tr> -->
																</table>
															</div>
														</td>

														<td><!-- <div id='ChartDiv' align='center'
																style="display: none">Chart.</div>
															<div id='ChartDiv1' align='center' style="display: none">Chart.</div> --></td>

														<td colspan="4">

															<div id="habcoverage" class="ui-widget-content">
																<h3 class="ui-widget-header">Alerts</h3>
																<marquee behavior="scroll" direction="up"
																	scrollamount="2" scrolldelay="2" onmouseover="stop()"
																	onmouseout="start()" height="220px">
																	<table width="100%" border="0" align="center"
																		cellpadding="0" cellspacing="30">
																		<tr class="alertmesg">
																			<td class=text2><%=theAlertMessage%></td>
																		</tr>
																		<tr>
																			<td></td>
																		</tr>
																	</table>
																</marquee>

															</div>
														</td>

														</tr>
													</table>
												</div>












												<table class="green">
													<tr>
														<td>
															<div id="master">
																<table border=0 cellSpacing=0 cellPadding=0 width="100%">
																	<tr>
																		<td>

																			<div id="resizable7" class="ui-widget-content">
																				<h3 class="ui-widget-header">Master Data Entry</h3>

																				<div id="accordion4">

																					<h3>
																						<a href="#">General Entry</a>
																					</h3>
																					<div>
																						<table class="green">



																							<!-- <tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data"
																										class="h4"><b class="green">1.</b>Mandal
																											Subdivision</a></span></td>
																							</tr>-->


<!-- <tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Panchayat.do"
																										class="h4"><b class="green">2.</b>Panchayat
																											Entry</a></span></td>
																							</tr>
 

																							<!-- <tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Village.do"
																										class="h4"><b class="green">3.</b>Village
																											Entry</a></span></td>
																							</tr>
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Habitation.do"
																										class="h4"><b class="green">4.</b>Habitation
																											Entry</a></span></td>
																							</tr> -->
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/ContaminationDetails.do"
																										class="h4"><b class="green">2.</b>Quality
																											Effected Habs Entry</a></span></td>
																							</tr>
																							<!-- <tr>

																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/PanchRaj.do&mode=data"
																										class="h4"><b class="green">3.</b>PanchayatRaj
																											Habitations</a></span></td>
																							</tr> -->

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Employee.do&mode=data"
																										class="h4"><b class="green">3.</b>Employee
																											Master</a></span></td>
																							</tr>

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList&mode1=init"
																										class="h4"><b class="green">4.</b>Employee
																											Search Form</a></span></td>
																							</tr>


																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Contractor.do&mode=data"
																										class="h4"><b class="green">5.</b>Contractor
																											Entry</a></span></td>
																							</tr>

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate"
																										class="h4"><b class="green">6.</b>Update
																											Contractor</a></span></td>
																							</tr>

																							<!-- <tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/school.do&mode=data"
																										class="h4"><b class="green">7.</b>School
																											Form</a></span></td>
																							</tr>

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data1"
																										class="h4"><b class="green">8.</b>Census
																											Village Mapping</a></span></td>
																							</tr>-->
																																													<%--	<% if(userid.length()==6 && (userid.substring(userid.length()-3).equals("000") )){ %>
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Panchayat.do"
																										class="h4"><b class="green">9.</b>Panchayat
																											Entry</a></span></td>
																							</tr>


																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Village.do"
																										class="h4"><b class="green">10.</b>Village
																											Entry</a></span></td>
																							</tr>
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Habitation.do"
																										class="h4"><b class="green">11.</b>Habitation
																											Entry</a></span></td>
																							</tr> 
																							
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/HabConvert.do"
																										class="h4"><b class="green">12.</b>Habitation
																											Conversion</a></span></td>
																							</tr> 
							<!-- 																                     <TR>
                     	<TD width="32%" bgColor=#ffffff height=32><FONT face=Verdana color=#000000 size=2><B><li><a href="switch.do?prefix=/masters&page=/HabConvert.do">Habitation Conversion</a></B></FONT></TD>
                     </TR>  -->
																								<%} %> --%>

																							<tr>
																						</table>
																					</div>




																					<h3>
																						<a href="#">Assets</a>
																					</h3>
																					<div>
																						<table class="green">






																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/Asset.do&mode=init"
																										class="h4"><b class="green">1.</b>Asset
																											Master</a></span></td>
																							</tr>



																							<!-- <tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=districts"
																										class="h4" target="_self"><b class="green">2.</b>Source
																											Yield Entry</a></span></td>

																							</tr> -->



																							<!--<tr>
																								<td class="h4"><span class="text2"><a
																										href="masters/rws_assets_convert_division_subdivision.jsp"
																										class="h4" target="_self"><b class="green">2.</b>Asset-Division
																											- Sub Division modification</a></span></td>
																							</tr>-->


																							<tr>
																						</table>
																					</div>













																					<h3>
																						<a href="#">Habitation & Sources</a>
																					</h3>
																					<div>
																						<table class="green">

																							<tr>

																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="/pred/masters/switch.do?prefix=/masters&page=/HabData.do"
																										class="h4"><b class="green">&nbsp;&nbsp;1.</b>Habitation
																											Status</a></span></td>
																							</tr>

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="masters/rws_Hab_SC_St_details_frm.jsp"
																										class="h4"><b class="green">&nbsp;&nbsp;2.</b>Habitation
																											SC/ST/Minority Status</a></span></td>
																							</tr>

																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/masters&page=/habSafeSuply.do&mode=init"
																										class="h4"><b class="green">&nbsp;&nbsp;3.</b>Coverage
																											Status Automation Form</a></span></td>
																							</tr>
																							<tr>
																								<td class="h4"><span class="text2"><a
																										href="switch.do?prefix=/masters&page=/FuncRepair.do&mode=init"
																										class="h4" target="_self"><b class="green">&nbsp;&nbsp;4.</b>Functional
																											Status of Assets</a></span></td>
																							</tr>

																						</table>

																					</div>

																					<!-- <h3>
																						<a href="#"> Sujala</a>
																					</h3>
																					<div>
																						<table class="green">
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/works&page=/ntrSujala.do&mode=data&special=reset"
																										class="h4" target="_self"><b class="green">&nbsp;&nbsp;1.</b>
																											Sujala Patakam </a> </span></td>

																							</tr>
																							<tr>
																								<td height=20 colspan="2" class="h4"><span
																									class="text2"><a
																										href="switch.do?prefix=/works&page=/ntrSujalaImpl.do&mode=data&special=reset"
																										class="h4"><b class="green">&nbsp;&nbsp;2.</b>
																											Sujala -Habitation & Sponsor Details </a>  </span></td>
																							</tr>

																			<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/ntrAssetConvert.do&mode=data&special=reset"
																					class="h4"><b class="green">&nbsp;&nbsp;3.</b>DONOR-TP To Asset Convert Form </a> <img
																					src="images/new.gif"> </span></td>
																		</tr>


																						</table>

																					</div>

																				</div>-->
																			</div> <!-- <div id="resizable7" class="ui-widget-content">
	<h3 class="ui-widget-header">Master Data Entry</h3>
<h3 class="ui-widget-header"></h3>
			
  <marquee  behavior="scroll" direction="up"><p> 

          <table class="green" >



<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data"  class="h4" ><b class="green">&nbsp;&nbsp;1.</b>Mandal Subdivision</a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Panchayat.do"  class="h4" ><b class="green">&nbsp;&nbsp;2.</b>Panchayat Entry</a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Village.do"  class="h4" ><b class="green">&nbsp;&nbsp;3.</b>Village Entry</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Habitation.do"  class="h4" ><b class="green">&nbsp;&nbsp;4.</b>Habitation Entry</a></span></td>
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/ContaminationDetails.do"  class="h4" ><b class="green">&nbsp;&nbsp;5.</b>Quality Effected Habs Entry</a></span></td>
</tr>
<tr>
 
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/PanchRaj.do&mode=data"  class="h4" ><b class="green">&nbsp;&nbsp;6.</b>PanchayatRaj Habitations</a></span></td>
</tr>
<tr>
 
      <td height=20 colspan="2" class="h4"><span class="text2"><a href="/pred/masters/switch.do?prefix=/masters&page=/HabData.do"  class="h4" ><b class="green">&nbsp;&nbsp;7.</b>Habitation Status</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="masters/rws_Hab_SC_St_details_frm.jsp"  class="h4" ><b class="green">&nbsp;&nbsp;8.</b>Habitation SC/ST/Minority Status</a></span></td>
</tr>



<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=data1"  class="h4" ><b class="green">&nbsp;&nbsp;9.</b>Census Village Mapping</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Asset.do&mode=init"  class="h4" ><b class="green">10.</b>Asset Master</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="masters/rws_assets_convert_division_subdivision.jsp"  class="h4" ><b class="green">11.</b>Asset-Division - Sub Division modification</a></span></td>
</tr>



<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Employee.do&mode=data"  class="h4" ><b class="green">12.</b>Employee Master</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList&mode1=init"  class="h4" ><b class="green">13.</b>Employee Search Form</a></span></td>
</tr>


<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/Contractor.do&mode=data"  class="h4" ><b class="green">14.</b>Contractor Entry</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/works&page=/WorkStatus.do&mode=contractorUpdate"  class="h4" ><b class="green">15.</b>Update Contractor</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/school.do&mode=data"  class="h4" ><b class="green">16.</b>School Form</a></span></td>
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=districts"  class="h4" target="_self"><b class="green">17.</b>Source Yield Entry</a></span></td>
       
</tr>

<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/works&page=/ntrSujala.do&mode=data&special=reset"  class="h4" target="_self"><b class="green">18.</b>NTR Sujala Patakam </a> <img src="images/new.gif"></span></td>
       
</tr>
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/works&page=/ntrSujalaImpl.do&mode=data&special=reset"  class="h4" ><b class="green">&nbsp;&nbsp;19.</b>NTR Sujala -Habitation & Sponsor Details </a> <img src="images/new.gif"> </span></td>
       </tr>	
  
       	</table></p>



</div> -->
																		<td>
																	</tr>
																	<td>
																		<div id="resizable12" class="ui-widget-content">
																			<h3 class="ui-widget-header">Master Reports</h3>
																			<div id="accordion1">
																				<h3>
																					<a href="#">Habitation Reports</a>
																				</h3>
																				<div>
																					<table class="green">
																						<!-- saira 7-9-2022<tr>
																							<td><b class="green">&nbsp;&nbsp;1.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi"
																								target="_self" class="h4">Free Format
																									Report&nbsp;&nbsp;</a></td>
																							<td><b class="green">&nbsp;&nbsp;2.</b></td>
																							<td><a
																								href="/pred/reports/rws_hab_status_forms.jsp"
																								target="_self" class="h4">CheckList Report</a></td>
																							<td><b class="green">&nbsp;&nbsp;3.</b></td>
																							<td><a
																								href="./reports/rws_coverage_status_frm1.jsp"
																								target="_self" class="h4"><br>Coverage
																									Status Directory Format-I</a></td>
																							<td><b class="green">&nbsp;&nbsp;4.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/reportsDisplay.do&mode=data"
																								target="_self" class="h4"><br>Coverage
																									Status Directory Format-II</a></td>
																						</tr> -->

																						<tr>
																							<!-- sairam 7-9-2022 <td><b class="green">&nbsp;&nbsp;5.</b></td>
																							<td><a
																								href="./reports/rws_hab_status_resource_rpt.jsp"
																								target="_self" class="h4"><br>Resources
																									At a Glance </a></td> -->
																							<!--  <td><b class="green">&nbsp;&nbsp;1.</b></td>
																							<td><a
																								href="./reports/rws_const_coverage_status_frm.jsp"
																								target="_self" class="h4">Constituency
																									Status</a></td>-->
																							<td><b class="green">&nbsp;&nbsp;2.</b></td>
																							<td><a
																								href="./reports/rws_habitation_abstract_rpt.jsp"
																								target="_self" class="h4">Status - Abstract
																									Report </a></td>
																									<td><b class="green">3.</b></td>
																							<td><a href="./reports/rws_HabPop_rpt.jsp"
																								target="_self" class="h4"><br>Hab LPCD
																									Population Report</a></td>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="/pred/reports/rws_household_con_frm.jsp"
																								target="_self" class="h4">Abstract
																									HouseHolds/House Connections Report</a></td>
																							<!--sairam 7-92022
																							 <td><b class="green">&nbsp;&nbsp;8.</b></td>
																							<td><a
																								href="./reports/rws_habs_cov_schemes_rpt.jsp"
																								target="_self" class="h4">Covered by Schemes</a></td> -->
																						</tr>
																						<tr>
																							<td><b class="green">&nbsp;&nbsp;5.</b></td>
																							<td><a
																								href="./reports/rws_hab_cov_hps_rpt.jsp"
																								target="_self" class="h4">Covered by HPs </a></td>
																							<td><b class="green">6.</b></td>
																							<td><a
																								href="./reports/rws_list_habs_notcovered_frm.jsp"
																								target="_self" class="h4"><br>Not
																									Covered by Schemes</a></td>
																							<td><b class="green">7.</b></td>
																							<td><a
																								href="./reports/rws_asset_abstract_rpt.jsp"
																								target="_self" class="h4">Asset Abstract
																									Report </a></td>
																							<td><b class="green">8.</b></td>
																							<td><a href="./reports/rws_dist_pop_frm.jsp"
																								target="_self" class="h4">Population Range</a></td>
																						</tr>
																						<tr>
																							<td></td>
																						</tr>
																						<tr>
																							<td><b class="green">9.</b></td>
																							<td><a
																								href="./reports/rws_dist_pop_frm1.jsp"
																								target="_self" class="h4">Status Wise </a></td>
																							<td><b class="green">10.</b></td>
																							<td><a
																								href="./reports/rws_dist_pop_frm2.jsp"
																								target="_self" class="h4">Category Wise</a></td>
																							<td><b class="green">11.</b></td>
																							<td><a
																								href="./reports/rws_dist_pop_cons.jsp"
																								target="_self" class="h4">Constituency Wise</a></td>
																			<!--added by sairam  -->	<td><b class="green">12.</b></td>
																							<td><a
																								href="./reports/rws_slip_back_rpt.jsp"
																								target="_self" class="h4">Slipped Back
																									Details</a></td> 
																							<!-- sairam 7-9-2022
																							<td><b class="green"> 16.</b></td>
																							<td><a
																								href="./reports/rws_planning_format_frm.jsp"
																								target="_self" class="h4">Planning Report-I
																							</a></td> -->

																						</tr>

																						<!-- sairam 7-9-2022<tr>
																							<td><b class="green">17.</b></td>
																							<td><a
																								href="./reports/rws_planning_format1_frm.jsp"
																								target="_self" class="h4">Planing-Format-II</a></td>
																							<td><b class="green">18.</b></td>
																							<td><a
																								href="./reports/rws_planning_format2_frm.jsp"
																								target="_self" class="h4">Planing-Format-III
																							</a><br></td>
																							<td><b class="green">19.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/duplicates.do&mode=data"
																								target="_self" class="h4">Duplicates List</a></td>
																							<td><b class="green">20.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/unidentified.do&mode=data"
																								target="_self" class="h4">UnIdentified
																									Habitations </a></td>

																						</tr>


																						<tr>
																							<td><b class="green">21.</b></td>
																							<td><a
																								href="./reports/rws_hab_updates_frm.jsp"
																								target="_self" class="h4">Month Wise
																									Updations</a></td>
																							<td><b class="green">22.</b></td>
																							<td><a
																								href="./reports/rws_hab_status_form.jsp"
																								target="_self" class="h4">Location Status </a></td>
																							<td><b class="green">23.</b></td>
																							<td><a
																								href="./reports/rws_goi_coverage_frm.jsp"
																								target="_self" class="h4">District Wise -
																									GOI</a></td>
																							<td><b class="green">24.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/PublicInst.do?mode=data"
																								target="_self" class="h4">Public Institutes
																							</a></td>

																						</tr> -->
																
																						<tr> 
																							<td></td>
																						</tr>

																						<tr>
																							<!-- added above<td><b class="green">12.</b></td>
																							<td><a
																								href="./reports/rws_slip_back_rpt.jsp"
																								target="_self" class="h4">Slipped Back
																									Details</a></td> -->
																							<td><b class="green">13.</b></td>
																							<td><a
																								href="./reports/rws_Slipage_hab_frm.jsp"
																								target="_self" class="h4">Slippage Report </a></td>
																							<td><b class="green">14.</b></td>
																							<td><a
																								href="./reports/rws_Sources_hab_frm.jsp"
																								class="h4">Source Details</a></td>
																							<td><b class="green">15.</b></td>
																							<td><a
																								href="./reports/rws_Fc_schemes_frm.jsp"
																								target="_self" class="h4">Assets Report </a></td>
																								<td><b class="green">16.</b></td>
																							<td><a
																								href="./reports/rws_ntr_sujala_impl_detail_frm.jsp"
																								target="_self" class="h4"> Sujala
																									Habitation Details </a> <img src="images/new.gif">
																							</td>
																						</tr>
																						<tr>
																		<!-- added at 3, 4<td><b class="green">29.</b></td>
																							<td><a href="./reports/rws_HabPop_rpt.jsp"
																								target="_self" class="h4"><br>Hab LPCD
																									Population Report</a></td>
																							<td><b class="green">30.</b></td>
																							<td><a
																								href="/pred/reports/rws_household_con_frm.jsp"
																								target="_self" class="h4">Abstract
																									HouseHolds/House Connections Report</a></td> -->
																							<!-- sairam<td><b class="green">31.</b></td>
																							<td><a
																								href="./reports/Habitation/Rws_Ntr_Sujala_Patakam_Abs_Rpt.jsp"
																								target="_self" class="h4"> Sujala
																									Patakam.(Abstract)</a> <img src="images/new.gif">
																							</td>
																							<td><b class="green">32.</b></td>
																							<td><a
																								href="./reports/Habitation/Rws_Ntr_Sujala_Patakam_Rpt_frm.jsp"
																								target="_self" class="h4"> Sujala Patakam
																									Details.</a> <img src="images/new.gif"></td>

 -->
																						</tr>
																						<tr>
																							<td><b class="green">17.</b></td>
																							<td><a
																								href="./reports/rws_ntr_sujala_impl_detail_frm.jsp"
																								target="_self" class="h4"> Sujala
																									Habitation Details </a> <img src="images/new.gif">
																							</td>
																							<td><b class="green">18.</b></td>
																							<td><a
																								href="./reports/Habitation/rws_habitation_status_details_frm.jsp"
																								target="_self" class="h4">Habitation Updated
																									Details</a> <img src="images/new.gif"></td>
																							<td><b class="green">19.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_asset_hab_abstract_frm.jsp"
																								target="_self" class="h4">Habitation
																									Information Report</a> <img src="images/new.gif">
																							</td>
																							<!-- sairam 7-9-2022<td><b class="green">36.</b></td>
																								<td><a
																									href="./reports/rws_ntr_sujala_gov_donor_rpt.jsp"
																									target="_self" class="h4">Status of Water Purification Plants installed through Donors/Government</a> <img src="images/new.gif">
																							</td>
																		 -->				</tr>
																					</table>

																				</div>
																				<h3>
																					<a href="#">Employee Reports</a>
																				</h3>
																				<div>
																					<table class="green">
																						<!--  <tr>
																							<td><b class="green">1.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/Employee.do&mode=checklist"
																								target="_self" class="h4">Check List</a>
																							<td>
																						</tr>
																						<tr>
																							<td><b class="green">2.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/Employee.do&mode=StatusForms"
																								target="_self" class="h4">Status Forms</a>
																							<td>
																						</tr>
																						<tr>
																							<td><b class="green">3.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/Employee.do&mode=DeptOptForms"
																								target="_self" class="h4">Department Opted</a>
																							<td>
																						</tr>
																						<tr>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/EmpSearch.do&mode=EmployeeList"
																								target="_self" class="h4">Employee Search</a>
																							<td>
																						</tr>-->
																						<tr>
																							<td><b class="green">5.</b></td>
																							<td><a
																								href="./reports/rws_employee_work_frm.jsp"
																								target="_self" class="h4">Employee Work
																									Details </a>
																							<td>
																						</tr>
																					</table>
																				</div>

																				<h3>
																					<a href="#">Asset</a>
																				</h3>
																				<div>
																					<table class="green">
																						<tr>
																							<td><b class="green">1.</b></td>
																							<td><a
																								href="./reports/rws_asset_cpws_rpt.jsp"
																								target="_self" class="h4">Details Report</a></td>
																							<!--<td><b class="green">2.</b></td>
																							<td><a
																								href="./reports/rws_asset_cpws_rpt1.jsp"
																								target="_self" class="h4">Checklist Report</a></td>-->
																							<td><b class="green">3.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/CheckList.do?mode=data"
																								target="_self" class="h4">Components
																									AbstractDrilldown</a></td>

																						</tr>
																						<tr>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="switch.do?prefix=/reports&page=/AssetFreeFormat.do?mode=data"
																								target="_self" class="h4">Asset Free Format
																									Report</a></td>
																							<!--<td><b class="green">5.</b></td>
																							<td><a
																								href="./reports/rws_hab_asset_status_no_frm.jsp"
																								target="_self" class="h4">Sources in
																									Habitation </a></td>
																							<td><b class="green">6.</b></td>
																							<td><a
																								href="./reports/arws_assetcount_frm.jsp"
																								target="_self" class="h4">Schemes-Habs
																									Benefitted</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">7.</b></td>
																							<td><a href="./reports/rws_hp_frm.jsp"
																								target="_self" class="h4">Handpumps Without
																									Borwells </a></td>
																							<td><b class="green">8.</b></td>
																							<td><a href="./reports/arws_schemes_frm.jsp"
																								target="_self" class="h4">Schemes Without
																									Sources/Reservoirs</a></td>
																							<td><b class="green">9.</b></td>
																							<td><a
																								href="./reports/rws_source_hab_asset_frm.jsp"
																								target="_self" class="h4">Source - Assets
																									Coverage </a></td>-->
																						</tr>
																						<tr>
																							<td><b class="green">10.</b></td>
																							<td><a
																								href="./reports/rws_AssetAbstract_report.jsp"
																								target="_self" class="h4">Abstract Report</a></td>
																							<td><b class="green">11.</b></td>
																							<td><a href="./reports/rws_Hp_rpt.jsp"
																								target="_self" class="h4">HP Abstract </a></td>
																							<td><b class="green">12.</b></td>
																							<td><a href="./reports/rws_Schemes_rpt.jsp"
																								target="_self" class="h4">Schemes Abstract</a></td>
																						<td><b class="green">13.</b></td>
																							<td><a
																								href="./reports/rws_onlyschemes_distwise_rpt.jsp"
																								target="_self" class="h4">Covered by
																									Schemes(Assets Data)</a></td>
																						</tr>

																						<tr>
																							<!-- <td><b class="green">14.</b></td>
																							<td><a
																								href="./reports/rws_asset_statement_rpt.jsp"
																								target="_self" class="h4">GOI Statement</a></td>-->
																							<td><b class="green">15.</b></td>
																							<td><a
																								href="./reports/rws_asurfaceohsr_frm.jsp"
																								target="_self" class="h4">GIS Information
																									Reports</a></td>
																							<td><b class="green">16.</b></td>
																							<td><a
																								href="./reports/rws_sourcesgis_frm.jsp"
																								target="_self" class="h4">GIS Sources
																									Information Report </a></td>

																						</tr>
																						<tr>
																							<!-- added at 12 <td><b class="green">16.</b></td>
																							<td><a
																								href="./reports/rws_onlyschemes_distwise_rpt.jsp"
																								target="_self" class="h4">Covered by
																									Schemes(Assets Data)</a></td> -->
																							<td><b class="green">17.</b></td>
																							<td><a
																								href="./reports/rws_onlyhp_distwise_rpt.jsp"
																								target="_self" class="h4">Covered by
																									HPs(Assets Data)</a></td>
																							<td><b class="green">18.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_asset_details_frm.jsp"
																								target="_self" class="h4">Assets Abstract</a></td>
																						</tr>

																						<tr>
																							<!--<td><b class="green">19.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_source_details_frm.jsp"
																								target="_self" class="h4">Yeild Updation
																									Status</a></td>-->
																							<td><b class="green">20.</b></td>
																							<td><a
																								href="./reports/rws_cpws_pws_cov_ass_frm.jsp"
																								target="_self" class="h4">Assets Priority
																									Report </a></td>
																							<td><b class="green">21.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_list_habs_notcovered_frm.jsp"
																								target="_self" class="h4">Not Covered by
																									Schemes(CPWS,PWS,MPWS,DP)</a></td>

																						</tr>
																						<tr>
																							<!--<td><b class="green">22.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_list_habs_notcovered_pws_frm.jsp"
																								target="_self" class="h4">Not Covered by
																									Schemes(CPWS,PWS,MPWS)</a></td>-->
																						</tr>

																						<tr>
																							<td><b class="green">23.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_district_wise_status_frm.jsp"
																								target="_self" class="h4">District Wise
																									HandPumps Status Report</a></td>
																							<!--<td><b class="green">24.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_district_wise_shpstatus_frm.jsp"
																								target="_self" class="h4">District Wise
																									Shallow HandPumps Status Report</a></td>-->
																							<td><b class="green">25.</b></td>
																							<td><a href="./reports/rws_bluefrog_frm.jsp"
																								target="_self" class="h4">RWSS & Blue Frog
																									GIS Co-ordinates</a></td>

																						</tr>
																						<tr>
																							<!--<td><b class="green">26.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_assetwise_habbenificiary_frm.jsp"
																								target="_self" class="h4">Asset Wise Hab
																									Benefited Report</a></td>-->
																						
																							<td><b class="green">27.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_asset_component_mobile_data_frm.jsp"
																								target="_self" class="h4">Assets and
																									Components Report - Image Status</a></td>
																									
																							<td><b class="green">28.</b></td>
																							<td><a
																								href="./reports/assetReports/rws_asset_image_frm.jsp"
																								target="_self" class="h4">Status of Images Uploaded</a></td>
																								
																						</tr>
																						<tr>
																						<td><b class="green">&nbsp;&nbsp;29.</b></td>
																						<td><a
																						href="./reports/assetReports/rws_asset_image_capturing_frm.jsp"
																						target="_self" class="h4">Month Wise Progress Report of Approved Geotagged Photographs</a></td>
																					<td><b class="green">&nbsp;&nbsp;30.</b></td>
																						<td><a href="./reports/assetReports/Rws_Asset_Functional_Status_Frm.jsp" target="_self" class="h4">Asset Functional Status</a></td>
																					<!-- <td><b class="green">&nbsp;&nbsp;31.</b></td>
																						<td><a
																						href="./reports/assetReports/rws_abstract_report_for_schemes_rpt.jsp"
																						target="_self" class="h4">Inspection Abstract Report For Schemes</a></td>
																					</tr>
																					<tr>
																						
																						<td><b class="green">32.</b></td>
																						<td><a
																						href="./reports/assetReports/rws_abstract_report_for_handpumps_rpt.jsp"
																						target="_self" class="h4">Inspection Abstract Report For Handpumps and Shallow Handpumps</a></td>
																					
	<td><b class="green">33.</b></td>
																					<td><a
																						href="./reports/assetReports/rws_abstract_report_his_rpt.jsp"
																						target="_self" class="h4">Inspection Abstract
																							Report for Schemes(Repeated Inspections)</a></td>
																							
																									<td><b class="green">&nbsp;&nbsp;34.</b></td>-->
																				<td>
																				<a
																						href="./reports/assetReports/district_wise_components_list.jsp"
																						target="_self" class="h4">Components Detailed Drill Report </a></td>
																									
																				
</tr>

																					</table>
																				</div>
																				<h3>
																					<a href="#">Fund Accounting</a>
																				</h3>
																				<div>
																					<table class="green">
																						<!-- <tr>
																							<td><b class="green">1.</b></td>
																							<td><a href="./reports/rws_pao_form.jsp"
																								target="_self" class="h4">PAO Details</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">2.</b></td>
																							<td><a
																								href="./reports/rws_head_of_acc_form.jsp"
																								target="_self" class="h4">Heads Details</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">3.</b></td>
																							<td><a href="./reports/rws_bank_rpt.jsp"
																								target="_self" class="h4">Account Details</a></td>
																						</tr> -->
																						<tr>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/IFSCEntry.do&mode=ViewReport"
																								target="_self" class="h4">IFSC Code Details</a></td>
																						</tr>
																					</table>
																				</div>


<!-- 		sairam 05-09-2022												<h3>
																					<a href="#">Schools</a>
																				</h3>
																				<div>
																					<table class="green">
																						<tr>
																							<td><b class="green">1.</b></td>
																							<td><a
																								href="switch.do?prefix=/masters&page=/schoolrep.do&mode=data"
																								target="_self" class="h4">Detailed Report</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">2.</b></td>
																							<td><a
																								href="./reports/rws_school_abstract_rpt.jsp"
																								target="_self" class="h4">Abstract Report</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">3.</b></td>
																							<td><a
																								href="./reports/rws_school_asset_rpt.jsp"
																								target="_self" class="h4">Asset/work Linkage
																									Status</a></td>
																						</tr>
																						<tr>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="./reports/rws_school_detailed_rpt.jsp"
																								target="_self" class="h4">School &
																									Anganwadies</a></td>

																						</tr>
																					</table>
																				</div> -->
																				<!-- <h3>
																					<a href="#">CM Reports <img
																						src="images/new.gif"></a>
																				</h3>
																				<div>
																					<table class="green">
																						<tr>
																							<td><b class="green">1.</b></td>
																							<td><a
																								href="./reports/rws_school_eduinsti_frm.jsp"
																								target="_self" class="h4">Schools
																									Institutions Abstract</a></td>
																						</tr>

																						<tr>
																							<td><b class="green">2.</b></td>
																							<td><a
																								href="./reports/rws_tanks_rpt_frm.jsp"
																								target="_self" class="h4">Water Facilites
																									Through Schemes</a></td>

																						</tr>
																						<tr>
																							<td><b class="green">3.</b></td>
																							<td><a
																								href="./reports/rws_detail_Handpumps_frm.jsp"
																								target="_self" class="h4">HandPumps Details</a></td>

																						</tr>
																						<tr>
																							<td><b class="green">4.</b></td>
																							<td><a
																								href="./reports/rws_tap_stand_existing_frm.jsp"
																								target="_self" class="h4">Taps and
										 															StandPosts Details</a></td>

																						</tr>
																					</table>
																				</div> -->
																</table>
															</div>

															</div>

														</td>
													</tr>
												</table>



												<!-- srinivas   works monitorning -->


												<div id="worksmon">
													<table border=0 cellSpacing=0 cellPadding=0 width="100%">
														<tr>
															<td>
																<div id="resizable7" class="ui-widget-content">
																	<h3 class="ui-widget-header">Works Monitorning
																		Data Entry</h3>
																	<h3 class="ui-widget-header"></h3>

																	<!--   <marquee  behavior="scroll" direction="up"><p>  -->

																	<table class="green">



																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/NotGrounded.do&mode=data&mode1=clear"
																					class="h4"><b class="green">1.</b>DPR/Permission
																						Status</a></span></td>
																		</tr>


																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/WorkStatus.do&mode=circles"
																					class="h4"><b class="green">2.</b>Work
																						Progress</a></span></td>
																		</tr>
																		<!--<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data&mode1=circles"
																					class="h4"><b class="green">3.</b>Update
																						Action Plan</a></span></td>
																		</tr>-->
																		<tr>

																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/Auglinkmain.do?mode=data"
																					class="h4"><b class="green">4.</b>Augmentation-MainScheme
																						Linkage</a></span></td>
																		</tr>
																		<tr>

																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/SchemeAsset.do&mode=circles"
																					class="h4"><b class="green">5.</b>Scheme-Asset
																						Integration</a></span></td>
																		</tr>
																		<!--<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/eoatFrm.do?mode=init"
																					class="h4"><b class="green">6.</b>Extension Of
																						Agreement Time</a></span></td>
																		</tr>

																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/worklocality.do&mode=data"
																					class="h4"><b class="green">7.</b>Works
																						Locality from</a></span></td>
																		</tr>-->
																		<!-- 
<tr>
       <td height=20 colspan="2" class="h4"><span class="text2"><a href="switch.do?prefix=/works&page=/aap.do&mode=data&mode1=circles"  class="h4" ><b class="green">9.</b>Annual Action Plan</a></span></td>
</tr>

 -->
																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=circles"
																					class="h4"><b class="green">8.</b>Probable
																						Date of Comp</a></span></td>
																		</tr>
																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/HabLink.do&mode=data"
																					class="h4"><b class="green">9.</b>Work Hab
																						Link</a></span></td>
																		</tr>
																	    <tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/workUpdation.do?mode=data&mode1=clear"
																					class="h4"><b class="green">10.</b>Work
																						Updation- SC/ST Sub Plan & AAP</a>  </span></td>
																		</tr>

																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/works&page=/MultipleSource.do&mode=init"
																					class="h4"><b class="green">11.</b>Multiple
																						Source Entry</a></span></td>
																		</tr>

																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/works&page=/LeadHab.do&mode=data&special=reset"
																					class="h4"><b class="green">12.</b>Lead
																						Habitation Updation</a></span></td>
																		</tr>
																		<!-- <tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/works&page=/ntrSujalaImpl.do&mode=data&special=reset"
																					class="h4"><b class="green">13.</b>NTR Sujala
																						-Habitation & Sponsor Details </a> <img
																					src="images/new.gif"> </span></td>
																		</tr> -->
																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=circles"
																					class="h4"><b class="green">13.</b>Works
																						To Be Displayed In CM Dashboard </a>  </span></td>
																		</tr>
																		
																		
																	</table>
																	</p>


																	<!--  </marquee> -->
																</div>
															<td>
																<div id="resizable13" class="ui-widget-content">
																	<h3 class="ui-widget-header">Works Monitoring
																		Reports</h3>
																	<div id="accordion5">

																		<h3>
																			<a href="#">Performance Reports</a>
																		</h3>
																		<div>

																			<table class="green">

																			<!-- SAIRAM 7-9-2022	<tr>
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_works_program_details_frm.jsp"
																						target="_self">Abstract Works Spill Over/ New</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_work_status_new_frm.jsp"
																						target="_self">Completed Not Commisioned</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_work_program_fin_notcompl_frm.jsp"
																						target="_self">Financially Not Completed </a></td>
																				</tr> -->
																				<td><b class="green">1.</b></td>
																				<td><a
																					href="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi"
																					target="_self">Free Format Report</a></td>
																				<!-- SAIRAM 7-9-2022--> <tr>
																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_sc_st_subplan_frm.jsp"
																						target="_self">SC/ST Sub Plan </a><img
																						src="images/new.gif"></td>
																				</tr> 

																						<!--<tr>	
<td><b class="green">6.</b></td><td>
<a href="./reports/rws_sc_sp_subplan_frm.jsp" target="_self">SCSP(2013-2014) Pending Action Plan </a><img src="images/new.gif"> </td></tr>-->

																				<!-- SAIRAM 7-9-2022-->
																				<tr>
																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/Rws_Scsp_1415_ActionPlan_Detail_Frm.jsp"
																						target="_self">SCSP(2014-2015) Action Plan </a><img
																						src="images/new.gif"></td>
																				</tr> 


																			</table>
																		</div>
																		<h3>
																			<a href="#">Abstract Reports</a>
																		</h3>
																		<div>

																			<table class="green">
																				<!-- SAIRAM 7-9-2022<tr>
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_work_general_abstract_rpt_p.jsp"
																						target="_self">General Abstract Report
																							-Revised</a></td>
																				</tr>

																				<tr>
																				<tr>
																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/works/rws_user_work_progress_abstract_rpt.jsp"
																						target="_self">Work Progress Abstract
																							Report(NRDWP, NABARD, APRWSP_WB, 13TH FC)</a></td>
																				</tr> -->
																				<%
																					java.util.Date sysdate1 = new java.util.Date();
																						SimpleDateFormat format = new SimpleDateFormat("yyyy");
																						SimpleDateFormat format1 = new SimpleDateFormat("M");
																						String Year = format.format(sysdate1);
																						String month = format1.format(sysdate1);
																						int cy = 0, cy1 = 0;
																						cy = Integer.parseInt(Year);
																						if (Integer.parseInt(month) >= 04) {
																							cy1 = cy + 1;
																						} else {
																							cy = cy - 1;
																							cy1 = cy + 1;
																						}
																						//System.out.println(cy+"   "+cy1);
																				%>
																				<tr>
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_fin_year_rpt.jsp"
																						target="_blank">Progress Report <%=cy + "-" + cy1%></a>
																					</td>
																				</tr>
																				<tr>
																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/works/rws_work_key_per_progress_rpt.jsp"
																						target="_blank">Progress Report(Key
																							Performance Indicators)</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_district_rpt.jsp"
																						target="_blank">Abstract Progress
																							Report(District Level Programmes)</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_min_abstract_rpt.jsp"
																						target="_blank">Abstract Progress Report(State
																							Level Programmes)</a></td>
																				</tr>
																				<!-- SAIRAM 7-9-2022 <tr>
																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/works/rws_min_work_flow_status_cm_rpt.jsp"
																						target="_blank">Work Progress - Work Flow(New
																							Format)</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/works/rws_min_work_flow_stip_date_rpt.jsp"
																						target="_blank">Work Flow and Progress
																							Duration Status (as per stipulated date of
																							completion)</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">9.</b></td>
																					<td><a
																						href="./reports/works/rws_work_key_per_prgs_extend_rpt.jsp"
																						target="_blank">Progress Report(Key
																							Performance Indicators-Extended Report)
																					</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">10.</b></td>
																					<td><a
																						href="./reports/works/rws_min_works_not_ground_exceed_rpt.jsp"
																						target="_blank">Works Not Grounded - Post Administrative Sanction</a></td>
																				</tr>
																				<tr>
																						<td><b class="green">11.</b></td>
																						<td><a
																							href="./reports/works/rws_min_works_not_ground_exceed_rpt.jsp"
																							target="_blank">Works Not Grounded - Post Administrative Sanction</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">12.</b></td>
																					<td><a
																						href="./reports/works/rws_work_prog_phyComp_finNotComp_rpt.jsp"
																						target="_blank">Abstract
																							Progress Report for Physically Completed But Financially Not
																							completed Works<img
																							src="images/new.gif"></a></td>
																				</tr>
																				<tr>
																					<td><b class="green">13.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_cs_abstract_rpt.jsp"
																						target="_blank">ABSTRACT REPORT - WEEKLY REVIEW BY HON'BLE CHIEF SECRETARY WITH DISTRICT COLLECTORS</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">14.</b></td>
																					<td><a
																						href="./reports/rws_work_flow_dist_mandal_programme_cm_rpt.jsp"
																						target="_blank">Work Progress - Work Flow -District Mandal Wise</a></td>
																				</tr> -->
																				<tr>
																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_new_abstract_rpt.jsp"
																						target="_blank">Work Progress - JJM Report (New)</a></td>
																				</tr>
																				<tr>
																			</table>
																			</p>
																		</div>
																		<!--<h3>
																			<a href="#">AAP & Ongoing Works & Analysis
																				Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<!-- sairam 7-9-2022 <tr>
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_works_habtype_ongoing_rpt.jsp?"
																						target="_self">SC/ST/PLAIN - Detailed</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_ongoing_abstract.jsp"
																						target="_self">Ongoing Works Abstract</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_work_habsubtype_abstract_rpt.jsp?"
																						target="_self">SC/ST/PLAIN - Abstract Report</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/AAP/rws_work_hab_target_frm.jsp"
																						target="_self">AAP Format-1</a><img
																						src="images/new.gif">
																				</tr>

																				<tr>
																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/AAP/rws_wrk_hab_target_abstract_frm.jsp"
																						target="_self">AAP Abstract</a><img
																						src="images/new.gif">
																				</tr>

																				<tr>
																					<td><b class="green">6.</b></td>
																					<td><a href="./reports/AAP/rws_aap_frm1.jsp"
																						target="_self"> AAP Habitations Coverage</a><img
																						src="images/new.gif">
																				</tr>


																				<tr>
																					<td><b class="green">7.</b></td>
																					<td><a
																						href="./reports/AAP/Rws_AAP_All_Schemes_Frm.jsp"
																						target="_self"> AAP Schemes</a><img
																						src="images/new.gif">
																				</tr>

																				<tr>
																					<td><b class="green">8.</b></td>
																					<td><a
																						href="./reports/AAP/Rws_AAP_QA_Schemes_Frm.jsp"
																						target="_self">AAP Schemes - QA</a><img
																						src="images/new.gif">
																				</tr>
 -->
																				<!--<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/works/rws_ongoing_works_det_frm.jsp"
																						target="_self">Ongoing Works Progress</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_PhyCom_FinNotCom_frm.jsp"
																						target="_self"> Phy Completed Fin Not
																							Completed Works</a></td>
																				</tr>-->
																				<!-- sairam 7-9-2022 <tr>
																					<td><b class="green">11.</b></td>
																					<td><a
																						href="./reports/AAP/Rws_AAP_OTA_Works_Frm.jsp"
																						target="_self">AAP Ongoing, Target and
																							Achievement Progress</a><img src="images/new.gif">
																					</td>
																				</tr>
																				<tr>

																					<td><b class="green">12.</b></td>
																					<td><a
																						href="./reports/AAP/Rws_AAP_OTA_Works_Frm.jsp"
																						target="_self">AAP Ongoing, Target and
																							Achievement Progress</a><img src="images/new.gif">
																				</tr>
																				<tr>
																					<td><b class="green">13.</b></td>
																					<td><a
																						href="./reports/rws_achie_analy_cm_rpt.jsp"
																						target="_blank">Target and Achievement
																							Analysis report</a><img src="images/new.gif">
																				</tr> 
																				<tr>
																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/works/rws_work_progress_CM_abstract_rpt.jsp"
																						target="_blank">Work Progress Abstract</a><img
																						src="images/new.gif">
																				</tr>


																			</table>

																		</div>-->
												<!--	sairam 7-9-2022		<h3>
																			<a href="#">Checklist</a>
																		</h3>
																		 <div>
																			<table class="green">
																				<tr>
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="../reports/rws_admn_status_form.jsp"
																						target="_self">Admin Sanction</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_tech_status_form.jsp"
																						target="_self">Technical Sanction</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_contractor_frm.jspp"
																						target="_self">Contractor Management </a></td>
																				</tr>
																				<tr>
																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_program_sched_frm.jsp"
																						target="_self">Program Schedule</a></td>
																					</td>
																				<tr>
																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_work_expenditure_frm.jsp"
																						target="_self">Work Expenditure </a></td>
																				</tr>
																				<tr>
																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/rws_work_completion_frm.jsp"
																						target="_self">Work Completion</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">7.</b></td>
																					<td><a href="./reports/rws_integrated_rpt.jsp"
																						target="_self">Integrated Work Checklist</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">8.</b></td>
																					<td><a
																						href="./reports/rws_works_ALL_integrated_rpt.jsp"
																						target="_self">All Works Integrated Checklist</a></td>
																				</tr>
																			</table>
																		</div> -->

																		<h3>
																			<a href="#">Detailed Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<!-- sairam 7-9-2022 <tr>
																					<td><b class="green">&nbsp;&nbsp;1.</b></td>
																					<td><a
																						href="switch.do?prefix=/proposals&page=/Workwise.do?mode=circles"
																						target="_self">WorkWise Report </a></td>
																					<td><b class="green">&nbsp;&nbsp;2.</b></td>
																					<td><a
																						href="./reports/rws_prajapatham_workstatus_select.jsp"
																						target="_self">Work Status </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																					</td>
																					<td><b class="green">&nbsp;&nbsp;3.</b></td>
																					<td><a href="./reports/rws_mnth_frm.jsp"
																						target="_self">Monthly Progress Report </a></td>
																				</tr>
																				<tr>
																					<td><b class="green">&nbsp;&nbsp;4.</b></td>
																					<td><a
																						href="./reports/rws_work_valueofwork_notpaid_rpt.jsp?"
																						target="_self">ValueOf WorkDone ButNot Paid </a></td>
																					<td><b class="green">&nbsp;&nbsp;5.</b></td>
																					<td><a
																						href="./reports/rws_qa_habs_covered_31032010.jsp"
																						target="_self">QA Habs Covered By 31.03.2010 </a>
																					</td>
																					<td><b class="green">&nbsp;&nbsp;6.</b></td>
																					<td><a
																						href="./reports/rws_spill_ncnsspc1habs_covered_10_11.jsp"
																						target="_self"><br>Hab Coverage of
																							SpillOver Works </a></td>
																				</tr>
																				<tr>
																					<td><b class="green">7.</b></td>
																					<td><a
																						href="./reports/rws_work_pendency_frm.jsp"
																						target="_self">Work Pendency Status Report</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																					</td>
																					<td><b class="green">8.</b></td>
																					<td><a href="./reports/rws_work_exp_frm.jsp"
																						target="_self">Payment Status Report </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
																					</td>
																				</tr>
																				<tr>

																					<td><b class="green">9.</b></td>
																					<td><a
																						href="./reports/rws_work_vouchers_frm.jsp"
																						target="_self"><br>Voucher Payment Status
																							Report</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

																					<td><b class="green">10.</b></td>
																					<td><a
																						href="./reports/rws_workid_search_frm.jsp"
																						target="_self">Work ID Based -Work Details</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																					</td>

																					<td><b class="green">11.</b></td>
																					<td><a
																						href="./reports/rws_project_shelf_frm.jsp"
																						target="_self">Project Shelf Districtwise
																							Report </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
																				</tr>
																				<tr>
																					<td><b class="green">12.</b></td>
																					<td><a
																						href="switch.do?prefix=/works&page=/workgap.do?mode=data"
																						target="_self"><br>Gap Report </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
																					</td>

																					<td><b class="green">13.</b></td>
																					<td><a
																						href="./reports/rws_work_ongoing_frm.jsp"
																						target="_self"><br>Ongoing Works -
																							Habitations Benefitted Report</a>
																						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

																					<td><b class="green">14.</b></td>
																					<td><a
																						href="./reports/rws_work_admn_tech_frm.jsp"
																						target="_self"><br>Diff. In Admn & Tech
																							Habs</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
																				</tr>


																				<tr>
																					<td><b class="green">15.</b></td>
																					<td><a
																						href="./reports/rws_work_probdate_frm.jsp"
																						target="_self"><br>Probable Completion
																							date View </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>
																					</td>

																					<td><b class="green">16.</b></td>
																					<td><a
																						href="./reports/rws_Pending_works_rpt.jsp"
																						target="_self"><br>Pending Works Report</a>
																						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>

																					<td><b class="green">17.</b></td>
																					<td><a
																						href="./reports/rws_works_exception_frm.jsp"
																						target="_self"><br>Status of Work
																							Progress Report</a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
																				</tr> -->

																				<tr>
																					<!-- sairam 7-9-2022 <td><b class="green">18.</b></td>
																					<td><a href="./reports/rws_Aap_frm.jsp"
																						target="_self"><br>AAP 2011-2012 Works</a>
																						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> -->
																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_ongoing_works_abs_frm.jsp"
																						target="_self">Ongoing Works
																							Progress(Abstract)</a></td>
																				</tr>







																			</table>
																		</div>
																	</div>
																</div>
															</td>



														</tr>

													</table>
												</div>

												<!-- Srinivas end -->














												<!-- Srinivas FundAccounting -->
												<div id="fundacc">
													<table border=0 cellSpacing=0 cellPadding=0 width="100%">
														<tr>
															<td></td>

















															<td>



																<div id="resizable15" class="ui-widget-content">
																	<h3 class="ui-widget-header">FundAccounting
																		Reports</h3>






																	<div id="accordion2">


																		<h3>
																			<a href="#">General Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_bill_history_frm.jsp"
																						target="_self" class="h4">Bill History Report</a>
																					</td>
																				</tr>
																	<!-- sairam 7-9-2022<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_Recipents_Paymnets_frm.jsp"
																						target="_self" class="h4">Receipts Vs Payments
																					</a></td>
																				</tr> -->
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_billvoucher_division_frm.jsp"
																						target="_self" class="h4">Division Wise
																							Bill-Voucher Details </a></td>
																				</tr>


																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_payment_details_frm.jsp"
																						target="_self" class="h4">Payment Details
																							Report </a></td>
																				</tr>
																				<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_program_works_rpt.jsp"
																						target="_self" class="h4">Work-Program
																							Releases </a></td>
																				</tr>

																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a
																						href="switch.do?prefix=/masters&page=/Contractor.do&mode=getContractorlist&special=reset"
																						target="_self" class="h4">Contractor Details
																							Report</a></td>
																				</tr>

																			</table>
																		</div>
																		<h3>
																			<a href="#">Financial Status Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<!-- <tr>

																					<td><b class="green">1</b></td>
																					<td><a
																						href="./reports/rws_bill_tobe_release_rpt.jsp"
																						target="_self" class="h4">Division Wise</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_bill_tobe_release_nrdwp_rpt.jsp"
																						target="_self" class="h4">NRDWP Related</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_biil_release_program_rpt.jsp"
																						target="_self" class="h4">Program Wise</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_work_details_exp_frm.jsp"
																						target="_self" class="h4">Work Wise</a></td>
																				</tr>

																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_direct_voucher_bill_frm.jsp"
																						target="_self" class="h4">Direct Bills -
																							Vouchers</a><img src="images/new.gif"></td>
																				</tr>-->
 
																				<tr>
																					<td><b class="green">&nbsp;&nbsp;6.</b></td>
																					<td class="h4"><a
																						href="./reports/fund/rws_bill_releases_rpt.jsp"
																						class="h4">Bill forwarded by EE Division</a></td>
																				</tr>

																			</table>
																			<br>

																			</p>
																		</div>

																		<h3>
																			<a href="#">Bank Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<tr>

																					<td><b class="green">1</b></td>
																					<td><a
																						href="./reports/rws_bank_process_frm.jsp"
																						target="_self" class="h4">Bill Wise Bank
																							Releases</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">2</b></td>
																					<td><a
																						href="./reports/rws_bankwise_State_frm.jsp"
																						target="_self" class="h4">Bill Wise State
																							Releases</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3</b></td>
																					<td><a href="./reports/rws_bill_pao_rpt.jsp"
																						target="_self" class="h4">State Bill Report</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">4</b></td>
																					<td><a href="./reports/rws_precedings_frm.jsp"
																						target="_self" class="h4">Bank Proceedings</a></td>
																				</tr>

<tr>

																					<td><b class="green">5</b></td>
																					<td><a href="./reports/rws_refunds_frm.jsp"
																						target="_self" class="h4">Refunds Abstract</a></td>
																				</tr>


																				<!--<tr>

																					<td><b class="green">6</b></td>
																					<td><a
																						href="./reports/rws_work_ddws_status_frm.jsp"
																						target="_self" class="h4">Project Shelf
																							Reports</a></td>
																				</tr>-->




																			</table>
																			<br>

																			</p>
																		</div>

																	</div>
															</td>
													</table>
												</div>







												<!-- drought srinivas -->

												<div id="drought">
													<table border=0 cellSpacing=0 cellPadding=0 width="100%">
														<tr>
															<td>
																<div id="resizable5" class="ui-widget-content">
																	<h3 class="ui-widget-header">Drought Data Entry</h3>
																	<h3 class="ui-widget-header"></h3>

																	<!--   <marquee  behavior="scroll" direction="up"><p>  -->

																	<table class="green">



																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/drought&page=/PowerTransport.do&mode=get2&special=reset"
																					class="h4"><b class="green">1.</b>Habitations
																						For Drought</a></span></td>
																		</tr>


																		<!--  <tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/drought&page=/TransportWaterDetail.do&mode=districts"
																					class="h4"><b class="green">2.</b>Daily
																						Entry(TRANS,HIRING)</a></span></td>
																		</tr>


																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/drought&page=/FlushDeep.do&mode=data&special=reset"
																					class="h4"><b class="green">3.</b>Flushing
																						Deepening of Borewells</a></span></td>
																		</tr>-->
																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/drought&page=/dailyReprot.do&mode=data&special=reset"
																					class="h4"><b class="green">4.</b>Daily Report
																						Abstract Entry</a></span></td>
																		</tr>
																		<!-- <tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/drought&page=/AdminstrativeSanction.do&mode=null"
																					class="h4"><b class="green">5.</b>Drought
																						Works</a></span></td>
																		</tr>
																															
																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/drought&page=/newsItem.do&mode=districts&special=reset&level=State"
																					class="h4"><b class="green">6.</b>News Paper
																						Clippings</a></span></td>
																		</tr>-->
																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/drought&page=/sstank.do&mode=data&special=reset"
																					class="h4"><b class="green">7.</b>Drought SS
																						Tanks</a></span></td>
																		</tr>
																	</table>
																	</p>

																	<!--  </marquee> -->
																</div>
															</td>










															<td>

																<div id="resizable15" class="ui-widget-content">
																	<h3 class="ui-widget-header">Drought Reports</h3>

																	<div id="accordion3">

																		<h3>
																			<a href="#">General Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<!--<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_drought_habitations_frm.jsp"
																						target="_self" class="h4">Contingency Abstract
																							Report</a></td>
																				</tr>-->
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a href="./reports/rws_drought_frm.jsp"
																						target="_self" class="h4">Drought Habitations
																							Report</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="switch.do?prefix=/drought&page=/DroughtReport.do&mode=get2"
																						target="_self" class="h4">Status report of
																							drought Habitations </a></td>
																				</tr>
																				<!--<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_drought_deepen_frm.jsp"
																						target="_self" class="h4">Abstract
																							Flushing/Deepnening </a></td>
																				</tr>
																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_news_paper_clippings_frm.jsp"
																						target="_self" class="h4">News Paper Clippings</a>
																					</td>
																				</tr>

																				<tr>

																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/rws_Typeof_Adverse_News_Item_frm.jsp"
																						target="_self" class="h4">Type Adverse News
																							Item Report</a></td>
																				</tr>-->

																				<tr>

																					<td><b class="green">7.</b></td>
																					<td><a
																						href="./reports/rws_drought_distinct_hab_frm.jsp"
																						target="_self" class="h4">Drought Distinct
																							Habitations Report</a></td>
																				</tr>


																			</table>
																		</div>

																		<h3>
																			<a href="#">Abstract Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<!--<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_drought_deepen_abst_frm.jsp"
																						target="_self" class="h4">Contingency Plan
																							Abstract-2</a></td>
																				</tr>-->
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_drought_daily_rpt.jsp"
																						target="_self" class="h4">Daily Report</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_drought_daily_comparision_consolidate_rpt.jsp"
																						target="_self" class="h4">Daily Comparision</a></td>
																				</tr>
																			<!-- 	<tr>

																				sairam 7-9-2022
																				 	<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_drought_ongoing_works_rpt.jsp"
																						target="_self" class="h4">On Going Works </a></td>
																				</tr>  -->
																				<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_drought_distwise_sstank_rpt.jsp"
																						target="_self" class="h4">SS Tank- Detailed</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_sstank_consolidated_rpt.jsp"
																						target="_self" class="h4">SS Tank-
																							Consolidated</a></td>
																				</tr>

																				<tr>

																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/rws_drought_drinking_water_situation_frm.jsp"
																						target="_self" class="h4">Abstract of Daily
																							Report on Drinking Water Situation ( Drought )</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">7.</b></td>
																					<td><a
																						href="./reports/rws_drought_contigencyplan_habs_frm.jsp"
																						target="_self" class="h4">Contigency Plan
																							Abstract Report(NEW)</a></td>
																				</tr>
																			</table>
																			<br>

																			</p>
																		</div>

																	</div>
															</td>
													</table>
												</div>


												<!-- drought end  -->









												<!-- water quality Srinivas-->


												<div id="water">
													<table border=0 cellSpacing=0 cellPadding=0 width="100%">
														<tr>
															<td>
																<div id="resizable5" class="ui-widget-content">
																	<h3 class="ui-widget-header">Water Quality Data
																		Entry</h3>
																	<h3 class="ui-widget-header"></h3>

																	<!--   <marquee  behavior="scroll" direction="up"><p>  -->

																	<table class="green">


																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&paramValue=34"
																					class="h4"><b class="green">1.</b>Lab Testing</a></span></td>
																		</tr>

																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/wquality&page=/WaterLabTestingParameter.do&mode=data"
																					class="h4"><b class="green">2.</b>Lab
																						Testing-9 Paramters</a></span></td>
																		</tr>

																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data&paramValue=13"
																					class="h4"><b class="green">3.</b>Lab
																						Testing-13 Paramters</a></span></td>
																		</tr>

																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data"
																					class="h4"><b class="green">4.</b>FTK Testing</a></span></td>
																		</tr>
																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/works&page=/RfdTraining.do?mode=data"
																					class="h4"><b class="green">5.</b>WQ Training
																						Entry</a> <img src="images/new.gif"> </span></td>
																		</tr>
																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/wquality&page=/sourceHab.do&mode=data&special=reset"
																					class="h4"><b class="green">6.</b>Single
																						Source Multiple Habitations</a></span></td>
																		</tr>
																	</table>



																</div>


															</td>
															<td>

																<div id="resizable15" class="ui-widget-content">
																	<!--<h3 class="ui-widget-header">Water Quality Reports</h3>
																	<div id="accordion44">


																		<h3>
																			<a href="#">General Reports</a>
																		</h3>
																		<div>
																			<table class="green">

																				<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/WaterQuality/rws_WQ_lab_coverage_frm_rpt.jsp"
																						target="_self" class="h4">WQ- Habs Coverage</a><img
																						src="images/new.gif"></td>
																				</tr>
																				<tr>
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a href="./reports/rws_lab_test_frm.jsp"
																						target="_self" class="h4">Lab Test Results</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a
																						href="./reports/rws_wq_data_proforam_frm.jsp"
																						target="_self" class="h4">Water Quality
																							Sources Proforma-1</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_wq_sam_res_loc_frm.jsp"
																						target="_self" class="h4">Status
																							Report-District Wise </a></td>
																				</tr>
																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a
																						href="./reports/rws_water_sample_abstract_frm.jsp"
																						target="_self" class="h4">Entry Status </a></td>
																				</tr>
																			</table>
																		</div>-->

																		<!-- <h3>
																			<a href="#">Abstract Reports</a>
																		</h3>
																		<div>
																			<table class="green">
																				<tr>

																					<td><b class="green">1.</b></td>
																					<td><a
																						href="./reports/rws_water_nsshabs_frm_rpt.jsp"
																						target="_self" class="h4">Habitaion Vs Water
																							Quality (Flouride,Salinity)</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">2.</b></td>
																					<td><a
																						href="./reports/rws_water_parameters_frm.jsp"
																						target="_self" class="h4">Physico-Chemical
																							Data</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">3.</b></td>
																					<td><a href="./reports/rws_Wq_Lab_rpt.jsp"
																						target="_self" class="h4">Labs-MPR</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_waterqtly_sources_tests_frm.jsp"
																						target="_self" class="h4">Abstract- Sources Vs
																							All Tests </a></td>
																				</tr>
																				<tr>

																					<td><b class="green">5.</b></td>
																					<td><a href="./reports/rws_WQ_lab_frm_rpt.jsp"
																						target="_self" class="h4">District Profile for
																							Quality Parameters</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">6.</b></td>
																					<td><a
																						href="./reports/rws_WQ_Habs_Coverage_Frm.jsp"
																						target="_self" class="h4">Habitation Coverage
																							By Test Results(Priority Based)</a></td>
																				</tr>
																				<tr>

																					<td><b class="green">7.</b></td>
																					<td><a
																						href="./reports/WaterQuality/rws_list_odf_gps_frm.jsp"
																						target="_self" class="h4">GRAM PANCHAYAT-LPCD</a>
																					</td>
																				</tr>


																				<tr>

																					<td><b class="green">8.</b></td>
																					<td><a href="./reports/rws_wq_samples_frm.jsp"
																						target="_self" class="h4">Abstract- Samples Vs
																							All Tests</a></td>
																				</tr>

																				<tr>

																					<td><b class="green">9.</b></td>
																					<td><a
																						href="./reports/rws_wq_ground_waterquality_post_data_district_frm.jsp"
																						target="_self" class="h4">Pre & Post Monsoon
																							Tests </a></td>
																				</tr>
																				<td><b class="green">10.</b></td>
																				<td><a
																					href="./reports/WaterQuality/rws_WQ_lab_coverageall_frm_rpt.jsp"
																					target="_self" class="h4">WQ- Habs
																						Coverage(2012 To 2014)</a><img src="images/new.gif">
																				</td>
																				</tr>

																				<tr>

																					<td><b class="green">11.</b></td>
																					<td><a
																						href="./reports/rws_WQ_nottestedsources_frm.jsp"
																						target="_self" class="h4">Sources Not Tested<img
																							src="images/new.gif"></a></td>
																				</tr>
																			</table>

																		</div>-->
																	</div>
																</div>
															</td>
														</tr>

													</table>


												</div>
<!-- sairam 5-09-2022							<div id="alerts1">
													<table class="green">
														<tr>
															<td>
																<div id="resizable8" class="ui-widget-content">
																	<h3 class="ui-widget-header">Alerts</h3>

																	<table>
																		<tr>
																			<td class="green">1.<a
																				href="/pred/help/Final PPT Dec-2013-Submitted.pptx"
																				class="h4">SE' S Conference
																					Dated:18-12-2013-Presentation.</a><img
																				src="images/new.gif"></td>

																		</tr>


																		<tr>
																			<td><b class="green">2.<a
																					href="./reports/Gaps/rws_no_household_habs_rpt.jsp"
																					target="_self">Habs not having house
																						connections</a><img src="images/new.gif" /></td>
																		</tr>
																		<tr>
																			<td><b class="green">3.<a
																					href="./reports/Gaps/rws_pop_lessthan50_hab_rpt.jsp"
																					target="_self">Habs having population lessthan
																						50</a><img src="images/new.gif" /></td>
																		</tr>

																		<tr>
																			<td><b class="green">4.<a
																					href="./reports/Gaps/rws_pop_greaterthan3000_hab_rpt.jsp"
																					target="_self">Habs having population
																						greaterthan 3000</a><img src="images/new.gif" /></td>
																		</tr>
																		<tr>
																			<td><b class="green">5.<a
																					href="./reports/Gaps/rws_lpcd_lessthan10_hab_rpt.jsp"
																					target="_self">Habs having lpcd lessthan 10</a><img
																					src="images/new.gif" /></td>
																		</tr>
																		<tr>
																			<td><b class="green">6.<a
																					href="./reports/Gaps/rws_lpcd_greatethan500_hab_rpt.jsp"
																					target="_self">Habs having lpcd lessthan 500</a><img
																					src="images/new.gif" /></td>
																		</tr>

																		<tr>
																			<td height=20 colspan="2" class="h4"><span
																				class="text2"><a
																					href="switch.do?prefix=/complaints&page=/GenericActionTaken.do&mode=get2"
																					class="h4"><b class="green">7.</b>Generic
																						Action To Be Taken Form</a></span></td>
																		</tr>
																	</table>
																</div>
															</td>
															<td>

																<div id="resizable8" class="ui-widget-content">
																	<h3 class="ui-widget-header">Works Monitoring</h3>
																	<table class="green">
																		<tr>
<td>1.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_gaprep_compl_notcommenced_rpt.jsp')">Projects(MVS) Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
																		<tr>
																			<td>1.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcommisioned_rpt.jsp')">Projects(MVS)
																					Works(s) Admin Sanctioned - Not Commenced with >1
																					year(s) of Time Period </a></td>
																		</tr>
																		<tr>
																			<td>2.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_sec_gaprep_grounded_notcompl_wrks_rpt.jsp')">Projects(MVS)
																					Works(s) Grounded - Not Completed with >2 year(s)
																					of Time Period </a></td>
																		</tr>
																		
<tr>
<td>4.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_compl_notcommenced_rpt.jsp')">SVS Works(s) Completed - Not Commisioned with >3 year(s) of Time Period  </a></td></tr>
																		<tr>
																			<td>3.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcommisioned_rpt.jsp')">SVS
																					Works(s) Admin Sanctioned - Not Commenced with >1
																					year(s) of Time Period </a></td>
																		</tr>
																		
<tr>
<td>6.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_svs_gaprep_grounded_notcompl_wrks_rpt.jsp')">SVS Works(s) Grounded - Not Completed with >2 year(s) of Time Period </a></td></tr>
																		<tr>
																			<td>4.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_sec_works_not_comp.jsp?mode=san4')">
																					Work(s) Not completed - sanctioned > 4 year(s)/3
																					years/2 years ago </a></td>
																		</tr>
																		<tr>
																			<td>5.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_sec_works_not_comp_ground.jsp?mode=ground4')">
																					Work(s) Not completed - Grounded > 4 year(s)/3
																					years/2 years ago </a></td>
																		</tr>
																		<tr>
<td>7.</td><td><a href="#" class="h4" onclick="viewWorks('Secretary/rws_sec_works__comp_not_comm.jsp')"> Work(s) completed - Not Commissioned  </a></td></tr>
																		<tr>
																			<td>6.</td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_work_physical_per_updation.jsp')">
																					Works - Physical Percentage(%) Completion Status</a></td>
																		</tr>



																	</table>
																</div>
															</td>

														</tr>

													</table>
												</div> -->


												<!-- SAIRAM 7-9-2022 <div id="rfd">
													<table class="green">
														<tr>
															<td>

																<div id="resizable7" class="ui-widget-content">
																	<h3 class="ui-widget-header">
																		RFD<img src="images/new.gif">
																	</h3>
																	<table class="green">
																		<tr>

																			<td><b class="green">1.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_fin_phy_prg_ach_frm.jsp')">Financial
																					and Physical Achievements</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">2.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/rws_work_dpr_fin_frm.jsp')">DPR
																					Status Progress Report</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">3.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/rws_work_dpr_fin_StatusPermissions_frm.jsp')">DPR
																					Permission Status</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">4.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_rfd_schools_rpt.jsp')">Coverage
																					of Schools/Anganwadis with Drinking Water
																					Facilities </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">5.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/rws_svs_mvs_detail_rpt.jsp')">SVS
																					- MVS </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">6.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/rws_svs_mvs_prevcomp_curr_update_rpt.jsp')">Work
																					Completion Date Updation</a></td>
																		</tr>


																		<tr>
																			<td><b class="green">7.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_WQ_RFD_lab_frm.jsp')">Water
																					Quality-Lab Abstract </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">8.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_ftk_test_ftkuptomonth_sec_frm.jsp')">Water
																					Quality-FTK Abstract </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">9.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_rpt.jsp')">Scheme(MVS)-Hab
																					Status </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">10.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp')">Scheme(SVS)-Hab
																					Status </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">11.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Drought
																					Works Status</a></td>
																		</tr>

																	</table>

																</div>


															</td>
 -->
															<!-- SAIRAM 7-9-2022<td>

																<div id="resizable6" class="ui-widget-content">
																	<h3 class="ui-widget-header">
																		RFD Secretary<img src="images/new.gif">
																	</h3>
																	<table class="green">
																		<tr>

																			<td><b class="green">&nbsp;&nbsp;1.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_works_program_details_frm.jsp')">Abstract
																					Works Spill Over/ New</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;2.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_work_dpr_sec_StatusP_drill_frm.jsp')">Permission
																					Pending Status</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;3.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_work_dpr_fin_secpro_frm.jsp')">DPR
																					Status Progress Report</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;4.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_rfd_schools_rpt.jsp')">Coverage
																					of Schools/Anganwadis with Drinking Water
																					Facilities </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;5.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_svs_mvs_prevcomp_curr_update_rpt.jsp')">Work
																					Completion Date Updation </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;6.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_work_program_fin_notcompl_frm.jsp')">Physically
																					completed and Financially not completed</a></td>
																		</tr>


																		<tr>
																			<td><b class="green">&nbsp;&nbsp;7.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_WQ_RFD_lab_frm.jsp')">Water
																					Quality-Lab Abstract </a></td>
																		</tr>




																		<tr>
																			<td><b class="green">&nbsp;&nbsp;8.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_ftk_test_ftkuptomonth_sec_frm.jsp')">Water
																					Quality-FTK Abstract </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;9.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_rpt.jsp')">Scheme(MVS)-Hab
																					Status </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">10.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_asset_habs_status_svs_rpt.jsp')">Scheme(SVS)-Hab
																					Status </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">11.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Drought
																					Works Status</a></td>
																		</tr>



																		<tr>
																			<td><b class="green">12.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_svs_target_ach_rpt.jsp')">SVS-1</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">13.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_mvs_target_ach_rpt.jsp')">MVS-1</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">14.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_svs_target_ach_rel_rpt.jsp')">SVS-Releases</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">15.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_mvs_target_ach_rel_rpt.jsp')">MVS-Releases</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">16.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_sch_target_ach_rpt.jsp')">Schools</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">17.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./public_domain/rws_rfd_anganavadi_target_ach_rpt.jsp')">Anganwadi</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">18.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./reports/RFDReports/rws_rwss_action_plan_rfd_frm.jsp')">Habitaions
																					Achievement RFD</a><img src="images/new.gif"></td>
																		</tr>



																	</table>

																</div>
															</td>

														</tr>

													</table>
												</div>
 -->

												<!--<div id="help">
													<table class="green">
														<tr>
															<td>
																<div id="resizable6" class="ui-widget-content">
																	<h3 class="ui-widget-header">Help</h3>

																	<table class="green">
																		<tr>

																			<td><b class="green">&nbsp;&nbsp;1.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/assethelp.doc')">Asset</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;2.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/HabitationStatushelp.doc')">Habitation
																					Status</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;3.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/WorkFlow.doc')">Works
																					Monitoring</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;4.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/FundAccounting.doc')">Fund
																					Accounting </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;5.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/CommissionedworkAsset.doc')">Asset
																					Scheme Integration </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;6.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/panchayat.doc')">Panchayat</a></td>
																		</tr>


																		<tr>
																			<td><b class="green">&nbsp;&nbsp;7.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/village.doc')">Village
																			</a></td>
																		</tr>




																		<tr>
																			<td><b class="green">&nbsp;&nbsp;8.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/Hab.doc')">Habitation
																			</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;9.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/QualityEffectedHabs.doc')">Quality
																					Effected Habs </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">10.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/WaterQuality.doc')">Water
																					Quality </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">11.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/Help For PRED.htm')">Complete
																					Online Help</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">12.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/School.doc')">School
																					Form</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">13.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/DetailedProjectReport.doc')">Detailed
																					Project Report(DPR) Help</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">14.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks1('./help/PushkarWork.doc')">Pushkar</a></td>
																		</tr>

																		<tr>
																			<td><b class="green">15.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/SMS.doc')">SMS
																					Sending Procedure</a><img src="images/new.gif"></td>
																		</tr>

																		<tr>
																			<td><b class="green">16.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/SMS_FLOW.doc')">Help
																					Document for SMS Module</a><img src="images/new.gif"></td>
																		</tr>

																		<!-- <tr>
<td><b class="green">17.</b></td><td><a href="#" class="h4" onclick="viewWorks('./help/Tanker_Movement.doc')">Help Doccument for Tanker Movement and Works and Assets</a><img src="images/new.gif"></td></tr>
 

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;17.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/tankermovment.doc')">Help
																					Doccument for Tanker Movement </a><img
																				src="images/new.gif"></td>
																		</tr>

																		<tr>
																			<td><b class="green">&nbsp;&nbsp;18.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/worksandassets.doc')">Help
																					Doccument for Works and Assets</a><img
																				src="images/new.gif"></td>
																		</tr>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;19.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/RwssMonitoring.doc')">Help
																					Document for Water Monitoring</a><img
																				src="images/new.gif"></td>
																		</tr>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;20.</b></td>
																			<td><a href="#" class="h4"
																				onclick="viewWorks('./help/RwssSSTank.docx')">Help
																					Document for SS-Tank</a><img
																				src="images/new.gif"></td>
																		</tr>

																	</table>
																</div>

															</td>

														</tr>


													</table>
												</div>-->


												<div id="pushkar">
													<table class="green">
														<tr>
															<td>
																<div id="resizable7" class="ui-widget-content">
																	<h3 class="ui-widget-header">Data Entry</h3>

																	<table>


																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/pushkar&page=/PushkarGhat.do"
																					class="h4" target="_self"><b class="green">&nbsp;&nbsp;1.</b>Pushkar
																						Entry</a></span></td>
																		</tr>

																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/pushkar&page=/PushkarWork.do&mode=null"
																					class="h4"><b class="green">&nbsp;&nbsp;2.</b>PushkarGhat
																						Work Entry Form</a></span></td>
																		</tr>

																	</table>
															</td>

															<td>
																<div id="resizable13" class="ui-widget-content">
																	<h3 class="ui-widget-header">Pushkar Reports</h3>


																	<div id="accordion15">

																		<h3>
																			<a href="#">Detailed Reports <img
																				src="images/new.gif"></a>
																		</h3>

																		<div>



																			<table>


																				<tr>
																					<td><b class="green">&nbsp;&nbsp;1.</b></td>
																					<td><a
																						href="./reports/Pushkar/rws_pushkar_abstract_frm.jsp"
																						target="_self" class="h4">Pushkar Work Wise
																							Abstract Report</a></td>
																				</tr>
																				<tr>
																					<td><b class="green">&nbsp;&nbsp;2.</b></td>
																					<td><a
																						href="./reports/Pushkar/rws_pushkar_work_wise_progress_frm.jsp"
																						target="_self" class="h4">Work wise progress
																							Report</a></td>

																				</tr>
																				<tr>
																					<td><b class="green">&nbsp;&nbsp;3.</b></td>
																					<td><a
																						href="./reports/Pushkar/rws_Pushkar_Ghatwise_report1_frm.jsp"
																						target="_self" class="h4">Pushkar Abstract
																							Report</a></td>


																				</tr>


																			</table>

																		</div>
																	</div>
																</div>
																</div>


															</td>


														</tr>


													</table>
												</div>


												<div id="smsmobile">
													<table class="green">
														<tr>
															<td>
																<div id="resizable7" class="ui-widget-content">
																	<h3 class="ui-widget-header">SMS & MOBILE</h3>
																	<div id="accordion6">

																		<h3>
																			<a href="#">SMS Entry</a>
																		</h3>
																		<div>
																			<table class="green">
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/employeeEntry.do&mode=get"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;1.</b>Employee
																								Mobile Entry</a></span></td>
																				</tr>
																				<!--<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/masters&page=/ceo.do"
																							class="h4"><b class="green">&nbsp;&nbsp;2.</b>ZP
																								CEO/DPO Entry</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/masters&page=/mpdo.do"
																							class="h4"><b class="green">&nbsp;&nbsp;3.</b>MPDO/MRO/Section
																								Officer/EORD Entry</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/masters&page=/sarpanch.do"
																							class="h4"><b class="green">&nbsp;&nbsp;4.</b>Sarpanch
																								Entry</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/masters&page=/villagesec.do"
																							class="h4"><b class="green">&nbsp;&nbsp;5.</b>Village
																								Secretary Entry</a></span></td>
																				</tr>

																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/divisionMandal.do"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;6.</b>DLPO
																								Division Mandal Mapping</a></span></td>
																				</tr>

																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/dlpo.do"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;7.</b>DLPO
																								Entry</a></span></td>
																				</tr>-->	

																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/SmsRegistration.do&mode=get2&special=reset"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;8.</b>Registration
																								Form</a></span></td>
																				</tr>


																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=get2"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;9.</b>Authorize
																								Registered Users</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/ResidualChlorine.do"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;10.</b>Residual
																								Chlorine-Action Taken</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=get"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;11.</b>Schemes-Action
																								Taken</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=get"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;12.</b>Water
																								Tanker-Action Taken</a></span></td>
																				</tr>

																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=get"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;13.</b>OHSR
																								& GLSR Action Taken</a></span></td>
																				</tr>

																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=circles"
																							class="h4"><b class="green">&nbsp;&nbsp;14.</b>Progress
																								Report</a></span></td>
																				</tr>

																				


																			</table>
																		</div>
																		<h3>
																			<a href="#">Mobile Entry</a>
																		</h3>
																		<div>
																			<table class="green">
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/SmsRegistration.do&mode=get2&special=reset"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;1.</b>Registration
																								Form</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/TankerRegistration.do&mode=get2&special=reset"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;2.</b>Tanker
																								Registration Form</a></span></td>
																				</tr>
																				<tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do&mode=get2&special=reset"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;3.</b>Private
																								Source Entry Form</a></span></td>
																				</tr>
																				<!-- <tr>
																					<td class="h4"><span class="text2"><a
																							href="switch.do?prefix=/smsmobile&page=/SourceDestination.do&mode=get2&special=reset"
																							class="h4" target="_self"><b class="green">&nbsp;&nbsp;4.</b>Source
																								and Destination Entry Form</a></span></td>
																				</tr> -->
																				<tr>
																				<td class="h4"><span class="text2">
																				<a href="switch.do?prefix=/smsmobile&page=/TVM.do"
																				class="h4" target="_self"><b class="green">&nbsp;&nbsp;4.</b>Tanker Volunteer Mapping  Form</a></span></td>
																				</tr>
																			</table>
																		</div>
																	</div>
																</div>
															</td>

															<td>
																<div id="resizable13" class="ui-widget-content">
																	<h3 class="ui-widget-header">SMS & Mobile Reports</h3>


																	<div id="accordion15">

																		<table>
																			<!-- sairam 5-09-2022 <tr>
																				<td><b class="green">&nbsp;&nbsp;1.</b></td>
																				<td><a
																					href="./reports/smsmobile/rws_residual_act_tkn_status_report.jsp?mode=initial"
																					target="_self" class="h4">SMS Based - Report</a></td>
																			</tr>

																			<tr>
																				<td><b class="green">&nbsp;&nbsp;2.</b></td>
																				<td><a
																					href="./reports/smsmobile/rws_pull_push_report.jsp?mode=initial"
																					target="_self" class="h4">PULL & PUSH Details
																						Report</a></td>
																			</tr> -->
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;1.</b></td>
																				<td><a
																					href="./reports/smsmobile/rws_tanker_movement_rpt.jsp?mode=initial"
																					target="_self" class="h4">Tanker Movement -
																						Detailed Report</a></td>
																			</tr>
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;2.</b></td>
																				<td><a
																					href="./reports/smsmobile/rws_tanker_movement_tanker_statistics.jsp?mode=det"
																					target="_self" class="h4">Tanker Movement Statistics -
																						  Report</a><img
																					src="images/new.gif"></td>
																			</tr>

																			<!-- 5-09-2022<tr>
																				<td><b class="green">&nbsp;&nbsp;5.</b></td>
																				<td><a href="#" class="h4"
																					onclick="viewWorks('./help/SMS.doc')">SMS
																						Sending Procedure </a><img src="images/new.gif"></td>
																			</tr>

																			<tr>
																				<td><b class="green">&nbsp;&nbsp;6.</b></td>
																				<td><a href="#" class="h4"
																					onclick="viewWorks('./help/SMS_FLOW.doc')">Help
																						Doccument for SMS Module</a><img src="images/new.gif"></td>
																			</tr> -->

																			<!--<tr>
<td><b class="green">&nbsp;&nbsp;6.</b></td><td><a href="./downloads/mobile/WaterTankerMovement.apk" class="h4" >Download Tanker Movement Mobile App</a><img src="images/new.gif"></td></tr>
-->
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;3.</b></td>
																				<td><a
																					href="./downloads/mobile/RWSS_WaterTankerMovement_V1.0.apk"
																					class="h4">Download Tanker Movement Mobile App
																						(Updated on 23-07-2020)</a></td>
																			</tr>

																			<tr>
																				<td><b class="green">&nbsp;&nbsp;4.</b></td>
																				<td><a
																					href="./downloads/mobile/Rwss_Asset_V1.0.apk"
																					class="h4">Download Works and Assets Mobile
																						App (Updated on 23-07-2020)</a></td>
																			</tr>
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;5.</b></td>
																				<td><a
																					href="./downloads/mobile/water_monitoring.apk"
																					class="h4">Download Water Monitoring Mobile
																						App(Residual Chlorine,Asset/Component Images and Functional Status )</a></td>
																			</tr>
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;6.</b></td>
																				<td><a
																					href="./downloads/mobile/sstank.apk"
																					class="h4">Download SS Tank New Mobile
																						App</a></td>
																			</tr>
																			<tr>
																				<td><b class="green">&nbsp;&nbsp;7.</b></td>
																				<td><a
																					href="./downloads/mobile/volunteer_app.apk"
																					class="h4">Download Drinking Water Transportation Monitoring App(Grama Volunteer)</a><img
																					src="images/new.gif"></td>
																			</tr>



																		</table>

																		<div>



																			<table>




																			</table>

																		</div>
																	</div>
																</div>
																</div>


															</td>


														</tr>


													</table>
												</div>



												<!-- sairam 7-9-2022 <div id="download">
													<table class="green">
														<tr>
															<td>
																<div id="resizable6" class="ui-widget-content">
																	<h3 class="ui-widget-header">Help</h3>

																	<table>


																	</table>
															</td>

															<td>

																<div id="resizable6" class="ui-widget-content">
																	<h3 class="ui-widget-header">Download</h3>

																	<table>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;1.</b></td>
																			<td><a
																				href="./smsmobile/rws_DataDownload_frm.jsp"
																				class="h4">Data Download(Sources & Schemes)</a></td>
																		</tr>

																	</table>

																</div>
															</td>
															</div>

														</tr>


													</table>
												</div>

 -->







												<!-- <div id="helpdesk">
													<table border=0 cellSpacing=0 cellPadding=0 width="100%">
														<tr>
															<td>
																<div id="resizable5" class="ui-widget-content">
																	<h3 class="ui-widget-header">
																		Grievances Monitoring Forms
																	</h3>
																	<h3 class="ui-widget-header"></h3>

																	   <marquee  behavior="scroll" direction="up"><p>  

																	<table>

									
																		<tr>
																			<td height=20 colspan="2" class="green"><span
																				class="text2"><a
																					href="switch.do?prefix=/complaints&page=/Complaintsgeneric.do&mode=get2&special=reset"
																					class="h4"><b class="green">1.</b>Grievnace
																						Entry Form</a></span></td>
																		</tr>
																		<tr>
																			<td height=20 colspan="2" class="green"><span
																				class="text2"><a
																					href="switch.do?prefix=/complaints&page=/GenericActionTaken.do&mode=get2"
																					class="h4"><b class="green">2.</b>Generic
																						Action To Be Taken Form</a></span></td>
																		</tr>

																	</table>
																	</p>

																	  </marquee> 
																</div>
															</td>










			<!-- Sairam, 5-09-2022 -->												<!--<td>

																<div id="resizable15" class="ui-widget-content">
																	<h3 class="ui-widget-header">Grievances Monitoring
																		Reports</h3>

																	<div id="accordion3">

																		<h3>
																			<a href="#">General Reports</a>
																		</h3>
																		<div>
																			<table>
																				<tr>
																					<td class="green">1.<a
																						href="/pred/reports/complaints/rws_Generic_Complaints_rpt.jsp"
																						class="h4">Generic ActionTaken Report</a><img
																						src="images/new.gif"></td>

																				</tr>
																				<tr>
																					<td class="green">2.<a
																						href="./reports/complaints/rws_grievance_status_abstract_frm.jsp"
																						class="h4">Grievnace Status Abstract Report</a><img
																						src="images/new.gif"></td>
																				</tr>

																				<tr>
																					<td class="green">3.<a
																						href="./reports/complaints/rws_Grievances_Details_frm.jsp"
																						class="h4">Grievnace Details Report</a><img
																						src="images/new.gif"></td>
																				</tr>

																				<tr>
																					<td class="green">4.<a
																						href="./reports/complaints/rws_Nature_Of_Complaints_frm.jsp"
																						class="h4">Nature Of Compalints Abstract
																							Report</a><img src="images/new.gif"></td>
																				</tr>

																				<tr>
																					<td class="green">5.<a
																						href="./reports/complaints/rws_Action_Taken_frm.jsp"
																						class="h4">Action Taken(Nature) Abstract
																							Report</a><img src="images/new.gif"></td>
																				</tr>


																			</table>
																		</div>
-->



																	<!--</div>
															</td> 
													</table>
												</div> -->








												<div id="theme">
													<table class="green">
														<tr>
															<td>
																<div id="resizable3" class="ui-widget-content">
																	<h3 class="ui-widget-header">Themes</h3>
																	<br>
																	<br> <br>
																	<table class="green">
																		<tr></tr>
																		<tr>
																			<td><img src="images/admin2.jpg" width="100"
																				height="60" onclick="change(1)"></td>
																			<td><img src="images/eebg1.jpg" width="100"
																				height="60" onclick="change(2)"></td>
																			<td><img src="images/custom.jpg" width="100"
																				height="60" onclick="change(4)"></td>
																		</tr>
																	</table>
															</td>
															</div>

															</td>


														</tr>


													</table>

												</div>

											</div>




										</TD>
									</TR>
									<TR class="footerrow">
										<TD vAlign=top align=middle><div align="center">
												<p>&nbsp;</p>
												<p>
													<b><font class="footer">Designed &amp; Developed
															by National Informatics Centre, AP State Centre</font></b>
												</p>
											</div></TD>
									</TR>


								</TBODY>
							</TABLE>
						</TD>
					</TR>
				</TBODY>
			</TABLE>



		</form>
	</center>
</body>
</HTML>
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

