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
		{
			selectedHab = document.forms[0].leadHab.value;
			alert(document.forms[0].leadHab.text);
		}
	}
	else
	{
		for(var j=0;j<document.forms[0].leadHab.length;j++)
		{
			if(document.forms[0].leadHab[j].checked)
			{
				selectedHab = document.forms[0].leadHab[j].value;
			}
		}
	}	
	if(selectedHab==undefined || selectedHab=="" || selectedHab==null)
	{
			alert("Please Select Asset Type");
	}
	else
	{
		if(confirm("Are You Sure with This Asset Type - This Selection Can not be Undone"))
		{
			var openerDoc = opener.document;
			var url = "switch.do?prefix=/works&page=/SchemeAsset.do&mode=getWorkStatus&workId="+workId+"&schemeSpecial="+selectedHab;
			openerDoc.forms[0].action = url;
			openerDoc.forms[0].submit();
			window.close();
		}
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
<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">
<html:form action="SchemeAsset">

		

<logic:notEmpty name="assetTypes">
<p align=center>
<font face=verdana size=2 color=red><b>
Scheme Type for this Work is : <%=session.getAttribute("type_of_asset")%><BR>
You may Select Any Asset Type of the Following
		</b></font>
</p>
<table width="60%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block" align="center">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.select" /></th>
	<th>Type Of Asset</th>
</tr>
</thead>
<tbody class="gridText">
<c:forEach items="${assetTypes}" end="8" var="item" varStatus="status">
<tr>
	<td align="center">
		<input type="radio" name="leadHab" 
			   value="<c:out value='${item.value}' />"/>
	</td>
	<td align="left">
		<b><c:out value="${item.label}" /></b>
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<br>
<center>
	<html:button property="mode" value="Proceed With Selected Asset Type" styleClass="btext"  onclick="fnAdds()"/>
</center>
</logic:notEmpty>

<logic:empty name="assetTypes">
<center><b class="gridLabel">
There are no Asset Typessssss
</center>
</logic:empty>
<input type="hidden" name="index" value="<c:out value='${param.index}'/>">
<html:hidden property="circleCode"/>
<html:hidden property="divCode"/>
<html:hidden property="subdivisioncode"/>
<html:hidden property="plan"/>
<html:hidden property="wrktype"/>
<html:hidden property="workCat"/>
<html:hidden property="program"/>
<html:hidden property="subprogram"/>
</html:form>
</body>
</html>