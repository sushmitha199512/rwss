<%@taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="empForm" />
<script language="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=data";
	document.forms[0].submit();
}
function getData1()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=get1";
	document.forms[0].submit();
}
function getData2()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=get2";
	document.forms[0].submit();
}

function verifyDoA()
{
	
	var earlierdate = document.getElementById("dob").value;
	var laterdate = document.getElementById("appointdate").value; 
	if(earlierdate!="" || laterdate!="")
	{
	//laterdate
	var age=getNoOfYears(laterdate,earlierdate);
	//alert("earlierdate" + earlierdate);
	if(age<18)
	{
		
		alert("Appointment date should be greater than date of birth");
		document.getElementById("appointdate").value="";
 	    //document.getElementById("dob").value="";
	}
	}
}
function showAge(){ 
	var d =document.getElementById('dob').value.split('/'); 
	var today=new Date();
	var bday=new Date(d[2],d[1],d[0]); 
	var by=bday.getFullYear(); 
	var bm=bday.getMonth()-1; 
	var bd=bday.getDate();

	var age=0; var dif=bday; 
	while(dif<=today){ 
	var dif = new Date(by+age,bm,bd); 
	age++; 
	} 
	age +=-2 ; 
	if(age<18)
	{
	alert("The age as on shoud be above 18yrs");
	document.getElementById("appointdate").value="";
	document.getElementById("dob").value="";
	}
	
} 

function verifyDoj()
{
	var earlierdate = document.getElementById("appointdate").value;
	var laterdate = document.getElementById("doj").value; 
	
	var yrs=getNoOfYears(laterdate,earlierdate);
	var months=getNoOfMonths(laterdate,earlierdate);
	var days=getNoOfDays(laterdate,earlierdate);
	if(days<=0 && months<=0 && yrs<=0)
	{
		alert("The Date Of Joining should be greater than date of appointment");
		document.getElementById("doj").value="";
	}
}
function verifyPostDate()
{
	var earlierdate = document.getElementById("doj").value;
	var laterdate = document.getElementById("currentpostdate").value; 
	var yrs=getNoOfYears(laterdate,earlierdate);
	var months=getNoOfMonths(laterdate,earlierdate);
	var days=getNoOfDays(laterdate,earlierdate);
	if(days<=0 && months<=0 && yrs<=0)
	{
		alert("The currentpostdate should be greater than Date Of Joining");
		document.getElementById("currentpostdate").value="";
	}
}
function disable()
{
	if(document.empForm.desig[0].checked)
	{	 //document.empForm.desgnCode.disabled=true;
	     //document.empForm.tempdesgCode.disabled=false;
	     document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=data";
	     document.forms[0].submit();
	}
	else if(document.empForm.desig[1].checked)
	{
		//document.empForm.desgnCode.disabled=true;
		document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=data";
		document.forms[0].submit();
	}
	else if(document.empForm.desig[2].checked)
	{
		//document.empForm.desgnCode.disabled=true;
		document.forms[0].action="switch.do?prefix=/masters&page=/Employee.do?mode=data";
		document.forms[0].submit();
	}
//document.empForm.tempdesgCode.disabled=true;	
}
function dacc()
{
	if(document.empForm.testpassed[1].checked)
	{
	hidediv('a1');
	hidediv('a2');
	}
	else 
	{
	showdiv('a1');
	showdiv('a2');
	}
}

function empp()
{
	if(document.empForm.spouseemployd[1].checked)
	{
	hidediv('b1');
	hidediv('b2');
	}
	else 
	{
	showdiv('b1');
	showdiv('b2');
	}
}


	function hidediv(id) {
		//safe function to hide an element with a specified id
		document.getElementById(id).style.display = 'none';
		document.empForm.dacctest.value="";
		}
	function showdiv(id) {
			//safe function to hide an element with a specified id
			document.getElementById(id).style.display = 'block';
     }
	function show() {
			//safe function to hide an element with a specified id
			document.empForm.testpassed[0].checked= true;
			}	
	function dacc1()
		{
			if(document.empForm.deputation[1].checked)
			{
			
			hidediv('a3');
			
			}
			else 
			{
			
			showdiv('a3');
			}
		}		
	function dacc2()
		{
			if(document.empForm.disciplinecase[1].checked)
			{
			//hidediv('a6');
			hidediv('a7');
			}
			else 
			{
			//showdiv('a6');
			showdiv('a7');
			}
		}		
function todaydate()
{
	var today=new Date();
	var year = today.getYear()
    var dt = today.getDate()
    var mnth = today.getMonth()+1
	
    if (dt< 10) dt = ("0" + dt);
	if (mnth< 10) mnth = ("0" + mnth);
	
	  if(year < 1000){
	    year += 1900
	    }
	  
  document.getElementById("updatedate").value = dt + "/" + mnth +  "/" + (year+"").substring(2,4);
}

function dacc3() {
	//safe function to hide an element with a specified id
	var choice = document.empForm.section.selectedIndex;
	//alert(choice);
    if(choice=='1')
    {
    	showdiv('a4');
    }
    else
    {
    	hidediv('a4');
    }
}
function init()
{
toggleItem('collapse_myTbody2');
}
function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}
function getRwsCode()
{
var ocode=document.getElementById("hoc").value+document.getElementById("coc").value+document.getElementById("doc").value+document.getElementById("sdoc").value;
document.getElementById("roc").value = ocode;
}


function toggleItem(id)
{   
    itm = getItem(id);
    if(id=="collapse_myTbody2")
      var im = "onea";
    else
       var im = "oneb";
    if(!itm)
        return false;
    if(itm.style.display == 'none'){
        itm.style.display = '';
        if (document.images[im]) {
		document.images[im].src = "../images/collapse.gif";
	    }
    }    
    else{
	      itm.style.display = 'none';
	      if (document.images[im]) {
		document.images[im].src = "../images/expand.gif";
	   }
    }	      

    return false;
}


//-->
</script>

<!-- <body onload="javascript:init();javascript:getRwsCode();javascript:show();javascript:todaydate();">-->
<%@ include file="/commons/rws_header2.jsp" %>
<body onload="javascript:init();javascript:getRwsCode();javascript:show();javascript:todaydate();">
<html:form action="Employee.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Employee Entry Form" />
	<jsp:param name="TWidth" value="740" />
	<jsp:param name="contextHelpUrl" value="./help/Help For PRED.doc" />
</jsp:include>

<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="760" align="center">
<tr>
<td>
	<fieldset>
	<legend>Employee Personal Details</legend>
	<label>
		
	<table border=0 width="770" align=center >
	<tr>
		<td class="textborder"><bean:message key="app.empcode"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;<html:text property="empcode" styleClass="mytext" style="width:60px" maxlength="5" onkeypress="return numeralsOnly(event)"/>
		<html:hidden property="empcode"/>
		</td>
		</tr>
		
		<tr>
		<td class="textborder"><bean:message key="app.empsurname1"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="surname"  styleClass="mytext" size="25" maxlength="30"  onkeypress="return alpha(event)"/>
		<html:hidden property="surname" />
		</td>
		<td class="textborder"><bean:message key="app.empname"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <html:text property="empname" styleClass="mytext" size="25" maxlength="30" onkeypress="return alpha(event)"/>
		</td>																																	
		</tr>
		
		<tr>
		<td class="textborder"><bean:message key="app.gender1"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:radio property="gender" value="M">Male</html:radio>
		<html:radio property="gender" value="F">Female</html:radio>
		</td>
		<td class="textborder"><bean:message key="app.wife"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;<html:text property="relation" styleClass="mytext" size="25" maxlength="30" onkeypress="return alpha(event)"/>
		</td>
		</tr>
	
		<tr>
		<td  class="textborder"><bean:message key="app.dob"/><font color="#FF6666">*</font>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="dob" styleClass="mytext" style="width:120px" readonly="true" />
		<a href="javascript:showCalendar(document.empForm.dob);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a>
		</td>
		<td class="textborder"><bean:message key="app.religion"/><font color="#FF6666">*</font>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:select property="religion" styleClass="mycombo" style="width:130px">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		   <logic:present name="religions">
		    <html:options collection="religions" name="rwsMaster" property="relgCode" labelProperty="relgNoName" />
		    </logic:present>
			</html:select>
		</td>
		</tr>
	
		<tr>
		<td  class="textborder"><bean:message key="app.social"/><font color="#FF6666">*</font>
			&nbsp;&nbsp;&nbsp;<html:select property="social" styleClass="mycombo" style="width:130px">
			<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		    <logic:present name="castes">
		    <html:options collection="castes" name="rwsMaster" property="casteCode" labelProperty="casteNoName" />
		    </logic:present>
		    </html:select>
		</td>
		<td class="textborder"><bean:message key="app.ndistrict"/><font color="#FF6666">*</font>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<html:select property="ndist" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			 <logic:present name="districts">
			<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
		</tr>
			
		<tr>
		<td class="textborder"><bean:message key="app.nmandal"/><font color="#FF6666">*</font>
		    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:select property="nmand" styleClass="mycombo" style="width:130px" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			 <logic:present name="mandals">
			<html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select>
		</td>
		<td class="textborder">Native Revenue Division
			&nbsp;&nbsp;<html:text property="nrevenue" styleClass="mytext" size="25" maxlength="15" onkeypress="return alpha(event)"/>
		</td>
		</tr>
		
		<tr>
		<td class="textborder"><bean:message key="app.qual"/><font color="#FF6666">*</font>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:select property="qual" style="width:130px" styleClass="mycombo">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="qualcodes">
			<html:options collection="qualcodes" name="rwsMaster" property="qualCode" labelProperty="qualNoName" />
			</logic:present>
			</html:select></td>
		<td class="textborder">Physically Challenged&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<html:radio property="handicap" value="Y">Yes</html:radio>
		<html:radio property="handicap" value="N">No</html:radio>
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
<!-- **************************************************************-->

<fieldset>
<label>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
  <tbody>
  <tr>
   <td  bgcolor="#8A9FCD">
	<div onclick="return toggleItem('collapse_myTbody2')" style="cursor:hand">
	<img style="WIDTH:13px; HEIGHT:11px" src="/images/expand.gif" name="onea">
	<font  style="font-family:verdana; font-size:8pt;font-weight:bold; color:#000000">&nbsp;Spouse Details</font></div>	
	</td>
	</tr>
	</tbody>
    <tbody class="collapse_obj" id="collapse_myTbody2" style="display:none">
	<tr>
    <td>
	<table width="100%" border=0>
	<tr>
		<td class="textborder"><bean:message key="app.semployed"/>&nbsp;<font color="#FF6666">*</font>
		<html:radio property="spouseemployd" value="Y" onclick="javascript:empp();">Yes</html:radio>
		<html:radio property="spouseemployd" value="N" onclick="javascript:empp();">No</html:radio>
		</td>
	</tr>	
	<tr>
		<td id='b1' class="textborder">Working&nbsp;
		<html:radio property="spouseworking" value="S">State</html:radio>
		<html:radio property="spouseworking" value="C">Central</html:radio>
		<html:radio property="spouseworking" value="P">PSU</html:radio>
		</td>
		</tr>
			
		<tr>
		<td id='b2' class="textborder">District&nbsp;
		<html:select property="spouseworkdist" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		</html:select>
		Mandal&nbsp;		
		<html:select property="spouseworkmand" styleClass="mycombo" style="width:130px" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		     <logic:present name="mandals">
		    <html:options collection="mandals" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		</html:select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Revenue Division<html:text property="spouseworkdiv" styleClass="mytext" maxlength="15" onkeypress="return alpha(event)"/>
		</td>
	</tr>	
	</table>
</td>
</tr>
  </tbody>
 </table>
 </label>
 </fieldset>
		<!-- ***************************************************************-->
		<fieldset>
		<legend>Education Details</legend>
		<label><table  border=0  width="770"  align=center  style="margin-bottom:0;margin-top:0">
		<tr>
		<td  class="textborder" nowrap>District Studied</td>
		</tr>
		<tr>
		<td  class="textborder">Class IV
		
			<html:select property="diststudied4" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
			 <logic:present name="districts">
			<html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
		    </html:select>
		</td>
		<td  class="textborder" >Class V
		
			<html:select property="diststudied5" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		     <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		<td  class="textborder" >Class VI
		
			<html:select property="diststudied6" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		     <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		
		<td  class="textborder" >Class VII
		
			<html:select property="diststudied7" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()" >
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		
		
		<td  class="textborder" >Class VIII
		
			<html:select property="diststudied8" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		<tr>
		<td  class="textborder" >Class IX
		
			<html:select property="diststudied9" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		
		<td  class="textborder" >Class X
		
			<html:select property="diststudied10" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		
		<td  class="textborder" nowrap>Local Districts<br> As Per Schools</td>
		<td  class="textborder">
			<html:select property="localdist" styleClass="mycombo" style="width:130px" onchange="javascript:getData1()">
			<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		     <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		    </logic:present>
		    </html:select>
		</td>
		<td  class="textborder">Local Zone
		<html:select property="localzone" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		 <logic:present name="zonecodes">
		<html:options collection="zonecodes" name="rwsMaster" property="zoneCode" labelProperty="zoneName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class="textborder"  >No Of Years Studied in District from VI to X</td>
		<td  class="textborder" >
		<html:text property="noofyrs"  styleClass="mytext" style="width:80px" onkeypress="return numeralsOnly(event)"/>
		<html:hidden property="noofyrs"  />
		</td>
		<td  class="textborder" cellspacing=1>No Of Years Studied in Zone from VI To X</td>
		<td  class="textborder" >
		<html:text property="noofyrs1"  styleClass="mytext" style="width:80px" onkeypress="return numeralsOnly(event)"/>
		<html:hidden property="noofyrs1"  />
		</td>
		</tr>
		<tr>
		<td  class="textborder" >InCase Of Private Passing(District)</td>
		<td  class="textborder">
			<html:select property="pvtdist" styleClass="mycombo" style="width:130px">
			<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		    <logic:present name="districts">
		    <html:options collection="districts" name="labelValueBean" property="value" labelProperty="label" />
		   </logic:present>
		    </html:select>
		</td>
		
		<td class="textborder">InCase Of Private Passing(Zone)</td>
		<td  class="textborder">
			<html:select property="pvtzone" styleClass="mycombo" style="width:130px" >
			<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		    <logic:present name="zonecodes">
		    <html:options collection="zonecodes" name="rwsMaster" property="zoneCode" labelProperty="zoneName" />
		    </logic:present>
		    </html:select>
		</td>
		</tr>
		</table>
		</label></fieldset>
		
	
		
		<fieldset>
		<legend>Employment Details</legend>
		<label>
	    <table  border=0 cellspacing=0 width="770"  align=center  style="margin-bottom:0;margin-top:0">
		<tr>
		<td class="textborder" nowrap><bean:message key="app.desig" /><font color="#FF6666">*</font>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="textborder"><html:radio property="desig" value="P"  onclick="javascript:disable();">Permanent</html:radio></td>
		<td class="textborder"><html:radio property="desig" value="T" onclick="javascript:disable();">Temporary</html:radio></td>
		<td class="textborder"><html:radio property="desig" value="W" onclick="javascript:disable();">WorkCharged</html:radio></td>
		</tr>
		
		<tr>
		<td class="textborder" nowrap><bean:message key="app.desgnCode" /><font color="#FF6666">*</font></td>
		<td><html:select property="desgnCode" style="width:150px" styleClass="mycombo" onchange="javascript:getData()">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="desgns">
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnName" />
		</logic:present>
		</html:select>
		</td>
		<td  class="textborder" nowrap><bean:message key="app.apptcategory" /></td> 
		<td><html:select property="apptcategory" style="width:130px" styleClass="mycombo" onchange="javascript:getData()">
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<html:option value="T">Technical</html:option>
		<html:option value="M">Min</html:option>
		<html:option value="L">LastGrade</html:option>
		<html:option value="O">Others</html:option>
		</html:select></td>
		</tr>
		<tr>
		<td  class="textborder"><bean:message key="app.appointdate" /><font color="#FF6666">*</font></td>
		<td  class="textborder">
			<html:text property="appointdate"  styleClass="mytext" style="width:80px" readonly="true" />
			<a href="javascript: showCalendar(document.empForm.appointdate);">
			<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		
		<td  class="textborder"><bean:message key="app.doj" /><font color="#FF6666">*</font></td>
		<td  class="textborder">
			<html:text property="doj"  styleClass="mytext" style="width:80px" readonly="true"  />
			<a href="javascript:showCalendar(document.empForm.doj);">	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		</td>
		</tr>
		<tr>
		<td  class="textborder" nowrap><bean:message key="app.moap" /><font color="#FF6666">*</font></td>
		<td  class="textborder">
		<html:select property="moap" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="modes">
		<html:options collection="modes" name="rwsMaster" property="moapCode" labelProperty="modeNoName" />
		</logic:present>
		</html:select></td>
		<td  class="textborder">
		<bean:message key="app.zone" /><font color="#FF6666">*</font></td>
		<td  class="textborder">
		<html:select property="zone" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="zonecodes">
		<html:options collection="zonecodes" name="rwsMaster" property="zoneCode" labelProperty="zoneName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		<tr>
		<td  class="textborder">
		<bean:message key="app.narecruit" /><font color="#FF6666">*</font>
		</td>
		<td  class="textborder">
		<html:select property="narecruit" style="width:130px" styleClass="mycombo" >
		<html:option value="">SELECT...</html:option>
		<html:option value="L">Local</html:option>
		<html:option value="N">Non-Local</html:option>
		</html:select>
		</td>
		<td  class="textborder"><bean:message key="app.apcatog" /><font color="#FF6666">*</font></td>
		<td  class="textborder">
		<html:select property="apcatog" style="width:130px" styleClass="mycombo" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="catcodes">
		<html:options collection="catcodes" name="rwsMaster" property="catCode" labelProperty="catNoName" />
		</logic:present>
		</html:select>
		</td>
		</tr>
		</table>
		</label>
		</fieldset>
		
		<fieldset>
		<legend>Service Details</legend>
		<label>
	    <table  border=0  width="760"  align=center  style="margin-bottom:5;margin-top:0">
		
		<tr>
		<td class="textborder"> <bean:message key="app.dcommprob"/><!--Date Of <br>Commencement <br>of Probation--><font color="#FF6666">*</font>
		<html:text property="dcommprob" styleClass="mytext" style="width:80px" readonly="true"/>
		<a href="javascript:showCalendar(document.empForm.dcommprob);">
		<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a>
		</td>
		
		<td class="textborder"><bean:message key="app.ddeclprob"/><!--Date Of <br>Declaration <br>of Probation--><font color="#FF6666">*</font>
		<html:text property="ddeclprob"  styleClass="mytext" style="width:80px" readonly="true"/>
		<a href="javascript: showCalendar(document.empForm.ddeclprob);">	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		
		<td  class="textborder"> <bean:message key="app.currentpostdate" /><!--Date of <br>Joining in<br>Present Post--><font color="#FF6666">*</font>
		<html:text property="currentpostdate"  styleClass="mytext" style="width:80px" readonly="true" />
		<a href="javascript: showCalendar(document.empForm.currentpostdate);">	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		
		<td  class="textborder">Date of <br>Promotion to <br>Present Designation
		<html:text property="promotedate"  styleClass="mytext" style="width:80px" readonly="true" />
		<a href="javascript: showCalendar(document.empForm.promotedate);">
	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		</tr>
	
		<tr>
		<td class="textborder">A/c's Test Passed</td>
		<TD class="textborder"><html:radio property="testpassed" value="Y" onclick="javascript:dacc();">Yes</html:radio>
		<html:radio property="testpassed" value="N" onclick="javascript:dacc();">No</html:radio></td>	
		<td id='a1' class="textborder"><bean:message key="app.dacctest" /></td>
		<td  id='a2' class="textborder">
		<html:text property="dacctest" styleClass="mytext" style="width:80px" readonly="true" />
		<a href="javascript:showCalendar(document.empForm.dacctest);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		</tr>
		<tr>
		</tr>
		
		<tr>
		<td  class="textborder" nowrap><bean:message key="app.addqual1" /></td>
		<td  class="textborder">
		<html:select property="addqual1" style="width:110px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="qualcodes">
		<html:options collection="qualcodes" name="rwsMaster" property="qualCode" labelProperty="qualNoName" />
		</logic:present>
		</html:select></td>
		
		<td  class="textborder" nowrap><bean:message key="app.addqual2" /></td>
		<td  class="textborder">
		<html:select property="addqual2" style="width:110px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="qualcodes">
		<html:options collection="qualcodes" name="rwsMaster" property="qualCode" labelProperty="qualNoName" />
		</logic:present>
		</html:select></td>
		</tr>

		<tr>
		<td  class="textborder" nowrap>Present Designation</td>
		<td  class="textborder">
		<html:select property="presentdesig" style="width:110px" styleClass="mycombo"  >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="desgns">
		<html:options collection="desgns" name="rwsMaster" property="desgnCode" labelProperty="desgnName" />
		</logic:present>
		</html:select></td>
		
		<td  class="textborder" nowrap><bean:message key="app.workSpecial" /></td>
		<td  class="textborder">	
		<html:select property="workSpecial" style="width:110px" styleClass="mycombo" onkeypress="return alpha(event)">
		<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
		<logic:present name="workSpecs">		
		<html:options collection="workSpecs" name="rwsMaster" property="workSpecCode" labelProperty="workSpecNoName" />
		</logic:present>
		</html:select></td>
		
		<td  class="textborder">Other Details</td>
		<td  class="textborder" >
		<html:text property="otherDet"  styleClass="mytext" style="width:140px" onkeypress="return alpha(event)"/></td>
		</tr>
	
		</table>
		</label>
		</fieldset>
	
		<fieldset>
		<legend>Working At</legend>
		<label>
		<table  border=0  width="770"  align=center>

		<tr>
    		<td class="textborder"><bean:message key="app.sector"/><font color="#FF6666">*</font>
			<html:select property="hoc" styleClass="mycombo" style="width:130px" onchange="javascript:getData()" >
			<html:option value="0">SELECT...</html:option>
			<logic:present name="heads">
			<html:options collection="heads" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select></td>
	
		<td class="textborder" >Circle
			<html:select property="coc" style="width:130px" styleClass="mycombo" onchange="javascript:getData()" >
			<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
			<!-- <html:option value="00"><font class="myfontclr1">ENC</html:option>-->
			<logic:present name="circlecodes">
			<html:options collection="circlecodes" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select></td>
	
		<td  class="textborder" >Division
			<html:select property="doc" style="width:130px" styleClass="mycombo" onchange="javascript:getData()" >
			<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
			<!-- <html:option value="0"><font class="myfontclr1">CIRCLEOFFICE</html:option>-->
			<logic:present name="divcodes"><html:options collection="divcodes" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select></td>
	
		<td  class="textborder" >SubDivision
			<html:select property="sdoc" styleClass="mycombo" style="width:130px" onchange="javascript:getData()">
			<html:option value="00"><font class="myfontclr1">SELECT...</html:option>
			<!-- <html:option value="00"><font class="myfontclr1">DIVISIONOFFICE</html:option>-->
			<logic:present name="subdivcodes">
			<html:options collection="subdivcodes" name="labelValueBean" property="value" labelProperty="label" />
			</logic:present>
			</html:select></td>

    	<td  class="textborder" >Section
			<html:select property="section" styleClass="mycombo" style="width:130px" value="1" onchange="javascript:dacc3()">
			<html:option value="1"><font class="myfontclr1">SPL/PROJECT</html:option>
			</html:select></td>
		</tr>
		<tr>
		</tr>
		<tr>
		<td  class="textborder"><bean:message key="app.roc" /></td>
		<td  class="textborder">
		<html:text property="roc"  styleClass="mytext" readonly="true" style="width:100px" onfocus="javascript:getRwsCode()"/></td>
    
		<td  class="textborder">DeptOpted</td>
		<td  class="textborder"><html:radio property="dept" value="PR" onclick="javascript:dacc2();">PR</html:radio>
			<html:radio property="dept" value="RWS" onclick="javascript:dacc2();">RWS</html:radio></td>
		</TR>
	
	  <TR>
	
        <td class="textborder">Deputation</td>
		<TD class="textborder"><html:radio property="deputation" value="Y" onclick="javascript:dacc1();">Yes</html:radio>
		<html:radio property="deputation"  value="N" onclick="javascript:dacc1();">No</html:radio></td>
	
		<td  id="a3" class="textborder" >Deputation Date(From)
		<TD class="textborder"><html:text property="deputationDate" styleClass="mytext" style="width:100px" readonly="true" />
		<a href="javascript:showCalendar(document.empForm.deputationDate);">	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		
		<td  class="textborder">Seniority
		<html:text property="seniority" styleClass="mytext" style="width:130px" onkeypress="return alpha(event)"/></td>
    
	</tr>
	
	<TR>
		
        <td class="textborder">Disciplinary Case</td>
		<TD class="textborder"><html:radio property="disciplinecase" value="Y" onclick="javascript:dacc2();">Yes</html:radio>
		<html:radio property="disciplinecase"  value="N" onclick="javascript:dacc2();">No</html:radio></td>
	
		<td class="textborder" id="a7">Disciplinary Type</td>
		<td><html:select property="disciplinetype" style="width:130px" styleClass="mycombo" >
		<html:option value="">SELECT...</html:option>
		<html:option value="V">Vig</html:option>
		<html:option value="A">ACB</html:option>
		<html:option value="Q">QC</html:option>
		<html:option value="O">Others</html:option>
		</html:select></td>
		</tr>
	
	<tr>
		<td class="textborder">Long Leave/Suspend</td>
		<TD class="textborder"><html:radio property="leavesuspend" value="L" >Long Leave</html:radio>
		<html:radio property="leavesuspend"  value="S" >Suspend</html:radio></td>
	
		<td  class="textborder">Leave/Suspension Date</td>
		<td><html:text property="leavedate" styleClass="mytext" style="width:100px" readonly="true" />
		<a href="javascript:showCalendar(document.empForm.leavedate);">	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
	
		<td  class="textborder">Deputation Dept
		<html:text property="depudept" styleClass="mytext" style="width:130px" onkeypress="return alpha(event)"/></td>
	</tr>

</table>
</label>
</fieldset>
<fieldset>
		<legend>Other Details</legend>
		<label>
	    <table  border=0  width="760"  align=center  style="margin-bottom:5;margin-top:0">
		
	<tr>
		<td  class="textborder">Pan No</td>
		<td  class="textborder">
		<html:text property="panno"  styleClass="mytext" style="width:130px" maxlength="10" onkeypress="return textOnly(event)" /></td>

		<td  class="textborder">APGLI No</td>
		<td  class="textborder">
		<html:text property="apgli"  styleClass="mytext" style="width:130px" onkeypress="return textOnly(event)"/></td>

		<td  class="textborder">GPF No</td>
		<td  class="textborder">
		<html:text property="gpfno"  styleClass="mytext" style="width:130px" maxlength="10" onkeypress="return textOnly(event)" /></td>
	</tr>

	<tr>
		<td class="textborder">Pay Scale</td>
		<td class="textborder">
		<html:text property="payscale" styleClass="mytext" style="width:130px" onkeypress="return textOnly(event)" />
		</td>

		<td class="textborder">Date Of Increment</td>
		<td class="textborder">
		<html:text property="incrementdate" styleClass="mytext" style="width:80px" readonly="true" />
		<a href="javascript: showCalendar(document.empForm.incrementdate);">
		<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle" ></a></td>
		
		<td  class="textborder"><html:hidden property="updatedate"/></td>
	</tr>

		</table>
		</label>
		</fieldset>

	<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="showAge();verifyDoA();verifyDoj();return validateEmpForm(empForm);" />
    	<html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
		<html:submit property="mode" title="View the Fields" styleClass="btext" value="View"  />
	 </td>
	</tr>
	
</table>
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="740"/>
</jsp:include>
</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
