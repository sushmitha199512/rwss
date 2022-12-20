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

function fnSave(){
	
	//alert("hi");
	var length= document.schemesForm.resultCount.value;
	
	//document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	//document.forms[0].elements['sBtn'].disabled=true;
	
	
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
		 }
		else if(document.getElementById("schemes["+k+"].dateOfAction").value==""){
			 alert("Please Select Date of Action");
			 document.getElementById("schemes["+k+"].dateOfAction").focus();
					 return false;
		 }
		else{
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
		
		
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/SchemesActionTaken.do&mode=updateSchemes";		
		
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
</script>





<%
nic.watersoft.commons.RwsUser user=null;
user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String loggedUser = user.getUserId();
System.out.println("loggedUser"+loggedUser);
String circle=loggedUser.substring(1,3);

session.setAttribute("circle",circle);

%>

<body  onload="javascript:init();" >

<html:form  action="SchemesActionTaken" method="post">


<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Schemes Action Taken" />
	<jsp:param name="TWidth" value="1100" />	
</jsp:include>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"    style="border-collapse:collapse;" width="88%" >	
<tr>
	<td class="mycborder">
		<fieldset>
			<legend>Habitation Details</legend>
			<label>
<table  border=0 align=center>
<tr><td class=mycborder><font face=verdana size=2>District<font color="red">*</font></font></td>
		<td class="textborder">
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="district" style="width:140px"  	 styleClass="mycombo"  disabled="true">
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
		<html:select property="mandal" style="width:140px"    styleClass="mycombo"  disabled="true"	>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
</td>

<%-- <td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Panchayat<font color="red">*</font></font></td>
		<td class="textborder">
		
		<html:select property="panchayat" style="width:140px"    styleClass="mycombo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
</td>
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
</td>--%>
</tr>
</table>
</label></fieldset></td></tr>

<tr>

<td class="mycborder">
		<fieldset>
			<legend>Schemes Action Taken</legend>
			<label>
		
		
		<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10" align=center>
		
<tr >
	<td class="btext" align="center" >S.No<font color="red">*</font></td>
	<td class="btext" align="center" >Habitation Name<font color="red">*</font></td>
	<td class="btext" align="center" >Local Person Name<font color="red">*</font></td>
	<td class="btext" align="center" >Asset Code<font color="red">*</font></td>
	<td class="btext" align="center" >Asset Name<font color="red">*</font></td>
	<td class="btext" align="center" >Location<font color="red">*</font></td>
	<td class="btext" align="center" >Status<font color="red">*</font></td>
	<td class="btext" align="center" >Action Taken<font color="red">*</font></td>
	<td class="btext" align="center" >Date Of Action<font color="red">*</font></td>
	<td class="btext" align="center" >Date Entered<font color="red">*</font></td>
	<td class="btext" align="center" >Service Request<font color="red">*</font></td>
	<td class="btext" align="center" >Remarks</td>
	<td class="btext" align="center" >Select<font color="red">*</font></td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="schemesForm" property="schemes">
	<logic:iterate id="schemes" name="schemesForm" property="schemes" indexId="index">
	
	<%System.out.println("hi"); %>
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		
		
		
		<%-- <td  class="rptValue" >
		
		<html:select   name="schemes" property="sourceCode" styleClass="mycombo" style="width:150px" indexed="true" onchange="javascript:getSourceDetails()" >
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
       <html:options collection="sources" name="rwsLocationBean" property="value" labelProperty="label" />
       </html:select>

		</td> --%>
		<html:hidden name="schemes" property="smsDate" indexed="true"/>
		<html:hidden name="schemes" property="smsMobile" indexed="true"/>
			<html:hidden name="schemes" property="mesid" indexed="true"/>
		 <td  class="rptValue" ><html:text name="schemes"  property="habitationName" indexed="true" readonly="true" size="14"/></td>
		 
		  <td  class="rptValue" ><html:text name="schemes"  property="localpersonname" indexed="true" readonly="true" /></td>
		 
		 
		 
		<td  class="rptValue" ><html:text name="schemes"  property="assetCode" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="schemes" property="assetName" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" ><html:text name="schemes" property="location" indexed="true" readonly="true" size="8"/></td>
		
		<td  class="rptValue" ><html:text name="schemes" property="schemeStatus" indexed="true" readonly="true" onmouseover="Tip(this.value,TITLE,'Scheme Status')"  onmouseout="UnTip()" size="8" /></td>
		<td  class="rptValue" >
		<html:select name="schemes" property="actionTaken" styleClass="mycombo" style="width:80px" indexed="true">
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		<html:option value="Y">Yes</html:option>
		<html:option value="N">No</html:option>
		</html:select>
		</td>
		<td  class="rptValue" >
		<html:text name="schemes"  property="dateOfAction"   
				    			   styleClass="mytext" style="width:50"   indexed="true"  />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('schemes[<%= count-2 %>].dateOfAction'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"></a>
		</td>
		<td  class="rptValue" ><html:text name="schemes" property="dateEntered" indexed="true" readonly="true" size="10"/></td>
		<td  class="rptValue" ><html:text name="schemes" property="serviceRequest" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" ><html:text name="schemes" property="remarks" indexed="true"/></td>
		
		
		
	
	<td>			
		<html:checkbox name="schemes" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
		</td>	
	</tr>
	</logic:iterate>
	</logic:notEmpty> 
	<%if(count==1)
		{
		%>
		<tr><td colspan="20" align="center" class="btext">No Records</td></tr>
		<tr>

		<%}
		else{%>
		<tr>
		<td colspan="20" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">
		</td>
		</tr>
		<%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	</table>
</label></fieldset></td></tr></table>
<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1100" />
</jsp:include>


</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

