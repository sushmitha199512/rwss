<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
function searchHab()
{

}
function fnAdds()
{
	var selectedHab;
	var workId = '<%=request.getParameter("workId")%>';
	if(document.forms[0].leadHab.length==undefined)
	{
		if(document.forms[0].leadHab.checked)
			selectedHab = document.forms[0].leadHab.value;
	}
	else
	{
		for(var j=0;j<document.forms[0].leadHab.length;j++)
		{
			if(document.forms[0].leadHab[j].checked)
				selectedHab = document.forms[0].leadHab[j].value;
		}
	}	
	if(selectedHab==undefined || selectedHab=="" || selectedHab==null)
	{
			alert("Please Select One habitation as Lead Habitation");
	}
	else
	{
		document.forms[0].action="switch.do?prefix=/works&page=/SchemeAsset.do&mode=addLeadHab&workId="+workId+"&leadHab="+selectedHab;
		document.forms[0].submit();
	}
}
function fnAdd(frm)
{
	
	var selectedHabs = 	frm.elements("leadHab");
	var len;
	var isAllowed = false;
	if(selectedHabs)
	{
		if(typeof selectedHabs.length != 'number')
			selectedHabs = [selectedHabs];
		
		len = selectedHabs.length;
		for(var i=0; i<len; i++)
		{
			if(selectedHabs[i].checked)
				isAllowed = true;
		}
		if(isAllowed)
		{
			if(confirm("Do you want add the selected habitations?"))
			{
				var index = document.getElementById("index").value;
				var totalHabitations = document.forms[0].elements("leadHab");
				var noOfSelectedHabs = "";
				if(totalHabitations)
				{
					if(typeof totalHabitations.length != "number")
					{
						totalHabitations = [totalHabitations];
					}
					var len = totalHabitations.length;
					
					for(var i=0; i<len; i++){
						if(totalHabitations[i].checked)
							noOfSelectedHabs++;  
					}
				}
				var openerDoc = opener.document;
				openerDoc.getElementById("WORK["+index+"].noOfHabs").value = noOfSelectedHabs;
				return false;
			}
		}
		else
			alert("Please select atleast one habitation.");
	}
	return false;
}

function fnOpenerSubmit()
{
	
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="SchemeAsset">

<logic:notEmpty name="tempSelectedHabs">
<p align=center>
<font face=verdana size=2 color=red><b>
Select One Habitation as Lead Habitation<br>from Benefited Habitations</b></font>
</p>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
</tr>
</thead>
<tbody class="gridText">
<c:forEach items="${tempSelectedHabs}" var="item" varStatus="status">
<tr>
	<td align="center">
		<input type="radio" name="leadHab" 
			   value="<c:out value='${item.habCode}' />"/>
	</td>
	<td align="center">
		<b><c:out value="${item.habCode}" /></b>
	</td>
	<td align="left">
		<b><c:out value="${item.habName}" /></b>
	</td>
	<td align="right">
		<c:out value="${item.habPop}" />
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<br>
<center>
	<html:button property="mode" value="Add" styleClass="btext"  onclick="fnAdds()"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:notEmpty>

<logic:empty name="tempSelectedHabs">
<center><b class="gridLabel">
There are no Benefited Habitations for this work
<br>Please Add Benefited Habitations under Work Progress -> Work Completion Phase</b><br> 
<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</logic:empty>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">
</html:form>
</body>
</html> 