<%@ include file="/commons/rws_header1.jsp"%>
<html:html>

<style type="text/css">
.text2bold {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	COLOR: #338de8;
	FONT-SIZE: 9px;
	TEXT-DECORATION: none
}

.text2bold1 {
	FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;
	COLOR: black;
	FONT-SIZE: 9px;
	FONT-WEIGHT: bold;
	TEXT-DECORATION: none
}

body {
	background: #FFF;
	color: #000;
	font: normal normal 10px Verdana, Geneva, Arial, Helvetica, sans-serif;
}

table, td, a {
	font: normal normal 12px Verdana, Geneva, Arial, Helvetica, sans-serif;
}

div#tbl-container22 {
	width: 1320px;
	height: 430px;
	overflow: auto;
	scrollbar-base-color: #C9C299;
}

div#tbl-container22 tr.normalRow td {
	background: #fff;
	font-size: 11px;
	height: 50px;
}

div#tbl-container22 tr.alternateRow td {
	background: #B6C9AD;
	font-size: 8px; .
	height: 21px;
}

div#tbl-container22 table {
	table-layout: fixed;
	border-collapse: collapse;
	background-color: WhiteSmoke;
}

div#tbl-container22 table th {
	height: 30px;
}

div#tbl-container22 thead th, div#tbl-container22 thead th.locked {
	font-size: 10px;
	font-weight: bold;
	text-align: center;
	background-color: #2B3856;
	color: white;
	position: relative;
	cursor: default;
}

div#tbl-container22 thead th {
	top: expression(document.getElementById ( "tbl-container22")
		.scrollTop-2); /* IE5+ only */
	z-index: 10;
}

div#tbl-container22 thead th.locked {
	z-index: 30;
}

div#tbl-container22 td.locked, div#tbl-container22 th.locked {
	background-color: #ffeaff;
	font-size: 12px;
	left: expression(document.getElementById ( "tbl-container22")
		.scrollLeft); /* IE5+ only */
	position: relative;
	z-index: 10;
	height: 40px;
}
-->
</style>

<style type="text/css">
.container {
	font-family: verdana, arial, helvetica, sans-serif;
	font-size: 0.9em;
	margin: 4px 0;
}

.container img {
	width: 16px;
	vertical-align: bottom;
}

.container span {
	font-weight: bold;
	cursor: pointer;
}

.off {
	display: none;
}

.on {
	width: 400px;
	margin: 10px 30px;
	text-align: justify;
	color: #003;
	background-color: #eef;
}
</style>
<%
	int count = 1;
	Date systemdate = new java.util.Date(System.currentTimeMillis());
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	String transdate = null;
	transdate = dateFormat.format(systemdate);
%>

<script language="JavaScript">

function getHabs()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=Habs";
	document.forms[0].submit();
}

function getMandal()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=mandal";
	document.forms[0].submit();
}

function getPanch()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=panch";
	document.forms[0].submit();
}

function getVillage()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=village";
	document.forms[0].submit();
}

function getData2()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=data";
	document.forms[0].submit();
}

function getData3()
{
	document.forms[0].action="switch.do?prefix=/drought&page=/sstank.do?mode=view";
	document.forms[0].submit();
}



function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');
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

function toggleItem(id)
{   
	itm = getItem(id);
	if(id=="collapse_myTbody2")
	var im = "onea";
	else if(id=="collapse_myTbody3")
	var im = "onec";
	else
	var im = "oneb";
	if(!itm)
	return false;
	if(itm.style.display == 'none'){
	itm.style.display = '';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/collapse.gif";
	}
	}    
	else{
	itm.style.display = 'none';
	if (document.images[im]) {
	document.images[im].src = "/pred/images/expand.gif";
	}
	}	      
	return false;
	}
function getData4()
{

document.forms[0].elements["OptionsDiv111"].style.display='block';
}
function fnSave()
{
	
	var district='<%=request.getParameter("dist")%>';
	var mandal='<%=request.getParameter("mand")%>';
	var habcode='<%=request.getParameter("habCode")%>';
    var finyear='<%=request.getParameter("sdrDate")%>	';
		var len = document.forms[0].resultCount.value;
		var flag=false;

		if (document.forms[0].elements["sdrDate"].value == "") {

			alert("Please Select Drought Date");
			return;
		}
		len = len - 1;
		for (var j = 0; j < len; j++) {
			if (document.forms[0].elements["hps[" + j + "].checks"].checked == true) {
				flag=true;
				if (document.forms[0].elements["hps[" + j + "].spopServed"].value == 0) {
					alert("Please Enter  Population Served By Tank");

					return;
				} else if (document.forms[0].elements["hps[" + j
						+ "].sriverVaguName"].value == 0) {
					alert("Please Enter River/Vagu Name");

					return;
				} else if (document.forms[0].elements["hps[" + j
						+ "].scanalName"].value == 0) {
					alert("Please Please Enter  Canal Name");

					return;
				} else if (document.forms[0].elements["hps[" + j
						+ "].stankCapacity"].value == 0) {
					alert("Please Please Enter  Tank Capacity");

					return;
				} else if (document.forms[0].elements["hps[" + j
						+ "].swaterSupplyDays"].value == 0) {
					alert("Please Please Enter Water  Supply No Of Days.");

					return;
				} else if (document.forms[0].elements["hps[" + j
						+ "].sfillingStatus"].value == '') {
					alert("Please Please Enter Present Status.");

					return;
				}

			}

		}
		if(!flag){
			 alert("Please Select Check Box For Save The Record");
			/*document.forms[0].elements['sBtn'].value="Save";
			 document.forms[0].elements['sBtn'].disabled=false; */
			 return;
		}else{
		if (confirm("Are You Sure To Save The Checked SS Tank(s)")) {
			//document.forms[0].hab1.value = habitations1;
			document.forms[0].action = "switch.do?prefix=/drought&page=/sstank.do&mode=save&dist="
					+ district
					+ "&mand="
					+ mandal
					+ "&habCode="
					+ habcode
					+ "&finyear=" + finyear;
			document.forms[0].submit();
		}
		}
}

function hide(value)
{
	var len=document.forms[0].resultCount.value;
	len = len-1;
	for( var j=0;j<len;j++)
	{     
	    if(document.forms[0].elements["hps["+j+"].sstepsTaken"].value=='N'){
     		document.forms[0].elements["hps["+j+"].stakenReasons"].disabled=true;
		}else if(document.forms[0].elements["hps["+j+"].sstepsTaken"].value=='Y'){
    		document.forms[0].elements["hps["+j+"].stakenReasons"].disabled=false;
		}else{
			document.forms[0].elements["hps["+j+"].stakenReasons"].disabled=true;
		}
 	}
	if(value=="a")
	{
  		hide1();
	}
}
function hide1()
	{
	//alert(" i am in hide1()");
	var len=document.forms[0].resultCount.value;
			//alert(len);
	len = len-1;
	
	for( var j=0;j<len;j++)
	{     
	    if(document.forms[0].elements["hps["+j+"].sidentifiedAlternative"].value=='N')
	{
	    document.forms[0].elements["hps["+j+"].sidentifiedReasons"].disabled=true;
	} 
	 else if(document.forms[0].elements["hps["+j+"].sidentifiedAlternative"].value=='Y'){
	    document.forms[0].elements["hps["+j+"].sidentifiedReasons"].disabled=false;
	   }
	else
	{
	   document.forms[0].elements["hps["+j+"].sidentifiedReasons"].disabled=true;
	}
	}
}
function getCanalName(count){
	var s=document.forms[0].elements["hps["+(count-2)+"].sriverVaguName"];
	var test=s.options[s.selectedIndex].innerHTML;
	var str=test.split(" @ ");
	document.forms[0].elements["hps["+(count-2)+"].scanalName"].value=str[1];
}
</script>

<body onload="javascript:hide('a');">
	<%@ include file="/commons/rws_header2.jsp"%>
	<html:form action="sstank.do">


		<%
			String csrfToken = "";
					nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
					csrfToken = valUtil.getCSRFCode();
					session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />



		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="DROUGHT SS TANKS ENTRY" />
			<jsp:param name="TWidth" value="1280" />
		</jsp:include>
		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
			style="border-collapse: collapse;" width="1320">
			<tr>
				<td>
					<fieldset>
						<legend>
							<bean:message key="legend.habitationDetails" />
						</legend>
						<label>
							<table border=0 width="100%" align=center
								style="margin-bottom: 0; margin-top: 0">
								<tr>
									<td class="textborder"><bean:message key="app.district" /><font
										color="#FF6666">*</font></td>
									<td class="textborder"><html:select property="dist"
											styleClass="mycombo" style="width:150px"
											onchange="javascript:getMandal()">
											<html:option value="">
												<font class="myfontclr1">SELECT... 
											</html:option>
											<logic:present name="districts">
												<html:options collection="districts" name="rwsLocationBean"
													property="value" labelProperty="label" />
											</logic:present>
										</html:select></td>
									<td class="textborder"><bean:message key="app.mandal" /><font
										color="#FF6666">*</font>
									<td class="textborder"><html:select property="mand"
											styleClass="mycombo" style="width:130px"
											onchange="javascript:getPanch()">
											<html:option value="">
												<font class="myfontclr1">SELECT... 
											</html:option>
											<logic:present name="mandals">
												<html:options collection="mandals" name="rwsLocationBean"
													property="value" labelProperty="label" />
											</logic:present>
										</html:select></td>
									<td class="textborder"><bean:message key="app.panchayat" /><font
										color="#FF6666">*</font></td>
									<td class="textborder"><html:select property="panch"
											styleClass="mycombo" style="width:150px"
											onchange="javascript:getVillage()">
											<html:option value="">SELECT...</html:option>
											<logic:present name="panchayats">
												<html:options collection="panchayats" name="rwsLocationBean"
													property="value" labelProperty="label" />
											</logic:present>
										</html:select></td>
									<td class="textborder"><bean:message key="app.village" /><font
										color="#FF6666">*</font></td>
									<td class="textborder"><html:select property="vill"
											styleClass="mycombo" style="width:150px"
											onchange="javascript:getHabs()">
											<html:option value="">SELECT...</html:option>
											<logic:present name="villages">
												<html:options collection="villages" name="rwsLocationBean"
													property="value" labelProperty="label" />
											</logic:present>
										</html:select></td>
								</tr>
								<tr>
									<td class="textborder"><bean:message key="app.habCode" /><font
										color="#FF6666">*</font></td>
									<td class="textborder" colspan=3><html:select
											property="habCode" styleClass="mycombo" style="width:350px"
											onchange="javascript:getData3()">
											<html:option value="">SELECT...</html:option>
											<logic:present name="habitations">
												<html:options collection="habitations"
													name="rwsLocationBean" property="value"
													labelProperty="labelValue" />
											</logic:present>
										</html:select></td>
									<!-- <td class="textborder" width="100">Fin.Year<font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:select property="finYear" styleClass="mycombo" style="width:150px">
		<!--<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="dryears">
		<html:options collection="dryears" name="rwsLocationBean" property="value" labelProperty="value" />
        </logic:present>
		</html:select>
		</td> -->



									<td class="textborder">Date<font color="#FF6666">*</font></td>
									<td class="textborder" colspan=3><html:select
											property="sdrDate" styleClass="mycombo" style="width:350px"
											onchange="javascript:getData3()">
											<html:option value="">SELECT...</html:option>
											<logic:present name="weekdates">
												<html:options collection="weekdates" name="rwsLocationBean"
													property="value" labelProperty="labelValue" />
											</logic:present>
										</html:select></td>

</tr>
    </table>
		</label>
	</fieldset>
	</td>
</tr>
</table>
<div id="tbl-container22">

<table id="tbl" border = 1 align=center bordercolor=black style="border-collapse:collapse">
	
<thead class="fixedHeader">
<tr align="center">
<th class="locked" align="center" rowspan="2" width=30>Select</th>
<th class="locked" align=center rowspan="2" width=30>Sl.No</th>
<th class="locked" align=center rowspan="2" width=200>SSSCode<br>(Drought Date)</th>
<th class="locked" align="center" colspan=2" width=250>Scheme details</th>
<th class=clrborder align="center" rowspan="2" width=100><font color="red"><b>*</b></font>Population served<br> by Tank</th>
<th class=clrborder align="center" colspan="2" width=250>Source of Feeding</th>
<th class=clrborder align="center" rowspan="2" width=100><font color="red"><b>*</b></font>Tank Capacity(Full)<br> litres in lakhs</th>
<th class=clrborder align="center" rowspan="2" width=100> <font color="red"><b>*</b></font>How many days water can be supplied ,<br> if the tank is filled<br> upto full capacity</th>
<th class=clrborder align="center" rowspan="2" width=100><font color="red"><b>*</b></font>Present status <br> (% of filling)</th>
<th class=clrborder align="center" rowspan="2" width=100>Date of Full Filling</th>
<th class=clrborder align="center" rowspan="2" width=100>Probable date <br>of Canal closure <br>(dd/mm/yy)</th>
<th class=clrborder align="center" rowspan="2" width=100>Probable date<br> of re opening and<br> intermitant fillings <br>if any (dd/mm/yy)</th>
<th class=clrborder align="center" rowspan="2" width=100>Whether steps have <br>been taken to fill up  <br>SS Tank to full capacity <br> before canal closure <br> and contingent plan to <br> fill up tank to  <br>full capacity</th>
<th class=clrborder align="center" rowspan="2" width=100>Steps Taken</th>
<th class=clrborder align="center" rowspan="2" width=100>Identified alternative <br>measures to mitigate<br> scarcity(if araises) in case<br> of longer canal closure due <br>to Mtc./Non filling of<br> Tank to full capacity etc.</th>
<th class=clrborder align="center" rowspan="2" width=100>Identified Alternatives</th>
<th class=clrborder align="center" rowspan="2" width=200>Remarks<br>(specific problems and also <br>reasons for less than 50% <br>filling and present supply <br>measures for 0% filling))</th>
</tr>
<tr align="center">
<th class="locked" align="center" width=250>Scheme Name</th>
<th class="locked" align="center" width=50>No. of habs covering</th>
<th class=clrborder align="center" width=200><font color="red"><b>*</b></font>Name of <br>River/Vagu /etc.</th>
<th class=clrborder align="center" width=200><font color="red"><b>*</b></font>Canal Name</th>
</thead>

<%
try{ %>
	<logic:notEmpty name="DroughtForm" property="hps">
	
	<nested:iterate id="hps" name="DroughtForm" property="hps" indexId="ndx">
	
	
	<tr align="left" id='tr<%=count%>'	onmouseover="this.style.background='#E3E4FA'" onmouseout="this.style.background='WHITE'">
	<td class="locked">
      	<html:checkbox name="hps" property="checks"   indexed="true"  />
	</td>
    <td class="locked"><%=count++%><nested:hidden name="hps"
		property="sdroughtDate" indexed="true" /> 

<nested:hidden name="hps"
		property="shabCode" indexed="true" />
		
<nested:hidden name="hps"
		property="shabName" indexed="true" /> </td>

		<td class="locked" class=bwborder width="200" align=left nowrap><nested:hidden name="hps"
		property="ssscCode" indexed="true" /><nested:write
		name="hps" property="ssscCode" /><br>&nbsp;&nbsp;&nbsp;&nbsp;(<nested:write
		name="hps" property="sdroughtDate" />)</td>


		<nested:hidden name="hps"
		property="assetCode" indexed="true"/>

     
    <td class="locked" class=bwborder align=left nowrap width="150">
	<nested:write  name="hps" property="sschemeName" />
	</td>
    <td  class="locked"class=bwborder align=left nowrap width="30">
	   <nested:write  name="hps" property="habCount" />
	</td>
<td class=bwborder align=center nowrap width="100" >
	<html:text name="hps" size="10" property="spopServed"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
	<%
	String canalNameChange="getCanalName("+count+")";
	%>
   <td  align="center" class="rptValue" width="200">
	                  <logic:present name="assetsources">
							<html:select  name="hps" property="sriverVaguName" styleClass="mycombo" style="width:150px" indexed="true" onchange="<%=canalNameChange %>" >
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="assetsources" name="labelValueBean"
										  property="value" labelProperty="labelValue" />
							</html:select>					
					</logic:present>
	</td>
<td  align="center"  class="rptValue" width="150">
	<html:text name="hps" size="15" property="scanalName"  indexed="true" onkeypress="return alpha(event)" /> 
	</td>
<td  align="center"  class="rptValue" width="100">
	<html:text name="hps" size="10" property="stankCapacity"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
<td  align="center"  class="rptValue" width="100">
	<html:text name="hps" size="10" property="swaterSupplyDays"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
<!-- <td  align="left" class="locked" class="rptValue">
	<html:text name="hps" size="5" property="stankNo"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td> -->
<td  align="center"class="rptValue" width="100">
	<html:text name="hps" size="10" property="sfillingStatus"  indexed="true"  onkeypress="return decimalsOnly(event)" /> 
	</td>
<td  align="center" class="rptValue" nowrap width="100">
	<html:text name="hps" size="7" property="sfillDate"  indexed="true"/><a href="javascript: showCalendarFuture(document.forms[0].elements['hps[<%=count-2 %>].sfillDate']);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"> </a>
	</td>
<td  align="center"  class="rptValue" width="100">
	<html:text name="hps" size="7" property="scanalPrbDate"  indexed="true"/><a href="javascript: showCalendarFuture(document.forms[0].elements['hps[<%=count-2 %>].scanalPrbDate']);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"> </a>
	</td>
<td  align="center"  class="rptValue" width="100">
	<html:text name="hps" size="7" property="sreopenPrbData"  indexed="true"  /><a href="javascript: showCalendarFuture(document.forms[0].elements['hps[<%=count-2 %>].sreopenPrbData']);">
							  <IMG SRC="<rws:context page='/images/calendar.gif'/>
							   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>

<td  align="center" class="rptValue" nowrap width="100">
	    <html:select name="hps"  property="sstepsTaken" styleClass="mycombo" indexed="true"  style="width:230px" onchange="hide('b');">
        <html:option value=""><font class="myfontclr1">SELECT</html:option>	
        <html:option value="Y"><font class="myfontclr1">YES</html:option>
        <html:option value="N"><font class="myfontclr1">NO</html:option>
		</html:select>
</td>

<td  align="center" class="rptValue" nowrap width="100">
	    <html:select name="hps"  property="stakenReasons" styleClass="mycombo" indexed="true"  style="width:230px">
       	<html:option value=""><font class="myfontclr1">SELECT</html:option>
       	<html:option value="By filling before canal closure"><font class="myfontclr1">By filling before canal closure</html:option>
		<html:option value="By pumping before canal closure"><font class="myfontclr1">By pumping before canal closure</html:option>
		<html:option value="others"><font class="myfontclr1">others</html:option>
		</html:select>
</td>
<td align="center" class="rptValue" nowrap width="100">
	    <html:select name="hps"  property="sidentifiedAlternative" styleClass="mycombo" indexed="true"  style="width:230px" onchange="hide1();">
<html:option value=""><font class="myfontclr1">SELECT</html:option>
<html:option value="Y"><font class="myfontclr1">YES</html:option>
        <html:option value="N"><font class="myfontclr1">NO</html:option>
		</html:select>
</td>
<td  align="center" class="rptValue" nowrap width="100">
	<html:select name="hps"  property="sidentifiedReasons" styleClass="mycombo" indexed="true"  style="width:250px">
  	<html:option value=""><font class="myfontclr1">SELECT</html:option>
    <html:option value="Transportation of Drinking water"><font class="myfontclr1">Transportation  of Drinking water</html:option>
		<html:option value="Hand pumps"><font class="myfontclr1">Hand pumps</html:option>
		<html:option value="Shallow Hand Pumps"><font class="myfontclr1">Shallow Hand Pumps</html:option>
		<html:option value="Scheme with Bore well Source"><font class="myfontclr1">Scheme with Bore well Source</html:option>
		<html:option value="Rationing of Water supply"><font class="myfontclr1">Rationing of Water supply</html:option>
		<html:option value="Alternative sources idetified"><font class="myfontclr1">Alternative sources identified</html:option>
		<html:option value="Connected with CPWSS"><font class="myfontclr1">Connected with CPWSS</html:option>
		<html:option value="others"><font class="myfontclr1">others</html:option>
		</html:select>

</td>
	<td  align="center"  class="rptValue" width="100">
	<html:textarea name="hps" rows="3" cols="25" property="stankRemarks"  indexed="true" onkeypress="return alpha(event)" /> 
	</td>		

		
</tr>
				
</nested:iterate>
</logic:notEmpty>

<logic:empty  name="DroughtForm" property="hps">
	<tr>
	<td colspan=11 align=center>No Records</td>
	</tr>
</logic:empty>
	<%
	
}catch(Exception p)
{
System.out.println("Exception in compaints status jsp:"+p);
}
%>


</table>

</div>

<tr align=center>
<td>
<input type="button"  name="Save"   value="&nbsp;&nbsp;Save&nbsp;&nbsp;" onclick="fnSave();">
</td>
</tr>
<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="1320"/>
</jsp:include>
<tr align=center>
	<td align="center" >
		<input type="hidden" name="resultCount" value="<%=count%>">
	
</td>
</tr>
		<input type=hidden name=hab1>


	</html:form>
</html:html>
<p align="center">
	<%@ include file="/commons/rws_footer.jsp"%>
</p>
<script language="javascript">
<%if (request.getAttribute("message") != null) {%>
 alert('<%=request.getAttribute("message")%>');
<%}%>
</script>