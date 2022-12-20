<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<head>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
div#tbl-container22 {
width: 600px;
height: 250px;
overflow: auto;
scrollbar-base-color:#C9C299;
}
div#tbl-container22 tr.normalRow td {
background: #fff;
font-size: 11px;
height: 28px;
}
div#tbl-container22 tr.alternateRow td {
background: #B6C9AD;

font-size: 8px;.
height: 21px;
}
div#tbl-container22 table {
table-layout: fixed;
border-collapse: collapse;
background-color: WhiteSmoke;
}
div#tbl-container22 table th {
height: 28px;

}
div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
font-size: 10px;
font-weight: bold;
text-align: center;

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
background-color: #ffeaff;
font-weight: bold;
left: expression(document.getElementById("tbl-container22").scrollLeft); /* IE5+ only */
position: relative;
z-index: 10;

}
fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</STYLE>


<script type="text/javascript">

function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=getmandal";
document.forms[0].submit();
}
function funcMandalChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=getpanchayath";
	document.forms[0].submit();
}
function fnPanchayathChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=getvillage";
	document.forms[0].submit();
}
function fnVillageChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=gethab";
	document.forms[0].submit();
}

function view()
{
	var district = document.forms[0].district.value;
	var mandal = document.forms[0].mandal.value;
	var panchayath = document.forms[0].panchayat.value;
	var village = document.forms[0].village.value;
	var hab = document.forms[0].habCode.value;
	
	if (district == null || district == "") {
		alert("Please select district");
		document.forms[0].district.focus();
		return false;
	}
	if (mandal == null || mandal == "") {
		alert("Please select mandal");
		document.forms[0].mandal.focus();
		return false;
	}
	if (panchayath == null || panchayath == "") {
		alert("Please select panchayath");
		document.forms[0].panchayat.focus();
		return false;
	}
	if (village == null || village == "") {
		alert("Please select village");
		document.forms[0].village.focus();
		return false;
	}
	if (hab == null || hab == "") {
		alert("Please select habitation");
		document.forms[0].habCode.focus();
		return false;
	}
	
	else{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=view";
	document.forms[0].submit();}
}
function save()
{var district = document.forms[0].district.value;
var mandal = document.forms[0].mandal.value;
var panchayath = document.forms[0].panchayat.value;
var village = document.forms[0].village.value;
var hab = document.forms[0].habCode.value;

if (district == null || district == "") {
	alert("Please select district");
	document.forms[0].district.focus();
	return false;
}
if (mandal == null || mandal == "") {
	alert("Please select mandal");
	document.forms[0].mandal.focus();
	return false;
}
if (panchayath == null || panchayath == "") {
	alert("Please select panchayath");
	document.forms[0].panchayat.focus();
	return false;
}
if (village == null || village == "") {
	alert("Please select village");
	document.forms[0].village.focus();
	return false;
}
if (hab == null || hab == "") {
	alert("Please select habitation");
	document.forms[0].habCode.focus();
	return false;
}else{
	alert("hi");
	var habitations1="";
	 var len=document.forms[0].resultCount.value;
	 alert("hi"+len);
	len = len-1;
	for( var j=0;j<len;j++)
	{     
		
			if(document.getElementById("hablist["+j+"].checks").checked==true)
			{
				habitations1=habitations1+document.getElementById("hablist["+j+"].householdnum").value;
				habitations1=habitations1+","+document.getElementById("hablist["+j+"].gender").value;
				habitations1=habitations1+","+document.getElementById("hablist["+j+"].adharcardnum").value;
				habitations1=habitations1+","
				if(document.getElementById("hablist["+j+"].gender").value==""){
					alert("please select gender "+(j+1)+"th row");
					return;
				}
			}}
	
	alert(habitations1);
	if(habitations1=="")
	   {
		 alert("Select atleast one check box to save");
    }
	  else{
		  document.forms[0].hab1.value = habitations1;
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/goihousehold.do?mode=save";
	document.forms[0].submit();
}}}
</script>
</head>
<%
int count=1;
%>

<html:form action="/goihousehold.do">
	
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Base Line Servey Household Details Entry" />
	<jsp:param name="TWidth" value="600" />
</jsp:include>
<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="600" >
		<tr>
			<td class="textborder" >
				<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD"
					style="border-collapse: collapse;" width="90%">
					
					<tr><td><font color="#000000" face=verdana size=2><B>District
		 
         </B></font></td><td>
		<html:select property="district" style="width:141px"   onchange="javascript: funcDistrictChanged();" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
    	 </html:select>
		
		</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B>Mandal&nbsp; </B></font></td><td>
		<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="javascript: funcMandalChanged();">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="mandalcodes">
		 <html:options collection="mandalcodes" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select>
	</td>
	</tr>	
	<tr>
	<td class="textborder" >
		<font color="#000000" face=verdana size=2><B>Panchayat </B></font></td><td>
		<html:select property="panchayat" style="width:140px"    styleClass="mycombo" onchange="fnPanchayathChanged()" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="panchayaths">
		
		<html:options collection="panchayaths" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select>
	 </td>

	<td class="textborder" >
		 <font color="#000000" face=verdana size=2><B>Village</B></font></td><td>
		 <html:select property="village" style="width:140px"    styleClass="mycombo" onchange="fnVillageChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 						<logic:notEmpty name="villages">
		 		
		 		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:notEmpty>
		 </html:select>
	</td>
	</tr>	
	<tr>
	<td class="textborder" ><font color="#000000" face=verdana size=2><B>Habitation</B></font></td><td>
        <html:select property="habCode" styleClass="mycombo" style="width:280px" onchange="view()"> 
	    <html:option value="">SELECT...</html:option>
	    				<logic:notEmpty name="habitations">
	    
	    <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	   </logic:notEmpty>
	    </html:select>
        </td>
        
        </tr>
        <tr align="center"><td class="textborder"  colspan="4">
        <div id="tbl-container22">
        <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="100%" border=1 style="border-collapse:collapse" >
<tr>
			<td class=btext>Select</td>
			<td class=btext>Household No.</td>
			<td class=btext>Head Name</td>
			<td class=btext>Gender</td>
			<td class=btext>Aadhar Card No</td>
			
</tr>
<logic:notEmpty name="habdetails">
<nested:iterate id="hablist" name="habdetails" indexId="ndx">

<tr>
<td width="40px" align="center" class="rptValue">
					<html:checkbox name="hablist" property="checks"   indexed="true"  />
				</td>
				
	<td width="40px" align="left" class="rptValue">
	<nested:hidden name="hablist" property="householdnum"  indexed="true"/>
	<bean:write name="hablist" property="householdnum" /></td>
	<td width="40px" align="left" class="rptValue"><bean:write name="hablist" property="hedname" /></td>	
	<td width="40px" align="center" height="30px" >
					<html:select name="hablist"   property="gender" styleClass="mycombo" indexed="true"  style="width:60px">
	 
	    <html:option value="">Select..</html:option>
	    <html:option value="male">Male</html:option>
	    <html:option value="female">Female</html:option>
	    </html:select></td>	
	<td width="40px" align="left" class="rptValue" ><html:text name="hablist" property="adharcardnum" styleClass="mytext1" size="25" maxlength="20" indexed="true" onkeypress="return checkSpaceAndSpecial(event)"/></td>				
</tr>
<%count++; %>
</nested:iterate>
</logic:notEmpty>
<logic:empty name="habdetails">
<tr><td  align="center" colspan="5">No Records</td></tr>
</logic:empty>

</table></div></td></tr>
	<tr>
			<td align="center" colspan="4"><input type="button"  class="btext2" name="SAVE" value="save" onclick="save()"/>
				
				
		</tr>
				</table>
				
			</td>
		</tr>
				
		</table>
		
		<input type="hidden" name="resultCount" value="<%=count%>">
	<input type=hidden name=hab1>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="600" />
	</jsp:include>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>