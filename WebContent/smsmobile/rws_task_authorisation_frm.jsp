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
	
	
	
	if(document.getElementById("taskAuthorizationCode").value=="")
	{
		alert("Please Eneter Task Authorization Code");
		return false;
	}
	
	else if(document.getElementById("taskAuthorizationName").value=="")
	{
		alert("Please Eneter Task Authorization Name");
		return false;
	}
	
	else
		{
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=saveTask";
		//alert("document.forms[0].action"+document.forms[0].action);
		document.forms[0].submit();
		
		}
	
	
	}

function fnView(){
	
	
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/SmsRegistration.do?mode=viewTask";
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

<body>
	<html:form action="/SmsRegistration.do" method="post" enctype="multipart/form-data">

<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Task Autherization Form" />
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
   <legend> Task Authorization Details</legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
    
	
	
	
	<tr>
	
	 <td class="textborder" >
       Task&nbsp;Authorization&nbsp;Code<font color="#FF6666">*</font></td><td><html:text property="taskAuthorizationCode" styleClass="mytext" style="width:150px"  readonly="true"/>
       </td>
	</tr>
	<tr>
	
	 <td class="textborder" >
       Task&nbsp;Authorization&nbsp;Name<font color="#FF6666">*</font></td><td><html:text property="taskAuthorizationName" styleClass="mytext" style="width:150px"  />
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
