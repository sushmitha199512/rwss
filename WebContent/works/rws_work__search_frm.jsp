<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%

    int count = 1;
	nic.watersoft.commons.RwsUser rwsusers=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String rwsuserid = rwsusers.getUserId();
	String ad=(String)session.getAttribute("userId");
	System.out.println("user:"+ad);
%>
<head>
<script type="text/javascript">

function disableCircle(){

	alert("fdsfSA");
	 
	 if(document.forms[0].elements['searchString'].value.length>=1){
	 document.forms[0].elements['circleOfficeCode'].disabled=true;
	 document.forms[0].elements['schemeCode'].disabled=true;
	 document.forms[0].elements['programCode'].disabled=true;
	 }else{
		 document.forms[0].elements['circleOfficeCode'].disabled=false;
		 document.forms[0].elements['schemeCode'].disabled=false;
		 document.forms[0].elements['programCode'].disabled=false;
	 }
	 
}
</script>

<script type="text/javascript">


function getDetails(){
	 if(document.forms[0].elements['workId'].value=="0"){
		 alert("Please Select Work");
		 return;
	 }
	 
	 document.forms[0].action="switch.do?prefix=/works&page=/workDetails.do&mode=viewReport";
		document.forms[0].submit();
	
}


 function quickSearch(){

	 if(document.forms[0].elements['searchString'].value==""){
		 alert("Please Enter Work Name:");
		 return;
	 }
	 if(document.forms[0].elements['searchString'].value.length<4){
		 alert("Please Enter 4 Digit String");
		 return;
	 }
	 	document.forms[0].action="switch.do?prefix=/works&page=/workDetails.do&mode=quickSearch";
		document.forms[0].submit();
	 
 }

function getProgWorks(){
	document.forms[0].action="switch.do?prefix=/works&page=/workDetails.do&mode=getSchemeWorks";
	document.forms[0].submit();
	
}

function getSchemeWorks(){
	document.forms[0].action="switch.do?prefix=/works&page=/workDetails.do&mode=getSchemeWorks";
	document.forms[0].submit();
	
}




</script>
</head>

<body onload="disableCircle();">
<html:form action="/workDetails.do">

<table width="50%">
<tr><td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Work Details" />
	<jsp:param name="TWidth" value="680" />
</jsp:include>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="51%" border=1 style="border-collapse:collapse;" >
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Quick Search</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody >
		<tr class="textborder">	

	<td class="textborder">Enter WorkName<span class="mandatory">*</span></td>
	<td>
	
	
	<html:text property="searchString" onkeydown="disableCircle();"></html:text>
	</td>
	<td>
	<input type="button"  onclick="javascript:quickSearch();" value="Search" class=btext >
	</td>
	</tr>
	</tbody>
	</table>
	</label>
	</fieldset>
	</td>
	</tr>
	
	<tr>
		<td class="bwborder" >
		<fieldset>
		<legend  ><B>Office Details</B></legend>
		<label>
		
			<table cellpadding="0" cellspacing="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
	<tbody class="formTBody">
		<tr class="textborder">	

	<td class="textborder">Circle<span class="mandatory">*</span></td>
	<td>
		<logic:equal name="RWS_USER" property="circleOfficeCode"  value="00" >
		<html:select property="circleOfficeCode" styleClass="combo"  >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="circles">
		<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>			  
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00" > 
		<html:text property="circleOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true"/>
		<html:hidden property="circleOfficeCode" name="RWS_USER" />
		</logic:notEqual>
	</td>

	


<logic:present name="schemes">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Schemes:</td>
						<td class="textborder"><html:select property="schemeCode"
							style="width:143px" styleClass="mycombo" onchange="getSchemeWorks()">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="schemes" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>
				
				
				
<logic:present name="programs">
						<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programs:</td>
						<td class="textborder"><html:select property="programCode"
							style="width:143px" styleClass="mycombo" onchange="getProgWorks()">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>

</tr>
<tr >

<logic:present name="works">
						<td class="textborder">Works:</td>
						<td class="textborder" colspan="6"><html:select property="workId"
							style="width:543px" styleClass="mycombo">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="works" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present>
</tr><tr >
<td ></td><td ></td><td ></td><td ></td><td ></td>
	<td>
	<input type="button"  onclick="javascript:getDetails();" value="View Details" class=btext id="savebutton">
	</td>
	</table>
	</label>
	</fieldset>
</td>
</tr>




</table>


<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="680"/>
</jsp:include>
</html:form>
</body>
<br>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>