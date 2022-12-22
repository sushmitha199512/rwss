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
</HEAD>
<BODY>
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
                                <td><div align="center">
                                  <p><font face="verdana" size="2" color=blue><b><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></b></font></p>
                                  <p><font face="verdana" size="2" color=blue><b><b>AP RWSS At A Glance&nbsp;&nbsp;</b></b></font> </p>
                                </div>
                                  <table border=0 cellspacing=0 cellpadding=0 
                                width="60%">
                                    <tbody>
                                      
                                      </tbody>
                                    </table></td>
                                </tr>
                              <tr>
                                <td valign=top align=left><table border=0 cellspacing=0 cellpadding=0 
                                width="100%">
                                    <tbody>
                                      <tr>
                                        <td valign=top width=8 align=left>&nbsp;</td>
                                        <td width="920" height=19 valign=top><table width="100%">
                                            </table>
                                          <table width="868" border="0" align="center">
                                            <tr>
                                              <td colspan="12" style="BORDER-BOTTOM: #666666 1px dotted; BORDER-BOTTOM: #666666 1px dotted" valign=bottom>&nbsp;</td>
                                              </tr>
                                            <tr>
                                              <td colspan="3"><span class="indigo10pixel">Habitation Directory</span></td>
                                              <td colspan="3"><span class="indigo10pixel">Assets</span></td>
                                              <td colspan="3"><span class="indigo10pixel">Works</span></td>
                                            </tr>
                                            <tr>
                                              <td width="13" align=right style="PADDING-RIGHT: 8px"><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td width="89" height=20 class=green>Mandals</td>
                                              <td width="101" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="mandals" value="<%=rs1.getString(1)%>">
                                              </span></td>
		
                                              <td width="13" align=right style="PADDING-RIGHT: 8px"><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td width="117" height=20 class=green>PWS</td>
                                              <td width="100" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pws" value="<%=rs1.getString(5)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td width="114" height=20 class=green>Ongoing</td>
                                              <td width="95" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="ongoing" value="<%=rs1.getString(12)%>">
                                              </span></td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Panchayats</td>
                                              <td class=text2 id="div2"><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="panchayats" value="<%=rs1.getString(2)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>MPWS</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="mpws" value="<%=rs1.getString(6)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Not Grounded</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="notground" value="<%=rs1.getString(13)%>">
                                              </span></td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Villages</td>
                                              <td class=text2 id="div3"><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="villages" value="<%=rs1.getString(3)%>"></span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>CPWS</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="cpws" value="<%=rs1.getString(7)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Completed</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="completed" value="<%=rs1.getString(14)%>"></span></td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Habitations</td>
                                              <td class=text2 id="div4"><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="habs" value="<%=rs1.getString(4)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Bore wells</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="borewells" value="<%=rs1.getString(8)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Commissioned</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="commissioned" value="<%=rs1.getString(15)%>">
                                              </span></td>
                                              </tr>
                                            <tr>
                                              <td colspan="12" style="BORDER-BOTTOM: #666666 1px dotted; BORDER-BOTTOM: #666666 1px dotted" valign=bottom>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td colspan="3"><span class="indigo10pixel">Habitation Coverage </span></td>
                                              <td colspan="3"><span class="indigo10pixel">Water Quality </span></td>
                                              <td colspan="3">&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>FC</td>
                                              <td width="101" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="fc" value="<%=rs1.getString(16)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Physico Chemical <span class="indigo10pixel"></span><span class="indigo10pixel"></span></td>
                                              <td width="100" class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="phys" value="<%=rs1.getString(23)%>">
                                              </span></td>
                                              <td width="13" align=right style="PADDING-RIGHT: 8px">&nbsp;</td>
                                              <td width="68" height=20 class=green>&nbsp;</td>
                                              <td width="95" class=text2>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>PC4</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc4" value="<%=rs1.getString(17)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>Bacterological</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="bact" value="<%=rs1.getString(24)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td class=text2>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>PC3</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc3" value="<%=rs1.getString(18)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td class=text2>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>PC2</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc2" value="<%=rs1.getString(19)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td height="20" colspan="3" align=right style="PADDING-RIGHT: 8px" class=green>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>PC1</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="pc1" value="<%=rs1.getString(20)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>NSS</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="nss" value="<%=rs1.getString(21)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                              <td style="PADDING-RIGHT: 8px" align=right><img 
                                src="imagess/arrow-samll.jpg" width=6 
                                height=5></td>
                                              <td height=20 class=green>NC</td>
                                              <td class=text2><span class="indigo10pixel">
                                                <input type="text" class="noborder-text-box" readonly="true" name="nc" value="<%=rs1.getString(22)%>">
                                              </span></td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                              <td style="PADDING-RIGHT: 8px" align=right>&nbsp;</td>
                                              <td height=20 class=green>&nbsp;</td>
                                              <td>&nbsp;</td>
                                            </tr>
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
                               
                  
                    </TABLE></TD></TR></TABLE></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
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