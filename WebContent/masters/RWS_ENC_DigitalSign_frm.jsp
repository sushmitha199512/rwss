<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


<title>ENC DSC Registration</title>
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

		var encname=document.forms[0].elements['encName'].value;
		var empCode=document.forms[0].elements['eeid'].value;
		var issuer=document.forms[0].elements['issuer'].value;
		if(encname=="" && empCode==""){
			alert("Please Enter Enc Name And Employee Code");
			return;
		}else if(encname==""){
			alert("Please Enter Enc Name.");
			return;
		}else if(empCode==""){
			alert("Please Enter Employee Code.");
			return;
		
		}else if(issuer=""){
			alert("Please Sign & Verify First.");
			return;
		
		}
		if(confirm("Please check the eToken Details.!")){
		document.forms[0].action="switch.do?prefix=/masters&page=/encDSRegToken.do&mode=saveCert";
		document.forms[0].submit();
		}else{
			
		}
	}
</script>
<script type="text/javascript">
function getTokenCertValue()
{

	document.getElementById('content').style.display='block';
		
		var signdatabase64 = document.SmartCardReaderApplet.readCertificate();
		if(signdatabase64.length>100){
		document.forms[0].certificate.value=signdatabase64;
		document.getElementById('content').style.display='none';
			document.forms[0].action="switch.do?prefix=/masters&page=/encDSRegToken.do&mode=processCertificate";
		document.forms[0].submit();
		}else{
			document.getElementById('content').style.display='none';
			alert("Token Not Inserted or Reading Failed");
		}
}
</script>


<body bgcolor="#edf2f8">
<div id="content" style="display:none" ><img src="images/processing.gif" alt="Loading Wait..." title="Loading Wait..."></div>
<html:form action="encDSRegToken.do&mode=data" method="post">
<html:hidden property="certificate"></html:hidden>
<table border = 0 align = "right">	
		<caption>
			<a href="<rws:context page='/home.jsp'/>">Home</a>
			
		</caption>
</table>
<br></br><br></br>
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Digital Signature Registration" />
	<jsp:param name="TWidth" value="825" />
	
</jsp:include>


<table bgcolor="ffffe0" bordercolor= "#8A9FCD"  rules="none" width="870" border=1 style="border-collapse:collapse;" >
  <tr><td>
	<fieldset>
		<legend><b>ENC Head Office Details</b></legend>	
			<table  border=0 style="border-collapse:collapse;" >

<tr>
<td class="rptHeading">Employee Name </td><td> <html:text property="encName"/> </td>
<td class="rptHeading">Employee Code </td><td><html:text property="eeid" /> </td>
</tr>
<tr>
<td class="rptHeading">EE Designation</td><td><input name="designation" value="ENC" readonly="readonly" /> </td>
</tr>
</table>
	</fieldset>
</td>
</tr>

<tr align="center">
<td>

<html:button property="mode" title="Reading the Digital Signature Details" styleClass="btext" value="Read Token" onclick="getTokenCertValue()"></html:button>

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

<html:button property="mode" title="Submit" styleClass="btext" value="Submit" onclick="dscSaveToken()"></html:button>

</td>
</tr>
 </table>



<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="825" />
</jsp:include>
<%@ include file="/commons/rws_footer.jsp"%>
</html:form>

<div >
<APPLET  code="nic.rws.verify.SmartCardReaderApplet.class"  NAME="SmartCardReaderApplet" archive="<rws:context page='/applet/SmartCardReaderApplet.jar'/>" width=500 height=500 MAYSCRIPT>  
  </APPLET>  
  </div>  

<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>


