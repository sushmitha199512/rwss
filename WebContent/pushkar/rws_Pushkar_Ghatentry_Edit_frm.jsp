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
	document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=mandals";
	document.forms[0].submit();


}
function fnMandalChanged()
{
	document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=panchayats";
	document.forms[0].submit();


}
function fnPanchayatChanged()
{
	document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=pushkartype";
	document.forms[0].submit();


}



function fnSave()
{

	document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=save&pcode="+document.forms[0].panchayat.value;
	document.forms[0].submit();
	document.forms[0].save.disabled=true;
	
	


}

function fnSaveNew()
{
	alert("111");
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	else if(document.forms[0].mandal.value=="")
	{
		alert("Please Select Mandal");
		return;
	}
	else if(document.forms[0].panchayat.value=="")
	{
		alert("Please Select Panchayat");
		return;
	}
	else if(document.forms[0].vcode.value=="")
	{
		alert("Please Enter PushkarGhat Code");
		return;
	}
	else if(document.forms[0].vname.value=="")
	{
		alert("Please Enter PushkarGhat Name");
		return;
	}
	
	else if(document.forms[0].pushkartype.value=="")
	{
		alert("Please Enter pushkar type ");
		return;
	}
	
	
	else{
		document.forms[0].save.disabled=true;
		document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=saveNew&pcode="+document.forms[0].panchayat.value;
		document.forms[0].submit();
	}
}
function viewfun()
{
	if(document.forms[0].district.value!="" && document.forms[0].mandal.value!="")
	{
		document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=view";
		document.forms[0].submit();
	}
	else
	{
		alert("District is Required\nMandal is Required\nPanchayat is Required");
	
	}

}
function fnAddNew()
{
	document.forms[0].action="/pred/pushkar/PushkarGhat.do?mode=addNew";
	document.forms[0].submit();

}

</script>
</head>
<body>
<html:form action="PushkarGhat.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="PushkarGhat Entry Form" />
		<jsp:param name="TWidth" value="100%" />
		<jsp:param name="contextHelpUrl" value="/pred/help/village.doc" />
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
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="mandal" style="width:140px"    styleClass="mycombo" onchange="fnMandalChanged()">
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
				
				<html:select property="panchayat" style="width:140px"    styleClass="mycombo"  >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="panchayats" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		
		<tr>
		<td class="textborder">PushkarGhat Type
				<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="pushkartype" style="width:140px"    styleClass="mycombo"  >
				<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:option value="A">A</html:option>
					<html:option value="B">B</html:option>
					<html:option value="C">C</html:option>
					
				</html:select>
		</td>
		</tr>
		
		<% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("pushkarEdit")){ %>
		<tr>
			<td class="textborder">PushkarGhat Code
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="vcode" style="width:140px" readonly="true"/>
					
			</td>
		</tr>
		<tr>
			<td class="textborder">PushkarGhat Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="vname" style="width:140px" />
					
			</td>
		</tr>
		<%} %>
		<% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("pushkarGhatNew")){ 
		System.out.println("in pushkarGhatNew new");%>
		<tr>
			<td class="textborder">PushkarGhat Code
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="vcode" style="width:140px" readonly="false" maxlength="3" onkeypress="return numeralsOnly()" />
					
			</td>
		</tr>
		<tr>
			<td class="textborder">PushkarGhat Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="vname" style="width:140px"   maxlength="23" onkeypress="return textOnly()" />
					
			</td>
		</tr>
		<%} %>
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
			 <% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("pushkarEdit")){ %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
			<%} %>
			
			
			
			
			
				<% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("pushkarEdit")){ %>
			<html:button property="mode" title="Close The Form" styleClass="btext" value="Close"  onclick="javascript:self.close();"/>
			<%} %>
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
	