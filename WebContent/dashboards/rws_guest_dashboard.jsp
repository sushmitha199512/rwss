

<%@page import="java.util.Date"%>
<%
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String userid = users.getUserId();
	String isEmailRegistered = users.getIsEmailRegistered();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ include file="/reports/conn.jsp"%>
<%@ include file="rws_alerts.jsp"%>
<%@ include file="/commons/rws_header1.jsp"%>

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
	font-weight: bold;
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
	height: 250px;
	padding: 0.5em;
}

#resizable7 {
	width: 250px;
	height: 380px;
	padding: 0.5em;
}

#resizable8 {
	width: 500px;
	height: 440px;
	padding: 0.5em;
}

#resizable12 {
	width: 800px;
	height: 380px;
	padding: 0.5em;
}

#resizable13 {
	width: 800px;
	height: 380px;
	padding: 0.5em;
}

#resizable15 {
	width: 800px;
	height: 230px;
	padding: 0.5em;
}

#resizable14 {
	width: 800px;
	height: 380px;
	padding: 0.5em;
}

#resizable16 {
	width: 500px;
	height: 290px;
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

	});
	</script>

<script language="JavaScript">
function embedHide() {
    document.getElementById("banner").style.visibility = "hidden";
}

function embedVisible() {
    document.getElementById("banner").style.visibility = "visible";    
}
function openUserForm(){

	var emailReg='<%=isEmailRegistered%>';
	
	if(emailReg!="true"){
	 newwindow=window.open('switch.do?prefix=/admin&page=/users.do&mode=data','frameless','width=560,height=340,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=0,screenX=300,screenY=300,left=350,top=200');  
		 if (window.focus) {newwindow.focus()}
		//TINY.box.show({iframe:'switch.do?prefix=/admin&page=/users.do&mode=data',boxid:'frameless',width:600,height:400,fixed:true,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
	}
}
function openJS(){}
function closeJS(){}

function change(type){


	
	 var userid = '<%=userid%>';
if(type=="1"){
	
document.getElementById('theme_css').href = '/pred/resources/style/admin/css/page/jquery-ui-1.10.2.custom.css';
setCookie(userid,'1',365, {samesite:'strict', secure:true, sameparty:true} );
  } else if(type=="2"){
	  
	  
document.getElementById('theme_css').href = '/pred/resources/style/ee/css/start/jquery-ui-1.8.23.custom.css';
setCookie(userid,'2',365, {samesite:'strict', secure:true, sameparty:true});

}else if(type=="3"){
	
document.getElementById('theme_css').href = '/pred/resources/style/user/css/trontastic/jquery-ui-1.10.2.custom.css';
setCookie(userid,'3',365, {samesite:'strict', secure:true, sameparty:true});
} else if(type=="4"){
	
document.getElementById('theme_css').href = '/pred/resources/style/custom/css/start/jquery-ui-1.8.23.custom.css';
setCookie(userid,'4',365, {samesite:'strict', secure:true, sameparty:true});
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

function releasesChart(){
//alert("dddd");

   document.getElementById('ChartDiv').style.display='block';
   document.getElementById('ChartDiv1').style.display='none';	
var URL1="./dashboards/rws_dashboard_charts.jsp?type=relDiv&finyear="+finyear+"&userid="+userid;
ajaxFunction_Charts(URL1,1);
	setTimeout('expChart();','10000');
}
function expChart(){
  
   document.getElementById('ChartDiv').style.display='none';
 document.getElementById('ChartDiv1').style.display='block';

var URL1="./dashboards/rws_dashboard_charts.jsp?type=expDiv&finyear="+finyear+"&userid="+userid;

ajaxFunction_Charts(URL1,2);
setTimeout('releasesChart();','10000');

}

function creategraph(){
var obj1,obj2;
createChart('./FusionCharts/FCF_Column3D.swf',1,600,300,0,0,'','ChartDiv',obj1);
createChart('./FusionCharts/FCF_Doughnut2D.swf',2,600,300,0,0,'','ChartDiv1',obj2);
releasesChart();
}


function getWorks()
{

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
						updateChartXML('1', resp);
					} else if (type == 2) {
						updateChartXML('2', resp);
					}
				}

			} else {

			}
		}
		xmlHttp.open("GET", URL, true);
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
					//document.forms[0].ongoing1.value = mytool_array[1];

					document.forms[0].ground.value = mytool_array[2];
					//document.forms[0].ground1.value = mytool_array[3];

					document.forms[0].underprogress.value = mytool_array[4];
					//document.forms[0].underprogress1.value = mytool_array[5];

					document.forms[0].notground.value = mytool_array[6];
					//document.forms[0].notground1.value = mytool_array[7];

					document.forms[0].completed.value = mytool_array[8];
					//document.forms[0].completed1.value = mytool_array[9];

					//document.forms[0].commissioned.value = mytool_array[6];
					//document.forms[0].commissioned1.value = mytool_array[7];
				}

				document.getElementById('content').style.display = 'none';
			} else {

				document.getElementById('content').style.display = 'block';
			}
		}
		xmlHttp.open("GET", URL, true);
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
	function changePasswordWindow(URL) {
		var width = 320;
		var height = 250;
		var left = parseInt((screen.availWidth / 2) - (width / 2));
		var top = parseInt((screen.availHeight / 2) - (height / 2));
		var properties = "width="
				+ width
				+ ",height="
				+ height
				+ ",screenX="
				+ left
				+ ",screenY="
				+ top
				+ ",toolbar=no,"
				+ "status=no,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,"
				+ "resizable=no,status=yes,left=400,top=250";
		if (URL != "") {
			newwindow = window.open(URL, 'newWinddow', properties);
			if (window.focus) {
				newwindow.focus()
			}
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
			URL = "./reports/rws_work_gen.jsp?district=00&finyear=&planNonplan=1&drill=null&distname=ALL";
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
		document.forms[0].elements["finyear"].selectedIndex = 0;
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

<body onload="checkCookie('<%=userid%>');init();openUserForm();">

	<form name="master">



		<div id="content" style="display: none">
			<img src="images/loading1.gif" alt="Loading Wait..."
				title="Loading Wait...">
		</div>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width=1000 align=center>
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
																		src="<rws:context page='/images/rwss.gif' />"></img></td>
																	<td width="580" valign="top" align="center"
																		bordercolor="#FFFFFF"><!-- <embed
																			src="imagess/rural.swf" width="550px" height="130px"
																			id="banner"></embed> --></td>



																	<td class="title1"><b> Welcome, <bean:write
																				name="RWS_USER" property="userId" /> <br> <logic:notEqual
																				name="RWS_USER" property="circleOfficeCode"
																				value="00">
																				<bean:write name="RWS_USER"
																					property="circleOfficeName" />
																			</logic:notEqual> <logic:notEqual name="RWS_USER"
																				property="divisionOfficeCode" value="00"> -- <bean:write
																					name="RWS_USER" property="divisionOfficeName" />
																			</logic:notEqual> <br> <logic:notEqual name="RWS_USER"
																				property="subdivisionOfficeCode" value="00"> -- <bean:write
																					name="RWS_USER" property="subdivisionOfficeName" />
																			</logic:notEqual> [ <c:out
																				value="${sessionScope.RWS_USER.officeName} User" />
																			]
																	</b> <br> <font class="title2"><br>
																			Rural&nbsp;Water&nbsp;Supply&nbsp;&&nbsp;Sanitation </font></td>
																	<td align="right" valign="top"><img
																		src="<rws:context page='/images/aplogo.gif' />"></img>
																	</td>
																	<td width="57" valign="bottom"><A href="#"
																		onclick="changePasswordWindow('Secretary/rws_sec_changepass_frm.jsp?special=N&userId=<%=userid%>')">[Change&nbsp;Password]</A></td>
																	<td width="57" valign="bottom"><A
																		href="/pred/Logout.do">[Logout]</A></td>

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
												<li><a href="#worksmon">Works Monitoring</a></li>
												<li><a href="#fundacc">Fund Accounting</a></li>
												<li><a href="#water">Water Quality</a></li>
												<li><a href="#drought">Drought</a></li>
												<li><a href="#rfd">RFD</a></li>
												<!-- <li><a href="#alerts1">Alerts</a></li> -->
												<li><a href="#help">Help</a></li>
												<li><a href="#theme">Themes</a></li>
											</ul>
											<div id="home1">
												<table width="868" border="0" align="center">


													<tr>
														<td align="right" colspan="8"><span
															class="indigo10pixel">&nbsp;&nbsp;&nbsp;Financial
																Year</span>&nbsp;&nbsp;<span class="indigo10pixel"><select
																class="select" id="finyear" onchange="getWorks()">
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
																				//String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4),substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),4,2)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2011 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
																				if (Integer.parseInt(month) >= 04) {
																					cy = Integer.parseInt(Year);
																					cy1 = cy + 1;
																					while (cy >= 2011) {
																	%>
																	<option value="<%=cy + "-" + cy1%>" selected><%=cy + "-" + cy1%></option>
																	<%
																		cy = cy - 1;
																						cy1 = cy + 1;
																					}//}else{
																	%>
																	<%-- <option value="<%=fy+"-"+fy1%>"><%=fy+"-"+fy1%></option>  --%>
																	<%
																		} else if (Integer.parseInt(month) < 4) {
																					cy = Integer.parseInt(Year) - 1;//2016
																					cy1 = cy + 1;//2017
																					while (cy >= 2011) {

																						//System.out.println("cy-cy1" + cy + "-" + cy1);
																	%>
																	<option value="<%=cy + "-" + cy1%>" selected><%=cy + "-" + cy1%></option>
																	<%
																		cy = cy - 1;
																						cy1 = cy + 1;
																					}
																	%>
																	<%
																		}
																				//}
																				//}
																				//if(rs11!=null)rs11.close();
																				//if(stmt11!=null)stmt11.close();

																			} catch (Exception e) {
																				e.printStackTrace();
																			}
																	%>

															</select> </span></td>
													</tr>
													<tr>
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
																		<td width="95" class=text2 align="right"><a
																			id="set1" title="Click here view details" href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=OnGoing&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ongoing"
																				style="text-align: right !important;"></a></td>
																		<%-- <td width="95" class=text2 align="right"><a
																		href="#"
																		onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=OnGoing&type=03&userid=<%=userid%>')"><input
																			type="text" class="noborder-text-box" readonly="true"
																			name="ongoing1" style="text-align: right !important;"></a></td> --%>
																	</tr>

																	<tr>
																		<td height=20 class=green>Not Grounded</td>
																		<td class=text2 align="right"><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=NotGrounded&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="notground"
																				style="text-align: right !important;"></a></td>
																		<%-- <td class=text2 align="right"><a href="#"
																		onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=NotGrounded&type=03&userid=<%=userid%>')"><input
																			type="text" class="noborder-text-box" readonly="true"
																			name="notground1" style="text-align: right !important;"></a></td> --%>

																	</tr>
																	<tr>
																		<td height=20 class=green>Grounded</td>
																		<td class=text2 align="right"><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=Grounded&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="ground"
																				style="text-align: right !important;"></a></td>
																		<%-- <td class=text2 align="right"><a href="#"
																		onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Grounded&type=03&userid=<%=userid%>')"><input
																			type="text" class="noborder-text-box" readonly="true"
																			name="ground1" style="text-align: right !important;"></a></td> --%>

																	</tr>

																	<tr>
																		<td height=20 class=green>Completed</td>
																		<td class=text2 align="right"><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=Completed&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="completed"
																				style="text-align: right !important;"></a></td>
																		<%-- <td class=text2 align="right"><a href="#"
																		onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Completed&type=03&userid=<%=userid%>')"><input
																			type="text" class="noborder-text-box" readonly="true"
																			name="completed1" style="text-align: right !important;"></a></td>
 --%>
																	</tr>
																	<tr>
																		<td height=20 class=green>Under Progress</td>
																		<td class=text2 align="right"><a href="#"
																			onclick="viewReport('dashboards/rws_dashboard_works_list.jsp?name=UnderProgress&type=01&userid=<%=userid%>')"><input
																				type="text" class="noborder-text-box"
																				readonly="true" name="underprogress"
																				style="text-align: right !important;"></a></td>
																		<%-- <td class=text2 align="right"><a href="#"
																		onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=UnderProgress&type=03&userid=<%=userid%>')"><input
																			type="text" class="noborder-text-box" readonly="true"
																			name="underprogress1" style="text-align: right !important;"></a></td>
 --%>
																	</tr>
																	<%-- <tr>
<td height=20 class=green>Commissioned</td>
                                              <td class=text2>
                                               <a href="#" onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Commissioned&type=01&userid=<%=userid %>')"> <input type="text" class="noborder-text-box" readonly="true" name="commissioned" ></a>
                                              </td>
<td class=text2>
                                           <a href="#" onclick="viewWorks('dashboards/rws_dashboard_works_list.jsp?name=Commissioned&type=03&userid=<%=userid %>')">     <input type="text" class="noborder-text-box" readonly="true" name="commissioned1" > </a>
                                              </td>
 
</tr> --%>
																</table>
															</div>
														</td>

														<td><div id='ChartDiv' align='center'
																style="display: none">Chart.</div>
															<div id='ChartDiv1' align='center' style="display: none">Chart.</div></td>



													</tr>
												</table>
											</div>

											<table>
												<tr>
													<td>
														<div id="master">
															<table border=0 cellSpacing=0 cellPadding=0 width="100%">
																<td>
																	<div id="resizable12" class="ui-widget-content">
																		<h3 class="ui-widget-header">Master Reports</h3>
																		<div id="accordion1">
																			<h3>
																				<a href="#">Habitation Reports</a>
																			</h3>
																			<div>
																				<table>
																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																								href="switch.do?prefix=/reports&page=/flexReport.do?mode=inFlexi"
																								target="_self" ><b class="green">&nbsp;&nbsp;1.</b>Free
																									Format Report</a></span></td>


																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																								href="/pred/reports/rws_hab_status_forms.jsp"
																								target="_self" class="h4"><b class="green">&nbsp;&nbsp;2.</b>CheckList
																									Report</a></span></td>

																				

																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_coverage_status_frm1.jsp"
																							target="_self" class="h4"><br> <b
																								class="green">&nbsp;&nbsp;3.</b>Coverage Status
																								Directory Format-I</a></span></td>



																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="switch.do?prefix=/reports&page=/reportsDisplay.do&mode=data"
																							target="_self" class="h4"><br> <b
																								class="green">&nbsp;&nbsp;4.</b>Coverage Status
																								Directory Format-II</a></span></td>
																					</tr>

																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_hab_status_resource_rpt.jsp"
																							target="_self" ><b class="green">&nbsp;&nbsp;5.</b>Resources
																								At a Glance </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_const_coverage_status_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;6.</b>Constituency Status</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_habitation_abstract_rpt.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;7.</b>Status - Abstract
																								Report </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_habs_cov_schemes_rpt.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;8.</b>Covered by Schemes</a></span></td>
																					</tr>
																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_hab_cov_hps_rpt.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;9.</b>Covered by HPs </a></span></td>
																						<!-- <td><b class="green">10.</b></td><td><a href="./reports/rws_list_habs_notcovered_frm.jsp" target="_self" class="h4"><br>Not Covered by Schemes</a></td> -->
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_Sources_hab_frm.jsp"
																							class="h4"><b class="green">&nbsp;&nbsp;10.</b>Source Details</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_asset_abstract_rpt.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;11.</b>Asset Abstract
																								Report </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a href="./reports/rws_dist_pop_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;12.</b>Population Range</a></span></td>

																					</tr>
																					
																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a href="./reports/rws_dist_pop_frm1.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;13.</b>Status Wise </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a href="./reports/rws_dist_pop_frm2.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;14.</b>Category Wise</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_planning_format_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;15.</b>Planning Report-I </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_planning_format1_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;16.</b>Planing-Format-II</a></span></td>
																					</tr>

																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_planning_format2_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;17.</b>Planing-Format-III
																						</a><br></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="switch.do?prefix=/reports&page=/duplicates.do&mode=data"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;18.</b>Duplicates List</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="switch.do?prefix=/reports&page=/unidentified.do&mode=data"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;19.</b>UnIdentified
																								Habitations </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_hab_updates_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;20.</b>Month Wise
																								Updations</a></span></td>
																					</tr>


																					<tr>

																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_hab_status_form.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;21.</b>Location Status </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_goi_coverage_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;22.</b>District Wise - GOI</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="switch.do?prefix=/reports&page=/PublicInst.do?mode=data"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;23.</b>Public Institutes </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a href="./reports/rws_slip_back_rpt.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;24.</b>Slipped Back
																								Details</a></span></td>
																					</tr>
																				

																					<tr>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/rws_Slipage_hab_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;25.</b>Slippage Report </a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/Habitation/rws_habitation_status_details_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;26.</b>Habitation Updated
																								Details</a></span></td>
																						<td height=20 colspan="2" class="h4"><span
																							class="text2"><a
																							href="./reports/assetReports/rws_asset_hab_abstract_frm.jsp"
																							target="_self" class="h4"><b class="green">&nbsp;&nbsp;27.</b>Habitation
																								Information Report </a></span></td>

																					</tr>
																				</table>

																			</div>
																			<h3>
																				<a href="#">Employee Reports</a>
																			</h3>
																			<div>
																				<table>
																					<tr>
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
																					</tr>
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
																				<table>
																					<tr>
																						<td><b class="green">1.</b></td>
																						<td><a
																							href="./reports/rws_asset_cpws_rpt.jsp"
																							target="_self" class="h4">Details Report</a></td>
																						<td><b class="green">2.</b></td>
																						<td><a
																							href="./reports/rws_asset_cpws_rpt1.jsp"
																							target="_self" class="h4">Checklist Report</a></td>
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
																						<td><b class="green">5.</b></td>
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
																								Coverage </a></td>
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
																					</tr>
																				</table>
																			</div>
																			<h3>
																				<a href="#">Fund Accounting</a>
																			</h3>
																			<div>
																				<table>
																					<tr>
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
																						<td><a
																							href="./reports/rws_program_works_rpt.jsp"
																							target="_self" class="h4">Work-Program
																								Releases</a></td>
																					</tr>

																					<tr>
																						<td><b class="green">4.</b></td>
																						<td><a href="./reports/rws_bank_rpt.jsp"
																							target="_self" class="h4">BANK - Account
																								Details</a></td>
																					</tr>

																				</table>
																			</div>


																			<h3>
																				<a href="#">Schools</a>
																			</h3>
																			<div>
																				<table>
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
																			</div>
															</table>
														</div>

														</div>

													</td>
												</tr>
											</table>




											<!-- srinivas   works monitorning -->




											<div id="worksmon">
												<table border=0 cellSpacing=0 cellPadding=0 width="100%">


													<td>
														<div id="resizable13" class="ui-widget-content">
															<h3 class="ui-widget-header">Works Monitorning
																Reports</h3>
															<div id="accordion5">

																<h3>
																	<a href="#">Performance Reports</a>
																</h3>
																<div>

																	<table>
																		<tr>
																			<td><b class="green">1.</b></td>
																			<td><a
																				href="switch.do?prefix=/reports&page=/flexReport1.do?mode=inFlexi"
																				target="_self">Free Format Report</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">2.</b></td>
																			<td><a
																				href="./reports/rws_works_program_details_frm.jsp"
																				target="_self">Abstract Works Spill Over/ New</a></td>
																		</tr>

																	</table>
																</div>
																<h3>
																	<a href="#">Abstract Reports</a>
																</h3>
																<div>

																	<table>
																		<tr>
																			<td><b class="green">1.</b></td>
																			<td><a
																				href="./reports/rws_work_general_abstract_rpt_p.jsp"
																				target="_self">General Abstract Report -Revised</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">2.</b></td>
																			<td><a href="./reports/rws_works_frm.jsp"
																				target="_self">Total Works Vs Habs</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">3.</b></td>
																			<td><a
																				href="./reports/works/rws_work_key_per_progress_rpt.jsp"
																				target="_blank">Progress Report(Key Performance
																					Indicators)</a></td>
																		</tr>
<tr>
																					<td><b class="green">4.</b></td>
																					<td><a
																						href="./reports/rws_work_flow_dist_mandal_programme_cm_rpt.jsp"
																						target="_blank">Work Progress - Work Flow -District Mandal Wise</a></td>
																				</tr>
																	</table>
																	</p>
																</div>
																<h3>
																	<a href="#">Ongoing Works && Analysis Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>
																			<td><b class="green">1.</b></td>
																			<td><a
																				href="./reports/rws_works_habtype_ongoing_rpt.jsp?"
																				target="_self">SC/ST/PLAIN - Detailed</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">2.</b></td>
																			<td><a href="./reports/rws_ongoing_abstract.jsp"
																				target="_self">Ongoing Works Abstract</a></td>
																		</tr>
																		<br>

																		<tr>
																			<td><b class="green">3.</b></td>
																			<td><a
																				href="./reports/rws_work_habsubtype_abstract_rpt.jsp?"
																				target="_self">SC/ST/PLAIN - Abstract Report</a></td>
																		</tr>
																	</table>

																</div>
																<h3>
																	<a href="#">Checklist</a>
																</h3>
																<div>
																	<table>
																		<tr>
																			<td class="h4"><span class="text2"><a
																					href="switch.do?prefix=/wquality&page=/WaterLabTesting.do&mode=data"
																					class="h4"><b class="green">1.</b>Lab Testing</a></span></td>
																		</tr>

																		<tr>
																			<td><b class="green">1.</b></td>
																			<td><a href="./reports/rws_admn_status_form.jsp"
																				target="_self">Admin Sanction</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">2.</b></td>
																			<td><a href="./reports/rws_tech_status_form.jsp"
																				target="_self">Technical Sanction</a></td>
																		</tr>
																		<tr>
																			<td><b class="green">3.</b></td>
																			<td><a href="./reports/rws_contractor_frm.jspp"
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
																</div>

																<h3>
																	<a href="#">Detailed Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>
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
																				target="_self">QA Habs Covered By 31.03.2010 </a></td>
																			<td><b class="green">&nbsp;&nbsp;6.</b></td>
																			<td><a
																				href="./reports/rws_spill_ncnsspc1habs_covered_10_11.jsp"
																				target="_self"><br>Coverage of Habs Under
																					SpillOver Works </a></td>
																		</tr>
																		<tr>
																			<td><b class="green">&nbsp;&nbsp;7.</b></td>
																			<td><a href="./reports/rws_ongoing_abstract.jsp"
																				target="_self">Ongoing Works Abstract</a></td>
																			<td><b class="green">&nbsp;&nbsp;8.</b></td>
																			<td><a
																				href="./reports/rws_districtwise_statuswise_work_rpt.jsp"
																				target="_self"> NRDWP-COV Works Abstract</a></td>

																			<td><b class="green">&nbsp;&nbsp;9.</b></td>
																			<td><a href="./reports/rws_work_exp_frm.jsp"
																				target="_self">Payment Status Report </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">10.</b></td>
																			<td><a
																				href="./reports/rws_workid_search_frm.jsp"
																				target="_self">Work ID Based -Work Details</a></td>

																			<td><b class="green">11.</b></td>
																			<td><a
																				href="./reports/rws_project_shelf_frm.jsp"
																				target="_self">Project Shelf Districtwise Report
																			</a></td>

																			<td><b class="green">12.</b></td>
																			<td><a
																				href="./reports/rws_Pending_works_rpt.jsp"
																				target="_self"><br>Pending WorksMonitoring
																					Report </a></td>
																		</tr>
																		<tr>
																			<td><b class="green">13.</b></td>
																			<td><a href="./reports/rws_work_ongoing_frm.jsp"
																				target="_self"><br>Ongoing Works -
																					Habitations Benefitted Report</a></td>
																			<td><b class="green">14.</b></td>
																			<td><a
																				href="./reports/rws_ongoing_works_abs_frm.jsp"
																				target="_self">Ongoing Works Progress(Abstract)</a>
																			</td>
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












													<!-- FundAccounting end -->









													<td>



														<div id="resizable15" class="ui-widget-content">
															<h3 class="ui-widget-header">FundAccounting Reports</h3>






															<div id="accordion2">


																<h3>
																	<a href="#">General Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>
																			<td><b class="green">1.</b></td>
																			<td><a
																				href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureSchemeWiseBetweenDates.do&mode=betweenDates"
																				target="_self" class="h4">Scheme Wise Releases
																					Vs Expenditure</a>
																		</tr>
																		<tr>

																			<td><b class="green">2.</b></td>
																			<td><a
																				href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=init"
																				target="_self" class="h4">Programme Wise
																					Releases Vs Expenditure</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">3.</b></td>
																			<td><a
																				href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=ProgWiseDrillFrm"
																				target="_self" class="h4">Programme Wise Rpt2
																					Releases Vs Expenditure </a></td>
																		</tr>
																		<tr>

																			<td><b class="green">4.</b></td>
																			<td><a
																				href="./reports/rws_billvoucher_division_frm.jsp"
																				target="_self" class="h4">Division Wise
																					Bill-Voucher Details </a></td>
																		</tr>


																	</table>
																</div>
																<h3>
																	<a href="#">Project Shelf Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>

																			<td><b class="green">1.</b></td>
																			<td><a
																				href="./reports/rws_billvoucher_division_frm.jsp"
																				target="_self" class="h4">Project Shelf Reports
																			</a></td>
																		</tr>

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







													<td>

														<div id="resizable15" class="ui-widget-content">
															<h3 class="ui-widget-header">Drought Reports</h3>

															<div id="accordion3">

																<h3>
																	<a href="#">General Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>

																			<td><b class="green">1.</b></td>
																			<td><a
																				href="./reports/rws_drought_habitations_frm.jsp"
																				target="_self" class="h4">Contingency Abstract
																					Report</a></td>
																		</tr>
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
																		<tr>

																			<td><b class="green">4.</b></td>
																			<td><a
																				href="./reports/rws_drought_deepen_frm.jsp"
																				target="_self" class="h4">Abstract
																					Flushing/Deepnening </a></td>
																		</tr>

																		<tr>

																			<td><b class="green">5.</b></td>
																			<td><a
																				href="./reports/rws_drought_contigencyplan_habs_frm.jsp"
																				target="_self" class="h4">Contigency Plan
																					Abstract Report(NEW) </a></td>
																		</tr>
																		<tr>

																			<td><b class="green">6.</b></td>
																			<td><a
																				href="./reports/rws_drought_drinking_water_situation_frm.jsp"
																				target="_self" class="h4">Abstract of Daily
																					Report on Drinking Water Situation ( Drought ) </a></td>
																		</tr>


																		<tr>

																			<td><b class="green">7.</b></td>
																			<td><a
																				href="./reports/rws_news_paper_clippings_frm.jsp"
																				target="_self" class="h4">News Paper Clippings</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">8.</b></td>
																			<td><a
																				href="./reports/rws_Typeof_Adverse_News_Item_frm.jsp"
																				target="_self" class="h4">Type Adverse News Item
																					Report</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">9.</b></td>
																			<td><a
																				href="./reports/rws_drought_distinct_hab_frm.jsp"
																				target="_self" class="h4">Drought Distinct
																					Habitations Report</a></td>
																		</tr>
																		<tr>
																				<td><b class="green">&nbsp;&nbsp;10.</b></td>
																				<td><a
																					href="./reports/smsmobile/rws_tanker_movement_rpt.jsp?mode=initial"
																					target="_self" class="h4">Tanker Movement -
																						Detailed Report</a></td>
																			</tr>
																		
																		

																	</table>

																</div>

																<h3>
																	<a href="#">Abstract Reports</a>
																</h3>
																<div>
																	<table>
																		<tr>

																			<td><b class="green">1.</b></td>
																			<td><a
																				href="./reports/rws_drought_deepen_abst_frm.jsp"
																				target="_self" class="h4">Contingency Plan
																					Abstract-2</a></td>
																		</tr>
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
																		<tr>

																			<td><b class="green">4.</b></td>
																			<td><a
																				href="./reports/rws_drought_ongoing_works_rpt.jsp"
																				target="_self" class="h4">On Going Works </a></td>
																		</tr>
																		<tr>

																			<td><b class="green">5.</b></td>
																			<td><a
																				href="./reports/rws_drought_distwise_sstank_rpt.jsp"
																				target="_self" class="h4">SS Tank- Detailed</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">6.</b></td>
																			<td><a
																				href="./reports/rws_sstank_consolidated_rpt.jsp"
																				target="_self" class="h4">SS Tank- Consolidated</a>

																			</td>
																		</tr>

																		<tr>

																			<td><b class="green">7.</b></td>
																			<td><a
																				href="./reports/rws_works_exception_frm.jsp"
																				target="_self" class="h4">Drought Works Detail
																					Report</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">8.</b></td>
																			<td><a
																				href="./reports/rws_drought_hab_category_frm.jsp"
																				target="_self" class="h4">Transportation
																					Report(Category A-B-C)</a></td>
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



													<td>

														<div id="resizable15" class="ui-widget-content">
															<h3 class="ui-widget-header">Water Quality Reports</h3>

															<div id="accordion4">

																<h3>
																	<a href="#">General Reports</a>
																</h3>
																<div>
																	<table>

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
																				href="./reports/rws_ftk_test_result_frm.jsp"
																				target="_self" class="h4">Ftk Test Results</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">4.</b></td>
																			<td><a
																				href="./reports/rws_wq_sam_res_loc_frm.jsp"
																				target="_self" class="h4">Status Report-District
																					Wise </a></td>
																		</tr>
																		<tr>

																			<td><b class="green">5.</b></td>
																			<td><a
																				href="./reports/rws_water_sample_abstract_frm.jsp"
																				target="_self" class="h4">Entry Status </a></td>
																		</tr>


																		<tr>

																			<td><b class="green">6.</b></td>
																			<td><a href="./reports/rws_wq_samples_frm.jsp"
																				target="_self" class="h4">Abstract- Samples Vs
																					All Tests</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">7.</b></td>
																			<td><a
																				href="./reports/rws_wq_data_proforam_frm.jsp"
																				target="_self" class="h4">Water Quality Sources
																					Proforma-1</a></td>
																		</tr>


																		<tr>

																			<td><b class="green">8.</b></td>
																			<td><a
																				href="./reports/rws_wq_ground_waterquality_post_data_district_frm.jsp"
																				target="_self" class="h4">Pre & Post Monsoon
																					Tests </a></td>
																		</tr>
																		<tr>

																			<td><b class="green">9.</b></td>
																			<td><a
																				href="./reports/rws_prepost_data_district_frm.jsp"
																				target="_self" class="h4">Pre & Post Monsoon
																					Tests Source Wise </a></td>
																		</tr>

																		<tr>

																			<td><b class="green">10.</b></td>
																			<td><a
																				href="./reports/rws_prepost_data_district_NEW_frm.jsp"
																				target="_self" class="h4">Pre & Post Monsoon
																					Tests Source Wise(New) </a></td>
																		</tr>

																		<tr>
																			<td><b class="green">11.</b></td>
																			<td><a
																				href="./wquality/rws_WQ_contaminated_habitations_frm_rpt.jsp"
																				target="_self" class="h4">Contaminated
																					Habitations As Per Lab Testing</a><img
																				src="images/new.gif"></td>
																		</tr>

																	</table>
																</div>

																<h3>
																	<a href="#">Abstract Reports</a>
																</h3>
																<div>
																	<table>
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
																				target="_self" class="h4">Physico-Chemical Data</a>
																			</td>
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
																				target="_self" class="h4">Habitation Coverage By
																					Test Results(Priority Based)</a></td>
																		</tr>
																		<tr>

																			<td><b class="green">7.</b></td>
																			<td><a
																				href="./reports/WaterQuality/rws_list_odf_gps_frm.jsp"
																				target="_self" class="h4">GRAM PANCHAYAT-LPCD</a></td>
																		</tr>

																		<tr>

																			<td><b class="green">8.</b></td>
																			<td><a
																				href="./reports/rws_WQ_nottestedsources_frm.jsp"
																				target="_self" class="h4">Sources Not Tested<img
																					src="images/new.gif"></a></td>
																		</tr>
																		<tr>

																			<td><b class="green">9.</b></td>
																			<td><a
																				href="./reports/WaterQuality/rws_WQ_lab_coverageall_frm_rpt.jsp"
																				target="_self" class="h4">WQ- Habs Coverage(2012
																					To 2014)</a><img src="images/new.gif"></td>
																		</tr>
																		<tr>

																			<!--<tr>
	<td><b class="green">10.</b></td><td>	
	<a href="./reports/rws_WQ_Test_Results_frm_rpt.jsp" target="_self" class="h4">WQ Test Results Download</a><img src="images/new.gif">
	</td></tr>
-->
																	</table>

																</div>
													</td>
													<td></td>

												</table>



































											</div>
											<!-- water quality end -->
















											<div id="rfd">
												<table>
													<tr>
														<td>

															<div id="resizable6" class="ui-widget-content">
																<h3 class="ui-widget-header">
																	RFD<img src="images/new.gif">
																</h3>
																<table>
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
																				of Schools/Anganwadis with Drinking Water Facilities
																		</a></td>
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


																</table>

															</div>
														<td>

															<div id="resizable6" class="ui-widget-content">
																<h3 class="ui-widget-header">
																	RFD Secretary<img src="images/new.gif">
																</h3>
																<table>
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
																				of Schools/Anganwadis with Drinking Water Facilities
																		</a></td>
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
																			onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Proforma-1</a></td>
																	</tr>
																	<tr>
																		<td><b class="green">13.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('Secretary/rws_drought_works_abstract_rpt.jsp')">Habs
																				Details</a></td>
																	</tr>

																</table>
															</div>
														</td>
													</tr>

													</td>

													</tr>


												</table>

											</div>



											<div id="help">
												<table>
													<tr>
														<td>
															<div id="resizable6" class="ui-widget-content">
																<h3 class="ui-widget-header">Help</h3>

																<table>
																	<tr>

																		<td><b class="green">&nbsp;&nbsp;1.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/assethelp.doc')">Asset</a></td>
																	</tr>
																	<tr>
																		<td><b class="green">&nbsp;&nbsp;2.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/HabitationStatushelp.doc')">Habitation
																				Status</a></td>
																	</tr>

																	<tr>
																		<td><b class="green">&nbsp;&nbsp;3.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/WorkFlow.doc')">Works
																				Monitoring</a></td>
																	</tr>

																	<tr>
																		<td><b class="green">&nbsp;&nbsp;4.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/FundAccounting.doc')">Fund
																				Accounting </a></td>
																	</tr>

																	<tr>
																		<td><b class="green">&nbsp;&nbsp;5.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/CommissionedworkAsset.doc')">Asset
																				Scheme Integration </a></td>
																	</tr>

																	<tr>
																		<td><b class="green">&nbsp;&nbsp;6.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/panchayat.doc')">Panchayat</a></td>
																	</tr>


																	<tr>
																		<td><b class="green">&nbsp;&nbsp;7.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/village.doc')">Village
																		</a></td>
																	</tr>




																	<tr>
																		<td><b class="green">&nbsp;&nbsp;8.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/Hab.doc')">Habitation
																		</a></td>
																	</tr>

																	<tr>
																		<td><b class="green">&nbsp;&nbsp;9.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/QualityEffectedHabs.doc')">Quality
																				Effected Habs </a></td>
																	</tr>

																	<tr>
																		<td><b class="green">10.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/WaterQuality.doc')">Water
																				Quality </a></td>
																	</tr>

																	<tr>
																		<td><b class="green">11.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/Help For PRED.htm')">Complete
																				Online Help</a></td>
																	</tr>
																	<tr>
																		<td><b class="green">12.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/School.doc')">School
																				Form</a></td>
																	</tr>
																	<tr>
																		<td><b class="green">13.</b></td>
																		<td><a href="#" class="h4"
																			onclick="viewWorks('./help/DetailedProjectReport.doc')">Detailed
																				Project Report(DPR) Help</a></td>
																	</tr>

																</table>
														</td>
														</div>

													</tr>


												</table>






											</div>

											<div id="theme">
												<table>
													<tr>
														<td>
															<div id="resizable3" class="ui-widget-content">
																<h3 class="ui-widget-header">Themes</h3>
																<br> <br> <br>
																<table>
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

													</tr>


												</table>
											</div>

										</div>

									</TD>
								</TR>


								<tr class="footerrow">
									<TD vAlign=top align=right><div align="center">
											<p>&nbsp;</p>
											<p>
												<b><font class="footer">Designed &amp; Developed
														by National Informatics Centre, AP State Centre</font></b>
											</p>
										</div></TD>
								</TR>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>

	</form>
	</center>
</body>
</HTML>
<%
	} catch (Exception e) {
		System.out.println("error:" + e.getMessage());
	} finally {
		try {
			if (rs1 != null)
				rs1.close();
			if (st1 != null)
				st1.close();
			if (conn != null)
				conn.close();
		} catch (Exception e) {
			System.out.println("error:" + e.getMessage());//  e.printStackTrace();
		}
	}
%>

