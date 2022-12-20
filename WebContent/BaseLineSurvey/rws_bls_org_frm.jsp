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
document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=getmandal";
document.forms[0].submit();
}
function funcMandalChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=getpanchayath";
	document.forms[0].submit();
}
function fnPanchayathChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=getvillage";
	document.forms[0].submit();
}
function fnVillageChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=gethab";
	document.forms[0].submit();
}
function fnHabChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=view";
	document.forms[0].submit();
}
function save()
{
	if (document.forms[0].district.value=="" )
	{
		alert("District Required");
		return false;
	}
	if (document.forms[0].mandal.value=="" )
	{
		alert("Mandal Required");
		return false;
	}
	if (document.forms[0].panchayat.value=="" )
	{
		alert("Panchayath Required");
		return false;
	}
	if (document.forms[0].village.value=="" )
	{
		alert("Village Required");
		return false;
	}
	if (document.forms[0].habCode.value=="" )
	{
		alert("select Habitation");
		return false;
	}
	if (document.forms[0].ngos.value=="" )
	{
		alert("select Ngos value");
		return false;
	}
	if (document.forms[0].shgs.value=="" )
	{
		alert("select shgs value");
		return false;
	}
	if (document.forms[0].wmngrps.value=="" )
	{
		alert("select women groups value");
		return false;
	}
	if (document.forms[0].othergrps.value=="" )
	{
		alert("select other groups value");
		return false;
	}
	
	if (document.forms[0].surveydt.value=="" )
	{
		alert("select survey date");
		return false;
	}
	
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/orgingp.do?mode=save";
	document.forms[0].submit();
}

</script>
</head>


<html:form action="/orgingp.do">
	
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Base Line Servey Other Organizations in GP" />
	<jsp:param name="TWidth" value="660" />
</jsp:include>
<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="690" >
		<tr>
			<td class="textborder" >
				<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD"
					style="border-collapse: collapse;" width="90%">
					<tr><td><font color="#000000" face=verdana size=2><B>District<font color="#FF6666">*</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		 
         </B></font></td><td>
		<html:select property="district" style="width:141px"   onchange="javascript: funcDistrictChanged();" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
    	 </html:select>
		
		</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B>Mandal<font color="#FF6666">*</font>&nbsp; </B></font></td><td>
		<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="javascript: funcMandalChanged();">
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="mandalcodes">
		 <html:options collection="mandalcodes" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select>
	</td>
	</tr>	
	<tr>
	<td class="textborder" >
		<font color="#000000" face=verdana size=2><B>Panchayat<font color="#FF6666">*</font> </B></font></td><td>
		<html:select property="panchayat" style="width:140px"    styleClass="mycombo" onchange="fnPanchayathChanged()" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="panchayaths">
		
		<html:options collection="panchayaths" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select>
	 </td>

	<td class="textborder" >
		 <font color="#000000" face=verdana size=2><B>Village<font color="#FF6666">*</font></B></font></td><td>
		 <html:select property="village" style="width:140px"    styleClass="mycombo" onchange="fnVillageChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 						<logic:notEmpty name="villages">
		 		
		 		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:notEmpty>
		 </html:select>
	</td>
	</tr>	
	<tr>
	<td class="textborder" ><font color="#000000" face=verdana size=2><B>Habitation<font color="#FF6666">*</font></B></font></td><td>
        <html:select property="habCode" styleClass="mycombo" style="width:280px" onchange="fnHabChanged()"> 
	    <html:option value="">SELECT...</html:option>
	    				<logic:notEmpty name="habitations">
	    
	    <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	   </logic:notEmpty>
	    </html:select>
        </td>
        <td class="textborder" ><font color="#000000" face=verdana size=2><B>NGOS<font color="#FF6666">*</font></B></font></td><td>
        <html:select property="ngos" styleClass="mycombo" style="width:120px"> 
	    <html:option value="">SELECT...</html:option>
	     <html:option value="Yes">Yes</html:option>
	     <html:option value="No">No</html:option>
	    </html:select>
        </td></tr>	
	<tr>
         <td class="textborder" ><font color="#000000" face=verdana size=2><B>SHGS<font color="#FF6666">*</font></B></font></td><td>
        <html:select property="shgs" styleClass="mycombo" style="width:120px"> 
	    <html:option value="">SELECT...</html:option>
	     <html:option value="Yes">Yes</html:option>
	     <html:option value="No">No</html:option>
	    </html:select>
        </td>
         <td class="textborder" ><font color="#000000" face=verdana size=2><B>Women Groups<font color="#FF6666">*</font></B></font></td><td>
        <html:select property="wmngrps" styleClass="mycombo" style="width:120px"> 
	    <html:option value="">SELECT...</html:option>
	     <html:option value="Yes">Yes</html:option>
	     <html:option value="No">No</html:option>
	    </html:select>
        </td>
	</tr>
	<tr>
	
	<td class="textborder" ><font color="#000000" face=verdana size=2><B>Other Groups<font color="#FF6666">*</font></B></font></td><td>
        <html:select property="othergrps" styleClass="mycombo" style="width:120px"> 
	    <html:option value="">SELECT...</html:option>
	     <html:option value="Yes">Yes</html:option>
	     <html:option value="No">No</html:option>
	    </html:select>
        </td><td class="textborder" >
        <font color="#000000" face=verdana size=2><B>Survey Date<font color="#FF6666">*</font></B></font></td><td>
        <html:text property="surveydt"  styleClass="mytext1" tabindex="15" size="8" /><a href="javascript: showCalendar(document.blsOrgForm.surveydt);"></font><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="30" border="0" height="19" align="absmiddle"></a>
	</td>
	</tr>
	<tr>
			<td align="center" colspan="4">
				<input type="button"  class="btext2" name="save/update" value="save/update" onclick="save()"/>  </td>
		</tr>
				</table>
				
			</td>
		</tr>
		
		
		
		
		</table>
		
		
	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="660" />
	</jsp:include>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>