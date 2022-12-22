<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<title>EE DSC RegistrationForm</title>
</head>

<script type="text/javascript">
function viewTokenDetails(){
	document.forms[0].action="switch.do?prefix=/masters&page=/eeDSRegForm.do&mode=view";
	document.forms[0].submit();
}

</script>

<script type="text/javascript">
function dscSaveToken()
{	

	if(document.getElementById("circleOffice").value==""){
		alert("You have not yet registered........");
		return;
	}
if(confirm("Please check the eToken Details.!")){
document.forms[0].action="switch.do?prefix=/masters&page=/eeDSRegForm.do&mode=sign";
document.forms[0].submit();
}else{
	
}
}
</script>
<script type="text/javascript">
function getTokenCertValue()
{
	
	//alert(document.forms[0].elements["circleOffice"].value);
	if(document.forms[0].elements["circleOffice"].value==""){
		alert("You have not yet registered........");
		return;
	}
	
	document.getElementById('content').style.display='block';
		
var signdatabase64 = document.SmartCardReaderApplet.readCertificate();
		//var certificate =signdatabase64.trim();
		//alert(signdatabase64);
		if(signdatabase64.length>100){
			
			document.forms[0].elements["certificate"].value=signdatabase64;
		document.getElementById('content').style.display='none';
			document.forms[0].action="switch.do?prefix=/masters&page=/eeDSRegForm.do&mode=processCertificate";
		document.forms[0].submit();
		}else{
			document.getElementById('content').style.display='none';
			alert("Token Not Inserted or Reading Failed");
		}
		
	
}
</script>



<body bgcolor="#edf2f8">
<div id="content" style="display:none" ><img src="images/processing.gif" alt="Loading Wait..." title="Loading Wait..."></div>
<html:form action="eeDSRegForm.do&mode=eepao" method="post">
<html:hidden property="certificate"></html:hidden>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="EE DS Registration Form" />
	<jsp:param name="TWidth" value="825" />
	
</jsp:include>


<table bgcolor="ffffe0" bordercolor= "#8A9FCD"  rules="none" width="870" border=1 style="border-collapse:collapse;" >


  <tr><td>
	<fieldset>
		<legend><b>EE Details</b></legend>	
			<table  border=0 style="border-collapse:collapse;" >
<tr>
<td class="rptHeading">Circle Office</td><td> <html:text property="circleOffice"  readonly="true" ></html:text></td>
<td class="rptHeading">Division Office  </td><td> <html:text property="divisionOffice" readonly="true"></html:text></td>
</tr>
<tr>
<td class="rptHeading">EE Name </td><td> <html:text property="eeName"  readonly="true"/> </td>
<td class="rptHeading">Employee Code </td><td><html:text property="paoCode"  readonly="true"/> </td>
</tr>

</table>
	</fieldset>
</td>
</tr>

<tr align="center">
<td>
<logic:equal value="No" property="isRegistered"  name="dscRegToken">
<html:button property="mode" title="Sign & Verify " styleClass="btext" value="Sign & Verify" onclick="getTokenCertValue()"></html:button>
</logic:equal>
<logic:equal value="yes" property="isRegistered"  name="dscRegToken">
<html:button property="mode" title="Sign & Verify "  disabled="true" styleClass="btext" value="Sign & Verify" onclick="getTokenCertValue()"></html:button>
</logic:equal>
</td>

</tr>

<tr>
<td>
<fieldset>
   	<legend  ><B>Digital Signing Details</B></legend>
	<table  border=0 style="border-collapse:collapse;">
			<tr>			
    <td class="rptHeading">Issuer</td><td> <html:textarea  property="issuer"  rows="4" cols="40" readonly="true" /> </td>
    <td class="rptHeading">Token&nbsp;Holder </td><td><html:textarea  property="issuerName"  rows="4" cols="40"   readonly="true" /> </td>
    </tr>
    <tr>
    <td class="rptHeading">Valid From </td><td> <html:text property="validFrom"  readonly="true" /></td>
    <td class="rptHeading">Valid To  </td><td> <html:text property="validTo" readonly="true"/></td>
			</tr>			
		</table>
	</fieldset>
</td>
</tr>
<tr align="center">
<td>

<logic:equal value="No" property="isRegistered"  name="dscRegToken">
<html:button property="mode" title="Submit" styleClass="btext" value="Submit" onclick="dscSaveToken()"></html:button>
</logic:equal>
</td>

</tr>
 </table>



<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="825" />
</jsp:include>

</html:form>

<div >
<APPLET  code="nic.rws.verify.SmartCardReaderApplet.class"  NAME="SmartCardReaderApplet" archive="applet/SmartCardReaderApplet.jar" width=500 height=500 MAYSCRIPT>  
  </APPLET>  
  </div>
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

