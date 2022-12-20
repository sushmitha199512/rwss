<%@ include file="/commons/rws_header1.jsp"%>
<script language="JavaScript">
function init()
{
onblur="self.focus()";
if(sourceForm.waterQuality.value == "")
{
document.getElementById('contaminationDetails').style.display='none';
document.getElementById('otherContaminationDetails').style.display='none';
}
if(document.forms[0].habCode.value=="")
	document.forms[0].sourceCode.value="";
}

function findTotal()
{
	if(document.forms[0].distFromSource.value)
	{
		document.getElementById('aws').style.display='block';
	}
	else
	{
		document.getElementById('aws').style.display='none';
	}
}
function panchayatChanged()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=villages";
sourceForm.submit();
}
function villageChanged()
{
document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=habitations";
sourceForm.submit();
}
function mandalChanged()
{

document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=panchayats";
sourceForm.submit();
}
function habitationChanged()
{

document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=setSourceCode";
sourceForm.submit();
}

function viewFunc()
{
var sourceTypeCode=document.forms[0].sourceTypeCode.value;
var assetTypeCode="<%= (String)request.getParameter("assetTypeCode")%>";
var assetCode="<%= (String)request.getParameter("assetCode")%>";
var pumpCode="<%= (String)request.getParameter("pumpCode")%>";
var habCode="<%= (String)request.getParameter("habCode")%>";
document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=view&sourceTypeCode="+sourceTypeCode+"&assetTypeCode="+assetTypeCode+"&assetCode="+assetCode+"&pumpCode="+pumpCode;
sourceForm.submit();
}
function saveFunc()
{
var stcode = '<%=request.getParameter("sourceTypeCode")%>';
var habCode=document.forms[0].habCode.value;
var yeild = document.forms[0].yield.value;
	var cond = false;
if(document.forms[0].distFromSource.value!="")
{
	for (var i=0; i<document.forms[0].AltWaterSourceType.length; i++) {
       if (document.forms[0].AltWaterSourceType[i].checked)
        cond = true;
     }
}
else
{
	cond = true;
}
if(document.forms[0].subSourceTypeCode.value=="")
{
	alert("Please select Sub Source Type");
}
else if(document.forms[0].habCode.value=="")
{
	alert("Please select Habitation");
}
else if(stcode=='1' && document.forms[0].location.value=="")
{
	alert("Please Enter Location");
	document.forms[0].location.focus();
}
else if(stcode=='2' && document.forms[0].tappingPoint.value=="")
{
	alert("Please Enter Location");
	document.forms[0].tappingPoint.focus();
}
else if(document.forms[0].presentCondition.value=="")
{
	alert("Please Enter Source Condition");
	document.forms[0].presentCondition.focus();
}
else if(yeild=="")
{
	alert("Please Enter Yield");
	document.forms[0].yield.focus();
}
else if(stcode=='1' && document.forms[0].sourceDepth.value=="")
{
	alert("Please Enter Source Depth");
	document.forms[0].sourceDepth.focus();
}
else if(!cond)
{
    alert("Select Reason for Alternative Water Source");
}
else
{
document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=Save&habCode="+habCode;
sourceForm.submit();
}
}
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=data";
	document.forms[0].submit();
}
function enableFields()
{
	if(sourceForm.waterQuality.value == "NSS")
	{
	document.getElementById('contaminationDetails').style.display='block';
	document.getElementById('otherContaminationDetails').style.display='block';
	}
	else
	{
	document.getElementById('contaminationDetails').style.display='none';
	document.getElementById('otherContaminationDetails').style.display='none';
	}
	/*if(sourceForm.waterQuality.value == "NSS")
	{
	
	document.getElementById('conti').style.display='block'
		}
	else
	{alert("sadiq");
		document.getElementById('conti').style.display='none'
		alert(document.getElementById('contitype').style.display)
		}*/
	
}
function getContam(that)
{	
	/*
	var optype = that.value;
	document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=contidata&opType="+optype;
	document.forms[0].submit();
	if(sourceForm.waterQuality.value == "NSS")
		document.getElementById('conti').style.display='block'
	else
		document.getElementById('conti').style.display='none'
	*/
	
}
/*
function showAssets(status)
{
	var message="";
	
	if(sourceForm.district.value=="")
	  message="District is required\n";
	if(sourceForm.mandal.value=="")
	  message=message+ "Mandal is required\n";
	//if(sourceForm.pcode.value=="")
	  //message=message+ "Panchayat is required\n";
	if(sourceForm.vcode.value=="")
	  message=message+  "Village is required\n";
	if(sourceForm.habCode.value=="")
	  message=message+ "Habitation is required\n";
	 if(message=="")
	 {
		 url = "switch.do?prefix=/masters&page=/Source.do&mode=asset&habCode="+sourceForm.habCode.value+"&status="+status+ "&district="+sourceForm.district.value + "&mandal="+ sourceForm.mandal.value + "&pcode="+sourceForm.pcode.value+"&vcode="+sourceForm.vcode.value;
	   //alert(url);
	   window.open(url,"","width=600,height=450,left=170,top=100,scrollbars=1");
	 }  
	 else
	 {
	 alert(message); 
	 } 
}
*/
function fnPickHabitations(index)
{
	var	newWindow;
	var habCode="<%=session.getAttribute("habCode")%>";
	var district = document.getElementById("district").value;
	var mandal = document.getElementById("mandal").value;
	var source=document.getElementById("sourceCode").value;
	var message="";
	if(district=="")
	 message=message+"District is required\n";
	if(mandal=="")
	  	 message=message+"mandal is required";
	 if(message!="")
	 {
	  alert(message) 
	 }	 
	 else{ 
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
 	 var url = "switch.do?prefix=/masters&page=/Source.do&mode=pickhab"
			+ "&district="+district+"&mandal="+mandal+"&assetCompTypeCode=01";
     var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes,status=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
   }	 
}
</script>
<body onload="init();findTotal()">
	<%@ include file="/commons/rws_header2.jsp"%>
	<html:form action="Source.do">
		<table cellpadding="0" cellspacing="0">
			<thead>
				<tr>
					<%
						if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
					%>
					<td><jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName"
								value="Sub Surface Source - Scheme Source Entry Form" />
							<jsp:param name="TWidth" value="100%" />
						</jsp:include></td>
					<%
						} else if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("2")) {
					%>
					<td><jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName"
								value="Surface Source - Scheme Source Entry Form" />
							<jsp:param name="TWidth" value="100%" />
						</jsp:include></td>
					<%
						}
					%>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td><jsp:include page="/commons/TableFotter.jsp">
							<jsp:param name="TWidth" value="100%" />
						</jsp:include></td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td>
						<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD"
							rules="none" style="border-collapse: collapse">
							<tr>
								<td>
									<fieldset>
										<legend>Habitation Details</legend>
										<label>
											<table border=0 width="100%" align=center>
												<tbody class="formTBody">
													<tr>
														<td width="200"><html:hidden property="assetTypeCode" />
															<bean:message key="app.district" /><span
															class="mandatory">*</span></td>
														<td><html:select property="district"
																style="width:140px" onchange="javascript:getData()"
																styleClass="mycombo">
																<html:option value="">
																	<bean:message key="app.pleaseSelect" />
																</html:option>
																<logic:notEmpty name="dists">
																	<html:options collection="dists" name="rwsLocationBean"
																		property="districtCode" labelProperty="districtName" />
																</logic:notEmpty>
															</html:select></td>
														<td width="210"><bean:message key="app.mandal" /><span
															class="mandatory">*</span></td>
														<td width="150"><html:select property="mandal"
																styleClass="mycombo" style="width:150px"
																onchange="javascript:mandalChanged()">
																<html:option value="">SELECT...</html:option>
																<html:options collection="mandals"
																	name="rwsLocationBean" property="mandalCode"
																	labelProperty="mandalName" />
															</html:select></td>
													</tr>
													<tr>
														<td><bean:message key="app.panchayat" /><span
															class="mandatory">*</span></td>
														<td><html:select property="pcode"
																styleClass="mycombo" style="width:150px"
																onchange="javascript:panchayatChanged()">
																<html:option value="">SELECT...</html:option>
																<html:options collection="panchyats"
																	name="rwsLocationBean" property="panchayatCode"
																	labelProperty="panchayatName" />
															</html:select></td>
														<td><bean:message key="app.village" /><span
															class="mandatory">*</span></td>
														<td><html:select property="vcode"
																styleClass="mycombo" style="width:150px"
																onchange="javascript:villageChanged()">
																<html:option value="">SELECT...</html:option>
																<html:options collection="villages"
																	name="rwsLocationBean" property="villageCode"
																	labelProperty="villageName" />
															</html:select></td>
													</tr>
													<tr>
														<td><bean:message key="app.habCode" /><span
															class="mandatory">*</span></td>
														<td colspan=3><html:select property="habCode"
																styleClass="mycombo" style="width:250px"
																onchange="habitationChanged()">
																<html:option value="">SELECT...</html:option>
																<html:options collection="prhabs" name="rwsLocationBean"
																	property="habCode" labelProperty="habName" />
															</html:select></td>
													</tr>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td>
									<fieldset>
										<legend>Source Details</legend>
										<label>
											<table border=0 width="100%" cellpadding="0" cellspacing="0">
												<tbody class="formTBody">
													<tr>
														<td>Source Type<span class="mandatory">*</span></td>
														<!-- <td>
					<html:select property="sourceTypeCode" styleClass="combo" onchange="javascript:getData()">
						<html:option value="">SELECT...</html:option>
						<html:options collection="sourceTypeCodes" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</html:select>
				</td>-->
														<%
															if (((String) request.getParameter("sourceTypeCode")).equals("1")) {
														%>
														<td><input type="text" style="width: 150px"
															value="SUBSURFACE SOURCE" styleClass="mytext"
															readonly="true" /> <html:hidden
																property="sourceTypeCode" value="1" /></td>
														<%
															} else {
														%>
														<td><input type="text" style="width: 150px"
															value="SURFACE SOURCE" styleClass="mytext"
															readonly="true" /> <html:hidden
																property="sourceTypeCode" value="2" /></td>
														<%
															}
														%>
														<td>Sub Source Type<span class="mandatory">*</span></td>
														<!-- <td>
					<html:select property="subSourceTypeCode" styleClass="combo"  onchange="javascript:getData()" >
						<html:option value="">SELECT...</html:option>
						<html:options collection="subSourceTypeCodes" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</html:select>
				</td>-->
														<%
															if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
														%>
														<td><html:select property="subSourceTypeCode"
																styleClass="combo">
																<!--  onchange="javascript:getData()"  -->
																<html:option value="">SELECT...</html:option>
																<html:option value="1">BORE WELL</html:option>
																<html:option value="3">INFILTRATON WELL</html:option>
																<html:option value="2">FILTER POINT</html:option>
																<html:option value="4">OPEN WELL</html:option>

															</html:select></td>
														<%
															} else {
														%>
														<td><html:select property="subSourceTypeCode"
																styleClass="combo">
																<!--  onchange="javascript:getData()"  -->
																<html:option value="">SELECT...</html:option>
																<html:option value="1">CANAL</html:option>
																<html:option value="2">RIVER</html:option>
																<html:option value="4">SPRINGS</html:option>
																<html:option value="5">RESERVOIR</html:option>
																<!-- 						<html:option value="4">INFILTRATION WELL</html:option> -->
															</html:select></td>
														<%
															}
															if (((String) request.getParameter("subSourceTypeCode")) != null
																		&& ((String) request.getParameter("subSourceTypeCode")).equalsIgnoreCase("1")) {
														%>
														<html:hidden property="type" value="" />
														<!--
				<tr><td>Bore Type</td>
					<td>
					<html:select property="type" styleClass="combo"   >
						<html:option value="">SELECT...</html:option>
						<html:option value="DTH">DTH</html:option>
						<html:option value="ROTARY">ROTARY</html:option>
						<html:option value="OTHERS">OTHERS</html:option>
					</html:select>
					</td>
				</tr> 
				 -->
														<%
															}
														%>
													</tr>
													<tr>
														<td><bean:message key="app.sourceCode" /><span
															class="mandatory">*</span></td>
														<td><html:text property="sourceCode"
																style="width:150px"
																value="<%=(String) request.getAttribute(\"scode\")%>"
																styleClass="mytext" readonly="true" /></td>
														<%
															if (!((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
														%>
														<td>Source Name<span class="mandatory">*</span></td>
														<td><html:text property="sourceName"
																value="<%=(String) request.getAttribute(\"sourceName\")%>"
																styleClass="thin-text-box" style="width:135"
																maxlength="25" onkeypress="upperOnly()" /></td>
														<%
															}
														%>
													</tr>
													<%
														if (((String) request.getParameter("sourceTypeCode")) != null
																	&& ((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("2")) {
													%>
													<tr>
														<td>Tapping Point(Location)<span class="mandatory">*</span>
														</td>
														<td><html:text property="tappingPoint"
																styleClass="thin-text-box" style="width:135"
																maxlength="30" onkeypress="upperOnly()" /></td>
														<%
															}
														%>
														<%
															if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
														%>
														<td><bean:message key="app.location" /><span
															class="mandatory">*</span></td>
														<td><html:text property="location"
																styleClass="thin-text-box" style="width:135"
																maxlength="30" onkeypress="upperOnly()" /></td>
														<%
															}
														%>
														<html:hidden property="noOfHab" />
														<html:hidden property="popbenefited" />
														<!-- 
				<td>
					<bean:message key="app.noOfHab" /><span class="mandatory">*</span>
				</td>
				<td>
					<html:text property="noOfHab" style="width:30px" 
					styleClass="thin-text-box" maxlength="2" 
					readonly="true"/>
					<html:button property="addHab" value="..." styleClass="btext" title="Click Here"
								 onclick="javascript: fnPickHabitations()" />
				</td>
			</tr>
			<tr>
				<td>
					<bean:message key="app.popbenefited" /><span class="mandatory">*</span>
				</td>
				<td>
					<html:text property="popbenefited" maxlength="5" 
						styleClass="thin-text-box" style="width:50px"
						onkeypress="return numeralsOnly(event)" />
				</td>
				
				 -->
														<!-- <td>
					<bean:message key="app.seasonal" /><span class="mandatory">*</span>
				</td>
				<td>
					<html:select property="seasonal" styleClass="combo">
						<html:option value="">SELECT...</html:option>
						<html:option value="Y">YES</html:option>
						<html:option value="N">NO</html:option>
					</html:select>
				</td> -->
														<td>
															Source Condition<span class="mandatory">*</span>
														</td>
														<%
															if (((String) request.getParameter("subSourceTypeCode")) != null
																		&& ((String) request.getParameter("subSourceTypeCode")).equalsIgnoreCase("1")) {
														%>
														<td><html:select property="presentCondition"
																styleClass="combo">
																<html:option value="">SELECT...</html:option>
																<html:option value="Yielding uniformly round the year">Yielding uniformly round the year</html:option>
																<html:option value="Seasonal">Seasonal</html:option>
																<html:option value="Silted up">Silted up</html:option>
																<html:option value="Dried up">Dried up</html:option>
															</html:select></td>
														<%
															} else {
														%>
														<td><html:select property="presentCondition"
																styleClass="combo">
																<html:option value="">SELECT...</html:option>
																<html:option value="Yielding uniformly round the year">Yielding uniformly round the year</html:option>
																<html:option value="Seasonal">Seasonal</html:option>
															</html:select></td>
														<%
															}
														%>
													</tr>
													<tr>
														<td>Static Water Level from Ground (Avg)</td>
														<td><html:text property="staticWaterLevel"
																style="width:60px" styleClass="thin-text-box"
																maxlength="4" onkeypress="return numeralsOnly(event)" />&nbsp;(In
															Mts.)</td>

														<html:hidden property="summerWaterLevel" />
														<!-- <td>Summer Water Level</td>
				<td>
					<html:text property="summerWaterLevel" style="width:60px" 
						styleClass="thin-text-box" maxlength="4"
						onkeypress="return numeralsOnly(event)" />&nbsp;(Mts)
				</td>
				 -->
														<td>Yield<span class="mandatory">*</span></td>
														<td><html:text property="yield" style="width:90px"
																styleClass="thin-text-box" maxlength="5"
																onkeypress="return upperOnly()" />&nbsp;(lpm)</td>
													</tr>
													<tr>
														<%
															if (((String) session.getAttribute("subSourceTypeCode")) != null
																		&& ((String) session.getAttribute("subSourceTypeCode")).equals("1")) {
														%>
														<html:hidden property="sourceDiameter" />
														<!-- <tr>	
				<td>
					<bean:message key="app.sourceDiameter" /><span class="mandatory">*</span>
				</td>
				<td>
					<html:text property="sourceDiameter" style="width:60px" 
						styleClass="thin-text-box" 
						onkeyup="extractNumber2(this,7,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" />
				</td> -->
														<td><bean:message key="app.sourceDepth" /><span
															class="mandatory">*</span></td>
														<td><html:text property="sourceDepth"
																style="width:60px" styleClass="thin-text-box"
																onkeyup="extractNumber2(this,7,2,false);"
																onkeypress="return blockNonNumbers(this, event, true, false);" />
														</td>
														<%
															}
														%>
														<td width="210">Water Quality</td>
														<td width="150"><html:select property="waterQuality"
																styleClass="combo" onchange="enableFields()">
																<html:option value="">SELECT...</html:option>
																<html:option value="SS">SAFE SOURCE</html:option>
																<html:option value="NSS">NSS</html:option>
															</html:select></td>
													</tr>

													<tr>
														<td width="200">Alternative Water Source</td>
														<td width="150"><html:text property="distFromSource"
																style="width:60px" styleClass="thin-text-box"
																maxlength="9"
																onkeypress="extractNumber2(this,7,1,false);"
																onkeyup="findTotal();" />&nbsp;(kms)</td>

														<td colspan="2">
															<div id="aws" style="display: none">
																<input type="radio" name="AltWaterSourceType" value="1"><font
																	size="2" face="verdana"><b>&nbsp;Sub-Surface
																		Source</b></font> <input type="radio" name="AltWaterSourceType"
																	value="2"><font size="2" face="verdana"><b>&nbsp;Surface
																		Source</b></font>
															</div>
														</td>

													</tr>
													<tr>
														<td width="100">Latitude-N</td>
														<td><nested:text property="latitude"
																style="width:80px" styleClass="thin-text-box"
																maxlength="10" onkeypress="decimalsOnly()" /></td>
														<td width="100">Longitude-E</td>
														<td><nested:text property="longitude"
																style="width:80px" styleClass="thin-text-box"
																maxlength="10" onkeypress="decimalsOnly()" /></td>
													</tr>
													<tr>
														<td width="100">Elevation</td>
														<td><nested:text property="elevation"
																style="width:80px" styleClass="thin-text-box"
																maxlength="10" onkeypress="decimalsOnly()" /></td>
														<td width="100">Waypoint</td>
														<td><nested:text property="waypoint"
																style="width:80px" styleClass="thin-text-box"
																maxlength="4" onkeypress="decimalsOnly()" /></td>
													</tr>
													<%
														if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("2")) {
													%>
													<tr>
														<td width="150">Type of Treatment</td>
														<td><html:select property="typeofTreatment"
																styleClass="combo" style="width:80px">
																<html:option value="">SELECT...</html:option>
																<html:option value="Rapid Sand Filters">Rapid Sand Filters</html:option>
																<html:option value="Slow Sand Filters">Slow Sand Filters</html:option>
																<html:option value="RO Plants">RO Plants</html:option>
																<html:option value="Micro Filters">Micro Filters</html:option>
																<html:option value="Ultra Filters">Ultra Filters</html:option>
																<html:option value="UV Plant">UV Plant</html:option>
															</html:select></td>
														<td width="120">Plant Capacity (units MLD)</td>
														<td><nested:text property="plantCapacity"
																style="width:80px" styleClass="thin-text-box" /></td>
													</tr>
													<%
														}
													%>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td id="#1">
									<!--  <fieldset >
			 <legend>Contamination Details</legend> 
			<label>
			
			<table  bordercolor= "#000000" border="1" style="border-collapse:collapse;" width="30%" align=left >
			<thead class="gridHeader">
			<tr>
			  <td class="bwborder">
				    <input type="radio" name="opType"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="FLOURIDE" /><font size="1" face="verdana"><b>&nbsp;Flouride</b></font> &nbsp;&nbsp;
 				    <input type="radio" name="opType"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="BRAKISH" /><font size="1" face="verdana"><b>&nbsp;Brakish</b></font> 
				    <input type="radio" name="opType"  style="width:12px;height:13px"  styleClass="mytext" onclick="javascript:getContam(this)" value="IRON" /><font size="1" face="verdana"><b>&nbsp;Iron</b></font> 				        
		        </td> 
			</tr>
			
			</table>
			 -->
								</td>
							</tr>
							<tr>
								<td id="contaminationDetails">
									<fieldset>
										<legend>Contamination Details</legend>
										<label>
											<table bordercolor="#000000" border="1"
												style="border-collapse: collapse;" width="60%" align=left>
												<thead class="gridHeader">
													<tr>
														<td class="label" width="300">Contamination Type</td>
														<td class="label" width="300">Flouride</td>
														<td class="label" width="300">Brakish</td>
														<td class="label" width="300">Iron</td>
													</tr>
												</thead>
												<tbody bgcolor="#FFFFFF">
													<tr>
														<td class="gridHeader" align="left">PPM</td>
														<td><html:text property="flouride"
																styleClass="gridText"
																onkeyup="extractNumber2(this,5,2,false)"
																onkeypress="return blockNonNumbers(this, event, true, false)" />
														</td>
														<td><html:text property="brakish"
																styleClass="gridText"
																onkeyup="extractNumber2(this,6,2,false)"
																onkeypress="return blockNonNumbers(this, event, true, false)" />
														</td>
														<td><html:text property="iron" styleClass="gridText"
																onkeyup="extractNumber2(this,5,2,false)"
																onkeypress="return blockNonNumbers(this, event, true, false)" />
														</td>
													</tr>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<tr>
								<td id="otherContaminationDetails">
									<fieldset>
										<legend>If Any Other Contamination, Please Specify</legend>
										<label>
											<table bordercolor="#000000" border="1"
												style="border-collapse: collapse;" width="60%" align=left>
												<!-- <tr>
			<td colspan="2" class="gridHeader"><font color="black">If Any Other Contaminations Please Specify</font></td>
			</tr> -->
												<tr>
													<td class="gridHeader" width="50%">Contamination Type</td>
													<td width="50%"><html:text property="othersType"
															maxlength="10" styleClass="gridText"
															onkeypress="return upperOnly(event)" /></td>
												</tr>
												<tbody bgcolor="#FFFFFF">
													<tr>
														<td class="gridHeader" align="left">PPM</td>
														<td><html:text property="others"
																styleClass="gridText"
																onkeyup="extractNumber2(this,6,2,false)"
																onkeypress="return blockNonNumbers(this, event, true, false)" />
														</td>
													</tr>
												</tbody>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<tr>
								<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
								<html:hidden property="token" styleClass="mytext"
									value="${sessionScope.csrfToken}" />
								<td align="center"><html:button property="mode"
										title="Save the Fields" styleClass="btext" value="Save"
										onclick="saveFunc()" /> <html:reset
										title="Clear all the Fields" styleClass="btext" value="Reset" />
									<html:button property="mode" title="View the Fields"
										styleClass="btext" value="View" onclick="viewFunc()" /> <html:button
										property="mode" title="Close Form" styleClass="btext"
										value="Close" onclick="javascript:self.close()" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>

		<br>
		<logic:present name="checkAssets">
			<% int count=1; %>
			<nested:iterate id="SOURCEASSET_LIST" property="sourceAssets">
				<%count=count+1; %>
			</nested:iterate>

			<table width="580" cellspacing="0" cellpadding="2" border="1"
				bordercolor="#FFFFFF"
				style="border-collapse: collapse; display: block">
				<thead class="gridLabel">
					<tr bgcolor="#8A9FCD">
						<td colspan=2 align=left><b>Asset in Source</b></td>
					</tr>
					<tr bgcolor="#8A9FCD">
						<th colspan="2" align="left">Total No. of Assets:&nbsp;<%= (count-1)%>
						</th>
					</tr>
					<tr bgcolor="#8A9FCD">
					<tr>
						<td class="textborder" align=center>Asset Code</td>
						<td class="textborder" align=center>Asset Name</td>
					</tr>
				</thead>
				<tbody class="gridText">
					<% count=1; %>
					<nested:iterate id="SOURCEASSET_LIST" property="sourceAssets">
						<tr class="row<%=count%2%>">
							<%count=count+1; %>
							<td class=bwborder align=center><bean:write
									name="SOURCEASSET_LIST" property="assetCode" /></td>
							<td class=bwborder align=left><bean:write
									name="SOURCEASSET_LIST" property="assetName" /></td>
						</tr>
					</nested:iterate>
				</tbody>
			</table>
		</logic:present>
	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
