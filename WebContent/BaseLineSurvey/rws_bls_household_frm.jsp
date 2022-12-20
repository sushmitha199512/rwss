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
function gettext(toiletstatus){
    var s1=document.forms[0].toiletsnotusereason;
    if(toiletstatus.value=="No"){
        
        s1.removeAttribute("disabled");
    } 
    else{
        s1.value="";
       s1.setAttribute("disabled","true");
    }
    
}
function getreason(toiletdefunt){
    var s1=document.forms[0].toiletsdefuntreason;
    if(toiletdefunt.value=="No"){
        
        s1.removeAttribute("disabled");
      
    } 
    else{
    	 s1.value="";
       s1.setAttribute("disabled","true")
    }
    
}

function funcDistrictChanged()
{
document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=getmandal";
document.forms[0].submit();
}
function funcMandalChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=getpanchayath";
	document.forms[0].submit();
}
function fnPanchayathChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=getvillage";
	document.forms[0].submit();
}
function fnVillageChanged()
{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=gethab";
	document.forms[0].submit();
}

function view()
{
	var district = document.forms[0].district.value;
	var mandal = document.forms[0].mandal.value;
	var panchayath = document.forms[0].panchayat.value;
	var village = document.forms[0].village.value;
	var hab = document.forms[0].habCode.value;
	
	if (district == null || district == "") {
		alert("Please select district");
		document.forms[0].district.focus();
		return false;
	}
	if (mandal == null || mandal == "") {
		alert("Please select mandal");
		document.forms[0].mandal.focus();
		return false;
	}
	if (panchayath == null || panchayath == "") {
		alert("Please select panchayath");
		document.forms[0].panchayat.focus();
		return false;
	}
	if (village == null || village == "") {
		alert("Please select village");
		document.forms[0].village.focus();
		return false;
	}
	if (hab == null || hab == "") {
		alert("Please select habitation");
		document.forms[0].habCode.focus();
		return false;
	}
	
	else{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=view";
	document.forms[0].submit();}
}
function save()
{
	var district = document.forms[0].district.value;
	var mandal = document.forms[0].mandal.value;
	var panchayath = document.forms[0].panchayat.value;
	var village = document.forms[0].village.value;
	var hab = document.forms[0].habCode.value;
	var headname = document.forms[0].hedname.value;
	var tocnt = document.forms[0].familycount.value;
	var malecnt = document.forms[0].malecount.value;
	var femalecnt = document.forms[0].femalecount.value;
	var potcpct = document.forms[0].potcapacity.value;
	var distance = document.forms[0].sourcedistance.value;
	var gender = document.forms[0].gender.value;
	if (district == null || district == "") {
		alert("Please select district");
		document.forms[0].district.focus();
		return false;
	}
	if (mandal == null || mandal == "") {
		alert("Please select mandal");
		document.forms[0].mandal.focus();
		return false;
	}
	if (panchayath == null || panchayath == "") {
		alert("Please select panchayat");
		document.forms[0].panchayat.focus();
		return false;
	}
	if (village == null || village == "") {
		alert("Please select village");
		document.forms[0].village.focus();
		return false;
	}
	if (hab == null || hab == "") {
		alert("Please select habitation");
		document.forms[0].habCode.focus();
		return false;
	}
	if (headname == null || headname == "") {
		alert("Enter head name");
		document.forms[0].hedname.focus();
		return false;
	}
	if (gender == null || gender == "") {
		alert("select gender");
		document.forms[0].gender.focus();
		return false;
	}
	if (tocnt == null || tocnt == "") {
		alert("Enter total total family count");
		document.forms[0].familycount.focus();
		return false;
	}
	if (malecnt == null || malecnt == "") {
		alert("Enter male count");
		document.forms[0].malecount.focus();
		return false;
	}
	if (femalecnt == null || femalecnt == "") {
		alert("Enter female count");
		document.forms[0].femalecount.focus();
		return false;
	}
	if (potcpct == null || potcpct == "") {
		alert("Enter pot capacity");
		document.forms[0].potcapacity.focus();
		return false;
	}
	if (distance == null || distance == "") {
		alert("Enter distance to water source");
		document.forms[0].sourcedistance.focus();
		return false;
	}
	else{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=save";
	document.forms[0].submit();}
}
</script>
</head>


<html:form action="/household.do">
	
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Base Line Servey Household Details Entry" />
	<jsp:param name="TWidth" value="970" />
</jsp:include>
<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
			<td class="textborder" >
				<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD"
					style="border-collapse: collapse;" width="90%">
					<tr><td><font color="#000000" face=verdana size=2><B>House Hold Code
		 
         </B></font></td><td><html:text property="householdnum" styleClass="mytext1" size="7" readonly="true"/></td></tr>
					<tr><td><font color="#000000" face=verdana size=2><B>District
		 
         </B></font></td><td>
		<html:select property="district" style="width:141px"   onchange="javascript: funcDistrictChanged();" styleClass="mycombo">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		<logic:notEmpty name="districts">
		<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
    	 </html:select>
		
		</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B>Mandal&nbsp; </B></font></td><td>
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
		<font color="#000000" face=verdana size=2><B>Panchayat </B></font></td><td>
		<html:select property="panchayat" style="width:140px"    styleClass="mycombo" onchange="fnPanchayathChanged()" >
		<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<logic:notEmpty name="panchayaths">
		
		<html:options collection="panchayaths" name="labelValueBean" property="value" labelProperty="label" />
		</logic:notEmpty>
		</html:select>
	 </td>

	<td class="textborder" >
		 <font color="#000000" face=verdana size=2><B>Village</B></font></td><td>
		 <html:select property="village" style="width:140px"    styleClass="mycombo" onchange="fnVillageChanged()">
		 <html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
		 						<logic:notEmpty name="villages">
		 		
		 		<html:options collection="villages" name="labelValueBean" property="value" labelProperty="label" />
		 </logic:notEmpty>
		 </html:select>
	</td>
	</tr>	
	<tr>
	<td class="textborder" ><font color="#000000" face=verdana size=2><B>Habitation</B></font></td><td>
        <html:select property="habCode" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">SELECT...</html:option>
	    				<logic:notEmpty name="habitations">
	    
	    <html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	   </logic:notEmpty>
	    </html:select>
        </td>
        <td class="textborder" >
        <font color="#000000" face=verdana size=2><B>Survey Date</B></font></td><td>
        <html:text property="surveydt"  styleClass="mytext1" tabindex="15" size="8" /><a href="javascript: showCalendar(document.houseHoldForm.surveydt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="30" border="0" height="19" align="center"></a>
	</td>
        </tr>
        <tr>
        <td class="textborder">Head Name<font color="#FF6666">*</font></td>
						<td><html:text property="hedname" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
				<td class="textborder">Father/Husband Name<font color="#FF6666">*</font></td>
						<td><html:text property="fathername" styleClass="mytext1" size="25" maxlength="100" onkeypress="return textOnly1(event)"/></td>		
        </tr>
        <tr>
        <td class="textborder">Relationship With Head<font color="#FF6666">*</font></td>
						<td><html:text property="hedrelation" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
				<td class="textborder">Card Type<font color="#FF6666">*</font></td>
						<td><html:text property="cardtype" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>		
        </tr>
        <tr>
        <td class="textborder">Gender<font color="#FF6666">*</font></td>
						<td><html:select property="gender" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="male">Male</html:option>
	    <html:option value="female">Female</html:option>
	    </html:select></td>
				<td class="textborder">Aadhar Card No<font color="#FF6666">*</font></td>
						
						<td><html:text property="adharcardnum" styleClass="mytext1" size="25" maxlength="20" onkeypress="return checkSpaceAndSpecial(event)"/></td>
        </tr>	
	 <tr>
        <td class="textborder">Card No.<font color="#FF6666">*</font></td>
						<td><html:text property="cardnum" styleClass="mytext1" size="25" maxlength="20" onkeypress="return checkSpaceAndSpecial(event)"/></td>
				<td class="textborder">Job Card No.<font color="#FF6666">*</font></td>
						<td><html:text property="jobcardnum" styleClass="mytext1" size="25" maxlength="20" onkeypress="return checkSpaceAndSpecial(event)"/></td>		
        </tr>
         <tr>
        <td class="textborder">Total Family Count<font color="#FF6666">*</font></td>
						<td><html:text property="familycount" styleClass="mytext1" size="25" maxlength="4" onkeypress="return numeralsOnly(event)"/></td>
				<td class="textborder">Female Count<font color="#FF6666">*</font></td>
						<td><html:text property="femalecount" styleClass="mytext1" size="25" maxlength="4" onkeypress="return numeralsOnly(event)"/></td>		
        </tr>
         <tr>
        <td class="textborder">Male Count<font color="#FF6666">*</font></td>
						<td><html:text property="malecount" styleClass="mytext1" size="25" maxlength="4" onkeypress="return numeralsOnly(event)"/></td>
				<td class="textborder">Base Line Status<font color="#FF6666">*</font></td>
						<td><html:text property="blsstatus" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>		
        </tr>
         <tr>
        <td class="textborder">Caste<font color="#FF6666">*</font></td>
						<td><html:text property="caste" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
				<td class="textborder">Toilets Available<font color="#FF6666">*</font></td>
						<td><html:select property="toilets" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
	            </tr>
	            <tr>
        <td class="textborder">Constructed Department<font color="#FF6666">*</font></td>
						<td><html:text property="departmentnm" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
				<td class="textborder">Toilet Type<font color="#FF6666">*</font></td>
						<td><html:text property="toilettype" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>		
        </tr>
        <tr>
        <td class="textborder">Sanitery Latrine Serviced<font color="#FF6666">*</font></td>
						<td><html:select property="latrineserviced" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
	    <td class="textborder">Toilets Used<font color="#FF6666">*</font></td>
						<td><html:select property="toiletsuse" styleClass="mycombo" style="width:280px" onchange="gettext(this)"> 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
        </tr>
        <tr>
         <td class="textborder">Reason for not Using Toilets<font color="#FF6666">*</font></td>
						<td><html:text property="toiletsnotusereason" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"  disabled="true"/></td>
						<td class="textborder">Water available for toilets? <font color="#FF6666">*</font></td>
						<td><html:select property="wateraviltoilets" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>
        </tr>
         <tr>
        <td class="textborder">Is toilet functional?<font color="#FF6666">*</font></td>
						<td><html:select property="toiletfnstatus" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
	    <td class="textborder">Is toilet defunt?<font color="#FF6666">*</font></td>
						<td><html:select property="toiletsdefuntstatus" styleClass="mycombo" style="width:280px" onchange="getreason(this)"> 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
        </tr>
        <tr>
         <td class="textborder">Reason for Toilet Defunt<font color="#FF6666">*</font></td>
						<td><html:text property="toiletsdefuntreason" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)" disabled="true"/></td>
						<td class="textborder">Community toilets useing? <font color="#FF6666">*</font></td>
						<td><html:select property="commtoiletsuse" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>
        </tr>
         <tr>
         <td class="textborder">Drinking Water Source<font color="#FF6666">*</font></td>
						<td><html:text property="watersource" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
						 <td class="textborder">Usage of water per day in pots<font color="#FF6666">*</font></td>
						<td><html:text property="usagewaterpots" styleClass="mytext1" size="25" maxlength="50" /></td>
						
        </tr>
        
          <tr>
         <td class="textborder">Litres per one pot<font color="#FF6666">*</font></td>
						<td><html:text property="potcapacity" styleClass="mytext1" size="25" maxlength="50" onkeypress="return numeralsOnly(event)"/></td>
						<td class="textborder">Is drinking water available? <font color="#FF6666">*</font></td>
						<td><html:select property="drinkwateravail" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>
        </tr>
         <tr>
         <td class="textborder">Water Available in Months<font color="#FF6666">*</font></td>
						<td><html:text property="wateravailmnths" styleClass="mytext1" size="25" maxlength="50" onkeypress="return numeralsOnly(event)"/></td>
						 <td class="textborder">Quality of Drinking Water<font color="#FF6666">*</font></td>
						<td><html:text property="waterquality" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
						
        </tr>
        <tr>
         <td class="textborder">Distance to Source Water<font color="#FF6666">*</font></td>
						<td><html:text property="sourcedistance" styleClass="mytext1" size="25" maxlength="50" onkeypress="return numeralsOnly(event)"/></td>
						 <td class="textborder">Phone No.<font color="#FF6666">*</font></td>
						<td><html:text property="phonenum" styleClass="mytext1" size="25" maxlength="50" onkeypress="return numeralsOnly(event)"/></td>
						
        </tr>
	<tr>
			<td align="center" colspan="4"><input type="button"  class="btext2" name="SAVE" value="save" onclick="save()"/>
				<input type="button"  class="btext2" name="VIEW" value="view" onclick="view();"/>  </td>
				
		</tr>
				</table>
				
			</td>
		</tr>
				
		</table>
		
		
	
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="970" />
	</jsp:include>
</html:form>
<%@ include file="/commons/rws_alert.jsp"%>