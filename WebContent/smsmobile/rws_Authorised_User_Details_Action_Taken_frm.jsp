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

function fnSave(){
	
	//alert("hi");
	var length= document.authorisedUserDetailsForm.resultCount.value;
	var imeiNo = [];
	var habcode = [];
	var index=0;
	document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	document.forms[0].elements['sBtn'].disabled=true;
	
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{	
		
	if(document.forms[0].elements["users["+k+"].checks"].checked)
	 {
		
		flag=true;
	 
	}	//end if
	else if(document.forms[0].elements["users["+k+"].checks"].checked==false)
	 {
		
		if(document.forms[0].elements["users["+k+"].status"].value=="Y"){
			imeiNo[index]=document.forms[0].elements["users["+k+"].IMEINo"].value;
			//alert("imeiNo"+imeiNo[index]);
			habcode[index]=document.forms[0].elements["users["+k+"].habCode"].value;
			//alert("habcode"+habcode[index]);
			index++;
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
		
		
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=Save&imeiNo="+imeiNo+"&habcode="+habcode+"";		
		
		  document.forms[0].submit();
			

	}
	
}

function init()
{
	
	
	circleOfficeCode='';
	
	
	
		
		
	
}

function getcomplaintData()
{
	
	
	
		if(document.getElementById('circleOfficeCode').value=='')
			{
		alert("please Select Circle");
		return false;
			}
	
		if(document.getElementById('divisionOfficeCode').value=='')
		{
		alert("please Select Division");
		return false;
		}
		if(document.getElementById('subDivisionOfficeCode').value=='')
		{
		alert("please Select Sub Division");
		return false;
		}
	
	else
		{ 
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=userData";	

	  document.forms[0].submit();
	}
	
}
function getData(){
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=get2";	

	  document.forms[0].submit();
}
function fnView(){
		if(document.getElementById('circleOfficeCode').value=='')
		{
	alert("please Select Circle");
	return false;
		}
	
		else if(document.getElementById('divisionOfficeCode').value=='')
	{
	alert("please Select Division");
	return false;
	}
		else if(document.getElementById('subDivisionOfficeCode').value=='')
	{
	alert("please Select Sub Division");
	return false;
	}
	else
	{ 
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/AuthorisedUserDetails.do&mode=userDataView";	
	
	document.forms[0].submit();
	}
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

<html:form  action="AuthorisedUserDetails" method="post">
	<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Authorised Mobile User Details" />
	<jsp:param name="TWidth" value="1700" />	
</jsp:include>
<table   align=center bgcolor="white" bordercolor= "black"    style="border-collapse:collapse;" width="100%" >	
<tr>
	<td class="mycborder">
		<fieldset>
			<legend>Office Details</legend>
			<label>
<table  border=0  align=center>
<tr>

<td class=mycborder><font face=verdana size=2>Circle<font color="red">*</font></font></td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" style="width:140px"   onchange="javascript: getData()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName" styleClass="mytext" style="width:140px"
						    readonly="true" />
				
				<html:hidden property="circleOfficeCode" />
			</logic:notEqual>
</td>

<td class=mycborder><font face=verdana size=2>Division<font color="red">*</font></font></td>
		<td class="textborder">
		<html:select property="divisionOfficeCode" style="width:140px"  onchange="getData()"  styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
</td>
<td class=mycborder><font face=verdana size=2>Sub Division<font color="red">*</font></font></td>
		<td class="textborder">
		<html:select property="subDivisionOfficeCode" style="width:140px" styleClass="mycombo" onchange="getData()" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="subDivisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
</td>

<td>
<input type=button value="Get Data" onclick="getcomplaintData()">
</td>
</tr>
</table>
</label></fieldset></td></tr>

<tr>

<td class="mycborder">
		<fieldset>
			<legend>Authorized Mobile User Details</legend>
			<label>
		
		
		<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10"  align=center>
		
<tr >
	<td class="btext" align="center" >S.No</td>
	<td class="btext" align="center" >Habitation Code</td>
	<td class="btext" align="center" >IMEI No of Device</td>	
	<td class="btext" align="center" >User Name</td>
	<td class="btext" align="center" >Data Collector Name</td>
	<td class="btext" align="center" >Mobile Number</td>
	<td class="btext" align="center" >Designation </td>
	<td class="btext" align="center" >Gender</td>
	<td class="btext" align="center" >Email id</td>
	<td class="btext" align="center" >Address</td>	
	<td class="btext" align="center" >Service Request</td>
	<td class="btext" align="center" >Date Of Request</td>
	<td class="btext" align="center" >Select</td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="authorisedUserDetailsForm" property="users"> 
	<logic:iterate id="users" name="authorisedUserDetailsForm" property="users" indexId="index">
	
	
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		
		
		
		<td  class="rptValue" ><bean:write name="users" property="habCode" /></td>
		<html:hidden property="habCode" name="users" indexed="true"/>
		
		<td  class="rptValue" ><bean:write name="users" property="IMEINo" /></td>
		<html:hidden property="IMEINo" name="users" indexed="true"/>
		<html:hidden property="userName" name="users" indexed="true"/>
		<html:hidden property="mobileNumber" name="users" indexed="true"/>
		<html:hidden property="status" name="users" indexed="true"/>
		
		<td  class="rptValue" ><bean:write name="users" property="userName" /></td>
		<td  class="rptValue" ><bean:write name="users" property="dataCollectorName" /></td>
		<td  class="rptValue" ><bean:write name="users" property="mobileNumber" /></td>
		<td  class="rptValue" ><bean:write name="users" property="designation" /></td>
		<td  class="rptValue" ><bean:write name="users" property="gender" /></td>
		<td  class="rptValue" ><bean:write name="users" property="emailId" /></td>
		<td  class="rptValue" ><bean:write name="users" property="address" /></td>
		<td  class="rptValue" ><bean:write name="users" property="serviceRequest" /></td>
		<td  class="rptValue" ><bean:write name="users" property="dateofRequest" /></td>
		
		
	
	<td>			
		<html:checkbox name="users" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
		</td>	
	</tr>
	</logic:iterate>
	</logic:notEmpty> 
	<%if(count==1)
		{
		%>
		<tr><td colspan="20" align="center" class="btext">No Records</td></tr>
		<tr>
<td colspan="20" align="center"><input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
		</tr>
		<%}
		else{%>
		<tr>
		<td colspan="20" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">&nbsp;
		<input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
		</tr>
		<%}%>
		
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	</table>
</label></fieldset></td></tr></table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1650" />
</jsp:include>


</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

