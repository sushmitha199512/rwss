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
	var length= document.ohsrForm.resultCount.value;
	
	//document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	//document.forms[0].elements['sBtn'].disabled=true;
	
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{	
		
	if(document.forms[0].elements["ohsr["+k+"].checks"].checked)
	 {
		 if(document.getElementById("ohsr["+k+"].actionTaken").value==""){
			 alert("Please Select Action Taken Date");
			 document.getElementById("ohsr["+k+"].actionTaken").focus();
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
		
		
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=SaveOhsr";		
		
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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=ohsrData";	

	  document.forms[0].submit();
	}
	
}

function getData(){
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=get";	

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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/OhsrActionTaken.do&mode=ohsrDataView";	
	
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

<html:form  action="OhsrActionTaken" method="post">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="OHSR&GLSR Action Taken" />
	<jsp:param name="TWidth" value="1100" />	
</jsp:include>
<table   align=center bgcolor="#DEE3E0" bordercolor= "black"  style="border-collapse:collapse;" width="81%" >	
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
		<html:select property="village" style="width:140px"    styleClass="mycombo" onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="villages" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		
</td>
<td class=mycborder><font face=verdana size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Habitation<font color="red">*</font></font></td>
		<td class="textborder">
		<html:select property="habitation" style="width:140px"    styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="habitations" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		
</td>
<td>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button value="Get Data" onclick="getResidualData()">
</td> --%>
</tr>
</table>
</label></fieldset></td></tr>

<tr>

<td class="mycborder">
		<fieldset>
			<legend>OHSR & GLSR Action Taken </legend>
			<label>
		
		
		<table border=1 style="border-collapse: collapse;" style="margin-bottom:5;margin-top:10" align=center>
		
<tr >
	<td class="btext" align="center" >S.No<font color="red">*</font></td>
	<td class="btext" align="center" >Habitation Name<font color="red">*</font></td>
	<td class="btext" align="center" >Asset Code<font color="red">*</font></td>
	<td class="btext" align="center" >Asset Name<font color="red">*</font></td>
	<td class="btext" align="center" >Local Person Name<font color="red">*</font></td>
	<td class="btext" align="center" >SMS Received On<font color="red">*</font></td>
	<td class="btext" align="center" >Location<font color="red">*</font></td>
	<td class="btext" align="center" >Status<font color="red">*</font></td>
	<td class="btext" align="center" >Type<font color="red">*</font></td>
	<td class="btext" align="center" >Action Taken Date<font color="red">*</font></td>
	 
	<td class="btext" align="center" >Remarks</td>
	<td class="btext" align="center" >Select<font color="red">*</font></td>
	</tr>
	
	
	<%
  int count=1;
%>
	
	<logic:notEmpty name="ohsrForm" property="ohsr">
	<logic:iterate id="ohsr" name="ohsrForm" property="ohsr" indexId="index">
	
	<%//System.out.println("hi"); %>             
	
	    <tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		
		<html:hidden name="ohsr" property="smsDate" indexed="true"/>
		<html:hidden name="ohsr" property="smsMobile" indexed="true"/>
		<html:hidden name="ohsr" property="mesid" indexed="true"/>
		<html:hidden name="ohsr" property="habitation" indexed="true"/>
		
		<td  class="rptValue" ><html:text name="ohsr"  property="habitationName" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="ohsr"  property="assetCode" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="ohsr"  property="assetName" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="ohsr"  property="localpersonname" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="ohsr"  property="smsDate" indexed="true" readonly="true" size="14"/></td>
		
		<td  class="rptValue" ><html:text name="ohsr"  property="location" indexed="true" readonly="true" size="14"/></td>
		<td  class="rptValue" ><html:text name="ohsr" property="status" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" ><html:text name="ohsr" property="type" indexed="true" readonly="true" size="8"/></td>
		<td  class="rptValue" >
		<html:text name="ohsr"  property="actionTaken"   
				    			   styleClass="mytext" style="width:50"   indexed="true"  />&nbsp;<a href="javascript: showCalendarFuture(document.getElementById('ohsr[<%= count-2 %>].actionTaken'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"></a>
		</td>
		
		
		<td  class="rptValue" ><html:text name="ohsr" property="remarks" indexed="true"/></td>
		
		
		
	
	<td>			
		<html:checkbox name="ohsr" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' onchange = "change()"/>
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

