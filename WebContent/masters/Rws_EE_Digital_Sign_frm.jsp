<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_ee_header1.jsp"%>
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">


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
</head>
<script type="text/javascript">
	function dscSaveToken()
		{
		if(confirm("Please check the eToken Details.!")){
		document.forms[0].action="switch.do?prefix=/masters&page=/eeDigitalSign.do&mode=saveCert";
		document.forms[0].submit();
		}else{
			
		}
	}
</script>
<script type="text/javascript">
function getTokenCertValue()
{
	var name=document.forms[0].elements["eename"].value;
	var id=document.forms[0].elements["eeid"].value;

	if(name!=null && name==''){
	
		alert("Please Enter Employee  Name.");
		document.forms[0].elements["eename"].focus();
	}
	if(id!=null && id==''){
		
		alert("Please Enter Employee Code.");
		document.forms[0].elements["eeid"].focus();
	}

	document.getElementById('content').style.display='block';
	
		var signdatabase64 = document.SmartCardReaderApplet.readCertificate();
		if(signdatabase64.length>100){
			//alert("hi");
		document.forms[0].certificate.value=signdatabase64;
		document.getElementById('content').style.display='none';
			document.forms[0].action="switch.do?prefix=/masters&page=/eeDigitalSign.do&mode=processCertificate";
		document.forms[0].submit();
		}else{
			document.getElementById('content').style.display='none';
			alert("Token Not Inserted or Reading Failed");
		}
}
</script>

<br></br><br></br><br></br><br></br>
<body bgcolor="#edf2f8">
<div id="content" style="display:none" ><img src=<rws:context page='/images/processing.gif'/> alt="Loading Wait..." title="Loading Wait..."></div>
<html:form action="eeDigitalSign.do&mode=certpage" method="post">
<html:hidden property="certificate"></html:hidden>
<table align="center">	
				<tr>
					<td align="right" class="bwborder">
						<a href="home.jsp">My Home</a>
					</td>
				</tr>
</table>

<center>
<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
	<jsp:param name="TableName" value="Digital Signature Registration" />
	<jsp:param name="TWidth" value="825" />
	
</jsp:include>

<table bgcolor="ffffe0" bordercolor= "#8A9FCD"  rules="none" width="870" border=1 style="border-collapse:collapse;" >
  <tr><td>
	<fieldset>
		<legend><b>Office Details</b></legend>	
			<table  border=0 style="border-collapse:collapse;" >

<tr>
<td class="rptHeading">Employee Name </td><td> <html:text property="eename"/> </td>
<td class="rptHeading">Employee Code </td><td><html:text property="eeid" /> </td>
</tr>
<tr>
<td class="rptHeading">EE Designation</td><td><input name="designation" value="EE-Budget" readonly="readonly" /> </td>
</tr>
</table>
	</fieldset>
</td>
</tr>

<tr align="center">
<td>

<html:button property="mode" title="Reading Digital Signature Token Details" styleClass="btext" value="Read Token" onclick="getTokenCertValue()"></html:button>

</td>

</tr>

<tr>
<td>
<fieldset>
   	<legend  ><B>Token Details</B></legend>
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
</center>
</html:form>

<div style="display:block">
<APPLET  code="nic.rws.verify.SmartCardReaderApplet.class"  NAME="SmartCardReaderApplet" archive="<rws:context page='/applet/SmartCardReaderApplet.jar'/>" width=500 height=500 MAYSCRIPT>  
  </APPLET>  
  </div>

  
<p align=center class="pageFooter" >
<%@ include file="/commons/rws_footer.jsp"%>
</p>
<%@ include file="/commons/rws_alert.jsp"%>
</body>

</html>


