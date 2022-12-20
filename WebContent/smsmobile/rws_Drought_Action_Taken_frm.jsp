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
	
	var length= document.droughtForm.resultCount.value;
	
	
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{	
		
	if(document.forms[0].elements["drought["+k+"].checks"].checked)
	 {
		if(document.getElementById("drought["+k+"].tankerUpdateStatus").value==""){
			 alert("Please Select Tanker Update Status");
			 document.getElementById("drought["+k+"].tankerUpdateStatus").focus();
					 return false;
		 }
		else if(document.getElementById("drought["+k+"].tankerSupplyDate").value==""){
			 alert("Please Select Tankaer Supply Date");
			 document.getElementById("drought["+k+"].tankerSupplyDate").focus();
					 return false;
		 }
		
		else{
			flag=true;
		}
	 
	}	
	
	}
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;  
		 return;
	}
	
	
	else{
		
		
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=SaveDrought";		
		
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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=droughtData";	

	  document.forms[0].submit();
	}
	
}

function getData(){
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=get";	

	  document.forms[0].submit();
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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/DroughtActionTaken.do&mode=droughtDataView";	
	
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

<html:form  action="DroughtActionTaken" method="post">


<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Drought Action Taken" />
	<jsp:param name="TWidth" value="1100" />	
</jsp:include>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"    style="border-collapse:collapse;" width="80%" >	
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
			<legend>Drought Action Taken </legend>
			<label>
		
		
		<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10" align=center>
		
<tr >
	<td class="btext" align="center" >S.No<font color="red">*</font></td>
	<td class="btext" align="center" >Habitation Name<font color="red">*</font></td>
	<td class="btext" align="center" >Local Person Name<font color="red">*</font></td>
	<td class="btext" align="center" >SMS Received On<font color="red">*</font></td>
	<td class="btext" align="center" >Location<font color="red">*</font></td>
	<td class="btext" align="center" >Tanker Status<font color="red">*</font></td>
	<td class="btext" align="center" >Tanker Update Status<font color="red">*</font></td>
	<td class="btext" align="center" >Tanker Supply Date<font color="red">*</font></td>
	<!-- <td class="btext" align="center" >Date Entered<font color="red">*</font></td> -->
	<td class="btext" align="center" >Service Request<font color="red">*</font></td>
	<td class="btext" align="center" >Remarks</td>
	<td class="btext" align="center" >Select<font color="red">*</font></td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="droughtForm" property="drought">
	<logic:iterate id="drought" name="droughtForm" property="drought" indexId="index">
	      
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		<html:hidden name="drought" property="droughtHabCode" indexed="true"/>
		<html:hidden name="drought" property="smsDate" indexed="true"/>
		<html:hidden name="drought" property="smsMobile" indexed="true"/>
		<html:hidden name="drought" property="mesid" indexed="true"/>
		<html:hidden name="drought" property="habitation" indexed="true"/>
		
		
		<td  class="rptValue" ><html:text name="drought"  property="habitationName" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="drought"  property="localpersonname" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="drought"  property="smsDate" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="drought"  property="location" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="drought" property="tankerStatus" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" >
		<html:select name="drought" property="tankerUpdateStatus" styleClass="mycombo" style="width:80px" indexed="true">
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		<html:option value="Y">Yes</html:option>
		<html:option value="N">No</html:option>
		</html:select>
		</td>
		<td  class="rptValue" >
		<html:text name="drought"  property="tankerSupplyDate"   
				    			   styleClass="mytext" style="width:50"   indexed="true"  />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('drought[<%= count-2 %>].tankerSupplyDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"></a>
		</td>
		<%-- <td  class="rptValue" ><html:text name="drought" property="dateEntered" indexed="true" readonly="true" size="10"/></td> --%>
		<td  class="rptValue" ><html:text name="drought" property="serviceRequest" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" ><html:text name="drought" property="remarks" indexed="true"/></td>
		
		
		
	
	<td>			
		<html:checkbox name="drought" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
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
		<td colspan="20" align="center"><input type=button value=Save id="sBtn" onClick="fnSave();" class="btext">
		&nbsp;
		<input type=button value=View id="vBtn" onClick="fnView();" class="btext"></td>
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

