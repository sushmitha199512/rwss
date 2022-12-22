<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<html:javascript formName="waterSampleForm" />

<html:form action="/WaterSample.do?mode=edit">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Water Sample Collection" />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="bwborder" colspan="3">
<fieldset>
<legend  > Office Details </legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
	<logic:present name="RWS_USER" property="headOfficeName">
	<td class="bwborder"><FONT class=myfontclr>Head Office&nbsp;:</FONT></td>
	<td class="bwborder">
	<html:text property="headOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	</td>
	</logic:present>
	<logic:present name="RWS_USER" property="circleOfficeName">
	<td class="bwborder"><FONT class=myfontclr>Circle&nbsp;:</FONT></td>
	<td class="bwborder">
	<html:text property="circleOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:130px"/>
	<html:hidden property="circleOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	
	<logic:notPresent name="RWS_USER" property="circleOfficeName">
	<html:hidden property="circleOfficeCode" name="RWS_USER" value="00"/>
	</td>
	</logic:notPresent>
	
	<logic:present name="RWS_USER" property="divisionOfficeName">
	<td class="bwborder"><FONT class=myfontclr>Division&nbsp;:</FONT></td>
	<td class="bwborder">
	<html:text property="divisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext"  style="width:130px"/>
	<html:hidden property="divisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	
	<logic:notPresent name="RWS_USER" property="divisionOfficeName">
	<html:hidden property="divisionOfficeCode" name="RWS_USER" value="0"/>
	</td>
	</logic:notPresent>
	
	
	<logic:present name="RWS_USER" property="subdivisionOfficeName">
	<td class="bwborder"><FONT class=myfontclr>Subdivision&nbsp;:</FONT></td>
	<td class="bwborder">
	<html:text property="subdivisionOfficeName" name="RWS_USER" readonly="true" styleClass="mytext" style="width:100px"/>
	<html:hidden property="subdivisionOfficeCode" name="RWS_USER" />
	</td>
	</logic:present>
	
	<logic:notPresent name="RWS_USER" property="subdivisionOfficeName">
	<html:hidden property="subdivisionOfficeCode" name="RWS_USER" value="00"/>
	</td>
	</logic:notPresent>
	
	</tr>
	</table>
	</label>
	</fieldset> 
 	 
 	 <fieldset>
	 <legend  > Habitation Details </legend>
     <label>
     <table cellpadding="0" cellspacing="2" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
    	<tr>
    	 <td class="bwborder"><FONT class=myfontclr>Mandal&nbsp;:</FONT></td>
  	     <td class="bwborder">
  	     <html:text property="mandalCode"   readonly="true" styleClass="mytext" style="width:100px"/>
	     <html:hidden property="mandalCode"  />
	     </td>
	     <td class="bwborder"><FONT class=myfontclr>Panchayat&nbsp;:</FONT></td>
  	     <td class="bwborder">
  	     <html:text property="panchayatCode"   readonly="true" styleClass="mytext" style="width:100px"/>
	     <html:hidden property="panchayatCode"  />
	     </td>
	     <td class="bwborder"><FONT class=myfontclr>Village&nbsp;:</FONT></td>
  	     <td class="bwborder">
  	     <html:text property="villageCode"   readonly="true" styleClass="mytext" style="width:100px"/>
	     <html:hidden property="villageCode"  />
	     </td>
	     </tr>
	     <tr>
		<td class="bwborder"><FONT class=myfontclr>Habitation&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td align=left >
		<html:select property="habCode" styleClass="mycombo" style="width:245px" >
		
		<html:option value="">SELECT...</html:option>
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
		</tr>
		</table>
		</label>
	   </fieldset>
	  
		<fieldset>
		<legend> Sample Collection Details </legend>
		<label>
		<table width="100%" cellspacing="2" cellpadding="2" border="0" bordercolor= "#8A9FCD" style="border-collapse:collapse;"  >
		<tr>
		
		<td class="bwborder"><FONT class=myfontclr>Source&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder">
		<!-- 
		<html:select property="sourceCode" styleClass="mycombo" style="width:145px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="sources" name="rwsMaster"  property="sourceCode" labelProperty="sourceName" />
		</html:select>
		 -->
		 <html:text property="sourceCode"  style="width:200px" readonly="true"/>
		</td>
		</tr>
		<td class="bwborder"><FONT class=myfontclr>Type of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder">
		<html:select property="testCode" styleClass="mycombo" style="width:145px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="watertests" name="rwsMaster"  property="testCode" labelProperty="testName" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Nature of Test&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder">
		<html:select property="natureOfTest" styleClass="mycombo" style="width:155px">
		<html:option value="">SELECT...</html:option>
		<html:option value="1">ROUTINE</html:option>
		<html:option value="2">SEASONAL</html:option>
		<html:option value="3">QUARTERLY</html:option>
		<html:option value="4">DISEASE OUTBREAK</html:option>
		</html:select>
		</td>
		</tr>
		<tr>
		<td class="bwborder"><FONT class=myfontclr>Sample Collected By&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder">
		<html:select property="sampCollectCode" styleClass="mycombo" style="width:145px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="desgns" name="rwsMaster"  property="desgnCode" labelProperty="desgnAcr" />
		</html:select>
		</td>
		<td class="bwborder"><FONT class=myfontclr>Collection Date<br>and Time&nbsp;:<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder" nowrap>
		<html:text property="sampCollectDate" size="10"  styleClass="mytext"  />
		<html:text property="sampCollectTime"  size="5" styleClass="mytext"/>
		<a href="javascript: showCalendar(document.waterSampleForm.sampCollectDate);">
		<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><br>
		<FONT class=myfontclr><font style="font-size:7pt">DD/MM/YYYY&nbsp;&nbsp;&nbsp;&nbsp;HH:MM</font></FONT></td>
		</tr>
		<tr>
		<td class="bwborder"><FONT class=myfontclr>Lab Assigned<font color="#FF6666">*</font></FONT></td>
		<td class="bwborder"><html:select property="labCode" styleClass="mycombo" style="width:240px">
		<html:option value="">SELECT...</html:option>
		<html:options collection="wqlabs" name="rwsMaster"  property="labCode" labelProperty="labName" />
		</html:select>
		</td>
		
		<td class="bwborder"><FONT class=myfontclr>Assigned On&nbsp;:</FONT></td>
		<td class="bwborder"><html:text property="assignedOn" value="<%=sdf.format(new java.util.Date())%>" size="12" readonly="true" styleClass="mytext"/></td>
		</tr>
		</table>
		</label>
		</fieldset>
		</td>
	<tr>
	<td class="bwborder">
	 
	<bean:define id="userId" name="RWS_USER" property="userId" />
	<html:hidden property="preparedBy" value="<%=(String)userId%>"/>
	<html:hidden property="testId" />
	</td>
	<td align="center">
	<html:submit property="mode" title="Save the Fields"  styleClass="btext" value="Submit" onclick="return validateWaterSampleForm(waterSampleForm)"/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" />
	</td>
 
	</tr>
	</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>