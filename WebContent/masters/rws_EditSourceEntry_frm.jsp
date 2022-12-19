<%@ include file="/commons/rws_header1.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
function init()
{
if(document.forms[0].waterQuality.value == "NSS")
	document.getElementById('contaminationDetails').style.display='block';
else
	document.getElementById('contaminationDetails').style.display='none';
if(document.forms[0].waterQuality.value == "NSS")
	document.getElementById('otherContaminationDetails').style.display='block';
else
	document.getElementById('otherContaminationDetails').style.display='none';
}

function check()
{
	if((document.forms[0].othersType.value!="" && document.forms[0].others.value!="") || (document.forms[0].othersType.value=="" && document.forms[0].others.value=="") )
	{
	return true;
	}
	else
	{
		if(document.forms[0].othersType.value!="" && document.forms[0].others.value=="")
		{
			alert("Percentage in Other Contamination cannot be empty");
		}
		else if(document.forms[0].othersType.value=="" && document.forms[0].others.value!="")
		{
			alert("Contamination Type in Other Contamination Cannot be empty");
		}
		return false;
	}
}
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=getsource";
	document.forms[0].submit();
}
function enableFields()
{
if(document.forms[0].waterQuality.value == "NSS")
	document.getElementById('contaminationDetails').style.display='block';
else
	document.getElementById('contaminationDetails').style.display='none';
	
if(document.forms[0].waterQuality.value == "NSS")
	document.getElementById('otherContaminationDetails').style.display='block';
else
	document.getElementById('otherContaminationDetails').style.display='none';
}

function fnPickHabitations()
{
    var	newWindow;
    var sourceCode='<%=request.getParameter("sourceCode")%>';
    var noOfHab='<%=request.getParameter("noOfHab")%>';
	 var width = 638;
	 var height = 332;
	 var left = parseInt((screen.availWidth/2)-(width/2));
	 var top = parseInt((screen.availHeight/2)-(height/2));
 	 var url = "switch.do?prefix=/masters&page=/Source.do&mode=disphab&noOfHab="+noOfHab
			   + "&sourceCode="+sourceCode;
	      var properties = "width=400,height=260,left=470,top=20,toolbar=no,"
				   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				   + "resizable=yes";
	 if( !newWindow || newWindow.closed)
	 {
		newWindow = window.open(url, "", properties);
	 }
	 else
	 {
		newWindow.focus();
	 }
}

</SCRIPT><%@ include file="/commons/rws_header2.jsp"%>

<body onload="init()">
	<tr>
		<td width="100%" align="right"><a href="#1"
			onclick="javascript:history.back(1)">Back</a></td>
	</tr>
	<tr>
		<td width="80%"><html:form action="Source.do?mode=edit">
				<jsp:include page="/commons/TableHeader.jsp">
					<jsp:param name="TableName" value="Source Entry Form" />
					<jsp:param name="TWidth" value="720" />
				</jsp:include>
				<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols"
					border="1" style="border-collapse: collapse;" width="660">
					<tr>
						<td>
							<table border=0 width="745" align=center>
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
											value="SUBSURFACE SOURCE" styleClass="mytext" readonly="true" />
											<html:hidden property="sourceTypeCode" value="1" /></td>
										<%
											} else {
										%>
										<td><input type="text" style="width: 150px"
											value="SURFACE SOURCE" styleClass="mytext" readonly="true" />
											<html:hidden property="sourceTypeCode" value="2" /></td>
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
										<html:hidden property="subSourceTypeCode" />
										<%
											if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
										%>
										<td><html:select property="subSourceTypeCode"
												styleClass="combo" disabled="true">
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
												styleClass="combo" disabled="true">
												<!--  onchange="javascript:getData()"  -->
												<html:option value="">SELECT...</html:option>
												<html:option value="1">CANAL</html:option>
												<html:option value="2">RIVER</html:option>
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
										<td><html:text property="sourceCode" style="width:150px"
												value="<%=(String) request.getAttribute(\"scode\")%>"
												styleClass="mytext" readonly="true" /></td>
										<%
											if (!((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
										%>
										<td>Source Name<span class="mandatory">*</span></td>
										<td><html:text property="sourceName"
												value="<%=(String) request.getAttribute(\"sourceName\")%>"
												styleClass="thin-text-box" style="width:135" maxlength="25"
												onkeypress="upperOnly()" /></td>
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
												styleClass="thin-text-box" style="width:135" maxlength="30"
												onkeypress="upperOnly()" /></td>

										<%
											}
											if (((String) request.getParameter("sourceTypeCode")).equalsIgnoreCase("1")) {
										%>
										<td><bean:message key="app.location" /><span
											class="mandatory">*</span></td>
										<td><html:text property="location"
												styleClass="thin-text-box" style="width:135" maxlength="30"
												onkeypress="upperOnly()" /></td>
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
											<!-- <bean:message key="app.presentCondition" /> --> Source
											Condition<span class="mandatory">*</span>
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
												style="width:60px" styleClass="thin-text-box" maxlength="4"
												onkeypress="return numeralsOnly(event)" />&nbsp;(In Mts.)</td>

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
										<td><html:text property="sourceDepth" style="width:60px"
												styleClass="thin-text-box"
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
												style="width:60px" styleClass="thin-text-box" maxlength="9"
												onkeypress="extractNumber2(this,7,1,false);" />&nbsp;(kms)
										</td>

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
										<!-- added by swapna on 19-01-2012 -->
										<td width="100">Latitude-N</td>
										<td><nested:text property="latitude"
												style="width:80px" styleClass="thin-text-box" maxlength="10"
												onkeypress="decimalsOnly()" /></td>
										<td width="100">Longitude-E</td>
										<td><nested:text property="longitude"
												style="width:80px" styleClass="thin-text-box" maxlength="10"
												onkeypress="decimalsOnly()" /></td>
									</tr>
									<tr>
										<td width="100">Elevation</td>
										<td><nested:text property="elevation" style="width:80px"
												styleClass="thin-text-box" maxlength="10"
												onkeypress="decimalsOnly()" /></td>
										<td width="100">Waypoint</td>
										<td><nested:text property="waypoint" style="width:80px"
												styleClass="thin-text-box" maxlength="4"
												onkeypress="decimalsOnly()" /></td>
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
							</table> </label>
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

					<!-- Contamination Details -->
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

												<!-- <td class="label">
					Flouride
				</td> -->
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
												<td><html:text property="others" styleClass="gridText"
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
					<%
						String csrfToken = "";
							nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
							csrfToken = valUtil.getCSRFCode();
							session.setAttribute("csrfToken", csrfToken);
					%>
					<html:hidden property="token" styleClass="mytext"
						value="${sessionScope.csrfToken}" />

					<tr>
						<td align="center"><html:submit property="mode"
								title="Save the Fields" styleClass="btext" value="Save"
								onclick="return check()" /> <html:reset
								title="Clear all the Fields" styleClass="btext" value="Reset" />
						</td>
					</tr>
					</tbody>
				</table>
				<jsp:include page="/commons/TableFotter.jsp">
					<jsp:param name="TWidth" value="720" />
				</jsp:include>

			</html:form> <!-- 
<table    width="500"   bgcolor="#8A9FCD">
<tr><td class=myfontclr><B><font color="#FFFFFF">Assets in Source</font></B></td>
</table>
<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="500" border=1 style="border-collapse:collapse" >
<tr >
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetCode" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><font color="#993366"><bean:message key="app.assetName" /></td>
</tr>


<logic:iterate id="assetsrclist" name="assetSrcs">
<tr align="left" >
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="assetsrclist" property="assetCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="assetsrclist" property="assetName" /></FONT>
</td>
</tr>
</logic:iterate>

</table>
 --></td>
	</tr>
	<!--  -->
	</td>
	</tr>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


