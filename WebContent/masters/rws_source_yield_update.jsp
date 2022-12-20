<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script language="JavaScript">

function fnSave(){
	var asset='';
	var length= document.HabNewEntry.resultCount.value;
	
	document.forms[0].elements['sBtn'].value="Saving Please Wait.....";
	document.forms[0].elements['sBtn'].disabled=true;
	//document.forms[0].elements["ccode"]
	
	length= length-1;

	var flag=false;
	for(var k=0;k<length;k++)
	{		
	if(document.forms[0].elements["habs["+k+"].checks"].checked)
	 {
		flag=true;
	var lat=document.forms[0].elements["habs["+k+"].latitude"].value;
	var longitude=document.forms[0].elements["habs["+k+"].longitude"].value;
	var elevation=document.forms[0].elements["habs["+k+"].elevation"].value;
	var safe = parseInt(document.forms[0].elements["habs["+k+"].safeLpd"].value);	
	var unsafe = parseInt(document.forms[0].elements["habs["+k+"].unSafeLpd"].value);


	
	var flo=parseFloat(document.forms[0].elements["habs["+k+"].flouride"].value);
	
	var brakish=parseFloat(document.forms[0].elements["habs["+k+"].brakish"].value);
	var iron=parseFloat(document.forms[0].elements["habs["+k+"].iron"].value);
	var nitrate = parseFloat(document.forms[0].elements["habs["+k+"].nitrate"].value);	
	var update=document.forms[0].elements["habs["+k+"].date"].value;
	var source=document.forms[0].elements["habs["+k+"].sourcedetails"].value;
	var plat=document.forms[0].elements["habs["+k+"].platformexistng"].value;
	var soak=document.forms[0].elements["habs["+k+"].SOAKPIT"].value;
	//alert("updatesource"+source);

	
	var status=document.forms[0].elements["habs["+k+"].status"].value;
	
	if(status==''){
		alert("Please Select Status Of the Source. ("+k+") Record");
		return;
	}
	if(safe==0 && unsafe==0  && status!='C' && status!='D' ){
		alert("Please Enter Any Safe LPD or Unsafe LPD ("+k+") Record");
		document.forms[0].elements['sBtn'].value="Save";
		document.forms[0].elements['sBtn'].disabled=false;
		return;
	}
	if(safe>0 && unsafe>0){
		
		document.forms[0].elements["habs["+k+"].flouride"].value=0;
		document.forms[0].elements["habs["+k+"].brakish"].value=0;
		document.forms[0].elements["habs["+k+"].iron"].value=0;
		document.forms[0].elements["habs["+k+"].nitrate"].value=0;
	}

	if(safe==0 && unsafe>0){

		
		if(flo==0 && brakish==0 && iron==0 && nitrate==0){
			alert("Please Enter Contamination Parameter Value for the Seleted  ("+k+") Record");
			document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
			return;
		}
		
		}
	

	
	}	//end if

	}//for loop
	if(!flag){

		 alert("Please Select Check Box For Save The Record");
		 document.forms[0].elements['sBtn'].value="Save";
			document.forms[0].elements['sBtn'].disabled=false;
		 return;
	}else{
		document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=save";	
		document.forms[0].submit();

	}
	
}

function fngetAssets()
{
	if(document.forms[0].circleCode.value=="" || document.forms[0].circleCode.value==null)
	 {
		 alert("Please Select District");
		 return false;
	 }
	
	else if(document.forms[0].sourceType.value=="" || document.forms[0].sourceType.value==null || document.forms[0].sourceType.value=="03" || document.forms[0].sourceType.value=="04" || document.forms[0].sourceType.value=="05" || document.forms[0].sourceType.value=="02" || document.forms[0].sourceType.value=="06")
		{
		
		 alert("Please Select SourceType CPWS ");
		 return false;
		}
	

	else
		{
		
		if(document.forms[0].sourceType.value=="01" || document.forms[0].sourceType.value=="06")
			{
	document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=getAssets";
	document.forms[0].submit();
	//alert("document.forms[0].action"+document.forms[0].submit());
			}
}}


function fnHabs()
{
	document.forms[0].elements['hBtn'].value="Wait.....";
	document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=habs";
	document.forms[0].submit();
	
}



function changeColor(o){
    o.style.backgroundColor=(o.style.backgroundColor=='e0ffff')?('e0ffff'):('transparent');
}
function validateCols(){
	//alert("loading...");
	
	var rcount=document.getElementById("resultCount").value;
	var source=document.getElementById("sourceType").value;
//	alert("source"+source);
	for(var i=0; i<rcount; i++)
	{
	document.getElementById("habs["+i+"].repairdate").disabled=true;
	document.getElementById("habs["+i+"].repairdesc").disabled=true;
	
	document.getElementById("habs["+i+"].staticDpth").disabled=true;
	document.getElementById("habs["+i+"].summerDpth").disabled=true;
	if(source=='05')
		{
		//alert("05");
		document.getElementById("habs["+i+"].sourcedetails").disabled=false;
		document.getElementById("habs["+i+"].repairdate").disabled=true;
		document.getElementById("habs["+i+"].repairdesc").disabled=true;
		document.getElementById("habs["+i+"].platformexistng").disabled=true;
		document.getElementById("habs["+i+"].SOAKPIT").disabled=true;
		}
	else if(source=='02')
		{
		document.getElementById("habs["+i+"].staticDpth").disabled=false;
		document.getElementById("habs["+i+"].summerDpth").disabled=false;
		document.getElementById("habs["+i+"].repairdate").disabled=false;
		document.getElementById("habs["+i+"].repairdesc").disabled=false;
		document.getElementById("habs["+i+"].sourcedetails").disabled=true;
		document.getElementById("habs["+i+"].platformexistng").disabled=false;
		document.getElementById("habs["+i+"].SOAKPIT").disabled=false;
		
		}
	
	else if(source=='03' || source=='04' || source=='06')
		{
		document.getElementById("habs["+i+"].repairdate").disabled=false;
		document.getElementById("habs["+i+"].repairdesc").disabled=false;
		document.getElementById("habs["+i+"].sourcedetails").disabled=true;
		document.getElementById("habs["+i+"].platformexistng").disabled=false;
		document.getElementById("habs["+i+"].SOAKPIT").disabled=false;
		
		
		}
	
	else
		{
		
		document.getElementById("habs["+i+"].sourcedetails").disabled=true;
		}
	}
    
		
	
}
function getMandals(){
	//alert("hi");
document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=mandals";	
document.forms[0].submit();
}
function getPanchayats(){

	document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=panchayaths";	
	document.forms[0].submit();
	
	
}

function getHabs(){
	//alert("hi");
document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=habs";	
document.forms[0].submit();
}

function getSources(){
	document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=data&modeType=sources";	
	document.forms[0].submit();
}



</script>
<script type="text/javascript" language="JavaScript">
function saveYields(count){
	var cir = document.HabNewEntry.circleCode.value;
	var mandl = document.HabNewEntry.mandalCode.value;
	if(cir!=null && cir==''){
		alert("Please select Circle Name.");
		document.HabNewEntry.circleCode.focus();
		return false;
	}
	if(mandl!=null && mandl==''){
		alert("Please select Mandal Name.");
		document.HabNewEntry.mandalCode.focus();
		return false;
	}
	
	var asset='';
	var length= document.HabNewEntry.resultCount.value;
	
	length= length-1;
	for(var k=0;k<length;k++)
		{		
		if(document.forms[0].elements["habs["+k+"].checks"].checked !=false)
		 {
			asset=asset+","+document.forms[0].elements["habs["+k+"].hpCode"].value;
	     }
	}
	  if(asset=="")
	   {
		 alert("Select atleast one check box to save");
     }
	  else{
	
		  if(confirm("Are You Sure want to Save")) {
			 document.forms[0].yields.value = asset;
            document.forms[0].action="switch.do?prefix=/masters&page=/HabiYield.do&mode=saveYield";
            document.forms[0].submit();
			}
	  }
}
</script>

<script type="text/javascript">
function  checkDisable(count){
	
	
	var hp=document.forms[0].elements["habs["+count+"].hpCode"].value;
	var safe = parseInt(document.forms[0].elements["habs["+count+"].safeLpd"].value);			
	var unsafe = parseInt(document.forms[0].elements["habs["+count+"].unSafeLpd"].value);
	
	if(safe>0 ){
		//alert("Unsafe PLD must be Zero.");
	
		document.forms[0].elements["habs["+count+"].flouride"].value=0;
		document.forms[0].elements["habs["+count+"].brakish"].value=0;
		document.forms[0].elements["habs["+count+"].iron"].value=0;
		document.forms[0].elements["habs["+count+"].nitrate"].value=0;
		
		document.forms[0].elements["habs["+count+"].flouride"].disabled=true;
		document.forms[0].elements["habs["+count+"].brakish"].disabled=true;
		document.forms[0].elements["habs["+count+"].iron"].disabled=true;
		document.forms[0].elements["habs["+count+"].nitrate"].disabled=true;
		
	}	
	if(safe==0 &&  unsafe>0){
		//alert("If Unsafe LPD greater tahn 0 &  Safe must be Zero.");
		//document.forms[0].elements["habs["+count+"].safeLpd").value=0;
		document.forms[0].elements["habs["+count+"].flouride"].disabled=false;
		document.forms[0].elements["habs["+count+"].brakish"].disabled=false;
		document.forms[0].elements["habs["+count+"].iron"].disabled=false;
		document.forms[0].elements["habs["+count+"].nitrate"].disabled=false;
	}
	
				
}
</script>


<script type="text/javascript" language="JavaScript">
function validateFl(count){
	
	var flrMax = parseFloat('<bean:write name="HabNewEntry" property="flourideMax" />');
	var flrMin = parseFloat('<bean:write name="HabNewEntry" property="flourideMin" />');
		
	var flt=parseFloat(document.forms[0].elements["habs["+count+"].flouride"].value);
	
	if(flt==0){
		return true;
	}
	if(flt>=1.5){
		return true;
	}else{
		document.forms[0].elements["habs["+count+"].flouride"].value="0";
		alert("Value Should be More than or equal to 1.5");
		return false;
	}
	
		
 }
</script>
<script type="text/javascript" language="JavaScript">
function validateBr(count){
	var flrMax = parseFloat('<bean:write name="HabNewEntry" property="brakishMax" />');
	var flrMin = parseFloat('<bean:write name="HabNewEntry" property="brakishMin" />');
		
	var flt=parseFloat(document.forms[0].elements["habs["+count+"].brakish"].value);
	
	if(flt==0){
		return true;
	}
	if(flt>=2000){
		return true;
	}else{
		document.forms[0].elements["habs["+count+"].brakish"].value="0";
		alert("Value Should be More than or equal to 2000");
		return false;
	}
}
</script>
<script type="text/javascript" language="JavaScript">
function validateIr(count){
	var flrMax = parseFloat('<bean:write name="HabNewEntry" property="ironMax" />');
	var flrMin = parseFloat('<bean:write name="HabNewEntry" property="ironMin" />');
		
	var flt=parseFloat(document.forms[0].elements["habs["+count+"].iron"].value);
	
	if(flt==0){
		return true;
	}
	if(flt>=0.3){
		return true;
	}else{
		document.forms[0].elements["habs["+count+"].iron"].value="0";
		alert("Value Should be More than or equal to 0.3");
		return false;
	}
}
</script>
<script type="text/javascript" language="JavaScript">
function validateNit(count){
	var flrMax = parseFloat('<bean:write name="HabNewEntry" property="nitrateMax" />');
	var flrMin = parseFloat('<bean:write name="HabNewEntry" property="nitrateMin" />');
		
	var flt=parseFloat(document.forms[0].elements["habs["+count+"].nitrate"].value);
	
	if(flt==0){
		return true;
	}
	if(flt>=45){
		return true;
	}else{
		document.forms[0].elements["habs["+count+"].nitrate"].value="0";
		alert("Value Should be More than or equal to 45");
		return false;
	}
}

function fndisable(){
	
	 var status=document.getElementById('statusn').value;
	var rcount=document.getElementById("resultCount").value;
	//alert("rcount"+rcount);
	for(var i=0; i<rcount; i++)
	{
		if(status=='N')
		 {
		
			document.getElementById("habs["+i+"].repairdate").disabled=false;
			document.getElementById("habs["+i+"].repairdesc").disabled=false;
			
		 
		 }
		else
			{
		
	document.getElementById("habs["+i+"].repairdate").disabled=true;
	document.getElementById("habs["+i+"].repairdesc").disabled=true;
	}
	}
    

	
}
</script>
<%
Date systemdate= new java.util.Date(System.currentTimeMillis());
java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
String transdate=null;
transdate=dateFormat.format(systemdate);
String sourceType=request.getParameter("sourceTypen");
//System.out.println("sourceType"+sourceType);
%>

<body   onLoad="validateCols();">


<html:form  action="HabiYield.do">
<html:text property="nitrateMax" style="display:none;" ></html:text>
<html:text property="brakishMax" style="display:none;" ></html:text>
<html:text property="flourideMax" style="display:none;"></html:text>
<html:text property="ironMax" style="display:none;"></html:text>

<jsp:include page="/commons/TableHeader1.jsp">
	<jsp:param name="TableName" value="Crash Programme Survey" />
	<jsp:param name="TWidth" value="1500" />	
</jsp:include>


<table  width="1500"
		border=1 style="border-collapse: collapse;">
 <!-- <tr>
       <td class="textborder" >District<font color="#FF6666">*</font>
			<html:select property="circleCode" styleClass="mycombo"  >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
	         <logic:present name="districts">
			<html:options collection="districts" name="rwsLocationBean" property="circleCode" labelProperty="circleName" />
	        </logic:present >
			</html:select>
		</td>
		
		<td class="textborder" >Source Type<font color="#FF6666">*</font>
	<html:select property="sourceType" styleClass="mycombo"  onchange="javascript:getSources();" >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
			<html:option value="01"><font class="myfontclr1">CPWS</font> </html:option>
			
			</html:select>
	</td>	
		

</tr>
		<tr>
		<TD>
		</TD>
		</tr>	
		<tr>
		<td class="textborder" align="center"><font color="red">(Or)</font>
		</tr>	 -->
		
      <tr>
       <td class="textborder" >District<font color="#FF6666">*</font>
			<html:select property="circleCode" styleClass="mycombo"  onchange="javascript:getMandals();" >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
	         <logic:present name="districts">
			<html:options collection="districts" name="rwsLocationBean" property="circleCode" labelProperty="circleName" />
	        </logic:present >
			</html:select>
		</td>
	
		<td class="textborder" >Mandals<font color="red">*</font>
			<html:select property="mandalCode" styleClass="mycombo"  onchange="javascript:getPanchayats();">
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
			<logic:present name="mandalOfficeNames">
			<html:options collection="mandalOfficeNames" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName"/>
			</logic:present>
			</html:select>
		</td>
		
			<td class="textborder">Panchayat
				<span class="mandatory">*</span>
						
				<html:select property="panchayat"     styleClass="mycombo" onchange="javascript:getHabs();">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:present name="panchayats">
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
								  </logic:present>
				</html:select>
		</td>
		
	</tr>
	
	<tr>
	<td class="textborder"  ><bean:message key="app.habCode" /><font color="#FF6666">*</font>
	<html:select property="habCode" styleClass="mycombo"  onchange="javascript:getDivisionData();">
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
			<logic:present name="habMandal">
			<html:options collection="habMandal" name="rwsLocationBean" property="habCode" labelProperty="habitationCode"/>
			</logic:present>
			</html:select>
	</td>	
	<td class="textborder" >Source Type<font color="#FF6666">*</font>
	<html:select property="sourceType" styleId="sourceTypen" styleClass="mycombo"  onchange="this.form.submit();javascript:getSources();" >
			<html:option value=""><font class="myfontclr1">SELECT...</font> </html:option>
			<html:option value="01"><font class="myfontclr1">CPWS</font> </html:option>
			<html:option value="05"><font class="myfontclr1">MPWS/PWS</font> </html:option>
			<html:option value="06"><font class="myfontclr1">DP</font> </html:option>
			<html:option value="02"><font class="myfontclr1">HandPumps</font> </html:option>
			<html:option value="03"><font class="myfontclr1">Open Wells</font> </html:option>
			<html:option value="04"><font class="myfontclr1">Shallow Handpumps</font> </html:option>
			<%-- <html:option value="07"><font class="myfontclr1">Spring's</font> </html:option> --%>
			
			</html:select>
	</td>	
	<td  align="left"><input type=button value=Assets id="hBtn" onClick="fngetAssets();" class="btext"></td>
	</tr>
	
	

		
		</table>
		
		
		<table width="1500"
		border=1 style="border-collapse: collapse;">
<tr >
	<td class="btext" align="center" rowspan="2">S.No</td>
	<td class="btext" align="center" rowspan="2">Source Code/<br>Asset Name/<br>Location/<br>Source Type</td>	 
	<td class="btext" align="center" rowspan="2">Status</td>
	<td class="btext" align="center" rowspan="2">Repair<br>Date</td>
	<td class="btext" align="center" rowspan="2">Repair<br>Description</td>
	<td class="btext" align="center" rowspan="2">Source<br>Details</td>
	<td class="btext" align="center" rowspan="2"><font color="red"><b>*</b></font>Safe<br>Yield(LPD)</td>
	<td class="btext" align="center" rowspan="2"><font color="red"><b>*</b></font>UnSafe<br>Yield(LPD)</td>	
	<td class="btext" align="center" rowspan="2" >Yield(LPM)<br>As Per Asset Entry</td>
	<td class="btext" align="center" rowspan="2" >Static Water</td>
	<td class="btext" align="center" rowspan="2" >Summer Water</td>
	<td class="btext" align="center" rowspan="2" >PlatForm Existing</td>
	<td class="btext" align="center" rowspan="2" >SAOK PITS</td>
	
	<td class="btext" align="center" colspan="3" >GPS</td>
	<td class="btext" align="center" colspan="5" >Quality Effected Parameter<br></br>Water Quality Test Results</td>
	<td class="btext" align="center" rowspan="2">Update<br>Date</td>
	<td class="btext" align="center" rowspan="2" >Remarks</td>
	
	<td class="btext" align="center" rowspan="2">Select</td>	
	</tr>
	
	<tr>	
	<td class="btext" align="center"><font color="red"><b>*</b></font>Latitude</td><td class="btext" align="center"><font color="red"><b>*</b></font>Longitude</td><td class="btext" align="center"><font color="red"><b>*</b></font>Elevation</td>
	<td class="btext" align="center" >FLOURIDE</td>
	<td class="btext" align="center" >BRAKISH </td>	  
	<td class="btext" align="center" >IRON </td>
	<td class="btext" align="center" >NITRATE </td>
	<td class="btext" align="center" >Latest<br>TestDate </td>
	
	
	
	</tr>
	<%
  int count=1;
%>
	<logic:notEmpty name="HabNewEntry" property="habs">
	<logic:iterate id="habs" name="HabNewEntry" property="habs" indexId="index">
	
	
  	
 
	
	
	<tr align="center" id='tr<%=count%>' onclick="changeColor(this)";>
		<td class="rptValue"><%=count++%></td>
		<nested:hidden name="habs" property="hpCode"  indexed="true" />
		<html:hidden name="habs" property="assetCode" indexed="true" />
		<td  class="rptValue" ><bean:write name="habs" property="hpCode" />/<br><bean:write name="habs" property="assetName" />/<br>
		<bean:write name="habs" property="location" />/<br>
		<bean:write name="habs" property="sourceTypeName" />
		
		</td>
			<td  align="center" >
			<html:select name="habs" property="status"  indexed="true" styleId="statusn" styleClass="mycombo"  style="width: 80px" >										
			<html:option value="">Select</html:option>
			<html:option value="W">WORKING</html:option>
			<html:option value="N">NOT WORKING</html:option>
			<html:option value="D">DRIED</html:option>
			<html:option value="S">SEASONAL</html:option>
			<html:option value="C">CONDEMED</html:option>				
			</html:select>
		</td>
		<td><html:text name="habs" property="repairdate"  styleId="repairdaten" indexed="true"  onkeypress="return decimalsOnly(event)" style="width: 70px" />
		<a href="javascript:showCalendar(document.getElementById('habs[<%=count-2%>].repairdate'));">
        
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>
		
		
		<td><html:text name="habs" property="repairdesc" styleId="repairdescn" indexed="true" style="width: 70px" readonly="false" onmouseover="Tip(this.value,TITLE,'Repair Description')"  onmouseout="UnTip()" /></td>
		
		
		<td  align="center" >
			<html:select name="habs" property="sourcedetails"  indexed="true" styleClass="mycombo"  style="width: 80px">										
			<html:option value="">Select</html:option>
			<html:option value="Surface">Surface</html:option>
			<html:option value="SubSurface">SubSurface</html:option>
						
			</html:select>
		</td>
		
		<td><html:text name="habs" property="safeLpd"  indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>' maxlength="7" size="4" /></td>
		<td>
		<html:text name="habs" property="unSafeLpd" indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>'  maxlength="7" size="4"/> </td>
		
		<td class="rptValue">		
		
		<html:text name="habs" property="yield" indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>'  maxlength="7" size="4"/>
											
		</td>
		
		
		<td class="rptValue">		
		
		<html:text name="habs" property="staticDpth" indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>'  maxlength="7" size="4"/>
											
		</td>
		
		<td class="rptValue">		
		
		<html:text name="habs" property="summerDpth" indexed="true"  onkeypress="return decimalsOnly(event)" onblur='<%="return checkDisable("+(count-2)+")"%>'  maxlength="7" size="4"/>
											
		</td>
		
		<td align="center" >							
			<html:select name="habs" property="platformexistng" indexed="true" styleClass="mycombo" >
			<html:option value="">SELECT</html:option>										
			<html:option value="Y">Yes</html:option>
			<html:option value="N">No</html:option>						
		</html:select>						
		</td>
		<td align="center" >							
			<html:select name="habs" property="SOAKPIT" indexed="true" styleClass="mycombo" >
			<html:option value="">SELECT</html:option>											
			<html:option value="Y">Yes</html:option>
			<html:option value="N">No</html:option>						
		</html:select>						
		</td>
			
			
		
		<td>
				<html:text name="habs" property="latitude" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>	
		</td>
		
		<td>			
				<html:text name="habs" property="longitude" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>			
		</td>
				
		<td>			
				<html:text name="habs" property="elevation" indexed="true" onkeypress="return decimalsOnly(event)" maxlength="7" size="4"/>			
		</td>
		
		<td align="center" style="display: none;">							
			<html:select name="habs" property="qualityAffected" indexed="true" styleClass="mycombo" >										
			<html:option value="Y">Yes</html:option>
			<html:option value="N">No</html:option>						
		</html:select>						
		</td>
		
		<td class="rptValue">
			<html:text property="flouride" name="habs" indexed="true" onkeypress="return decimalsOnly(event)"  onblur='<%="return validateFl("+(count-2)+")"%>' maxlength="4" size="4"></html:text>
			
			<font color="red"><b>(<bean:write name="habs" property="flourideContamination" />)</b></font>	
		</td>
		<td class="rptValue">
			<html:text property="brakish" name="habs" indexed="true" onkeypress="return numeralsOnly(event)" onblur='<%="return validateBr("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		
		<font color="red"><b>(<bean:write name="habs" property="brakishContamination" />)</b></font>
		
		</td>
		<td class="rptValue">
			<html:text property="iron" name="habs" indexed="true" onkeypress="return decimalsOnly(event)" onblur='<%="return validateIr("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		
		<font color="red"><b>(<bean:write name="habs" property="ironContamination" />)</b></font>	
		
		</td>
		<td class="rptValue">
			<html:text property="nitrate" name="habs" indexed="true" onkeypress="return numeralsOnly(event)" onblur='<%="return validateNit("+(count-2)+")"%>' maxlength="4" size="4"></html:text>	
		<font color="red"><b>(<bean:write name="habs" property="nitrateContamination" />)</b></font>
		
		</td>
		
		<td class="rptValue">
			<html:text property="testdate" name="habs" indexed="true" style="width: 100px"  onkeypress="return numeralsOnly(event)" maxlength="4" size="4"></html:text>	
	
		
		</td>
		  <td class="rptValue">
		  <html:text name="habs" property="date" indexed="true" readonly="true"  style="width: 70px" onkeypress="return decimalsOnly(event)"/>
	<!--  <a href="javascript:showCalendar(document.getElementById('habs[<%=count-2%>].date'));">
        
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a></td>-->
		
		
				<td>			
				<html:text name="habs" property="remarks" indexed="true"  style="width: 70px" maxlength="50" />			
		</td>				
		<td>			
		<html:checkbox name="habs" property="checks" indexed="true" onclick='<%= "check(" + index + ")" %>' />
		</td>		
	</tr>
	
	</logic:iterate>
	</logic:notEmpty>
	<%if(count==1)
		{
		%><tr><td colspan="22" align="center" class="btext">No Records</td></tr><%}
		else{%><tr><td colspan="22" align="center">
		
		 <input type=button value=Save id="sBtn" onClick="fnSave();" class="btext" > 
		 <!-- <input type=button value=Save id="sBtn" onClick="fnSave();" class="btext" disabled="disabled">  -->
		<%-- <html:submit id="sBtn"  value="Save"  onClick="fnSave();" disabled="true"  class="btext"/>  --%>
		
		</td></tr><%}%>
		<input type="hidden" name="resultCount" value="<%=count%>"/>
	
	
	</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1500" />
</jsp:include>

<input type=hidden name=yields>
<input type=hidden name=repairdesc>
</html:form>

<table>
<tr>
<td><font color="red"><b>Note1:</b></font></td><td class="rptValue"><font color="green"><b>LPD(Liter Per Day)</b></font></td></tr>
<tr>
<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="green"><b>LPM(Liter Per Minute)</b></font></td>
</tr>
<tr>
<td colspan="2" class="rptValue"><font color="green"><b>(-)Indicates the Latest  Water Quality Test Results On That Source</b></font></td>
</tr>
<tr>
<td><font color="red"><b>Note2:</b></font></td><td class="rptValue"><font color="green"><b>1.For CPWS  Select District only Then Click on Assets Button</b></font></td></tr>
<tr>
<td colspan="2" class="rptValue"><font color="green"><b>2.For MPWS/PWS,HANDPUMPS,OPENWELLS,SHALLOW HANDPUMPS,Direct Pumping Select up to Habitation</b></font></td>
</tr>



</table>  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

