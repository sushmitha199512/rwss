<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_admin_authorization_struts.jsp"%>
<html:javascript formName="panchayatForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
function resetfn()
{

if(panchayatForm.district.value!="")
{
document.forms[0].action="switch.do?prefix=/masters&page=/PanchRaj.do&mode=resetForm";
	document.forms[0].submit();
	}
}

function getData()
{
	document.forms[0].action="switch.do?prefix=/masters&page=/PanchRaj.do&mode=data";
	document.forms[0].submit();
}
function addprhab()
{
   var c = document.getElementById("count").value;
   var k=0;
   for(var i=0; i<c; i++)
	{  if(document.getElementById("PRHAB_LIST["+i+"].jbCode").value.length!=2)
	       k=k+1;
	}
	if(k==0){
     return true; }
	else{
	  alert("PR HABCODE Must be 16 digits");
	  return false;
	 }

	  
}

 function removeprhab()
{
   var c = document.getElementById("count").value;
   var k=0;
   
   for(var i=0; i<c; i++){
    if(document.getElementById("PRHAB_LIST["+i+"].habitation").checked)
 	    k=k+1; 
   }
   if(c==0)
   {
     	alert("There are no Habitations");
     	return false;
   }
   else{
    if(k==0)
    {
     	alert("Please select atleast one habitation.");
     	return false;
    }
    else{
     document.forms[0].action="switch.do?prefix=/masters&page=/PanchRaj.do&mode=Remove";
	 document.forms[0].submit();
    }
   } 
}
//-->
</SCRIPT>
<%@ include file="/commons/rws_header2.jsp" %>


<html:form action="/PanchRaj.do" onsubmit="return validatePanchayatForm(this)" >

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Habitation Code Detials Entry Form" />
	<jsp:param name="TWidth" value="540" />
</jsp:include>

<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="580" >
<tr>
<td>
<table  border=0  width="100%" >
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.district" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="district" style="width:123px" styleClass="mycombo" onchange="javascript:getData()" >
	<html:option value=""><font class="myfontclr1">SELECT...</html:option>
	<html:options collection="dists" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
	</html:select>
		
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mandal" styleClass="mycombo" style="width:123px" onchange="javascript:getData()" >
	<html:option value="">SELECT...</html:option>
	<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
	</html:select>
	</td>
</tr>
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.panchayat" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="pcode" styleClass="mycombo" style="width:123px"   onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="panchyats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
	</html:select>
	</td>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.village" /><font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:select property="vcode" styleClass="mycombo" style="width:123px"   onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
	</html:select>
	</td>
</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Hab Code<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder colspan="7">
	<html:select property="habCode" styleClass="mycombo" style="width:280px"   onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="habitations" name="rwsMaster" property="habCode" labelProperty="habitationCode" />
	</html:select>
	</td>
	</tr>
	</table>
	<table border=1 width="100%" style="border-collapse:collapse;" bgcolor="#ffffff" bordercolor= "#8A9FCD" >
		<tr bgcolor="#8A9FCD">
		<td class=mycborder colspan=3><FONT class=myfontclr><font color="#ffffff">PRHab Details </td>
		</tr>
		<tr>
		<td  class=mycborder align=center><font class="myfontclr"><font color="#993366">Select</font></font></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">PRHab Code</FONT>
		</td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><font color="#993366">PRHab Name</FONT>
		</td>
		 
		</tr>
		<%int count=0;%>
		<nested:iterate id="PRHAB_LIST" property="prHabs" >
			<% count++; %>
		<tr>
		<td><nested:checkbox name="PRHAB_LIST" property="habitation" indexed="true" /></td>
		<td class=mycborder align=center >
		<table border=0>
		<tr>
   		<td align=right class=mycborder>
		<nested:text name="PRHAB_LIST" styleClass="mytbltext" property="habCode"  maxlength="14" indexed="true" style="width:112px" 
   		 readonly="true"/>
 	    </td>
 	    <td class=mycborder>
		<nested:text name="PRHAB_LIST" styleClass="mytbltext" property="jbCode"  maxlength="2" indexed="true" onkeypress="return numeralsOnly(event)"/>
		</td>
		</tr>
		</table>
		</td>
      	<td class=bwborder>
		<nested:text name="PRHAB_LIST" styleClass="mytbltext" property="habName" style="width:200px" maxlength="25" indexed="true"  onkeypress="upperOnly()"/>
		</td>
		
		</tr>
		</nested:iterate>
			<input type="hidden" name="count" value="<%= count %>">
		</table>
		<tr>
	<td colspan="2" align="center">
	<html:button property="mode" title="Remove PRHabs" styleClass="btext" value="Remove PRHabs" onclick="return removeprhab()"/>
	<html:submit property="mode" title="Add new PRHab" styleClass="btext" value="Add New PRHab" onclick="return addprhab()"/>
	<html:submit property="mode" title="Save the Fields" styleClass="btext" value="Save" onclick=" return winView() "/>
    <html:reset title="Clear all the Fields" styleClass="btext" value="Reset" onclick="resetfn()" />
	</td>
</tr>
</table>

 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="540"/>
</jsp:include>

</html:form>
<%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>