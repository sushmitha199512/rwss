<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
	int count = 0;
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String userid = users.getUserId();

	String md = request.getParameter("mode");
	String md1 = request.getParameter("mode1");
%>

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
function openFile(URL){
	
	
	var popFeatures = "width=800,height=550,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
	if(URL!="")
	{
		myNewWin = window.open(URL,'newWinddow',popFeatures);
		myNewWin.focus();	
	}	
	
}

<!--

function getDivisions()
{

 document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=Divisions";
	document.forms[0].submit();

}
function getWorkcategory()
{
  document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=workcategory";
  monitoringForm.submit();
}
function getSubDivisions()
{

	document.forms[0].action="switch.do?prefix=/works&page=/WorkReleases.do&mode=data&mode1=programmes";
	monitoringForm.submit();
}
function getProgramme()
{

document.forms[0].action="switch.do?prefix=/works&page=/WorkReleases.do&mode=data&mode1=programmes";
monitoringForm.submit();

}

function getWorks()
{

document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=works";
document.forms[0].submit();

}
function getYears()
{

document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getYears";
document.forms[0].submit();

}
function getPrograms()
{

document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=programmes";
document.forms[0].submit();

}



function getWorkDetails()
{

document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getworkDetails";
document.forms[0].submit();

}
function getDateObject(dateString,dateSeperator)
{
		var curValue=dateString;
	var sepChar=dateSeperator;
	var curPos=0;
	var cDate,cMonth,cYear;
	curPos=dateString.indexOf(sepChar);
	cDate=dateString.substring(0,curPos);
	endPos=dateString.indexOf(sepChar,curPos+1);			cMonth=dateString.substring(curPos+1,endPos);
	curPos=endPos;
	endPos=curPos+5;			
	cYear=curValue.substring(curPos+1,endPos);
	dtObject=new Date(cYear,cMonth,cDate);	
	return dtObject;
}

function updateWork(){


	 slsccDate=getDateObject(document.forms[0].elements["slsccDate"].value,"/");

	 sanctionedDate=getDateObject(document.forms[0].elements["sanctionedDate"].value,"/");
	//Date admnDate=document.forms[0].elements["sanctionedDate"].value;

	/* if(slsccDate>sanctionedDate){
		alert("SLSCC Date Should not be Greater than Admin Sanctioned Date.");
		return false;
	} */

	
	if(document.forms[0].elements["workid"].value==""){
		alert("Please Select Work.");
	return false;
		}


	var totExp=parseFloat(document.forms[0].elements["probExpNextYear"].value);
	 totExp+=parseFloat(document.forms[0].elements["pExp"].value);
	 totExp+=parseFloat(document.forms[0].elements["pExp1"].value);

	var balEst=parseFloat(document.forms[0].elements["balanceEst"].value);
	
	if(totExp>balEst){
		alert("Probable Expenditure Should be Less Than or Equal to  Balance Estimate Cost.");
		return false;
	}
	
	
	//if(document.forms[0].elements["probExp"].value=="" || document.forms[0].elements["probExp"].value=="0"){
		//alert("Please Enter Probable Expenditure");
	//	document.forms[0].elements["probExp"].focus();
	//	return false;
	//	}

	//if(document.forms[0].elements["probExpNextYear"].value=="" || document.forms[0].elements["probExpNextYear"].value=="0"){
	//	alert("Please Enter Probable Expenditure for Next Financial Year");
	//	document.forms[0].elements["probExpNextYear"].focus();
	//	return false;
	//	}

	if(document.forms[0].elements["subplanSubmitted"].value=="0"){
		alert("Please Select Subplan Submitted");
		document.forms[0].elements["subplanSubmitted"].focus();
		return false;

	}
	

	//var probExp=parseFloat(document.forms[0].elements["probExp"].value);
	//var balEst=parseFloat(document.forms[0].elements["balanceEst"].value);
	//if(probExp>balEst){
	//	alert("Probable Expenditure Should be Less Than Balance Estimate Cost.");
	//	return false;
	//}

	
	document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=update";
	document.forms[0].submit();
	
}

function getWorkDetails()
{
	//if(document.forms[0].elements["workIdList"].value==""){
	//	alert("Please Enter  Work Id.");
	//	return false;
	//	}
	document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=workdetails";
	document.forms[0].submit();
	
}

function addAAPHabs(){
	var URL="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getSanctionedHabs";

	//var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		//myNewWin = window.open("switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getSanctionedHabs",'_new',popFeatures);
	///	myNewWin.focus();
		
		TINY.box.show({url:URL,boxid:'frameless',width:850,height:500,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}});
			
	}

	

function getWorkDetails1()
{
	if(document.forms[0].elements["workIdList"].value==""){
		alert("Please Enter  Work Id.");
		return false;
		}
	document.forms[0].action="switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=workdetailsQuick";
	document.forms[0].submit();
	
}

function sl(){
	//alert("sdfdsf");
}

 -->
 
    </script>
    </head>
    

<%

String cirfi=(String)session.getAttribute("fixcircle");
String usercode=RWS_USER.getCircleOfficeCode();
String username=RWS_USER.getCircleOfficeName();
String divusercode=RWS_USER.getDivisionOfficeCode();
String divusername=RWS_USER.getDivisionOfficeName();
String subusercode=RWS_USER.getSubdivisionOfficeCode();
java.util.Date systemdate= new java.util.Date(System.currentTimeMillis());

java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
  String transdate=null;
transdate=dateFormat.format(systemdate);


%>

	<body  >
<html:form  action="workUpdation.do" method="post">

<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	<table>
		<tr>
			<td align="right"><a href="<rws:context page='/home.jsp'/>">Home&nbsp;</a>
			</td>
		</tr>


	</table>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="SC/ST Subplan & Anual Action Plan" />
		<jsp:param name="TWidth" value="930" />
	</jsp:include>

	<table bgcolor="ffffe0" bordercolor="#8A9FCD" rules="none" width="1000"
		border=1 style="border-collapse: collapse;">

					
		<table bgcolor="ffffe0" width="960" bordercolor="#8A9FCD">
		<tr>
				<td>
				<fieldset><legend><b>Quick Search</b></legend>

				<table width="960" border=0 style="border-collapse: collapse;">
				<tr>
						<td class="btext2" align="right" >Enter Work ID<font
							color="red"><b>*</b></font></td>
						<td>&nbsp;&nbsp;&nbsp;<html:text property="workIdList"
							size="20" maxlength="14" />&nbsp;&nbsp;&nbsp;<input
							type="button" onclick="getWorkDetails1()" value="Get Details"></input></td>
					</tr>
					
					
				</table>
				
				</fieldset>
				</td>
				</tr>
			<tr>
				<td>
				<fieldset><legend><b>Office Details</b></legend>

				<table width="960" border=0 style="border-collapse: collapse;">
				<tr>
				<logic:present name="circles">
					<logic:notPresent name="fixcircle">
						<td class="btext2">Circle<span class="mandatory">*</span></td>
						<td class="btext2"><html:select  property="circleCode" 
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getDivisions();">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="circles" property="value"
								labelProperty="label" />
						</html:select></td>
					</logic:notPresent>
					<logic:present name="fixcircle">

						<td class="btext2">Circle<span class="mandatory">*</span></td>
						<logic:present name="RWS_USER" property="circleOfficeName">
							<html:hidden property="circleCode" />
							<td class="btext2"><html:text property="circleOfficeName"
								name="RWS_USER" readonly="true" styleClass="mytext"
								style="width:100px" /> <html:hidden property="circleCode"
								 /></td>
						</logic:present>
					</logic:present>
				</logic:present>


				<%if(divusercode.equals("0")){%>
				<td class="btext2"><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td class="btext2"><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" onchange="Javascript:getWorkcategory();">
					<html:option value="">Select...</html:option>
					<logic:present name="divisions">
						<html:options collection="divisions" name="division"
							property="value" labelProperty="label" />
					</logic:present>

				</html:select></td>
				<%} else{%>
				<td class="btext2"><bean:message key="app.division" /><span class="mandatory">*</span></td>
				<td class="btext2"><html:select property="cmbDivision" style="width:183px"
					styleClass="mycombo" >
					<html:option value='<%=divusercode%>'>
						<%=divusername%>
					</html:option>
				</html:select> 
				
				<%} %>





<td class="btext2">Category:
<html:select property="category" style="width:135px" styleClass="mycombo" onchange="javascript:getPrograms();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</font></html:option>
<html:option value="1">
								<font class="myfontclr1">Projects
							</html:option>
<html:option value="2">
								<font class="myfontclr1">Normal
							</html:option>
<html:option value="3">
								<font class="myfontclr1">District Level
							</html:option>
</html:select>
</td>



<td><logic:present name="programs">
						<td class="btext2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Programs</td>
						<td class="btext2"><html:select property="programCode"
							style="width:143px" styleClass="mycombo"
							onchange="javascript:getWorks();">
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="programs" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present></td>
				
</tr>
<tr>

<logic:present name="works">
						<td class="btext2" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Works</td>
						<td class="btext2" colspan=5><html:select property="workIdList1"
							style="width:560px" styleClass="mycombo"
							onchange="javascript:getWorkDetails();">
							<html:option value=" ">
								<font class="myfontclr1">Select...
							</html:option>
							<html:options collection="works" property="value"
								labelProperty="label" />
						</html:select></td>
				
				</logic:present></td>
				</tr>
					

				</table>
				</fieldset>
				</td>
			</tr>
			<tr>
				<td>
				<fieldset><legend><B>Work Details</B></legend>
				<table width="900" border=0 style="border-collapse: collapse;">
					<tr>

						<td class="btext2" align="right">Work ID</td>
						<td><html:text property="workid" size="20" maxlength="20"
							disabled="true" /></td>

						<td class="btext2" align="right">Work Name</td>
						<td colspan="3"><html:text property="workName" size="80"
							disabled="true" /></td>
					</tr>
					<tr>
						<td class="btext2" align="right">Program</td>
						<td><html:text property="program" size="20" disabled="true" /></td>
						<td class="btext2" align="right">SubProgram</td>
						<td><html:text property="subProgName" size="20"
							disabled="true" /></td>
						<td class="btext2" align="right">Sanction Date</td>
						<td><html:text property="sanctionedDate" size="20"
							disabled="true" /></td>
					</tr>
					<tr>
						<td class="btext2" align="right">Sanction&nbsp;Amount
						<td><html:text property="sanctionedAmount" size="20"
							disabled="true" /></td>
						</td>
						<td class="btext2" align="right">Balance&nbsp;Estimate as on 01.04.current year</td>
						<td><html:text property="balanceEst" size="20"
							disabled="true" /></td>
							<td class="btext2" align="right">Expenditure During Year</td>
						<td><html:text property="expDuring" size="20"
							disabled="true" /></td>
					</tr>
					
					<tr>
						<td class="btext2" align="right">Grounding Date </td>
						<td><html:text property="groundingDate" size="20"
							disabled="true" /></td>
						
						<td class="btext2" align="right">Completion Date</td>
						<td><html:text property="completionDate" size="20"
							disabled="true" /></td>
							<td class="btext2" align="right">Sanction&nbsp;Habs</td>
						<td><html:text property="sanctionHabs" size="20"
							disabled="true" /></td>
							
					</tr>

				</table>
				</fieldset>
				</td>
			</tr>
			
			<tr>
				<td>
				<fieldset><legend><B>Population Details</B></legend>
				<table width="900" border=0 style="border-collapse: collapse;">
					
					<tr>
						<td class="btext2" align="right">Plain</td>
						<td><html:text property="plain" size="20" disabled="true" /></td>
						<td class="btext2" align="right">SC</td>
						<td><html:text property="sc" size="20"
							disabled="true" /></td>
						<td class="btext2" align="right">ST</td>
						<td><html:text property="st" size="20"
							disabled="true" /></td>
					</tr>
					
				</table>
				</fieldset>
				</td>
			</tr>
	<tr>
				<td>
				<fieldset><legend><B>Updations</B></legend>
				<table ><tr><td >
				<table border=0 style="border-collapse: collapse;">
				<tr>
						<td class="btext2" align="right">SLSCC Date</td><td align="left"> <html:text property="slsccDate"    style="width: 80px"   onkeypress="return decimalsOnly(event)"/>
			<a href="javascript: showCalendarFuture(document.forms[0].slsccDate);">
       <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>
</td>


</tr>
					<tr>

						<td class="btext2" align="right">Clause : </td><td><html:text property="specialCatCode"    style="width: 80px"  readonly="true" />
						</td>
						</tr>
						<tr>
						<td class="btext2" align="right">Probable&nbsp;Date&nbsp;Of&nbsp;Completion</td><td align="left"> 
							<html:text property="probDateOfComp"    style="width: 80px"   onkeypress="return decimalsOnly(event)"/>
							<a href="javascript: showCalendarFuture(document.forms[0].probDateOfComp);"> <img src="./images/cal.gif" width="16" height="16" border="0" alt="Pick a date"></a>

</td>


</tr>
<tr>
						
<td class="btext2" align="right">SubPlan Submitted:<font color="red"><b>*</b></font></td><td>

<html:select property="subplanSubmitted" 	style="width:80px" styleClass="mycombo" >
<html:option value="0">	Select...</html:option>
<html:option value="SCSP">SCSP</html:option>
<html:option value="TSP">TSP</html:option>
<html:option value="Others">Others</html:option>
</html:select>
</td>
</tr>

</table>
</td>
<td class="btext2" align="right" >

<fieldset><legend><b>Probable Expenditure</b><font color="red">(Amount&nbsp;in&nbsp;Lakhs)</font></legend>
<table>					
						
						
						<tr>
						<td class="btext2" align="right">Expenditure current fin year(Entire Year i.e Expenditure made so far and for balance period )<font color="red"><b>*</b></font></td><td class="btext2" align="left"> <html:text onkeypress="return decimalsOnly(event)" property="probExpNextYear" size="8" /></td>
						</tr>
						<tr>
						<td class="btext2" align="right">Expenditure next  fin year<font color="red"><b>*</b></font></td><td class="btext2" align="left"> <html:text onkeypress="return decimalsOnly(event)" property="pExp" size="8" /></td>
						</tr>
						<tr>
						<td class="btext2" align="right">Expenditure next to next fin year<font color="red"><b>*</b></font></td><td class="btext2" align="left"> <html:text onkeypress="return decimalsOnly(event)" property="pExp1" size="8" /></td>
						</tr>
						
						
					</table>
					</fieldset>
					</td>
					</tr>	
					</table>
					
					
					<table>
					
					
						<tr>
						
						<td align="center" ><input class="btext2" type="button" onclick="updateWork()"
							value="Update"></input></td>
						<td align="center">
						<!-- <input class="btext2" type="button" onclick="addAAPHabs()"	value="Add AAP Habs"></input> -->
						<!-- <input class="btext2" type="button" onclick="TINY.box.show({url:'switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getSanctionedHabs',boxid:'frameless',width:850,height:500,fixed:false,maskid:'bluemask',maskopacity:40,closejs:function(){closeJS()}})"	value="Add AAP Habs"></input> -->
						<input class="btext2" type="button" onclick="openFile('switch.do?prefix=/works&page=/workUpdation.do&mode=data&mode1=getSanctionedHabs')"	value="Add AAP Habs"></input>
						
						</td>
							
							
					</tr>

				</table>
				</fieldset>


				</td>
			</tr>


		</table>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="930" />
		</jsp:include>

		<table>
		
		<tr>
				<td colspan="2" class="rptValue"><font color="red">Note:</font>AAP -Anual Action Plan</td>
			</tr>
		<tr>
		<td colspan="2" class="rptValue"><font color="red">Note:</font>1.Enter Probable Expenditure During the Financial Year 
		</td>
		
		</tr>
		
		
		
			<tr>
				<td colspan="2" class="rptValue"><font color="red">Note:</font>1.SCSP
				-11(B) Means ,the hab in which work proposed under SC sub plan
				current fin year is having SC population more than or Equal to 40%</td>
			</tr>
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2.SCSP
				-11(C) Means ,the hab in which work proposed under SC sub plan
				current fin year is having SC population less than 40%</td>
			</tr>
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				3.TSP-11(B) Means ,the hab in which work proposed under tribal sub plan	current fin year is having ST population more than or Equal to 40%</td>
			</tr>
			
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4.TSP
				-11(C) Means ,the hab in which work proposed under tribal sub plan
				current fin year is having ST population less than 40%</td>
			</tr>
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5.Others-SC-
				11(B) Means ,the hab in which work not proposed under any sub plan
				current fin year and also having SC population more than or Equal to 40%</td>
			</tr>
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6.Others-ST-
				11(B) Means ,the hab in which work not proposed under any sub plan
				current fin year and also having ST population more than or Equal to 40%</td>
			</tr>
			<tr>
				<td colspan="2" class="rptValue">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7.Others
				-11(C) Means ,the hab in which work not proposed under any sub plan
				current fin year and also having ST/SC population is less than 40%</td>
			</tr>


		</table>

		<%@ include file="/commons/rws_footer.jsp"%>
	</table>
	
</html:form>
</body>
<%
 if(request.getAttribute("message")!=null)
 {	
	 String message=(String)request.getAttribute("message");
%>
	<script language=JavaScript>
	var mess="<%=message%>";
	alert(mess)
	</script>
<%
 } %>
