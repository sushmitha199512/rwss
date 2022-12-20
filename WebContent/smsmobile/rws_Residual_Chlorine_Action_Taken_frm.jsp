<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<style>
/* begin some basic styling here */
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: #338de8; FONT-SIZE: 9px;  TEXT-DECORATION: none
}
.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif; COLOR: black; FONT-SIZE: 9px; FONT-WEIGHT: bold; TEXT-DECORATION: none
}
body {
background: #FFF;
color: #000;
font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;
}
table, td, a {
font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif;
}
div#tbl-container22 {
width: 1130px;
height: 400px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
font-size: 11px;
height: 50px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;
font-size: 8px;
height: 21px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table th {
height: 30px;
}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;
background-color: #2B3856;
color: white;
position:relative;
cursor: default; 
}
div#tbl-container22 thead th {
top: expression(document.getElementById("tbl-container22").scrollTop-2); /* IE5+ only */
z-index: 10;
}
div#tbl-container22 thead th.locked {z-index: 30;}
div#tbl-container22 td.locked, div#tbl-container22 th.locked{
background-color: #edeaed;
font-size: 12px;
font-weight: bold;
text-shadow:blue;
font-style:italic;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;
height:70px;

}
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<script language="JavaScript">

function viewWorks(URL)
{
	alert("link----"+URL);
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">
function fnView(){
	if(document.forms[0].elements['district'].value==''){
		alert("please Select District");
		return false;
	}else if(document.forms[0].elements['mandal'].value==''){
		alert("please Select Mandal");
		return false;
	}else if(document.forms[0].elements['panchayat'].value==''){
		alert("please Select Panchayat");
		return false;
	}else
	{ 
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=chlorideDataView";	
	document.forms[0].submit();
	}
}

function fnSave(){	
	//alert("hi");
	var length= document.residualChlorineForm.resultCount.value;	
	//document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	//document.forms[0].elements['sBtn'].disabled=true;	
	length= length-1;
	var flag=false;
	for(var k=0;k<length;k++)
	{	
		if(document.forms[0].elements["chlorides["+k+"].checks"].checked)
		{
		if(document.forms[0].elements["chlorides["+k+"].assetCode"].value=="" && document.forms[0].elements["chlorides["+k+"].sourceCode"].value==""){
			 alert("Please Select Source");
			 //document.getElementById("chlorides["+k+"].actionTaken").focus();
					 return false;
		 }else if(document.forms[0].elements["chlorides["+k+"].actionTaken"].value==""){
			 alert("Please Select Action Taken");
			 document.forms[0].elements["chlorides["+k+"].actionTaken"].focus();
					 return false;
		 }else if(document.forms[0].elements["chlorides["+k+"].dateOfAction"].value==""){
			 alert("Please Select Date of Action");
			 document.forms[0].elements["chlorides["+k+"].dateOfAction"].focus();
					 return false;
		 }else{
			flag=true;
		 }	 
		}	//end if	
	}//for loop
	if(!flag){
		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
		 document.forms[0].elements['sBtn'].disabled=false;  
		 return;
	}else{		
		 document.forms[0].action="switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=Save";		
		 document.forms[0].submit();
	}	
}

function init()
{
	district='';
	mandal='';
	panchayat='';	
}

function getResidualData()
{	
	if(document.forms[0].elements['district'].value==''){
		alert("Please Select District");
		return false;
	}else if(document.forms[0].elements['mandal'].value==''){
		alert("Please Select Mandal");
		return false;
	}else if(document.forms[0].elements['panchayat'].value==''){
		alert("Please Select Panchayat");
		return false;
	}else{ 
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=chlorideData";	
		document.forms[0].submit();
	}		
}

function getData(){
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/ResidualChlorine.do&mode=get";	
    document.forms[0].submit();
}

function getSourceDetails(){	
	var length= document.residualChlorineForm.resultCount.value;
	var temp= new Array();
	length= length-1;
	for(var k=0;k<length;k++)
	{			
		if(document.forms[0].elements["chlorides["+k+"].sourceCode"].value!="")
		 {
			var sC=document.forms[0].elements["chlorides["+k+"].sourceCode"].value;
			temp=sC.split(" - ");
			document.forms[0].elements["chlorides["+k+"].sourceName"].value=temp[1];
			document.forms[0].elements["chlorides["+k+"].assetCode"].value=temp[2];
		}
	} 
}
function showSources(count){
	var habitation=document.forms[0].elements["chlorides["+count+"].habitation"].value;
	var mesid=document.forms[0].elements["chlorides["+count+"].mesid"].value;
	  var width = 850;
      var height = 550;
      var left = parseInt((screen.availWidth / 2) - (width / 2));
      var top = parseInt((screen.availHeight / 2) - (height / 2));
	 var url = "switch.do?prefix=/smsmobile&page=/rws_select_rc_sources_frm.jsp&habitation=" + habitation+"&count="+count+"&mode=astdata" ;
    var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
             + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
             + "resizable=yes,status=yes";
    newWindow = window.open(url, "_New", properties);
    newWindow.focus();
     
}
</script>
<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
//System.out.println("loggedUser"+loggedUser);
String circle=loggedUser.substring(1,3);
session.setAttribute("circle",circle);
%>
<body  onload="javascript:init();" >
	<html:form  action="ResidualChlorine" method="post">
	
		<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
	
		<jsp:include page="/commons/TableHeader1.jsp">
			<jsp:param name="TableName" value="Residual Chloride  Details" />
			<jsp:param name="TWidth" value="1100" />	
		</jsp:include>
		<table  align=center bgcolor="#DEE3E0" bordercolor= "black"    style="border-collapse:collapse;" width="80%" >	
		<tr>
			<td class="mycborder">
				<fieldset>
				<legend>Office Details</legend>
				<label>
				<table  border=0 align=center>
				<tr>
					<td class=mycborder><font face=verdana size=2>District<font color="red">*</font></font></td>
					<td class="textborder">
						<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
							<html:select property="district" style="width:140px"  onchange="javascript: getData()"	 styleClass="mycombo">
								<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
								<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
							</html:select>
						</logic:equal>
						<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
							<html:text property="districtName" styleClass="mytext" style="width:140px" readonly="true" />
							<html:hidden property="district" />
						</logic:notEqual>	
					</td>
					<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal<font color="red">*</font></font></td>
					<td class="textborder">
						<html:select property="mandal" style="width:140px" styleClass="mycombo"  onchange="getData()">
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
						</html:select>
					</td>
					<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Panchayat<font color="red">*</font></font></td>
					<td class="textborder">		
						<html:select property="panchayat" style="width:140px" styleClass="mycombo" onchange="getResidualData()" >
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="panchayats" name="labelValueBean"  property="value" labelProperty="label" />
						</html:select>
					</td>
					<%--
					</tr>
					<tr>
					<td class=mycborder><font face=verdana size=2>Village<font color="red">*</font></font></td>
							<td class="textborder">
							<html:select property="village" styleClass="mycombo" style="width:150px" onchange="javascript:getData()" >
							<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
					         <logic:present name="villages">
							<html:options collection="villages" name="rwsLocationBean" property="value" labelProperty="label" />
					        </logic:present >
							</html:select>
					</td>
					<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Habitation<font color="red">*</font></font></td>
							<td class="textborder">
							<html:select property="habitation" styleClass="mycombo" style="width:150px">
							<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
					         <logic:present name="habitations">
							<html:options collection="habitations" name="rwsLocationBean" property="value" labelProperty="labelValue" />
					        </logic:present >
							</html:select>
					</td> 
					<td>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="Get Data" onclick="getResidualData()">
					</td>
					--%>
				</tr>
				</table>
				</label>
				</fieldset>
			</td>
		</tr>
		<tr>
			<td class="mycborder">
			<fieldset>
			<legend>Residual Chlorine Test Details</legend>
			<label>
			<div id="tbl-container22">		
				<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10" align=center>
					<thead class="fixedHeader">	
				<tr class="normalRow">
	<th class="locked" align="center" width="30" rowspan="2">S.No</th>
	<th class="locked" align="center" width="100" rowspan="2">Habitation Name</th>
	<th class="locked" align="center" width="100" rowspan="2">Local Person Name</br>/Location</th>
	<th class="locked" align="center" width="70" rowspan="2">Registered Service Request</th>
	<th class="locked" align="center" width="70" rowspan="2">Mode of Service Request</th>
	<th class="locked" align="center" width="100" rowspan="2">Latitude-Longitude</br>/Location</th>
	
	<th class="locked" align="center" width="170" rowspan="2">Select Source</th>	
	<th class="btext" align="center" width="120" rowspan="2">Asset Code<font color="red">*</font></th>
	<th class="btext" align="center" width="120" rowspan="2">Asset Name<font color="red">*</font></th>
	
	<th class="btext" align="center" width="180" rowspan="2">Source Name<font color="red">*</font></th>
	<th class="btext" align="center" width="100" rowspan="2">SMS Received On</th>
	<th class="btext" align="center" width="60" rowspan="2">RC PPM Value<font color="red">*</font></th>
	<th class="btext" align="center" width="100" rowspan="2">Action Taken<font color="red">*</font></th>
	<th class="btext" align="center" width="90" rowspan="2">Date Of Action<font color="red">*</font></th>
	
	<th class="btext" align="center" width="100" rowspan="2">Remarks</th>
	<th class="btext" align="center" width="50" rowspan="2">Select<font color="red">*</font></th>
	</tr>
</thead>
				<%  int count=1; %>
				<logic:notEmpty name="residualChlorineForm" property="chlorides">
				<logic:iterate id="chlorides" name="residualChlorineForm" property="chlorides" indexId="index">
				<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
					<td class="locked"><%=count++%></td>			
					<%-- <td  class="rptValue" >		
					<html:select   name="chlorides" property="sourceCode" styleClass="mycombo" style="width:150px" indexed="true" onchange="javascript:getSourceDetails()" >
					<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
			        <html:options collection="sources" name="rwsLocationBean" property="value" labelProperty="label" />
			        </html:select>
					</td> --%>
					<html:hidden name="chlorides" property="testDate" indexed="true"/>
					<html:hidden name="chlorides" property="mesid" indexed="true"/>
					<html:hidden name="chlorides" property="habitation" indexed="true"/>
					<html:hidden name="chlorides" property="sourceCode" indexed="true"/>
					<%-- <td  class="rptValue" ><html:text name="chlorides" property="sourceName" indexed="true" readonly="true"/></td> --%>
					<td  class="locked" ><html:text name="chlorides"  property="habitationName" indexed="true" readonly="true" size="14" onmouseover="Tip(this.value,TITLE,'Habitation Name')" onmouseout="UnTip()"/></td>
					<%-- <td  class="rptValue" >
					<html:select   name="chlorides" property="assets" styleClass="mycombo" style="width:150px" indexed="true"  >
					<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
			        <html:options collection="assets" name="rwsLocationBean" property="value" labelProperty="label" />
			        </html:select>
					</td> --%>
					<td  class="locked" ><bean:write name="chlorides"  property="localpersonname"/></br>/<bean:write name="chlorides" property="location" /></td>
					<td  class="locked" ><html:text name="chlorides" property="serviceRequest" indexed="true" readonly="true" size="8"/></td>
					<td  class="locked" ><html:text name="chlorides" property="modeOfCapture" indexed="true" readonly="true" size="8"/></td>
						<logic:equal name="chlorides" property="selectSource" value="true">
							<td  class="locked" ><bean:write name="chlorides"  property="locLat"/></br>/<bean:write name="chlorides" property="locLong" /></td>
						<%-- <html:text name="chlorides" property="locLat" indexed="true" readonly="true" size="8"/>
						<td  class="locked" ><html:text name="chlorides" property="locLong" indexed="true" readonly="true" size="8"/></td> --%>
						</logic:equal>
						<logic:equal name="chlorides" property="selectSource" value="false">
						<td  class="locked" ><html:text name="chlorides" property="msgLocation" indexed="true" readonly="true" size="15" onmouseover="Tip(this.value,TITLE,'Lcation')"  onmouseout="UnTip()"/>
						</logic:equal>
					<td  class="locked" >
						<logic:equal name="chlorides" property="selectSource" value="true">
							<input type=button value="select Asset,Source"  id="actionTaken" onClick="showSources(<%=count-2%>);" class="btext" disabled="disabled"/>
						</logic:equal>
						<logic:equal name="chlorides" property="selectSource" value="false">
							<input type=button value="select Asset,Source"  id="actionTaken" onClick="showSources(<%=count-2%>);" class="btext"/>
						</logic:equal>
					</td>
					<td  class="bwborder" ><html:text name="chlorides"  property="assetCode" indexed="true" readonly="true" size="16"/></td> 
				    <td  class="bwborder" ><html:text name="chlorides"  property="assetName" indexed="true" readonly="true" size="26"  onmouseover="Tip(this.value,TITLE,'Asset Name')"  onmouseout="UnTip()"/></td>
				<%-- 	<td  class="bwborder" ><html:text name="chlorides"  property="sourceCode" indexed="true" readonly="true" size="27"/></td> --%> 
					<td  class="bwborder" ><html:text name="chlorides"  property="sourceName" indexed="true" readonly="true" size="50"  onmouseover="Tip(this.value,TITLE,'Source Name And Location')"  onmouseout="UnTip()"/></td>
					<td  class="bwborder" ><html:text name="chlorides"  property="testDate" indexed="true" readonly="true" size="8"/></td> 
					<td  class="bwborder" ><html:text name="chlorides" property="ppmValue" indexed="true" readonly="true" size="5" style="text-align:right"/></td>
					<td  class="bwborder" >
						<html:select name="chlorides" property="actionTaken" styleClass="mycombo" style="width:80px" indexed="true">
							<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
							<html:option value="Y">Yes</html:option>
							<html:option value="N">No</html:option>
						</html:select>
					</td>
					<td  class="bwborder" >
						<html:text name="chlorides"  property="dateOfAction"  styleClass="mytext" style="width:50"   indexed="true"  />&nbsp;<a href="javascript: showCalendarFuture(document.forms[0].elements['chlorides[<%= count-2 %>].dateOfAction']);">
							<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
					</td>
					<%-- <td  class="rptValue" ><html:text name="chlorides" property="dateEntered" indexed="true" readonly="true" size="10"/></td> --%>
					
					<td  class="bwborder" ><html:text name="chlorides" property="remarks" indexed="true"/></td>
					<td>			
						<html:checkbox name="chlorides" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
					</td>	
				</tr>
				</logic:iterate>
				</logic:notEmpty> 
				</table>
				</div>
			<%if(count==1){	%>
			<tr><td colspan="20" align="center" class="btext">No Records</td></tr>
			<tr>
	<td colspan="20" align="center"><input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
			</tr>
			<%}
			else{%>
			<tr>
			<td colspan="20" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">
			&nbsp;
			<input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
			</tr>
			<%}%>
				<input type="hidden" name="resultCount" value="<%=count%>"/>
	
	</label></fieldset></td></tr></table>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="1100" />
	</jsp:include>
</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

