<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
%>


<%@ include file="/commons/rws_header2.jsp" %>

<head>
<script language="javascript">
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
	document.forms[0].action="/pred/masters/villagesec.do?mode=mandals";
	document.forms[0].submit();


}
function fnMandalChanged()
{
	document.forms[0].action="/pred/masters/villagesec.do?mode=panchayats";
	document.forms[0].submit();


}
function fnPanchayatChanged()
{
	document.forms[0].action="/pred/masters/villagesec.do?mode=villages";
	document.forms[0].submit();


}

/* function fnSave()
{

	document.forms[0].action="/pred/masters/villagesec.do?mode=save";
	document.forms[0].submit();
	//document.forms[0].save.disabled=true;


} */

function fnSaveNew()
{
	var email = document.forms[0].villageSecEmailId.value;
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		 document.forms[0].district.focus;
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		 document.forms[0].mandal.focus;
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		 document.forms[0].panchayat.focus;
		return;
	}
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		 document.forms[0].village.focus;
		return;
	}
	else if(document.forms[0].villageSecMobile.value=="")
	{
		alert("Please Enter Mobile Number");
		 document.forms[0].villageSecMobile.focus;
		return;
	}
	else if(!(document.forms[0].villageSecMobile.value.length == 10))
	{
		alert("Please Enter 10 Digit Mobile Number");
		document.forms[0].villageSecMobile.focus;
		return;
	}
	else if(document.forms[0].villageSecName.value=="")
	{
		alert("Please Enter Name.");
		 document.forms[0].villageSecName.focus;
		return;
	}
	else if(email=="")
	{
		alert("Please Enter Email ID.");
		 document.forms[0].villageSecEmailId.focus;
		return;
	}
	else if (!filter.test(email) && email!="") {
		    alert('Please provide a valid email address');
		    document.forms[0].villageSecEmailId.focus;
		    return false;
		 } 
	
	else if(document.forms[0].status.value=="")
	{
		alert("Please Enter status .");
		 document.forms[0].status.focus;
		return;
	}

	else if(document.forms[0].frmDate.value=="")
	{
		alert("Please Enter  Starting Date .");
		 document.forms[0].frmDate.focus;
		return;
	}
	else if(document.forms[0].toDate.value!="" && document.forms[0].status.value=="W")
	{
		
			alert("Please Change the status To Not Working");
			 document.forms[0].status.focus;
			return;
		
	}
	else if(document.forms[0].toDate.value=="" && document.forms[0].status.value=="N")
	{
		
			alert("Please Select To Date");
			 document.forms[0].status.focus;
			return;
		
	}
	else{

		document.forms[0].action="/pred/masters/villagesec.do?mode=update";
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
			document.forms[0].action="/pred/masters/villagesec.do?mode=view";
		document.forms[0].submit();
	
 
}
function fnAddNew()
{
	document.forms[0].action="/pred/masters/villagesec.do?mode=addNew";
	document.forms[0].submit();

}


function fnsarpanchDetails()
{
	document.forms[0].action="/pred/masters/villagesec.do?mode=get";
	document.forms[0].submit();
}
function distodate()
{
	for (i = 0; i < document.forms.length; i++) {
		document.forms[i].setAttribute("AutoComplete", "off");
	}
	if(document.forms[0].status.value=='W')
		{
		document.forms[0].toDate.disabled=true;
		disablelink();
		}
	 else
		if(document.forms[0].status.value=='R')
		{
		document.forms[0].toDate.disabled="";
		enablelink();
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
function enablelink()
{
var hlink = document.getElementById('date');
if(!hlink)
return;
hlink.href = "javascript:showCalendar(document.getElementById('toDate'))";
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
<body onload="return distodate()">
<html:form action="villagesec.do">

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
		<jsp:param name="TableName" value="Village Secretary Edit Form" />
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
						    readonly="true" disabled="true"/>
				
				<html:hidden property="district" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="fnMandalChanged()" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="mandals" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder">Panchayat
				<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="panchayat" style="width:140px"    styleClass="mycombo"  onchange="fnPanchayatChanged()" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
	 	</td>
		</tr>
	
		
		<tr>
		<td class="textborder">Village
				<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="village" style="width:140px"    styleClass="mycombo" disabled="true">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					 <html:options collection="villages" name="labelValueBean" 
								  property="value" labelProperty="label" /> 
				</html:select>
	 	</td>
		</tr>
		
		
		
		
		<tr>
			<td class="textborder"> Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="villageSecName" style="width:140px"   maxlength="23" onkeypress="return textOnly()" />
					
			</td>
		
		
		</tr>
		
		
		
	<tr>
			<td class="textborder"> Mobile No
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="villageSecMobile" style="width:140px" readonly="false" maxlength="10" onkeypress="return numeralsOnly()" />
					
			</td>
		</tr>
		
		<tr>
			<td class="textborder"> Email Id
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="villageSecEmailId" style="width:140px" readonly="false"  />
					
			</td>
		</tr>
		
		<tr>
			<td class="textborder">Status
				<span class="mandatory">*</span>
				</td><td>
				<html:select property="status" style="width:140px"    styleClass="mycombo" onclick="distodate()"  onchange="distodate()"  >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
				<html:option value="W">Working</html:option>
				<html:option value="R">Not Working</html:option>
				
				</html:select>
			</td>
				
		
		</tr>
			
		<tr >


		
		<tr>
		<td  class=textborder >
		<FONT class=myfontclr>From Date</FONT>
		<span class="mandatory">*</span>
		</td>
		<td  class=textborder >
		<html:text property="frmDate" styleClass="mytext" size="10" />
		<a href="javascript:showCalendar(document.getElementById('frmDate'));"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		
		</tr>
		
				
		
		
		
		
		
			<tr>
		<td  class=textborder >
		<FONT class=myfontclr>To Date</FONT>
		</td>
		<td  class=textborder >
		
		<html:text property="toDate"  styleClass="mytext" size="10" />
		<a href="javascript:showCalendar(document.getElementById('toDate'));" id="date"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a>
		
	
	
		
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
			<html:button property="mode" title="View Sarpanch" styleClass="btext" value="View"  onclick="return viewfun()"/>
			
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
	