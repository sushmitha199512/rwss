<%@page import="nic.watersoft.smsmobile.NicSmsGateway"%>
<%@page import="nic.watersoft.admin.OTPGeneration"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<%
nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userid = users.getUserId();

%>
<html>
<head>
<!-- <script type="text/javascript" src="/resources/javascript/emailValidation.js"></script> -->
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<!-- <title>Users List Form</title> -->
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>


<script type="text/javascript" language="JavaScript">




function checkOtp(){
	
	var otp= document.forms[0].elements["otp"].value;
	
	
	if((otp == null || otp == '') ){
		   alert('Please Enter OTP');
		   return false;
		}
	else{

		   document.forms[0].action="switch.do?prefix=/fundAccounting&page=/otp.do?mode=get";	
		   document.forms[0].submit();
			
		}
		
}
</script> 

<body >

<html:form action="otp.do" method="post">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="OTP" />
	<jsp:param name="TWidth" value="320" />
	
</jsp:include>

<table  width="360" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
  
	   <tr><td></td><td></td></tr>
	<tr >
	<td class="textborder" align="right">Enter OTP</td><td><html:text property="otp" maxlength="6" /></td>
	</tr>
	

		<tr><td colspan="14" align="center"><input type=button value=Submit onClick="checkOtp();" class="btext">
		&nbsp;&nbsp;&nbsp;&nbsp;
		
		</td>
		</tr>
		
	</table>
	
	

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="320" />
</jsp:include>

</html:form>
 
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

