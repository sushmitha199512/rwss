<%@ include file="conn3.jsp" %>
<%@ include file="header_rpt.jsp" %>
<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>

<html>
<head>
<title>Login Form</title>

<script language="JavaScript">
function fnsubmit()
{
	document.loginForm.cmdLogin.value="fromLogin";
	if(document.loginForm.userName.value=="" || document.loginForm.passWord.value=="")
	alert("UserName & PassWord Should not be blank");
	
		//document.f1.action="temp.jsp";
	else
	document.loginForm.submit();
}
function failsubmit()
{
	alert("Invalid UserName & PassWord");
}
function focus()
{
	
	document.loginForm.submit();
}
</script>
<link rel="stylesheet" type="text/css" href="style.css"> 
</head>
<html:messages id="error">
<%=error%><br>
</html:messages>
		<body align=center bgcolor="#ffffff">
<html:form action="LoginAction"  >
<center>

<%
String vusername="";
String vpassword="";
String s="";
%>
<!-- <span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span> -->

<br><br>
<table cellpadding="0" cellspacing="0">
		<tr>
			<td><img src="resources/images/top_left_b.gif"></td>
			<td background="resources/images/top_center_b.gif" width="204" class="heading" valign="middle" align="center" class id ="mainheading"><font color="#000000" face=verdana size=2><b>Login Form</td>
			<td><img src="resources/images/top_right_b.gif"></td>
		</tr>
	</table>
<table border=1 cellspacing=1 cellpadding=1 width="39%" height="40%" style="border-collapse:collapse" rules="none" bordercolor=navy >


<!-- <form name=f1 method="post" > -->
<tr>
<td class=label align=left><font color="#000000" face=verdana size=2><b><bean:message key="app.login.userName" />
		
		<td class=label>:</td>
		<td class=label><html:text property="userName" styleClass="btext" maxlength="6"/></td>

		</tr>
		<tr>
<td class=label align=left><font color="#000000" face=verdana size=2><b><bean:message key="app.login.passWord" />
		
		<td class=label>:</td>
		<td class=label><html:password property="passWord" styleClass="btext" maxlength="6"/></td>

		</tr>
		<%

		%>
</table>
			  <table cellpadding="0" cellspacing="0" >
		<tr>	

			<td><img src="resources/images/bottom_left.gif"></td>
			<td background="resources/images/bottom_center.gif" width="220" class="heading" valign="middle"	align="center"></td>
			<td><img src="resources/images/bottom_right.gif" ></td>
		</tr>
		</table>
		<tr>
<!-- </form> -->
<br>
<html:hidden property="cmdLogin" />
<td colspan=3 align=center><input type=button value=submit name=button1 onclick="fnsubmit()" ></td>

</tr>
</form>
               </center>
<p align="center">

<%@ include file="footer.jsp" %>


              </p>

			   </body>
			   </html:form>