<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%@ include file="/masters/Rws_Habstatus_Entry_Frm_Script.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	userid = users.getUserId();
	//System.out.println("user id:"+userid);
	Calendar rightNow = Calendar.getInstance();
  	int year = rightNow.get(Calendar.YEAR);
  	String cstatus = (String)request.getAttribute("status");
%>
<%@ include file="/commons/rws_header2.jsp" %>
<script language="javascript">
function resetHab(value)
{
	if(value=="circle")
	{
		document.forms[0].mandal.value = '';
		document.forms[0].pcode.value = '';
		document.forms[0].habCode.value = '';
	}
	else if(value=="mandal")
	{
		document.forms[0].pcode.value = '';
		document.forms[0].habCode.value = '';
	}
	else if(value=="panchayat")
	{
		document.forms[0].habCode.value = '';
	}

}
function remainUncheck(i)
{
	document.forms[0].contTypes1.checked = false;
	document.forms[0].contTypes2.checked = false;
	document.forms[0].contTypes3.checked = false;
	document.forms[0].contTypes4.checked = false;
	document.forms[0].contTypes5.checked = false;
	if(i==1)document.forms[0].contTypes1.checked = true;
	else if(i==2)document.forms[0].contTypes2.checked = true;
	else if(i==3)document.forms[0].contTypes3.checked = true;
	else if(i==4)document.forms[0].contTypes4.checked = true;
	else if(i==5)document.forms[0].contTypes5.checked = true;
}
function fnCoverageChange()
 {
var userIdd = '<%=userid%>';
if(userIdd!='admin')
{
 alert("You Can Not Update Coverage Status");
}
 }
 function coverageStatusCombos()
 {
 	alert("sdfdsfsdsdfsdfsdfs");
 }
 function removeOption()
 {
 for (var i=document.forms[0].status.options.length-1; i>=0; i--){
    status.options[i] = null;
  }
 
 }
 function addOption(calCoverageStatus)
{
//alert(calCoverageStatus);
var userIdd = '<%=userid%>';
var covStatus = '<%=cstatus%>';
if(userIdd=='admin' || userIdd=='100000')
{
document.forms[0].status.options.length = 0; 
	//alert("1:"+calCoverageStatus);
	if(calCoverageStatus=='UI' || covStatus=='UI')
	{
		var optn = document.createElement("OPTION");
		var combo = document.getElementById("status");  
		optn.text = "UI";
		optn.value = "UI";
		combo.add(optn);
		if(covStatus=='UI')
		{
			optn = document.createElement("OPTION");
			optn.text = calCoverageStatus;
			optn.value = calCoverageStatus;
			combo.add(optn);
		}
	}
	else
	{
		var optn = document.createElement("OPTION");
		var combo = document.getElementById("status");  
		optn.text = calCoverageStatus;
		optn.value = calCoverageStatus;
		combo.add(optn);
		optn = document.createElement("OPTION");
		optn.text = "UI";
		optn.value = "UI";
		combo.add(optn);
	}

}	
if(calCoverageStatus=='NC')
{
	document.getElementById('covnc').style.display='block';
	document.getElementById('covnotnc').style.display='none';
}
else
{
	document.getElementById('covnc').style.display='none';
	document.getElementById('covnotnc').style.display='block';
}
if(calCoverageStatus=='NSS')
{
	document.getElementById('conti').style.display='block';
}
else
{
	document.getElementById('conti').style.display='none';
}

}
</script>
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
<html:javascript formName="habStatusForm" />
<body>
<html:form action="HabStatus.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Habitation Directory Entry Form" />
		<jsp:param name="contextHelpUrl" value="/pred/help/HabitationStatushelp.doc" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

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
<body onload="findTotal('levelOfWater');">
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="780" >


<%@ include file="/masters/rws_habStatusEntry_frm_OfficeSelect.jsp" %>


	
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.habitationDetails"/></legend>
	<label>
	<table border=0 width="100%" align="center" border=0>
	<tr>
	<td class="textborder" width="80"><bean:message key="app.district" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:text property="district" style="width:150px" value="<%=(String)request.getAttribute(\"distName\")%>" styleClass="mytext" readonly="true" />
		<html:hidden property="dcode" />
		<html:hidden property="init" />
	</td>
	<td class="textborder" width="100"><bean:message key="app.mandal" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="mandal" styleClass="mycombo" style="width:150px" onchange="javascript:resetHab('mandal');getHabDirData1()" >
			<html:option value="">SELECT...</html:option>
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
		</html:select>
	</td>
	
	<td class="textborder" width="100"><bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="pcode" styleClass="mycombo" style="width:150px"  onchange="javascript:resetHab('panchayat');getHabDirData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="panchyats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
	</td>
	</tr>
	<!--  
	<tr>
	<td class="textborder" width="80"><bean:message key="app.village" /><font color="#FF6666">*</font></td>
	<td  class="textborder" width="150">
		<html:select property="vcode" styleClass="mycombo" style="width:150px"   onchange="javascript:getHabDirData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
		</html:select>
	</td>
	-->
	<tr>
	<td class="textborder" nowrap width="100"><bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getHabDirData1()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="habs" name="rwsLocationBean" property="habCode" labelProperty="habName" />
		</html:select>
	</td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
 
<logic:notEqual name="habStatusForm" property="updateDate" value="">
<tr>
  <td  bgcolor="#8A9FCD">
  <font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >Habitation Data Last Updated Date:&nbsp;</font><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" ><bean:write name="habStatusForm" property="updateDate"/></font>
  <!-- <font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Update Coverage Status As on 01-APR-<%= year %></font> changed on 030409-->
 <font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:white">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Update Coverage Status As on 01-APR-2010</font>
  </td>
 </tr>
 </logic:notEqual>
  
<tr>
<td>
<table border=0 width="19%" height="20%">
<tr>
<td class="textborder" nowrap>&nbsp;<bean:message key="app.cnsYear" />&nbsp;&nbsp;&nbsp;</td>
			
<td class="textborder">
 <html:select property="censusYear" styleClass="mycombo" 
					 style="width:70px" onchange="setValue()">
				<%

		Calendar cal = new GregorianCalendar();
		int syear = cal.get(Calendar.YEAR);
//		Debug.println("//System Year"+syear);
		int[] census = {2001, 2011, 2021,2031,2041,2051,2061,2071,2081,2091};

		int i = 0;

		for (i=0; i < census.length ; i ++)
		{
			if (syear < census[i])
			{
				//out.println(census [i]);
			}
			else
			{ 
				%>
			<html:option value="<%= String.valueOf(census[i]) %>" > <%=census [i]%> </html:option>
		

			<%}
		}

%>
			
		</html:select>
		</td>
		 <td class="textborder" nowrap>Habitation Type<font color="#FF6666">*</font></td>
		<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;
		                <html:select property="habType" styleClass="mycombo" style="width:80px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="NORMAL">NORMAL</html:option>
		                       <html:option value="AGENCY">AGENCY</html:option>
		                       <html:option value="COASTAL">COASTAL</html:option>
		                </html:select>   
		</td>
		<td class="textborder" nowrap>Habitation SubType<font color="#FF6666">*</font></td>
		<td class="textborder">&nbsp;&nbsp;&nbsp;&nbsp;
		                <html:select property="habSubType" styleClass="mycombo" style="width:80px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="PLAIN">PLAIN</html:option>
		                       <html:option value="SC">SC</html:option>
		                       <html:option value="ST">ST</html:option>
		                </html:select>   
		</td>
		<td class="textborder" nowrap>&nbsp;Habitation Category</td>
		<td class="textborder">
		                <html:select property="habCat" styleClass="mycombo" style="width:65px">
		                       <html:option value="NONE">NONE</html:option>
    	                       <html:option value="HILLY">HILLY</html:option>
    	                       <html:option value="DDP">DDP</html:option>
		                       
		                </html:select>   
		</td>

</tr>
<tr>
<td class="textborder" nowrap colspan="4">&nbsp;Is Minority Dominated?&nbsp;&nbsp;
	<html:checkbox property="isMinorityHab" title="Tick the CheckBox if the Habitation is Minority Dominated"/>
</td>
<td class="textborder" nowrap colspan="4">&nbsp;Is Left Wing Extremism (LWE)/Naxal Affected area?&nbsp;&nbsp;
	<html:checkbox property="isLwe" title="Tick the CheckBox if the Habitation is Minority Dominated"/>
</td>
</tr>
</table>
</td>
</tr>
<tr>

<td>
	<table>
	<tr>
	<td>	
		<fieldset>
		<legend>Census Population</legend>
		<label>
		<table border=0 width="100%" height="100%">
		<tr>
			<td class="textborder"><bean:message key="app.plainPop" /></td>
			<td class="textborder">
				<html:text property="censusPop" styleClass="mytext" 
						   style="width:50px" tabindex="1" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')" onkeyup="findTotal('totPop');findTotal('netPop');findTotal('levelOfWater')"/>
			</td>
			<td class="textborder"><bean:message key="app.floatPop" /></td>
			<td class="textborder">
				<html:text property="floatPop" styleClass="mytext" 
						   style="width:50px" tabindex="6" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')" onkeyup="findTotal('totPop');findTotal('netPop');findTotal('levelOfWater')"/>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsSc" /></td>
			<td class="textborder">
				<html:text property="censusSc" styleClass="mytext" 
						   style="width:50px" tabindex="2" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('totPop')" onkeyup="findTotal('totPop');findTotal('netPop');findTotal('levelOfWater')" />
			</td>
			<td class="textborder"><bean:message key="app.floatReason" /></td>
			<td class="textborder">
				<html:select property="floatReason" styleClass="mycombo" style="width:70px">
					<html:option value="">SELECT...</html:option>
					<html:option value="TEMPLE">TEMPLE</html:option>
					<html:option value="MARKET">MARKET</html:option>
					<html:option value="OTHERS">OTHERS</html:option>
				</html:select>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsSt" /></td>
			<td class="textborder">
				<html:text property="censusSt" styleClass="mytext" 
						   style="width:50px" tabindex="3" 
						   onkeypress="return numeralsOnly(event)" 
						   onblur="findTotal('netPop')" onkeyup="findTotal('totPop');findTotal('netPop');findTotal('levelOfWater')"/>
			</td>
			<td class="textborder"><bean:message key="app.netPop" /></td>
			<td class="textborder">
				<html:text property="netPop" styleClass="mytext" 
						   style="width:50px" readonly="true" 
						   onfocus="findTotal('netPop')" tabindex="8"/>
			</td>
		</tr>
		<tr>
			<td class="textborder"><bean:message key="app.cnsPop" /></td>
			<td class="textborder">
				<html:text property="totPop" styleClass="mytext" 
						   style="width:50px" readonly="true" tabindex="4" />
			</td>
		 <td class="textborder" nowrap>No. Of House Holds</td>
		<td class="textborder"><html:text property="houseHold" styleClass="mytext" maxlength="5" style="width:50px" onkeypress="return numeralsOnly(event)"/></td>
		</tr>
		<tr>
		    <td class="textborder" nowrap>No. Of Cattles </td>
		<td class="textborder"><html:text property="cattles" styleClass="mytext" maxlength="5" style="width:50px" onkeypress="return numeralsOnly(event)"/></td>
		</tr>
		</table>
		</label>
		</fieldset>
	</td>
	<td valign="top">
	<fieldset>
	<legend>Population Covered</legend>
	<label>
		<table border=0 width="100%" height="100%">
			<tr>
				<td class="textborder"><bean:message key="app.habYear" /></td>
				<td class="textborder" colspan=2>
					<input type="text" name="habYear" value="01/04/2010" styleClass="mytext" style="width:70px" tabindex="9" readonly="true"/>
					<!-- <a href="javascript: showCalendar(document.habStatusForm.habYear);"   onfocus="return checkEndYear()"> -->
					<!-- 	<IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"  > -->
					<!-- </a> -->
				</td>
			</tr>
			<tr>
				<td class="textborder"><bean:message key="app.plainCvrd" /></td>
				<td class="textborder">
					<html:text property="popCovered" styleClass="mytext" 
							   style="width:50px" tabindex="10" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')" onkeyup="findTotal('popCvrd')" />
				</td>
				<td class="textborder"><bean:message key="app.scCvrd" /></td>
				<td class="textborder">
					<html:text property="scCovered" styleClass="mytext" 
							   style="width:50px" tabindex="11" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')"  onkeyup="findTotal('popCvrd')"/>
				</td>
			</tr>
			<tr>
				<td class="textborder"><bean:message key="app.stCvrd" /></td>
				<td class="textborder">
					<html:text property="stCovered" styleClass="mytext" 
							   style="width:50px" tabindex="12" 
							   onkeypress="return numeralsOnly(event)" 
							   onblur="findTotal('popCvrd')" onkeyup="findTotal('popCvrd')"/>
				</td>
				<td class="textborder"><bean:message key="app.popCvrd" /></td>
				<td class="textborder">
					<html:text property="totPopCvrd" styleClass="mytext" 
							   style="width:50px" readonly="true" tabindex="13"/>
				</td>
			</tr>
			<tr>
				<td class="textborder">&nbsp;</td>
				<td class="textborder"><input type="text" class="mytext" style="width:50px;visibility:hidden"></td>
				<td class="textborder">&nbsp;</td>
				<td class="textborder">&nbsp;</td>
			</tr>
		</table>
	</label>
	</fieldset>
	</td>
	</tr>
</table>
</td>
</tr>
<tr>
    <td>
         <fieldset>
	     <legend>Source Details</legend>
	     <label>
	     <table border=0 width="65%" height="100%">
			<tr >
				<td class="textborder">No. Of Existing Sources  
					<html:text property="existSource" styleClass="mytext" style="width:70px" maxlength="3" onkeypress="return numeralsOnly(event)"/>
				</td>
				<td class="textborder">No. Of Safe Sources
					<html:text property="safeSource" styleClass="mytext" style="width:70px" maxlength="3" onkeypress="return numeralsOnly(event)" onchange="validateInput()"/>
				</td>

			</tr>
		 </table>
	     </label>
	     </fieldset>
    </td>
</tr>
<tr>
<td>
<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
  <tbody>
  <tr>
  <td  bgcolor="#8A9FCD">
	<div onclick="return toggleItem('collapse_myTbody2')" style="cursor:hand"><img style="WIDTH: 13px; HEIGHT: 11px" src="../images/expand.gif" name="onea"><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >
					&nbsp;Water Supply-Drinking Purpose-Existing Facilities</font></div>	
	</td>
	</tr>
	</tbody>
    <tbody class="collapse_obj" id="collapse_myTbody2" style="display:none">
	<tr><td>
	<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	<tr bgcolor="#8A9FCD">
		<td rowspan="2" class="btext" width="65%" align="right">SAFE + UNSAFE(HandPumps+PWS+MPWS)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="btext"></td>
		<td rowspan="10" class="btext" align="center" width="34%">UNSAFE</td>
	</tr>
	</table>
	<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	<tr bgcolor="#8A9FCD">
		<td rowspan="2" class="btext" width="45%" align="right">SAFE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
		<td class="btext"></td>
		<td rowspan="10" class="btext" align="center" width="54%">UNSAFE</td>
	</tr>
	</table>
			<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	<thead class="gridHeader">
	<tr bgcolor="#8A9FCD">
		<th rowspan="2"></th>
	</tr>
	<tr bgcolor="#8A9FCD">
   	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('HAND PUMPS')" id="black">Hand Pumps</a></th>
  	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('PWS')" id="black">PWS</a></th>
   	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('CPWS')" id="black">CPWS</a></th>
   	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('MPWS')" id="black">MPWS</a></th>
   	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('OTHERS')" id="black">OTHERS<BR></a><font color="white" size="1">(DP,OW etc)</font></th>
   	     <th rowspan="2">&nbsp;</th>
    	<th rowspan="2"><a href="javascript:fnGetComponentDetails('HAND PUMPS UNSAFE')" id="black">Hand Pumps</a></th>
    	 <th rowspan="2"><a href="javascript:fnGetComponentDetails('PWS UNSAFE')" id="black">PWS</a></th>
  	     <th rowspan="2"><a href="javascript:fnGetComponentDetails('MPWS UNSAFE')" id="black">MPWS</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('OPEN WELLS')" id="black">Open Wells</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('PONDS')" id="black">Ponds</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('SHALLOW HAND PUMPS')" id="black">Shallow Hand Pumps</a></th>
		<th rowspan="2"><a href="javascript:fnGetComponentDetails('OTHERS UNSAFE')" id="black">Others</a></th>
	</tr>
	</thead>
	
	<tr>
		<td class="textborder">Nos.</td>
		<td class="textborder">
			<html:text property="hpNo" styleClass="gridText" style="width:75px" />
		</td>
		<td class="textborder">
		<html:text property="pwsNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="cpwsNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" />
		</td>
		<td class="textborder">
			<html:text property="mpwsNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)"/>
		</td>
		<td class="textborder">
			<html:text property="othersSafeeNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)"/>
		</td>
		<td class="textborder">
			&nbsp;
		</td>
		<td class="textborder">
			<html:text property="dpNo"  styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		</td>
		<td class="textborder">
			<html:text property="pwsUnsafeNo"  styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		<td class="textborder">
			<html:text property="mpwsUnsafeNo"  styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>					   
		<td class="textborder">
			<html:text property="owsNo" styleClass="gridText" style="width:75px" />
		</td>
		<td class="textborder">
			<html:text property="pondsNo" styleClass="gridText" style="width:75px"/>
		</td>
		
		<td>
			<html:text property="shpNo" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)"/>
		</td>
		<td>
			<html:text property="othersNo" styleClass="gridText" style="width:50px" 
					 	 onkeypress="return numeralsOnly(event)"/>
		</td>
	</tr>
	<tr>
		<td class="textborder" nowrap>Water Supply<br>(Lts/Day)</td>
		<td class="textborder">
			<html:text property="hpSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="pwsSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="cpwsSupply" styleClass="gridText" style="width:50px"  onkeyup="funcCalcTotWaterSupply();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="mpwsSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" onkeyup="funcCalcTotWaterSupply();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="othersSafeSupply" styleClass="gridText" style="width:50px" 
					   onkeypress="return decimalsOnly(event)" onkeyup="funcCalcTotWaterSupply();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			&nbsp;
		</td>
		<td class="textborder">
			<html:text property="dpSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="pwsUnsafeSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="mpwsUnsafeSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="owsSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();findTotal('levelOfWater')"/>
		</td>
		<td class="textborder">
			<html:text property="pondsSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();findTotal('levelOfWater')"/>
		</td>
		
		<td>
			<html:text property="shpSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater')" onblur="funcCalcTotWaterSupply1();findTotal('levelOfWater')"/>
		</td>
		
		<td>
			<html:text property="othersSupply" styleClass="gridText" style="width:50px" onkeypress="return numeralsOnly(event)" onkeyup="funcCalcTotWaterSupply1();funcCalcTotWaterSupply2();findTotal('levelOfWater');" onblur="funcCalcTotWaterSupply1()"/>
		</td>
	</tr>

	</table>
	</td>
	</tr>
<tr>
<td>
<table  width="100%">
  <tr onmouseover="Tip('Note: To Calculate LPCD, Water Supply taken from (Total Safe Supply)+(Partly Unsafe(HandPumps+PWS+MPWS))',TITLE,'')" onmouseout="UnTip()">
    <td width="310" class="textborder">Total Water Supply(See Note.)<img src="<%=request.getContextPath()%>/images/new1.gif"></td>
    <td width="140"><html:text property="totalWaterSupplySafe" styleClass="mytext"  readonly="true"/></td>
    <td width="332" class="textborder">Level Of Water Supply(LPCD)</td>
    <td width="195"><html:text property="levelOfWaterSupply" styleClass="mytext" readonly="true" /></td>
  </tr>
  <tr>
    <td width="310" class="textborder">Total Water Supply(Safe Source)</td>
    <td width="140"><html:text property="totalWaterSupplySafeOnly" styleClass="mytext"  readonly="true"/></td>
    <td width="332" class="textborder">Level Of Water Supply(Safe Source)</td>
    <td width="195"><html:text property="levelOfWaterSupplySafeOnly" styleClass="mytext" readonly="true" /></td>
  </tr>
  <tr>
    <td class="textborder">Total Water Supply(UnSafe Source)</td>
    <td><html:text property="totalWaterSupplyUnsafe" styleClass="mytext" readonly="true"/></td>
    <td class="textborder">Level Of Water Supply(UnSafe Source)</td>
    <td><html:text property="unsafeLpcd" styleClass="mytext" readonly="true" /></td>
  </tr>
  <tr>
    <td class="textborder">Total Water Supply(Safe+UnSafe)</td>
    <td><input type="text" name="totalWaterSupplySafePlusUnsafe" class="mytext" readonly="true"/></td>
    <td class="textborder">Level Of Water Supply(Safe+UnSafe)</td>
    <td><input type="text" name="totalLpcdSafePlusUnsafe" class="mytext" readonly="true"/></td>
  </tr>
  <tr>
    <td class="textborder">Safe LPCD of Drinking &amp; Cooking</td>
    <td><html:text property="lpcdCooking" styleClass="mytext" readonly="true" onkeyup="extractNumber2(this,7,2,false);checkCookLpcd();" onkeypress="return blockNonNumbers(this, event, true, false);checkCookLpcd();" onchange="checkCookLpcd()" onmouseover="Tip('Note: Cooking LPCD Value is automatically calculated as Actual LPCD Value/4',TITLE,'')" onmouseout="UnTip()"/></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="textborder">Prev. Yr.Coverage Status</td>
    <td><html:text property="prevYrStatus" styleClass="mytext" readonly="true" /></td>
    <td class="textborder">Coverage Status&nbsp;As On Date</td>
    <td><%if(userid.equals("admin") || userid.equals("100000")){ %>
		<html:select property="status" styleClass="mycombo">
		</html:select>
		<%}else{ %>
		<html:text property="status" styleClass="mytext" readonly="true" />
		<%} %>
	</td>
  </tr>
</table>
</td>
</tr>
<tr>
<td>
	<table  border=0>
	
	
	
	<!-- **************************BEGIN************************** -->
	
   	 <tr>
   	    
   	    <html:hidden property="qualityAffected" value="N"/>
	     	<td class="textborder" colspan="3" nowrap>
	   		<logic:equal name="habStatusForm" property="status" value="NSS">
				<div id="conti" style="position:relative;overflow-y:auto;left:100;height:30;width:270;top:0;display:block">
				 </logic:equal>
			<logic:notEqual name="habStatusForm" property="status" value="NSS">
				<div id="conti" style="position:relative;overflow-y:auto;left:100;height:30;width:270;top:0;display:none">
			</logic:notEqual>
<table align = "center">
<tr align="center">
<td class="textborder" onmouseover="dddrivetip('<font face=verdana size=2 color=#6600CC><b>Flouride:</font><font face=verdana size=2 color=black><bean:write name="habStatusForm" property="flouride"/></b>(PPM)</font>')" onmouseout="hideddrivetip()"><html:radio property="contTypes1" value="1" onclick="remainUncheck(1)">Flouride</html:radio></td>
<td class="textborder" onmouseover="dddrivetip('<font face=verdana size=2 color=#6600CC><b>Brakish:</font><font face=verdana size=2 color=black><bean:write name="habStatusForm" property="brakish"/></b>(PPM)</font>')" onmouseout="hideddrivetip()"><html:radio property="contTypes2" value="2" onclick="remainUncheck(2)">Brakish</html:radio></td>
<td class="textborder" onmouseover="dddrivetip('<font face=verdana size=2 color=#6600CC><b>Iron:</font><font face=verdana size=2 color=black><bean:write name="habStatusForm" property="iron"/></b>(PPM)</font>')" onmouseout="hideddrivetip()"><html:radio property="contTypes3" value="3" onclick="remainUncheck(3)">Iron</html:radio></td>
<td class="textborder" onmouseover="dddrivetip('<font face=verdana size=2 color=#6600CC><b>Aresenic:</font><font face=verdana size=2 color=black><bean:write name="habStatusForm" property="aresenic"/></b>(PPM)</font>')" onmouseout="hideddrivetip()"><html:radio property="contTypes4" value="4" onclick="remainUncheck(4)">Aresenic</html:radio></td>
<td class="textborder" onmouseover="dddrivetip('<font face=verdana size=2 color=#6600CC><b>Nitrate:</font><font face=verdana size=2 color=black><bean:write name="habStatusForm" property="nitrate"/></b>(PPM)</font>')" onmouseout="hideddrivetip()"><html:radio property="contTypes5" value="5" onclick="remainUncheck(5)">Nitrate</html:radio></td>
<html:hidden property="flouride"/>
<html:hidden property="brakish"/>
<html:hidden property="iron"/>
<html:hidden property="aresenic"/>
<html:hidden property="nitrate"/>
<input type="hidden" name="SlipDivStatus">
</tr>
</table>
</div> 	 
		 	<!-- PROB
			<bean:define id="selectedContName" property="contName" name="habStatusForm"/>
			-->	 
			<!-- <c:forEach items="${contaminations}" var="item" varStatus="status">
	        <!-- <c:if test="${selectedContName==item.contType}" > 
	             	 <input type="radio" name="contType"  style="width:12px;height:13px"  styleClass="mytext"  value="<c:out value='${item.contType}' />" checked=true><font size="1" face="verdana"><b>&nbsp;<c:out value='${item.contType}' /></b></font>&nbsp;&nbsp; -->
        	<!-- </c:if>
                <c:if test="${selectedContName!=item.contType}" > 
                 <input type="radio" name="contType"  style="width:12px;height:13px"  styleClass="mytext"  value="<c:out value='${item.contType}' />" ><font size="1" face="verdana"><b>&nbsp;<c:out value='${item.contType}' /></b></font>&nbsp;&nbsp; 
			</c:if>
			</c:forEach>-->
			
     		</td>
			</tr>
				<tr>
				<td class="textborder" colspan="3">
				 <div id="slip" >
								
				&nbsp;Reason For Slippage<html:select property="slipReasonCode" styleClass="mycombo" style="width:270px" >
								<html:option value="">Select...</html:option>
								<logic:present name="slipReasons">
								<html:options collection="slipReasons" name="labelValueBean" property="value" labelProperty="label" />
								</logic:present>
								</html:select>
				 </div>
				 </td>
				 </tr>
			
			
			<!-- **************************END*********************************** -->
			<tr>
			<td colspan="5" nowrap>
			
			<logic:notEqual name="habStatusForm" property="status" value="FC">

				<div id="FCcover" style="position:relative;overflow-y:auto;left:0;height:25;width:270;top:0;display:block">	
				<table>
				<tbody>
			<tr>
			
			<td class="textborder" nowrap><bean:message key="app.yrforFC" /></td>
			<td class="textborder"><html:text property="proposedFcYr" styleClass="mytext" maxlength="4"
						   style="width:50px" onkeypress="return numeralsOnly(event)" tabindex="5"/></td>
			<td class="textborder" nowrap><bean:message key="app.amtReqforFC" /></td>
			<td class="textborder"><html:text property="proposedFCAmt" styleClass="mytext" maxlength="4"
						   style="width:50px"  tabindex="5"/></td>
						   </tr>
			</tbody>
			</table>
				</div>
			 </logic:notEqual>
			<logic:equal name="habStatusForm" property="status" value="FC">
			<div id="FCcover" style="position:relative;overflow-y:auto;left:0;height:23;width:270;top:0;display:none">
			<table>
			</table>
			</div>
		 </logic:equal>
		
		  </td>
			</tr>
			
	</table>
</td>
</tr>
  </tbody>
 </table>
 </td>
 </tr>
<tr>
<td>
	<fieldset>
	<legend>Distance From Nearest Source</legend>
	<label>
		<table width="100%">
		<tr>
		<td >
			<div id="covnc" style="position:relative;overflow-y:auto;left:0;width:370;top:0;display:block">
			<TABLE>
			<tr>
			<td class="textborder">Nearest Available Source</td>
			<td class=myfontclr>
			<html:select property="ncSourceType" styleClass="mycombo" style="width:150px">
		                       <html:option value="">SELECT...</html:option>
		                       <html:option value="1">Spring</html:option>
		                       <html:option value="2">Dug well</html:option>
		                       <html:option value="3">Ponds</html:option>
		                       <html:option value="4">River</html:option>
		                       <html:option value="5">Stream</html:option>
		                       <html:option value="6">Distant Govt.Source.(any)</html:option>
		                </html:select>   &nbsp;
			</td>
			
			</tr>
			</table>
			</div>
			<div id="covnotnc" style="position:relative;overflow-y:auto;left:0;width:370;top:0;display:block">
			<TABLE width="50%">
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
			</table>
			</div>
		</td>
		<td class="textborder">Distance of availability of Water Supply <BR>Point from house hold</td>
		<td class=myfontclr>
			<html:select property="sourceDistance" styleClass="mycombo" style="width:80px">
	                       <html:option value="">SELECT...</html:option>
	                       <html:option value="1"><50</html:option>
	                       <html:option value="2">50-100</html:option>
	                       <html:option value="3">101-200</html:option>
	                       <html:option value="4">201-500</html:option>
	                       <html:option value="5">500-1600</html:option>
	                       <html:option value="6">>1600</html:option>
	                </html:select>   &nbsp;(in Mtrs.)
	     </td>
	</tr>


		</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td bgcolor="#8A9FCD">
    


<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
  <tbody>
  <tr>
  <td  bgcolor="#8A9FCD">
	<div onclick="return toggleItem('collapse_myTbody1')" style="cursor:hand"><img style="WIDTH: 13px; HEIGHT: 11px" src="../images/expand.gif" name="oneb"><font  style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000" >
					&nbsp;Public Institutions Details</font></div>	
	</td>
	</tr>
	</tbody>
    <tbody class="collapse_obj" id="collapse_myTbody1" style="display:none">
	<tr><td>
		<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="100%" align=center >
			 	
			<tr>
				<td class=clrborder align=center>Name</td>
				<td class=clrborder align=center>Total No.</td>
				<td class=clrborder align=center>No. Covered with<br>drinking water</td>
				<td class=clrborder align=center>Working</td>
				<td class=clrborder align=center>Not Working</td>
			</tr>
			
			<nested:iterate id="HABINST_LIST" property="habInsts">
			<tr>	
				<td  class="textborder">
					<font size="1" face="verdana"><bean:write name="HABINST_LIST" property="instituteName"  /></font>
					<nested:hidden property="instituteCode" name="HABINST_LIST" indexed="true" />

				</td>
				<td  class="textborder" >
					<nested:text  property="instituteNo" name="HABINST_LIST" indexed="true"
						styleClass="gridText" style="width:100px" 
						onkeypress="return numeralsOnly(event)" />
				</td>
				<td  class="textborder" >
					<nested:text  property="instituteCovered" name="HABINST_LIST" 
						styleClass="gridText" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)" />
				</td>
				<td  class="textborder" >
					<nested:text  property="instituteWorking" name="HABINST_LIST" 
						styleClass="gridText" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)" />
				</td>
				<td  class="textborder" >
					<nested:text  property="instituteNotWorking" name="HABINST_LIST" 
						styleClass="gridText" style="width:100px" indexed="true"
						onkeypress="return numeralsOnly(event)" />
				</td>
			</tr>
			</nested:iterate>
		</table>
	</td>
	</tr>
	</tbody>
	</table>
 
</td>
</tr>	



<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.others" /></legend>
	<label>
		<table width="100%" align="center" border="0">
		<tr>
			<td class="textborder"><bean:message key="app.remarks" /></td>
			<td><html:textarea property="remarks" cols="35"/></td>
			
		</tr>
		

	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<table width="100%">
	<tr>
		<td class="textborder" align=center>
		<%if(userid.equals("admin") || userid.equals("100000"))
		{
		%>
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isValid()" disabled="false"/>
		<%}
		else
		{%>
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return isValid()" disabled="false"/>
		<%}%>
		<html:submit property="mode" title="View the habitations" styleClass="btext" value="View"  onclick="return viewfun()"/>
		</td>
	</tr>
	</table>
</td>
</tr>
</table>
</td></tr></table>
</html:form>
</body>
<%@ include file="/commons/rws_tooltip_hab.jsp"%>
<p align=center>
<font face=verdana size=2 color=red>
Note:*** 1. To Calculate LPCD, Water Supply taken from (Total Safe Supply)+(Partly Unsafe(HandPumps+PWS+MPWS))<BR><BR>
</font>
</p>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>