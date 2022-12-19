<%@ include file="/commons/rws_header1.jsp" %>
<%
RwsUser user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
	  response.sendRedirect("unAuthorise.jsp");	
}

java.util.ArrayList aaa = (java.util.ArrayList)request.getAttribute("censusVillages");
 %>
<script language="JavaScript">

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/MandalSubdivision.do&mode=showMandals";
	document.forms[0].submit();
}

function fnAdd(frm)
{
	var rad_val='';
	var rad_text = '';
	for (var i=0; i < document.forms[0].selectedHabCode.length; i++)
  	{
   		if (document.forms[0].selectedHabCode[i].checked)
    	{
       		var val = document.forms[0].selectedHabCode[i].value;
       		rad_val = val.substring(0,14);
       		rad_text = val.substring(15,val.length);
      	}
   }
   if(rad_val=='')
   {
   		alert("Select One Village as Census Village");
   		return false;
   	}
   	else
   	return true;
}


function getParameters()
{
	var rad_val='';
	var rad_text='';
	for (var i=0; i < document.forms[0].selectedHabCode.length; i++)
  	{
   		if (document.forms[0].selectedHabCode[i].checked)
    	{
       		var val = document.forms[0].selectedHabCode[i].value;
       		rad_text = val.substring(0,val.length-11);
       		rad_val = val.substring(val.length-8,val.length);
       	}
   }
   if(rad_val=='')
   {
   		alert("Select One Village as Census Village");
   		return false;
   	}
   	else
		{
			var openerDoc = opener.document;
			var frm = openerDoc.forms[0];
			frm.action = "switch.do?prefix=/masters&page=/MandalSubdivision.do?mode=populateVillage&vcode="+rad_val+"&vname="+rad_text;
			frm.submit();
			window.close();
		}
}

</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="MandalSubdivision" onsubmit="return fnAdd(this)">


<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="none" width="100%" border=1 style="border-collapse:collapse;" >
<tr>
<td class="bwborder" >
<fieldset>
<legend><B>Details</B></font></legend>
<label>
<table cellpadding="0" cellspacing="0" border="0" width="100%" bordercolor= "#8A9FCD" style="border-collapse:collapse;" >
<tr>
				<td class="bwborder"><FONT class=myfontclr>District&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="censusDistt" styleClass="combo"  onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="censusDistricts">
						<html:options collection="censusDistricts" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
				<td class="bwborder"><FONT class=myfontclr>Sub District&nbsp;<font color="#FF6666">*</font>:</FONT></td>
				<td class="bwborder">
					
					<html:select property="censusSubDist" styleClass="combo"  onchange="getData()">
					<html:option value=""><bean:message key="app.pleaseSelect" /></html:option>
					<logic:notEmpty name="censusSubDistricts">
						<html:options collection="censusSubDistricts" name="labelValueBean" 
									  property="value" labelProperty="label" />
					</logic:notEmpty>			  
				</html:select>
			
				</td>
</tr>
<%if(aaa!=null && aaa.size()!=0){ %>
<tr>
<td colspan="4">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.village" /></th>
</tr>
</thead>
<tbody class="gridText">
<%
for(int i=0;i<aaa.size();i++)
{
	nic.watersoft.commons.LabelValueBean labelValueBean = new nic.watersoft.commons.LabelValueBean();
	labelValueBean = (nic.watersoft.commons.LabelValueBean)aaa.get(i);
	
%>
<tr>
	<td align="center">
		<input type="radio" name="selectedHabCode" 
			   value="<%=labelValueBean.getLabelValue()%>"/>
	</td>
	<td align="left">
		<b><%=labelValueBean.getLabel()%></b>
	</td>
	
</tr>
<%
} 
%>

</tbody>
</table>
</td>
</tr>
<tr>
<td colspan="4" align="center">
<input type="hidden" name="proposalId" value="<c:out value='${habitations[0].proposalId}'/>">
<br>
<center>
	<html:submit property="mode" value="Save" styleClass="btext" onclick="getParameters()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</td>
</tr>
<%}
else
{ %>
<tr>
<td colspan="4">
<center><b class="gridLabel">
There are no Census Villages in the selected Sub District.
<br>Please select different Combination</b><br> 
<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</td>
</tr>
<%}%>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">

<script>
<!-- 

var frm = document.forms[0];
var habs = frm.elements("selectedHabCode");
if(habs)
{
	if(typeof habs.length != 'number')
		habs = [habs];
	
	for(var i=0; i<habs.length; i++)
	{
		<c:forEach items="${tempSelectedHabs}" var="item">
			if(habs[i].value == '<c:out value="${item.habCode}" />')
				habs[i].checked = true;
		</c:forEach>	
	}
}
//-->
</script>
</html:form>
</body>
</html>

<%
	String message = (String)request.getAttribute("insert-success");
	if(message != null && message.equals("inserted"))
	{
%>
	<script>
	<!--
		var index = document.getElementById("index").value;
		var openerDoc = opener.document;
		alert("Habitations added successfully.\nPress OK to continue...");
		var url = "switch.do?prefix=/proposals&page=/RepresentativeProposalData.do&mode=showHabs";
		openerDoc.forms[0].action = url;
		openerDoc.forms[0].submit();
		window.close();
	//-->
	</script>
<%
	}
	
	if(message != null && message.equals("not-inserted"))
	{
%>
	<script>
	<!--
		alert("Cannot add habitations.\n Please try again.");
		openerDoc.getElementById("WORK["+index+"].noOfHabs").value = "";
	//-->
	</script>
<% 
	}
%> 