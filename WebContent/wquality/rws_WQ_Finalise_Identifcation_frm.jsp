<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="wqFinalIdenForm" />

 <script language="JavaScript">
<!--
	function getSourceCode()
	{
	if(document.forms[0].habCode.value!="" && document.forms[0].schemeCode.value!="" && document.forms[0].rno.value!="")
	document.forms[0].sourceCode.value=document.forms[0].habCode.value+document.forms[0].schemeCode.value+document.forms[0].schemeRep.value+document.forms[0].rno.value;
	
	}
	function newSourceClicked()
	{
		if(document.forms[0].subCompTypeCode.value!="" && document.forms[0].habCode.value!="")
		{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=newSource";
		document.forms[0].submit();
		}else{
		alert("Please Select Source Type");
		}
	}
	function sourceTypeChanged()
	{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=data";
		document.forms[0].submit();
	}
	function getData()
	{
		document.forms[0].action="switch.do?prefix=/wquality&page=/WaterFinalIden.do&mode=data";
		document.forms[0].submit();
	}
	function showWork()
	{
		var workId=wqFinalIdenForm.workCode.value;
		if(workId=="")
		 alert("Please Select Work Id");
		else{
		  url = "switch.do?prefix=/estimates&page=/ShowWorkDetails.do&type=new&workId="+workId;
		  window.open(url,"", "width=534,height=240,left=189,top=200,scrollbars=1");
		}
	}
	
//-->
</script>
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/WaterFinalIden.do" enctype="multipart/form-data">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Source Identification and Finalisation" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="textborder" >
<fieldset>
<legend>RWS Offices</legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
	<html:hidden property="newSource" />
	<html:hidden property="schemeRep" />
	<logic:present name="RWS_USER" property="headOfficeName">
	<td class="textborder">Head&nbsp;:</td>
	<td class="textborder">
	<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	</td>
	</logic:present>
	<logic:present name="RWS_USER" property="circleOfficeName">
	<td class="textborder">Circle&nbsp;:</td>
	<td class="textborder">
	<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	<html:hidden property="circleOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	<logic:present name="RWS_USER" property="divisionOfficeName">
	<td class="textborder">Division&nbsp;:</td>
	<td class="textborder">
	<html:text property="divisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext"  style="width:100px"/>
	<html:hidden property="divisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	<logic:present name="RWS_USER" property="subdivisionOfficeName">
	<td class="textborder">Subdivision&nbsp;:</td>
	<td class="textborder">
	<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	</tr>
	</table>
	</label>
	</fieldset>
		<fieldset>
		<legend ><B>Source Finalisation & Identification Details</B></legend>
		<label>
		<table width="100%" cellspacing="2" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
		<tr>
		<td class="textborder">Habitation&nbsp;:<font color="#FF6666">*</font></td>
		<td align=left colspan="3">
		<html:select property="habCode" styleClass="mycombo" style="width:323px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="habs" name="rwsWQuality" property="code" labelProperty="codeName" />
		</html:select>
		</td>
		
		</tr>
		
		<tr>
		<td class="textborder" nowrap>Work&nbsp;:<font color="#FF6666">*</td>
		<td class="textborder" colspan=5>
		<html:select property="workCode" styleClass="mycombo" style="width:573px" onchange="getData()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="workIds" name="rwsMaster"  property="workCode" labelProperty="codeName" />
		</html:select>
		&nbsp;<input type="button" class="btext" value="..." style="width:22px;height:18px" onclick="showWork()">
		</td></td></tr>
		
		<tr>
		
		<td class="textborder">Asset Type&nbsp;:<font color="#FF6666">*</font></td>
		<td class="textborder">
		<html:select property="assetTypeCode" styleClass="mycombo" style="width:123px" onchange="sourceTypeChanged()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="assetTypes" name="rwsMaster"  property="value" labelProperty="label" />
		</html:select>
		</td>
		<td class="textborder">Source Type&nbsp;:<font color="#FF6666">*</font></td>
		<td class="textborder">
		<html:hidden property="compTypeCode" value="01" />
		<html:select property="subCompTypeCode" styleClass="mycombo" style="width:123px" onchange="sourceTypeChanged()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="subCompTypes" name="rwsMaster"  property="value" labelProperty="label" />
		</html:select>
		</td>
		<% if(session.getAttribute("newSource")==null || !((String)session.getAttribute("newSource")).equals("true"))
		{ %>
		<td class="textborder">Source Code&nbsp;:<font color="#FF6666">*</font></td>
		<td class="textborder" align="left">
		<html:select property="sourceCode" styleClass="mycombo" style="width:220px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="sourceCodes" name="rwsMaster"  property="sourceCode" labelProperty="sourceCode" />
		</html:select>
		</td>
		
		<td><!--  <html:button property="newSource" value="New Source" onclick="newSourceClicked()"/>-->
		<A href="#1" onclick="newSourceClicked()">New Source</A>
		
		</td>
		
		<%} else{%>
		<td class="textborder" colspan=1>Scheme Code&nbsp;:<font color="#FF6666">*</font></td>
		<td class="textborder">
		<html:select property="schemeCode" styleClass="mycombo" style="width:90px" onchange="getSourceCode()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="schemeCodes" name="LabelValueBean"  property="value" labelProperty="value" />
		</html:select>
		</td>
		<td class="textborder">Running SNo.&nbsp;:<font color="#FF6666">*</font></td>
		
		<td class="textborder" align="left">
		<html:select property="rno" styleClass="mycombo" style="width:90px" onchange="getSourceCode()">
		<html:option value="">SELECT...</html:option>
		<html:options collection="rnos" name="LabelValueBean"  property="value" labelProperty="value" />
		</html:select>
		</td>
		
		<%} %>
		</tr>
		
		<% if(session.getAttribute("newSource")!=null && ((String)session.getAttribute("newSource")).equals("true"))
		{ %>
		<tr>
		<td class="textborder">Source Code:<font color="#FF6666">*</font></td>
		<td colspan=1>
		<html:text property="sourceCode" styleClass="mytext" style="width:160px" readonly="true"/>
		</td>
		<%} %>
		
		<td class="textborder">Programme&nbsp;:<font color="#FF6666">*</td>
		<td class="textborder">
		<html:select property="prgmCode" styleClass="mycombo" style="width:123px" onchange="javascript:getData()">
		<html:option value="0">SELECT...</html:option>
		<html:options collection="programmes" name="labelValueBean"  property="value" labelProperty="label" />
		</html:select>
		</td>
		<td class="textborder" colspan=2>SubProgramme&nbsp;:<font color="#FF6666">*
		<html:select property="subprgmCode" styleClass="mycombo" style="width:123px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="subprogrammes" name="labelValueBean"  property="value" labelProperty="label" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder" colspan="1">
			<fieldset>
			<legend ><B>Recommendations</B></legend>
			<label>
			<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<td class="textborder">Casing&nbsp;:</td>
			<td class="textborder">
			<html:text property="casing" styleClass="mytext" style="width:80px"/>&nbsp;mts
			</td>
			<tr>
			<td class="textborder">Depth&nbsp;:</td>
			<td class="textborder">
			<html:text property="depth"  styleClass="mytext" style="width:80px"/>&nbsp;mts
			</td>
			<tr>
			<td class="textborder">Yield&nbsp;:</td>
			<td class="textborder">
			<html:text property="yield"  styleClass="mytext"  style="width:80px"/>&nbsp;lpm
			</td>
			</tr>
			</table>
			</label>
			</fieldset>
		</td>
		
		<td class="textborder" colspan="6" width="100%">
			<fieldset>
			<legend><B>Work Inventory References</B></legend>
			<label>
			<table cellpadding="0" cellspacing="0" border="1" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
			<tr>
			<td class="clrborder">1)</td>
			<td class="textborder" colspan="3" width="95">Source Type&nbsp;:</td>
			<td class="textborder" width="123">
			<html:select property="source1" styleClass="mycombo" style="width:123px" onchange="sourceTypeChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sources" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />
			</html:select>
			</td>
			<td class="textborder" colspan="3">Source &nbsp;:</td>
			<td class="textborder" width="220">
			<html:select property="sourceCode1" styleClass="mycombo" style="width:220px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes1" name="rwsMaster"  property="sourceCode" labelProperty="sourceCode" />
			</html:select>
			</td>
			
			<td class="textborder">Depth&nbsp;:</td>
			<td class="textborder">
			<html:text property="depth1"  styleClass="mytext" style="width:60px"/>&nbsp;mts
			</td>
			<td class="textborder">Yield&nbsp;:</td>
			<td class="textborder">
			<html:text property="yield1"  styleClass="mytext"  style="width:60px"/>&nbsp;lpm
			</td>
			</tr>
			<tr>
			<td class="clrborder">2)</td>
			<td class="textborder" colspan="3">Source Type&nbsp;:</td>
			<td class="textborder">
			<html:select property="source2" styleClass="mycombo" style="width:123px" onchange="sourceTypeChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sources" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />
			</html:select>
			</td>
			
			<td class="textborder" colspan="3">Source &nbsp;:</td>
			<td class="textborder">
			<html:select property="sourceCode2" styleClass="mycombo" style="width:220px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes2" name="rwsMaster"  property="sourceCode" labelProperty="sourceCode" />
			</html:select>
			</td>
			<td class="textborder">Depth&nbsp;:</td>
			<td class="textborder">
			<html:text property="depth2"  styleClass="mytext" style="width:60px"/>&nbsp;mts
			</td>
			<td class="textborder">Yield&nbsp;:</td>
			<td class="textborder">
			<html:text property="yield2"  styleClass="mytext"  style="width:60px"/>&nbsp;lpm
			</td>
			</tr>
			<tr>
			<td class="clrborder" >3)</td>
			<td class="textborder" colspan="3" width="100">Source Type&nbsp;:</td>
			<td class="textborder">
			<html:select property="source3" styleClass="mycombo" style="width:123px" onchange="sourceTypeChanged()">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sources" name="rwsMaster"  property="sourceCode" labelProperty="codeName" />
			</html:select>
			</td>
			
			<td class="textborder" colspan="3">Source &nbsp;:</td>
			<td class="textborder" >
			<html:select property="sourceCode3" styleClass="mycombo" style="width:220px">
			<html:option value="">SELECT...</html:option>
			<html:options collection="sourceCodes3" name="rwsMaster"  property="sourceCode" labelProperty="sourceCode" />
			</html:select>
			</td>
			<td class="textborder">Depth&nbsp;:</td>
			<td class="textborder">
			<html:text property="depth3"  styleClass="mytext" style="width:60px"/>&nbsp;mts
			</td>
			<td class="textborder">Yield&nbsp;:</td>
			<td class="textborder">
			<html:text property="yield3"  styleClass="mytext"  style="width:60px"/>&nbsp;lpm
			</td>
			</tr>
			</table>
			</label>
			</fieldset>
		</td>
		</tr>
		<tr>
		<td class="textborder">Lab Chemist&nbsp;:<font color="#FF6666">*</font></td>
		<td class="textborder">
		<html:select property="empcode" styleClass="mycombo" style="width:123px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="empcodes" name="RwsWQuality"  property="empcode" labelProperty="empcode" />
		</html:select>
		</td>
		<td class="textborder">Site Identification Date&nbsp;:<font color="#FF6666">*</td>
		<td class="textborder" nowrap>
		<html:text property="siteIdenData" size="10"  styleClass="mytext"  />
		<a href="javascript: showCalendar(document.wqFinalIdenForm.siteIdenData);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/>
		</a></td>
		<td class="textborder" >Site Map</td>
		<td class="bwborder" >
		<html:file styleClass="mytext" property="sitePlan"></html:file>
		</td>
		</tr>
		<tr>
		<td class="textborder">Finalised<font color="#FF6666">*</td>
		<td class="textborder">
		<html:select property="finalised" styleClass="mycombo" style="width:123px">
		<html:option value="">SELECT...</html:option>
		<html:option value="Y">YES</html:option>
		<html:option value="N">NO</html:option>
		</html:select>
		</td>
		<td class="textborder" nowrap>Finalised Date<font color="#FF6666">*</td>
		<td class="textborder" nowrap>
		<html:text property="finalDate" size="10" value="" styleClass="mytext"  />
		<a href="javascript: showCalendar(document.wqFinalIdenForm.finalDate);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/>
		</a></td>
		<td class="textborder">Remarks<font color="#FF6666">*</td>
		<td class="textborder" rowspan="2">
		<html:textarea property="remarks"  style="width:133px" onkeypress="upperOnly()"/>
		</td>
		</tr>

		</table>
		</label>
		</fieldset>
		</td>
		
	<tr>
	
	<td align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return validateWqFinalIdenForm(wqFinalIdenForm)"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	<html:submit property="mode" title="View the Fields" styleClass="btext" value="View"   />
	</td>
	
	<bean:define id="userId" name="RWS_USER" property="userId" />
	<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
	<html:hidden property="preparedOn" value="<%=fmt.format(new java.util.Date())%>" />
	
	</tr>
	</table>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>