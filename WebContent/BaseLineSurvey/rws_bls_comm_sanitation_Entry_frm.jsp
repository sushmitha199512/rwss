<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<head>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</STYLE>
<script type="text/javascript">
function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=mandal";
document.forms[0].submit();
}
function funcMandalChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=panchayat";
	document.forms[0].submit();
}
function fnPanchayatChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=village";
	document.forms[0].submit();
}
function fnVillageChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=hab";
	document.forms[0].submit();
}
function fnHabChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=habdetails";
	document.forms[0].submit();
}
function fnView()
{

	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do&mode=view";
    document.forms[0].submit();
}

function save()
{


	if (parseInt(document.forms[0].totalCscConstructed.value)<=0 ||parseInt(document.forms[0].totalFunctionalCsc.value)<=0 || parseInt(document.forms[0].totalDefunctCsc.value)<=0 || parseInt(document.forms[0].noofAdditionalCscRequired.value)<=0)
	{
		alert("Entered Value Should greater than 0");
		return false;
	}
	if (document.forms[0].district.value=="" )
	{
		alert("Select District");
		return false;
	}
	if (document.forms[0].mandal.value=="" )
	{
		alert(" Select Mandal");
		return false;
	}
	if (document.forms[0].panchayat.value=="" )
	{
		alert("Select Panchayat");
		return false;
	}
	if (document.forms[0].village.value=="" )
	{
		alert("Select Village");
		return false;
	}
	if (document.forms[0].habCode.value=="" )
	{
		alert("select Habitation");
		return false;
	}
	if (document.forms[0].habCode.value=="" )
	{
		alert("select Habitation");
		return false;
	}
	if (document.forms[0].totalCscConstructed.value=="" ||document.forms[0].totalFunctionalCsc.value==""||document.forms[0].totalDefunctCsc.value=="" ||document.forms[0].noofAdditionalCscRequired.value=="")
	{
		alert("Enter mandatory(*) fields");
		return false;
	}
	if (document.forms[0].surveyDate.value=="" )
	{
		alert("select surveyDate");
		return false;
	}
	else{
		document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/commSan.do?mode=save";
		document.forms[0].submit();
		}
	
	
}

</script>
</head>
<html:form action="/commSan.do">
<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Base Line Survey - Community Sanitary Entry Form" />
	<jsp:param name="TWidth" value="660" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="690" >
		<tr>
			<td class="textborder" >
<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD" border=0 
					style="border-collapse: collapse;" width="90%">
					
<tr>
<td class="btext2">District<font color="red"><b>*</b></font></td>
		<td> <html:select property="district" style="width:140px"   onchange="funcDistrictChanged()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
    	 </html:select></td>
<td class="btext2">Mandal<font color="red"><b>*</b></font></td> 
	<td>	<html:select property="mandal" style="width:140px"  styleClass="mycombo" onchange="funcMandalChanged()">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="mandals">
		 <html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select></td>
</tr>

<tr>
<td class="btext2">Panchayat<font color="red"><b>*</b></font></td>
	<td>	 <html:select property="panchayat" style="width:140px"   onchange="fnPanchayatChanged()" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="panchayats">
				<html:options collection="panchayats" name="labelValueBean" property="value" labelProperty="label" />
    	 </logic:notEmpty>
    	 </html:select></td>
<td class="btext2">Village<font color="red"><b>*</b></font></td>
	<td>	<html:select property="village" style="width:140px"  styleClass="mycombo" onchange="fnVillageChanged()">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 				<logic:notEmpty name="villages">
		 		 <html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select></td>
</tr>	

<tr>
	<td class="btext2">Habitation<font color="red"><b>*</b></font></td>
     <td>   <html:select property="habCode" styleClass="mycombo" style="width:280px" onchange="fnHabChanged()"> 
	    <html:option value="">SELECT...</html:option>
	   		 				<logic:notEmpty name="habitations">
	   	    <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	   </logic:notEmpty>
	    </html:select>
        </td>
</tr>
<table width="700" border=0 style="border-collapse:collapse;">
<br></br>
<tr>
    <td class="btext2">Total CSC Constructed<font color="red"><b>*</b></font></td><td><html:text maxlength="3" property="totalCscConstructed" onkeypress="return numeralsOnly(event)" /></td>
	<td class="btext2">Total Functional CSC<font color="red"><b>*</b></font></td><td><html:text maxlength="3"  property="totalFunctionalCsc" onkeypress="return numeralsOnly(event)"  /></td>
</tr>
<tr>
	<td class="btext2">Total Defunct CSC<font color="red"><b>*</b></font></td><td><html:text maxlength="3"  property="totalDefunctCsc" onkeypress="return numeralsOnly(event)" /></td>
	<td class="btext2"> Additional CSC Required<font color="red"><b>*</b></font></td><td><html:text maxlength="3"  property="noofAdditionalCscRequired" onkeypress="return numeralsOnly(event)" /></td>
</tr>
<tr>
	<td class="btext2">Survey date<font color="red"><b>*</b></font><font color="red">(dd/mm/yy)</font></td><td><html:text  property="surveyDate" readonly="true" /><a href="javascript:showCalendar(document.CommunitySanitaryForm.surveyDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
</tr>




</table></td></tr> 
<tr><td colspan="4">
</td></tr>
		<tr>
			<td align="center"> 
			<!--<html:submit property="mode" title="Save the Fields" styleClass="btext" value="save/update" onclick="JavaScript: return validate();"/>-->  
			<input type="button"  class="btext2" name="save/update" value="save/update" onclick="save()"/>             
		</tr></table>
<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="660" />
	</jsp:include>
</table>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>