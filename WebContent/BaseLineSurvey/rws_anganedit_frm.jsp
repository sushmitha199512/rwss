<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<html:html>
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
	color: green;
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
<script type="text/javascript" src="/pred/resources/javascript/tinybox.js"></script>
<link rel="stylesheet" href="/pred/resources/style/demos.css" type="text/css">
<head>


<script language="JavaScript">
<%
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate=null;
	transdate=dateFormat.format(systemdate);
%>


function init()
{
	dCode='';
	mCode='';
	pCode='';
	vCode='';
	habCode='';
}

function fnSave()
{
	
	 if(document.forms[0].anganwadiName.value=="" || document.forms[0].anganwadiName.value==null)
	 {
		 alert("Enter Anganwadi Name");
		 return false;
	 }
       
  else if(document.forms[0].anganCode.value=="" || document.forms[0].anganCode.value==null)
	 {
		 alert("Enter Anganwadi Code");
		 return false;
	 }

	 else if(document.forms[0].buildingTypename.value=="" || document.forms[0].buildingTypename.value==null)
	 {
		 alert("Enter Building Type Name");
		 return false;
	 }
	 else if(document.forms[0].totalEnrolment.value=="" || document.forms[0].totalEnrolment.value==null)
	 {
		 alert("Enter Total Enrollment");
		 return false;
	 }
	 else if(document.forms[0].availabilityofToiletfacility.value=="" || document.forms[0].availabilityofToiletfacility.value==null)
	 {
		 alert("Select Availability Of Toilet Facility");
		 return false;
	 }
	 else if(document.forms[0].buildingDept.value=="" || document.forms[0].buildingDept.value==null)
	 {
		 alert("Select Building Department");
		 return false;
	 }
	 else if(document.forms[0].yearofBuilt.value=="" || document.forms[0].yearofBuilt.value==null)
	 {
		 alert("Select Year Of Built");
		 return false;
	 }
	 
      else if(document.forms[0].sanitaryUse.value=="" || document.forms[0].sanitaryUse.value==null)
	 {
		 alert("Select Sanitary Use");
		 return false;
	 }
        else if(document.forms[0].functionalReason.value=="" || document.forms[0].functionalReason.value==null)
	 {
		 alert("Enter Functional Reason");
		 return false;
	 }
	
else if(document.forms[0].reasonforDefunct.value=="" || document.forms[0].reasonforDefunct.value==null)
	 {
		 alert("Enter Reason For Defunct");
		 return false;
	 }
	
else if(document.forms[0].toiletwaterFacilityavailable.value=="" || document.forms[0].toiletwaterFacilityavailable.value==null)
	 {
		 alert("Select Toilet Water Facility Available");
		 return false;
	 }
	 
else if(document.forms[0].drinkingWaterexist.value=="" || document.forms[0].drinkingWaterexist.value==null)
	 {
		 alert("Select Drinking Water Exist");
		 return false;
	 }
	 
else if(document.forms[0].drinkingWaterexist.value=="" || document.forms[0].drinkingWaterexist.value==null)
	 {
		 alert("Select Drinking Water Exist");
		 return false;
	 }
else if(document.forms[0].binExist.value=="" || document.forms[0].binExist.value==null)
	 {
		 alert("Select Bin Available");
		 return false;
	 }

else if(document.forms[0].pitExist.value=="" || document.forms[0].pitExist.value==null)
	 {
		 alert("Select Pit Available");
		 return false;
	 }

else if(document.forms[0].surveyDate.value=="" || document.forms[0].surveyDate.value==null)
	 {
		 alert("Select Survey Date");
		 return false;
	 }




else
{
	
	
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/Angan.do&mode=edit";
    document.forms[0].submit();
}
	

}




</script>

<body  onload="javascript:init();">


<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/Angan.do">

<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="BaseLine Survey Anganwadi Edit Entry Form" />
	<jsp:param name="TWidth" value="960" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
			<td class="textborder" >
<table cellpadding="1" cellspacing="5" bordercolor="#8A9FCD" border=0 
					style="border-collapse: collapse;" width="1000">

	  <tr>
<td>
   <fieldset>
   <legend><b>Habitation Details</b><span class="mandatory">*</span></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
    <tr>
	    <td class="btext2" width="100"><bean:message key="app.district"/>
	    <html:text property="dName"  readonly="true"/>
		</td>
		<td class="btext2" width="100">
	<bean:message key="app.mandal"/><html:text property="mName" readonly="true" />
	</td>
		<td class="btext2" width="100">
	<bean:message key="app.panchayat" /><html:text property="pName"  readonly="true"/>
	</td>
	<td class="btext2" width="100">
	<bean:message key="app.village" /><html:text property="vName" readonly="true"/>
	</td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td class="btext2" width="100">
		<bean:message key="app.Hab" /><html:text property="panchName" readonly="true"/>
		</td>
		</tr>


	
	
</table>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
	
		<tr>
		<td>
		<fieldset>
   	    <legend  ><b>Angan Wadi  Details</b><span class="mandatory">*</span></legend>
   	    <label>

		<table  border=0   width="100%"  style="border-collapse:collapse;">
		
		<tr>
		<td class="btext2">Anganwadi Name<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="anganwadiName"    maxlength="50" size="30" onkeypress="return alpha(event)" /></td>
		<td class="btext2">Anganwadi Code<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="anganCode"    maxlength="15" size="15" onkeypress="return numeralsOnly(event)" /></td>
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		<td class="btext2">Building Type Name<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="buildingTypename"    maxlength="50" size="30" onkeypress="return alpha(event)" /></td>
		<td class="btext2">Total Enrolment<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="totalEnrolment"    maxlength="5" size="5" onkeypress="return numeralsOnly(event)" /></td>
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		
		<td class="btext2" >Availability of Toilet Facility<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		
		
		<td class="textborder" ><font color="#FF6666"></font>
		
		<html:select property="availabilityofToiletfacility" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes </html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
		
			</html:select>
		</td>
		
		
		
		
		<td class="btext2" >Building Department<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		
		
		<td class="textborder" ><font color="#FF6666"></font>
		
		<html:select property="buildingDept" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="NBA"><font class="myfontclr1">NBA </html:option>
		<html:option value="Other than NBA"><font class="myfontclr1">Other than NBA</html:option>
		
			</html:select>
		</td>
		
		
		
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		
		
		
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		<td class="btext2"><font face=verdana size=2><B>Year of Built<font color="#FF6666">*</font>
		</td>
		

<td  class=btext2 >


    <html:select property="yearofBuilt" style="width:135px" styleClass="mycombo">

	<logic:present name="expyears">
	<html:option value="">SELECT</html:option>	
	<html:options collection="expyears" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	
	</html:select>
</td>

		
		
		
		
		
		
		<td  class=btext2 ><font  face=verdana size=2><B>Sanitary Use<font color="#FF6666">*</font>&nbsp;
		
		
		</B></font>
		</td>
		<td  class=clrborder >
		<html:select property="sanitaryUse" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
		
			</html:select>
		</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	
		<tr>
		<td class="btext2">Functional Reason<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="functionalReason"    maxlength="15" size="15" onkeypress="return alpha(event)" /></td>
		
		
		<td class="btext2">Reason For Defunct<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="reasonforDefunct"    maxlength="50" size="30" onkeypress="return alpha(event)" /></td>
		
		
		</tr>
		
		<tr>
		<td>&nbsp;</td>
		</tr>
		<tr>
		<td class="btext2" >Toilet water Facility Available<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="toiletwaterFacilityavailable" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		<td class="btext2" >Drinking Water Exist<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="drinkingWaterexist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		</tr>
		<tr><td>&nbsp;</td></tr>
		<tr>
		<td  class="btext2" >Bin Available<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" >
		<html:select property="binExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		<td class="btext2" >Pit Available<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="pitExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		</tr>
		<td>&nbsp;</td>
		<tr>
			
		<td  class="btext2" >Survey Date:<font color="#FF6666">*</font></td>
		<td class="textborder" >
	<html:text property="surveyDate"  styleClass="mytext" style="width:100px" readonly="true" />
	<a href="javascript:showCalendar(document.BaseLineForm.surveyDate);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
	</tr>
		
				</table>		
				</fieldset>
				</label>
				</td>
				</tr>
				
   	</table>
   	
					
	
	
	<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="Update/Save the Fields" styleClass="btext2" value="Save" onclick="fnSave()"  />
		
		
		
				</td>
				
	</tr>
</table>
	</table>
			
 
	
	<jsp:include page="/commons/TableFotter.jsp">
	
	<jsp:param name="TWidth" value="960"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>


