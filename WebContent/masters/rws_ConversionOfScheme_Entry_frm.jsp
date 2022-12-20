<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
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
function getData()
{
	
	document.forms[0].action="switch.do?prefix=/masters&page=/conversionOfSchemes.do&mode=data";
	document.forms[0].submit();
}

function showSources()
{
    var circleOfficeCode = document.forms[0].districtCode.value; 
    var mandalCode = document.forms[0].mandalCode.value;
    var panchayatCode = document.forms[0].panchayatCode.value;
    var villageCode=document.forms[0].villageCode.value;
    var habCode = document.forms[0].habCode.value;
    var width = 850;
    var height = 550;
    var left = parseInt((screen.availWidth / 2) - (width / 2));
    var top = parseInt((screen.availHeight / 2) - (height / 2));
    if (document.forms[0].districtCode.value == "")
    {
        alert("District Required");
    }
    else if (document.forms[0].mandalCode.value == "")
    {
        alert("Mandal Required");
    } else if (document.forms[0].panchayatCode.value == "")
    {
        alert("Panchayat Required");
    }
    else if (document.forms[0].villageCode.value == "")
    {
        alert("Villeage is Required");
    } 
    else if (document.forms[0].habCode.value == "")
    {
        alert("Habitation is Required");
    } else
    {

        if (document.forms[0].districtCode.options != undefined)
        {
            var printString =
                    "District:" + document.forms[0].districtCode.options[document.forms[0].districtCode.selectedIndex].text
                    + " Mandal:" + document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
                    + " Panchayat:" + document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
                    + " Village:" + document.forms[0].villageCode.options[document.forms[0].villageCode.selectedIndex].text
                    + " Habitation:" + document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text;
        } else
        {
            var printString = "District:" + document.forms[0].districtName.value + " Mandal:" + document.forms[0].mandalCode.options[document.forms[0].mandalCode.selectedIndex].text
                    + " Panchayat:" + document.forms[0].panchayatCode.options[document.forms[0].panchayatCode.selectedIndex].text
                    + " Village:" + document.forms[0].villageCode.options[document.forms[0].villageCode.selectedIndex].text
                    + " Habitation:" + document.forms[0].habCode.options[document.forms[0].habCode.selectedIndex].text;
        }
        
        var url = "switch.do?prefix=/masters&page=/rws_select_Asset_Schemes_Sources_frm1.jsp?&habCode=" + habCode +  "&printString=" + printString;
        var properties = "width=" + width + ",height=" + height + ",screenX=" + left + ",screenY=" + top + ",toolbar=no,"
                + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
                + "resizable=yes,status=yes";
        newWindow = window.open(url, "_New", properties);
        newWindow.focus();
    } 

}
 function removeprhab()
{
	var assetcode=document.forms[0].assetCode.value;
    var assetname=document.forms[0].assetName.value;
    var asch2=document.forms[0].type_of_asset_code.value;
    if(document.forms[0].assetCode.value=="")
    	{
    	alert("select Asset");
    	}
    else if(document.forms[0].type_of_asset_code.value=="")
    	{
    	alert("Asset Changed Type To is required");
    	}
    else{
    	if(asch2=="09")
    		chtype="DirectPumping";
    	else if(asch2=="01")
    		chtype="PWS";
    	else if(asch2=="02")
    		chtype="MPWS";        	 	   
    	     var r = confirm("Are Sure You Want To Change The Asset "+assetname+"("+assetcode+") To "+chtype);
    	    if (r == true) {
    	        document.forms[0].action="switch.do?prefix=/masters&page=/conversionOfSchemes.do&mode=update&assetcode="+assetcode+"&asch2="+asch2;
        		document.forms[0].submit();
    	    } else {
    	        return;
    	    }
    	    //document.getElementById("demo").innerHTML = txt;   	 
    	 
    	}
}
</SCRIPT>
<script type="text/javascript">

</script>
<style>


</style>
<html:form action="/conversionOfSchemes.do">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Conversion Of Schemes" />
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
	<html:select property="district" style="width:123px" styleClass="mycombo" styleId="districtCode" onchange="javascript:getData()" >
	<html:option value=""><font class="myfontclr1">SELECT...</html:option>
	<html:options collection="dists" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
	</html:select>
		
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.mandal" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="mandal" styleClass="mycombo" style="width:123px" styleId="mandalCode" onchange="javascript:getData()" >
	<html:option value="">SELECT...</html:option>
	<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
	</html:select>
	</td>
</tr>
<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.panchayat" /><font color="#FF6666">*</font></FONT></td>
	<td class=mycborder >
	<html:select property="pcode" styleClass="mycombo" style="width:123px" styleId="panchayatCode"  onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="panchyats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
	</html:select>
	</td>
	</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr><bean:message key="app.village" /><font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder >
	<html:select property="vcode" styleClass="mycombo" style="width:123px"  styleId="villageCode" onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
	</html:select>
	</td>
</tr>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Hab Code<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder colspan="7">
	<html:select property="habCode" styleClass="mycombo" style="width:280px"  styleId="habCode"  onchange="javascript:getData()">
	<html:option value="">SELECT...</html:option>
	<html:options collection="habitations" name="rwsMaster" property="habCode"  labelProperty="habName" />
	</html:select>
	</td>
	</tr>
	<tr><td></td><td>
                                        <html:button property="mode" styleClass="btext" value="Select Assets" onclick="return showSources()"/>&nbsp;
                                        <!-- <input type="button" Class="btext" value="Ftk Tested Sources" title="Ftk Tested Sources" style="width:140px" onclick="return viewFtkSources();"/>&nbsp; -->
                                    </td>  </tr>
	
	<tr>
	<td class="bwborder" nowrap><FONT class=myfontclr>Asset Code&nbsp;:<font color="#FF6666">*</font></FONT>
    <html:text property="assetCode" style="width:200px"  disabled="true"  readonly="true" /></td>
    <td class="bwborder" nowrap><FONT class=myfontclr>Asset Name&nbsp;:<font color="#FF6666">*</font></FONT>
    <html:text property="assetName" readonly="true" style="width:200px" disabled="true" /></td>
    </tr>
	<%-- <tr>
	 <td><FONT color="#FF6666" style="font-size: 9px">Selected Asset Type Is:<bean:write name="assetType"/></FONT></td>
	</tr> --%>
	<tr>
	<td class=mycborder >
	<FONT class=myfontclr>Asset Type Changed To<font color="#FF6666">*</font></FONT></td>
	<td  class=mycborder colspan="7">
	<html:select property="type_of_asset_code" styleClass="mycombo" style="width:123px"  onkeydown="javascript:getData();">
	<html:option value="">SELECT...</html:option>
	<html:options collection="SchemesTo"  name="scheme" property="type_of_asset_code" labelProperty="type_of_asset_name" />
	</html:select>
	
	</td>
	</tr>
	</table>
	
<tr align="center"><td colspan="2" ><html:button property="mode" title="Remove PRHabs" styleClass="btext" value="Submit" onclick="return removeprhab()"/></td></tr>
 <jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="540"/>
</jsp:include>&nbsp;

</html:form>
<%-- <%@ include file="/commons/rws_alert.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%> --%>