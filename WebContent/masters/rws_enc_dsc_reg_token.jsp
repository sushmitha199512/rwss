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

<title>ENC DSC Registration Token</title>
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

<script type="text/javascript">
function dscSaveToken()
{
	var k=confirm("Please check the eToken Details.!");
	if(k==true){
	document.forms[0].action="switch.do?prefix=/masters&page=/encDSRegToken.do&mode=encsign";
	document.forms[0].submit();
	}else{
		
	}

}
</script>
<script type="text/javascript">
function viewEncTokenDetails(){
	
	document.forms[0].action="switch.do?prefix=/masters&page=/encDSRegToken.do&mode=viewEnc";
	document.forms[0].submit();
}
</script>
<body bgcolor="#edf2f8" >
<html:form action="encDSRegToken.do&mode=encRegToken" method="post">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="ENC DSC Registration Token" />
	<jsp:param name="TWidth" value="100%" />
	
</jsp:include>

<table width="600" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
 
<tr>
 		<td class="textborder" width="150">ENC Name<font color="red" size="3">*</font></td>
		<td >
		<html:text property="encName" maxlength="50" size="80" />
		</td>
</tr>
<tr>
 		<td class="textborder" width="150">PAO Code<font color="red" size="3">*</font></td>
		<td >
		<html:text property="paoCode" maxlength="15" size="20"/>
		</td>
</tr>

<tr>
<td class="textborder" width="50" >Token Password<font color="red" size="3">*</font> </td>
		<td >
		<html:password property="tokenPwd" onblur="viewEncTokenDetails()"/>	    	
	</td>
		
</tr>

<tr align="center">
	<td class="textborder" width="50">Token Details</td>
    <td width="80" class="btext"><font size="3" >Issuer </font><html:textarea property="issuer" rows="4" cols="35" readonly="true" /> </td>
    <td width="150" class="btext"><font size="3">Issuer Name</font><html:textarea property="issuerName" rows="4" cols="35" readonly="true" /> </td>
    <td width="110" class="btext"><font size="3">Valid From</font> <html:textarea property="validFrom" rows="4" cols="35" readonly="true" /></td>
    <td width="80" class="btext"><font size="3"> Valid To </font> <html:textarea property="validTo" rows="4" cols="35" readonly="true"/></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
	    <html:button property="mode" title="Save" styleClass="btext" value="Save"  onclick="javascript:dscSaveToken()"/>
 		<html:reset title="Clear" styleClass="btext" value="Reset" /> 		
	</td>
 </tr>
 </table>



<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

</html:form>
<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>


<%@ include file="/commons/rws_footer.jsp"%>
</body>
</html>

