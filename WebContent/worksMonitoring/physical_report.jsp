<%@		taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@		taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@		taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@		taglib uri="/WEB-INF/jstl-core" prefix="c" %>


<html>	
<head>
 <%@ page import="java.util.Date" %>
<%! Date date= new Date(); %>
   <%! int day=date.getDate(); %>  	
   <%! long month=date.getMonth(); %>  
   <%! long year = date.getYear(); %> 
<script>
	
function ppdelete()
{
	//alert("PPPPPPPP");
	

	document.financialForm.cmdDel.value="2";
	document.financialForm.action="InsertFinancialProgress.do";
	document.financialForm.submit();
}
function winClose()
{
	location.href="/Pred/main.jsp";
}
function main()
{
	window.location="main.jsp";
}
</script>





	<title>WATERSOFT</title>

	<link rel="stylesheet" type="text/css" href="resources/style/style.css">
		<link rel="stylesheet" type="text/css" href="resources/style/menu.css">
		

	</head>
	<html:messages id="error">
<%=error%><br>
</html:messages>
		<body>
<html:form action="InsertFinancialProgress"  onsubmit="return validateFinancialForm(this)">

<center>
<span class = "mainHeading">WATERSOFT</span><br>
<span class = "mainHeading">Panchayat Raj & Engineering Department, Rural Water Supply Sector</span> <br>
<span class = "mainHeading">Government of Andhra Pradesh</span>


</center>
	

	</html:form>

