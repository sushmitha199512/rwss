<%@ include file="/commons/rws_header1.jsp" %>
<style>
#black
{
	text-decoration: underline;
	color: black;
}
</style>


<script language="JavaScript">
<!--
function fnGetComponentDetails(component)
{
	var typeOfAssetCode = "00";
	if(component == 'HAND PUMPS')
		typeOfAssetCode = "04";
	else
	if(component == 'PWS')
		typeOfAssetCode = "01";
	else		
	if(component == 'CPWS')
		typeOfAssetCode = "03";	
	else		
		typeOfAssetCode = "00";
	
	if(typeOfAssetCode == '00')
		alert("No details available.");
	else			
	{
		var habCode = document.getElementById("habCode").value;	
		var url = "switch.do?prefix=/masters&page=/ShowComponentDetails.do"
			+ "&typeOfAssetCode="+typeOfAssetCode+"&habCode="+habCode;
			
		var properties = "width=700,height=400,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   	   + "scrollbars=yes,copyhistory=no,resizable=yes";
		window.open(url,"", properties);
	}
}
function getHabDirData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/HabData.do";
	document.forms[0].submit();
}
function viewfun()
{
  var message="";
  if(habStatusForm.coc.value=="")
     message=message+"Circle is required\n";
  if(habStatusForm.doc.value=="")
     message=message+"Division is required\n";
  if(habStatusForm.sdoc.value=="")
     message=message+"Sub Division is required\n";
  if(habStatusForm.mandal.value=="")
     message=message+"Mandal is required\n";
  if(habStatusForm.pcode.value=="")
     message=message+"Panchayat is required\n";
  if(habStatusForm.vcode.value=="")
     message=message+"Village is required\n";

   if(message=="")
     return true;     
   else{
    alert(message);
    return false;
   } 
}
function enableFields()
{
	if(habStatusForm.qualityAffected.value == "Y")
			document.getElementById('conti').style.display='block'
	else
		document.getElementById('conti').style.display='none'
}

function fnCalculatePCPDTotal()
{
	var pcpdDrinking = parseFloat(habStatusForm.pcpdDrink.value);
	var pcpdOthers = parseFloat(habStatusForm.pcpdOthers.value);
	
	if(isNaN(pcpdDrinking))
		pcpdDrinking = 0;
	if(isNaN(pcpdOthers))
		pcpdOthers = 0;
	var pcpdTotal = parseFloat(pcpdDrinking) + parseFloat(pcpdOthers);
	habStatusForm.pcpdTotal.value = pcpdTotal.toFixed(2);
}

function findTotal(pop)
{
	if(pop == "totPop")	
	{
		var censusPop = parseInt(habStatusForm.censusPop.value);
		var censusSc = parseInt(habStatusForm.censusSc.value);
		var censusSt = parseInt(habStatusForm.censusSt.value);
		
		if(isNaN(censusPop))
			censusPop = 0;
		if(isNaN(censusSc))
			censusSc = 0;		
		if(isNaN(censusSt))
			censusSt = 0;
					
		habStatusForm.totPop.value = parseInt(censusPop) + parseInt(censusSc) 
								   + parseInt(censusSt); 
	}
	else 
	if(pop == "netPop")	
	{
		var censusPop = parseInt(habStatusForm.censusPop.value);
		var censusSc = parseInt(habStatusForm.censusSc.value);
		var censusSt = parseInt(habStatusForm.censusSt.value);
		var floatPop = parseInt(habStatusForm.floatPop.value)
		
		if(isNaN(censusPop))
			censusPop = 0;
		if(isNaN(censusSc))
			censusSc = 0;		
		if(isNaN(censusSt))
			censusSt = 0;
		if(isNaN(floatPop))
			floatPop = 0;	
					
		habStatusForm.netPop.value = parseInt(censusPop) + parseInt(censusSc) 
								   + parseInt(censusSt) + parseInt(floatPop); 
		
	}
	else 
	if(pop == "popCvrd")	
	{
		var popCovered = parseInt(habStatusForm.popCovered.value);
		var stCovered = parseInt(habStatusForm.stCovered.value);
		var scCovered = parseInt(habStatusForm.scCovered.value);

		if(isNaN(popCovered))
			popCovered = 0;
		if(isNaN(stCovered))
			stCovered = 0;
		if(isNaN(scCovered))
			scCovered = 0;	

		habStatusForm.totPopCvrd.value = parseInt(popCovered) + parseInt(stCovered) + parseInt(scCovered); 
	}
	else 
	if(pop == "levelOfWater")	
	{
		var totalWaterSupply = parseInt(habStatusForm.totalWaterSupply.value);
		var totPop = parseInt(habStatusForm.totPop.value);
		var levelOfWater = totalWaterSupply / totPop;
		
		habStatusForm.existWaterLevel.value = levelOfWater.toFixed(2);
	}
}
function getTotal(index)
{
	var plainPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].plainPop").value;
	var scPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].scPop").value;
	var stPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].stPop").value;
	document.getElementById("HABWATERSUPPLY_LIST["+index+"].totalPop").value = parseInt(plainPop)+parseInt(scPop)+parseInt(stPop);
	
	var plainPop = parseInt(habStatusForm.censusPop.value);
	var scPop = parseInt(habStatusForm.censusSc.value);
	var stPop = parseInt(habStatusForm.censusSt.value);
	
	if(isNaN(censusPop))
		censusPop = 0;
	if(isNaN(censusSc))
		censusSc = 0;		
	if(isNaN(censusSt))
		censusSt = 0;
		
}
var tot=0;
function getTotalWS(index)
{
	//var plainPop = document.getElementById("totalWaterSupply").value;
	
	var totPop = document.getElementById("HABWATERSUPPLY_LIST["+index+"].totalPop").value;
	tot=tot+parseInt(totPop);
	document.getElementById("totalWaterSupply").value=tot;

}

//-->
</script>
<html:javascript formName="habStatusForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="HabStatus.do?mode=Update"> 
<table align="center" cellpadding="0" cellspacing="0">
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Habitation Directory Entry Form" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="780" >
<tr>
<td class="mycborder">
<fieldset>
<legend>Office Details</legend>
<label>
<table  border=0  width="100%">
<tr>
<html:hidden property="dcode"/>
<html:hidden property="mandal"/>
<html:hidden property="pcode"/>
<html:hidden property="vcode"/>
<html:hidden property="coc"/>
<html:hidden property="doc"/>
<html:hidden property="sdoc"/>
<html:hidden property="habCode"/>
 
 

	<td class=textborder >Circle</td>
	<td class=textborder >
	<html:text property="con"  styleClass="mytext" readonly="true"/></td>
	<td class=textborder >Division</td>

	<td class=textborder >
	<html:text property="don" styleClass="mytext"  readonly="true"/></td>
	<td class=textborder >Subdivision</td>
	<td class=textborder >
	<html:text property="sdon"   styleClass="mytext" readonly="true"/>
	</td>
	</tr>
	</table>
	</label>
	</legend>
	</fieldset>
 </td>
 </tr>
<td class="textborder">
<fieldset>
<legend>Habitation Details</legend>
<label>
 <table  border=0  width="100%">
<tr>
    <TD class="textborder" nowrap><bean:message key="app.district" /></TD>
    <TD class=textborder>
	<html:text property="district" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.mandal" /></TD>
    <TD class=textborder>
	<html:text property="mandalName" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.panchayat" /></TD>
    <TD class=textborder>
	<html:text property="pname" styleClass="mytext"  readonly="true"/>
	</TD>
  </tr>
 
<tr>
    <TD class="textborder" nowrap><bean:message key="app.village" /></TD>
    <TD class=textborder>
	<html:text property="vname" styleClass="mytext"  readonly="true"/>
	</TD>
	
	<TD class="textborder" nowrap><bean:message key="app.habCode" /></TD>
    <TD class=textborder>
	<html:text property="habName" styleClass="mytext"  readonly="true"/>
	</TD>
  </tr>
</table>
</label>
</fieldset>
</td>

</tr>
<tr>
<td>
	<table>
	<tr>
	<td>	
		<fieldset>
		<legend>Census Population</legend>
		<label>
		<table border=0 width="100%" height="100%">
		<tr>
			<td class="textborder"><bean:message key="app.plainPop" /></td>
			<td class="textborder">
				<html:text property="censusPop" styleClass="mytext" 
						   style="width:50px" tabindex="1" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')"/>
			</td>
			<td class="textborder"><bean:message key="app.cnsYear" /></td>
			<td class="textborder">
				<html:text property="censusYear" styleClass="mytext" maxlength="4"
						   style="width:50px" onkeypress="return numeralsOnly(event)" tabindex="5"/>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsSc" /></td>
			<td class="textborder">
				<html:text property="censusSc" styleClass="mytext" 
						   style="width:50px" tabindex="2" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')"/>
			</td>
			<td class="textborder"><bean:message key="app.floatPop" /></td>
			<td class="textborder">
				<html:text property="floatPop" styleClass="mytext" 
						   style="width:50px" tabindex="6" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')"/>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsSt" /></td>
			<td class="textborder">
				<html:text property="censusSt" styleClass="mytext" 
						   style="width:50px" tabindex="3" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('netPop')"/>
			</td>
			<td class="textborder"><bean:message key="app.floatReason" /></td>
			<td class="textborder">
				<html:select property="floatReason" styleClass="mycombo" 
							 style="width:70px">
					<html:option value="">SELECT...</html:option>
					<html:option value="TEMPLE">TEMPLE</html:option>
					<html:option value="MARKET">MARKET</html:option>
					<html:option value="OTHERS">OTHERS</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsPop" /></td>
			<td class="textborder">
				<html:text property="totPop" styleClass="mytext" 
						   style="width:50px" readonly="true" tabindex="4" />
			</td>
			<td class="textborder"><bean:message key="app.netPop" /></td>
			<td class="textborder">
				<html:text property="netPop" styleClass="mytext" 
						   style="width:50px" readonly="true" 
						   onfocus="findTotal('netPop')" tabindex="8"/>
			</td>
		</tr>
		</table>
		</label>
		</fieldset>
	</td>
	<td valign="top">
	<fieldset>
	<legend>Population Covered</legend>
	<label>
		<table border=0 width="100%" height="100%">
			<tr>
				<td class="textborder"><bean:message key="app.habYear" /></td>
				<td class="textborder" colspan=2>
					<html:text property="habYear" styleClass="mytext" 
							   style="width:70px" tabindex="9"/>
					<a href="javascript: showCalendar(document.habStatusForm.habYear);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
				</td>
			</tr>
			<tr>
				<td class="textborder"><bean:message key="app.plainCvrd" /></td>
				<td class="textborder">
					<html:text property="popCovered" styleClass="mytext" 
							   style="width:50px" tabindex="10" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')" />
				</td>
				<td class="textborder"><bean:message key="app.scCvrd" /></td>
				<td class="textborder">
					<html:text property="scCovered" styleClass="mytext" 
							   style="width:50px" tabindex="11" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')" />
				</td>
			</tr>
			<tr>
				<td class="textborder"><bean:message key="app.stCvrd" /></td>
				<td class="textborder">
					<html:text property="stCovered" styleClass="mytext" 
							   style="width:50px" tabindex="12" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')" />
				</td>
				<td class="textborder"><bean:message key="app.popCvrd" /></td>
				<td class="textborder">
					<html:text property="totPopCvrd" styleClass="mytext" 
							   style="width:50px" readonly="true" tabindex="13"/>
				</td>
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
	</td>
	</tr>
</table>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend>Water Supply-Drinking Purpose-Existing Facilities</legend>
	<label>
	<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	<thead class="gridHeader">
	<tr bgcolor="#8A9FCD">
		<th rowspan="2"></th>
		<th colspan="5">Drinking Purpose</th>
		<th colspan="5">Other Purpose</th>
	</tr>
	<tr bgcolor="#8A9FCD">
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('SHALLOW HAND PUMPS')" id="black">Shallow Hand Pumps</a></th>
		<th rowspan="2">Cisterns</th>
		<th rowspan="2">GLSR</th>
		<th rowspan="2">OHSR</th>
		<th rowspan="2">Total</th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('HAND PUMPS')" id="black">Hand Pumps</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('OPEN WELLS')" id="black">Open Wells</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('PONDS')" id="black">Ponds</a></th>
		<th rowspan="2">Shallow Wells</th>
		<th rowspan="2">Total</th>
	</tr>
	</thead>
	<tr>
		<td class="textborder">Nos.</td>
		<td class="textborder">
			<html:text property="shpNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="cisternsNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="glsrNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)"/>
		</td>
		<td class="textborder">
			<html:text property="ohsrNo"  styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		</td>
		<td>
			<html:text property="drinkTotalNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		</td>
		<td class="textborder">
			<html:text property="hpNo" styleClass="gridText" style="width:75px" />
		</td>
		<td class="textborder">
			<html:text property="owsNo" styleClass="gridText" style="width:75px" />
		</td>
		<td class="textborder">
			<html:text property="pondsNo" styleClass="gridText" style="width:75px"/>
		</td>
		<td class="textborder">
			<html:text property="shwNo" styleClass="gridText" style="width:75px"/>
		</td>
		<td>
			<html:text property="otherTotalNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		</td>
	</tr>
	<tr>
		<td class="textborder" nowrap>Water Supply</td>
		<td class="textborder">
			<html:text property="shpSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="cisternsSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="glsrSupply" styleClass="gridText" style="width:50px" readonly="true" />
		</td>
		<td class="textborder">
			<html:text property="ohsrSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" />
		</td>
		<td>
			<html:text property="drinkTotalSupply" styleClass="gridText" style="width:50px"
						 onkeypress="return numeralsOnly(event)"/>
		</td>
		<td class="textborder">
			<html:text property="hpSupply" styleClass="gridText" style="width:50px" />
		</td>
		<td class="textborder">
			<html:text property="owsSupply" styleClass="gridText" style="width:50px" />
		</td>
		<td class="textborder">
			<html:text property="pondsSupply" styleClass="gridText" style="width:50px" />
		</td>
		<td class="textborder">
			<html:text property="shwSupply" styleClass="gridText" style="width:50px" />
		</td>
		<td>
			<html:text property="otherTotalSupply" styleClass="gridText" style="width:50px" 
					 	 onkeypress="return numeralsOnly(event)"/>
		</td>
	</tr>

	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<table width="100%">
	<tr>
		<td class="textborder">PCPD Drinking</td>
		<td class="textborder">
			<html:text property="pcpdDrink"  styleClass="mytext" style="width:50px" 
						 onkeypress="return decimalsOnly(event)"
						 onblur="javascript: fnCalculatePCPDTotal()"/>
		</td>
		<td class="textborder">PCPD Others</td>
		<td class="textborder">
			<html:text property="pcpdOthers"  styleClass="mytext" style="width:50px" 
						 onkeypress="return decimalsOnly(event)"
						 onblur="javascript: fnCalculatePCPDTotal()"/>
		</td>
		<td class="textborder">Total PCPD</td>
		<td class="textborder">
			<html:text property="pcpdTotal"  styleClass="mytext" 
						 style="width:50px" onkeypress="return numeralsOnly(event)" 
						 readonly="true"/>
		</td>
	</tr>

	<tr>
		<td class="textborder"><bean:message key="app.totWS" /></td>
		<td class="textborder">
			<html:text property="totalWaterSupply" styleClass="mytext" 
						   style="width:60px" onkeypress="return decimalsOnly(event)"
						   onfocus="findTotal('totalWaterSupply')"/>&nbsp;lts
		</td>
		<td class="textborder"><bean:message key="app.existWatSup" /></td>
		<td class="textborder">
			<html:text property="levelOfWaterSupply" styleClass="mytext" readonly="true" 
					   style="width:60px" 
					   onfocus="findTotal('levelOfWaterSupply')" />&nbsp;lpcd
		 </td>
		 <td class="textborder"><bean:message key="app.cvrdStatus" /></td>
		 <td class="textborder">
			<html:select property="status" styleClass="mycombo" 
						 style="width:70px">
				<html:option value="">SELECT...</html:option>
				<html:option value="FC">FC</html:option>
				<html:option value="NC">NC</html:option>
				<html:option value="PC1">PC1</html:option>
				<html:option value="PC2">PC2</html:option>
				<html:option value="PC3">PC3</html:option>
				<html:option value="PC4">PC4</html:option>
				<html:option value="NSS">NSS</html:option>
			</html:select>
		</td>
	</tr>	
	</table>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend>Distance From Nearest</legend>
	<label>
		<table width="100%">
		<tr>
			<td class="textborder">Ground Water Source</td>
			<td class=myfontclr>
				<html:text property="nearWaterGroundSource" styleClass="mytext" 
					   style="width:60px" onkeypress="return decimalsOnly(event)"/>&nbsp;kms
			<td class="textborder">Surface Water Source</td>
			<td class=myfontclr>
				<html:text property="nearWaterSource" styleClass="mytext" style="width:60px"
						   onkeypress="return decimalsOnly(event)"/>&nbsp;kms
			</td>
		</tr>
		</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td>	
	<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
	<tr>
	<td>
		<div style="position:relative;overflow-y:auto;left:0;top:0;">
		<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
			<tr bgcolor="#8A9FCD">
				<td colspan=3 align="left" style="font-family:verdana; font-size:9pt;font-weight: bold; color:#ffffff">
					Public Institutions Details
				</td>
			</tr>
			<tr>
				<td class=clrborder align=center>Name</td>
				<td class=clrborder align=center>Total No.</td>
				<td class=clrborder align=center>No. Covered with<br>drinking water</td>
			</tr>
			<nested:iterate id="HABINST_LIST" property="habInsts">
			<tr>
				<td  class="textborder">
					<bean:write name="HABINST_LIST" property="instituteName" />
					<nested:hidden property="instituteCode" name="HABINST_LIST" indexed="true" />

				</td>
				<td  class="textborder" >
					<nested:text property="instituteNo" name="HABINST_LIST" indexed="true"
						styleClass="mytbltext" style="width:100px" 
						onkeypress="return numeralsOnly(event)" />
				</td>
				<td  class="textborder" >
					<nested:text property="instituteCovered" name="HABINST_LIST" 
						styleClass="mytbltext" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)" />
				</td>
			</tr>
			</nested:iterate>
		</table>
		</div>
	</td>
	</tr>
	</table>
</td>
</tr>	

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.others" /></legend>
	<label>
		<table width="100%" align="center" border="0">
		<tr>
			<td class="textborder"><bean:message key="app.remarks" /></td>
			<td><html:textarea property="remarks" cols="35"/></td>
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
			<bean:write name="HABCONTAMINATION_LIST" property="contType" />
			<nested:hidden name="HABCONTAMINATION_LIST" property="contType" indexed="true"/>
		</td>
		<td  class="textborder" >
			<nested:text property="percent" name="HABCONTAMINATION_LIST" 
						 styleClass="mytbltext" indexed="true" 
						 onkeypress="return decimalsOnly(event)"/>
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
</td>
</tr>

<tr>
<td>
	<table width="100%">
	<tr>
		<td class="textborder" align=center>
 			<logic:notEmpty name="habStatusForm" property="buttonName">
			<html:submit property="mode" title="Save the Fields" styleClass="btext" onclick="return validateHabStatusForm(habStatusForm)" >
				<bean:write name="habStatusForm" property="buttonName" />
			</html:submit>	
			</logic:notEmpty>	
		<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	 
		</td>
	</tr>
	</table>
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>


</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

