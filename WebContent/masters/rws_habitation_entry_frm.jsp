<%@ include file="/commons/rws_header1.jsp" %>
<%@	page import="java.util.*" %>
<%@	page import="nic.watersoft.commons.Debug" %>


<%@ include file="/commons/rws_header2.jsp" %>
<%
	nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
%>
<head>
<script language="javascript">

function funcClose()
{
	if(typeof(window.opener)!="undefined") 
	{
		//alert("child");
		self.close();
	}
	else
	{
		//alert("parent");
		winClose();
	}

}
function funcDistrictChanged()
{
	document.forms[0].action="/pred/masters/Habitation.do?mode=mandals";
	document.forms[0].submit();
	
	
}

function selectionChanged(mode)
{
	if(document.forms[0].panchayat)
	{
		document.forms[0].action="/pred/masters/Habitation.do?mode="+mode;
		document.forms[0].submit();
	}
}

function fnSave()
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin" && ad!="100000" && ad.substring(3,6) != "000")
	{
//		if(document.forms[0].district.value=="14" )
	//	{
			alert("Record Cannot be saved as it has been freezed");
			return;
		//}
			
	}
	document.forms[0].action="/pred/masters/Habitation.do?mode=save";
	document.forms[0].submit();
	document.forms[0].save.disabled=true;


}

function fnSaveNew()
{
	var ad='<%= (String)session.getAttribute("userId")%>';
	if(ad!="admin" && ad!="100000" && ad.substring(3,6) != "000")
	{
		//if(document.forms[0].district.value=="14" )
		//{
			alert("Record Cannot be saved as it has been freezed");
			return;
		//}
	}
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	if(document.forms[0].constituency.value=="")
	{
		alert("Please Select Constituency");
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
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		return;
	}
	else if(document.forms[0].hcode.value=="")
	{
		alert("HCode is Required");
		return;
	}
	else if(document.forms[0].prcode.value=="")
	{
		alert("PRCode Is Required");
		return;
	}
	else if(document.forms[0].prHabName.value=="")
	{
		alert("PRHabName is Required");
		return;
	}
	else if(document.forms[0].hcode.value.length!=2)
	{
		alert("HCode Should be Of Length 2");
		return;
	}
	else if(document.forms[0].prcode.value.length!=2)
	{
		alert("PRCode Should be Of Length 2");
		return;
	}
	else{
		document.forms[0].save.disabled=true;
		document.forms[0].action="/pred/masters/Habitation.do?mode=saveNew";
		document.forms[0].submit();
	}
}
function viewfun()
{
	if(document.forms[0].district.value!=""  && document.forms[0].mandal.value!="")
	{
		var x=document.getElementById("mandal");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var mandalName=x.options[x.selectedIndex].text;
		else
		var mandalName="";
		
		var x=document.getElementById("constituency");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var constituencyName=x.options[x.selectedIndex].text;
		else
		var constituencyName="";
		
		var x=document.getElementById("panchayat");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var panchayatName=x.options[x.selectedIndex].text;
		else
		var panchayatName="";
		
		var x=document.getElementById("village");
		if(x.options[x.selectedIndex].text!="SELECT...")
		var villageName=x.options[x.selectedIndex].text;
		else
		var villageName="";
		
		
		
		document.forms[0].action="/pred/masters/Habitation.do?mode=view&mandalName="+mandalName+"&constituencyName="+constituencyName+"&panchayatName="+panchayatName+"&constituencyName="+constituencyName+"&villageName="+villageName;
		document.forms[0].submit();
	}
	else
	{
		alert("District is Required\nMandal is Required");

	}

}
function fnAddNew()
{
	if(document.forms[0].district.value=="")
	{
		alert("Please Select District");
		return;
	}
	if(document.forms[0].constituency.value=="")
	{
		alert("Please Select Constituency");
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
	else if(document.forms[0].village.value=="")
	{
		alert("Please Select Village");
		return;
	}
	else{
		document.forms[0].action="/pred/masters/Habitation.do?mode=addNew";
		document.forms[0].submit();
	}

}

function showHabCode()
{
	if(document.forms[0].hcode && document.forms[0].prcode)
	{
	
		if(document.forms[0].hcode.value!="" && document.forms[0].prcode.value!="")
		{
				document.forms[0].habcode.value=document.forms[0].district.value+document.forms[0].constituency.value+document.forms[0].mandal.value+document.forms[0].village.value+document.forms[0].hcode.value+document.forms[0].panchayat.value+document.forms[0].prcode.value;
		}
		else
			document.forms[0].habcode.value="";
	
	}
	
}
</script>
</head>
<body onload="showHabCode()"> 
<html:form action="Habitation.do">
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Habitation Entry Form" />
		<jsp:param name="TWidth" value="100%" />
		<jsp:param name="contextHelpUrl" value="/pred/help/Hab.doc" />
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
		<input type="hidden" name="prevMode" value=<%=request.getAttribute("mode") %> >
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
				<html:select property="district" style="width:150px"   onchange="javascript: funcDistrictChanged()"	 styleClass="mycombo">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="districts" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
			
			
			</logic:equal>
			<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
				<html:text property="districtName" styleClass="mytext" style="width:150px"
						    readonly="true" />
				
				<html:hidden property="district" />
			</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder">Constituency
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="constituency" style="width:150px"    styleClass="mycombo" onchange="showHabCode()" >
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="constituencies" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<tr>
		<td class="textborder">Mandal
			<span class="mandatory">*</span>
		</td>
		<td>
				
				<html:select property="mandal" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('panchayats')">
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
				
				<html:select property="panchayat" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('villages')">
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
				
				<html:select property="village" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('habitations')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="villages" name="labelValueBean" 
								  property="value" labelProperty="label" />
				</html:select>
		</td>
		</tr>
		<% if(request.getAttribute("mode")!=null && !request.getAttribute("mode").equals("habitationNew")){ %>
		
		<tr>
			<td class="textborder">Habitation Code
				<span class="mandatory">*</span>
			</td>
			<td>
				
				<html:select property="habitation" style="width:150px"    styleClass="mycombo" onchange="selectionChanged('habName')">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<html:options collection="habitations" name="labelValueBean" 
								  property="habCode" labelProperty="habCode" />
					
				</html:select>
		</td>
		</tr>
		
		<tr>
			<td class="textborder">Habitation Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="habName" style="width:150px"   onkeypress="return textOnly()" />
					
			</td>
		</tr>
	
		<%} %>
		<% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("habitationNew")){ %>
		<tr>
			<td class="textborder">HCode
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="hcode" style="width:150px" readonly="false" maxlength="2" onkeypress="return numeralsOnly()" onblur="showHabCode()"/>
					
			</td>
		</tr>
		<tr>
			<td class="textborder">PRCode
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="prcode" style="width:150px" readonly="false" maxlength="2" onkeypress="return numeralsOnly()" onblur="showHabCode()"/>
					
			</td>
		</tr>
		<tr>
			<td class="textborder">Habitation Code
				<span class="mandatory">*</span>
			</td>
			<td>
					<input type="text" name="habcode" style="width:150px"   readonly />
					
			</td>
		</tr>
		<tr>
			<td class="textborder">PRHab Name
				<span class="mandatory">*</span>
			</td>
			<td>
					<html:text property="prHabName" style="width:150px" readonly="false" maxlength="23" onkeypress="return textOnly()"/>
					
			</td>
		</tr>
		<%} %>
		</table>
		</label>
		</fieldset>
		</td>
		</tr>
		<%
								String csrfToken = "";
								nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
								csrfToken = valUtil.getCSRFCode();
								session.setAttribute("csrfToken", csrfToken);
							%>
							<html:hidden property="token" styleClass="mytext"	value="${sessionScope.csrfToken}" />
		<tr>
	<td>
		<table width="100%">
		<tr>
			<td class="textborder" align=center>
			 <% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("habitationEdit")){ %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSave()" />
			<%} %>
			 <% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("habitationNew")){ %>
			<html:button property="save" title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSaveNew()" />
			<%} %>
			
			<html:button property="mode" title="View Habitations" styleClass="btext" value="View"   onclick="return viewfun()"/>
			<% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("habitationEdit")){ %>
			<html:button property="mode" title="Close The Form" styleClass="btext" value="Close"  onclick="javascript:funcClose()"/>
			<%}
			//System.out.println("aaa:"+users.getUserId());
			if(users.getUserId().equals("100000") || users.getUserId().equals("admin")||(users.getUserId().length()==6 && (users.getUserId().substring(users.getUserId().length()-3).equals("000") ))){
				//System.out.println("in false");%>
			<html:button property="addNew" title="Add New Habitation" styleClass="btext" value="Add New"  onclick="fnAddNew();" disabled="false"/>
			<%}else
			{
					//System.out.println("in true");
				%>
			<html:button property="addNew" title="Add New Habitation" styleClass="btext" value="Add New"  onclick="fnAddNew();" disabled="true"/>
				<%}%>
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
	