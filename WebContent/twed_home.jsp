
<%@ include file="/tribalWorks/conn.jsp" %>


<% nic.watersoft.twedCommons.TwedUser users=(nic.watersoft.twedCommons.TwedUser)session.getAttribute("TWED_USER");
	String userid = users.getUserId(); 
  boolean flag=false;
System.out.println("user id>>>>>>>>>>>>>."+userid);
%>
<script language="javascript">
var iens6=document.all||document.getElementById;
var ns4=document.layers;
function submitComplaint()
	{
		var userid = '<%=userid%>';

		var urlnew = "works/feedback.jsp?userid="+userid;
		//alert(urlnew);
		window.open(urlnew,"feedBackPage","width=500,height=500,scrollbars=yes,copyhistory=no,resizable=yes,status=yes");
	}
	function ViewComplaint()
		{
			window.open("works/ViewFeedBacks.jsp","viewfeedBackPage","width=900,height=600,left=50,top=50,scrollbars=yes,copyhistory=no,resizable=yes,status=yes");
		}

function getOfflinePatches()
{
url = "switch.do?prefix=/reports&page=/offlinePatches.do";
	 window.open(url,"","width=600,height=400,left=100,top=100,scrollbars=1");
}
function alignWhatsNewImg()
{
document.getElementById("whatsNewLink").style.left=document.body.clientWidth-document.getElementById("whatsNewImg").width;

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
function viewWorks(URL)
{
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
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

function openWhatsNew()
{


 var width = 650;
	 var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
	 
	 
url = "/pred/whatsNew.html";
	  var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
		newWindow = window.open(url, "_New", properties);
		//newWindow = window.open(url, "_blank", properties);
		newWindow.focus();
}
</script>



<%	
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String theAlertMessage = "";
	String ad=(String)session.getAttribute("userId");
	Debug.println("ad is "+ad);
	
	if(request.getParameter("loginMode")==null || (request.getParameter("loginMode")!=null && request.getParameter("loginMode").equals("watersoft")))
	{
		
		Object oNoOfProposalsC = request.getAttribute("NO_OF_PROPOSALS_C");
		Object oNoOfProposalsA = request.getAttribute("NO_OF_PROPOSALS_A");
		Object oNoOfProposalsOMC = request.getAttribute("NO_OF_PROPOSALS_OM_C");
		Object oNoOfProposalsOMA = request.getAttribute("NO_OF_PROPOSALS_OM_A");
		Object oNoOfEstimates = request.getAttribute("NO_OF_ESTIMATES");
		Object oNoOfEstimatesOM = request.getAttribute("NO_OF_ESTIMATES_OM");
		Object no_of_vouchers = request.getAttribute("no_of_vouchers");
		Object no_of_bills = request.getAttribute("no_of_bills");
        //added by jyothi
        Object bank_process = request.getAttribute("bank_process");
        Object sec_alert = request.getAttribute("sec_alerts");
       //


		String no_of_proposals_c = null;
		String no_of_proposals_a = null;
		String no_of_proposals_om_c = null;
		String no_of_proposals_om_a = null;
		String no_of_estimates = null;
		String no_of_estimates_om = null;
		
		//added by jyothi
		String bank_status=null;
        String sec_msg=null;
	
	//	
		
		

		if(oNoOfProposalsC != null)
		{
			no_of_proposals_c = String.valueOf(oNoOfProposalsC);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/NewProposalData.do>"
							+ "You have " + no_of_proposals_c + " New proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsA != null)
		{
			no_of_proposals_a = String.valueOf(oNoOfProposalsA);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/NewAdminProposalData.do>"
							+ "You have " + no_of_proposals_a + " New sanctioned proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsOMC != null)
		{
			no_of_proposals_om_c = String.valueOf(oNoOfProposalsOMC);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/OMProposalData.do>"
							+ "You have " + no_of_proposals_om_c + " O&M proposal(s)</a><br>";
		}
	
		if(oNoOfProposalsOMA != null)
		{
			no_of_proposals_om_a = String.valueOf(oNoOfProposalsOMA);
			theAlertMessage += "<a href=switch.do?prefix=/proposals&page=/OMAdminProposalData.do>"
							+ "You have " + no_of_proposals_om_a + " O&M sanctioned proposal(s)</a><br>";
		}
		
		if(oNoOfEstimates != null)
		{
			no_of_estimates = String.valueOf(oNoOfEstimates);
			theAlertMessage += "<a href=switch.do?prefix=/estimates&page=/NewEstSanctionData.do>"
							+ "You have " + no_of_estimates + " estimates(s)</a><br>";
		}
		
		if(oNoOfEstimatesOM != null)
		{
			no_of_estimates_om = String.valueOf(oNoOfEstimatesOM);
			theAlertMessage += "<a href=switch.do?prefix=/estimates&page=/OMEstSanctionData.do>"
							+ "You have " + no_of_estimates_om + " O&M estimates(s)</a><br>";
		}
		
		if(no_of_vouchers != null && (userid!=null && userid.substring(0,1).equals("1") && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=./reports/rws_work_voucher_pending_rpt.jsp?userIdd="+userid+" target=_NEW><font color=red><b>"+ "You have " + no_of_vouchers + " New Voucher(s)</b></font></a><br>";
		}

		if(no_of_bills != null && (userid!=null && userid.substring(0,1).equals("1") && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=./works/rws_tobe_fwd_bills_frm.jsp target=_NEW><font color=red><b>"+ "You have " + no_of_bills + " Pending Bill(s)</b></font></a><br>";
		}

        if(no_of_vouchers != null && (userid!=null && userid.substring(0,1).equals("2") && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=./tribalWrksMonitoring/rws_work_voucher_pending_rpt.jsp?userIdd="+userid+" target=_NEW><font color=red><b>"+ "Tribal You have " + no_of_vouchers + " New Voucher(s)</b></font></a><br>";
		}

		if(no_of_bills != null && (userid!=null && userid.substring(0,1).equals("2") && userid.indexOf("EE")>0))
		{
			no_of_vouchers = String.valueOf(no_of_vouchers);
			theAlertMessage += "<a href=./tribalWrksMonitoring/rws_tobe_fwd_bills_frm.jsp target=_NEW><font color=red><b>"+ "Tribal You have " + no_of_bills + " Pending Bill(s)</b></font></a><br>";
		}





//added by jyothi
		if(bank_process != null && (userid!=null && userid.substring(0,1).equals("1") && userid.indexOf("EE")>0))
		{
			bank_status =(String)request.getAttribute("bank_process");
            System.out.println("bank_status is "+bank_status);
			theAlertMessage += "<font color=red><b>"+ "Pending Process at Bank   " + bank_status + " </b></font></a><br>";
		}
        if(bank_process != null && (userid!=null && userid.equals("admin") || userid.equals("100000")))
		{
			bank_status =(String)request.getAttribute("bank_process");
            System.out.println("bank_status is "+bank_status);
			theAlertMessage += "<img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ " Pending Process at Bank   " + bank_status + " </b></font></a><br>&nbsp;";
		}

       if(sec_alert!=null && !sec_alert.equals(""))
		{
			sec_msg =(String)request.getAttribute("sec_alerts");            
            System.out.println("sec_alert is "+sec_msg);
            theAlertMessage += "<DIV> <img src=/pred/images/new1.gif align=left border=0></img><font color=red><b>"+ "RWSS SECRETARY &nbsp;" + sec_msg + " </b></font><a href=./reports/rws_secrep_message_rpt.jsp target=_NEW>Read More>></a></DIV><br>";
		    
        }


//


		if(theAlertMessage != null && theAlertMessage.length()>0)
		{
			int indexOfBR = theAlertMessage.lastIndexOf("<br>");
			theAlertMessage = theAlertMessage.substring(0, indexOfBR);
		}
	
	
%>

<%@ include file="/commons/rws_header1.jsp" %>







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
<script language="JavaScript" src="/pred/resources/javascript/datetime.js"></script>

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
.h4:hover { text-transform:uppercase; }

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

	select.select{
		position:relative;
		z-index:10;
		width:166px !important;
		height:26px !important;
		line-height:26px;
		font-size: 16px;

}

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

	#resizable h3, #resizable2 h3 { text-align: center; margin: 0; }
	#resizable3 h3, #resizable4 h3 { text-align: center; margin: 0; }
#resizable5 h3, #resizable4 h3 { text-align: center; margin: 0; }
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

<script src="/pred/resources/javascript/jquery.ui.mouse.js"></script>
	<script src="/pred/resources/javascript/jquery.ui.resizable.js"></script>
	








<script type="text/javascript">

function doBlink() {
  // Blink, Blink, Blink...
  var blink = document.all.tags("BLINK")
  for (var i=0; i < blink.length; i++)
    blink[i].style.visibility = blink[i].style.visibility == "" ? "hidden" : "" 
}

function startBlink() {
  // Make sure it is IE4
  if (document.all)
    setInterval("doBlink()",100);
}
window.onload = startBlink;


var description=new Array()
description[0]='<%= theAlertMessage%>';



//Do not edit below here

iens6=document.all||document.getElementById
ns4=document.layers

<!--GLOBAL VARIABLES-->
var thename
var theobj
var thetext
var winHeight
var winPositionFromTop
var winWidth
var startH=2
var openTimer
<!--END GLOBAL VARIABLES-->

<!--GLOBAL FUNCTIONS-->

function ietruebody(){
return (document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function setObj(text,theswitch,inwidth,inheight) {
	thetext=text
	if(iens6){
		thename = "viewer"
		theobj=document.getElementById? document.getElementById(thename):document.all.thename
		winHeight=100
			if(iens6&&document.all) {
				winPositionFromTop=!window.opera? ietruebody().clientHeight : document.body.clientHeight
				winWidth=(ietruebody().clientWidth-ietruebody().leftMargin)
			}
			if(iens6&&!document.all) {
				winPositionFromTop=window.innerHeight
				winWidth=(window.innerWidth-(ietruebody().offsetLeft+30))
			}
			if(theswitch=="override") {
				winWidth=inwidth
				winHeight=inheight
			}
		theobj.style.width=winWidth+"px"
		theobj.style.height=startH+"px"
			if(iens6&&document.all) {
				theobj.style.top=ietruebody().scrollTop+winPositionFromTop+"px"
				//window.status=winPositionFromTop
				theobj.innerHTML = ""
				theobj.insertAdjacentHTML("BeforeEnd","<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2'	style='color:black;font-weight:normal'>"+thetext+"</font></td>	</tr></table>")
			}
			if(iens6&&!document.all) {
				theobj.style.top=window.pageYOffset+winPositionFromTop+"px"
				theobj.innerHTML = ""
				theobj.innerHTML="<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2' style='color:black;font-weight:normal'>"+thetext+"</font></td></tr></table>"}
	}
	if(ns4){
		thename = "nsviewer"
		theobj = eval("document."+thename)
		winPositionFromTop=window.innerHeight
		winWidth=window.innerWidth
		winHeight=100
			if(theswitch=="override") {
				winWidth=inwidth
				winHeight=inheight
			}
		theobj.moveTo(0,eval(window.pageYOffset+winPositionFromTop))
		theobj.width=winWidth
		theobj.clip.width=winWidth
		theobj.document.write("<table cellspacing=0 width="+winWidth+" height="+winHeight+" border=1><tr><td width=100% valign=top><font type='times' size='2' style='color:black;font-weight:normal'>"+thetext+"</font></td></tr></table>")
		theobj.document.close()
	}
	viewIt()
}

function viewIt() {
	if(startH<=winHeight) {
		if(iens6) {
			theobj.style.visibility="visible"
				if(iens6&&document.all) {
					theobj.style.top=(ietruebody().scrollTop+winPositionFromTop)-startH+"px"
				}
				if(iens6&&!document.all) {
					theobj.style.top=(window.pageYOffset+winPositionFromTop)-startH+"px"
				}
			theobj.style.height=startH+"px"
			startH+=2
			openTimer=setTimeout("viewIt()",10)
		}
		if(ns4) {
			theobj.visibility = "visible"
			theobj.moveTo(0,(eval(window.pageYOffset+winPositionFromTop)-startH))
			theobj.height=startH
			theobj.clip.height=(startH)
			startH+=2
			openTimer=setTimeout("viewIt()",10)
		}
	}else{
		clearTimeout(openTimer)
	}
}

function stopIt() {
	if(iens6) {
		theobj.innerHTML = ""
		theobj.style.visibility="hidden"
		startH=2
	}
	if(ns4) {
		theobj.document.write("")
		theobj.document.close()
		theobj.visibility="hidden"
		theobj.width=0
		theobj.height=0
		theobj.clip.width=0
		theobj.clip.height=0
		startH=2
	}

}
<!--END GLOBAL FUNCTIONS-->
</script>
</head>
<%  ad=(String)session.getAttribute("userId");
	if(theAlertMessage != null && theAlertMessage.length()>0)
	{
	
%>
<body bgcolor="#edf2f8" topmargin=0 leftmargin=0
	onload="init();getWorks();setObj(description[0],'override',300,100);alignWhatsNewImg()"
	onbeforeunload="fnBeforeUnload()">
 
<%
	if(userid!=null && (userid.equals("100000") || userid.equals("admin")))
	{
	%>
<div id="suggestion" style="position:absolute;top:520px;left:1120px;height:100px;width:50px"><img id="suggestion" src="/pred/images/Feed.jpg" height="80" width="110" onclick="ViewComplaint()" onmouseover="javascript:style.cursor='hand'"/></div>
<%}else{%>
<div id="suggestion" style="position:absolute;top:520px;left:1120px;height:100px;width:50px"><img id="suggestion" src="/pred/images/Feed.jpg" height="80" width="110" onclick="submitComplaint()" onmouseover="javascript:style.cursor='hand'"/></div>
<%}%>
<div id="whatsNewLink" style="position:absolute;top:15px;left:820px;height:100px;width:100px"><img id="whatsNewImg" src="/pred/images/whats_new_graphic.jpg" height="40" width="110" onclick="openWhatsNew()" onmouseover="javascript:style.cursor='hand'"/></div>
<form action="/pred/Logout.do">
<% } 
	else
	{
	
%>
<body BGCOLOR="#edf2f8" topmargin=0 leftmargin=0 onload="init();getWorks();alignWhatsNewImg()"
	onbeforeunload="fnBeforeUnload()">
<form >
	<%
	if(userid!=null && (userid.equals("100000") || userid.equals("admin")))
	{
	%>
<div id="suggestion" style="position:absolute;top:520px;left:1120px;height:100px;width:50px"><img id="suggestion" src="/pred/images/Feed.jpg" height="80" width="110" onclick="ViewComplaint()" onmouseover="javascript:style.cursor='hand'"/></div>
<%}else{%>
<div id="suggestion" style="position:absolute;top:520px;left:1120px;height:100px;width:50px"><img id="suggestion" src="/pred/images/Feed.jpg" height="80" width="110" onclick="submitComplaint()" onmouseover="javascript:style.cursor='hand'"/></div>
<%}%>
<div  id="whatsNewLink" style="position:absolute;top:15px;left:820px;height:100px;width:100px"><img id="whatsNewImg" src="/pred/images/whats_new_graphic.jpg" height="40" width="110" onclick="openWhatsNew()" onmouseover="javascript:style.cursor='hand'"/></div>
<% } %>

<table border=0 width="100%" cellpadding=0 cellspacing=0>
	<!-- watersoft header begins here -->
	
	<tr>
		<td align=left width="5%"><!--  <IMG SRC="<rws:context page='/images/PredSymbol.gif'/>" WIDTH="40" HEIGHT="40">  -->
		</td>
		<td align=center class="pageHeading"><bean:message key="app.title1" />
		<span style="font-family:verdana; font-size: 8pt; "> </span></td>
	</tr>

	<tr>
<%
	if(userid!=null && (userid.equals("200000")))
	{
	%>
		<td class="pageHeading1" align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message
			key="app.heading3" /></td>
<%}
else
{ %>
<td class="pageHeading1" align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message
			key="app.heading1" /></td>
<%} %>
	</tr>
	<tr>
		<td class="pageHeading2" align="center" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message
			key="app.heading2" /></td>
	</tr>

	<tr>
		<td colspan="3">
		<table width="100%" class="userDetails" cellpadding="0"
			cellspacing="0" border=0>
			<tr>
				<td nowrap><b> Welcome, <bean:write name="TWED_USER"
					property="userId" /> <font face="italic" size=1 color=#0000FF> <logic:notEqual
					name="TWED_USER" property="circleOfficeCode" value="00"> -- <bean:write
						name="TWED_USER" property="circleOfficeName" />
				</logic:notEqual> <logic:notEqual name="TWED_USER"
					property="divisionOfficeCode" value="00"> -- <bean:write
						name="TWED_USER" property="divisionOfficeName" />
				</logic:notEqual> <logic:notEqual name="TWED_USER"
					property="subdivisionOfficeCode" value="00"> -- <bean:write
						name="TWED_USER" property="subdivisionOfficeName" />
				</logic:notEqual> </font> [ <c:out
					value="${sessionScope.TWED_USER.officeName} User" /> ]</b></td>
				</td>
	
				<td align="right"><span id="date_time"></span>
            <script type="text/javascript">window.onload = date_time('date_time');</script>&nbsp;&nbsp;&nbsp;&nbsp;</b>
			
			</tr>
			
			
			<!--  end of watersoft header -->
<!-- ***************************** -->
<!--Please check the Water Supply Status Details (Safe/Un Safe) Sources to ensure correctness of data-->
<!-- Update Assets,Works Monitoring, Schools, Water Quality and -->
</table>
				</td>
			</tr>
			<%if(userid !=null && !userid.equals("guest")){%>
        <!--    <tr> behavior="alternate" 
			<td>&nbsp;</td><td colspan="3"><marquee behavior="alternate" onmouseover="this.setAttribute('scrollamount', 0, 0);" onmouseout="this.setAttribute('scrollamount', 6, 0);"><b><font color="#0000FF" face="verdana" size="2"><font color="#0000FF" face="verdana" size="2">Complete the updation of habitation status and Assets as on 1.4.12 as per GIS survey by 30.05.2012 </font></b></marquee></td><td>&nbsp;&nbsp;&nbsp;&nbsp;</td><td>&nbsp;&nbsp;&nbsp;</td></tr>-->
			<%}%>
			<tr>
				<td><%
	if(ad!=null && (ad.equals("admin")))
	{
		
		 %><!-- <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->
				<script type="text/javascript" src="./includes/browser.js">
  		</script> <script type="text/JavaScript"
					src="./resources/javascript/admin-menu-items.js">
		<!--//
		//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
		//-->
		</script> </script> 
		<%
	} 
	else if(ad!=null && ad.equals("100000"))
	{
		
		 %>   <!-- <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->
				<script type="text/javascript" src="./includes/browser.js">
  		 </script> <script type="text/JavaScript"
					src="./resources/javascript/admin-menu-items.js">
		<!--//
		//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
		//-->
		</script> </script>
		
		<%
	} 
	else if(ad.equals("guest"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/guest-menu-items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script></script>  <%
	}
	else if(ad.substring(0,1).equals("1") && ad.substring(4,6).equals("AO"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/ao-menu-items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script>  <%
	}
   else if(ad.substring(0,1).equals("2") && ad.substring(4,6).equals("AO"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/tribalao_menu_items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script>  <%
	}
	else if(ad.substring(0,1).equals("1") && ad.substring(4,6).equals("EE"))
	 { %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/ee-menu-items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script>  <%
	}
else if(ad.substring(0,1).equals("2") && ad.substring(4,6).equals("EE"))
	 { %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/tribalee_menu_items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script>  <%
	}

 
				else if(ad.equals("1000DR"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/drought-menu-items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script>  <%
	}
		else if(ad!=null && ad.equals("200000"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/tribal_menu_items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script> 
   <%
	}
   	else if(ad!=null && ad.substring(0,1).equals("2") && !ad.substring(2,2).equals("00"))
	{ %> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/tribaluser_menu_items.js">
			
				<!--
				//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script> 
   <%
	}
	else {
 		
 		%>  <!-- <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"				src="./resources/javascript/user-menu-items.js">
				<!--//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script> 
		 
		<%} %></td>
		</tr>
		</table>
		<!-- Menu navigation starts here--> <BR>

<br><br><br>
<table>
<tr>
<div id="content" style="display:none" ><img src="images/loading1.gif" alt="Loading Wait..." title="Loading Wait..."></div> 
<td>

  
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
			String finquery="select distinct  substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4)  from  rws_work_admn_tbl where ADMIN_DATE is not null and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) like'%2%' and substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) >=2010 order by substr(to_char(ADMIN_DATE,'dd/mm/yyyy'),7,4) desc";
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
        <td >

<div id="resizable3" class="ui-widget-content">
	<h3 class="ui-widget-header">Quick Links</h3>
<table >
<tr>
<td height="20" ><a href="reports/rws_works_program_details_frm.jsp" class="h4"><img src="/pred/images/new.gif">Abstract Spill/New Works Details </a></td></tr>

<tr>
<td height="20" ><a href="reports/rws_work_status_new_frm.jsp" class="h4"><img src="/pred/images/new.gif">Abstract Works Status Report </a></td></tr>


<tr>
<td><a href="reports/rws_schools_monitoring_rpt.jsp" class="h4" ><img src="/pred/images/new.gif"> Abstract School Details</a></td></tr>
<tr>
<td><a href="reports/rws_totalnowatersample_frm.jsp" class="h4" ><img src="/pred/images/new.gif">Abstract Lab Details </a></td></tr>

<tr>
<td><a href="reports/rws_totalnolabs_frm.jsp" class="h4" ><img src="/pred/images/new.gif">Abstract FTK Details </a></td></tr>

</table>
</div>
</td>
</tr>
</table>
</div>
</td>                          
             </tr>
                                          </table>
</div>
<!--  
</td>
<td align="right">	<IMG SRC="<rws:context page='/images/RWS.JPG'/>" ALT=""></td></tr> -->
</table>


		



	
		<table width="100%" cellpadding="0" cellspacing="0"
		style="position:absolute; bottom:0">
		<tr>
		<td align="center" class="pageFooter">Designed and Developed by
		National Informatics Centre, AP State Centre</td>
		</tr>
		</table>
</form>
		</body>
		<layer name="nsviewer" bgcolor="#FFFFCC" style="border-width:thin;z-index:1"></layer>
		
			<script type="text/javascript">
			if (iens6){
				document.write("<div id='viewer' style='background-color:#DEE3E0;visibility:hidden;position:absolute;right:0;width:0;height:0;z-index:1;overflow:hidden;border:0px ridge white'></div>")
			}
			if (ns4){
				hideobj = eval("document.nsviewer")
				hideobj.visibility="hidden"
			}
			</script>
	




<!-- ******************************* -->
<%} //end of watersoft if%>



			
			
			
			
			<%
			if(request.getParameter("loginMode")!=null && request.getParameter("loginMode").equals("prajapatham"))
			{ %>
			<%@ include file="/commons/rws_header1.jsp" %>
			</head>
			<% 
				ad=(String)session.getAttribute("userId");
			%>
				<body BGCOLOR="#edf2f8" topmargin=0 leftmargin=0 onload="init();alignWhatsNewImg()"
				onbeforeunload="fnBeforeUnload()">
				<table border=0 width="100%" cellpadding=0 cellspacing=0>
				<!-- prajapatham header begins here -->
					<tr>
						<td align=center class="pageHeading">Prajapatham <span
						style="font-family:verdana; font-size: 8pt; "> </span></td>
					</tr>
					<tr>
						<td class="pageHeading1" align="center" colspan="3"><!-- <bean:message key="app.heading1" /> -->
						</td>
					</tr>
					<tr>
						<td class="pageHeading2" align="center" colspan="2"><bean:message
						key="app.heading2" /></td>
					</tr>
					<tr>
						<td colspan="3">
							<table width="100%" class="userDetails" cellpadding="0"
							cellspacing="0">
								<tr>
									<td nowrap><b> Welcome, <bean:write name="TWED_USER"
										property="userId" /> <font face="italic" size=1 color=#0000FF> 
										<logic:notEqual
										name="TWED_USER" property="circleOfficeCode" value="00"> -- <bean:write
										name="TWED_USER" property="circleOfficeName" />
										</logic:notEqual>
										<logic:notEqual name="TWED_USER"
										property="divisionOfficeCode" value="00"> -- <bean:write
										name="TWED_USER" property="divisionOfficeName" />
										</logic:notEqual> <logic:notEqual name="TWED_USER"
										property="subdivisionOfficeCode" value="00"> -- <bean:write
										name="TWED_USER" property="subdivisionOfficeName" />
										</logic:notEqual> </font> [ <c:out
										value="${sessionScope.TWED_USER.officeName} User" /> ]</b></td>
									</td>
						
					
						<td align="right"><b> <%=sdf.format(new java.util.Date())%>&nbsp;&nbsp;&nbsp;&nbsp;</b>
					</tr>
					</table>
				</td>
			</tr>

			<tr>
				<td><%
	if(ad!=null && ad.equals("admin"))
	{
		
		 %>   <!-- <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->
				<script type="text/javascript" src="./includes/browser.js">
  		 </script> <script type="text/JavaScript"
					src="./resources/javascript/prajapatham_admin-menu-items.js">
		<!--//
		//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
		//-->
		</script> </script>
		
		<%
	} 
	
	else if(ad.equals("guest"))
	{%> 
				<script type="text/javascript" src="./includes/browser.js">
  				</script> <script type="text/JavaScript"
					src="./resources/javascript/prajapatham_admin-menu-items.js">
				<!--//
				//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
				//-->
				</script> </script> 
		 <%
	} else {
 		
 		%> <!-- <script language="JavaScript" src="<rws:context page='/resources/javascript/menu_items.js' />"></script>  -->
				<script type="text/javascript" src="./includes/browser.js">
  			</script> <script type="text/JavaScript"
					src="./resources/javascript/prajapatham_admin-menu-items.js">
			<!--//
			//new menu (MENU_ITEMS, MENU_POS, MENU_STYLES);
	
			//-->
			</script> </script> 
		<%} %></td>
		</tr>

		</table>
		<!-- Menu navigation starts here--> <BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<BR>
		<center><IMG SRC="<rws:context page='/images/rws.gif'/>" WIDTH="40"
		HEIGHT="50" BORDER="0" ALT=""></center>

		<table width="100%" cellpadding="0" cellspacing="0"
		style="position:absolute; bottom:0">
		<tr>
		<td align="center" class="pageFooter">Designed and Developed by
		National Informatics Centre, AP State Centre</td>
		</tr>
		</table>
		</body>
		
		<%} %>
					<!-- prapapatham header ends here -->
				
		
		</html>
		
