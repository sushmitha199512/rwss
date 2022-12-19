<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy serve
%>

<title>EE DSC RegistrationForm</title>
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
<script type="text/javascript">
function windowClose(){
	window.close();
};
</script>
<script type="text/javascript">


</script>
</head>

<body bgcolor="#edf2f8">
<html:form action="eeDSRegForm.do&mode=view" method="post">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="EE DS Registration Form" />
	<jsp:param name="TWidth" value="1200" />
	
</jsp:include>

<table width="1200">

<tr style="">
    <td width="150" class="btext"><font size="3" >Issuer </font><html:textarea  property="issuer" rows="8" cols="35" readonly="true" /> </td>
    <td width="150" class="btext"><font size="3">Issuer Name</font><html:textarea property="issuerName" rows="8" cols="35" readonly="true" /> </td>
    <td width="150" class="btext"><font size="3">Valid From</font> <html:textarea property="validFrom" rows="8" cols="35" readonly="true" /></td>
    <td width="150" class="btext"><font size="3"> Valid To </font> <html:textarea property="validTo" rows="8" cols="35" readonly="true"/></td>
  </tr>
  
  <tr>
    <td colspan="1" align="center">
	    <html:button property="mode" title="close" styleClass="btext" value="Close" onclick="windowClose();"/>
	</td>
 </tr>
</table>



<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="1200" />
</jsp:include>

</html:form>

<%@ include file="/commons/rws_footer.jsp"%>
</body>
</html>

