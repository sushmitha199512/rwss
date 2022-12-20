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

/* function fnSave()
{
	


 if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
		}
	document.forms[0].action="/pred/masters/ceo.do?mode=save";
	document.forms[0].submit();
} */


function fungetDetails()
{
	document.forms[0].action="/pred/masters/ceo.do?mode=get";
	document.forms[0].submit();
	
}
function fnSaveNew()
{
	var email = document.forms[0].ceoEmailId.value;
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var dpoemail = document.forms[0].dpoEmailId.value;
	
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	
	else if(document.forms[0].ceoName.value=="")
	{
		alert("Please Enter CEO Name");
		document.forms[0].ceoName.focus();
		return ;
	}
	else if(document.forms[0].ceoMobile.value=="")
	{
		alert("Please Enter CEO Mobile Number");
		document.forms[0].ceoMobile.focus();
		return;
	}
	else if(!(document.forms[0].ceoMobile.value.length == 10))
	{
		alert("Please Enter 10 Digit Mobile Number");
		document.forms[0].ceoMobile.focus;
		return;
	}
	
	else if (!filter.test(email) && email!="") {
	    alert('Please provide a valid email address');
	    document.forms[0].ceoEmailId.focus;
	    return;
	 } 
	else if(document.forms[0].dpoName.value=="")
	{
		alert("Please Enter DPO Name");
		document.forms[0].ceoMobile.focus();
		return;
	}
	else if(document.forms[0].dpoMobile.value=="")
	{
		alert("Please Enter DPO Mobile Number");
		document.forms[0].ceoMobile.focus();
		return;
	}
	else if (!filter.test(dpoemail) && dpoemail!="") {
	    alert('Please provide a valid email address');
	    document.forms[0].ceoEmailId.focus;
	    return;
	 } 
	
	else{
		document.forms[0].action="/pred/masters/ceo.do?mode=save";
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
			document.forms[0].action="/pred/masters/ceo.do?mode=view";
		document.forms[0].submit();
	
	
}
function fnAddNew()
{
	
	document.forms[0].action="/pred/masters/ceo.do?mode=addNew";
	document.forms[0].submit();

}


function fnsarpanchDetails()
{
	document.forms[0].action="/pred/masters/ceo.do?mode=get";
	document.forms[0].submit();
}

function distodate()
{
	if(document.forms[0].status.value=='W')
		{
		document.forms[0].toDate.disabled=true;
		disablelink();
		}
	 else
		if(document.forms[0].status.value=='N')
		{
		document.forms[0].toDate.disabled="";
		}	
	} 
	
function disablelink()
{
var hlink = document.getElementById('date');
if(!hlink)
return;
hlink.href = "#";
hlink.className = "disableLink";
}
</script>
<style type="text/css">
.disabledLink
{
color: #333;
text-decoration : none;
cursor: default;
}
</style>
</head>
<body onload="autocompletion()" >
<html:form action="ceo.do">
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
		<jsp:param name="TableName" value="CEO ZP/DPO Entry Form" />
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
				<html:select property="district" style="width:140px"  styleClass="mycombo" onchange="javascript: fungetDetails()">
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
			<td class="textborder">CEO Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="ceoName" style="width:140px"   maxlength="23" onkeypress="return textOnly()" />
					
			</td>
		
		
		</tr>
		
		
		
	<tr>
			<td class="textborder">CEO Mobile No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="ceoMobile" style="width:140px" readonly="false" maxlength="10" onkeypress="return numeralsOnly()" />
					
			</td>
		</tr>
		
		<tr>
			<td class="textborder">CEO Email Id
				
			</td>
			<td>
					<html:text property="ceoEmailId" style="width:140px" readonly="false"/>
					
			</td>
		</tr>
		
		
		
		<tr>
			<td class="textborder">DPO Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="dpoName" style="width:140px"   maxlength="23" onkeypress="return textOnly()" />
					
			</td>
		
		
		</tr>
		
		
		
	<tr>
			<td class="textborder">DPO Mobile No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="dpoMobile" style="width:140px" readonly="false" maxlength="10" onkeypress="return numeralsOnly()" />
					
			</td>
		</tr>
		
		<tr>
			<td class="textborder">DPO Email Id
				
			</td>
			<td>
					<html:text property="dpoEmailId" style="width:140px" readonly="false"/>
					
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
			<html:button property="mode" title="View CEO" styleClass="btext" value="View"  onclick="return viewfun()"/>
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
	