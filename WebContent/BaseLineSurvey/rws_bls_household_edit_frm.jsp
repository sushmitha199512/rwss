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


function save()
{
	
	var hab = document.forms[0].habCode.value;
	var surveydt = document.forms[0].surveydt.value;
	var headnm = document.forms[0].hedname.value;
	
	if (hab == null || hab == "") {
		alert("Please select habitation");
		document.forms[0].habCode.focus();
		return false;
	}
	if (surveydt == null || surveydt == "") {
		alert("Please select survey date");
		document.forms[0].surveydt.focus();
		return false;
	}
	if (headnm == null || headnm == "") {
		alert("please enter family head name");
		document.forms[0].hedname.focus();
		return false;
	}
	
	
	else{
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/household.do?mode=update";
	document.forms[0].submit();}
}
</script>
</head>


<html:form action="/household.do">
	
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Base Line Servey Household Edit Form" />
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
	<html:text property="district"></html:text>
		
		</td>
<td class="textborder"><font color="#000000" face=verdana size=2><B>Mandal&nbsp; </B></font></td><td>
		<html:text property="mandal"></html:text>
	</td>
	</tr>	
	<tr>
	<td class="textborder" >
		<font color="#000000" face=verdana size=2><B>Panchayat </B></font></td><td>
		<html:text property="panchayat"></html:text>
	 </td>

	<td class="textborder" >
		 <font color="#000000" face=verdana size=2><B>Village</B></font></td><td>
		 <html:text property="village"></html:text>
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
        <td class="textborder">Relationship With Head<font color="#FF6666">*</font></td>
						<td><html:text property="hedrelation" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
				<td class="textborder">Card Type<font color="#FF6666">*</font></td>
						<td><html:text property="cardtype" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>		
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
						<td><html:text property="departmentnm" styleClass="mytext1" size="25" maxlength="50"onkeypress="return textOnly1(event)" /></td>
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
						<td><html:select property="toiletsuse" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
        </tr>
        <tr>
         <td class="textborder">Reason for not Using Toilets<font color="#FF6666">*</font></td>
						<td><html:text property="toiletsnotusereason" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
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
						<td><html:select property="toiletsdefuntstatus" styleClass="mycombo" style="width:280px" > 
	    <html:option value="">Select..</html:option>
	    <html:option value="Yes">Yes</html:option>
	    <html:option value="No">No</html:option>
	    </html:select></td>	
        </tr>
        <tr>
         <td class="textborder">Reason for Toilet Defunt<font color="#FF6666">*</font></td>
						<td><html:text property="toiletsdefuntreason" styleClass="mytext1" size="25" maxlength="50" onkeypress="return textOnly1(event)"/></td>
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
						<td><html:text property="usagewaterpots" styleClass="mytext1" size="25" maxlength="50" onkeypress="return numeralsOnly(event)"/></td>
						
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
			<td align="center" colspan="4"><input type="button"  class="btext2" name="UPDATE" value="update" onclick="save()"/>
				 </td>
				
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