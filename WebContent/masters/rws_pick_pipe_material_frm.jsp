<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="assetForm" />
<script language="JavaScript">
<!--

function fnGetpipeClass(elem)
{
	alert("sadiq   " );
	alert(elem.name);
	var index = document.getElementById("pipeMaterial").value;
	//var index = elem.name.value
	alert(elem.name+"   "+index );
	document.assetForm.action="/pred/masters/Asset.do?mode=pipeclass";
	document.assetForm.submit();
	
	// document.assetForm.action="switch.do?prefix=/masters&page=/Asset.do&mode=pickpipemat";
//	 document.assetForm.submit();
	   
}
//-->
</script>
</head>

<body leftmargin="0" topmargin="0" bgcolor="#edf2f8">

<html:form action="Asset" >



<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD" align="center" >
	<th colspan=3>
		<font size="2" face="verdana" color="black"><b>&nbsp;Select Pipe Materials </b></font>
	</th>
	</tr>
<tr bgcolor="#8A9FCD">
	 <th> 
		<font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.disMaterial"/></b></font>
		</th> 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.disClass"/></b></font>
		 </th> 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.disDiameter"/></b></font>
	 </th>
	
</tr>
</thead>

<tbody class="gridText">

<c:forEach begin="1" end ="${sessionScope.NoOfPipes}"  >
<tr>
 <td align=center >
 
	  <logic:present name="pipeMaterial">
				<html:select property="pipeMaterial" styleClass="gridText" onchange="javascript: fnGetpipeClass(this)">
					<html:option value="">SELECT... </html:option>
					<html:options collection="pipeMaterial" name="commonLists"  property="value" labelProperty="label" />
				</html:select>
			 </logic:present>  
			 </td>
			  <td align=center >
	  
				<html:select property="pipeMaterial" styleClass="gridText">
					<html:option value="">SELECT... </html:option>
					<html:options collection="pipeMaterial" name="commonLists"  property="value" labelProperty="label" />
				</html:select>
		
			  <td align=center >
	  
				<html:select property="pipeMaterial" styleClass="gridText">
					<html:option value="">SELECT... </html:option>
					<html:options collection="pipeMaterial" name="commonLists"  property="value" labelProperty="label" />
				</html:select>
		
			  		 </tr>
 </c:forEach>

</tbody>
</table>

<br>
<center>
	<html:submit property="mode" value="Add" styleClass="btext"/>
	<html:button property="mode" value="Close" styleClass="btext" onclick="javascript: fnClose()" />
</center>
</html:form>
</body>

