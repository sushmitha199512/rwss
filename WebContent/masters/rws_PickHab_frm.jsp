<%@ include file="/commons/rws_header1.jsp" %>
<html:javascript formName="sourceForm" />
<script language="JavaScript">
<!--

function init()
{
	 var tempIndex="<%= request.getParameter("index")%>";
	 
  	 //alert(tempIndex);
}
function addfun()
{

 	var index = document.getElementById("count").value;
	for(var i=0;i<index;i++)
	{
		if(document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked)
		{
				document.getElementById("SOURCEHAB_LIST["+i+"].isChecked").value="true";
		}
		else
		{
				document.getElementById("SOURCEHAB_LIST["+i+"].isChecked").value="false";
		}
	}
	//alert("habCode is <%= request.getAttribute("habCode") %>");
	var assetCompTypeCode="<%=request.getParameter("assetCompTypeCode")%>";
	var assetSubCompTypeCode="<%=request.getParameter("assetSubCompTypeCode")%>";
	var assetTypeCode="<%=request.getParameter("assetTypeCode")%>";
	
   
    var totalHabitations;
   	var noOfSelectedHabs = 0;
   	var totPopulation = 0;
 	for(var i=0; i<index; i++)
 	{
		 if(document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked)
		 {
			    noOfSelectedHabs++;	
			    totPopulation=totPopulation+parseInt(document.getElementById("SOURCEHAB_LIST["+i+"].totPop").value);
			   
		 }
	}
	//alert(noOfSelectedHabs);
	if(noOfSelectedHabs==0)
	{
  	   alert("Please select atleast one habitation."); 
  	   return false;
  	}
  	else 
  	{  
  		var tempIndex="<%= request.getParameter("index")%>";
  		var schemeCode="<%= request.getParameter("schemeCode")%>";
	 	//alert(tempIndex);
	 	if(assetCompTypeCode=="01")
	 	{
  	 		document.forms[0].action="switch.do?prefix=/masters&page=/Source.do&index="+tempIndex+"&mode=AddHab"
  	 						+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode
  	 						+"&assetSubCompTypeCode="+assetSubCompTypeCode
  	 						+"&schemeCode="+schemeCode
							+"&noOfHab="+noOfSelectedHabs;
  	 	}
  	 	else
  	 	{
  	 		document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&index="+tempIndex+"&mode=AddHab"
  	 						+"&assetTypeCode="+assetTypeCode+"&assetCompTypeCode="+assetCompTypeCode
  	 						+"&assetSubCompTypeCode="+assetSubCompTypeCode
  	 						+"&schemeCode="+schemeCode
							+"&noOfHab="+noOfSelectedHabs;
  	 	}
         
       // opener.document.forms[0].noOfHab.value = noOfSelectedHabs;
        if(opener.document.forms[0].popbenefited)
        	opener.document.forms[0].popbenefited.value=totPopulation;
		//opener.getElementById("ASSETRESERVIOR_LIST["+index+"].noOfHab").value = noOfSelectedHabs;
//		 alert(opener.getElementById("ASSETRESERVIOR_LIST[0].noOfHabs").value);
	//	 alert("aaaaaaaaaaaaaaaa");
        return true; 
     } 
	 var url = "switch.do?prefix=/proposals&page=/AdminstrativeSanction.do&mode=carryHabs&habs="+s+"&noOfHabs="+count
	 alert(opener.document.getElementById("ASSETRESERVIOR_LIST["+i+"].noOfHabs").value);
			openerDoc.forms[0].action = url;
			openerDoc.forms[0].submit();
			window.close();
        
}//-->
</script>
</head>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" onload="init()">
<html:form action="Source.do?mode=AddHab">
<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>

	<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
	   style="border-collapse:collapse;display:block">
		<tr bgcolor="#8A9FCD">
		<td class=mycborder colspan=5><FONT class=myfontclr><font color="#ffffff">Select the Habitations Located in the Source </font>
		</td>
		</tr>
		<tr>
		<td class=clrborder align=center>Select</td>
		<td  class=clrborder align=center>Hab Code</td>
		<td  class=clrborder align=center>Hab Name</td>
		<td  class=clrborder align=center>population</td>
		<td  class=clrborder align=center>Status</td>
		</tr>
		<% int count=0; %>
		
		<nested:iterate id="SOURCEHAB_LIST" name="sourceHabs" >
		
		<%count=count+1;%>
		<tr>
		<td align=center class=bwborder>
			<nested:checkbox name="SOURCEHAB_LIST" property="habCode" indexed="true" />
			<nested:hidden name="SOURCEHAB_LIST" property="isChecked" value="false" indexed="true" />
		</td>
		
		<td  class=bwborder align=center >
			<nested:text name="SOURCEHAB_LIST" property="panchRajCode" styleClass="mytbltext" style="width:160px" readonly="true" indexed="true"/>
		</td> 
	 	<td  class=bwborder align=center >
			<nested:text name="SOURCEHAB_LIST" property="panchRajName" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td>
		<td  class=bwborder align="right">
			<nested:text name="SOURCEHAB_LIST" property="totPop" readonly="true" styleClass="mytbltext" style="width:80px" indexed="true"/>
		</td>
		<td  class=bwborder align=center >
			<nested:text name="SOURCEHAB_LIST" property="coverStatus" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td>
		</tr>
		</nested:iterate>
		<input type="hidden" name="count" value="<%= count %>">
		</table>
	</td>
	</tr>
	<tr>
		<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Add" onclick="return addfun()" />
	     <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>
		</td>
	</tr>
</table>
<script>
<!-- 
  var index = document.getElementById("count").value;
   
   for(var i=0; i<index; i++)
   {
   
   if(document.getElementById("SOURCEHAB_LIST["+i+"].panchRajCode").value == "<c:out value='${baseHab}'/>")
 	  {
 	  
 	  	document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked = true;
 	  	document.getElementById("SOURCEHAB_LIST["+i+"].habCode").disabled = true; 	  	
 	  }
   
 	 /* <c:forEach items="${tempSelectedSourceHabs}" var="habs">
		if(document.getElementById("SOURCEHAB_LIST["+i+"].panchRajCode").value == "<c:out value='${habs.panchRajCode}'/>")
		{
		   document.getElementById("SOURCEHAB_LIST["+i+"].habCode").checked = true;
		}
		</c:forEach>	*/
	}
 
//-->
</script>
</html:form>
</body>
</html>
