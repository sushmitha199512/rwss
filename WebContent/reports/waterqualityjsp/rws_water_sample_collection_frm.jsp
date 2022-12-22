<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="waterSampleForm" /> 
<SCRIPT LANGUAGE="JavaScript">
<!--
function check()
{
if(document.forms[0].circleOfficeCode.value == "" || document.forms[0].divisionOfficeCode.value == "" || document.forms[0].subdivisionOfficeCode.value == "" || document.forms[0].mandalCode.value == "" || document.forms[0].panchayatCode.value == "" || document.forms[0].habCode.value == "" || document.forms[0].sourceType.value == "" || document.forms[0].sourceCode.value == "" || document.forms[0].testCode.value == "" || document.forms[0].natureOfTest.value == "" || document.forms[0].sampCollectCode.value == "" || document.forms[0].sampCollectDate.value == "" || document.forms[0].sampCollectTime.value == "" || document.forms[0].labCode.value == "" )
{
	document.getElementById('mode1').disabled = true;
}
else
{
	document.getElementById('mode1').disabled = false;
}

}
function check1()
{
if(document.forms[0].circleOfficeCode.value == "" || document.forms[0].divisionOfficeCode.value == "" || document.forms[0].subdivisionOfficeCode.value == "" || document.forms[0].mandalCode.value == "" || document.forms[0].panchayatCode.value == "" || document.forms[0].habCode.value == "" || document.forms[0].sourceType.value == "" || document.forms[0].sourceCode.value == "" || document.forms[0].testCode.value == "" || document.forms[0].natureOfTest.value == "" || document.forms[0].sampCollectCode.value == "" || document.forms[0].sampCollectDate.value == "" || document.forms[0].sampCollectTime.value == "" || document.forms[0].labCode.value == "" )
{
	document.getElementById('mode1').disabled = true;
}
else
{
	document.getElementById('mode1').disabled = false;
}

}
function Reset()
{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=reset";
	document.forms[0].submit();
}
function funcReset()
{

document.forms[0].sourceType.value="";
document.forms[0].sourceCode.value="";
document.forms[0].sourceCode.length=0;
document.forms[0].sourceCode.options[0]=new Option("SELECT...","");
getData();
}
function showSources()
{
	var circleOfficeCode=document.forms[0].circleOfficeCode.value;
	var mandalCode=document.forms[0].mandalCode.value;
	var panchayatCode = document.forms[0].panchayatCode.value;
	var habCode = document.forms[0].habCode.value;
	var width = 650;
	var height = 450;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
if(document.forms[0].panchayatCode.value != "")
{
	if(document.forms[0].habCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewSources&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode+"&panchayatCode="+panchayatCode+"&habCode="+habCode;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
	alert("Habitation is Required");
	}
}
else
{
	if(document.forms[0].mandalCode.value!="")
	{
		 var url = "switch.do?prefix=/wquality&page=/WaterSample.do&mode=viewSources&circleOfficeCode="+circleOfficeCode+"&mandalCode="+mandalCode;
	     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
	}
	else
	{
		alert("Mandal Required");
	}
}
	
//document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
//document.forms[0].submit();
}
function getData()
{
	
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
	document.forms[0].submit();
	
}
function getSourceCodes()
{
//	alert(document.forms[0].sourceType.value);
	if(document.forms[0].mandalCode.value!="")
	{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
	document.forms[0].submit();
	}
	else 
	{
	document.forms[0].sourceType.value="";
	alert("Please Select Mandal");
	}
}
function getSourceLocation()
{
	
	if(document.forms[0].habCode.value!="")
	{
	document.forms[0].action="switch.do?prefix=/wquality&page=/WaterSample.do&mode=data";
	document.forms[0].submit();
	}
	else 
	{
	document.forms[0].sourceType.value="";
	alert("Please Select Habitation");
	}
}

//-->
</SCRIPT><%@ include file="/commons/rws_header2.jsp" %>
<body onload = "check()">
<html:form action="/WaterSample.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Collection" />
	<jsp:param name="TWidth" value="770" />
	<jsp:param name="contextHelpUrl" value="./help/WaterQuality.doc" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="810" border=1 style="border-collapse:collapse;" >
<tr>
<td  >
<fieldset>
<legend> Office Details </legend>
<label>
<table cellpadding="0" cellspacing="0" border="0"  width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
<td class="bwborder"><FONT class=myfontclr>Head Office&nbsp;:</FONT></td>
	<td class="bwborder">
				<html:text property="headOfficeName"  
						   name="RWS_USER" readonly="true"/>
				<html:hidden property="headOfficeCode" name="RWS_USER"/>
			</td>
	 
		<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
	<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="circleOfficeCode" onchange="getData()" 
							 styleClass="combo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="circles">
					<html:options collection="circles" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="circleOfficeName"  
						   name="RWS_USER" readonly="true" styleClass="text"/>
				<html:hidden property="circleOfficeCode" name="RWS_USER" />
			</logic:notEqual>
		</td>
		 
 
	 </tr>
	 <tr>
	<td class="bwborder"><FONT class=myfontclr>Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
	 <logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:select property="divisionOfficeCode" onchange="getData()"
						 styleClass="combo">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="divisions">
			<html:options collection="divisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>			  
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="divisionOfficeCode" value="0">
			<html:text property="divisionOfficeName"  
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="divisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>

	<td class="bwborder"><FONT class=myfontclr>Sub Division&nbsp;<font color="#FF6666">*</font>:</FONT></td>
	<td class="bwborder">
	 <logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:select property="subdivisionOfficeCode" styleClass="combo" onchange="getData()">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<logic:notEmpty name="subdivisions">
			<html:options collection="subdivisions" name="labelValueBean" 
						  property="value" labelProperty="label" />
			</logic:notEmpty>
			</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="subdivisionOfficeCode" value="00">
			<html:text property="subdivisionOfficeName"    
					   name="RWS_USER" readonly="true"/>
			<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
		</logic:notEqual>
		</td>
	</tr>
	</table>
	</label>
	</fieldset>
	<fieldset>
	<%
	String special = (String)request.getAttribute("special");
	//System.out.println("Special ::"+special); 
	%>
<legend  > Habitation Details </legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tr>
		<td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="mandalCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
		</html:select>
		</td>
	<%
	if(special != null && special.equals("special"))
	{
	%>
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%}
	else if(special == null || special.equals(""))
	{ %>
		<td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left >
		<html:select property="panchayatCode" styleClass="mycombo" style="width:120px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchyats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666"></font></FONT></td>
		<td align=left colspan="5">
		<html:select property="habCode" styleClass="mycombo" style="width:320px" onchange="funcReset()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	</tr>
	<%} %>
	<tr><td colspan="10">&nbsp;</td></tr>
	<tr>
	<td colspan="10" align="center"><html:button property="mode"   styleClass="btext" value="Select Sources" onclick="return showSources()"/></td>
	</tr>
	
	</table>
	</label>
	</fieldset>
		<fieldset>
		<legend > Sample Collection Details </legend>
		<label>
		<table width="100%" cellspacing="4" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
		<tr>
		
		</tr>
		<tr>
			<td class="bwborder" nowrap><FONT class=myfontclr>Source Type&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder">
			<html:hidden property="testId"/>
			<html:select property="sourceType" styleClass="mycombo" style="width:123px" onchange="getSourceCodes()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sources" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />
			</html:select>
			</td>
			
			
			<td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>
			
			<td class="bwborder" colspan="3">
			<html:select property="sourceCode" styleClass="mycombo" style="width:400px" onchange="getSourceLocation()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceAndLocation" />
			</html:select>
			
			</td>
			
			
			<!-- 
			<td class="bwborder"><FONT class=myfontclr>Location&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder"><html:text property="location"  size="12" readonly="true" styleClass="mytext" style="width:133px"/></td>
			  -->
			
			
		</tr>
		
		<tr>
			<td class="bwborder"><FONT class=myfontclr>Type of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="testCode" styleClass="mycombo" style="width:123px" onchange="check1();">
			<html:option value="">SELECT...</html:option>
			<html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testName" />
			</html:select>
			</td>
			
			<td class="bwborder"><FONT class=myfontclr>Nature of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="natureOfTest" styleClass="mycombo" style="width:130px" onchange="check1();">
			<html:option value="">SELECT...</html:option>
			<html:option value="1">ROUTINE</html:option>
			<html:option value="2">SEASONAL</html:option>
			<html:option value="3">QUARTERLY</html:option>
			<html:option value="4">DISEASE OUTBREAK</html:option>
			</html:select>
			</td>
			
			<td class="bwborder"><FONT class=myfontclr>Sample Collected By&nbsp;:<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder">
			<html:select property="sampCollectCode" styleClass="mycombo" style="width:133px" onchange="check1();">
			<html:option value="">SELECT...</html:option>
			<html:options collection="desgns" name="rwsMaster"  property="desgnCode" labelProperty="desgnAcr" />
			
			</html:select>
			</td>
			
			</tr>
		<tr>
			
			
			<td class="bwborder"><FONT class=myfontclr>Collection Date<br>and Time&nbsp;:<font color="#FF6666">*</FONT></td>
			<td class="bwborder" nowrap>
			<html:text property="sampCollectDate" size="9"  styleClass="mytext" maxlength="10" onchange="check1();"/>
			<html:text property="sampCollectTime" size="4" styleClass="mytext" maxlength="5" onchange="check1();"/>
			<a href="javascript: showCalendar(document.waterSampleForm.sampCollectDate);">
			<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
			<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;HH:MM</font></font>
			</td>
			
		
			<td class="bwborder"><FONT class=myfontclr>Assigned On&nbsp;:</FONT></td>
			<td class="bwborder"><html:text property="assignedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" readonly="true" styleClass="mytext"/></td>
		
			<% 
			java.util.ArrayList col = new java.util.ArrayList();
			col = (java.util.ArrayList)session.getAttribute("wqlabs");
			//System.out.println("col size:"+col.size());
			 %>
			<td class="bwborder"><FONT class=myfontclr>Lab Assigned To<font color="#FF6666">*</font></FONT></td>
			<td class="bwborder" colspan="5"><html:select property="labCode" styleClass="mycombo" style="width:133px" onchange="check1();">
			<html:option value="">SELECT...</html:option>
			<html:options collection="wqlabs" name="rwsMaster"  property="labCode" labelProperty="location" />
			</html:select>
			</td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
		
	<tr>
	<td align="center">
	<html:submit property="mode1" title="Save the Fields"  styleClass="btext" value="Save" onclick="return validateWaterSampleForm(this);"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="Reset();" />
    
	<html:submit property="mode" title="View the Fields" styleClass="btext" value="View"   />
	
	<bean:define id="userId" name="RWS_USER" property="userId" />
	<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
	<html:hidden property="preparedOn" value="<%=sdf.format(new java.util.Date())%>"/>
	</td>
	</tr>
	</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="770"/>
</jsp:include>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>