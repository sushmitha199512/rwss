<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"); %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">

function fnSave()
{
	
	var email=document.getElementById("emailId").value;
	var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var service = document.getElementById("servicereq").value;
  
	

   if(document.getElementById("datecollname").value=="")
	{
	alert("Please Select Name Of The Local Person");
	return false;
	}
	else if(document.getElementById("desgnation").value=="")
	{
	alert("Please Enter Designation");
	return false;
	}
	else if(document.getElementById("location").value=="")
	{
	alert("Please Enter Location");
	return false;
	}
	else if(document.getElementById("phoneNo").value=="")
	{
	alert("Please Enter Phone Number");
	return false;
	}
	else if(document.forms[0].phoneNo.value.length!=10)
	{
		alert("Please Enter 10 Digits Mobile Number");
		return;
	}
	else if(document.getElementById("gender").value=="")
	{
	alert("Please Select Gender");
	return false;
	}
	else if (!filter.test(email) && email!="") {
		    alert('Please provide a valid email address');
		    document.forms[0].servicereq.focus;
		    return false;
	}
	else if(document.getElementById("address").value=="")
	{
	alert("Please Enter Address");
	return false;
	}
	else
		{
		if (service == "M" || service == "B") {
			if (document.getElementById("imeino").value == "") {
				alert("Please Enter Valid IMEI");
				return false;
			} 
			if (document.getElementById("username").value == "") {
				alert("Please Enter User Name");
				return false;
			} else if (document.getElementById("password").value == "") {
				alert("Please Enter Password");
				return false;
			}  else if (document.getElementById("modAuth").value == "") {
				alert("Please Select Module Authentication");
				return false;
			}
			else{
				document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=update";
				//alert("document.forms[0].5555"+document.forms[0].action);
				document.forms[0].submit();
				}
		}
		else{
			document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=update";
			//alert("document.forms[0].action"+document.forms[0].action);
			document.forms[0].submit();
			}
		
		
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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=view";
	document.forms[0].submit();
		}
}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=get2";
	document.forms[0].submit();
    
     
}
function getModuleFields() {
	
	 for (i=0; i<document.forms.length; i++) {
	        document.forms[i].setAttribute("AutoComplete","off");
	       }
	 
	var service = document.getElementById("servicereq").value;
	if (service == "S") {
		document.getElementById("unameTR").style.display = "none";
		document.getElementById("pwdTR").style.display = "none";
		/* document.getElementById("cpwdTR").style.display = "none"; */
		document.getElementById("moduleTR").style.display = "none";
	} else if (service == "M" || service == "B") {
		document.getElementById("unameTR").style.display = "block";
		document.getElementById("pwdTR").style.display = "block";
		/* document.getElementById("cpwdTR").style.display = "block"; */
		document.getElementById("moduleTR").style.display = "block";
	}
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

<body onload="getModuleFields()">
	<html:form action="/SmsRegistration.do" method="post">
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
		<jsp:param name="TableName" value="Mobile Registration Edit Form" />
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
   <legend>Registration Details</legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		
	
		<html:text property="districtName" styleClass="mytext" style="width:150px" readonly="true" disabled="true"/>
		<html:hidden property="circleOfficeCode"/>
		
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
	<html:text property="mand" styleClass="mytext" style="width:150px" readonly="true" disabled="true"/>
		
		    
	</td>
	</tr>
	<tr>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:text property="panch" styleClass="mytext" style="width:150px" readonly="true" disabled="true"/>
	</td>
	
		</tr>
		<%--  <tr>
		
		<td class="textborder" width="100">
	<bean:message key="app.village" /></td>
	<td class="textborder" width="150">
		<html:select property="vill" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2();hide();">
		<html:option value="">SELECT...</html:option>
        <logic:present name="villages">
		<html:options collection="villages" name="rwsLocationBean" property="villageCode" labelProperty="villageName" />
        </logic:present >
		</html:select>
	</td>
	</tr>  --%>
	<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:text property="habName" styleClass="mytext" style="width:150px" readonly="true" disabled="true"/>
	</td>
	</tr>
	 <tr>
	 <td class="textborder" >
       IMEI No</td><td><html:text property="imeino" styleClass="mytext" style="width:150px" maxlength="15" onkeypress="return numeralsOnly(event)" />
       </td>
	</tr>
	
	
	
	
	
	
	<tr>
	<td class="textborder" >
      Name&nbsp;Of&nbsp;Local&nbsp;Person<font color="#FF6666">*</font></td><td><html:text property="datecollname"    styleClass="mytext" style="width:150px"  />
       </td>
	</tr>
	
	
	<tr>
	<td class="textborder" >
       Designation<font color="#FF6666">*</font></td><td><html:select property="desgnation" styleClass="mycombo" style="width:150px" >
       <html:option value="">--Select--</html:option>
        <html:option value="Teacher">Teacher</html:option>
         <html:option value="Post Master">Post Master</html:option>
          <html:option value="Post Man">Post Man</html:option>
           <html:option value="Student">Student</html:option>
           <html:option value="SHG Member">SHG Member</html:option>
          <html:option value="Panch Volunteer">Panch Volunteer</html:option>
		<html:option value="Spl Officer">Spl Officer</html:option>
		<html:option value="Others">Others</html:option>
      
       </html:select>
       </td>
	</tr>
	
	<tr>
								<td class="textborder">Service&nbsp;Request<font
									color="#FF6666">*</font></td>
								<td><html:select property="servicereq" styleClass="mycombo"
									style="width:150px" onchange="getModuleFields()">

									<html:option value="S">SMS</html:option>
									<html:option value="M">Mobile</html:option>
									<html:option value="B">Both</html:option>

								</html:select></td>

								<%-- <td class="textborder"><html:hidden property="servicereq"
									styleClass="mytext" style="width:150px" /></td> --%>

							</tr>
						<tr id="unameTR" style="display: none;">
								<td class="textborder">User&nbsp;Name<font color="#FF6666">*</font></td>
								<td><html:text property="username" styleClass="mytext"
									style="width:150px" /></td>
							</tr>
							<tr id="pwdTR" style="display: none;">
								<td class="textborder">Password<font color="#FF6666">*</font></td>
								<td><html:password property="password" styleClass="mytext"
									style="width:150px" /></td>
							</tr>
							<%-- <tr id="cpwdTR" style="display: none;">
								<td class="textborder">Confirm Password<font
									color="#FF6666">*</font></td>
								<td><html:password property="confirmpassword"
									styleClass="mytext" style="width:150px" /></td>
							</tr> --%>

							<tr id="moduleTR" style="display: none;">
								<td class="textborder">Module&nbsp;Authentication<font
									color="#FF6666">*</font></td>
								<td class="textborder" colspan=3><html:select
									property="modAuth" styleClass="mycombo" style="width:150px">
									<html:option value="">SELECT...</html:option>
									<logic:present name="tasks">
										<html:options collection="tasks" name="tasks"
											property="taskCode" labelProperty="taskcodename" />

									</logic:present>
								</html:select></td>
	
	<tr>
	
	 <td class="textborder" >
       Location<font color="#FF6666">*</font></td><td><html:text property="location" styleClass="mytext" style="width:150px" readonly="true" />
       </td>
	</tr>
	
	
	<tr>
	
	 <td class="textborder" >
       Mobile&nbsp;Number<font color="#FF6666">*</font></td><td><html:text property="phoneNo" maxlength="10"  size="10"   styleClass="mytext" style="width:150px"  onkeypress="return numeralsOnly(event)"  />
       </td>
	</tr>
	<tr>
	<td class="textborder" >
       Gender<font color="#FF6666">*</font></td><td><html:select property="gender" styleClass="mycombo" style="width:150px">
       <html:option value="">SELECT...</html:option>
        <html:option value="M">Male</html:option>
        <html:option value="F">FeMale</html:option>
        
      </html:select>
       </td>
	</tr>
	
	
	
	
		
	<tr>
	<td class="textborder" >
       Email Id</td><td><html:text property="emailId"    styleClass="mytext" style="width:150px"  />
       </td>
	</tr>	
	<tr>
	<td class="textborder" >
       Address<font color="#FF6666">*</font></td><td><html:textarea property="address"  rows="3" cols="16" />
       </td>
	</tr>
	
	
	
		</table>
		</label>
	</fieldset>
	</td>
</tr>

<html:hidden property="habCode"/>
<html:hidden property="oldMobile"/>

   
   
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="Update the Fields"  styleClass="btext" value="Update"  onclick="fnSave();"/>

	
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


<table width="30%" align=center>
<tr><td bordercolor="black"><font color="red" size="2" >NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td>
<td class=rptValue nowrap>1. For IMEI Number Dail <font color="red"> *#06# </font>on your Phone or Tab</td></tr>


</table>


<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
