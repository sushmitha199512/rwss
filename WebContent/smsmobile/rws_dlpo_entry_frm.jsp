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
	document.forms[0].action="/pred/smsmobile/dlpo.do?mode=divisions";
	document.forms[0].submit();
}

function fnSave()
{

	document.forms[0].action="/pred/smsmobile/dlpo.do?mode=save";
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
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Division");
		return;
	}
	else if(document.forms[0].dlpoNo.value=="")
	{
		alert("Please Enter DLPO Employee Code");
		return;
	}
	else if(document.forms[0].dlpoNo.value.length!=8)
	{
		alert("Please Enter 8 Digit Employee Number");
		return;
	}
	
	else if(document.forms[0].sarpanchName.value=="")
	{
		alert("Please Enter DLPO Name.");
		return;
	}
	else if(document.forms[0].sarpanchMobile.value=="")
	{
		alert("Please Enter Mobile Number");
		return;
	}
	else if(document.forms[0].sarpanchMobile.value.length!=10)
	{
		alert("Please Enter 10 Digits Mobile Number");
		return;
	}
	

	
	else{
		document.forms[0].action="/pred/smsmobile/dlpo.do?mode=save";
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
			document.forms[0].action="/pred/smsmobile/dlpo.do?mode=view";
		document.forms[0].submit();
	
 
}
function fnAddNew()
{
	document.forms[0].action="/pred/smsmobile/dlpo.do?mode=addNew";
	document.forms[0].submit();

}


function fnsarpanchDetails()
{
	document.forms[0].action="/pred/smsmobile/dlpo.do?mode=get";
	document.forms[0].submit();
}
 
 
function fnmandals()
{
	document.forms[0].action="/pred/smsmobile/dlpo.do?mode=mandals";
	document.forms[0].submit();
	}
</script>
</head>
<body onload="autocompletion()">
<html:form action="dlpo.do">
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
		<jsp:param name="TableName" value="DLPO Entry Form" />
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
				<html:select property="district" style="width:140px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo">
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
		<td class="textborder">Division
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="mandal" style="width:140px"  onchange="fnsarpanchDetails()"  styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		
		<%-- <tr>
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="divmandals" style="width:140px"  onchange="fnsarpanchDetails()"  styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="divmandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr> --%>
		
		<tr>
			<td class="textborder">DLPO No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="dlpoNo" style="width:140px"   maxlength="8"  onkeypress="return numeralsOnly(event)" />
					
			</td>
		
		
		</tr>
		
		
		<tr>
			<td class="textborder">DLPO Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="sarpanchName" style="width:140px"   maxlength="23" onkeypress="return textOnly()" />
					
			</td>
		
		
		</tr>
		
		
		
	<tr>
			<td class="textborder">DLPO Mobile No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="sarpanchMobile" style="width:140px" readonly="false" maxlength="10" onkeypress="return numeralsOnly()" />
					
			</td>
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
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSaveNew()" />
			<html:button property="mode" title="View MPDO" styleClass="btext" value="View"  onclick="return viewfun()"/>
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
	