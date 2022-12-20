<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
function getProposalIds(that)
{
	var url = "switch.do?prefix=/proposals&page=/NewProposalTrackingData.do&assetCode=" + that.value;
	form = that.form;
	form.action = url;
	form.submit();
}

function getData(that)
{
    form = that.form;
 	form.action ="switch.do?prefix=/proposals&page=/NewProposalTrackingData.do";
	form.submit();
}
//-->
</script>
<html:javascript formName="NewProposalTrackForm" />
<%@ include file="/commons/rws_header2.jsp" %>


<html:form action="/NewProposalTracking" onsubmit="return validateNewProposalTrackForm(this)">
<table align="center" cellpadding="0" cellspacing="0">
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Proposal Tracking" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot summary="Page footer with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody summary="Page body">
<tr>
<td>
	<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" cellspacing="2" cellpadding="2"
		   rules="none" style="border-collapse:collapse" class="formTBody">
	<tr>
		<td><bean:message key="app.district" /><span class="mandatory">*</span></td>
		<td>
		 <html:select property="district" styleClass="comboMedium"   onchange="getData(this)">
		  <html:option value="">SELECT...</html:option>
		  <html:options collection="districts" name="rwsLocation" property="districtCode" labelProperty="districtName" />
		</html:select>
		</td>
		 </tr>
	<tr>
		<td><bean:message key="app.mandal" /></td>
		<td>
		 <html:select property="mandal" styleClass="comboMedium"  onchange="getData(this)">
		  <html:option value="">SELECT...</html:option>
		  <html:options collection="mandals" name="rwsLocation" property="mandalCode" labelProperty="mandalName" />
		</html:select>
		</td>
	 </tr>
		<tr>
		<td > Panchayat</td>
		<td align=left >
		<html:select property="panchayat" styleClass="comboMedium"  onchange="getData(this)">
		<html:option value="">SELECT...</html:option>
		<html:options collection="panchayats" name="rwsLocation" property="panchayatCode" labelProperty="panchayatName" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td > Village</td>
		<td align=left >
		<html:select property="village" styleClass="comboMedium"  onchange="getData(this)">
		<html:option value="">SELECT...</html:option>
		<html:options collection="villages" name="rwsLocation" property="villageCode" labelProperty="villageName" />
		</html:select>
		</td>
		</tr>
		<tr>
		<td  >Habitation</td>
		<td align=left >
		<html:select property="habCode" styleClass="comboMedium"  onchange="getData(this)">
		<html:option value="">SELECT...</html:option>
		<html:options collection="prhabs" name="rwsLocation" property="habCode" labelProperty="habName" />
		</html:select>
		</td>
	    </tr>
	    <tr>
	   <logic:present name="representatives">
   	    <td  >Representatives</td>
   		<td align=left >
			<html:select property="repCode" styleClass="comboMedium"
				 onchange="javascript: getData(this)">
			<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
			<html:options collection="representatives" name="labelValueBean"
				  property="value" labelProperty="label" />
			</html:select>
         </td>			
		</logic:present>
	    </tr>
        <tr>
		<td><bean:message key="app.year" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="financialYear" styleClass="comboMedium">
				<html:option value="">SELECT...</html:option>
				<html:options collection="financialYears" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.scheme"/><span class="mandatory">*</span></td>
		<td>
			<html:select property="assetCode" onchange="javascript: getProposalIds(this)"
						 styleClass="comboMedium">
				<html:option value="">SELECT...</html:option>		 
				<html:options collection="assetTypes" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>
	</tr>
	<logic:present name="proposalIds">
	<tr>
		<td><bean:message key="app.proposalId" /><span class="mandatory">*</span></td>
		<td>
			<html:select property="proposalId" styleClass="comboMedium">
				<html:option value="">SELECT...</html:option>
				<html:options collection="proposalIds" name="labelValueBean" property="value"
							  labelProperty="label" />
			</html:select>
		</td>
	</tr>
	</logic:present>
	<logic:notPresent name="proposalIds">
	<tr>
		<td><bean:message key="app.proposalId" /><span class="mandatory">*</span></td>
		<td>
			<html:text property="proposalId" onkeypress="javascript: upperOnly()" 
					   styleClass="thin-text-box" style="width:200px" readonly="true"/>
					   
		</td>
	</tr>
	</logic:notPresent>
	<tr>
		<td colspan="2" align="center">
			<html:submit styleClass="btext"><bean:message key="button.submit" /></html:submit>
		</td>
	</tr>
	</table>
</td>
</tr>
</tbody>

</table>
</html:form>

</body>
</html>