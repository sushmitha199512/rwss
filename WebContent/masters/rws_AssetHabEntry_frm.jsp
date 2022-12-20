<%@ include file="/commons/rws_header1.jsp" %>
 <html:javascript formName="assetForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{ var dcode="<%=request.getParameter("dcode")%>";
	//alert(dcode);
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=hab&dcode="+dcode;
	document.forms[0].submit();
}
function func()
{
  document.getElementById("ASSETHAB_LIST["+0+"].habitation").checked = true;
}
function addfunc()
{
  var temp="<%=request.getParameter("form")%>";
  var index = document.getElementById("count").value;
  var k=0;
   for(var i=0; i<index; i++){
    if(document.getElementById("ASSETHAB_LIST["+i+"].habitation").checked)
 	    k=k+1; 
   }		    
  if(temp=="edit")
  {
     var habCode="<%=request.getParameter("habCode")%>";
     for(var i=0; i<index; i++){
 		 if(document.getElementById("ASSETHAB_LIST["+i+"].habName").value==habCode){
		    document.getElementById("ASSETHAB_LIST["+i+"].habitation").checked = true;
		  } 
      }		    
   } 
   if(k==0)
   {
   	alert("Please select atleast one habitation.");
   	return false;
   }
   else{
	   
      
	   for(var i=0; i<index; i++)
	   {
	   	  if(document.getElementById("ASSETHAB_LIST["+i+"].habCode").value == "<c:out value='${baseHabitation}'/>")
	 	  {
	 	  	document.getElementById("ASSETHAB_LIST["+i+"].habitation").disabled = false; 	  	
	 	  	
	 	  }
	 	}
      document.forms[0].submit();
	
 
      alert("Habitations Added Successfully\n press OK to continue...");  
	   self.close();
	  opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=ShowHabsBenfit"; 
	  //opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=ShowHabsBenfit&typeOfAssetCode="+document.assetForm.assetTypeCode.value;
      // opener.document.forms[0].submit();
     
      	return true;
   }

}
//-->
</SCRIPT>
</head>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" >
<html:form action="Asset.do?mode=checks">

<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>
<table  border=0  width="580"  align=center  >
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="dcode" style="width:150px" styleClass="mycombo" onchange="javascript:getData()" >
		<html:option value="">SELECT...</html:option>
		<html:options collection="dists" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
	</html:select>
	</td>
	<!-- <td>	 <html:text name="assetForm" property="district" style="width:150px"  styleClass="mytext" readonly="true" /> </td>
     --> 
	 <input type="hidden" name="dcode" value=<%=request.getParameter("dcode")%> >
         <% if(((String)session.getAttribute("mandal"))!=null) {
    %>   
 
     <td class=mycborder >
	 <FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	 <td class=mycborder >
	 <html:text name="assetForm" property="mandal" style="width:150px"  styleClass="mytext" readonly="true" />
	  
     <input type="hidden" name="mandal" value=<%=request.getParameter("mandal")%> >
     <input type="hidden" name="habCode" value=<%=request.getParameter("habCode")%> >
     </td>       
     <%}else{%>
     <td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mandal" styleClass="mycombo" style="width:123px" onchange="javascript:getData()" >
	<html:option value="">SELECT...</html:option>
	<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
	</html:select>
	</td>
    <%} %> 
      
     <input type="hidden" name="assetTypeCode" value="<%=request.getParameter("assetTypeCode")%>">
	</table>
	
	<table border=1 width="590" style="border-collapse:collapse;" bgcolor="#ffffff" bordercolor= "#8A9FCD" >
		<tr bgcolor="#8A9FCD">
		<td class=mycborder colspan=5><FONT class=myfontclr><font color="#ffffff">Select the Habitations</td>
		</tr>
		<td class=mycborder align=center><FONT class=myfontclr><font color="#993366">Select</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Habitation Code</FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Habitation Name</FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Total Population</FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">Coverage Status</FONT>
		</td>
		</tr>
		<% int count=0; %>
		<nested:iterate id="ASSETHAB_LIST" property="assetHabs">
		<%count=count+1;%>
		<tr>
 		 <% if(((String)session.getAttribute("mandal"))!=null) {%>   
		  <td align=center class=mycborder1><nested:checkbox name="ASSETHAB_LIST" property="habitation" indexed="true"  onclick="func()" /></td>
		  <script>
		     document.getElementById("ASSETHAB_LIST["+0+"].habitation").checked = true;

		  </script>
		<%}else{%>
    	  <td align=center class=mycborder1><nested:checkbox name="ASSETHAB_LIST" property="habitation" indexed="true" /></td>
    	  <%}%>
		<td  class=mycborder1 align=center >
		<FONT class=myfontclr1><nested:text name="ASSETHAB_LIST" property="habCode" styleClass="mytbltext" style="width:150px" readonly="true" indexed="true"/></FONT>
		</td>
		<td  class=mycborder1 >
		<FONT class=myfontclr1><nested:text name="ASSETHAB_LIST" property="habName" readonly="true" styleClass="mytbltext" style="width:200px" indexed="true"/></FONT>
		</td>
		<td  class=mycborder1 align=center >
		<FONT class=myfontclr1><nested:text name="ASSETHAB_LIST" property="totPopu" styleClass="mytbltext" style="width:150px" readonly="true" indexed="true"/></FONT>
		</td>
		<td  class=mycborder1 >
		<FONT class=myfontclr1><nested:text name="ASSETHAB_LIST" property="covStatus" readonly="true" styleClass="mytbltext" style="width:200px" indexed="true"/></FONT>
		</td>
		</tr>
		</nested:iterate>
		<input type="hidden" name="count" value="<%= count %>">
		</table>
	<tr>
	<td colspan="2" align="center">
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick="return addfunc()" />
 
     <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/>
	 
	</td>
</tr>
</table>
<script>
<!-- 
   var index = document.getElementById("count").value;
   var temp="<%=request.getParameter("form")%>";
   for(var i=0; i<index; i++)
   {
   	  if(document.getElementById("ASSETHAB_LIST["+i+"].habCode").value == "<c:out value='${baseHabitation}'/>")
 	  {
 	  	
 	  	document.getElementById("ASSETHAB_LIST["+i+"].habitation").checked = true;
 	  	document.getElementById("ASSETHAB_LIST["+i+"].habitation").disabled = true; 	  	
 	  	
 	  }
 	  <c:forEach items="${tempSelectedHabs}" var="habs">
   	  	if(document.getElementById("ASSETHAB_LIST["+i+"].habCode").value == "<c:out value='${habs.habCode}'/>")
		{
		  document.getElementById("ASSETHAB_LIST["+i+"].habitation").checked = true;
  		}
		</c:forEach>	
	}
 
//-->
</script>
</html:form>



