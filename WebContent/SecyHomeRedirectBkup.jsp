<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
System.out.println(users);
String userid = users.getUserId();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<%@ include file="/reports/conn.jsp" %>
<%
ResultSet rs1 = null;
Statement st1 = null;
try
{
	st1 = conn.createStatement();
	String q1 = "select * from rws_secretary_details_tbl";
	rs1 = st1.executeQuery(q1);
	rs1.next();
%>
<HTML xmlns="http://www.w3.org/1999/xhtml"><HEAD><TITLE>Welcome to Watersoft</TITLE>
<META content="text/html; charset=iso-8859-15" http-equiv=Content-Type>
<style media="all" type="text/css">
html, body { overflow: hidden; height: 100%; margin: 0; padding: 0; }
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
	COLOR: #444b69;
	FONT-SIZE: 11px;
	FONT-WEIGHT: bold;	
	width:95px;
}

</STYLE>
<LINK rel=stylesheet type=text/css href="imagess/style.css">
<style type="text/css">
<!--
.style1 {
	color: #0000FF;
	font-size: 12;
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
	left: 343px;
	top: 220px;
}
-->
</style>
<style>
/*position and hide the menu initially - leave room for the menu to expand...*/
#description {margin-left:150px; width:510px;}
#page {padding:20px 0; width:100%;}
#menu {position:absolute; top:150px; left:8px; display:none;}
/*dock styling...*/
/*...set the cursor...*/
#menu div.jqDock {cursor:pointer;}
/*label styling...*/
div.jqDockLabel {padding-bottom:8px; font-size:12px; font-family:verdana; font-weight:bold; white-space:nowrap; color:blue; cursor:pointer;}
</style>
<script language="JavaScript" src="/pred/imagess/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/pred/imagess/jquery.jqDock.min.js"></script>
<link href="/pred/resources/style/dockstyle.css" rel="stylesheet" type="text/css" />
<script language="javascript">
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
			document.forms[0].ongoing.value = mytool_array[11];
			document.forms[0].notground.value = mytool_array[12];
			document.forms[0].completed.value = mytool_array[13];
			document.forms[0].commissioned.value = mytool_array[14];
			document.forms[0].fc.value = mytool_array[15];
			document.forms[0].pc4.value = mytool_array[16];
			document.forms[0].pc3.value = mytool_array[17];
			document.forms[0].pc2.value = mytool_array[18];
			document.forms[0].pc1.value = mytool_array[19];
			document.forms[0].nss.value = mytool_array[20];
			document.forms[0].nc.value = mytool_array[21];
			document.forms[0].phys.value = mytool_array[22];	
			document.forms[0].bact.value = mytool_array[23];
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
function fnCall(reportVal)
{
	var URL = "";
	if(reportVal=="1")
		URL = "./switch.do?prefix=/reports&page=/reportsDisplay.do&mode=data";
	else if(reportVal=="2")
		URL="./reports/rws_dist_popcate_rpt1.jsp";
	else if(reportVal=="3")
		URL = "./reports/rws_hab_status_resource_rpt.jsp";
	else if(reportVal=="4")
		URL = "./reports/rws_AssetAbstract_report1.jsp?yrcreation=00&drill=&rDistrictName=";
	else if(reportVal=="5")
		URL = "./reports/rws_dist_asst.jsp?district=-1&mandal=0&panchayat=0&habitation=0";
	else if(reportVal=="6")
		URL = "./reports/rws_school_abstract_rpt1_secy.jsp?rDistrict=00&drill=null&rDistrictName=ALL";
	else if(reportVal=="7")
		URL = "./reports/rws_work_gen.jsp?district=00&finyear=2010-11&planNonplan=1&drill=null&distname=ALL";
	else if(reportVal=="8")
		URL = "./reports/rws_coverage_status_graph_rpt.jsp?chart=b&district=51&mandal=0&panchayat=0&FDate=01-APR-2010";
	var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}
function toggleDisplay()
{
	var zURL="./reports/rws_bill_tobe_release_rpt_secy.jsp";
	var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=0,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	myWin = window.open(zURL,'expenditure',popFeatures);
	myWin.focus();	
}</script>
</HEAD>
<BODY>
<div id='page'>
  <div id='menu'>
	<a href="/pred/Logout.do"><img src="imagess/home.png" title="Logout" alt="Logout" border="0"/></a>
	<a href="http://ddws.gov.in" target="_NEW"><img src="imagess/ddws-logo.gif" title="DDWS" alt="DDWS" border="0"/></a>
	<a href="https://webmail.ap.gov.in" target="_NEW"><img src="imagess/email.png" title="AP WebMail" alt="AP WebMail" border="0" /></a>
  </div>
<div id="div1" class="cornerBox"><p><a href="#" onClick="submitComplaint()"><img src="imagess/wian-feedback-icon.png"  height="40" title="AP WebMail" alt="AP WebMail" border="0" /></a></p></div>
<form name="master">
<TABLE border=0 cellSpacing=0 cellPadding=0 width=1000 align=center>
  <TBODY>
  
  <TR>
    <TD>
      <TABLE border=0 cellSpacing=0 cellPadding=0 width=950 align=center>
        <TBODY>
        <TR>
          <TD vAlign=top align=middle>
            <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
              <TBODY>
              <TR>
                <TD vAlign=top colSpan=2>
                  <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
                    <TBODY>
					<tr><td>&nbsp;</td></tr>
                    <TR>
                     <td align="center" vAlign=top>
						<table width="100%">
						<tr>
						<TD height=39 vAlign=top width=60 align=left><IMG src="imagess/aplogo.gif" 
                        alt=logo width=60 
                        height=58 border="0"></TD>
						<td width="86" align="center">&nbsp;</td>
						<td width="428" align="center" bordercolor="#FFFFFF"><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="414" height="90">
                          <param name="movie" value="imagess/rural.swf">
                          <param name="quality" value="high">
                          <param name="menu" value="false">
                          <param name="wmode" value="transparent">
                          <embed src="images/rural.swf" width="414" height="90" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" menu="false" wmode="transparent"></embed>
                        </object></td>
						<td width="205" valign="bottom">
				<font face="verdana" size="3" color=blue>Welcome to<br>
				</font><font color="black" size="2" face="verdana"> Ms. Chitra Ramachandran, IAS Principal Secretary, RWSS </font></td>
					    <td width="57" valign="bottom"><A href="/pred/Logout.do">[Logout]</A></td>
						<td width="66" valign="top"><IMG alt=logo src="imagess/ddws-logo.gif" width=60 height=65>				</td>
				</tr></table></td>
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
                                <tr>
                                  <td colspan="3" align="right"><div id="content" style="display:none"><img src="/pred/images/loading4.gif"></div>                                    
                                    <font face="verdana" size="2" color=blue><img src="images/refresh.JPG" width="35" height="35" alt="Click to get Updated Data" title="Click to get Updated Data" style="cursor:hand"  id="btnLoad"></font></td>
                                </tr>
                              <tr>
                                <td><font face="verdana" size="2" color=blue><b><b>&nbsp;&nbsp;&nbsp;AP RWSS At A Glance&nbsp;&nbsp;</b></b></font></td>
                                <td><table border=0 cellspacing=0 cellpadding=0 
                                width="60%">
                                    <tbody>
                                      <tr>
                                        <td width=87 align=left>&nbsp;</td>
                                        <td width=4></td>
                                        <td></td>
                                      </tr>
                                    </tbody>
                                </table></td>
                                <td width=11 align=right>&nbsp;</td>
                              </tr>
                              <tr>
                                <td valign=top colspan=3 align=left><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                    <tbody>
                                      <tr>
                                        <td valign=top width=8 align=left>&nbsp;</td>
                                        <td height=19 valign=top width=722><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                            <tbody>
                                              <tr>
                                                <td height=4 colspan=4 align=left></td>
                                              </tr>
                                              <tr>
                                                <td height=4 colspan=4></td>
                                              </tr>
                                              <tr>
                                                <td 
                                style="BORDER-TOP: #666666 1px dotted; BORDER-RIGHT: #666666 1px dotted" 
                                valign=top width=180><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                                    <tbody>
                                                      <tr>
                                                        <td height=26 width=14 align=middle>&nbsp;</td>
                                                        <td colspan="2" 
                                align=left class=indigo10pixel>Habitation Directory</td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td width="84" height=20 class=green>Mandals </td>
                                                        <td width="89" class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="mandals" value="<%=rs1.getString(1)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Panchayats</td>
                                                        <td class=text2 id="div2"><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="panchayats" value="<%=rs1.getString(2)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Villages</td>
                                                        <td class=text2 id="div3"><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="villages" value="<%=rs1.getString(3)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Habitations</td>
                                                        <td class=text2 id="div4"><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="habs" value="<%=rs1.getString(4)%>"></span></td>
                                                      </tr>
                                                    </tbody>
                                                </table></td>
                                                <td 
                                style="BORDER-TOP: #666666 1px dotted; BORDER-RIGHT: #666666 1px dotted" 
                                valign=top width=159><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                                    <tbody>
                                                      <tr>
                                                        <td width="8%" height=26 align=middle>&nbsp;</td>
                                                        <td colspan="2" 
                                align=left class=indigo10pixel>Assets</td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td width="50%" height=20 class=green>PWS<span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td width="42%" class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="pws" value="<%=rs1.getString(5)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>MPWS<span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="mpws" value="<%=rs1.getString(6)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>CPWS<span class="indigo10pixel"></span></td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="cpws" value="<%=rs1.getString(7)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Borewells</td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="borewells" value="<%=rs1.getString(8)%>"></span></td>
                                                      </tr>
                                                    </tbody>
                                                </table></td>
                                                <td style="BORDER-TOP: #666666 1px dotted" 
                                valign=top width=179><table border=0 cellspacing=0 cellpadding=0 
                                width="97%">
                                                    <tbody>
                                                      <tr>
                                                        <td width="8%" height=26 align=middle>&nbsp;</td>
                                                        <td colspan="2" 
                                align=left class=indigo10pixel>Works (2010-2011)</td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td width="54%" height=20 class=green>Ongoing<span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td width="38%" class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="ongoing" value="<%=rs1.getString(12)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Not Grounded</td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="notground" value="<%=rs1.getString(13)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Completed</td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="completed" value="<%=rs1.getString(14)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Commissioned<span class="indigo10pixel"></span><span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="commissioned" value="<%=rs1.getString(15)%>"></span></td>
                                                      </tr>
                                                    </tbody>
                                                </table></td>
                                                <td 
                                style="BORDER-LEFT: #666666 1px dotted; BORDER-TOP: #666666 1px dotted" 
                                valign=top width=177><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                                    <tbody>
                                                      <tr>
                                                        <td height=26 align=middle>&nbsp;</td>
                                                        <td colspan="2" 
                                align=left class=indigo10pixel>Releases In Lakhs </td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>BRO<span class="indigo10pixel"></span><span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="bro" value="<%=rs1.getString(9)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>LOC<span class="indigo10pixel"></span><span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="loc" value="<%=rs1.getString(10)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                        <td height=20 class=green>Expenditure</td>
                                                        <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="exp" value="<%=rs1.getString(11)%>"></span></td>
                                                      </tr>
                                                      <tr>
                                                        <td height="20" colspan="3" align=center style="PADDING-RIGHT: 8px"><a href="#" class="text2bold" onClick="toggleDisplay()">View Detailed Report</a></td>
                                                      </tr>
                                                    </tbody>
                                                </table></td>
                                              </tr>
                                            </tbody>
                                          </table>
                                            <table width="100%">
                                            </table>
                                          <table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                              <tbody>
                                                <tr>
                                                  <td height=4 colspan=4 align=left></td>
                                                </tr>
                                                <tr>
                                                  <td height=4 colspan=4></td>
                                                </tr>
                                                <tr>
                                                  <td 
                                style="BORDER-TOP: #666666 1px dotted; BORDER-RIGHT: #666666 1px dotted" 
                                valign=top width=229><table border=0 cellspacing=0 cellpadding=0 
                                width="228">
                                                      <tbody>
                                                        <tr>
                                                          <td height=26 width=15 align=middle>&nbsp;</td>
                                                          <td colspan="2" 
                                align=left class=indigo10pixel>Habitation Coverage</td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td width="97" height=20 class=green>FC </td>
                                                          <td width="109" class=text2><span class="indigo10pixel">
                                                            <input type="text" class="noborder-text-box" readonly="true" name="fc" value="<%=rs1.getString(16)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>PC4</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="pc4" value="<%=rs1.getString(17)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>PC3</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="pc3" value="<%=rs1.getString(18)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>PC2</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="pc2" value="<%=rs1.getString(19)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>PC1</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="pc1" value="<%=rs1.getString(20)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>NSS</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="nss" value="<%=rs1.getString(21)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>NC</td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="nc" value="<%=rs1.getString(22)%>"></span></td>
                                                        </tr>
                                                      </tbody>
                                                  </table></td>
                                                  <td 
                                style="BORDER-TOP: #666666 1px dotted; BORDER-RIGHT: #666666 1px dotted" 
                                valign=top width=212><table 
                                width="100%" border=0 cellpadding=0 cellspacing=0>
                                                      <tbody>
                                                        <tr>
                                                          <td width="8%" height=26 align=middle>&nbsp;</td>
                                                          <td colspan="2" 
                                align=left class=indigo10pixel>Water Quality </td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td width="56%" height=20 class=green>Physico Chemical <span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                          <td width="36%" class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="phys" value="<%=rs1.getString(23)%>"></span></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=green>Bacterological<span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                                          <td class=text2><span class="indigo10pixel"><input type="text" class="noborder-text-box" readonly="true" name="bact" value="<%=rs1.getString(24)%>"></span></td>
                                                        </tr>
                                                      </tbody>
                                                  </table></td>
                                                  <td style="BORDER-TOP: #666666 1px dotted" 
                                valign=top width=469><table 
                                width="97%" border=0 cellpadding=0 cellspacing=0>
                                                      <tbody>
                                                        <tr>
                                                          <td width="4%" height=26 align=middle>&nbsp;</td>
                                                          <td colspan="3" 
                                align=left class=indigo10pixel>Reports</td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td width="49%" height=20 class=text2><a href="#" onClick="fnCall('1')">Habitation Coverage Status </a></td>
                                                          <td width="3%" align=right style="PADDING-RIGHT: 8px"><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td width="44%" height=20 class=text2><a href="#" onClick="fnCall('2')">Population-Category</a></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#"  onClick="fnCall('8')">Habitation Coverage Graph </a></td>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#"  onClick="fnCall('3')">Resources in a Habitation </a></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#"  onClick="fnCall('4')">Assets Abstract</a></td>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#" onClick="fnCall('5')">Assets-Sources </a></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#" onClick="fnCall('7')">Works Abstract </a></td>
                                                          <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                                          <td height=20 class=text2><a href="#"  onClick="fnCall('6')">Schools Abstract </a></td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                        </tr>
                                                        <tr>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                          <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                                          <td height=20 class=text2>&nbsp;</td>
                                                        </tr>
                                                      </tbody>
                                                  </table></td>
                                                </tr>
                                              </tbody>
                                          </table></td>
                                      </tr>
                                    </tbody>
                                </table></td>
                                <td>&nbsp;</td>
                              </tr>
                            </table></TD>
                          </TR>
                                								
                                <TR>
                                <TD vAlign=top colSpan=3 align=left>
                                <TABLE border=0 cellSpacing=0 cellPadding=0 
                                width="100%">
                                <TBODY>
                                <TR>
                                <TD colSpan=3>
                                <TABLE border=0 cellSpacing=0 cellPadding=0 
                                width="100%">
                                <TBODY>								
                                </TBODY></TABLE></TD></TR>
                                </TBODY></TABLE></TD></TR>
                                <TR>
                                <TD height=2 vAlign=top colSpan=3 
                                align=left></TD></TR>
                               
                                <TR>
                                  <TD class=grey10pixel vAlign=top colSpan=3 
                        align=middle><div align="center" class="style1">
                                    <p>&nbsp;</p><p>&nbsp;</p>
                                    <p>Designed &amp; Developed by National Informatics Centre, AP State Centre</p>
                                    </div></TD>
                                </TR>
                                </TABLE></TD></TR></TABLE></TD></TR>
                  
                    </TABLE></TD></TR></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</TD></TR></TBODY></TABLE>
</form>
</BODY></HTML>
<%}
catch(Exception e)
{System.out.println("error:"+e.getMessage());}
finally
{
	if(rs1!=null)rs1.close();
	if(st1!=null)st1.close();
	if(conn!=null)conn.close();
}
%>