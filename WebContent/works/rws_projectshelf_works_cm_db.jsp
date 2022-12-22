<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%
	int count = 1;
	nic.watersoft.commons.RwsUser rwsusers = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
	String ad = (String) session.getAttribute("userId");
	%>
<head>
<style type="text/css">
.style1 {
	color: #FF0000;
	font-family: verdana;
	font-size: 13px;
}
</style>
<script language="JavaScript"
	src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.7.1.js"></script>
<script>
	function toggleRowColor(that) {
		var rowColor = '#ccccff';
		if (that) {
			if (that.style.background == rowColor)
				that.style.background = "white";
			else if (that.style.background == "white")
				that.style.background = rowColor;
			else
				that.style.background = rowColor;
		}
	}
	function getDivisions() {

		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=divisions";
		document.forms[0].submit();
	}
	function getSubDivisions() {

		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=subDivisions";
		document.forms[0].submit();
	}
	function getMandals() {
		//alert("hi");
		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=mandals";
		document.forms[0].submit();
	}
	function getPrograms() {
		if (document.forms[0].divisionOfficeCode.value == '') {
			alert("Please Select Division");
			return false;
		}
		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=getPrograms";
		document.forms[0].submit();

	}
	function getWorkcategory() {
		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=workcategory";
		PSWorkForm.submit();
	}

	function getProgramme() {

		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=programmes";
		PSWorkForm.submit();

	}
	function getSubProgramme() {

		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=subprogrammes";
		PSWorkForm.submit();

	}
	function getWorks1() {

		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=getworks";
		PSWorkForm.submit();

	}
	function checkMe() {
		if (document.forms[0].type[0].checked) {
			document.forms[0].type[0].checked = true;
		} else if (document.forms[0].type[1].checked) {
			document.forms[0].type[1].checked = true;
		} else {
			document.forms[0].type[0].checked = true;
		}
	}

	function getWorks() {
		if (document.forms[0].circleOfficeCode.value == '') {
			alert("Please Select Circle");
			return false;					
		} else if (document.forms[0].divisionOfficeCode.value == '') {
			alert("Please Select Division");
			return false;					
		}else {
			document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=getCMCOREWorks&CMcore=yes";
			document.forms[0].submit();
		}
	}
	function fnShowHabs(workid) {
		var workId = workid.name;
		var url = "switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=showHabs&workID="
				+ workId;
		var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				+ "scrollbars=yes,copyhistory=no,resizable=yes";
		var newWindow = window.open(url, "", properties);
		newWindow.moveTo(10, 10);
	}
	function fnShowDate() {		
		var length = document.forms[0].resultCount.value;
		var temp = new Array();
		length = length - 1;
		for (var k = 0; k < length; k++) {
			if (document.forms[0].elements["psWorks[" + k + "].workStatus"].value != "") {
				var workStatus = document.forms[0].elements["psWorks[" + k	+ "].workStatus"].value;
				var workId = document.forms[0].elements["psWorks[" + k	+ "].workId"].value;
				var groundedDate = document.forms[0].elements["psWorks[" + k + "].groundedDate"].value;
				var financialDate = document.forms[0].elements["psWorks[" + k + "].financialDate"].value;
				var physicalDate = document.forms[0].elements["psWorks[" + k + "].physicalDate"].value;
				var commisionedDate = document.forms[0].elements["psWorks[" + k	+ "].commisionedDate"].value;
				if (workStatus == 'grounded') {				
					document.forms[0].elements["psWorks[" + k  + "].workStatusDate"].value = groundedDate;
				} else if (workStatus == 'financiallyCompleted') {
					document.forms[0].elements["psWorks[" + k + "].workStatusDate"].value = financialDate;
				} else if (workStatus == 'physicallyCompleted') {
					document.forms[0].elements["psWorks[" + k + "].workStatusDate"].value = physicalDate;
				} else if (workStatus == 'commissioned') {
					document.forms[0].elements["psWorks[" + k + "].workStatusDate"].value = commisionedDate;
				}				
			}
		}
	}

	function fnSave(thisform) {
		var selectedWorks = '';		
		var len = document.forms[0].resultCount.value;
		len = len - 1;
		var yes = 0;
		for (var i = 0; i < len; i++) {
			if (document.forms[0].elements["psWorks[" + i + "].checks"].checked == true) {
				selectedWorks = selectedWorks	+ ","+ document.forms[0].elements["psWorks[" + i + "].workId"].value;
				selectedWorks = selectedWorks	+ "@"+ document.forms[0].elements["psWorks[" + i+ "].probableDate"].value;
				if (document.forms[0].elements["psWorks[" + i + "].probableDate"].value == ''	|| document.forms[0].elements["psWorks[" + i+ "].probableDate"].value == '-') {	
					alert("Please Select Probable Date");
					document.forms[0].elements["psWorks[" + i + "].probableDate"] .focus();
					return false;
				} else if (document.forms[0].elements["psWorks[" + i + "].coreDashboardStatus"].value == '') {
					alert("Please Select CM-SEC Dashboard");
					document.forms[0].elements["psWorks[" + i + "].coreDashboardStatus"].focus();
					return false;
				}else if(document.forms[0].elements["psWorks["+i+"].coreDashboardStatus"].value=='Y' && document.forms[0].elements["psWorks["+i+"].probableDate"].value!='-' && document.forms[0].elements["psWorks["+i+"].kpiStatus"].value =='Y'  ){
					if(document.forms[0].elements["psWorks["+i+"].kpiHabList"].value=='')
					{
						alert("Please Select Habs by clicking on Habs button");
						return false;
					}
			}	
			}
		}
		if (selectedWorks == "") {
			alert("Select atleast one check box to save");
		} else {
			if (confirm("Are You Sure To Save The Checked Work(s)")) {
				document.forms[0].work.value = selectedWorks;
				document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=saveW";
				document.forms[0].submit();
			}
		}
	}
	function uploadWorkImage(workid, status) {		
		var zURL = "./switch.do?prefix=/works&page=/aap1.do&mode=data&mode1=saveImage&workid="	+ workid + "&status=" + status;
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL, 'habs', popFeatures);
		myWin.focus();
	}
	function workPhysicalStatus(workid) {
		var zURL = "./switch.do?prefix=/works&page=/aap1.do&mode=milestones&workid="+ workid;
		var popFeatures = "width=950,height=500,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=100";
		myWin = window.open(zURL, 'habs', popFeatures);
		myWin.focus();
	}
	function openFile(workId, status) {		
		var url = "./switch.do?prefix=/works&page=/aap1.do&mode=showScannedCopy&workid="+ workId + "&imageStatus=" + status;
		var width = 990;
		var height = 450;
		var left = parseInt((screen.availWidth / 2) - (width / 2));
		var top = parseInt((screen.availHeight / 2) - (height / 2));
		var properties = "width="
				+ width
				+ ",height="
				+ height
				+ ",screenX="
				+ left
				+ ",screenY="
				+ top
				+ ",toolbar=no,"
				+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				+ "resizable=yes,status=yes,left=20,top=20";

		newWindow = window.open(url, "_New", properties);
		newWindow.focus();

	}
	function hideOrUnhide() {
		if (document.getElementById('schemeType').value == 'SVS') {
			document.getElementById('show').style.display = 'block';
		} else if (document.getElementById('schemeType').value == '') {
			document.getElementById('show').style.display = 'none';
		} else {
			document.getElementById('show').style.display = 'none';
			document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=data&mode1=getCMCOREMVSWorks&CMcore=yes";
			document.forms[0].submit();
		}
	}
	function show() {
		document.getElementById('show').style.display = 'block';
	}
	function hideOrUnhideSVS() {
		if (document.getElementById('schemeType').value == 'SVS') {
			document.getElementById('show').style.display = 'block';
		} else {
			document.getElementById('show').style.display = 'none';
		}
	}
	function viewExcel() {
		document.forms[0].action = "switch.do?prefix=/works&page=/CMDBoard.do&mode=excelFile&mode1=excelFile";
		document.forms[0].submit();
	}
	function showHabs(index){		
		var workid=document.forms[0].elements["psWorks["+index+"].workId"].value;
		var cdbs=document.forms[0].elements["psWorks["+index+"].coreDashboardStatus"].value;
		var probdate=document.forms[0].elements["psWorks["+index+"].probableDate"].value;
		var kpis=document.forms[0].elements["psWorks["+index+"].kpiStatus"].value;
		if(cdbs!='Y' || kpis!='Y' || probdate=='-'){
			alert("Please Select Probable Date(Target Date of Completion) and CM-SEC Dashboard,KPI Report for the WorkId("+workid+") as 'YES'");
			return false;
		}		
		var width = 1000;
		var height = 400;
		var left = parseInt((screen.availWidth/2)-(width/2));
		var top = parseInt((screen.availHeight/2)-(height/2));
		var newWindow;
		var url = "./switch.do?prefix=/works&page=/CMDBoard.do&mode=kpiHabs&workid="+workid+"&index="+index;
	    var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=yes,menubar=no,location=1,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,top=10,left=1";
		if( !newWindow || newWindow.closed)
		{
			newWindow = window.open(url, "", properties);
		}
		else
		{
			newWindow.focus();
		}	
	}
</script>


</head>

<%
	if (ad != null && (ad.equals("admin") || ad.equals("100000"))) {
%>
<body onload="checkMe();hideOrUnhideSVS();">
	<%
		} else {
	%>

<body onload="checkMe();show();">
	<%
		}
	%>
	<html:form action="CMDBoard.do" method="post"
		enctype="multipart/form-data">
		<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
		<table width="100%">
			<tr>
				<td align=right><a href="javascript:onClick=history.go(-1)">Back&nbsp;|&nbsp;</a>
					<a href="<rws:context page='/home.jsp'/>">Home&nbsp;|&nbsp;</a> 
			</tr>
		</table>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName"	value="Probable Date & Works To Be Displayed In Dashboard" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="none"
			width="100%" border=1 style="border-collapse: collapse;">
			<%
				if (ad != null && (ad.equals("admin") || ad.equals("100000"))) {
			%>
			<tr>
				<td class="bwborder">
					<fieldset>
						<legend>
							<B>Scheme Details</B>
						</legend>
						<label>
							<table style="border-collapse: collapse;border-color:#8A9FCD ">
								<tbody class="formTBody">
									<tr class="textborder">
										<td class="textborder">Scheme Type<span class="mandatory">*</span>
											<html:select property="schemeType" styleClass="combo"
												onchange="hideOrUnhide()">
												<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
												<html:option value="MVS">MVS</html:option>
												<html:option value="SVS">SVS</html:option>
											</html:select>
										</td>
									</tr>
								</tbody>
							</table>
						</label>
					</fieldset>
				</td>
			</tr>
			<%
				}
			%>
			<tr>
				<td class="bwborder">
					<div id="show" style="display: none;">
						<fieldset>
							<legend>
								<B>Office Details</B>
							</legend>
							<label>
								<table 	style="border-collapse: collapse;border-color: #8A9FCD">
									<tbody class="formTBody">
										<tr class="textborder">
											<%
												java.util.Date systemdate = new java.util.Date(	System.currentTimeMillis());
													java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
													String transdate = null;
													transdate = dateFormat.format(systemdate);
											%>
											<td class="textborder">Circle<span class="mandatory">*</span></td>
											<td><logic:equal name="RWS_USER"
													property="circleOfficeCode" value="00">
													<html:select property="circleOfficeCode" styleClass="combo"	onchange="getDivisions()">
														<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
														<logic:notEmpty name="circles">
															<html:options collection="circles" name="labelValueBean" property="value" labelProperty="label" />
														</logic:notEmpty>
													</html:select>
												</logic:equal> 
												<logic:notEqual name="RWS_USER" property="circleOfficeCode"	value="00">
													<html:text property="circleOfficeName"	styleClass="thin-text-box" name="RWS_USER" readonly="true" />
													<html:hidden property="circleOfficeCode" name="RWS_USER" />
												</logic:notEqual></td>
											<td class="textborder">&nbsp;Division<span	class="mandatory">*</span></td>
											<td>
												<logic:equal name="RWS_USER" property="divisionOfficeCode" value="0">
													<html:select property="divisionOfficeCode"	styleClass="combo" onchange="getSubDivisions()">
														<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
														<logic:notEmpty name="divisions">
															<html:options collection="divisions" name="labelValueBean" property="value"	labelProperty="label" />
														</logic:notEmpty>
													</html:select>
												</logic:equal> 
												<logic:notEqual name="RWS_USER"	property="divisionOfficeCode" value="0">
													<html:text property="divisionOfficeName" styleClass="thin-text-box" name="RWS_USER" readonly="true" />
													<html:hidden property="divisionOfficeCode" name="RWS_USER" />
												</logic:notEqual>
											</td>
											<td class="textborder">&nbsp;Sub&nbsp;Division</td>
											<td><logic:equal name="RWS_USER" property="subdivisionOfficeCode" value="0">
													<html:select property="subdivisionOfficeCode" styleClass="combo">
														<html:option value="0">	<bean:message key="app.pleaseSelect" />	</html:option>
														<logic:notEmpty name="subDivisions">
															<html:options collection="subDivisions"	name="labelValueBean" property="value"	labelProperty="label" />
														</logic:notEmpty>
													</html:select>
												</logic:equal> 
												<logic:notEqual name="RWS_USER"	property="subdivisionOfficeCode" value="0">
													<html:text property="subdivisionOfficeName"	styleClass="thin-text-box" name="RWS_USER" readonly="true" />
													<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
												</logic:notEqual>
											</td>
											<td class="textborder"><html:radio property="type"	value="1" />Plan&nbsp;</td>
											<td class="textborder"><html:radio property="type"	value="2" />Non&nbsp;Plan</td>																				
											<td class="textborder">&nbsp;&nbsp;Category</td>
											<td><html:select property="category" styleClass="combo"	onchange="javascript:getPrograms();">
													<html:option value="0">	<bean:message key="app.pleaseSelect" />	</html:option>
													<html:option value="1">Projects</html:option>
													<html:option value="2">Normal</html:option>
													<html:option value="3">District Level</html:option>
												</html:select></td>

										</tr>
										<tr></tr>
										<tr class="textborder">
											<logic:present name="programs">
												<td class="textborder">Programs:</td>
												<td class="textborder">
												<html:select property="programCode" style="width:143px"	styleClass="combo">
														<html:option value="0"><bean:message key="app.pleaseSelect" />	</html:option>
														<html:options collection="programs" property="value" labelProperty="label" />
													</html:select></td>
											</logic:present>
											<logic:present name="schemes">
												<td class="textborder">Schemes:</td>
												<td class="textborder">
												<html:select property="schemeCode" style="width:143px"	styleClass="combo">
														<html:option value="0">	<bean:message key="app.pleaseSelect" />	</html:option>
														<html:options collection="schemes" property="value"	labelProperty="label" />
												</html:select></td>
											</logic:present>
										</tr>
										<tr></tr>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td><input type="button"	onclick="javascript:getWorks();" value="Get Works"	class=btext id="savebutton"></td>
								</table>
							</label>
						</fieldset>
					</div>
				</td>

				<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="100%" border=1
					style="border-collapse: collapse">
					<tr bgcolor="#8A9FCD">
						<td class="bwborder" colspan="25"><B><font
								color="#FFFFFF">Ongoing Works </B></td>
						<td align="center"></td>
					</tr>
					<tr>
						<td class="clrborder" align="center" rowspan="2">S.No.</td>
						<td class="clrborder" align="center" rowspan="2">District /<br />Division	</td>					
						<td class="clrborder" align="center" rowspan="2">Lead Hab Mandal</td>
						<td class="clrborder" align="center" rowspan="2">Work ID /<br />Work Name	</td>						
						<td class="clrborder" align="center" rowspan="2">Program Name/<br>SubProgram Name</td>
						<td class="clrborder" align="center" rowspan="2">Sanction date</td>
						<td class="clrborder" align="center" rowspan="2">Est. Cost<br>(in lakhs)</td>						
						<td class="clrborder" align="center" rowspan="2">Probable Date(Target Date of Completion)<font color="red"><b>*</b></font>	</td>					
						<td class="clrborder" align="center" rowspan="2">CM-SEC	Dashboard</td>	
						<td class="clrborder" align="center" rowspan="2" width="10%">KPI Report</td>					
						<td class="clrborder" align="center" rowspan="2">Check</td>
					</tr>
					<tr>						
					</tr>

					<logic:notEmpty name="PSWorkProbabledtForm" property="psWorks">
						<logic:iterate id="psWorks" name="PSWorkProbabledtForm"
							property="psWorks" indexId="ndx">

							<tr align="left" onclick="toggleRowColor(this)">
								<td class="bwborder"><%=count++%></td>
								<td class="bwborder"><bean:write name="psWorks"	property="dname" />/<br />
									<bean:write name="psWorks" property="divname" /></td>								
								<td class="bwborder"><bean:write name="psWorks"	property="mname" /></td>
								<td class="bwborder"><bean:write name="psWorks"	property="workId" /> /<br />
									<bean:write name="psWorks" property="workName" /></td>								
								<html:hidden name="psWorks" property="workId" indexed="true" />
								<td class="bwborder"><bean:write name="psWorks"	property="progName" />/<br>
									<bean:write name="psWorks" property="subprogName" /></td>
								<td class="bwborder"><bean:write name="psWorks"	property="admnDate" /></td>
								<td class="bwborder" align="right"><bean:write	name="psWorks" property="admnAmnt" /></td>	
								<td nowrap>									
									<html:text name="psWorks" property="probableDate" indexed="true" style="width: 70px" styleClass="noborder-text-box" readonly="true" /> 
									<a	href="javascript: showCalendarFuture(document.getElementById('psWorks[<%=ndx%>].probableDate'));">
									<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20"	border="0" height="17" align="absmiddle"></a> 
								</td>
								<td class="bwborder"><html:select name="psWorks" property="coreDashboardStatus" styleClass="mycombo" style="width:80px" indexed="true">
										<html:option value=""><font class="myfontclr1">SELECT...</font>	</html:option>
										<html:option value="Y">Yes</html:option>
										<html:option value="N">No</html:option>
									</html:select>
								</td>
								<td class="bwborder">
										<html:select name="psWorks"	property="kpiStatus" styleClass="mycombo" style="width:80px" indexed="true" >
											<html:option value=""><font class="myfontclr1">SELECT...</font></html:option>
											<html:option value="Y">Yes</html:option>
											<html:option value="N">No</html:option>
										</html:select> 
										<html:button style="width: 30px; height: 20px" property="kpiButton" onclick='<%= "javascript : showHabs(" +ndx +"); " %>'>...</html:button>
										<html:hidden name="psWorks" property="kpiHabList" indexed="true" />
									</td>
								<td class="bwborder" align=center><html:checkbox name="psWorks" property="checks" indexed="true" /></td>
							</tr>
						</logic:iterate>
					</logic:notEmpty>
					<%if(count==1){ %><tr>
						<td colspan="18" align="center" class="btext">No Records</td>
					</tr>
					<%}
					else{%><tr>
						<td colspan="18" align="center"><input type=button value=Save
							onClick="fnSave(this);" class="btext"></td>
					</tr>
					<%}%>
					<input type="hidden" name="resultCount" value="<%=count%>">
					<html:hidden property="deldate" value='<%=transdate%>' />
				</table>

				<jsp:include page="/commons/TableFotter.jsp">
					<jsp:param name="TWidth" value="100%" />
				</jsp:include>
				<input type=hidden name=work>
				<p align=center>
					<font face="verdana" size="2" color="red"> <b>Note********:
							In this Report All Newly Sanctioned and Ongoing Works are
							Displayed </b></font>
				<table align="center" cellpadding="0" cellspacing="0" border=0>
					<tr>
						<td><span class="style1"><li>Stipulated Date
									calucalation based on given Agreement Date + Agreement Duration</li></span></td>
					</tr>
					<tr>
						<td><span class="style1"><li>'-' Represents NO
									DATA</li></span></td>
					</tr>
				</table>
				</p>
				<br>
			</tr>
		</table>
	</html:form>
</body>

<script>
var ad='<%= (String)session.getAttribute("userId")%>';
if(ad=="admin" || ad=="100000")
{
}
else
{
}
</script>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>