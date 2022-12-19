<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="habStatusForm"/>
<SCRIPT LANGUAGE="JavaScript">
<!--
function enableFields()
{
	if(habStatusForm.coveredStatus.value=="NSS")
		document.getElementById('conti').style.display='block'
	else
		document.getElementById('conti').style.display='none'
}
function findTotal(pop)
{
	if(pop == "totPop")		habStatusForm.totPop.value=parseInt(habStatusForm.censusPop.value)+parseInt(habStatusForm.censusSc.value)+parseInt(habStatusForm.censusSt.value)
	else if(pop == "netPop")		habStatusForm.netPop.value=parseInt(habStatusForm.censusPop.value)+parseInt(habStatusForm.censusSc.value)+parseInt(habStatusForm.censusSt.value)+parseInt(habStatusForm.floatPop.value)
	else if(pop == "popCvrd")	habStatusForm.totPopCvrd.value=parseInt(habStatusForm.popCovered.value)+parseInt(habStatusForm.stCovered.value)+parseInt(habStatusForm.scCovered.value)
}

//-->
</SCRIPT><%@ include file="/commons/rws_header2.jsp" %>



<html:form action="HabStatus?mode=edit" onsubmit="return validateHabStatusForm(this)" >



<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" >
<tr>
<td>
<fieldset>
<legend><bean:message key="legend.rwsOffices"/></legend>
<label>
<table  border=0  width="100%"  >
<tr>
	<td class=mycborder nowrap>
	<FONT class=myfontclr>Circle<font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
		<html:text property="coc" style="width:100px" styleClass="mytext" readonly="true"/>
	</td>
	<td class=mycborder nowrap>
		<FONT class=myfontclr>Division</FONT></td>
	<td  class=mycborder >
		<html:text property="doc" style="width:100px" styleClass="mytext" readonly="true"/>
	</td>
	<td class=mycborder nowrap>
		<FONT class=myfontclr>Sub Division</FONT></td>
	<td  class=mycborder >
		<html:text property="sdoc" styleClass="mytext" style="width:100px" readonly="true"/>
	</td>
	<td class=mycborder nowrap >
	<FONT class=myfontclr><bean:message key="app.habCode" /></FONT></td>
	<td  class=mycborder >
	<html:text property="habCode" styleClass="mytext" style="width:123px" readonly="true"/>
	</td>
	</tr>
	</table>
	</label>
	</fieldset>
	<html:hidden property="dcode1" />
	<html:hidden property="mcode1" />
	<html:hidden property="pcode1" />
	<html:hidden property="vcode1" />
	<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
	<tr>
	<td valign="top">
	<fieldset>
	<legend>Census Population</legend>
	<label>
	
		<table border=0 width="100%" align=center>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.plainPop" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="censusPop"  styleClass="mytext" style="width:50px" tabindex="1"/></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.cnsYear" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="censusYear"  styleClass="mytext" style="width:50px" maxlength="4"  tabindex="5"/></td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.cnsSc" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="censusSc"  styleClass="mytext" style="width:50px" tabindex="2"/></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.floatPop" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="floatPop"  styleClass="mytext" style="width:50px" tabindex="6"/></td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.cnsSt" /></FONT></td>
		<td  class=mycborder>
		<html:text property="censusSt"  styleClass="mytext" style="width:50px" tabindex="3"/></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.floatReason" /></FONT>
		</td>
		<td class=mycborder>
			<html:select property="floatReason" styleClass="mycombo" 
							 style="width:70px">
				<html:option value="">SELECT...</html:option>
				<html:option value="TEMPLE">TEMPLE</html:option>
				<html:option value="MARKET">MARKET</html:option>
				<html:option value="OTHERS">OTHERS</html:option>
			</html:select>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.cnsPop" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="totPop"  styleClass="mytext" style="width:50px" readonly="true" onfocus="findTotal('totPop')" tabindex="4"/></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.netPop" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="netPop"  styleClass="mytext" style="width:50px" readonly="true" onfocus="findTotal('netPop')" tabindex="8"/></td>
		</tr>
		</table>	
		</label>
		</fieldset>
	</td>
	<td valign="top">
		<fieldset>
		<legend>Population Covered</legend>
		<label>
		<table border=0 width="100%" align=center>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.habYear" /></FONT>
		</td>
		<td  class=mycborder colspan=2>
		<html:text property="habYear"  styleClass="mytext" style="width:70px" tabindex="9"/>
		<a href="javascript: showCalendar(document.habStatusForm.habYear);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		</tr><tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.plainCvrd" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="popCovered"  styleClass="mytext" style="width:50px" tabindex="10"/></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.scCvrd" /></FONT>
		</td>
		<td  class=mycborder>
		<html:text property="scCovered"  styleClass="mytext" style="width:50px" tabindex="11"/></td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.stCvrd" /></FONT></td>
		<td  class=mycborder>
		<html:text property="stCovered"  styleClass="mytext" style="width:50px"tabindex="12" /></td>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.popCvrd" /></FONT>
		</td>
		<td class=mycborder>
			<html:text property="totPopCvrd"  styleClass="mytext" style="width:50px" readonly="true" onfocus="findTotal('popCvrd')" tabindex="13"/></td>
		</tr>
		<tr>
			<td class="textborder">&nbsp;</td>
			<td class="textborder"><input type="text" class="mytext" style="width:50px;visibility:hidden"></td>
			<td class="textborder">&nbsp;</td>
			<td class="textborder">&nbsp;</td>
		</tr>
		</table>
		</label>
		</fieldset>
	
	</td></tr>
	</table>
	
		<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  border="1" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
		<tr bgcolor="#8A9FCD">
		<td colspan=6 class=bwborder><font color="#ffffff">Water Supply-Drinking Purpose</font></td>
		</tr>
		<tr>
			<td class=clrborder align=center>Scheme</td>
			<td class=clrborder align=center>Nos.</td>
			<td class=clrborder align=center>Plain Pop<br>Covered</td>
			<td class=clrborder align=center>SC Pop<br>Covered</td>
			<td class=clrborder align=center>ST Pop<br>Covered</td>
			<td class=clrborder align=center>Total Pop<br>Covered</td>
		</tr>
		<nested:iterate id="HABWATERSUPPLY_LIST" property="habWaterSupply">
		<tr>
			<td class=mycborder align=center>
				<nested:text property="component" name="HABWATERSUPPLY_LIST" 
						style="width:200px" readonly="true"
						styleClass="mytbltext" indexed="true" />
			</td>
			<td class=mycborder>
				<nested:text property="totalNo" name="HABWATERSUPPLY_LIST" 
						styleClass="mytbltext" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)"/>
			</td>
			<td class=mycborder>
				<nested:text property="plainPop" name="HABWATERSUPPLY_LIST" 
						styleClass="mytbltext" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)"/>
			</td>
			<td class=mycborder>
				<nested:text property="scPop" name="HABWATERSUPPLY_LIST" 
						styleClass="mytbltext" style="width:100px" indexed="true" 
						onkeypress="return numeralsOnly(event)"/>
			</td>
			<td class=mycborder>
				<nested:text property="stPop" name="HABWATERSUPPLY_LIST" 
					styleClass="mytbltext" style="width:100px" indexed="true" 
					onkeypress="return numeralsOnly(event)"/>
			</td>
			<td class=mycborder>
				<nested:text property="totalPop" name="HABWATERSUPPLY_LIST" indexed="true"
						styleClass="mytbltext" style="width:100px" readonly="true"/>
			</td>
		</tr>
		</nested:iterate>
		</table>
	<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
	<tr>
	<td>
	<div style="position:relative;overflow-y:auto;left:0;height:108;width:100;top:0;">
	<table   bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
	<tr bgcolor="#8A9FCD"><td class=bwborder colspan=3><font color="#ffffff">Public Institutions Details</font></td></tr>
	<tr>
		<td  class=clrborder align=center>Code</td>
		<td  class=clrborder align=center>No.</td>
		<td  class=clrborder align=center>Covered with water</td>
	</tr>
	<nested:iterate id="HABINST_LIST" property="habInsts">
	<tr>
		<td  class=mycborder align=center>
		<nested:hidden property="instituteCode" name="HABINST_LIST"  indexed="true"  />
		<nested:text property="instituteName" name="HABINST_LIST" style="width:100px" styleClass="mytbltext" indexed="true" readonly="true" />
		</td>
		<td  class=mycborder >
		<nested:text property="instituteNo" name="HABINST_LIST" styleClass="mytbltext" style="width:100px" indexed="true"/></td>
		<td  class=mycborder >
		<nested:text property="instituteCovered" name="HABINST_LIST" styleClass="mytbltext" style="width:100px" indexed="true" /></td>
	</tr>
	</nested:iterate>
	</table>
	</div>
	</td>
	<td>
	<fieldset>
		<legend>Others</legend>
		<label>
		<table  border=0  width="100%"  align=center  >
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.totWS" /></FONT>
		</td>
		<td  class=myfontclr1>
		<html:text property="totalWaterSupply"  styleClass="mytext" style="width:60px"/>&nbsp;lts
		</td>
		<td  class=mycborder >
		<FONT class=myfontclr><bean:message key="app.existWatSup" /></FONT>
		</td>
		<td  class=myfontclr1>
		<html:text property="existWaterLevel"  styleClass="mytext" style="width:60px" />&nbsp;lpcd</td>
		</tr>
		<tr>
		<td  class=mycborder ><FONT class=myfontclr>Distance From<br>Nearest Ground<br>Water Source</FONT></td>
		<td  class=myfontclr1>
		<html:text property="nearWaterGroundSource"  styleClass="mytext" style="width:60px"/>&nbsp;kms
		<td  class=mycborder ><FONT class=myfontclr>Distance From<br>Nearest Surface<br>Water Source</FONT></td>
		<td  class=myfontclr1>
		<html:text property="nearWaterSource"  styleClass="mytext" style="width:60px"/>&nbsp;kms
		</td>
		</tr>
		<tr>
		<td  class=mycborder>
		<FONT class=myfontclr><bean:message key="app.cvrdStatus" /></FONT>
		</td>
		<td  class=mycborder>
		<html:select property="coveredStatus"  styleClass="mycombo" style="width:70px" >
		<html:option value="">Select...</html:option>
		<html:option value="FC">FC</html:option>
		<html:option value="NC">NC</html:option>
		<html:option value="PC1">PC1</html:option>
		<html:option value="PC2">PC2</html:option>
		<html:option value="PC3">PC3</html:option>
		<html:option value="PC4">PC4</html:option>
		<html:option value="NSS">NSS</html:option>
		</html:select>
		</td>
		<td  class=mycborder><FONT class=myfontclr><bean:message key="app.remarks" /></td>
		<td><html:textarea property="remarks" style="width:100px" /></td>
		</tr>
		<tr>
			<td class="textborder">Quality Affected</td>
			<td class="textborder">
				<html:select property="qualityAffected" styleClass="mycombo" 
							 style="width:70px" onchange="enableFields()">
					<html:option value="">SELECT...</html:option>
					<html:option value="Y">YES</html:option>
					<html:option value="N">NO</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
		<td colspan=4>
		<logic:equal name="habStatusForm" property="qualityAffected" value="Y">
			<div id="conti" style="position:relative;overflow-y:auto;left:0;height:54;width:400;top:0;display:block">
		</logic:equal>
		<logic:notEqual name="habStatusForm" property="qualityAffected" value="Y">
			<div id="conti" style="position:relative;overflow-y:auto;left:0;height:54;width:400;top:0;display:none">
		</logic:notEqual>

	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
	<tr bgcolor="#8A9FCD"><td class=bwborder colspan=2><font color="#ffffff">Contamination Details</font></td></tr>
	<tr>
		<td class=clrborder align=center>Contamination Type</td>
		<td class=clrborder align=center>Percentage</td>
	</tr>
	<nested:iterate id="HABCONTAMINATION_LIST" property="contaminations">
	<tr>
		<td  class="textborder" >
			<nested:text property="contType" name="HABCONTAMINATION_LIST" styleClass="mytbltext" indexed="true"/>
		</td>
		<td  class="textborder" >
			<nested:text property="percent" name="HABCONTAMINATION_LIST" styleClass="mytbltext" indexed="true" />
		</td>
	</tr>
	</nested:iterate>
	</table>
	</div>
	</td>
	</tr>
		</table>
		</label>
		</fieldset>
		</td></tr></table>

		<tr>
		<td  class=mycborder align=center>
		<html:submit title="Save the Fields" styleClass="btext" value="Save" onclick="return winView()" />
		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
		<html:hidden property="habCode" />
		</td>
		</tr>
	</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>

</html:form>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

