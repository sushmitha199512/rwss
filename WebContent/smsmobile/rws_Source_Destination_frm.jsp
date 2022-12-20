<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"); 
String sourceCode=(String)session.getAttribute("nextSourceCode");
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">
function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
function fnSave()
{
	
	
    if(document.forms[0].circleOfficeCode.value== "" || document.forms[0].circleOfficeCode.value==null)
    {
    alert("Please Select District");
    return false;
    }
    
    else if(document.forms[0].mand.value== "" || document.forms[0].mand.value==null)
    {
    alert("Please Select Mandal");
    return false;
    }
    
    else if(document.forms[0].panch.value== "" || document.forms[0].panch.value==null)
    {
    alert("Please Select Panchayat");
    return false;
    }
		
    else if(document.forms[0].habCode.value== "" || document.forms[0].habCode.value==null)
    {
    alert("Please Select Habitation");
    return false;
    }
    
    else if(document.forms[0].psourceCode.value=="" || document.forms[0].psourceCode.value==null)
    	{
    	alert("Please Select Source Code");
    	return false;
    
    	}
    
    else if(document.forms[0].destination.value=="" || document.forms[0].destination.value==null)
	{
	alert("Please Enter Destination");
	return false;

	}
    else if(document.forms[0].distance.value=="" || document.forms[0].distance.value==null)
	{
	alert("Please Enter Distance ");
	return false;

	}
    else if(document.forms[0].fromDate.value=="" || document.forms[0].fromDate.value==null)
	{
	alert("Please Select From Date");
	return false;

	}
	
    else{
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/SourceDestination.do?mode=sourceDestinationSave";
		
		document.forms[0].submit();
    }
		
		}
	
	
	

function fnView(){
	
	if(document.getElementById("circleOfficeCode").value=="")
	{
		alert("Please Select District");
		return false;
	}
	else
		{
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SourceDestination.do?mode=sddview";
	document.forms[0].submit();
		}
}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SourceDestination.do?mode=get2";
	document.forms[0].submit();
    
     
}

</script>

<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:4px 0;
 }
.container img {
    width:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}
.on {
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>



</head>

<body onload="autocompletion()">
	<html:form action="/SourceDestination.do" method="post">
<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Source and Destination Entry Form" />
		<jsp:param name="TWidth" value="100%" />
		
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="450" >
<tr>
<td>
   <fieldset>
   <legend>Source Details</legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="red">*</font></td>
		<td class="textborder" width="80">
		<logic:equal name="RWS_USER" property="circleOfficeCode" value="00">
		<html:select property="circleOfficeCode" styleClass="mycombo" style="width:150px" onchange="javascript:getData2();hide();" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
        </logic:present >
		</html:select>
		</logic:equal>
		<logic:notEqual name="RWS_USER" property="circleOfficeCode" value="00">
		<html:text property="districtName" styleClass="mytext" style="width:150px" readonly="true"/>
		<html:hidden property="circleOfficeCode"/>
		</logic:notEqual>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color=red>*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:150px" onchange="javascript:getData2();hide();">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
            </logic:present >
			</html:select>
	</td>
	</tr>
	<tr>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="red">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2();hide();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
        </logic:present >
		</html:select>
	</td>
	
		</tr>
		
	<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="red">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2();hide();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="habitations">
  	<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
  	
    </logic:present >
		</html:select>
	</td>
	</tr>
	<tr>
	<td class="textborder" width="100">
	Source&nbsp;Code<font color="red">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="psourceCode" styleClass="mycombo" style="width:150px"  >
		<html:option value="">SELECT...</html:option>
        <logic:present name="sources">
  	<html:options collection="sources" name="PrivateSourceForm" property="psourceCode" labelProperty="psourceName" />
  	
    </logic:present >
		</html:select>
	</td>
	</tr>
	
	
	<tr>
	 <td class="textborder" >
      Destination<font color="red">*</font></td><td><html:text property="destination"  style="width:150px" />
       </td>
	</tr>
	
	<tr>
	 <td class="textborder" >
      Distance&nbsp;in&nbsp;Kms<font color="red">*</font></td><td><html:text property="distance"  style="width:150px"  onkeypress="return decimalsOnly(event)" />
       </td>
	</tr>
	<tr>
	<td class="textborder" >From&nbsp;Date<font color="red">*</font></td>
	<td>
	<html:text   property="fromDate"    style="width:120px"  />
					    			   <a href="javascript: showCalendarFuture(document.getElementById('fromDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>
	</tr><tr>
	<td class="textborder" >To&nbsp;Date</td>
	<td>
	<html:text   property="toDate"    style="width:120px"     />
					    			   <a href="javascript: showCalendarFuture(document.getElementById('toDate'));">
								  <IMG SRC="<rws:context page='/images/calendar.gif'/>
								   " width="20" border="0" height="17" align="absmiddle"></a>
	</td>
	</tr>
	
	
		</table>
		</label>
	</fieldset>
	</td>
</tr>



   
   
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="Save the Fields"  styleClass="btext" value="Save"  onclick="fnSave();"/>

	<html:button property="view" title="View the Fields"  styleClass="btext" value="View"  onclick="fnView();"/>
</td>
    </tr>


</table>
		</td>
		</tr>
		</tbody>
		</table>
</html:form>

</body>
</html>


<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
