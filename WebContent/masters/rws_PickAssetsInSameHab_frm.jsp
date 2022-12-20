<%@ include file="/commons/rws_header1.jsp" %>

<SCRIPT LANGUAGE="JavaScript">
<!--
function addfunc()
{
       
		  var habcode = "<%=request.getParameter("habCode")%>";
	   	  var typeOfAsset="<%=request.getParameter("assetTypeCode")%>";
		  var doc="<%=request.getParameter("district")%>";
		  var sdoc="<%=request.getParameter("sdoc")%>";
		  var district="<%=request.getParameter("district")%>";
		  var mandal ="<%=request.getParameter("mandal")%>";
		  var vcode ="<%=request.getParameter("vcode")%>";
		   var pcode ="<%=request.getParameter("pcode")%>";
		   alert("dist is "+doc);
   		   alert("mandal is "+mandal);
   		   alert("panch is "+pcode);
   		   alert("village is "+vcode);
   		   alert("habcode is "+habcode);
           alert("typeOfAsset is "+typeOfAsset);
		 // var pumpCode=sourceForm.pumpCode.value;

alert(document.getElementById("count").value);

  var temp="<%=request.getParameter("form")%>";
  var index = document.getElementById("count").value;
  var k=0;
   for(var i=0; i<index-1; i++){
	 
    if(document.getElementById("SOURCEASSET_LIST["+i+"].habCode").checked)
 	    k=k+1; 

   }
  
  if(temp=="edit")
  {
     var habCode="<%=request.getParameter("habCode")%>";
     for(var i=0; i<index; i++){
 		 if(document.getElementById("SOURCEASSET_LIST["+i+"].assetTypeName").value==habCode){
		    document.getElementById("SOURCEASSET_LIST["+i+"].assetName").checked = true;
		  } 
      }		    
   } 
   if(k==0)
   {
   	alert("Please select atleast one Asset.");
   	return false;
   }
   else {
	   alert("end dffer");
      document.forms[0].submit();
      alert("Assets Added Successfully\n press OK to continue...");
     // opener.document.forms[0].action="switch.do?prefix=/masters&page=/Source.do&mode=data"
	 opener.document.forms[0].action="switch.do?prefix=/masters&page=/Source.do?mode=data&doc="+doc+"&sdoc="+sdoc+"&district="+doc+"&mandal="+mandal+"&habCode="+habcode+"&pcode="+pcode+"&vcode="+vcode+"&sourceTypeCode=1&subSourceTypeCode=1";
       opener.document.forms[0].submit();
        
      	return true;
   }

}

//-->
</SCRIPT>
</head>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<html:form action="Source.do?mode=Add">

<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>

	<table border=1 width="100%" style="border-collapse:collapse;" bgcolor="#ffffff" bordercolor= "#8A9FCD" >
		<tr bgcolor="#8A9FCD">
		<td class=mycborder colspan=4><FONT class=myfontclr><font color="#ffffff">
			<c:if test="${param.status == 'hab'}">
				Select the Assets Located in the same Habitation as the Source 
			</c:if>
			<c:if test="${param.status != 'hab'}">
				Select the Assets Located in different Habitation as the Source 
			</c:if>
		</td>
		</tr>
		<tr>
		<td class=clrborder align=center>Select</td>
		<td  class=clrborder align=center>Asset Type</td>
		<td  class=clrborder align=center>Asset Code</td>
		<td  class=clrborder align=center>Asset Name</td>
		</tr>
		<%int count=1; %>
		<nested:iterate id="SOURCEASSET_LIST" property="sourceAssets">
		<tr>
		<%count=count+1; %>
		<td align=center class=bwborder>
			<nested:checkbox name="SOURCEASSET_LIST" property="habCode" indexed="true" />
		</td>
		<td  class=bwborder align=center >
			<nested:text name="SOURCEASSET_LIST" property="assetTypeName" styleClass="mytbltext" style="width:100px" readonly="true" indexed="true"/>
		</td>
		<td  class=bwborder align=center >
			<nested:text name="SOURCEASSET_LIST" property="assetCode" styleClass="mytbltext" style="width:120px" readonly="true" indexed="true"/>
		</td>
		<td  class=bwborder >
			<nested:text name="SOURCEASSET_LIST" property="assetName" readonly="true" styleClass="mytbltext" style="width:130px" indexed="true"/>
		</td>
		</tr>
		</nested:iterate>
		<input type=hidden name="count" value="<%=count%>">
		</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Add" onclick="return addfunc()" /> 
    <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>
 
	</td>
</tr>
</table>
<script>
<!-- 

   var index = document.getElementById("count").value;
   for(var i=0; i<index; i++)
   {
 	  <c:forEach items="${tempSelectedAssets}" var="assets">
		if(document.getElementById("SOURCEASSET_LIST["+i+"].assetCode").value == "<c:out value='${assets.assetCode}'/>")
		{
		   document.getElementById("SOURCEASSET_LIST["+i+"].habCode").checked = true;
		}
		</c:forEach>	
	}
 
//-->
</script>
</html:form>
</body>
</html>



