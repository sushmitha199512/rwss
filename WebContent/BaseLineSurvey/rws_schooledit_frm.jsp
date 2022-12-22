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
function getData2()
{
	
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/School.do&mode=data";
    document.forms[0].submit();
}
function fnView()
{
	alert(1);
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/School.do&mode=cview";
    document.forms[0].submit();
}

function fnSave()
{
	
	
	if(document.forms[0].schoolName.value=="" || document.forms[0].schoolName.value==null)
	{
		alert("Enter School Name");
		return false;
	}
	else if(document.forms[0].diseCode.value=="" || document.forms[0].diseCode.value==null)
	{
		alert("Enter Dise Code");
		return false;
	}
	else if(document.forms[0].locality.value=="" || document.forms[0].locality.value==null)
	{
		alert("Enter Locality");
		return false;
	}
	else if(document.forms[0].schoolType.value=="" || document.forms[0].schoolType.value==null)
	{
		alert("Enter School Type");
		return false;
	}
	else if(document.forms[0].schoolCategory.value=="" || document.forms[0].schoolCategory.value==null)
	{
		alert("Enter School Category");
		return false;
	}
	else if(document.forms[0].schoolEstablieshed2007.value=="" || document.forms[0].schoolEstablieshed2007.value==null)
	 {
		 alert("Select School Established 2007");
		 return false;
	 }
	else if(document.forms[0].boysCount.value=="" || document.forms[0].boysCount.value==null)
	{
		alert("Enter Boys Count");
		return false;
	}
	else if(document.forms[0].girlsCount.value=="" || document.forms[0].girlsCount.value==null)
	{
		alert("Enter Girls Count");
		return false;
	}
	else if(document.forms[0].sanitaryExist.value=="" || document.forms[0].sanitaryExist.value==null)
	 {
		 alert("Select Sanitary Exist");
		 return false;
	 }
	else if(document.forms[0].sanitaryBuildingdept.value=="" || document.forms[0].sanitaryBuildingdept.value==null)
	{
		alert("Select Sanitary Building Dept");
		return false;
	}
	
	else if(document.forms[0].yearofBuilt.value=="" || document.forms[0].yearofBuilt.value==null)
	{
		alert("Select Year Of Built");
		return false;
	}
	else if(document.forms[0].boystoiletCount.value=="" || document.forms[0].boystoiletCount.value==null)
	{
		alert("Enter Boys Toilet Count");
		return false;
	}
	
	else if(document.forms[0].girlstoiletCount.value=="" || document.forms[0].girlstoiletCount.value==null)
	{
		alert("Enter Girls Toilet Count");
		return false;
	}

	

	 else if(document.forms[0].schoolCategory.value=="" || document.forms[0].schoolCategory.value==null)
	 {
		 alert("Select School Category");
		 return false;
	 }
	 

else if(document.forms[0].isWaterExist.value=="" || document.forms[0].isWaterExist.value==null)
	 {
		 alert("Select Is Water Exist");
		 return false;
	 }
else if(document.forms[0].sanitaryUse.value=="" || document.forms[0].sanitaryUse.value==null)
	 {
		 alert("Select Sanitary Use");
		 return false;
	 }
else if(document.forms[0].drinkingwaterFacilityAvailable.value=="" || document.forms[0].drinkingwaterFacilityAvailable.value==null)
	 {
		 alert("Select Drinking Water Facility Available");
		 return false;
	 }

else if(document.forms[0].binExist.value=="" || document.forms[0].binExist.value==null)
	 {
		 alert("Select Bin Exist");
		 return false;
	 }
else if(document.forms[0].pitExist.value=="" || document.forms[0].pitExist.value==null)
	 {
		 alert("Select pit Exist");
		 return false;
	 }
	
	else if(document.forms[0].surveyDate.value=="" || document.forms[0].surveyDate.value==null)
	{
		alert("Select Survey Date");
		return false;
	}
	
	else
	{
	
	
	
	document.forms[0].action="switch.do?prefix=/BaseLineSurvey&page=/School.do&mode=edit";
    document.forms[0].submit();
	
}
}




</script>

<body  onload="javascript:init();">


<%@ include file="/commons/rws_header2.jsp" %>
<html:form action="/School.do">

<table>
<tr><td align="right">
<a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
</td></tr>
</table>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="BaseLine Survey Schools Edit Entry Form" />
	<jsp:param name="TWidth" value="960" />
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
			<td class="textborder" >
	   <tr>
<td>
   <fieldset>
   
   <legend><b><bean:message key="legend.habitationDetails"/></b><span class="mandatory">*</span></legend>
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
	<bean:message key="app.village" /><html:text property="vName" readonly="true" />
	</td>
		</tr>
		<tr>
		<td></td>
		<td></td>
		</tr>
		<tr>
		<td class="btext2" width="100">
		<bean:message key="app.Hab" /><html:text property="panchName"  readonly="true"/>
		</td>
		</tr>


	
	
</table>
</fiedset>
</label>
</td>
</tr><table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="none" border="1" 
	   style="border-collapse:collapse;" width="1000" >
		<tr>
		<td>
		<fieldset>
   	    <legend  ><b>School Details</b><span class="mandatory">*</span></legend>
   	    <label>
		
		<table  border=0   width="100%"  style="border-collapse:collapse;">
		
		<tr>
		<td class="btext2">School Name<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="schoolName"  style="width:180px"  maxlength="100" size="50" onkeypress="return alpha(event)" />
		<html:hidden property="schoolCode"   />
		</td>
		<td class="btext2">Dise Code<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="diseCode"    maxlength="15" size="15" onkeypress="return numeralsOnly(event)" /></td>
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		<td class="btext2">Locality<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="locality"  style="width:180px"  maxlength="100" size="50" onkeypress="return alpha(event)" /></td>
		<td class="btext2">School Type<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="schoolType"    maxlength="15" size="15" onkeypress="return alpha(event)" /></td>
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		
		<td class="btext2" >School Category<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		
		
		<td class="textborder" ><font color="#FF6666"></font>
		
		<html:select property="schoolCategory" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Primary "><font class="myfontclr1">Primary </html:option>
		<html:option value="Upper primary "><font class="myfontclr1">Upper primary</html:option>
		<html:option value="High "><font class="myfontclr1">High </html:option>
			</html:select>
		</td>
		
		
		
		
		<td class="btext2" >School Established 2007<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		
		
		<td class="textborder" ><font color="#FF6666"></font>
		
		<html:select property="schoolEstablieshed2007" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes </html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
		
			</html:select>
		</td>
		
		
		
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		
		
		<tr>
		<td class="btext2">Boys Count<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="boysCount"  maxlength="4" size="4" onkeypress="return numeralsOnly(event)"  /></td>
		<td class="btext2">Girls Count<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="girlsCount"   maxlength="4" size="4" onkeypress="return numeralsOnly(event)"  /></td>
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		<td class="btext2" >Sanitation Exist<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		
		
		<td class="textborder" ><font color="#FF6666"></font>
		
		<html:select property="sanitaryExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		<tr>
		<td class="btext2" >Sanitation Building Department<font color="#FF6666">*</font><font color="#FF6666"></font>
		<td class="textborder" ><font color="#FF6666"></font>
		<html:select property="sanitaryBuildingdept" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="NBA"><font class="myfontclr1">NBA </html:option>
		<html:option value="Other than NBA"><font class="myfontclr1">Other than NBA</html:option>
		
			</html:select>
			</td>
		</td>
		

<td class="btext2" >Year Of Built<font color="#FF6666">*</font><font color="#FF6666"></font>

<td class="textborder" ><font color="#FF6666"></font>
    <html:select property="yearofBuilt" style="width:135px" styleClass="mycombo">

	<logic:present name="expyears">
	<html:option value="">SELECT</html:option>	
	<html:options collection="expyears" name="labelValueBean" property="value" labelProperty="label" />
	</logic:present>
	
	</html:select>
	</td>
</td>
</tr>
<tr>
		<td>&nbsp;</td>
		</tr>
		

		
		<tr>
		<td class="btext2">Boys Toilet Count<font color="#FF6666">*</font>
		</td>
		<td class="textborder" >
		<html:text property="boystoiletCount"    maxlength="4" size="4" onkeypress="return numeralsOnly(event)"  /></td>
		<td class="btext2">Girls Toilet Count<font color="#FF6666">*</font>
		</td>
		
		<td class="textborder" >
		<html:text property="girlstoiletCount"    maxlength="4" size="4" onkeypress="return numeralsOnly(event)"  /></td>
		
		
		</tr>
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		
		
		
		<tr>
		
		<td  class=btext2 ><font face=verdana size=2><B>Is water Exist<font color="#FF6666">*</font>&nbsp;
		
		</B></font></td><td>
		
		
		<html:select property="isWaterExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes </html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
		
			</html:select>
		</td>
		<td  class=btext2 ><font face=verdana size=2><B>Sanitation Use<font color="#FF6666">*</font>&nbsp;
		
		
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
		<tr>
		<td>&nbsp;</td>
		</tr>
		<tr>
		<td class="btext2" >Drinking Water Facility Available<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="drinkingwaterFacilityAvailable" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		
		<td  class="btext2" >Bin Exist<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" >
		<html:select property="binExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
		</tr>
		
		<tr>
		<td>&nbsp;</td>
		</tr>
		
		<tr>
		<td class="btext2" >Pit Exist<font color="#FF6666">*</font><font color="#FF6666"></font></td>
		<td class="textborder" width="150">
		<html:select property="pitExist" styleClass="mycombo" style="width:135px"  >
		<html:option value="">SELECT</html:option>
		<html:option value="Yes"><font class="myfontclr1">Yes</html:option>
		<html:option value="No"><font class="myfontclr1">No</html:option>
			</html:select>
		</td>
			
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
				
   	
					
	
	
	<tr>
		<td class="textborder" align=center>			 
		<html:button property="mode" title="Update/Save the Fields" styleClass="btext2" value="Save" onclick="fnSave()"  />
		
		
		
				</td>
				
	</tr>
	

			
 
	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="960"/>
</jsp:include>
</html:form>
</html:html>
<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>


