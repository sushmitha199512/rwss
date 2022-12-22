<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
%>


<%@ include file="/commons/rws_header2.jsp" %>

<head>
<script language="javascript">
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function funcInit()
{
	
	//code to check parent window or child window
	/*
	if(typeof(window.opener)!="undefined") 
	alert("child");
	else
	alert("parent");
	*/
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin")
	{
		document.forms[0].addNew.disabled="true";
	}

}
function funcDistrictChanged()
{
	//document.forms[0].mandal.selectedIndex.value=0;
	//document.forms[0].sarpanchName.value=" ";
	//document.forms[0].sarpanchMobile.value=" ";
	//document.forms[0].status.value=" ";
	//document.forms[0].frmDate.value=" ";
	//document.forms[0].toDate.value=" ";
	document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=editdivisions";
	document.forms[0].submit();
}

function fnSave()
{

	document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=save";
	document.forms[0].submit();
	//document.forms[0].save.disabled=true;


}

function fnSaveNew()
{
	
	if(document.forms[0].district.value=="")
	{
		alert("Please Select Circle");
		return;
	}
	else if(document.forms[0].division.value=="")
	{
		alert("Please Select Division");
		return;
	}
	else if(document.forms[0].divmandals.value=="")
	{
		alert("Please Select Division");
		return;
	}	
	else{
		document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=update";
		document.forms[0].submit();
	}
}
function viewfun()
{
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
		document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=view";
		document.forms[0].submit();
}



function fnsarpanchDetails()
{
	document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=get";
	document.forms[0].submit();
}
 
 
function fnmandals()
{
	document.forms[0].action="/pred/smsmobile/divisionMandal.do?mode=editmandals";
	document.forms[0].submit();
	}
</script>
</head>
<body  onload="autocompletion()">
<html:form action="divisionMandal.do">

<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
			
			
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="DLPO Division/Mandal Form" />
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

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="350" >
<tr>
<td>
	
		<fieldset>
		<legend><bean:message key="legend.rwsOffices"/></legend>
		<label>
		<table  border=0  width="100%">
		
		<tr>
			<td class="textborder">District
			<span class="mandatory">*</span>
		</td>
		
		<td class="textborder">
			<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
				<html:select property="district" style="width:140px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="districtName" styleClass="mytext" style="width:140px"
						    readonly="true" />
				
				<html:hidden property="district" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder">Division Code
			<span class="mandatory">*</span>
		</td>
		<td>
				<html:text property="division" style="width:140px"
						    disabled="true" />
				<%-- <html:select property="division" style="width:140px"  onchange="fnmandals()"  styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divisions" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select> --%>
		</td>
		</tr>
		
		<tr>
		<td class="textborder">Division Name
			<span class="mandatory">*</span>
		</td>
		<td>
				<html:text property="divisionName"  style="width:140px"  disabled="true"/>
				
		</td>
		</tr>
		
		
		<tr>
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="divmandals" style="width:140px"    styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divmandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<html:hidden property="oldDivision"/>
			<html:hidden property="oldMandal"/>
			<html:hidden property="oldCircle"/>
		
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
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSaveNew()" />
			<html:button property="mode" title="View DLPO Mandal" styleClass="btext" value="View"  onclick="return viewfun()"/>
			</td>
		</tr>
		</table>
	</td>
	</tr>
		</table>
		</td>
		</tr>
		</tbody>
		</table>
		</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>		 
	