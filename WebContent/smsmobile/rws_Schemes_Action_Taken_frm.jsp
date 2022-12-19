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

<style type="text/css">
<!--
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
height:40px;

}
-->
</style>
<style>
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
var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
}

function wopen(url, name, w, h)
{
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

function fnSave(){
	
	var length= document.schemesForm.resultCount.value;
	
	
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{	
		
	if(document.forms[0].elements["schemes["+k+"].checks"].checked)
	 {		
		 if(document.getElementById("schemes["+k+"].actionTaken").value==""){
			 alert("Please Select Action Taken");
			 document.getElementById("schemes["+k+"].actionTaken").focus();
					 return false;
		 }else if(document.getElementById("schemes["+k+"].dateOfAction").value==""){
			 alert("Please Select Date of Action");
			 document.getElementById("schemes["+k+"].dateOfAction").focus();
					 return false;
		 }else if(document.getElementById("schemes["+k+"].repCode").value==""){
			 alert("Please Select repair type");
			 document.getElementById("schemes["+k+"].repCode").focus();
					 return false;
		 }else if(document.getElementById("schemes["+k+"].repCost").value==""){
			 alert("Please enter repair cost");
			 document.getElementById("schemes["+k+"].repCost").focus();
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
	}
	
	
	else{
		
		
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=SaveSchemes";		
		
		  document.forms[0].submit();
			

	}
	
}

function init()
{
		
	district='';
		
}

function getResidualData()
{
			if(document.getElementById('district').value=='')
			{
		alert("please Select District");
		return false;
			}
	
		else if(document.getElementById('mandal').value=='')
		{
		alert("please Select Mandal");
		return false;
		}
		
	else
		{ 
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=schemesData";	
	  document.forms[0].submit();
	}
	
}
function getData(){
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=get";	

	  document.forms[0].submit();
}
function getSourceDetails(){
	
	var length= document.schemesForm.resultCount.value;
	var temp= new Array();
	length= length-1;
	for(var k=0;k<length;k++)
	{	
		
		if(document.forms[0].elements["schemes["+k+"].sourceCode"].value!="")
	 {
			var sC=document.forms[0].elements["schemes["+k+"].sourceCode"].value;
			
			temp=sC.split(" - ");
			document.forms[0].elements["schemes["+k+"].assetCode"].value=temp[1];
			document.forms[0].elements["schemes["+k+"].assetName"].value=temp[2];
	}
	}
	 
}
function fnView(){
	if(document.getElementById('district').value=='')
	{
	alert("please Select District");
	return false;
		}
	
	else if(document.getElementById('mandal').value=='')
	{
	alert("please Select Mandal");
	return false;
	}
	
	else
	{ 
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=schemesDataView";	
	
	document.forms[0].submit();
	}
}
function showSources(count){
	var habitation=document.forms[0].elements["schemes["+count+"].habitation"].value;
	var mesid=document.forms[0].elements["schemes["+count+"].mesid"].value;
	  var width = 850;
      var height = 550;
      var left = parseInt((screen.availWidth / 2) - (width / 2));
      var top = parseInt((screen.availHeight / 2) - (height / 2));
	 var url = "switch.do?prefix=/smsmobile&page=/rws_select_sources_frm.jsp&habitation=" + habitation+"&count="+count+"&mode=astdata" ;
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
String circle=loggedUser.substring(1,3);

session.setAttribute("circle",circle);

%>

<body  onload="javascript:init();" >

<html:form  action="SchemesActionTaken" method="post">


<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Schemes Action Taken" />
	<jsp:param name="TWidth" value="1100" />	
</jsp:include>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"    style="border-collapse:collapse;" width="1100" >	
<tr>
	<td class="mycborder">
		<fieldset>
			<legend>Habitation Details</legend>
			<label>
<table  border=0 align=center>
<tr><td class=mycborder><font face=verdana size=2>District<font color="red">*</font></font></td>
		<td class="textborder">
		    <logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="district" style="width:140px"   onchange="javascript: getData()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="districtName" styleClass="mytext" style="width:140px"
						    readonly="true" />
				
				<html:hidden property="district" />
			</logic:notEqual>
		
</td>

<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mandal<font color="red">*</font></font></td>
		<td class="textborder">
		<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="getResidualData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
</td>

</tr>
</table>
</label></fieldset></td></tr>

<tr>

<td class="mycborder">
		<fieldset>
			<legend>Schemes Action Taken</legend>
			<label>
		
	<div id="tbl-container22">	
		<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10" align=center>
	<thead class="fixedHeader">	
<tr >
	<td class="locked" align="center" width="30">S.No<font color="red">*</font></td>
	<td class="locked" align="center" width="70">Habitation Name<font color="red">*</font></td>
	<td class="locked" align="center" width="100">Local Person Name/Location<font color="red">*</font></td>
	<td class="locked" align="center" width="90">Service Request<font color="red">*</font></td>
	<td class="locked" align="center" width="170">Select Asset,Source<font color="red">*</font></td> 
	<td class="btext" align="center" width="120">Asset Code<font color="red">*</font></td>
	<td class="btext" align="center" width="120">Asset Name<font color="red">*</font></td>
	<td class="btext" align="center" width="200">Source Code<font color="red">*</font></td>
	<td class="btext" align="center" width="200">Source Name/location<font color="red">*</font></td>
	<!-- <td class="btext" align="center" >Asset type<font color="red">*</font></td> -->
	<td class="btext" align="center" width="100">SMS Received On<font color="red">*</font></td>
	<td class="btext" align="center" width="100">Status<font color="red">*</font></td>
	<td class="btext" align="center" width="100">Action Taken<font color="red">*</font></td>
	<td class="btext" align="center" width="100">Date Of Action<font color="red">*</font></td>
	<td class="btext" align="center" width="150">Repair Type<font color="red">*</font></td>
	<td class="btext" align="center" width="100">Repair Cost<font color="red">*</font></td>
	<!-- <td class="btext" align="center" >Date Entered<font color="red">*</font></td> -->
	<td class="btext" align="center" width="100">Remarks</td>
	<td class="btext" align="center" width="50">Select<font color="red">*</font></td> 
	</tr>
	</thead>
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="schemesForm" property="schemes">
	<logic:iterate id="schemes" name="schemesForm" property="schemes" indexId="index">
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="locked"><%=count++%></td>
		<html:hidden name="schemes" property="smsDate" indexed="true"/>
		<html:hidden name="schemes" property="smsMobile" indexed="true"/>
		<html:hidden name="schemes" property="habitation" indexed="true"/>
		<html:hidden name="schemes" property="mesid" indexed="true"/>
		<td  class="locked" ><bean:write name="schemes"  property="habitationName" /></td>
		<td  class="locked" ><bean:write name="schemes"  property="localpersonname"/>/<bean:write name="schemes" property="location" /></td>
		<td  class="locked" ><bean:write name="schemes" property="serviceRequest" /></td>
		<td  class="locked">
             <input type=button value="select Asset,Source"  id="actionTaken" onClick="showSources(<%=count-2%>);" class="btext"/>       
        </td>
		<td  class="bwborder" ><html:text name="schemes"  property="assetCode" indexed="true" readonly="true" size="16"/></td>
		<td  class="bwborder" ><html:text name="schemes" property="assetName" indexed="true" readonly="true" size="22"/></td>
		<td  class="bwborder" ><html:text name="schemes"  property="sourceCode" indexed="true" readonly="true" size="27"/></td>
		<td  class="bwborder" ><html:text name="schemes" property="sourceName" indexed="true" readonly="true" size="35"/></td>
	<html:hidden name="schemes" property="astType" indexed="true"  />
		<td  class="bwborder" ><html:text name="schemes" property="smsDate" indexed="true" readonly="true" size="8"/></td>
		<td  class="bwborder" ><html:text name="schemes" property="schemeStatus" indexed="true" readonly="true" onmouseover="Tip(this.value,TITLE,'Scheme Status')"  onmouseout="UnTip()" size="8" /></td>
		<td  class="bwborder" >
		<html:select name="schemes" property="actionTaken" styleClass="mycombo" style="width:80px" indexed="true" >
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		<html:option value="Y">Yes</html:option>
		<html:option value="N">No</html:option>
		</html:select>
		</td>
		<td  class="bwborder" >
		<html:text name="schemes"  property="dateOfAction" styleClass="mytext" style="width:50"   indexed="true"  />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('schemes[<%= count-2 %>].dateOfAction'));">
			 <IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		</td> 
	<%--<td  class="rptValue" ><html:text name="schemes" property="dateEntered" indexed="true" readonly="true" size="10"/></td> --%>
		<td  class="bwborder" >		
		<html:select name="schemes" property="repCode" styleClass="mycombo" style="width:170px" indexed="true" >
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		<html:option value="001"><font class="myfontclr1">Pumpset repair</font></html:option>
		<html:option value="002"><font class="myfontclr1">Pipeline damage/leakage</font></html:option>
		<logic:equal name="schemes" property="astType"  value="01">
		<html:option value="003"><font class="myfontclr1">Treatment Plant repairs</font></html:option>
		<html:option value="004"><font class="myfontclr1">Insufficient yield of source</font></html:option>
		<html:option value="005"><font class="myfontclr1">Power problem</font></html:option>
		<html:option value="006"><font class="myfontclr1">Maintenance problem</font></html:option>
		</logic:equal>
		<logic:equal name="schemes" property="astType"  value="02">
		<html:option value="003"><font class="myfontclr1">Treatment Plant repairs</font></html:option>
		<html:option value="004"><font class="myfontclr1">Insufficient yield of source</font></html:option>
		<html:option value="005"><font class="myfontclr1">Power problem</font></html:option>
		<html:option value="006"><font class="myfontclr1">Maintenance problem</font></html:option>
		</logic:equal>
		<logic:equal name="schemes" property="astType"  value="03">
		<html:option value="003"><font class="myfontclr1">Treatment Plant repairs</font></html:option>
		<html:option value="004"><font class="myfontclr1">Insufficient yield of source</font></html:option>
		<html:option value="005"><font class="myfontclr1">Power problem</font></html:option>
		<html:option value="006"><font class="myfontclr1">Maintenance problem</font></html:option>
		</logic:equal>
		<logic:equal name="schemes" property="astType"  value="04">
		<html:option value="003"><font class="myfontclr1">Insufficient yield of source</font></html:option>
		<html:option value="004"><font class="myfontclr1">Power problem</font></html:option>
		<html:option value="005"><font class="myfontclr1">Maintenance problem</font></html:option>
		</logic:equal>
		<logic:equal name="schemes" property="astType"  value="09">
		<html:option value="003"><font class="myfontclr1">Insufficient yield of source</font></html:option>
		<html:option value="004"><font class="myfontclr1">Power problem</font></html:option>
		<html:option value="005"><font class="myfontclr1">Maintenance problem</font></html:option>
		</logic:equal>
       	</html:select>
		</td>
		<td  class="bwborder" ><html:text name="schemes" property="repCost"  indexed="true" size="15" onkeypress="return decimalsOnly(event)"/></td> 
		<td  class="bwborder" ><html:text name="schemes" property="remarks" indexed="true"/></td>
		<td>			
		<html:checkbox name="schemes" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
		</td>	
		
	</tr>
	</logic:iterate>
	</logic:notEmpty> 
	</table>
	</div>
	<%if(count==1)
		{
		%>
		<tr><td colspan="17" align="center" class="btext">No Records</td></tr>
		<tr>
<td colspan="17" align="center"><input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
		</tr>
		<%}
		else{%>
		<tr>
		 <td colspan="17" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">
				&nbsp;<input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
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

