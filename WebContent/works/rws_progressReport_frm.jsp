<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<%int count=0; %>
<head>
<META Http-Equiv="Cache-Control" Content="no-cache">
<META Http-Equiv="Pragma" Content="no-cache">
<META Http-Equiv="Expires" Content="0"> 

<script language="javascript">
//this array contains all elements
var allElementsList=new Array("programmeCode","planNonPlan","catagory",
"openingBalance","obReleaseTotal","totalWorksNo","totalWorksCost","totalWorksHabs",
"release","duringTheMonth","spillOverWorksNo",
"spillOverWorksBalCost","commitment","spillOverWorksBalHabs",
"spillOverWorksBalIpPh1Habs","newWorksNo","newWorksCost",
"newWorksTotalHabs","newWorksIpPh1Habs","newWorksIpPh2Habs","totalWorksIpHabs",
"progressEntrusted","progressGrounded","completedWorks",
"completedCoveredHabs","completedIpPh1Habs","completedIpPh2Habs");

//this array contains only those elements for which tab is allowed
var elementsList=new Array("programmeCode","planNonPlan","catagory","release","duringTheMonth","spillOverWorksNo",
"spillOverWorksBalCost","commitment","spillOverWorksBalHabs",
"spillOverWorksBalIpPh1Habs","newWorksNo","newWorksCost",
"newWorksTotalHabs","newWorksIpPh1Habs","newWorksIpPh2Habs",
"progressEntrusted","progressGrounded","completedWorks",
"completedCoveredHabs","completedIpPh1Habs","completedIpPh2Habs");



function getIndex(prefix,element,index)
{
	elementPrefix=prefix+"["+index+"].";
	for(var i=0;i<elementsList.length;i++)
	{
		if(element==(elementPrefix+elementsList[i]))
			return i;
	}

}
function changeAllElementsBackgroundColorToWhite(prefix,array)
{
	for(var i=0;i<noOfRecords;i++)
	{
		for(var j=0;j<array.length;j++)
		{
			var elementTmp=document.getElementById(prefix+"["+i+"]."+elementsList[j]);
			elementTmp.style.background="white";
		}
	}

}
function getElement(prefix,index,arrayIndex)
{
	return document.getElementById(prefix+"["+index+"]."+elementsList[arrayIndex]);

}
function getNextElement(that,index)
{
	var source=that.name;
	target="";
	var elementIndex=getIndex("PROGRESSREPORT_ENTRIES",source,index);
	var targetElement=getElement("PROGRESSREPORT_ENTRIES",index,elementIndex+1);
	if(targetElement)
		targetElement.focus();
	
}
function getPrevElement(that,index)
{
	var source=that.name;
	target="";
	var elementIndex=getIndex("PROGRESSREPORT_ENTRIES",source,index);
	var targetElement=getElement("PROGRESSREPORT_ENTRIES",index,elementIndex-1);
	if(targetElement)
		targetElement.focus();
	
}

var inNavigationMode=true;
//script to diable arrow keys for combo elements (only when in navigation mode);
if(window.Event) window.captureEvents(Event.KEYDOWN);

function keyDown(e){
  var n = (window.Event) ? e.which : e.keyCode;
  if(inNavigationMode)
  	if(n==38 || n==40) return false;
}
//include onkeydown="return keyDown(event);" in the select element
//end of script to diable arrow keys for combo elements

function handleKeys(event,that,index)
{
	content=that.value;
	var nextIndex=-1;
	index=parseInt(index,10);
	var elementIndex=getIndex("PROGRESSREPORT_ENTRIES",that.name,index);
	//alert(elementIndex);
	//alert(event.keyCode);
	//ESC Key
	if(event.keyCode=="17")
	{
		inNavigationMode=!inNavigationMode;
		document.forms[0].navigationMode.value=inNavigationMode+"";
		if(inNavigationMode)
		{
			window.status="In Navigation Mode. Press Ctrl to change mode";
		}
		else
		{
			window.status="In Edit Mode. Press Ctrl to change mode";
		}
	}
	
	if(inNavigationMode)
	{
		//uparrow
		if(event.keyCode=="38")
		{
			//if(that.type=="select-one")
				//return;
			nextIndex=index-1;
			if(getElement("PROGRESSREPORT_ENTRIES",nextIndex,elementIndex))
			{
				getElement("PROGRESSREPORT_ENTRIES",nextIndex,elementIndex).focus();
			}
		return false;	
		}
		//down arrow
		
		if(event.keyCode=="40")
		{
			//if(that.type=="select-one")
				//return ;
			nextIndex=index+1;
			if(getElement("PROGRESSREPORT_ENTRIES",nextIndex,elementIndex))
			{
				getElement("PROGRESSREPORT_ENTRIES",nextIndex,elementIndex).focus();
			}
			
		}
	
	
		
			//left arrow
			if(event.keyCode=="37")
			{
				var prevElement=getPrevElement(that,index);
				if(prevElement)
				{
					prevElement.focus();
				}
				
			}
			//right arrow
			if(event.keyCode=="39")
			{
				var nextElement=getNextElement(that,index);
				if(nextElement)
				{
					nextElement.focus();
				}
				
			}
		
	}
	if(event.keyCode!="17"&&event.keyCode!="37"&&event.keyCode!="38"&&event.keyCode!="39"&&event.keyCode!="40")
	{
		refreshTotals();
	}
}

function getData()
{
	document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=data";
	document.forms[0].submit();
}
function getCatagoryList(index)
{
	document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=getCatagoryList&index="+index;
	document.forms[0].submit();
}
function addNewProgForPlan_Normal()
{
	document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=addNewProgForPlanNormal";
	document.forms[0].submit();
}
function removeRecord()
{
	document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=removeProgForPlanNormal";
	document.forms[0].submit();
}
function fnSave()
{
	if(validateFrm())
	{
		document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=insertProgressReport";
		document.forms[0].submit();
	}
}
</script>
</head>

<body onload="initFunc()">
<html:form action="ProgressReportEntry.do" >

<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor=black>
<thead><tr><td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Progress Report Entry Form" />
		<jsp:param name="TWidth" value="100%"/>
		
	</jsp:include>
</td></tr></thead>

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


<table   align=center bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="1"  style="border-collapse:collapse;" width="100%" >	

<tr>
	<td class="mycborder">
		<fieldset>
			<legend align="right"> (Amount In Rs. Crores)</legend>
			<label>
				 <table   width="100%" bgcolor="#ffffff" cellpadding="0" cellspacing="1" 
					   border="1" bordercolor="#8A9FCD" style="border-collapse:collapse" >
					 <!-- 
					 <tr class="clrborder"><td colspan="30" nowrap align="left">District:&nbsp;<html:text style="width:100" property="dname" styleClass="gridText" readonly="true"/>Year:&nbsp;<html:text property="financialYear" style="width:100" styleClass="gridText" readonly="true"/>Month:&nbsp;<html:text property="monthName" style="width:100" styleClass="gridText" readonly="true"/></td></tr>
					  -->
					  <tr class="clrborder">
					  <td colspan="30" nowrap align="left">District:&nbsp;
					  <html:hidden property="navigationMode"/>
					  
					
						<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
							<html:select property="district"  styleClass="mycombo" style="width:150px">
							<html:option value=""><bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="districts">
										<html:options collection="districts" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>
		  					</html:select>
						</logic:equal>
						
						<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
							<html:text property="dname" styleClass="gridtext" style="width:150px"
						   		 readonly="true" />
							<html:hidden property="district" />
						</logic:notEqual>
	  					
					
					Year:&nbsp;
					<html:select  style="width:95"
									property="financialYear" styleClass="mycombo" >
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="financialYearsList">
										<html:options collection="financialYearsList" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>

					</html:select>
					  <!-- <html:text property="financialYear" style="width:100" styleClass="gridText" readonly="true"/> -->
					  Month:&nbsp;
					  <html:select  style="width:75"
									property="month" styleClass="mycombo" >
									<html:option value="">
										<bean:message key="app.pleaseSelect" />
									</html:option>
									<logic:notEmpty name="monthsList">
										<html:options collection="monthsList" name="labelValueBean"
											property="value" labelProperty="label" />
									</logic:notEmpty>

								</html:select>
						&nbsp;
						<button  value="Go" class="btext" onclick="getData()">
						Go<img src="<rws:context page='/images/go.gif' />" WIDTH="12" HEIGHT="12"/>
						</button>
						</td></tr>
					 
					 <tr class="clrborder">
					     <td rowspan="3" class="clrborder" align="center">S.No.</td>
					     <td rowspan="3" class="clrborder" align="center">Programme<font color="black">*</font></td>
				 	     <td rowspan="3" class="clrborder" align="center" >Plan / Non Plan<font color="black">*</font></td>
				 	     <td rowspan="3" class="clrborder" align="center" nowrap>Catagory<font color="black">*</font></td>
					     <td colspan="6" class="clrborder" align="center">FINANCIAL</td>
					     <td colspan="14" class="clrborder" align="center">WORKS & HABITATIONS</td>
					     <td colspan="6" class="clrborder" align="center">PHYSICAL</td>
					  </tr>
					  <tr>
					     <td colspan="4" class="clrborder" align="center">OB + Releases</td>
					     <td colspan="2" class="clrborder" align="center">Expenditure During <c:out value="${param.financialYear}"/></td>
					     <td colspan="5" class="clrborder" align="center">Spillover Works as on 1.4.<%=request.getParameter("financialYear").substring(0,4) %></td>
					     <td colspan="5" class="clrborder" align="center">New Works sanctioned during <c:out value="${param.financialYear}"/></td>
					     <td colspan="4" class="clrborder" align="center">Total Works </td>					    
					     <td colspan="2" class="clrborder" align="center">Progress</td>					    
					     <td colspan="4" class="clrborder" align="center">Completed</td>					    
					  </tr>
					  <tr>
					  	<td class="clrborder" align="center">OB</td>
					  	<td class="clrborder" align="center">Releases during the Month</td>
					  	<td class="clrborder" align="center">Releases upto the Month</td>
					  	<td class="clrborder" align="center">Total <br>(3+4)</td>
					  	<td class="clrborder" align="center">During the Month</td>
					  	<td class="clrborder" align="center">Upto the Month</td>
					  	<td class="clrborder" align="center">No</td>
					  	<td class="clrborder" align="center">Bala Cost</td>
					  	<td class="clrborder" align="center">Commitment on physical comp works as on 1.4.07</td>
					  	<td class="clrborder" align="center">Bal Habs</td>
					  	<td class="clrborder" align="center">Bal IP PH-1 Habs(Out of Col.11)</td>
					  	<td class="clrborder" align="center">No</td>
					  	<td class="clrborder" align="center">Cost</td>
					  	<td class="clrborder" align="center">Total Habs</td>
					  	<td class="clrborder" align="center">IP PH-1 Habs(Out of Col.15)</td>
					  	<td class="clrborder" align="center">IP PH-2 Habs(Out of Col.15)</td>
					  	<td class="clrborder" align="center">No(Col. 8+13)</td>
					  	<td class="clrborder" align="center">Cost(Col.9+10+14)</td>
					  	<td class="clrborder" align="center">Habs col(11+15)</td>
					  	<td class="clrborder" align="center">IP Habs(Out of Col.20)</td>
					  	<td class="clrborder" align="center">Entrusted out of col 18</td>
					  	<td class="clrborder" align="center">Grounded out of col 18</td>
					  	<td class="clrborder" align="center">Works</td>
					  	<td class="clrborder" align="center">Covered Habs</td>
					  	<td class="clrborder" align="center">Covered IP PH-1 Habs</td>
					  	<td class="clrborder" align="center">Covered IP PH-2 Habs</td>
					  </tr>
					 
					  <tr>
					  
					  	<td class="clrborder" align="center">1</td>
					  	<td class="clrborder" align="center">2</td>
					  	<td class="clrborder" align="center">&nbsp;</td>
					  	<td class="clrborder" align="center">&nbsp;</td>
					  	<td class="clrborder" align="center">3</td>
					  	<td class="clrborder" align="center">&nbsp;</td>
					  	<td class="clrborder" align="center">4</td>
					  	<td class="clrborder" align="center">5</td>
					  	<td class="clrborder" align="center">6</td>
					  	<td class="clrborder" align="center">7</td>
					  	<td class="clrborder" align="center">8</td>
					  	<td class="clrborder" align="center">9</td>
					  	<td class="clrborder" align="center">10</td>
					  	<td class="clrborder" align="center">11</td>
					  	<td class="clrborder" align="center">12</td>
					  	<td class="clrborder" align="center">13</td>
					  	<td class="clrborder" align="center">14</td>
					  	<td class="clrborder" align="center">15</td>
					  	<td class="clrborder" align="center">16</td>
					  	<td class="clrborder" align="center">17</td>
					  	<td class="clrborder" align="center">18</td>
					  	<td class="clrborder" align="center">19</td>
					  	<td class="clrborder" align="center">20</td>
					  	<td class="clrborder" align="center">21</td>
					  	<td class="clrborder" align="center">22</td>
					  	<td class="clrborder" align="center">23</td>
				  		<td class="clrborder" align="center">24</td>
				  		<td class="clrborder" align="center">25</td>
				  		<td class="clrborder" align="center">26</td>
				  		<td class="clrborder" align="center">27</td>
					  </tr>
					
					  <%count=0; %>
					  <html:hidden property="district"/>
					  <html:hidden property="financialYear"/>
					  <html:hidden property="month"/>
					 
					  <logic:present name="progressReportEntries">
					  
					 <nested:iterate id="PROGRESSREPORT_ENTRIES" name="progressReportEntries"  indexId="ndx" >
				 	  <tr>
				 	  
					  <td class="bwborder" align="center" nowrap>
					  <%= ++count %>
					
					  <INPUT TYPE="CHECKBOX" name="planNormal" VALUE="<%=count-1 %>"/>
					  </td>
					  <td class="bwborder" align="center">
					<html:select name="PROGRESSREPORT_ENTRIES" style="width:220" property="programmeCode" styleClass="mycombo" indexed="true" onkeydown="return keyDown(event);" onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="programmsList">
					<html:options collection="programmsList" name="labelValueBean" 
								  property="value" labelProperty="label" />
					</logic:notEmpty>
					</html:select>
					</td>
					<td class="bwborder" align="center">
					
					<html:select name="PROGRESSREPORT_ENTRIES" style="width:80" property="planNonPlan" styleClass="mycombo" indexed="true"  onkeydown="return keyDown(event);" onchange='<%= "javascript: getCatagoryList(\" + ndx +\")"%>' onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="NONPLAN">Non Plan</html:option>
					<html:option value="PLAN">Plan</html:option>
					</html:select>
					</td>
					<td class="bwborder" align="center">
					<html:select name="PROGRESSREPORT_ENTRIES" style="width:200" property="catagory" styleClass="mycombo" indexed="true"  onkeydown="return keyDown(event);" onchange='<%= "javascript: getUptoTheMonthValue(\" + ndx +\")"%>' onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>'>
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="PROGRESSREPORT_ENTRIES" property="catagoryList">
					<html:optionsCollection name="PROGRESSREPORT_ENTRIES" property="catagoryList" 
									value="value" label="label" />
					</logic:notEmpty>
					</html:select>
					</td>
					
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="openingBalance" onkeyup="extractNumber2(this,11,2,false);refreshTotals()" onkeypress="return blockNonNumbers(this, event, true, false);"  style="width:80;text-align:right;color:#066B8A" styleClass="gridText" maxlength="12" readonly="true" indexed="true"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="release" onkeyup='<%="extractNumber2(this,11,2,false);getClosingBalance();handleKeys(event,this,\"+ndx+\")"%>' onkeypress="return blockNonNumbers(this, event, true, false);" style="width:80;text-align:right;" styleClass="gridText"  maxlength="12" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="releasesUptoTheMonth" onkeyup="extractNumber2(this,11,2,false);refreshTotals()" onkeypress="return blockNonNumbers(this, event, true, false);" style="width:80;text-align:right;;color:#066B8A" styleClass="gridText"  maxlength="12"  readonly="true" indexed="true" /></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="obReleaseTotal"  style="width:80;text-align:right;color:#066B8A" styleClass="gridText"  maxlength="10" readonly="true" indexed="true"/></td>
					
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="duringTheMonth" onkeyup='<%="extractNumber2(this,11,2,false);getClosingBalance();handleKeys(event,this,\"+ndx+\")"%>' onkeypress="return blockNonNumbers(this, event, true, false);"  style="width:80;text-align:right;" styleClass="gridText"  maxlength="12" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="uptoTheMonth"  style="width:60;text-align:right;color:#066B8A" styleClass="gridText"  maxlength="10" readonly="true" indexed="true"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="spillOverWorksNo" onkeypress="return numeralsOnly(event)"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' style="width:60;text-align:right;" styleClass="gridText"  maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="spillOverWorksBalCost" onkeyup='<%="extractNumber2(this,11,2,false);handleKeys(event,this,\"+ndx+\")"%>' onkeypress="return blockNonNumbers(this, event, true, false);" style="width:80;text-align:right;" styleClass="gridText"  maxlength="12" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="commitment" onkeyup='<%="extractNumber2(this,11,2,false);handleKeys(event,this,\"+ndx+\")"%>' onkeypress="return blockNonNumbers(this, event, true, false);" style="width:80;text-align:right;" styleClass="gridText"  maxlength="12" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="spillOverWorksBalHabs" onkeypress="return numeralsOnly(event)"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' style="width:60;text-align:right;" styleClass="gridText"  maxlength="4" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="spillOverWorksBalIpPh1Habs" onkeypress="return decimalsOnly(event)"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' style="width:60;text-align:right;" styleClass="gridText"  maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="newWorksNo" onkeypress="return decimalsOnly(event)"  style="width:60;text-align:right;" onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' styleClass="gridText"  maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="newWorksCost" onkeypress="return decimalsOnly(event)"  style="width:80;text-align:right;" onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' styleClass="gridText"  maxlength="12" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="newWorksTotalHabs" onkeypress="return decimalsOnly(event)"  style="width:60;text-align:right;" onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' styleClass="gridText"  maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="newWorksIpPh1Habs" onkeypress="return decimalsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="newWorksIpPh2Habs" onkeypress="return decimalsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="10" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="totalWorksNo" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;color:#066B8A" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" indexed="true" readonly="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="totalWorksCost" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;color:#066B8A" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" readonly="true" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="totalWorksHabs" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;color:#066B8A" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="10" readonly="true" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="totalWorksIpHabs" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;color:#066B8A" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="10" readonly="true"  indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="progressEntrusted" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="progressGrounded" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="completedWorks" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="completedCoveredHabs" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="5" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="completedIpPh1Habs" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="4" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					<td><html:text name="PROGRESSREPORT_ENTRIES" property="completedIpPh2Habs" onkeypress="return numeralsOnly(event)"  style="width:60;text-align:right;" styleClass="gridText"  onkeyup='<%="handleKeys(event,this,\"+ndx+\")"%>' maxlength="4" indexed="true" onfocus="funcGotFocus(this)" onblur="funcLostFocus(this)"/></td>
					
	  	 			
					</tr>
					</nested:iterate>
					</logic:present>
					
					
					<%if(count==0){ %>
						<tr><td colspan="26" align="center">No Records</td></tr>
					<%}else{ %>
					
					<tr>
					
					<td>&nbsp;</td>
					<td><font class="gridText"><b>Total</b></font></td>
					<td></td>
					<td></td>
					<td><input type="text" name="openingBalanceGrandTotal"    style="width:85;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="releaseGrandTotal"    style="width:85;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="releasesUptoTheMonthGrandTotal"    style="width:85;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="obReleaseTotalGrandTotal"    style="width:85;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="duringTheMonthGrandTotal"    style="width:85;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="uptoTheMonthGrandTotal"    style="width:60;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="spillOverWorksNoGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="spillOverWorksBalCostGrandTotal"    style="width:85;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="commitmentGrandTotal"    style="width:85;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="spillOverWorksBalHabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="spillOverWorksBalIpPh1HabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="newWorksNoGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="newWorksCostGrandTotal"    style="width:85;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="newWorksTotalHabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					
					<td><input type="text" name="newWorksIpPh1HabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="newWorksIpPh2HabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="totalWorksNoGrandTotal"    style="width:60;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="totalWorksCostGrandTotal"    style="width:60;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="totalWorksHabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;color:#066B8A" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="totalWorksIpHabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;color:#066B8A;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="progressEntrustedGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="progressGroundedGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="completedWorksGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="completedCoveredHabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="completedIpPh1HabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					<td><input type="text" name="completedIpPh2HabsGrandTotal"    style="width:60;font-weight:bold;text-align:right;" class="gridText"  maxlength="10" readonly/></td>
					
					</tr>
					<%} %>
					
					  </table>
					  </label></fieldset>
	 		       </td>
	 		      </tr>
			<!-- End of ProgressReport form details -->
			
<tr><td><b><small>Closing Balance:&nbsp;</small></b><input type="text" style="width:100;background-color=#DEE3E0" name="closingBalance" class="gridText" readonly/></td></tr>					

<tr>
<td align="center">
<input type="button" class="btext" value="Save/Update" onclick="fnSave()">&nbsp;
<input type="button" class="btext" value="Add New" onclick="addNewProgForPlan_Normal()">&nbsp;
<input type="button" class="btext" value="Remove" onclick="removeRecord()">&nbsp;

</tr>
</table>

</td></tr></tbody></table>
</html:form>
</body>
<script language="javascript">
/*
function refreshTotals(that,index)
{
	if(that.name=document.getElementById("PROGRESSREPORT_ENTRIES["+index+"].obReleaseTotal").name)
		OBReleasesTotal();
	totalWorks();
	getGrandTotalsForAll();
	silentValidateFrm();
}
*/
function refreshTotals()
{
	OBReleasesTotal();
	totalWorks();
	getGrandTotalsForAll();
	silentValidateFrm();
}
function initFunc()
{
	OBReleasesTotal();
	totalWorks();
	getGrandTotalsForAll();
	getClosingBalance();
	if(!inNavigationMode)
		window.status="In Edit mode. Press Ctrl to change mode.";
	else
		window.status="In Navigation mode. Press Ctrl to change mode.";
	
}
var noOfRecords=<%=count%>;
function OBReleasesTotal()
{

	for(var i=0;i<noOfRecords;i++)
	{
		
		var releases=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].release");
		var openingBalance=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].openingBalance");
		var obReleasesTotal=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].obReleaseTotal");
		var obReleasesUptoTheMonthTotal=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].releasesUptoTheMonth");
		//obReleasesTotal.value=getNumericValue(openingBalance.value)+getNumericValue(releases.value)+getNumericValue(obReleasesUptoTheMonthTotal.value);
		obReleasesTotal.value=getNumericValue(openingBalance.value)+getNumericValue(obReleasesUptoTheMonthTotal.value);
		obReleasesTotal.value=roundNumberToSpefiedDecimal(obReleasesTotal.value,2)
	}
}
function totalWorks()
{

	for(var i=0;i<noOfRecords;i++)
	{
		document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").value=
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksNo").value)+
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksNo").value);
			
		document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksCost").value=
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalCost").value)+
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksCost").value);
			
		document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksHabs").value=
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalHabs").value)+
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksTotalHabs").value);
	
	
		//code added
		document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksIpHabs").value=
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalIpPh1Habs").value)+
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh1Habs").value)+
			getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh2Habs").value);
	
	
	}
}
function getNumericValue(str)
{
	if(str=="")
		return 0;
	else
		return parseFloat(str,10);
}

function getAndSetGrandTotal(str,target)
{
	var grandTotal=0;
	for(var i=0;i<noOfRecords;i++)
	{
		grandTotal=grandTotal+getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"]."+str).value);
	
	}
	if(document.getElementById(target))
		document.getElementById(target).value=grandTotal;
	
	return grandTotal;

}
function getGrandTotalsForAll()
{
	getAndSetGrandTotal("openingBalance","openingBalanceGrandTotal");
	//document.forms[0].openingBalanceGrandTotal.value=document.getElementById("PROGRESSREPORT_ENTRIES[0].openingBalance").value;
	getAndSetGrandTotal("releasesUptoTheMonth","releasesUptoTheMonthGrandTotal");
	getAndSetGrandTotal("release","releaseGrandTotal");
	getAndSetGrandTotal("obReleaseTotal","obReleaseTotalGrandTotal");
	getAndSetGrandTotal("duringTheMonth","duringTheMonthGrandTotal");
	getAndSetGrandTotal("uptoTheMonth","uptoTheMonthGrandTotal");
	getAndSetGrandTotal("spillOverWorksNo","spillOverWorksNoGrandTotal");
	getAndSetGrandTotal("spillOverWorksBalCost","spillOverWorksBalCostGrandTotal");
	getAndSetGrandTotal("commitment","commitmentGrandTotal");
	
	getAndSetGrandTotal("spillOverWorksBalHabs","spillOverWorksBalHabsGrandTotal");
	getAndSetGrandTotal("spillOverWorksBalIpPh1Habs","spillOverWorksBalIpPh1HabsGrandTotal");
	getAndSetGrandTotal("newWorksNo","newWorksNoGrandTotal");
	getAndSetGrandTotal("newWorksCost","newWorksCostGrandTotal");
	getAndSetGrandTotal("newWorksTotalHabs","newWorksTotalHabsGrandTotal");
	getAndSetGrandTotal("newWorksIpPh1Habs","newWorksIpPh1HabsGrandTotal");
	getAndSetGrandTotal("newWorksIpPh2Habs","newWorksIpPh2HabsGrandTotal");
	getAndSetGrandTotal("totalWorksNo","totalWorksNoGrandTotal");
	getAndSetGrandTotal("totalWorksCost","totalWorksCostGrandTotal");
	getAndSetGrandTotal("totalWorksHabs","totalWorksHabsGrandTotal");
	getAndSetGrandTotal("totalWorksIpHabs","totalWorksIpHabsGrandTotal");
	getAndSetGrandTotal("progressEntrusted","progressEntrustedGrandTotal");
	getAndSetGrandTotal("progressGrounded","progressGroundedGrandTotal");
	getAndSetGrandTotal("completedWorks","completedWorksGrandTotal");
	getAndSetGrandTotal("completedCoveredHabs","completedCoveredHabsGrandTotal");
	getAndSetGrandTotal("completedIpPh1Habs","completedIpPh1HabsGrandTotal");
	getAndSetGrandTotal("completedIpPh2Habs","completedIpPh2HabsGrandTotal");
	

}
var errorCellColor="red";
function validateFrm()
{
	changeAllElementsBackgroundColorToWhite("PROGRESSREPORT_ENTRIES",allElementsList);
	for(var i=0;i<noOfRecords;i++)
	{
		var result=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].programmeCode").value;	
		if(result=="")
		{
			alert("Programme for Record with S.No."+(i+1)+" is required");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].programmeCode").style.background=errorCellColor;
			return false;
		}
		if(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].openingBalance").value=="")
		{
			alert("Opening balance for Record with S.No."+(i+1)+" is required");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].openingBalance").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalIpPh1Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalHabs").value))
		{
			alert("Spillover Works Bal IP PH-1 Habs for Record \nwith S.No."+(i+1)+" should not be greater \nthan Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalHabs").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh1Habs").value)+getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh2Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksTotalHabs").value))
		{
			alert("Sum of New Works IP PH-1 Habs and IP PH-2 Habs should not be greater than \nNew works Total Habs for Record with S.No."+(i+1)+"");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh2Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksTotalHabs").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksIpHabs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksHabs").value))
		{
			alert("Total Works IPHabs for Record with S.No."+(i+1)+" \n should not be greater than Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksIpHabs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksHabs").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh1Habs").value)+getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh2Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedCoveredHabs").value))
		{
			alert("Sum of Covered IP PH-1 Habs and Covered IP PH-2 Habs  for Record with S.No."+(i+1)+" \n should not be greater than Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh2Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedCoveredHabs").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressEntrusted").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").value))
		{
			alert("Entrusted out of col 18 value  for Record with S.No."+(i+1)+" \n should not be greater than Total Works No");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressEntrusted").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").style.background=errorCellColor;
			return false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressGrounded").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").value))
		{
			alert("Grounded out of col 18 value  for Record with S.No."+(i+1)+" \n should not be greater than Total Works No");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressGrounded").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").style.background=errorCellColor;
			return false;
		}
	}
	return true;
}
function silentValidateFrm()
{
	var valid=true;
	changeAllElementsBackgroundColorToWhite("PROGRESSREPORT_ENTRIES",allElementsList);
	for(var i=0;i<noOfRecords;i++)
	{
		var result=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].programmeCode").value;	
		if(result=="")
		{
			//alert("Programme for Record with S.No."+(i+1)+" is required");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].programmeCode").style.background=errorCellColor;
			valid=false;
		}
		if(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].openingBalance").value=="")
		{
			//alert("Opening balance for Record with S.No."+(i+1)+" is required");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].openingBalance").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalIpPh1Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalHabs").value))
		{
			//alert("Spillover Works Bal IP PH-1 Habs for Record \nwith S.No."+(i+1)+" should not be greater \nthan Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].spillOverWorksBalHabs").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh1Habs").value)+getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh2Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksTotalHabs").value))
		{
			//alert("Sum of New Works IP PH-1 Habs and IP PH-2 Habs should not be greater than \nNew works Total Habs for Record with S.No."+(i+1)+"");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksIpPh2Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].newWorksTotalHabs").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksIpHabs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksHabs").value))
		{
			//alert("Total Works IPHabs for Record with S.No."+(i+1)+" \n should not be greater than Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksIpHabs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksHabs").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh1Habs").value)+getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh2Habs").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedCoveredHabs").value))
		{
			//alert("Sum of Covered IP PH-1 Habs and Covered IP PH-2 Habs  for Record with S.No."+(i+1)+" \n should not be greater than Bal Habs");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh1Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedIpPh2Habs").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].completedCoveredHabs").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressEntrusted").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").value))
		{
			//alert("Entrusted out of col 18 value  for Record with S.No."+(i+1)+" \n should not be greater than Total Works No");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressEntrusted").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").style.background=errorCellColor;
			valid=false;
		}
		if(getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressGrounded").value)>getNumericValue(document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").value))
		{
			//alert("Grounded out of col 18 value  for Record with S.No."+(i+1)+" \n should not be greater than Total Works No");
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].progressGrounded").style.background=errorCellColor;
			document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].totalWorksNo").style.background=errorCellColor;
			valid=false;
		}
	}
	return valid;
}
function getUptoTheMonthValue(index)
{
	
	//document.forms[0].mdistrict.options[document.forms[0].mdistrict.selectedIndex].text+" District");
	var selectedProgrammeObj=document.getElementById("PROGRESSREPORT_ENTRIES["+index+"].programmeCode");	
	for(var i=0;i<noOfRecords;i++)
	{
		/*
		var progObj=document.getElementById("PROGRESSREPORT_ENTRIES["+i+"].programmeCode");	
		if(selectedProgrammeObj.value==progObj.value && i!=index)
		{
			if(selectedProgrammeObj.value!="")
				alert("Selection Already Exists");
			selectedProgrammeObj.value="";
			return false;
		}
		*/
	}
	document.forms[0].action="/pred/works/ProgressReportEntry.do?mode=getUptoTheMonth&index="+index+"&programmeCode="+document.getElementById("PROGRESSREPORT_ENTRIES["+index+"].programmeCode").value+"&planNonPlan="+document.getElementById("PROGRESSREPORT_ENTRIES["+index+"].planNonPlan").value+"&catagory="+document.getElementById("PROGRESSREPORT_ENTRIES["+index+"].catagory").value;
	document.forms[0].submit();
}
function getClosingBalance()
{
	//document.forms[0].closingBalance.value=getNumericValue(document.forms[0].obReleaseTotalGrandTotal.value)-(getNumericValue(document.forms[0].duringTheMonthGrandTotal.value)+getNumericValue(document.forms[0].uptoTheMonthGrandTotal.value));
	document.forms[0].closingBalance.value=(getNumericValue(document.forms[0].openingBalanceGrandTotal.value)+getNumericValue(document.forms[0].releaseGrandTotal.value)+getNumericValue(document.forms[0].releasesUptoTheMonthGrandTotal.value))-(getNumericValue(document.forms[0].duringTheMonthGrandTotal.value)+getNumericValue(document.forms[0].uptoTheMonthGrandTotal.value));
}
function funcGotFocus(that)
{
	//that.style.background="#DEE3E0";
	if(that.style.background!="red")
		that.style.background="#A6F1D1";
	    
}
function funcLostFocus(that)
{
	if(that.style.background!="red")
		that.style.background="white";
}

function changeAllElementsBackgroundColorToWhite(prefix,columnsList)
{
	for(var i=0;i<noOfRecords;i++)
	{
		for(var j=0;j<columnsList.length;j++)
		{
			var elementTmp=document.getElementById(prefix+"["+i+"]."+columnsList[j]);
			elementTmp.style.background="white";
		}
	}

}
</script>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
			