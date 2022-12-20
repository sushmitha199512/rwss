<%@ include file="/commons/rws_header1.jsp" %>
 <html:javascript formName="assetForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=hab";
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
      document.forms[0].submit();
      alert("Habitations Added Successfully\n press OK to continue...");
      if(temp=="edit")
      {
        opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=disp&typeOfAssetCode="+document.assetForm.assetTypeCode.value;
        opener.document.forms[0].submit();
      }  
      	return true;
   }

}
//-->
</SCRIPT>
</head>
<body bgcolor="#edf2f8" topmargin="0" leftmargin="0" >
<html:form action="Asset3.do?mode=checks">

<table  bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="590" align=center>
<tr>
<td>
 
	 
	
	<table bgcolor="#FFFFFF" width="100%" bordercolor="#000000" border="1" style="border-collapse:collapse;margin-top:0">
	    <thead class="gridHeader">
	    <tr>
	    <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrNo"/></b></font>
		</th> 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrLocation"/></b></font>
		 </th> 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrCapacityInLts"/></b></font>
		 </th>
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrNoOfFillings"/></b></font>
		 </th>
		  <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrMade"/></b></font>
		 </th>
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrCondition"/></b></font>
		 </th>		 
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrFillHrs"/></b></font>
		 </th>	
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrEmptyHrs"/></b></font>
		 </th>	
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrDraCondition"/></b></font>
		 </th>
		 <th> 
         <font size="1" face="verdana" color="black"><b>&nbsp;<bean:message key="app.glsrHygiene"/></b></font>
		 </th>
		 </tr>
		 </thead> 
		 
		<% int count=0; %>
		<nested:iterate id="ASSETSUBCOMP_LIST" property="assetSubComponents">
		<%count=count+1;%>
		<tr>
 		 
		 <% count=count+1; %>
		 <tr>
		 <td    align=center >
		    <nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrNo" maxlength="3" styleClass="gridText" style="width:100px"/>
		 </td>
		 <td    align=center >
			<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrLocation" styleClass="gridText" maxlength="30" style="width:100px"  onkeypress="textOnly()"/>
		 </td>
		 <td   align=center >
			<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrCapacityInLts" maxlength="30"  styleClass="gridText" style="width:100px" onkeypress="decimalsOnly()"/>
		 </td>
		 <td   align=center >
			<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrNoOfFillings" maxlength="30"  styleClass="gridText" style="width:100px" onkeypress="numeralsOnly()"/>
		 </td>
		 
		 <td   align=center >
				<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrMade"    styleClass="gridText" style="width:100px"  onkeypress="textOnly()"/>
		 </td>
	 	 <td    align=center >
				<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrCondition" maxlength="50"  styleClass="gridText" style="width:100px"  onkeypress="textOnly()"/>
		 </td>
		 <td   align=center >
				<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrFillHrs" styleClass="gridText" style="width:100px" onkeypress="numeralsOnly()"/>
		 </td>
 		 <td    align=center >
				<nested:text name="ASSETSUBCOMP_LIST" indexed="true" property="glsrEmptyHrs"  styleClass="gridText" style="width:100px" onkeypress="numeralsOnly()"/>
		 </td>
 		 <td   align=center > 
				<html:select name="ASSETSUBCOMP_LIST" indexed="true" property="glsrDraCondition" styleClass="mycombo" style="width:100px">
	 			<html:option value="">SELECT...</html:option>
				<html:option value="Y">YES</html:option>
				<html:option value="N">NO</html:option>
        	    </html:select>
			 
	 	</td>
		<td  align=center >
			<html:select name="ASSETSUBCOMP_LIST" indexed="true" property="glsrHygiene" styleClass="mycombo" style="width:100px">
			<html:option value="">SELECT...</html:option>
			<html:option value="G">GOOD</html:option>
			<html:option value="B">BAD</html:option>
            </html:select>
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
 
</html:form>



