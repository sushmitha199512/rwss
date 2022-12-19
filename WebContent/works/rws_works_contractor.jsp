<style type="text/css">
div#tbl-container1 {
width: 840px;
height: 330px;
overflow: scroll;
}

div#tbl-container1 table th {
text-align:center;
width: 100px;
}
A.blue:link {text-decoration:none;color:blue}
A:active {text-decoration: none;color:red}
A:hover {text-decoration: underline;}
div.transbox
  {
  width:250px;
  background-color:#D6DCD9;
  border:1px solid black;
  filter:alpha(opacity=140);
  opacity:1.5;
  }
</style>
<script>
function toggleRowColor(that)
{
	clearColorSelections();
	that.style.color="red";
}
function clearColorSelections() {
	var choices = document.getElementsByTagName("a");
	for (var i=1;i < choices.length;i++)
	{
		choices[i].style.color="blue";
	}
}
function getData(variable)
{
	var dist = document.forms[0].circleCode.value;
	var cat = document.forms[0].workCat.value;
	var openRequest = getAjaxRequest();
	openRequest.open("POST","/pred/works/ContractorGet.jsp?district="+dist+"&catcode="+cat+"&name="+variable,false);
	postData="district="+dist+"&catcode="+cat+"&name="+variable;
	openRequest.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	openRequest.send(postData);
	document.getElementById("habs1").innerHTML="<select name=conName style=width:500px styleClass=mycombo>"+openRequest.responseText+"</select>"+"&nbsp;<a href=#1 onclick=getContractorDetails() TITLE=CLICK HERE TO ADD NEW CONTRACTOR><INPUT type=button name=... value=... HEIGHT=6 class=btext readonly></a>";
}
function getAjaxRequest()
{
	var openRequest;
	try 
	{
		openRequest = new XMLHttpRequest();
		return openRequest;
	}
	catch (error) 
	{
		try
		{
			openRequest = new ActiveXObject("Microsoft.XMLHTTP");
			return openRequest;
		}
		catch (error)
		{
			if(isDebugOn)
				displayDebugError("Error crea");
		}
	}
}
var daysofmonth   = new Array( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
var daysofmonthLY = new Array( 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
function getContractorDetails()
{
	var width = 850;
	var height = 500;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url="./switch.do?prefix=/masters&page=/Contractor.do&mode=data&contractorName="+document.forms[0].conName.value+"&dCode="+document.getElementById('workId').value.substring(4,6);
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
function LeapYear(year) 
{
    if ((year/4)   != Math.floor(year/4))   return false;
    if ((year/100) != Math.floor(year/100)) return true;
    if ((year/400) != Math.floor(year/400)) return false;
    return true;
}
function y2k(number)    
{ 
return (number < 1000) ? number + 1900 : number; 
}
var today = new Date();
var year = y2k(today.getYear());

if (LeapYear(year)) {
  daysofmonth = daysofmonthLY;
}
function getStipulatedDateOfCompletion()
{
	if(document.forms[0].agrDate.value=="" || document.forms[0].agrDuration.value=="")
	{
		document.forms[0].stipulatedDate.value="";
		return;
	}
agreementDate=document.forms[0].agrDate.value;
noOfMonths=parseInt(document.forms[0].agrDuration.value,10);
var year=parseInt(agreementDate.substring(6,10),10);
var month=parseInt(agreementDate.substring(3,5),10);
var date=parseInt(agreementDate.substring(0,2),10);
var newFullDate="";
var newYear=year;
var newDate=date;
var newMonth=month+noOfMonths;
var stringDate="";
var stringMonth="";
if(newMonth>12)
{
	newYear=year+parseInt((newMonth/12),10);
	newMonth=newMonth%12;
}
if (LeapYear(newYear)) {
  daysofmonth = daysofmonthLY;
}
if(newDate>daysofmonth[newMonth-1])
newDate=daysofmonth[newMonth-1];

if(newDate<10)
stringDate="0"+newDate;
else
stringDate=newDate+"";
if(newMonth==0)
{
	newYear=year+parseInt((noOfMonths/12));
	stringMonth="12";
}
else if(newMonth<10)
{
stringMonth="0"+newMonth;
}
else
stringMonth=newMonth+"";
newFullDate=stringDate+"/"+stringMonth+"/"+newYear;
document.forms[0].stipulatedDate.value=newFullDate;
}
var executeBeforeDateWindowClosed=true;
function beforeDateWindowClosed(calDateField)
{
	if(calDateField.name=="agrDate")
	{
		getStipulatedDateOfCompletion();
	}
}
function fnGetStages(index)
{
   var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=stages"
			+ "&index="+index;
	var frm = document.forms["WorkForm"];
	frm.action = url;
	frm.submit();
}
function validateFrm()
{
	var validationPassed=true;
	var frm = document.forms["WorkForm"];
	if(frm.workEnt.value=="")
	{
	alert("Work Entrustement is required");
	validationPassed=false;
	}
	if(frm.workEnt.value=="T")
	{
     	if(frm.tenId.value=="")
		{
		alert("Tender Notification Id is required");
		validationPassed=false;
		}
	}
	if(frm.tenAcceptedDate.value!="" && frm.tsDate.value!="" && validationPassed == true)
	{
		var res=compareDates(frm.tenAcceptedDate.value, frm.tsDate.value);
		if(res<0)
		{
		alert("Tender Accepted Date should be greater \nthan or equal to Technical Sanction Date("+frm.tsDate.value+")");
		validationPassed=false;
		}
	}
	if(frm.loaIssued.value!="" && frm.tsDate.value!="" && validationPassed == true)
	{
		var res=compareDates(frm.loaIssued.value, frm.tsDate.value);
		if(res<0)
		{
		alert("LOA Issued on Date should be greater \nthan or equal to Technical Sanction Date("+frm.tsDate.value+")");
		validationPassed=false;
		}
	}
	if(frm.siteHandOverDate.value!="" && frm.agrDate.value!="" && validationPassed == true)
	{
		var res=compareDates(frm.siteHandOverDate.value, frm.agrDate.value);
		if(res<0)
		{
		alert("Site HandingOver Date should be greater \nthan or equal to Agreement Date("+frm.agrDate.value+")");
		validationPassed=false;
		}
	}
	if(frm.probCompDate.value!="" && frm.agrDate.value!="" && validationPassed == true)
	{
		var res=compareDates(frm.probCompDate.value, frm.agrDate.value);
		if(res<0)
		{
		alert("Probable Completion Date should be greater \nthan or equal to Agreement Date("+frm.agrDate.value+")");
		validationPassed=false;
		}
	}
	return validationPassed;
}
function getDateObject(dateString,dateSeperator)
{
	var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);
	cMonth=dateString.substring(curPos+1,endPos);
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth,cDate);	
	return dtObject;
}
function fnDelete()
{
	var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=delete";
	var frm = document.forms["WorkForm"];
	if(confirm("Do you want to delete the record"))
	{
	frm.action = url;
	frm.submit();
	}
}
function disText()
{
	if(document.forms[0].workEnt.value=="T")
	{
	document.getElementById('a').style.display='block';
	document.getElementById('b').style.display='none';
	}
	else if(document.forms[0].workEnt.value=="N")
	{
	document.getElementById('a').style.display='none';
	document.getElementById('b').style.display='block';
	}
	validatePercentage();
}
</script>
<BODY onload="disText();">
<c:set var="adminAmnt" value="${WorkForm.samount}" scope="request"/>
<%
long partAAmt=0;
String partASanction=(String)request.getAttribute("partASanAMount");
String adminAmnt = (String)request.getAttribute("adminAmnt");
long sancAmt = (new Double(Double.parseDouble(adminAmnt)*100000)).longValue();
if(partASanction!=null && !partASanction.equals("")){
 partAAmt = (new Double(Double.parseDouble(partASanction)*100000)).longValue();
}
%> 
<c:set var="revAdminAmnt" value="${WorkForm.revAdminAmnt}" scope="request"/>
<%String revAdminAmnt = (String)request.getAttribute("revAdminAmnt");
long revSancAmnt = 0;
if(revAdminAmnt!=null && !revAdminAmnt.equals("") && !revAdminAmnt.equals("0"))
{
	revSancAmnt = (new Double(Double.parseDouble(revAdminAmnt)*100000)).longValue();
	sancAmt = revSancAmnt;
}
%> 
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
				<B>Contractor Management: (Amount In Rs.Lakhs)</B>
		</legend>
		<label>
		<table cellpadding="0" width="800" cellspacing="4" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	  		<tr class="textborder">
	  		<td width="25%">
	  		Work Entrustment :<span class="mandatory">*</span></TD>    
            <TD><html:select property="workEnt" style="width:122px" styleClass="mycombo" onchange="disText()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="T">TENDER</html:option>
					<html:option value="N">NOMINATION</html:option>
			</html:select>
	  		</td>
	  		</tr>
	  		<tr class="textborder">
	  		<td>Tender Notification Id :</td>
	  		<td>
	  		<div id="a" style="display:block">
	  		<html:text property="tenId"  styleClass="mytext" maxlength="15" />
	  		</div>
	  		<div id="b" style="display:none">
	  		<html:text property="tenId1" value="NOMINATION" styleClass="mytext" maxlength="15" readonly="true"/>
	  		</div>
	  		</td>
	  		<td>Tender Cost:</td>
	  		<td><html:text property="tenCost" onkeypress="return decimalsOnly(event)" size="12" maxlength="10"/></td>
	  	 	</tr>
	  	 	<tr class="textborder">
	  	 	<td>Tender Accepted Date:</td>
	  		<td><html:text property="tenAcceptedDate"  styleClass="mytext" maxlength="15" style="width:100px" readonly="true"/>
	  		<a href="javascript: showCalendar(document.WorkForm.tenAcceptedDate);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
            </a></td>
	  		<td>Tender Percentage:<font color="#FF6666">*</font></td>
	  		<td >
	  		<html:select property="workPer1" style="width:100px" styleClass="mycombo" onchange="validatePercentage()">
					<html:option value="-1">SELECT</html:option>
					<html:option value="-">LESS</html:option>
					<html:option value="+">EXCESS</html:option>
					<html:option value="">EST. RATES</html:option>
			</html:select>
			<html:text property="tenPer" onkeypress="return decimalsOnly(event)" size="7" maxlength="5"/>
			</td></tr>
			<tr><td colspan="4" align="center">
				<font face="verdana" size="1" color=red>Select Contractor Alphabet Wise --></font>
				<font face="verdana" size="1">				
					<!-- <a href="#" class="blue" onclick="javascript:getData('all','conName');toggleRowColor(this);">ALL</a> -->
					<a href="#" class="blue" onclick="javascript:getData('a','conName');toggleRowColor(this);">A</a>
					<a href="#" class="blue" onclick="javascript:getData('b','conName');toggleRowColor(this);">B</a>
					<a href="#" class="blue" onclick="javascript:getData('c','conName');toggleRowColor(this);">C</a>
					<a href="#" class="blue" onclick="javascript:getData('d','conName');toggleRowColor(this);">D</a>
					<a href="#" class="blue" onclick="javascript:getData('e','conName');toggleRowColor(this);">E</a>
					<a href="#" class="blue" onclick="javascript:getData('f','conName');toggleRowColor(this);">F</a>
					<a href="#" class="blue" onclick="javascript:getData('g','conName');toggleRowColor(this);">G</a>
					<a href="#" class="blue" onclick="javascript:getData('h','conName');toggleRowColor(this);">H</a>
					<a href="#" class="blue" onclick="javascript:getData('i','conName');toggleRowColor(this);">I</a>
					<a href="#" class="blue" onclick="javascript:getData('j','conName');toggleRowColor(this);">J</a>
					<a href="#" class="blue" onclick="javascript:getData('k','conName');toggleRowColor(this);">K</a>
					<a href="#" class="blue" onclick="javascript:getData('l','conName');toggleRowColor(this);">L</a>
					<a href="#" class="blue" onclick="javascript:getData('m','conName');toggleRowColor(this);">M</a>
					<a href="#" class="blue" onclick="javascript:getData('n','conName');toggleRowColor(this);">N</a>
					<a href="#" class="blue" onclick="javascript:getData('o','conName');toggleRowColor(this);">O</a>
					<a href="#" class="blue" onclick="javascript:getData('p','conName');toggleRowColor(this);">P</a>
					<a href="#" class="blue" onclick="javascript:getData('q','conName');toggleRowColor(this);">Q</a>
					<a href="#" class="blue" onclick="javascript:getData('r','conName');toggleRowColor(this);">R</a>
					<a href="#" class="blue" onclick="javascript:getData('s','conName');toggleRowColor(this);">S</a>
					<a href="#" class="blue" onclick="javascript:getData('t','conName');toggleRowColor(this);">T</a>
					<a href="#" class="blue" onclick="javascript:getData('u','conName');toggleRowColor(this);">U</a>
					<a href="#" class="blue" onclick="javascript:getData('v','conName');toggleRowColor(this);">V</a>
					<a href="#" class="blue" onclick="javascript:getData('w','conName');toggleRowColor(this);">W</a>
					<a href="#" class="blue" onclick="javascript:getData('x','conName');toggleRowColor(this);">X</a>
					<a href="#" class="blue" onclick="javascript:getData('y','conName');toggleRowColor(this);">Y</a>
					<a href="#" class="blue" onclick="javascript:getData('z','conName');toggleRowColor(this);">Z</a>
			</td></tr>
	  	 	<tr class="textborder">
	  	 	<td>Contractor/Firm Name:</td>
	  		<td colspan="3" id="habs1">
  			  		<html:select property="conName" style="width:500px" styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect"/></html:option>
					<logic:present name="contractors">
						<html:options collection="contractors"   property="value" labelProperty="label" />
					</logic:present>
			</html:select>
	  		<a href="#1" onclick="getContractorDetails()" TITLE="CLICK HERE TO ADD NEW CONTRACTOR">
	  		<INPUT type="button" name="..." value="..." class=btext HEIGHT="6" readonly></a></td>
	  		</tr>
	  		<tr class="textborder"><td>LOA Issued on Date:</td>
	  		<td><html:text property="loaIssued" readonly="true" style="width:100px" styleClass="mytext" maxlength="10"/>
	  		<a href="javascript: showCalendar(document.WorkForm.loaIssued);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
            </a></td>
	  	 	</tr>
	  	 	<tr class="textborder"><td>
	  	    <legend>
				<B>Tender Approved By:</B>
		    </legend> 
		    </td></tr>
		    <tr class="textborder">
		    <td><html:multibox property="tenCommiteeArr" value="01"/>Tender Committee</td>
		    <td colspan=2><html:multibox property="tenCommiteeArr" value="02"/>Competent Authority</td>
		    </tr>
		    </tr>
	  	 	<tr class="textborder"><td>
	  	    <legend>
				<B>Agreement Details: (Agrmt. Refers To Agreement) </B>
		    </legend>
		    </td>
		    </tr>
		    <tr class="textborder">
	  		<td>Agrmt Reference No:<font color="#FF6666">*</font></td>
	  		<td><html:text property="agrRefNo"  styleClass="mytext" maxlength="20"  /></td>
	  		<td>Agrmt Date:<font color="#FF6666">*</font></td>
	  		<td><html:text property="agrDate"   style="width:100px" styleClass="mytext" maxlength="10"  readonly="true"/>
	  		<a href="javascript: showCalendar(document.WorkForm.agrDate);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
            </a></td>
	  	 	</tr>
	  	 	<tr class="textborder">
	  		<td>Agrmt Duration in months:<font color="#FF6666">*</font></td>
	  		<td><html:text property="agrDuration" onkeypress="return numeralsOnly()" styleClass="mytext" maxlength="2"  onkeyup="javascript:getStipulatedDateOfCompletion()"/></td>
	  		<td>Agrmt Value:<font color="red" face="verdana">*(In Rupees)</font></td>
	  		<td><html:text property="agrValue" onkeypress="return decimalsOnly(event)" onkeyup="fnCheckAgreement(event)" size="12" maxlength="10"/>
	  	    </td>
	  	 	</tr>
	  	 	<tr class="textborder">
	  		<td>Site Handingover Date:<font color="#FF6666">*</font></td>
	  		<td><html:text property="siteHandOverDate"  styleClass="mytext" maxlength="150"  style="width:100px" readonly="true" />
	  		<a href="javascript: showCalendar(document.WorkForm.siteHandOverDate);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
            </a></td>
	  		<td>Stipulated Date<br> Of Completion:</td>
	  		<td><html:text property="stipulatedDate"   style="width:100px" styleClass="mytext" maxlength="10"  readonly="true"/>
           </td>
	  	 	</tr>
	  	 	<tr class="textborder" nowrap>
	  		<td>Probable Date Of Completion:</td>
	  		<td><html:text property="probCompDate"  styleClass="mytext" maxlength="150"  style="width:100px" readonly="true" />
	  		<a href="javascript: showCalendarFuture(document.WorkForm.probCompDate);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
            </a></td>
			<%
			if(revAdminAmnt==null || (revAdminAmnt!=null && (revAdminAmnt.equals("") || revAdminAmnt.equals("0")))){%>
			<td>Total Estimate Cost:</td>
	  		<td><font face=verdana size=2 color=red><%=sancAmt%> Rs.</td>			
			<%}
			else
			{%><td>Total Estimate Cost:(Revised)</td>
	  		<td><font face=verdana size=2 color=red><%=revSancAmnt%> Rs.</td>
			<%}%>
			
	  	 	</tr>
<tr class="textborder" nowrap><td></td><td></td><td>Part-A Sanction Amount:</td>
	  		<td> <html:text property="partASanAMount" readonly="true"></html:text><font color="red" face="verdana">*(In Rupees)</font></td>	</tr>
	  		</table>
	  	</label>
	  	</fieldset>
	   </td>
</tr>	
<tr>
		<td class="bwborder" >
		<fieldset>
		<legend>
				<B>MileStones</B>
		</legend>
		<label>
		<div id="tbl-container1">
		<table cellpadding="4" cellspacing="4" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;">
	  		 <tr class="textborder">
	  		 <td>	  		   
	  		 <table width="840" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
				   style="border-collapse: collapse">
			<thead class="gridHeader">
			<tr align=center>
				<th><bean:message key="app.select" /></th>
				<th>Sl.No</th>
				<th>Type Of<BR>Contractor<span class="mandatory">*</span></th>
				<th>Major<BR>Mile<BR>Stone<BR> No</th>
				<th>Mile Stone<br>(Major Component)<span class="mandatory">*</span></th>
				<th>Type of Item/<br>Component<span class="mandatory">*</span></th>
				<th>Quantity to be <BR>executed i.e <BR>No of Items<BR>/Length in Mts etc.,<span class="mandatory">*</span></th>
				<th>Target Date<span class="mandatory">*</span></th>
				<th>Revised <BR>Target Date<BR>(As Per <BR> EOAT)</th>
				<th>Agreement value of the<BR>Item to be executed <BR>in the Mile stone<BR>(ECV)<BR><font color="white" 
				face="verdana">(In Rupees)<span class="mandatory">*</span></font></th>
				<%if(revAdminAmnt==null || (revAdminAmnt!=null && (revAdminAmnt.equals("") || revAdminAmnt.equals("0")))){%>
					<th>% of Component to be <br> executed in the MileStone<BR> w.r.to total <font color="white" 
				face="verdana">Estimate Cost</font></th>
				<%}else{%>
					<th>% of Component to be <br> executed in the MileStone<BR> w.r.to total <font color="white" face="verdana">Revised Estimate Cost</font></th>	
				<%}%>
			 	</tr>
			</thead>
			<tbody>
			 <% int mileStones = 0;%>
			 <nested:iterate id="MILES"  name="mileStonesList" indexId="ndx" scope="session">
			 <% mileStones++;%>
			 <tr bgcolor="#ffffff">
				<td width="40px" align="center">
					<input type="checkbox" name="remove" value="<%= ndx%>">
				</td>
				<td class="rptValue">
					<nested:text name="MILES" property="mileStoneSno" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 50px"/>
				</td>
				<td class="rptValue">
					
<nested:select name="MILES" property="typeOfContractor" indexed="true" style="width: 70px" styleClass="noborder-text-box" onchange='<%= "javascript: fnGetStages1("+ndx+")"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<html:option value="1">Civil</html:option>
							<html:option value="2">Electrical</html:option>
							<html:option value="3">Mechanical</html:option>
							<html:option value="4">BoreWell</html:option>
							<html:option value="5">Spill Over</html:option>
						</nested:select>
				</td>
				<td>
					<nested:text name="MILES" property="majorMileStone" indexed="true" readonly="true" styleClass="noborder-text-box" style="width: 30px"/>
				</td>
				<td width="30">
					<logic:present name="MILESTONES">
						<nested:select name="MILES" property="mileStone" indexed="true"
									   style="width: 160px" styleClass="noborder-text-box" 
									   onchange='<%= "javascript: fnGetStages(\"+ndx+\")"%>'>
							<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
							<nested:options collection="MILESTONES"  name="rws_works_WorkStatus_bean" 
										  property="mileStone" labelProperty="mileStoneName" />
						</nested:select>
					</logic:present> 
				</td>
				 <td width="30">
					<nested:select name="MILES" property="stage" indexed="true"  
								   style="width: 180px" styleClass="noborder-text-box">
						<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
						    <logic:notEmpty name="MILES" property="stages">
							<nested:optionsCollection name="MILES" property="stages" label="stageName" value="stage"/>
						</logic:notEmpty>
					</nested:select>
				</td>
				<td>
					<nested:text name="MILES" property="compInNo" indexed="true" onkeypress="return numeralsOnly()" maxlength="6" styleClass="noborder-text-box" style="width: 80px"/>
				</td>
				<td width="10%" nowrap>
					<nested:text name="MILES" property="targetDate" style="width: 80px" indexed="true" styleClass="noborder-text-box" readonly="true"/>
	                   <a href="javascript: showCalendarFuture(document.getElementById('MILES[<%= ndx%>].targetDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
				</td>
				<td width="10%" nowrap>
					<nested:text name="MILES" property="eoatTargetDate" style="width: 80px" indexed="true" styleClass="noborder-text-box" readonly="true"/>
	                   <a href="javascript: showCalendarFuture(document.getElementById('MILES[<%= ndx%>].eoatTargetDate'));">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle">
				</td>				
				<td>
					<nested:text name="MILES" property="perCompInWorkValue" indexed="true" 
							     style="width: 70px;" styleClass="noborder-text-box" maxlength="15"  onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)" onkeyup='<%= "javascript: calPer("+ndx+")"%>'/>
				</td>
				<td>
					<nested:text name="MILES" property="perCompInWork" indexed="true" 
							     style="width: 80px;" styleClass="noborder-text-box" maxlength="9"  readonly="true" onkeypress="return blockNonNumbersAndExtractNumber2(this, event, true, false)"/>
				</td>	 
			  </tr>
			  </nested:iterate>
			<input type="hidden" name="workCount" value="<%=mileStones %>">
			</tbody>
			</table>
			</div>
			</td>
			</tr>
   		 </table>
   		 <table width="840" >
		 <tr>
		 <td align="center">
				 <Div id="OptionsDiv1" class="transbox" style="display:none;">
					<p align=center>
					<font face=verdana size=2 color=blue>Please Select Major Code <BR>from the Following</font><BR>
					<select name="majorNo" onchange="fnAddNew1()" class="myCombo">
					</select><BR>
					<a href="#" onclick="javascript:document.getElementById('OptionsDiv1').style.display='none'">Close</a>
					</p>
				</Div>
			 </td></tr>
   		 <tr>
	  		 <td align=left nowrap colspan=3>
	  		 <html:button property="mode" styleClass="btext" value="Add New Major MileStone" 
	  		 onclick="fnAddNewMajor() " title="Click to add a new Major MileStone"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  		    <html:button property="mode" styleClass="btext" value="Add Item to Existing MileStone" 
	  		 onclick="fnAddNew() " title="Click to add a new Item to Existing MileStone"/> 
	  		  <html:button property="mode" styleClass="btext" value="Remove Item from Existing MileStone" 
	  		 onclick="fnRemove()" title="Click to remove a  Item from Existing MileStone"/>
	  		 </td>
	  		 </tr>
			 </table>
	  	</label>
	  	</fieldset>
	   </td>
</tr>	 
<tr>
		<%
		
		//if((physicalStatuss.equals("Financially Completed") || !workCancelleddDate.equals("")) && (session.getAttribute("tsStatus")!=null && session.getAttribute("tsStatus").equals("yes")))
			if((physicalStatuss.equals("Financially Completed") || !workCancelleddDate.equals("")) || session.getAttribute("tsStatus").equals("no"))
        {
			// || physicalStatuss.equals("Commissioned") || physicalStatuss.equals("Completed") - Unfreezed  for commissioned and completed works on 180910
        %>
			<td colspan="9" align="center"><html:button property="mode" styleClass="btext" value="Save" 
				  		 onclick="fnSave() " title="Click to save data" disabled="true"/> 
		<%
        }
        else{
        %>
			<td colspan="9" align="center"><html:button property="mode" styleClass="btext" value="Save" 
				  		 onclick="fnSave() " title="Click to save data" disabled="false"/> 
			<%}
			%>
			<html:button property="mode" styleClass="btext" value="Delete" 
				  		 onclick="fnDelete() " title="Click to Delete"/> 
			 </td> 		     
			</tr>
<html:hidden property="tsDate"/>
<SCRIPT language="javascript">
function fnGetStages1(index)
{

	var wCount = '<%=mileStones%>';
	var flag = false;
	if(wCount!=0)
	{
		for(var i=0;i<wCount-1;i++)
		{
			if(document.getElementById("MILES["+index+"].typeOfContractor").value=="5")
			{
				flag = true;
			}
		}
	}
	if(flag == true)
	{
		document.getElementById("MILES["+index+"].typeOfContractor").value='';
		alert("Spill Over Item should be once for a Work");
	}
	else
	{
		if(document.getElementById("MILES["+index+"].typeOfContractor").value=="5")
		{
			document.getElementById("MILES["+index+"].mileStone").value = '15';
			document.getElementById("MILES["+index+"].majorMileStone").value = '0';
			var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=stages&index="+index;
			var frm = document.forms["WorkForm"];
			frm.action = url;
			frm.submit();
		}
	}
}
function fnCheckAgreement(evt)
{
	var sancAmt = '<%=sancAmt%>';
	if(parseFloat(document.forms[0].agrValue.value)>parseFloat(sancAmt))
	{
		alert("Agreement Value:("+document.forms[0].agrValue.value+") Should not reater than Sanction Amount:("+sancAmt+")");
		document.forms[0].agrValue.value = '0';
	}
}
function calPer(i)
{
	var sancAmt = '<%=sancAmt%>';
    var partAAMount=document.getElementById('partASanAMount').value;
	var value = document.getElementById("MILES["+i+"].perCompInWorkValue").value;
	var finVal = parseFloat(parseFloat(parseFloat(value)/parseFloat(sancAmt))*100);
	if(isNaN(finVal))
		finVal = 0;
	document.getElementById("MILES["+i+"].perCompInWork").value = finVal.toFixed(4);
}
function fnAddNewMajor()
{
	var wCount = '<%=mileStones%>';
	var val = '0';
	if(wCount!=0)
	{
		for(var i=0;i<wCount;i++)
		{
			var status = makeCompulsory(i);
			if(status==false){break;}
		}
		if(status==true)
		{
			val = document.getElementById("MILES["+(wCount-1)+"].majorMileStone").value;
			var newArray=new Array();
			for(i=0;i<wCount;i++)
			{		
				newArray[i] = document.getElementById("MILES["+i+"].majorMileStone").value;
			}
			var newArray1 = unique(newArray);
			for(i=0;i<newArray1.length;i++)
			{		
				val = newArray1[i];
			}
			val++;
			var frm = document.forms["WorkForm"];
			frm.action = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=addNew&majorCode="+val+"&special=y";
			frm.submit();
		}
	}
	else
	{
		val++;
		var frm = document.forms["WorkForm"];
		frm.action = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=addNew&majorCode="+val+"&special=y";
		frm.submit();
	}
}
function fnAddNew()
{
	var wCount = '<%=mileStones%>';
	if(wCount==0)
	{
		alert("Please Add New Major Mile Stone");
	}
	else
	{
		for(var i=0;i<wCount;i++)
		{
			var status = makeCompulsory(i);
			if(status==false){break;}
		}
			if(status==true)
			{
				var newArray=new Array();
				for(i=0;i<wCount;i++)
				{		
					newArray[i] = document.getElementById("MILES["+i+"].majorMileStone").value;
				}
				var newArray1 = unique(newArray);
				document.forms[0].majorNo.options.length = 0; 
			   	var combo = document.getElementById("majorNo");  
			   	var optn = document.createElement("OPTION");
				optn.text = "-Select-";
				optn.value = "";
				combo.add(optn);
				for(i=0;i<newArray1.length;i++)
				{
					if(newArray1[i]!="0"){
					optn = document.createElement("OPTION");
					optn.text = newArray1[i];
					optn.value = newArray1[i];
					combo.add(optn);
					}
				}
				document.getElementById('OptionsDiv1').style.display='block';
			}
	}
}
function fnAddNew1()
{
	document.getElementById('OptionsDiv1').style.display='none';
	if(document.forms[0].majorNo.value=="")
	{
		alert("Please Select Major MileStone Code");
	}
	else
	{
			var val = document.forms[0].majorNo.value;
		  	var urls = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=addNew&majorCode="+val;
			var frm = document.forms["WorkForm"];
			frm.action = urls;
			frm.submit();
	}
}
function makeCompulsory(i)
{
	if(document.getElementById("MILES["+i+"].typeOfContractor").value=="")
	{
		alert("Please Select Type Of Contractor for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].typeOfContractor").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].mileStone").value=="")
	{
		alert("Please Select Mile Stone for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].mileStone").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].stage").value=="")
	{
		alert("Please Select Stage for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].stage").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].compInNo").value=="")
	{
		alert("Please Enter Component No. for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].compInNo").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].targetDate").value=="")
	{
		alert("Please Select Target Date for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].targetDate").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].perCompInWorkValue").value=="")
	{
		alert("Please Enter %Completed in Work for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].perCompInWorkValue").focus();
		return false;
	}
	else if(document.getElementById("MILES["+i+"].perCompInWork").value!="" && parseInt(document.getElementById("MILES["+i+"].perCompInWork").value)>100)
	{
		alert("Please Enter Total % Completed of Work should be <= 100 for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
		document.getElementById("MILES["+i+"].perCompInWorkValue").focus();
		return false;
	}
	else
	{
		if(document.getElementById("MILES["+i+"].eoatTargetDate").value!="")
		{
			dt1=getDateObject(document.getElementById("MILES["+i+"].targetDate").value,"/");
			dt2=getDateObject(document.getElementById("MILES["+i+"].eoatTargetDate").value,"/");
			if(dt1>dt2)
			{
				alert("Revised Target Date("+document.getElementById("MILES["+i+"].eoatTargetDate").value+") for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value+" Should be Greater than Target Date("+document.getElementById("MILES["+i+"].targetDate").value+") for S.No:"+document.getElementById("MILES["+i+"].mileStoneSno").value);
				document.getElementById("MILES["+i+"].eoatTargetDate").focus();
				return false;
			}
			else
			{
				return true;
			}
		}
		return true;
	}
}
function unique(arrayName)
{
    var newArray=new Array();
    label:for(var i=0; i<arrayName.length;i++ )
    {  
        for(var j=0; j<newArray.length;j++ )
        {
            if(newArray[j]==arrayName[i]) 
                continue label;
        }
        newArray[newArray.length] = arrayName[i];
    }
    return newArray;
}
function fnRemove()
{
	var wCount = '<%=mileStones%>';
	var selectCount=0;
	for(i=0; i<document.forms[0].elements.length; i++)
	{
		if(document.forms[0].elements[i].type=="checkbox" && document.forms[0].elements[i].name=="remove" && document.forms[0].elements[i].checked)
		{
			selectCount++;
		}
	}
   	var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=remove";
	var frm = document.forms["WorkForm"];
	frm.action = url;
	if(selectCount>0)
	{
		if(parseInt(selectCount)==parseInt(wCount))
		{
			if(confirm("Are You sure to Remove all the Mile Stones"))
			{
				frm.submit();
			}
		}
		else
		{
			frm.submit();
		}
	}
	else
	{
		alert("Please Select Atleast one Mile Stone to Remove");
	}
}
function fnSave()
{
	var wCount = '<%=mileStones%>';
	var aDate = '<%=session.getAttribute("adate")%>';
	dtt1=getDateObject(aDate,"/");
	dtt2=getDateObject("01/04/2010","/");
	var st = dtt1<dtt2;
	if(wCount==0 && st==false)
	{
		alert("Please Add Mile Stone(s)");
	}
	else
	{
		dt1=getDateObject(document.forms[0].tsDate.value,"/");
		dt2=getDateObject(document.forms[0].agrDate.value,"/");
		if(wCount==0)
		{
				if(dt1>dt2)
			alert("Agreement Date should be greater than or equal Technical Sanction Date("+document.forms[0].tsDate.value+")");
			else
			{
				var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=save&conNamee="+document.forms[0].conName.value;
				var frm = document.forms["WorkForm"];
				var validationPassed=validateFrm();
				if(validationPassed)
				{
					frm.action = url;
					frm.submit();
				}	
			}
		}
		if(dt1>dt2)
			alert("Agreement Date should be greater than or equal Technical Sanction Date("+document.forms[0].tsDate.value+")");
		else
		{
			if(document.forms[0].tenCost.value=="")
			{
				alert("Tender Cost Required");
			}
			else if(document.forms[0].workPer1.value=="-1")
			{
				alert("Tender Percentage Required");
			}
			else if(document.forms[0].conName.value=="")
			{
				alert("Contractor Name Required");
			}
			else if(document.forms[0].agrRefNo.value=="")
			{
				alert("Agrmt Reference No Required");
			}
			else if(document.forms[0].agrDate.value=="")
			{
				alert("Agrmt Date Required");
			}
			else if(document.forms[0].agrDuration.value=="")
			{
				alert("Agrmt Duration Required");
			}
			else if(document.forms[0].agrValue.value=="")
			{
				alert("Agrmt Value Required");
			}
			else if(document.forms[0].siteHandOverDate.value=="")
			{
				alert("Site Handingover Date Required");
			}
			else if(wCount!=0)
			{
				for(var i=0;i<wCount;i++)
				{
					var status = makeCompulsory(i);
					if(status==false){break;}
				}
				if(status==false){}
				else if(totalPer()==true)
				{
					var url = "switch.do?prefix=/works&page=/WorkStatus.do&conMode=save&conNamee="+document.forms[0].conName.value;
					var frm = document.forms["WorkForm"];
					var validationPassed=validateFrm();
					if(validationPassed)
					{
						frm.action = url;
						frm.submit();
					}	
				}
			}
		 }
	}
}
function totalPer()
{
	var wCount = '<%=mileStones%>';
	var tot = 0;
	var sancAmt = '<%=sancAmt%>';
	for(var i=0;i<wCount;i++)
	{
		if(document.getElementById("MILES["+i+"].mileStone").value!=13)
		{
			tot = tot + parseFloat(document.getElementById("MILES["+i+"].perCompInWorkValue").value);
		}
	}
	if(tot>parseFloat(sancAmt))
	{
		alert("Total Agreement value of the Items for Work Should be less than Sanction Amount");
		return false;
	}
	else
	{
		return true;
	}
}
</SCRIPT>
</BODY>
<%@ include file="/commons/rws_alert.jsp"%> 
	  	