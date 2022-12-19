<%@ include file="/commons/rws_header1.jsp" %>
<%@page import="java.util.ArrayList" %>
<%@page import="nic.watersoft.commons.ProgrammeSubProgrammeBean" %>

<script language="JavaScript">
<!--
function fnToggleSubProgrammes(that)
{
	var frm = that.form;
	var programmeCode = that.value;
	if(programmeCode == "00")
	{
		if(that.checked)
			frm.others.disabled = false;
		else
			frm.others.disabled = true;
	}
	else
	{
		var field = "subprogrammeCode_"+programmeCode;
		var subprogrammeElem = frm.elements(field);
			
		if(subprogrammeElem)
		{
			var len = subprogrammeElem.length;
			if(typeof len != "number")
			{
				subprogrammeElem = [subprogrammeElem]; 
			}
			if(that.checked)
			{	for(var i=0; i<len; i++)
				{	subprogrammeElem[i].disabled = false;
				}
			}
			else
			{	for(var i=0; i<len; i++)
				{	subprogrammeElem[i].disabled = true;
				}
			}
		}
	}
}
function fnSave()
{
	var flag = false;
	if(validateEditOMProposalForm(EditOMProposalForm))
	{
		var others = document.getElementById("others");
		var otherValue = others.value;
		var frm = others.form;
		flag = true;
		if(!others.disabled)
		{
			var regexp = /.+/;
			if(!otherValue.match(regexp))
			{
				alert("If others, specify is required");
				flag = false;
				frm.others.focus();
			}
			else
			{
				var programmeNames = frm.elements("programmeName");
				if(typeof programmeNames.length != "number")
					programmeNames = [programmeNames];
				for(var j=0; j<programmeNames.length; j++)
				{
					if(programmeNames[j].value == otherValue.toUpperCase())
						flag = false;
				}
				if(!flag)
				{
					alert("Programme entered is already in the list.");
					frm.others.focus();
				}
			}
		}
	}
	return flag;
}

function fnCancel(that)
{
	var frm = that.form;
	var url = "switch.do?prefix=/proposals&page=/OMProposalData.do";
	frm.action = url;
	frm.submit();
	
}
//-->
</script>
<html:javascript formName="EditOMProposalForm" />

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/EditOMProposal" method="post" enctype="multipart/form-data">
<table align="center" cellpadding="0" cellspacing="0">

<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Proposals Edit Form" />
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

<tbody>
<tr>
<td>
<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tr>
<td>
<fieldset>
<legend>
	<bean:message key="legend.proposalDetails" />
</legend>
<label>
	<table>
	<tbody class="formTBody">
	<tr>
		<td class="column1"><bean:message key="app.proposalId" /><span class="mandatory">*</span></td>
		<td class="column2">
			<html:text property="proposalId" readonly="true" size="23" styleClass="thin-text-box" />
		</td>
		<td class="column3"><bean:message key="app.assetCode" /><span class="mandatory">*</span></td>
		<td class="column4">
			<html:text property="assetCode" readonly="true" styleClass="thin-text-box" />
		</td>
	</tr>
	<tr>
		<td colspan="4" width="100%">
		<div style="height: 100px; overflow-y:auto">
		<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000"
		style="border-collapse: collapse">
		
		<thead class="gridHeader">
		<tr>
			<th><bean:message key="app.select" /></th>
			<th><bean:message key="app.programme" /></th>
			<th><bean:message key="app.subprogramme" /></th>
		</tr>
		<tbody class="label">
		<% 
			ArrayList programmeSubProgrammes = (ArrayList)request.getAttribute("programmeSubProgrammes");
			ProgrammeSubProgrammeBean programmeSubProgrammeBean = null;
			String tempProgrammeCode = "00";
			String programmeCode = "";
			String programmeName = "";
			String subprogrammeCode = "";
			String subprogrammeName = "";
			boolean flag = true;
			for(int i=0; i<programmeSubProgrammes.size(); i++)
			{
			
			  programmeSubProgrammeBean = (ProgrammeSubProgrammeBean)programmeSubProgrammes.get(i);
			  programmeCode = programmeSubProgrammeBean.getProgrammeCode();
			  programmeName = programmeSubProgrammeBean.getProgrammeName();
			  subprogrammeCode = programmeSubProgrammeBean.getSubprogrammeCode();
			  subprogrammeName = programmeSubProgrammeBean.getSubprogrammeName();
			  //System.out.println("subprogrammeName" + subprogrammeName + "KNK");
			   if(!tempProgrammeCode.equals(programmeCode))
			   {
			      //System.out.println("tempProgrammeCode " + tempProgrammeCode);
		          //System.out.println("ProgrammeCode " + programmeCode);
			   	  tempProgrammeCode = programmeCode;

		%>
			<tr class="row<%= i%2%>">
			<td align="center">
			<html:multibox property="programmeCodes" value="<%= programmeCode %>"
				onclick="javascript: fnToggleSubProgrammes(this)"	/>
			</td>
			<td>&nbsp;<%= programmeName %></td>
			<input type="hidden" name="programmeName" value="<%= programmeName%>">
			<td>
			<% 
				flag = false;
				} 
			%>	
			    <% if(subprogrammeName!=null){ %>
			      <input type="radio" disabled="true"
			      name="subprogrammeCode_<%= programmeCode%>" value="<%= subprogrammeCode %>">
			      	<%= subprogrammeName%>
			    <%} %>  
			<% 
				if(flag)
				{
			%>
				</td></tr>
			<%  } %>	
			
		<% 	 } %>
		</tbody>
		</table>
		</div>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.ifOthers"/></td>
		<td colspan="3" class="column2">
			<html:text property="others" disabled="true" 
				styleClass="thin-text-box"/>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.estimateCost" /><span class="mandatory">*</span></td>
		<td class="column2">
			<html:text property="estimateCost" styleClass="thin-text-box" onkeypress="return decimalsOnly(event)"/>
		</td>
		<td class="column3"><bean:message key="app.financialYear" /><span class="mandatory">*</span></td>
		<td class="column4">
			<html:select property="financialYear" styleClass="combo">
				<html:option value="">SELECT...</html:option>
				<logic:present name="financialYears">
					<html:options collection="financialYears" name="labelValueBean"
						property="value" labelProperty="label"/>
				</logic:present>
			</html:select>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.remarks" /></td>
		<td class="column2">
			<html:textarea property="remarks" styleClass="thin-text-box" onkeypress="upperOnly()"/>
		</td>
	</tr>
	<tr>
		<td class="column1"><bean:message key="app.lineEstimate" /></td>
		<td class="column2">
			<html:file property="lineEstimate" styleClass="thin-text-box" />
		</td>
		<td class="column3"  colspan="2">
			<a href='<bean:write name="EditOMProposalForm" property="lineEstimatePath"/>'
				   target='_new'>
				 Show Uploaded File
			</a>
		</td>
	</tr>
		<tr>
		<td class="column1"><bean:message key="app.budjetEstimate" /></td>
		<td class="column2" colspan="3">
			<html:file property="budjetEstimate" styleClass="thin-text-box" />
		</td>
	</tr>
	<tr>
		<td align="center" colspan="4">
			<html:submit property="mode" styleClass="btext" onclick="return fnSave()">
				<bean:message key="button.save" />
			</html:submit>
			<html:reset styleClass="btext">
				<bean:message key="button.clear" />
			</html:reset>
			<html:button property="mode" styleClass="btext" onclick="fnCancel(this)">
				<bean:message key="button.cancel" />
			</html:button>
		</td>
	</tr>
	</tbody>
	</table>
</label>
</fieldset>
</td>
</tr>
</td>
</tr>
</tbody>
</table>
<html:hidden property="init" />
<%
	String[] subprogrammeCodes = (String[])request.getAttribute("subprogrammeCodes");
	String programmeCode1 = "";
	String subprogrammeCode1 = "";
	String programmeSubProgrammeCode1 = "";
	if(subprogrammeCodes != null)
	{
		for(int i=0; i<subprogrammeCodes.length; i++)
		{
			programmeSubProgrammeCode1 = subprogrammeCodes[i];
			//System.out.println("programmeSubProgrammeCode1 " + programmeSubProgrammeCode1);
			subprogrammeCode1 = "";
			programmeCode1 = programmeSubProgrammeCode1.substring(0,2);
			if(programmeSubProgrammeCode1.length() == 5)
			{
				subprogrammeCode1 = programmeSubProgrammeCode1.substring(3,5);
				//System.out.println("subProgrammeCode1 " + subprogrammeCode1);
			}
 %>
	<script>
	<!--
		var frm = document.forms[0];
		var sps = frm.elements("<%= "subprogrammeCode_"+programmeCode1%>");
		if(sps)
		{
			if(typeof sps.length != "number")
				sps = [sps];
				
			for(var k=0; k<	sps.length; k++)
			{
				sps[k].disabled = false;
				if(sps[k].value == "<%= subprogrammeCode1%>")
					sps[k].checked = true;					
			}
		}
	//-->	
	</script>
<% 
		}
	}
%>	
</html:form>
</body>
</html>